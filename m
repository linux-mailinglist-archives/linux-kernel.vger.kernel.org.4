Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7696DE66D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDKVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKVbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CA10E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9629760DBC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB636C433D2;
        Tue, 11 Apr 2023 21:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681248660;
        bh=WuwM7eBBpG+iDgIFIoBbrWke9NYsxIXtTX+7OpaHRMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttabg2r4mNiayFBR+a+8t24D1WM/aEIUkRaDDN/IOx/2yTHNFzxILBvvjBl1VeKmX
         VedXf5xiLIVf+wMUwp/3oE2ODf73fCVOZPePZmxhV1oioYwKOP04zOLNheldKLyzlN
         LLX22GXWF7ga1aQRyORk632SciSnhiDlFpkTaw0QZ2z0X+k2bDqKmlgcJAYTV5PTYI
         wYPjDToK3x1KB3VYmUv5qdvQ3F6c2KykQXf0eHbX1e8NoF4Ey/qwu4bw+oYIw2Iw71
         57N8QhpHjkMpa/T7l6+mwGHQSwVqrMlqd0bvWgOlaHnYDWxPXjgdxVAOJPArhsYP1Y
         LDkgML8rPWWdw==
Date:   Tue, 11 Apr 2023 22:30:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
Message-ID: <20230411213052.GA24045@willie-the-truck>
References: <20230306-arm64-fgt-reg-gen-v4-1-d587297520d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306-arm64-fgt-reg-gen-v4-1-d587297520d5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:59:25PM +0100, Mark Brown wrote:
> Automatically generate the Hypervisor Fine-Grained Instruction Trap
> Register as per DDI0601 2022-12, currently we only have a definition for
> the register name not any of the contents.  No functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v4:
> - Rebase onto applied HFG[RW]TR_EL2 patch.
> - Correct naming of HFGITR_EL2.TLBIASIDE1.
> - Link to v3: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org
> Changes in v3:
> - Add HFGITR_EL2.
> Changes in v2:
> - Correct naming of nPIRE0_EL1.
> - Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org
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
> index 2af92b4f4fe4..b76569b29561 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1964,6 +1964,71 @@ Sysreg HFGWTR_EL2	3	4	1	1	5
>  Fields	HFGxTR_EL2
>  EndSysreg
>  
> +Sysreg HFGITR_EL2	3	4	1	1	6
> +Res0	63:61
> +Field	60	COSPRCTX
> +Field	59	nGCSEPP
> +Field	58	nGCSSTR_EL1
> +Field	57	nGCSPUSHM_EL1
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
> +Field	44	TLBIASIDE1
> +Field	43	TLBIVAE1
> +Field	42	TLBIVMALLE1
> +Field	41	TLBIRVAALE1
> +Field	40	TLBIRVALE1
> +Field	39	TLBIRVAAE1
> +Field	38	TLBIRVAE1
> +Field	37	TLBIRVAALE1IS
> +Field	36	TLBIRVALE1IS
> +Field	35	TLBIRVAAE1IS
> +Field	34	TLBIRAALE1IS

I got a bit cross-eyed looking at this, but this looks wrong ^^

** Please ** can you generate this stuff rather than writing it by hand?

Like I said on the previous version, the script can be as hacky as you
like and doesn't need to live in the tree. But if you just run it locally
then it should prevent these inevitable typos.

Will
