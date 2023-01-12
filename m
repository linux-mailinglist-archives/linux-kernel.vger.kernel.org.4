Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59366708F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjALLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjALLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:08:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264F48CE8;
        Thu, 12 Jan 2023 03:00:14 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:00:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673521213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1QNHCIDJ7rojdgNnqA4mJe1cfCZkTQt32RrnCw+08k=;
        b=lu/zi31dDgZlme4oCsT42jgjaLWwS35EFzK1BNuDLfE/ErYQvoC+EfLpwwsJhx6MrYWH3R
        lTR/wGrdAwXluasLJR24Ww3NFcsobuUsC3qc+tz/vbOUaeq3gn0shnyJ0B6Nqh130sJoi1
        QuD4oOD6Yw4rMipZgJaLY5VBKMfr7pd65FZ8ZprGzwtHZLbGBq37uDRNadkQee9ytauV2i
        zlIwnWth7JVobRow1bJEmcf4aFn8pHuFzSRH1ZvbECYWUxD4sszzxEt88kfPD9r3YoiYxl
        yil1kLeRuqiCcuhFwEg9YwtSwMkPHHSPNutdxQED6q1rrQM1mgLPgCJTmdfS9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673521213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1QNHCIDJ7rojdgNnqA4mJe1cfCZkTQt32RrnCw+08k=;
        b=ksnBDcHqpunrEMuMJZuzFI2qNz87htcUDVk/44Hy+Ebt+cE0Eb+ZVDJ5+LzKk0mfjU2ink
        nBgWmCLKQ9FBWeAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Message-ID: <Y7/oO8s26SKU8eOz@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 16:15:00 [+0100], Krzysztof Kozlowski wrote:
> The PSCI cpuidle power domain in power_off callback uses
> __this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in

Why does __this_cpu_write() matter here?

> Realtime kernels and solves errors like:
> 
>   BUG: scheduling while atomic: swapper/2/0/0x00000002
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Call trace:
>    dump_backtrace.part.0+0xe0/0xf0
>    show_stack+0x18/0x40
>    dump_stack_lvl+0x68/0x84
>    dump_stack+0x18/0x34
>    __schedule_bug+0x60/0x80
>    __schedule+0x628/0x800
>    schedule_rtlock+0x28/0x5c
>    rtlock_slowlock_locked+0x360/0xd30
>    rt_spin_lock+0x88/0xb0
>    genpd_lock_nested_spin+0x1c/0x30
>    genpd_power_off.part.0.isra.0+0x20c/0x2a0
>    genpd_runtime_suspend+0x150/0x2bc
>    __rpm_callback+0x48/0x170
>    rpm_callback+0x6c/0x7c
>    rpm_suspend+0x108/0x660
>    __pm_runtime_suspend+0x4c/0x8c
>    __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
>    psci_enter_domain_idle_state+0x18/0x2c
>    cpuidle_enter_state+0x8c/0x4e0
>    cpuidle_enter+0x38/0x50
>    do_idle+0x248/0x2f0
>    cpu_startup_entry+0x24/0x30
>    secondary_start_kernel+0x130/0x154
>    __secondary_switched+0xb0/0xb4

This is to a sleeping lock (spinlock_t) in an IRQ-off region which
starts in do_idle(). You could describe the problem and to solution you
aim for instead pasting a backtrace into the commit description and
adding a flow in the code.

I don't see how your commit description matches your change in code. One
might think "Oh. If I see this pattern, I need an irqsafe lock to fix
it".

Sebastian
