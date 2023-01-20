Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8305067562B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjATN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:56:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FFBF8B5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:56:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ss4so14078894ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7eK0S32R7OzdAHjN8ANIsN9zhM51LWwumKsQBQQh8I=;
        b=C/UkHRCo3dJQXtq4TBwbY4SPLPXRYn2WOJG9lENA7XPB5yLT/zlXBogNk1MOZ6l55p
         5fZq+rGqYualx4+bpTovJMsfmDCsCUiGXcKUPTu5p9XB+OtbFWUScvNjeDDh5hex/JJG
         7jiytQBn/EBJWWPjwVKX3aGDhkoyfWgdWvr7wtMarwTpKBeJfG2Pal2Rsy7JWF4jJxzJ
         oglsLixFOL5wWywmmwJigjkv2eWfgidHwq4JRyQLkdXDXhXbcUkd2ml2YuwBDRFu61BQ
         fO2wS2UZQSpA1YUeHvkJM2V+gCuVbFL6bzDwsgzvfPL0U5dqQ9yjsUehYo7NpWAA1Jz1
         LmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7eK0S32R7OzdAHjN8ANIsN9zhM51LWwumKsQBQQh8I=;
        b=YWBfz7xbrwk4RRKwtmdiVOKPXn4QHuB1LwIBa7jPlE4ErMSX43cIEX9T8g/USDGx3B
         4GeVO1Nk9hTcIiJSiJsSyqoy2BOyg9HiqkCjiH0sdmV3NrhEPwWkjK/DX/OP83VNt2AI
         TG3oo6j0hDdEPWZBIuTE96TpPy2JWmfno5iFWNv+L39A/n07U4ql4u6W32aLdr24X1nh
         CQ5Z0tKwTciqJkxZ7p/4rpVB9YduLZmvV3zRXXiGGlzmZaGvC2J+uDq/ynvOcZDDcNIt
         dAfSjcvWslDRWI/Mzr/7fg6ZcbG0x8aypN6btY+1BK1g53BnADRoRlWPJrqi95oIEF09
         XsHA==
X-Gm-Message-State: AFqh2kpsO7OSh9wB3Y04U2+LjNWFrCGUIQ/6fNUsKYUrZp8gYelcvkMK
        GISEW+Ay99UBrVXWN0CAF+v4lg==
X-Google-Smtp-Source: AMrXdXsDjnqn1FOnw74lL1yVvsD6lGj78Ptra6ukhIH804E5wD8+CJKg4PdIcqvALwMEwneYz7HrQQ==
X-Received: by 2002:a17:906:4096:b0:79e:4880:dd85 with SMTP id u22-20020a170906409600b0079e4880dd85mr14823861ejj.47.1674222994156;
        Fri, 20 Jan 2023 05:56:34 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906218900b0084cb4d37b8csm18043546eju.141.2023.01.20.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:56:33 -0800 (PST)
Date:   Fri, 20 Jan 2023 14:56:32 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        conor@kernel.org, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 2/3] RISC-V: resort all extensions in consistent orders
Message-ID: <20230120135632.vb7ncvoapnaixluu@orel>
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
 <20221205144525.2148448-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205144525.2148448-3-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:45:25PM +0000, Conor Dooley wrote:
> Ordering between each and every list of extensions is wildly
> inconsistent. Per discussion on the lists pick the following policy:
> 
> - The array defining order in /proc/cpuinfo follows a narrow
>   interpretation of the ISA specifications, described in a comment
>   immediately presiding it.
> 
> - All other lists of extensions are sorted alphabetically.
> 
> This will hopefully allow for easier review & future additions, and
> reduce conflicts between patchsets as the number of extensions grows.
> 
> Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 12 +++++++-----
>  arch/riscv/kernel/cpu.c        |  4 ++--
>  arch/riscv/kernel/cpufeature.c |  6 ++++--
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b22525290073..ce522aad641a 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
>   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
>   * extensions while all the multi-letter extensions should define the next
>   * available logical extension id.
> + * Entries are sorted alphabetically.
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_SSTC,
> +	RISCV_ISA_EXT_SVINVAL,
>  	RISCV_ISA_EXT_SVPBMT,
>  	RISCV_ISA_EXT_ZICBOM,
>  	RISCV_ISA_EXT_ZIHINTPAUSE,
> -	RISCV_ISA_EXT_SSTC,
> -	RISCV_ISA_EXT_SVINVAL,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,

Hi Conor,

I'm digging this back up because I'm basing Zicboz on it.

If we take "riscv: improve boot time isa extensions handling", then this
becomes a bunch of manually enumerated defines

 #define RISCV_ISA_EXT_SSCOFPMF         26
 #define RISCV_ISA_EXT_SVPBMT           27
 #define RISCV_ISA_EXT_ZICBOM           28
 #define RISCV_ISA_EXT_ZIHINTPAUSE      29
 #define RISCV_ISA_EXT_SSTC             30
 #define RISCV_ISA_EXT_SVINVAL          31

Keeping those in alphabetical order would either require manually
reenumerating them or to allow the numbers to be out of order as
we add more extensions. I think I'd prefer we just add new
extensions at the bottom and keep the numbers in order.

Thanks,
drew
