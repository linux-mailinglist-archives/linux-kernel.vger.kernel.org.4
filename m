Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752AE6149A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiKALmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiKALmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF82098F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F63A603F2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87375C433C1;
        Tue,  1 Nov 2022 11:35:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CO6JjFtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667302503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NfYm6sby+EMAs/+0GL8Wzp/D88zVvqWOVCo8SMDNGI=;
        b=CO6JjFtJIcgmQOz35udB3SQKPKwlMaNeMh7teykEqIQC5++h8m6wyTj2NIZDjlZ+OcEAyY
        dAL6ZvxabnSAD1tFzfm8T1ixgfbb975lwQcf8V7RzqJQY35hpKYcWTwjtxHwl3cGt1zqA/
        abh4WglwNJrcZkUpkwxjaO7Dc96uTxY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7b4d3266 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 11:35:02 +0000 (UTC)
Date:   Tue, 1 Nov 2022 12:34:59 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        puwen@hygon.cn, TonyWWang-oc@zhaoxin.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, andrew.cooper3@citrix.com,
        tony.luck@intel.com, mario.limonciello@amd.com,
        pawan.kumar.gupta@linux.intel.com, chenyi.qiang@intel.com,
        rdunlap@infradead.org, jithu.joseph@intel.com,
        rafael.j.wysocki@intel.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/cpu: replacing the open-coded shift with BIT(x)
Message-ID: <Y2EEY63DnDodJFoz@zx2c4.com>
References: <20221101111418.816139-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101111418.816139-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 07:14:18PM +0800, Gaosheng Cui wrote:
> Replace the open-coded shift with BIT(x) to make the code a bit
> more self-documenting, at the same time, fix some useless warnings.

Others might feel differently and that's fine, but I always found the
BIT() thing so much less clear than doing 1<<n, which is not only a
pattern that I recognize as builtin to my brain, but also provides a
direct description of what's happening, "shift a 1 over n times",
leaving no off-by-one ambiguity about it. If anything I'd like to see
the BIT() macro expanded throughout and then removed entirely.

Probably just me though. You can safely ignore my opinion :).

Jason


> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2:
> - Change the commit msg, remove the UBSAN warning calltrace, and
>   merge patch "x86/cpu: fix undefined behavior in bit shift for
>   intel_detect_tlb" with it. Thanks!
>  arch/x86/kernel/cpu/amd.c     | 2 +-
>  arch/x86/kernel/cpu/centaur.c | 2 +-
>  arch/x86/kernel/cpu/hygon.c   | 2 +-
>  arch/x86/kernel/cpu/intel.c   | 4 ++--
>  arch/x86/kernel/cpu/proc.c    | 2 +-
>  arch/x86/kernel/cpu/zhaoxin.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 860b60273df3..75d82cad323a 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -613,7 +613,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>  	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
>  	 * with P/T states and does not stop in deep C-states
>  	 */
> -	if (c->x86_power & (1 << 8)) {
> +	if (c->x86_power & BIT(8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>  	}
> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> index 345f7d905db6..9910bb1d90fd 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -105,7 +105,7 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_X86_64
>  	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
>  #endif
> -	if (c->x86_power & (1 << 8)) {
> +	if (c->x86_power & BIT(8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>  	}
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> index 21fd425088fe..dc473bfbf1b5 100644
> --- a/arch/x86/kernel/cpu/hygon.c
> x86/cpu: fix undefined behavior in bit shift for intel_detect_tlb+++ b/arch/x86/kernel/cpu/hygon.c
> @@ -251,7 +251,7 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
>  	 * c->x86_power is 8000_0007 edx. Bit 8 is TSC runs at constant rate
>  	 * with P/T states and does not stop in deep C-states
>  	 */
> -	if (c->x86_power & (1 << 8)) {
> +	if (c->x86_power & BIT(8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>  	}
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 2d7ea5480ec3..2bdf6d601a6f 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -286,7 +286,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	 * It is also reliable across cores and sockets. (but not across
>  	 * cabinets - we turn it off in that case explicitly.)
>  	 */
> -	if (c->x86_power & (1 << 8)) {
> +	if (c->x86_power & BIT(8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>  	}
> @@ -945,7 +945,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
>  
>  		/* If bit 31 is set, this is an unknown format */
>  		for (j = 0 ; j < 3 ; j++)
> -			if (regs[j] & (1 << 31))
> +			if (regs[j] & BIT(31))
>  				regs[j] = 0;
>  
>  		/* Byte 0 is level count, not a descriptor */
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..efa1d39c4f25 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -135,7 +135,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  	seq_puts(m, "power management:");
>  	for (i = 0; i < 32; i++) {
> -		if (c->x86_power & (1 << i)) {
> +		if (c->x86_power & BIT(i)) {
>  			if (i < ARRAY_SIZE(x86_power_flags) &&
>  			    x86_power_flags[i])
>  				seq_printf(m, "%s%s",
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> index 05fa4ef63490..34a8a460f8f4 100644
> --- a/arch/x86/kernel/cpu/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -61,7 +61,7 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_X86_64
>  	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
>  #endif
> -	if (c->x86_power & (1 << 8)) {
> +	if (c->x86_power & BIT(8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>  	}
> -- 
> 2.25.1
> 
