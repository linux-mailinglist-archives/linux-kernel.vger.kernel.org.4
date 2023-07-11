Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7C74F38D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGKPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjGKPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:32:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED311709
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyhSPjFr2+/YCa+XkML0MylJ6XHvXgKAc/2kn7i0jmw=; b=s5yqW9+A5vr+jBu4NXIxS6+jVR
        DovdoA3HsICh5sVYvTiIMpFwGB3frbxxZBWiwUIufPi4revHlrgVP5uWUpJ2KdWY8Z2QIdkS1kw59
        WetE8Fc5zZN2ttmF95uZYs2ht8rEkSo9WHjt0/g/Cvgp2fqioad/DUSPAFXTHGedSpnslTgpd5nu6
        oPx++TJyFtz+YYtCP70oAv+PQl+EeVy8ovlUt015rSgQHLu3OxQrrh3NtCZ8PfD7L2uktM5QCKAyc
        KCKx4EZjFQeD6K5AkYG6YGLlW9K4iDvx20P5htTip/v5zYznCG38qwXDGLQrc1XfItnISX7jlc8cn
        LUXbhz5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJFLw-00FqIN-3D; Tue, 11 Jul 2023 15:32:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF01530057E;
        Tue, 11 Jul 2023 17:32:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D53852439FF31; Tue, 11 Jul 2023 17:32:34 +0200 (CEST)
Date:   Tue, 11 Jul 2023 17:32:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>, rafael.j.wysocki@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230711153234.GO3062772@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <d32d5e3c-2cd9-3339-d6eb-59ce7c3ec55f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32d5e3c-2cd9-3339-d6eb-59ce7c3ec55f@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:26:26AM -0700, Arjan van de Ven wrote:
> > 
> > Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
> > commit babbles something about waking CPUs from idle to do TLB
> > invalidate, but that shouldn't be the case, that's what we have
> > kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
> > vcpu-enter.
> > 
> > Arjan, what is the actual problem you're trying to solve any why hide
> > this in intel_idle ?
> 
> I'm trying to solve to get guests on par with bare metal in terms of all
> the idle capabilities -- including TLB flushing before going idle, but
> also all the other latency control mechanisms that cpuidle brings.

I'm probably stupid, but the TLB thing doesn't make sense to me. What
TLB invalidations are you having problems with?

Also, you patches come with 0% performance data.

> And yes this is in intel_idle for 2 reasons
> 1) we use the host latencies for the deeper C state and that needs intel idle information

How are guest idle and host idle related in any way? Guest might think
it will go idle for a long time, but the host will happily run another
vCPU.

This doesn't add up.

> 2) we are about to add umwait support to this as well (patches on the mailing list for
> the base infrastructure for this)

The only way umwait makes sense for a guest is to amortize the VMEXIT
cost, and in that respect it seems a perfect fit for that haltpoll
thing. 
