Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7366C3314
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCUNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjCUNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:39:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB511A7;
        Tue, 21 Mar 2023 06:39:26 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:39:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679405963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uW5fpG7UdO7junfYXzpr1VASUwkYgjePEMEZI0s2uKU=;
        b=nAS1PiYdPQp25hSPtZD9qb4LVvIfl5+Iq5YN9Mxy/T1EHmDnbg8pR/VShA4l3+N1ogc6aW
        VwtM2UDEZYA6VEkgWdZEDkmtWRDDukXVPXLHXTbLyH6ZbjoAJ9Cfs5RNZleYiuxWbLLgIz
        1sA8e5lPAUKvng31ckchCFGaRylR3MWgiUqvqFPZFhGgEtSm+7G2BcaFlLjBdm8CtUZKbR
        3qpTBNFWDOtkTbPA45Uc3zYiQeeDTJQCf42V2Lq7jvmRwTnHCalrc8CIeNA59l2+sM/kZT
        lmWt30xKc70YatBYQPgSqUoUNbdlTLtiQnQbj5RrCjiGXUR/tmB3GkxlH4nR2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679405963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uW5fpG7UdO7junfYXzpr1VASUwkYgjePEMEZI0s2uKU=;
        b=MuC8fJg05kjTXLdb4HxI+i197gCnckEYTxojaKeYuFelpshq39C3x6bX0kq2UQSeu12Sg0
        dPtD75Vt7oRPDUAA==
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
Message-ID: <20230321133922.ontdC41h@linutronix.de>
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
 <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
 <20230321105734.Z7F3Uvf1@linutronix.de>
 <3e227a63-a45f-8c20-f697-b263121ec173@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e227a63-a45f-8c20-f697-b263121ec173@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21 12:27:42 [+0100], Krzysztof Kozlowski wrote:
> > I still fail to understand why this is PREEMPT_RT specific and not a
> > problem in general when it comes not NO_HZ_FULL and/ or CPU isolation.
> 
> Hm, good point, I actually don't know what is the workqueue
> recommendation for NO_HZ_FULL CPUs - is still locality of the workqueue
> preferred?

If you isolate a CPU you want the kernel to stay away from it. The idea
is that something is done on that CPU and the kernel should leave it
alone. That is why the HZ tick avoided. That is why timers migrate to
the "housekeeping" CPU and do not fire on the CPU that it was programmed
on (unless the timer has to fire on this CPU).

> And how such code would look like?
> if (tick_nohz_tick_stopped())?

Yeah closer :) The CPU-mask for workqueues can still be different on
non-NOHZ-full CPUs. Still you interrupt the CPU doing in-userland work
and this is not desired.

You have a threaded-IRQ which does nothing but schedules a worker. Why?
Why not sleep and remain in that threaded IRQ until the work is done?
You _can_ sleep in the threaded IRQ if you have to. Force-threaded is
different but this is one is explicit threaded so you could do it.
	
> > However the thermal notifications have nothing to do with cpufreq.
> 
> They have. The FW notifies that thermal mitigation is happening and
> maximum allowed frequency is now XYZ. The cpufreq receives this and sets
> maximum allowed scaling frequency for governor.

I see. So the driver is doing something in worst case. This interrupt,
you have per-CPU and you need to do this CPU? I mean could you change
the affinity of the interrupt to another CPU?

> Best regards,
> Krzysztof

Sebastian
