Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF76E4B76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDQO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDQO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:28:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BDC5B9B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:28:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA7B1063;
        Mon, 17 Apr 2023 07:29:33 -0700 (PDT)
Received: from [10.57.68.227] (unknown [10.57.68.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08EBE3F5A1;
        Mon, 17 Apr 2023 07:28:48 -0700 (PDT)
Message-ID: <c4d4f543-9dae-9514-3411-7061192af530@arm.com>
Date:   Mon, 17 Apr 2023 15:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 30/60] arm64: idreg-override: Create a pseudo feature
 for rodata=off
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-31-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-31-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> Add rodata=off to the set of kernel command line options that is parsed
> early using the CPU feature override detection code, so we can easily
> refer to it when creating the kernel mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/cpufeature.h   | 1 +
>  arch/arm64/kernel/pi/idreg-override.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index bc10098901808c00..edc7733aa49846b2 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -16,6 +16,7 @@
>  #define cpu_feature(x)		KERNEL_HWCAP_ ## x
>  
>  #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
> +#define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	4

I assume these are bit numbers? Why not just use the next available bit (bit 1)
for this new flag?

>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index 4e76db6eb72c2087..6c547cccaf6a9e9c 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -151,6 +151,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
>  	.override	= &arm64_sw_feature_override,
>  	.fields		= {
>  		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
> +		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
>  		{}
>  	},
>  };
> @@ -183,6 +184,7 @@ static const struct {
>  	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
>  	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>  	{ "nokaslr",			"arm64_sw.nokaslr=1" },
> +	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>  };
>  
>  static int __init parse_hexdigit(const char *p, u64 *v)

