Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03A737C36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjFUHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:32:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7E9D;
        Wed, 21 Jun 2023 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r2sGgtI29SDh+dbp1qIh4vLtrr1O+aNDcgCSsrOh00Y=; b=qQTixkvsG+cgjcsVZWqLwaJQIJ
        MX2XHOqgPV2E0smtYODkB/myJ1SEZ1ATOciOJZEnRyr4TFTCfYAO+HB6WO6sW8vhs+DfJEJH8ice1
        myt4EUao0Ymw3Lpd265XZx+KOhA8dnmzaZP4QfIyaI29b6K3OEgasUWfeyh24LKOovjpQxuXcd+n+
        mpn1sLjh1ISR/3bPC9bBzec8AFVMa21nXfTZU8esC0llFxAUc18FEZMBtLRJI203QMi/JiLnqleN4
        4sTa7Go1hh512StGOo9vTATt9KB67iCpfIzAT9dm5Z+fA1F4KP0ncxTgmT1WgQo0KbijVYYIlEGYB
        MEl16eTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBsK5-00HIIr-1C;
        Wed, 21 Jun 2023 07:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35C2A300222;
        Wed, 21 Jun 2023 09:32:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 246282419FDEF; Wed, 21 Jun 2023 09:32:12 +0200 (CEST)
Date:   Wed, 21 Jun 2023 09:32:12 +0200
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
Subject: Re: [PATCH v2 5/5] x86/idle: Disable IBRS entering mwait idle and
 enable it on wakeup
Message-ID: <20230621073212.GC2046280@hirez.programming.kicks-ass.net>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140625.1001886-6-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:06:25AM -0400, Waiman Long wrote:
> When a user sets "intel_idle.max_cstate=0", it will disable
> intel_idle and fall back to acpi_idle instead. The acpi_idle code
> will then call mwait_idle_with_hints() to enter idle state. So when
> X86_FEATURE_KERNEL_IBRS is enabled, it is necessary to disable IBRS
> within mwait_idle_with_hints() when IRQ was disabled to avoid performance
> degradation on silbing thread running user workload.

Urgh, no, just no. This is nasty.
