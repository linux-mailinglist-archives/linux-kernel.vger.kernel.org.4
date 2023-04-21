Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358666EAF73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjDUQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632308691
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041F063EC7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D044CC433D2;
        Fri, 21 Apr 2023 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682095652;
        bh=P6EDadJ8vbwoQwpgWNF4Rx4sm42pFSBo0z0ia2uhbzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7PyJ9JbaNC6hqGLA15KUxWZRfAQP8qrlVwHO1mLR9HFTozhb26w6w3OVLGANB710
         w3V5T19br0Hfqe6jItiBOpQn8m1yxZ+6lo5Few4fq0bAVMuGkGxp3bAHEaayN5Fvxe
         XCI3tq/2y1C1kTe57EQ4gjVFrRKmfLf3CP9l9VBK4WO6ljOW5hH78FlKDj6CHqIhSW
         639xhLuSesC2clbtMyQULeEHDuG3CKTLuGHpvWbXX5HgteG2/3YFmdhJJ56UDpH8xv
         HT62ydnK01/R6CQSkYxOplHeyxKParMvYYeWVWur2moGC+I3jGR8XRZPMoxBZwW3Dk
         2FcftdkzOcsIg==
Date:   Fri, 21 Apr 2023 18:47:29 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZEK+IeTYsauHLozy@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <20230421142446.GA1185829@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421142446.GA1185829@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:24:46PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 21, 2023 at 02:36:52PM +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > I'm looking at the __arch_cpu_idle() implementation in Loongarch
> > and I'm wondering about the rollback code. I don't understand well
> > that code but with the help from PeterZ I might have seen something,
> > so tell me if I'm wrong: when an interrupt happens within
> > __arch_cpu_idle(), handle_vint() rolls back the return value to the
> > beginning of __arch_cpu_idle(), so that TIF_NEED_RESCHED is checked
> > again. Is that correct?
> 
> Loongson copied this crap from MIPS, so they are direct affected too.

Right.

> 
> > Because if an interrupt fires while in __arch_cpu_idle(), that IRQ
> > might enqueue a new timer and that new timer needs to be reprogrammed
> > from the main idle loop and just checking TIF_NEED_RESCHED doesn't
> > tell about that information.
> 
> Notably; this is only relevant to NOHZ, right?

Indeed.

> > And set that from the timer enqueue in idle time and check TIF_IDLE_EXIT
> > on idle callback. It depends how many architectures are concerned by this.
> > All I know so far is:
> 
> The alternative is changing kernel/entry/common.c:irqentry_exit() to add
> a nohz callback next to ct_irq_exit(), and have that reprogram the timer
> if/when we're in NOHZ mode.

We used to do that but Rafael rewrote the thing a few years ago in order for
the cpuidle governor to know about the next timer event as a heuristic to
predict the best c-state, and actually decide if it's worth stopping the
tick.

So cpuidle_select() eventually calls tick_nohz_get_sleep_length() in the
beginning of the idle loop to know the next timer event (without stopping the
tick yet), on top of that and other informations, tick is stopped or not
(cf: stop_tick argument in cpuidle_select()).

If an IRQ wakes up the CPU and queues a timer, we need to go through that
whole process again, otherwise we shortcut cpuidle C-state update.

> *HOWEVER*
> 
> intel_idle_irq() is affected -- except that we only (normally) use that
> for very shallow idle states and it won't interact with NOHZ (because we
> only disable the tick for deep idle states).

Well I don't know, that doesn't look comfortable... :)

Also why does it need to enable IRQs if ecx=1 ?

> > * Need to check all other archs
> > 
> > I'm trying to find an automated way to debug this kind of issue but it's not
> > easy...
> 
> Yeah, too much arch code :/ Easiest might be to check if our idea of
> where the timer should be and the hardware agree on IRQ entry or so --
> *any* IRQ. That will miss a lot of cases, but at least it's something.

Hmm, not sure I understand what you're suggesting...

Thanks.
