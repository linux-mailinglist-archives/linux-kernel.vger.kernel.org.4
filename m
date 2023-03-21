Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB786C3034
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCULUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjCULUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:20:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82CDFC141
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:20:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386ACAD7;
        Tue, 21 Mar 2023 04:20:46 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.54.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FFD43F71E;
        Tue, 21 Mar 2023 04:20:01 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:19:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Support CMDLINE_EXTEND
Message-ID: <ZBmS28ciIei5sKHY@FVFF77S0Q05N>
References: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320211451.2512800-1-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:14:51AM +1300, Chris Packham wrote:
> Support extending the bootloader provided command line for arm64
> targets. This support is already present via generic DT/EFI code the
> only thing required is for the architecture to make it selectable.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

We deliberately dropped support for CMDLINE_EXTEND in commit:

  cae118b6acc3 ("arm64: Drop support for CMDLINE_EXTEND")

... which was mentioned the last time somone tried to re-add it:

  https://lore.kernel.org/linux-arm-kernel/ZAh8dWvbNkVQT11C@arm.com/

Has something changes such that those issues no longer apply? If so, please
call that out explicitly in the commit message. If not, I do not think we
should take this patch.

Thanks,
Mark.

> ---
>  arch/arm64/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1023e896d46b..3c837b085f21 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2228,6 +2228,12 @@ config CMDLINE_FROM_BOOTLOADER
>  	  the boot loader doesn't provide any, the default kernel command
>  	  string provided in CMDLINE will be used.
>  
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	help
> +	  The command-line arguments provided by the boot loader will be
> +	  appended to the default kernel command string.
> +
>  config CMDLINE_FORCE
>  	bool "Always use the default kernel command string"
>  	help
> -- 
> 2.40.0
> 
