Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7869863F9D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiLAVat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiLAVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:30:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C415A95B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:30:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669930242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEXRe6EnzwLWdTHPhEnnPYCfVGjc5TU7PUtwG1b6J2Y=;
        b=EFBFeCgrq3Xjm+CembFBotS4JCESPkXLCpyTie2MzvmvM4hErsMkmVz2c9RtMmmxUPY77Q
        hquFglHRuprTJGQ2qNVqt09SHpAcCuKedEpOw8jWRmrlZHRgklMt668TuiSKv/RslMv0ug
        u1EirdbH/SzBJx2jnY9wfGcjVt/TdfuE9eBfFudJ+QvYbxbAF4muZ5v1wX4GmKmBhyuX23
        m9HLDnTHiRwunSgiwuVzooKlUBm2/IxEjv0f7bqI1FovywXfV1QfqvkCTGbWx6EThYbMKF
        XwTsqBHfuREtPgHTQ7XA4YWdDeBuen871O4zZZExNIN5vTj7fHS2fA8JSPdGWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669930242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEXRe6EnzwLWdTHPhEnnPYCfVGjc5TU7PUtwG1b6J2Y=;
        b=O+HcuIbE29ULW8qzenbyLDVWEu1JLzfv2mdqwmjdLyiXZT4GZKTomqVWkHoY/jRvTwIHMK
        Hah5zP/cQCOMXnBA==
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] hrtimer: CPU and entry_time is added to a warning
 message in hrtimer_interrupt()
In-Reply-To: <20220624070011.128234-1-yamamoto.rei@jp.fujitsu.com>
References: <87h77lhkzh.ffs@tglx>
 <20220624070011.128234-1-yamamoto.rei@jp.fujitsu.com>
Date:   Thu, 01 Dec 2022 22:30:41 +0100
Message-ID: <87sfhyrev2.ffs@tglx>
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

Rei!

On Fri, Jun 24 2022 at 16:00, Rei Yamamoto wrote:
> A warning message in hrtimer_interrupt() is output up to 5 times
> by default, and CPU and entry_time are also shown.

This describes to some extent _what_ the patch is doing, but not the
why.

> These changes are helpful that the function spending a lot of time is clear
> by using ftrace:

That's a constructed case. There are multiple reasons why this can
happen, not just because a single hrtimer callback misbehaves.

> @@ -2038,6 +2039,15 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_INT_MAX,
>  	},
> +#endif
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	{
> +		.procname       = "hrtimer_interrupt_warnings",
> +		.data           = &sysctl_hrtimer_interrupt_warnings,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec,
> +	},

So this adds a new sysctl, but the changelog does not tell anything
about it. Aside of the dubious value of this sysctl, this lacks the
required documentation for new sysctls.

> +	/*
> +	 * If a message is output many times, the delayed funciton
> +	 * may be identified by resetting sysctl_hrtimer_interrupt_warnings
> +	 * and enabling ftrace.

What has the reset of sysctl_hrtimer_interrupt_warnings to do with
ftrace and how is that reset helpful to identify the root cause?

Also repeating the printk 5 times does not add any value at all. The
runaway detection already has logic to supress spurious events and if
the problem persists then it can be observed by ftrace without any of
these changes.

I assume - because you did not tell so - that you try to have a
correlation between ftrace and dmesg via the entry timestamp output,
right?

That's just a half thought out debug bandaid, really.

You can provide a way better mechanism by adding a tracepoint right at
the pr_warn_once(), which emits information for correlation right into
the trace.

That allows you to stop the trace once the tracepoint is emitted instead
of having to do all of this including the correlation manually.

Hmm?

Thanks,

        tglx

