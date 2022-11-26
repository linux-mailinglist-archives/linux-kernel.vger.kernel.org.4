Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94C639754
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKZRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKZRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:05:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029417A81
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:05:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669482305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5Ts30MespxUKzsUT1l7gvsIpD/wCNbmSDwi0rq7pWo=;
        b=a1vG6WIHLX8A8l4bbess8p3ebtC0MNf7n88bWD/3PqTxJ1uhpyZ9s4hHJK5DzlNe5lhmJq
        DaD7vanZVw80QrUdkx4pDbIeUFASYcJ0R8qUmJKJKu5LlvELuECNSOvYLnguyeU/rNhBr9
        jBdZbt1LJfYwVinnQYZHUTrz9PU0VAWM7s21Ns7DrDdaYEr14ZjT3l+3b8CsXbWhoJOxeF
        3fDxV9pGenyolZ3GybsEdHv4BUst2bFjEGi5oGzmFOgveySWzE3JrjCSOORfUHqxnkBrc0
        LDumya6APS4Pev3plwpVgtQ3GfSLVFWVVa1d8+r+nE3Wp/I+lxxKTgnQxz4nJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669482305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w5Ts30MespxUKzsUT1l7gvsIpD/wCNbmSDwi0rq7pWo=;
        b=dam0KkoHF7cMdxbvjVFLp64t7BNxpbeugIF7gW3X6Ip03wY3HHGZ0SDANtDVhfQCIenvje
        LRzxWKBGTevPKMCw==
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>, fweisbec@gmail.com,
        mingo@kernel.org, dave@stgolabs.net, paulmck@kernel.org,
        josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
In-Reply-To: <20221121035140.118651-1-zhouzhouyi@gmail.com>
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
Date:   Sat, 26 Nov 2022 18:05:05 +0100
Message-ID: <87y1rxwsse.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21 2022 at 11:51, Zhouyi Zhou wrote:
> During CPU-hotplug torture (CONFIG_NO_HZ_FULL=y), if we try to
> offline tick_do_timer_cpu, the operation will fail because in
> function tick_nohz_cpu_down:
> ```
> if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
>       return -EBUSY;
> ```
> Above bug was first discovered in torture tests performed in PPC VM

How is this a bug?

> of Open Source Lab of Oregon State University, and reproducable in RISC-V
> and X86-64 (with additional kernel commandline cpu0_hotplug).
>
> In this patch, we avoid offline tick_do_timer_cpu by distribute
> the offlining cpu among remaining cpus.

Please read Documentation/process. Search for 'this patch'...

>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  include/linux/tick.h        |  1 +
>  kernel/time/tick-common.c   |  1 +
>  kernel/time/tick-internal.h |  1 -
>  kernel/torture.c            | 10 ++++++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..23cc0b205853 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -14,6 +14,7 @@
>  #include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> +extern int tick_do_timer_cpu __read_mostly;
>  extern void __init tick_init(void);
>  /* Should be core only, but ARM BL switcher requires it */
>  extern void tick_suspend_local(void);
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 46789356f856..87b9b9afa320 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -48,6 +48,7 @@ ktime_t tick_next_period;
>   *    procedure also covers cpu hotplug.
>   */
>  int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
> +EXPORT_SYMBOL_GPL(tick_do_timer_cpu);

No. We are not exporting this just to make a bogus test case happy.

Fix the torture code to handle -EBUSY correctly.

Thanks,

        tglx
