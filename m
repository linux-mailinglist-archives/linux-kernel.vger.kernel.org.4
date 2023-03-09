Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21426B24DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCINEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjCINDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:03:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133E8EA2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:03:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1168349wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112; t=1678367027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wUL7zyrq+hkUe0QyztCHqciprnPN2J77YqA2w+p6uw=;
        b=SVwzmJN/HHrLPQ5EBN3SoLeijhNj2FJD6moz68UaWxYmOp37tbhzRrmSmoEIvu6K7f
         n++iGDGGYxy2M9e1ah6C7t446yugoMwj6k28LQeLCLYPPvTSmSYPTOEKpqSFhvM7gkSd
         ypkXd8BgOjabM0PNzX7u6Sh+JLz4cf2Fr56BtqIwrS/akeQdEqskl7vJcOAe2ECEziax
         rysEsTUxJiHgpHwGgLz3JmFaEQKjgrMxDspkMdSgurGZT9k0he7Pml9xrmnyS19FNiqT
         x4+Ehg/XQ2nVl2fgcfA8FDAPDxKcjggyFeNSJGr1PDWZ82bfGF6tnpH0vjixjJeVZZA2
         jO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678367027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wUL7zyrq+hkUe0QyztCHqciprnPN2J77YqA2w+p6uw=;
        b=PwqAQgK4B2DixScaB5lkYpGd72vTg5wXifX7a8fjp635q9XDd29bvJoYpWi1EwzHpB
         YqGUS6MUf8FPUfYdBJ8ASONurxzLq00YEFI+wtdZsc9mqcki6QEe1bhpJwzx6x2XLo5I
         5E6iloW1ow2rfgCuOeIvr17Nl+qQyxWBVr7Ud0VvU9zFEAH5n1/Vv7o5Mh3uRC/Kng88
         qU2MvapWZ6J0ZK4Z94Cd5U3Yk43NKDkHgrG7YOzBWwOoetHYCamxamaFKlOceoq9RDx7
         oyZWSAFdetkjH8L315QkucZJXANIxLZ5hqPwq6Kl0pJsaXnML31MiFIXPoqPusVrHvk/
         vQUA==
X-Gm-Message-State: AO0yUKVsrq12VWlq3PGIdkZlz8SEnxlBlXhvwnoIwbDHoigP+Pw8kAgT
        2qejWJKBbSUO4OFnXaqYrwf/2A==
X-Google-Smtp-Source: AK7set/T2Nl5NfjwhETcH5hvgrJSxiO8/bHnDp8+rxXHJ2aliq5GkpZ/pl5bn24aX3exP9DDD+SrXA==
X-Received: by 2002:a05:600c:524d:b0:3eb:38a2:2bbc with SMTP id fc13-20020a05600c524d00b003eb38a22bbcmr18974852wmb.7.1678367027624;
        Thu, 09 Mar 2023 05:03:47 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d58e2000000b002c56af32e8csm17968839wrd.35.2023.03.09.05.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:03:47 -0800 (PST)
Date:   Thu, 9 Mar 2023 14:03:38 +0100
From:   Petr Malat <oss@malat.biz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        tglx@linutronix.de, nsaenzju@redhat.com, frederic@kernel.org
Subject: Re: [PATCH] softirq: Do not loop if running under a real-time task
Message-ID: <ZAnZKoH38Telq1qG@ntb.petris.klfree.czf>
References: <20230306154548.655799-1-oss@malat.biz>
 <20230308091458.Q42uCjR2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308091458.Q42uCjR2@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:14:58AM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-03-06 16:45:48 [+0100], Petr Malat wrote:
> > Softirq processing can be a source of a scheduling jitter if it executes
> > in a real-time task as in that case need_resched() is false unless there
> > is another runnable task with a higher priority. This is especially bad
> > if the softirq processing runs in a migration thread, which has priority
> > 99 and usually runs for a short time.
> > 
> > One option would be to not restart the softirq processing if there is
> > another runnable task to allow the high prio task to finish and yield the
> > CPU, the second one is to not restart if softirq executes in a real-time
> > task. Usually, real-time tasks don't want to be interrupted, so implement
> > the second option.
> 
> This affects only PEEMPT_RT, right?
I have observed the issue on 5.15 CONFIG_PREEMPT=y arm32 kernel.

