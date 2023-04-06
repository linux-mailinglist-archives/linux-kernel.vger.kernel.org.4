Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B356D9B14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjDFOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjDFOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB38A7E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0492A645E6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46500C4339B;
        Thu,  6 Apr 2023 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680792419;
        bh=n5joFKVnPLtAJ6tG71FKEUuT0a8hdGU5ynD+XlAjA2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYOHeh585eFA/bUEq2xNVhimLscmPnMZWiYlvecrpszOoq/vRqCY0NqZq1L1Smzo3
         GuhKpkCtWPaol2vx6uidnaHfzsXNXlukxuZZTOD2NqCMZK/65qVEIjuM7SVDoxI9UM
         noZyMr8J0KjpO+fk66c6BvZjvx2uDZ7A6KPSgTPUSwJg4PnWTdWp5AFZBf1eEgDOTu
         PYMx56JK7Dr+5E495vC6Pwwyox2f1qiyks1RfM36Kgeoj0Qfadm9+l6q/nGcUEEqWv
         M8rUgo4M6UYGlaIT5AcKuLi+3Vs0Hru99yQvRMs+MEJvtVdJai9IPBEZGqnSSgQH0Q
         f6sPCYG2sNMOQ==
Date:   Thu, 6 Apr 2023 15:46:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
Message-ID: <20230406144653.GB11479@willie-the-truck>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
 <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 08:44:54PM +0000, Mark Brown wrote:
> Automatically generate the Hypervisor Fine-Grained Instruction Trap
> Register as per DDI0601 2022-12, currently we only have a definition for
> the register name not any of the contents.  No functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  1 -
>  arch/arm64/tools/sysreg         | 65 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e5ca9ece1606..c48b41c9b0cc 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -419,7 +419,6 @@
>  #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
>  #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
>  #define SYS_HSTR_EL2			sys_reg(3, 4, 1, 1, 3)
> -#define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
>  #define SYS_HACR_EL2			sys_reg(3, 4, 1, 1, 7)
>  
>  #define SYS_TTBR0_EL2			sys_reg(3, 4, 2, 0, 0)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 60829a9409f0..c06097a8b921 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1941,6 +1941,71 @@ Sysreg HFGWTR_EL2	3	4	1	1	5
>  Fields	HFGxTR_EL2
>  EndSysreg
>  
> +Sysreg HFGITR_EL2	3	4	1	1	6
> +Res0	63:61
> +Field	60	COSPRCTX
> +Field	59	nGCSEPP
> +Field	58	nGCSSTR_EL1
> +Field	57	nGCSPUSHM_EL1

These aren't in the Arm ARM afaict ^^^

> +Field	56	nBRBIALL
> +Field	55	nBRBINJ
> +Field	54	DCCVAC
> +Field	53	SVC_EL1
> +Field	52	SVC_EL0
> +Field	51	ERET
> +Field	50	CPPRCTX
> +Field	49	DVPRCTX
> +Field	48	CFPRCTX
> +Field	47	TLBIVAALE1
> +Field	46	TLBIVALE1
> +Field	45	TLBIVAAE1
> +Field	44	TLBSIDE1

This is a typo ^^^

(I stopped reviewing at this point)

Can't we generate this file from the architecture xml? That would hopefully
avoid typos like this and make review less tedious.

Will
