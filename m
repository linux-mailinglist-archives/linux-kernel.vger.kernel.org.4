Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5697F6EAFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjDUQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjDUQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D015A2E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A68C61088
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD95C433D2;
        Fri, 21 Apr 2023 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682096143;
        bh=Jukf/1aFVaKR4MjeD0Fkl5f1lVGhtXOtkmQgbfHUkXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xkf1fvfY47b1uM8DssbESzfmhtoCoQ9bCs8ut4cK29N+RSG7ve+XeT5t/BpzI/3oX
         9JlJ5x3iys0EjH1Q1mFmAxzOR2hIZltTb6H4AClq2wa4eZW7bSrMT81duDW39llVlR
         nJt+9OJBCVz5SIC9LVrdCqIRV24BJx4sMepEjpqe2oTUwPH9SPfjJjEj5zv2nXYTHS
         QcZLqRoFnWrIPHJbCCKjJh5ZYHSp3YREQVnbnwDbNRGykD9QVONMFbGrDtN71ME6aL
         XGyjfYyYMWbILjd+sJHQC63BGm/Y0XUp/LRRaBmbHX5rGPQ7Lt6ojhdHeyu7wSJjqV
         JwXzfBBK9GCPg==
Date:   Fri, 21 Apr 2023 18:55:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZELADFhjWR2Swn3l@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leil2r7v.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:24:36PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 21 2023 at 14:36, Frederic Weisbecker wrote:
> The check for TIF_NEED_RESCHED as loop termination condition is simply
> wrong. The architecture is not to supposed to loop in arch_cpu_idle().
> 
> That loop is from Linux 0.9 days. Seems MIPS::__r4k_wait() and
> loongarch, which copied that muck are still stuck in the 1990'ies.
> 
> It has to return when an interrupt brings it out of the "idle wait"
> instruction.
> 
> The special case are mwait() alike mechanisms which also return when a
> monitored cacheline is written to. x86 uses that to spare the reseched
> IPI as MWAIT will return when TIF_NEED_RESCHED is set by a remote CPU.

Right.

> 
> > More generally IRQs must _not_ be re-enabled between cpuidle_select()
> > (or just tick_nohz_idle_stop_tick() if no cpuidle support) and the
> > last halting ASM instruction. If that happens there must be
> > a mechanism to cope with that and make sure we return to the main
> > idle loop.
> 
> No. arch_cpu_idle() can safely reenable interrupts when the "wait"
> instruction requires that. It has then to disable interrupts before
> returning.
> 
> x86 default_idle() does: STI; HLT; CLI; That's perfectly fine because
> the effect of STI is delayed to the HLT instruction boundary.

Right, I implicitly included sti;mwait and sti;hlt
The point is that if interrupts are enabled too early before the
idling instruction then we are screwed.

> 
> > Another way to cope with this would be to have:
> >
> > #define TIF_IDLE_TIMER	 ...
> > #define TIF_IDLE_EXIT	 (TIF_NEED_RESCHED | TIF_IDLE_TIMER)
> 
> There is absolutely no need for this. arch_cpu_idle() has to return
> after an interrupt, period. If MIPS/loongarch cannot do that then they
> can have their private interrupt counter in that magic rollback ASM to
> check for. But we really don't need a TIF flag which makes the (hr)timer
> enqueue path more complex.

Then I'm relieved :)  (well sort-of, given the risk for an accident somewhere
on an arch or a cpuidle driver I may have overlooked).

> 
> > I'm trying to find an automated way to debug this kind of issue but
> > it's not easy...
> 
> It's far from trivial because you'd need correlation between the
> interrupt entry and the enter to and return from arch_cpu_idle().
> 
> I fear manual inspection is the main tool here :(

I thought so :)

I'm already halfway through the architectures, then will come the cpuidle drivers...

Thanks.