> I have plans to redo parts of it. You shouldn't enter ksoftirqd to be
> begin with. There is this ktimerd in v6.1 which mitigates this to some
> point and I plan to extend it to also cover the sched-softirq.
> Other than that, you are right in saying that the softirq must not
> continue with a RT prio and that need_resched() is not visible here.
> However ksoftirqd itself must be able to do loops unless the
> need-resched flag is seen.
> 
> Since you mentioned migration thread, how ofter to you see this or how
> does this trigger?
I have seen only one occurrence, where I have a back trace available
(from hundreds systems). I think that's because on my system it may occur
only if it hits the migration thread, otherwise there are more runable
threads of the same priority and need_resched() breaks the loop.

I obtained the stack trace by making a debugging module which uses a
periodic timer to monitor active tasks and it dumps stack when it finds
something fishy. This is what I got:
 [<bf84f559>] (hogger_handler [hogger]) from [<c04850ef>] (__hrtimer_run_queues+0x13f/0x2f4)
 [<c04850ef>] (__hrtimer_run_queues) from [<c04858a5>] (hrtimer_interrupt+0xc9/0x1c4)
 [<c04858a5>] (hrtimer_interrupt) from [<c0810533>] (arch_timer_handler_phys+0x27/0x2c)
 [<c0810533>] (arch_timer_handler_phys) from [<c046de3b>] (handle_percpu_devid_irq+0x5b/0x1e4)
 [<c046de3b>] (handle_percpu_devid_irq) from [<c0469a27>] (__handle_domain_irq+0x53/0x94)
 [<c0469a27>] (__handle_domain_irq) from [<c041e501>] (axxia_gic_handle_irq+0x16d/0x1bc)
 [<c041e501>] (axxia_gic_handle_irq) from [<c0400ad3>] (__irq_svc+0x53/0x94)
 Exception stack(0xc1595ca8 to 0xc1595cf0)
 [<c0400ad3>] (__irq_svc) from [<c098e404>] (_raw_spin_unlock_irqrestore+0x1c/0x3c)
 [<c098e404>] (_raw_spin_unlock_irqrestore) from [<c0446b6d>] (try_to_wake_up+0x1d9/0x5d0)
 [<c0446b6d>] (try_to_wake_up) from [<c0483d2d>] (call_timer_fn+0x31/0x16c)
 [<c0483d2d>] (call_timer_fn) from [<c048406f>] (run_timer_softirq+0x207/0x2d4)
 [<c048406f>] (run_timer_softirq) from [<c0401293>] (__do_softirq+0xd3/0x2f8)
 [<c0401293>] (__do_softirq) from [<c042876b>] (irq_exit+0x57/0x78)
 [<c042876b>] (irq_exit) from [<c0469a2b>] (__handle_domain_irq+0x57/0x94)
 [<c0469a2b>] (__handle_domain_irq) from [<c041e501>] (axxia_gic_handle_irq+0x16d/0x1bc)
 [<c041e501>] (axxia_gic_handle_irq) from [<c0400ad3>] (__irq_svc+0x53/0x94)
 Exception stack(0xc1595e78 to 0xc1595ec0)
 [<c0400ad3>] (__irq_svc) from [<c044d37c>] (active_load_balance_cpu_stop+0x1ec/0x234)
 [<c044d37c>] (active_load_balance_cpu_stop) from [<c04ac099>] (cpu_stopper_thread+0x69/0xd8)
 [<c04ac099>] (cpu_stopper_thread) from [<c0440b53>] (smpboot_thread_fn+0x9f/0x17c)
 [<c0440b53>] (smpboot_thread_fn) from [<c043ccf9>] (kthread+0x129/0x12c)
 [<c043ccf9>] (kthread) from [<c0400131>] (ret_from_fork+0x11/0x20)

I was then looking into the code how it could happen softirqs were not
offloaded to the thread and the only explanation I have is what I described
in the original mail.
BR,
  Petr
