Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138664E275
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLOUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:42:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594545EDE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:42:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F55D61EFF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0694C433EF;
        Thu, 15 Dec 2022 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671136925;
        bh=d/a7C/PBOg8rdq9nwXwUdpRZ5tsLNSdSY3Squ2imeAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3xlF6bUMRnZWvVutOYkDDYPoagnHMfAjHcWy839UzoWE65h0njzkehIWK3rHiMFl
         pFFVxTqJqLwGMWEH4DVNlk4yVHvfz6tvKF/Y6uIoo1y8pYyIy9DIkd1p5b7LzigHg7
         n6EPWk3n6woOvhhKmT0M8USBykiEonQ9P0U8InbXyqZHSyLd5wurBcdSm8pKgCqXpF
         5PTeCaHzp+F+wr844bzYtcdsKRBC9uOkObwyCxE2AwhpSmp4bpyNxEKMY/jUgjsrXz
         872QztzTey9jImak0Ss0J4YGmhBBZQ1380yW6dMV3svniT6bDiz0YQDOjcShFbpfdT
         ieAmiZVdYfVZg==
Received: by pali.im (Postfix)
        id 6DA4A5CD; Thu, 15 Dec 2022 21:42:02 +0100 (CET)
Date:   Thu, 15 Dec 2022 21:42:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1] powerpc/64: Set default CPU in Kconfig
Message-ID: <20221215204202.mbw2ij4ou7t2ttpv@pali>
References: <3fd60c2d8a28668a42b766b18362a526ef47e757.1670420281.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd60c2d8a28668a42b766b18362a526ef47e757.1670420281.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wednesday 07 December 2022 14:38:40 Christophe Leroy wrote:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
...
> @@ -166,11 +153,12 @@ CC_FLAGS_FTRACE += -mprofile-kernel
>  endif
>  endif
>  
> -CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> -AFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> +CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += -mcpu=$(CONFIG_TARGET_CPU)
> +AFLAGS-$(CONFIG_TARGET_CPU_BOOL) += -mcpu=$(CONFIG_TARGET_CPU)
>  
> -CFLAGS-$(CONFIG_E5500_CPU) += $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
> -CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))
> +CFLAGS-$(CONFIG_POWERPC64_CPU) += $(call cc-option,-mtune=power10,	\
> +				  $(call cc-option,-mtune=power9,	\
> +				  $(call cc-option,-mtune=power8)))
>  
>  asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
>  
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
...
> @@ -251,6 +249,10 @@ config TARGET_CPU
>  	default "power8" if POWER8_CPU
>  	default "power9" if POWER9_CPU
>  	default "power10" if POWER10_CPU
> +	default "e500mc64" if E5500_CPU

Now I'm looking at this change again... and should not E5500_CPU rather
enforce -mcpu=e5500 flag? I know that your patch moves e500mc64 flag
from the Makefile to Kconfig, but maybe it could be changed in some
other followup patch...

Anyway, do you know what is e500mc64 core? I was trying to find some
information about it, but it looks like some unreleased freescale core
which predates e5500 core. ISA (without extensions like altivec) seems
to be same for e500mc64, e5500 and e6500 cores and difference is only
pipeline definitions in gcc config files. So if my understanding is
correct then kernel binary compiled with any of these -mcpu= flag should
work on any of those cores. Just for mismatches core binary will not be
optimized for speed.

> +	default "e6500" if E6500_CPU
> +	default "power4" if POWERPC64_CPU && !CPU_LITTLE_ENDIAN
> +	default "power8" if POWERPC64_CPU && CPU_LITTLE_ENDIAN
>  	default "405" if 405_CPU
>  	default "440" if 440_CPU
>  	default "464" if 464_CPU
> -- 
> 2.38.1
> 
