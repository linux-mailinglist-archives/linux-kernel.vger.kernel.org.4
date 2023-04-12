Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137686DF004
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDLJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjDLJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86555FE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E8D62B17
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451C8C433EF;
        Wed, 12 Apr 2023 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681290293;
        bh=zZZlNeCjDkasiEk+l/m8l9090JK0GVdmjnq3v9cYBb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6+EymLXJmlB2tmOulEOsDMnGozkR2Kd+tJU/h5acc4uS5QELcvMXummYzASM7k5q
         0veeFs/SqOpmd2kTkY0oVU2d4f9mFMf4SNGmFsBDvZ1MXk15NUSUXtfAPndQ9QMz1h
         oH4xAT/K6e8cLPnGEoKJtoU0kJ14K+4Rk/ThqaNQxEFVeP1lU2GaujfGWQufKrBgsr
         ReWkhwiRQRPSgKvZCuAySaZmsEik2/Zcdy2QUDO9sdoXsBDaZJR26Pd25JBlPE54uH
         Pf/bN4AuWnkQwd8ioIn9YLUtKrn74ePw+d2K3fUMpUziVkjcPlPGIkhlpTTv16A4oh
         rzU23jhbe5r0Q==
Date:   Wed, 12 Apr 2023 10:04:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64/cpufeature: Use helper macro to specify ID
 register for capabilites
Message-ID: <20230412090447.GA24799@willie-the-truck>
References: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
 <20230303-arm64-cpufeature-helpers-v1-3-b16cf36acaea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-arm64-cpufeature-helpers-v1-3-b16cf36acaea@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:20:25PM +0000, Mark Brown wrote:
> When defining which value to look for in a system register field we
> currently manually specify the register, field shift, width and sign and
> the value to look for. This opens the potential for error with for example
> the wrong field width or sign being specified, an enumeration value for
> a different similarly named field or letting something be initialised to 0.
> 
> Since we now generate defines for all the ID registers we now have named
> constants for all of these things generated from the system register
> description, meaning that we can generate initialisation for all the fields
> used in matching from a minimal specification of register, field and match
> value. This is both shorter and eliminates or makes build failures several
> potential errors.
> 
> No change in the generated binary.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 245 ++++++++---------------------------------
>  1 file changed, 44 insertions(+), 201 deletions(-)

[...]

>  		.desc = "WFx with timeout",
>  		.capability = ARM64_HAS_WFXT,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> -		.sys_reg = SYS_ID_AA64ISAR2_EL1,
> -		.sign = FTR_UNSIGNED,
> -		.field_pos = ID_AA64ISAR2_EL1_WFxT_SHIFT,
> -		.field_width = 4,
> -		.matches = has_cpuid_feature,
> -		.min_field_value = ID_AA64ISAR2_EL1_WFxT_IMP,
> +		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, WFxT, IMP)

You drop the '.matches' field here.

Will
