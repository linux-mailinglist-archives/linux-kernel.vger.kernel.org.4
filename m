Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3C738849
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjFUPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjFUPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:00:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8D83C1E;
        Wed, 21 Jun 2023 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CXb4b4l4LNUAf0U2xVpvyG7mv/bi5gwwudAAnpCg7aU=; b=io1na3/e2IqvVZycPhNWy4pDSG
        6NJb+OiHR+kF29S+BufH1WIreBhhmoajbQvl4lTJDeZoN8ubhwkFE9GPXP1RNwQ5CXKWN7PvydEFs
        OTv2cujV6GiVr4dYfR63LjasfalqJFsQfuuWLBfLMwRbqMGMjf2HwjnNgR2qzDnKntYsv4JnlIxEI
        /JIgyDoiXTlxLvX+i+B0gW20SRM7GZzisM1Cxock/Wmz4evuU2mp+8GjG0aCciUN7ZimEjYZke09J
        oG0h9Z5k2EVhoj/bvjQ62TvoctUilwGdrhC2xbMg0u/PsK8KnxpvOEpQaJ8n45U8yIaHWgw+hDAeV
        pZ56Jxrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBzED-00HWvV-2G;
        Wed, 21 Jun 2023 14:54:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FBAE300274;
        Wed, 21 Jun 2023 16:54:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 073182130B3BB; Wed, 21 Jun 2023 16:54:37 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:54:36 +0200
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
Message-ID: <20230621145436.GK2053369@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
 <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
 <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
 <20230621144848.GJ2053369@hirez.programming.kicks-ass.net>
 <309d15f5-0dd8-aee8-14a6-621a071bc363@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309d15f5-0dd8-aee8-14a6-621a071bc363@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:51:33AM -0400, Waiman Long wrote:
> 
> On 6/21/23 10:48, Peter Zijlstra wrote:
> > On Wed, Jun 21, 2023 at 10:44:23AM -0400, Waiman Long wrote:
> > 
> > > Well, hlt_play_dead() is only called if cpuidle_play_dead() returns an error
> > > which is not the typical case. My testing does confirm that this patch is
> > > able to keep the IBRS bit off when a CPU is offline via its online sysfs
> > > file.
> > The point is; your re-enable IBRS hunk at the end is dead-code. It
> > should never ever run and having it is confusing.
> 
> What I meant is that hlt_play_dead() should never be called unless there is
> some serious problem with the system and native_play_dead() does return in
> normal usage.

This is all through arch_cpu_idle_dead() which is __noreturn. And no,
none of this must ever return.

If you want an offline CPU to come back, you re-init.
