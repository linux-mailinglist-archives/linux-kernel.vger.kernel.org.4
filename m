Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F56C66C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCWLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCWLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381211E85;
        Thu, 23 Mar 2023 04:37:32 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:37:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679571450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B5a/2lJOt4SmIwlSzVt22/TrHyZEzTsE6LNtuklxZac=;
        b=VB48T2/W6zCJWTOhQr9302VTx7tKm1NW+hETq8wWsKBAJfEjxuuJ3hLya2220J4M28Vy3q
        FR2eamZhJYAjRRzkYVyvOWiJw8VEV1oBnm1/uUndtyhcP4UlHP2axYsYBmWXBasdns29/m
        gCNC0CxjCTJK8xoFuo5MtJiX3oGA2cUbCBRLcqrnubORoB3SiZAcnfefq5dbU0m7tevFFU
        Fo4ZYzwSwnRUpT/1x+y9PRkMEK5n+lkSHFrJpUYKpvn4xeMoaEybdtZuoI2WfHotDVDgWX
        /GI1L1RYSI8eOvEphxglVydcHqiA9mL2qLYnb3htEPxkMqI9OmjevKLXBRcp5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679571450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B5a/2lJOt4SmIwlSzVt22/TrHyZEzTsE6LNtuklxZac=;
        b=RY0XQBjoUyG9azt+t3IuhkfhfeGHia1YiXOeydBIc7BP11Nd7215kg0/qyWVUnhp+0CfIm
        Ts1cTb34/dvxqhCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
Message-ID: <20230323113728.Tuuk4-J9@linutronix.de>
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
 <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
 <20230321105734.Z7F3Uvf1@linutronix.de>
 <3e227a63-a45f-8c20-f697-b263121ec173@linaro.org>
 <20230321133922.ontdC41h@linutronix.de>
 <386e5c1b-cf64-8047-97e5-2cbbe3dc415b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <386e5c1b-cf64-8047-97e5-2cbbe3dc415b@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-23 09:16:27 [+0100], Krzysztof Kozlowski wrote:
> > Yeah closer :) The CPU-mask for workqueues can still be different on
> > non-NOHZ-full CPUs. Still you interrupt the CPU doing in-userland work
> > and this is not desired.
> 
> Probably this should be done by workqueue core code.  Individual drivers
> should not need to investigate which CPUs are isolated.

_Either_ this is part of the interrupt service routine or it is not.
Sometimes work can be offloaded.
However this interrupt is short and offloads work to a workqueue.
Can the interrupt be moved to another CPU without breaking something? 
The use can only change the CPUs on which the workqueue can run but also
the affinity of the IRQ itself. If the user wishes to isolate CPU X and
move workqueues and interrupts away from the CPU the question is why is
this a problem for you.

> > You have a threaded-IRQ which does nothing but schedules a worker. Why?
> > Why not sleep and remain in that threaded IRQ until the work is done?
> > You _can_ sleep in the threaded IRQ if you have to. Force-threaded is
> > different but this is one is explicit threaded so you could do it.
> 
> If I get your point correctly, you want the IRQ handler thread to do the
> actual work instead of scheduling work? The answer to this is probably here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0e27c3d4e20dab861566f1c348ae44e4b498630

Let me look.

| Re-enabling an interrupt from its own interrupt handler may cause
| an interrupt storm, if there is a pending interrupt and because its
| handling is disabled due to already done entrance into the handler
| above in the stack.

I have hard time parsing this.
disable_irq_nosync() and enable enable_irq() shouldn't be invoked from
within the interrupt handler itself. This interrupt is already requested
as a threaded handler with IRQF_ONESHOT. This means the IRQ-chip already
disables the interrupt while the threaded handler is invoked. No need
for that.

I don't know what the purpose of reg_intr_clr here is. Acking the
interrupt before reading the status and doing any work does not look
right.

| Also, apparently it is improper to lock a mutex in an interrupt contex.

Again, this is an interrupt handler requested as a threaded handler.
This handler is invoked with enabled interrupts and preemption. The code
in this handler can invoke ssleep() or mutex_lock(). A might_sleep()
does not produce a plat here. It okay to acquire a mutex. This is why we
have threaded interrupts.

You can't acquire a mutex in a forced-threaded handler. This is not the
case here.

> > 	
> >>> However the thermal notifications have nothing to do with cpufreq.
> >>
> >> They have. The FW notifies that thermal mitigation is happening and
> >> maximum allowed frequency is now XYZ. The cpufreq receives this and sets
> >> maximum allowed scaling frequency for governor.
> > 
> > I see. So the driver is doing something in worst case. This interrupt,
> > you have per-CPU and you need to do this CPU? I mean could you change
> > the affinity of the interrupt to another CPU?
> 
> I don't know. The commit introducing it:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ed6dfbd3bb987b3d2de86304ae45972ebff5870
> claimed it helps to reduce number of interrupts hitting CPU 10x-100x
> times... I don't see it - neither in tests nor in the code, so I am just
> thinking to revert that one.

So it may run on another CPU but doing it on the right cluster reduces
the received interrupt 10-100 times. Do we have per-cluster register or
is the interrupt ACK wrong and this what is observed?

The questions are:
- What is the interrupt signaling.
- What must be done to acknowledge the interrupt.

This needs to be figured out and verified that it actually works as
intended. The hardware might keep sending interrupt because the source
is either not acknowledge properly or the source of the interrupt (the
reason why it was generated in first place) is still pending/ not
handled. The changes you reference look like "if we do this then it
seems better.". No explanation about the issue/ root cause and the
targeted solution.

> Best regards,
> Krzysztof

Sebastian
