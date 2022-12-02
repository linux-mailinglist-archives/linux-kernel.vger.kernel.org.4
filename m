Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21D640DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiLBSsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiLBSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:48:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198F8B3A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:48:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670006897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K2j1SZM4oUlYwwMJynT0T9xQynq1mOR1/i8Jr4xfZAI=;
        b=ljR13D0G4DN1u5TsdK0h1i/8z0NwLjdw+nSj0/qT1Tlwxi6d9DnsShRi+2uifQ2uWKcQtF
        qlgd9D+BoAtYpzuVFzADQsrJW2pjYX/0sVc5mI7iQCfLqfW+D37BZL4QlX3fbMw9uzJiar
        zAbVWYRZgceJYU1r3H6vHm1LjGvmSZDR6vBuoOHzHUmGVVwKiOHVffqrF/WWB8dzh1O7gM
        0K2UiORvwp2vi7Rl6nsxNutTv9k0kiuUVppkKS14uB1/gwv6G1iXkUSCBQf6RL22K+0K5u
        xN521DILnAjkbG2aRTzIGLBc6cDx+fIv0d+zbQfn3yLzun4G14oH9IIH9+FGCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670006897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K2j1SZM4oUlYwwMJynT0T9xQynq1mOR1/i8Jr4xfZAI=;
        b=Dg/DGD+AXnLEYc/XTYzWsCPDJOp98aDmxx9+Im2rofZTPTU9nOnVAWg4E03EwjVmnPO/U5
        WVheFDX/4+mSpZBQ==
To:     lirongqing@baidu.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        tony.luck@intel.com, wyes.karny@amd.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH][RFC] x86: override prefer_mwait_c1_over_halt to avoid
 loading cpuidle-haltpoll driver
In-Reply-To: <1669952252-32710-1-git-send-email-lirongqing@baidu.com>
References: <1669952252-32710-1-git-send-email-lirongqing@baidu.com>
Date:   Fri, 02 Dec 2022 19:48:16 +0100
Message-ID: <87fsdxprpr.ffs@tglx>
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

Li!

On Fri, Dec 02 2022 at 11:37, lirongqing@baidu.com wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> x86 KVM guests with MWAIT can load cpuidle-haltpoll driver, and will
> cause performance degradation, so override prefer_mwait_c1_over_halt
> to a new value, aviod loading cpuidle-haltpoll driver

Neither the subject line nor the above makes any sense to me.

prefer_mwait_c1_over_halt() is a function which is invoked and when it
returns true then the execution ends up in the code path you are
patching.

> @@ -889,6 +889,7 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
>  	} else if (prefer_mwait_c1_over_halt(c)) {
>  		pr_info("using mwait in idle threads\n");
>  		x86_idle = mwait_idle;
> +		boot_option_idle_override = IDLE_PREF_MWAIT;

What you do is setting boot_option_idle_override to a new value, but
that has nothing to do with prefer_mwait_c1_over_halt() at all.

So how are you overriding that function to a new value?

But that's just a word smithing problem.

The real and way worse problem is that you pick a variable, which has
the purpose to capture the idle override on the kernel command line, and
modify it as you see fit, just to prevent that driver from loading.

select_idle_routine() reads it to check whether there was a command line
override or not. But it is not supposed to write it. Why?

Have you checked what else evaluates that variable? Obviously not,
because a simple grep would have told you:

drivers/cpuidle/cpuidle-haltpoll.c:     if (boot_option_idle_override != IDLE_NO_OVERRIDE)
drivers/idle/intel_idle.c:      if (boot_option_idle_override != IDLE_NO_OVERRIDE)

Congratulations!

Your patch breaks the default setup of every recent Intel system on the
planet because it not only prevents the cpuidle-haltpoll, but also the
intel_idle driver from loading.

Seriously. It's not too much asked to do at least a simple grep and look
at all _nine_ places which evaluate boot_option_idle_override.

Thanks,

      tglx




