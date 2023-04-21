Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A856EADF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjDUPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDUPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:24:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F700E57
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:24:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682090676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0uYo60hmEZ1HDe1S2XFY3knBj4NHLSTKoAvh/2m+TU=;
        b=LU7SdfThp5o73XhxuC2vxT/jUTlPZvXSPWZOtL4P5ZrgDukzuztGx+Pm441/HRm5AlDfY3
        ZqYNHJknu94ZcG51n5vbGI/HWOdfWIEz3IntNxFccXW9v1MfJqPe4xTBLfb7ukd5scq2Vz
        M+Q9PPB8rvyTFz8fot/6P1xUrmNIk1CaRHD2LPZMU+fYjCdkLyhT/mmUbCE+WwWxi48NBy
        1+bKAKuCu1P1UxGTOF3DE6YKAE0jLyBczDkC1oF6Cm9rDpDzdol1Un3DL6U3HGLKYaSKz7
        saqvfVhzRHepCOKqeEt0iUxUgmqzfzBapVnm0ie44rxSBVW7M26vlyVeibi70g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682090676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0uYo60hmEZ1HDe1S2XFY3knBj4NHLSTKoAvh/2m+TU=;
        b=Cy9Dm9kzKSndmG0OEZ89k0Gqtzy+7DvbpJQfR/LZhYBNtr8ywLLqlxwqhbMVpBiKBCxjwD
        Q2oxTo7Ldxw3XIAQ==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
In-Reply-To: <ZEKDZEQmKExv0O7Q@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
Date:   Fri, 21 Apr 2023 17:24:36 +0200
Message-ID: <87leil2r7v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2023 at 14:36, Frederic Weisbecker wrote:
> I'm looking at the __arch_cpu_idle() implementation in Loongarch
> and I'm wondering about the rollback code. I don't understand well
> that code but with the help from PeterZ I might have seen something,
> so tell me if I'm wrong: when an interrupt happens within
> __arch_cpu_idle(), handle_vint() rolls back the return value to the
> beginning of __arch_cpu_idle(), so that TIF_NEED_RESCHED is checked
> again. Is that correct?
>
> Because if an interrupt fires while in __arch_cpu_idle(), that IRQ
> might enqueue a new timer and that new timer needs to be reprogrammed
> from the main idle loop and just checking TIF_NEED_RESCHED doesn't
> tell about that information.

The check for TIF_NEED_RESCHED as loop termination condition is simply
wrong. The architecture is not to supposed to loop in arch_cpu_idle().

That loop is from Linux 0.9 days. Seems MIPS::__r4k_wait() and
loongarch, which copied that muck are still stuck in the 1990'ies.

It has to return when an interrupt brings it out of the "idle wait"
instruction.

The special case are mwait() alike mechanisms which also return when a
monitored cacheline is written to. x86 uses that to spare the reseched
IPI as MWAIT will return when TIF_NEED_RESCHED is set by a remote CPU.

> More generally IRQs must _not_ be re-enabled between cpuidle_select()
> (or just tick_nohz_idle_stop_tick() if no cpuidle support) and the
> last halting ASM instruction. If that happens there must be
> a mechanism to cope with that and make sure we return to the main
> idle loop.

No. arch_cpu_idle() can safely reenable interrupts when the "wait"
instruction requires that. It has then to disable interrupts before
returning.

x86 default_idle() does: STI; HLT; CLI; That's perfectly fine because
the effect of STI is delayed to the HLT instruction boundary.

> Another way to cope with this would be to have:
>
> #define TIF_IDLE_TIMER	 ...
> #define TIF_IDLE_EXIT	 (TIF_NEED_RESCHED | TIF_IDLE_TIMER)

There is absolutely no need for this. arch_cpu_idle() has to return
after an interrupt, period. If MIPS/loongarch cannot do that then they
can have their private interrupt counter in that magic rollback ASM to
check for. But we really don't need a TIF flag which makes the (hr)timer
enqueue path more complex.

> I'm trying to find an automated way to debug this kind of issue but
> it's not easy...

It's far from trivial because you'd need correlation between the
interrupt entry and the enter to and return from arch_cpu_idle().

I fear manual inspection is the main tool here :(

Thanks,

        tglx
