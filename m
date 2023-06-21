Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A17387F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjFUOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjFUOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D130C2;
        Wed, 21 Jun 2023 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=51ntrqOP9xV53ppe6taX/fDHYlbjYhGaWS2ewMSMacQ=; b=BJNPNa7gq53+sDGdf9CBaxeqW2
        sFtrhWqemannmeSs0jXnJxe8a/NZXrFhGAs+SrFNp2RxsHFu5tV1crB3I5wMeXHbFn8q1D18GwO3/
        0aRftsytEAsInFZj5FRkcjZ/dVh/Gdr7tPEnPW9lhYnqq2inRlZhYIkxP+55evS3ULc1KivsdoeXS
        wYzgZ6TL7LaKQTnyUiweuvfPlCp3EVgb46ibgGqVYeUHjD+wxzVuBWqxtW5wU7SJl+KkkAAVQ2i/K
        +i3OrYltkoch5oWcy9Fqd28jaG+bNexwCP5l1CQWXxbZ720NxFEF9WcnDtsCog9mcCpPxttDagMEA
        9w7RL8HA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBz8c-00HWjr-0F;
        Wed, 21 Jun 2023 14:48:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB4AF300274;
        Wed, 21 Jun 2023 16:48:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2E742130B3BD; Wed, 21 Jun 2023 16:48:48 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:48:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Message-ID: <20230621144848.GJ2053369@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
 <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
 <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:44:23AM -0400, Waiman Long wrote:

> Well, hlt_play_dead() is only called if cpuidle_play_dead() returns an error
> which is not the typical case. My testing does confirm that this patch is
> able to keep the IBRS bit off when a CPU is offline via its online sysfs
> file.

The point is; your re-enable IBRS hunk at the end is dead-code. It
should never ever run and having it is confusing.

