Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809566066D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJTROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJTRN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:13:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95F1A910B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=utMzAWAaRXrY+26l2QugyM3qYVdlY+ytg7KZbgukQr0=; b=Vq8Ml6TT/sTqeJqSmwKxrogW7O
        YPdZeNpkhRQLCTW7SynKMD3i5s9m54sfGw0Yy5pixepQehiJ23A/sOJpVgspVIJhcM236Ug2FAMmA
        pFaeNWAQNR/wdj4zj9GI9D2bU6QvA1Xx+H2Z4oF1qXuZQJS7MNTF5f+MMvcuVarNeml+Chp567XCY
        bLAMRLkRN1ntlLBJB7Rr6jchkISsCuZgllQ5p+5lJyVLbNLSg1uHa0ybridfySUZOPxQTxKJU5PBQ
        QpQ1U2C7sFMfBVDroBatWvHkPhAtKKhxgvJT7+gW8Rj9Dj+Lf/YTqxxnF1kGooP91ZEbzwGOP7PhA
        gw6hhQ7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olZ6l-0055Ow-UE; Thu, 20 Oct 2022 17:13:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E366A300209;
        Thu, 20 Oct 2022 19:13:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD8732C15968D; Thu, 20 Oct 2022 19:13:26 +0200 (CEST)
Date:   Thu, 20 Oct 2022 19:13:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rishabh Agrawal <rishabhagr@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        drake@endlessm.com, rafael.j.wysocki@intel.com, mingo@redhat.com,
        tglx@linutronix.de, vaibhav.shankar@intel.com,
        biernacki@google.com, zwisler@google.com, mattedavis@google.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2] Add hardcoded crystal clock for KabyLake
Message-ID: <Y1GBtjcetPpTq0V3@hirez.programming.kicks-ass.net>
References: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018190124.v2.1.I918ccc908c5c836c1e21e01d2cf6f59b0157bcc3@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:01:32PM +0000, Rishabh Agrawal wrote:
> Set KabyLake crystal clock manually since the TSC calibration is off
> by 0.5%. All the tests that are based on the timer/clock will fail in
> this case.
> 
> The HPET has been disabled by upstream due to PC10 issue causing the
> 3 hatch devices, dratini, jinlon, and kohaku to not calibrate the clock

I have no idea what a hatch device is, nor what pokemon have anything to
do with things.

> precisely. These 3 devices are KabyLake devices. Intel team has verified

But no actual Intel person with a Reviewed-by tag we can go pester if
this turns out to be wrong.

> that all KBL devices have 24.0 MHz clock frequency, therefore this
> change is valid.

And yet you only change KBL_L.

And why, pray *WHY* can't Intel simply write the correct information in
CPUID leaf 15h. I mean, they defined the leaf, might as well use it, no?

> Signed-off-by: Rishabh Agrawal <rishabhagr@chromium.org>
> ---
> 
> Changes in v2:
>   - Adding Thomas Gleixner, Daniel Drake, Rafael Wysocki, Len brown and Ingo to review since you worked on this.
> 
>  arch/x86/kernel/tsc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..63a06224fa48 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -644,10 +644,21 @@ unsigned long native_calibrate_tsc(void)
>  	 * Denverton SoCs don't report crystal clock, and also don't support
>  	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
>  	 * clock.
> +	 *
> +	 * Intel KabyLake devices' clocks are off by 0.5% when using the below
> +	 * calculation, so hardcode 24.0 MHz crystal clock.
>  	 */
> -	if (crystal_khz == 0 &&
> -			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
> -		crystal_khz = 25000;
> +	if (crystal_khz == 0) {
> +		switch (boot_cpu_data.x86_model) {
> +		case INTEL_FAM6_ATOM_GOLDMONT_D:
> +			crystal_khz = 25000;
> +			break;
> +		case INTEL_FAM6_KABYLAKE_L:
> +			crystal_khz = 24000;
> +			break;
> +		}
> +
> +	}
>  
>  	/*
>  	 * TSC frequency reported directly by CPUID is a "hardware reported"
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
