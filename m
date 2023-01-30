Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E368068A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjA3Hf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjA3Hf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:35:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B8193D7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:35:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so17862545ejx.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfETmmTJA09Tb8AAwAjfmJEnkRVB5Nh/ahlNcOn6vxY=;
        b=bjsmp1isU6JeAyrPafl3L1U7DNfyVJ7sYRyXRrE175aiUI/2CCvT/1eEPaazv+Yvzr
         S9bALfsn3Avv4bySMBtGJatKPejwOhl+czAR/5MK8owIcHVcO+iJxhQlUsEphQKEmvr9
         qwccWMUAb/DZhHCV04CXpw+sWhMP7GMgxlJgR9N9C5fWL0w09jzUNwW7UgpROjh8B6jP
         enUmx4jwCpVvP6iE6SHIlSjY/IY91awleHYf9FH6Tm/OqR27bvT+ncEwTotfB83eVEzL
         2nLYs3US7r4z75czWDIsrpgGbpMJ5mLuT3lFccdiyZ78NkRfVLlncKUWIGetayjrelFN
         f9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfETmmTJA09Tb8AAwAjfmJEnkRVB5Nh/ahlNcOn6vxY=;
        b=hj64PCDwek9rKLKDXKjToQyeig828HHpNY3l3SvMpOD2gJq8Ad7fcstLEiaALYjR8P
         P0irAUeZy+tvxZLFvuntcokMxjiDqbCfOR2yqOQk+AxUiXX6uAIylKHi8x2hhoVGd3r/
         bSnuPI4VZHb9djTNnU9SW1zfzvYbb5unPg+F9BW07Es5nwsZSg1Q3dJ0/igm+CKwr9dU
         ZCad1cP2m4C1ifj1wlkF6VATvW/C8TCE/O2gayb2Enl3MW7Ohk0Nf+Y1PWFlllVrizfa
         /pKfASeoZ1A7whQ67D9/vOhMreObD0Cs8lYNGLFlJGY8/+pH5JCd8VxpRqqGSTn1/1lI
         iepw==
X-Gm-Message-State: AO0yUKU41ICmWs2JkEW6iSpqo/f6d3kRd3F0GKbcF94e2dMpSQUYgJwQ
        SN0iwSeOYJDD9PEON90q3Uk3DA==
X-Google-Smtp-Source: AK7set/t4Qk5zw1F0DdvwAEi9Iqv8vsi6/do+RC5b14yJow5+FclmrhKfP/nnQ4XMUHXQu9DxceuHw==
X-Received: by 2002:a17:907:785:b0:88a:bb13:7329 with SMTP id xd5-20020a170907078500b0088abb137329mr208029ejb.53.1675064123856;
        Sun, 29 Jan 2023 23:35:23 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id fy37-20020a1709069f2500b0087fbf72175csm4050800ejc.103.2023.01.29.23.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 23:35:23 -0800 (PST)
Date:   Mon, 30 Jan 2023 08:35:22 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
Message-ID: <20230130073522.ivv2izzayouhw6dm@orel>
References: <20230129094242.282620-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129094242.282620-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
> Add header include guards to insn.h to prevent repeating declaration of
> any identifiers in insn.h.
> 
> Fixes: edde5584c7ab ("riscv: Add SW single-step support for KDB")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/include/asm/insn.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> index 25ef9c0b19e7..22c7613bfda3 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -3,6 +3,9 @@
>   * Copyright (C) 2020 SiFive
>   */
>  
> +#ifndef _ASM_RISCV_INSN_H
> +#define _ASM_RISCV_INSN_H
> +
>  #include <linux/bits.h>
>  
>  #define RV_INSN_FUNCT3_MASK	GENMASK(14, 12)
> @@ -365,3 +368,4 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
>  	*utype_insn |= (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);
>  	*itype_insn |= ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPOFF);
>  }
> +#endif /* _ASM_RISCV_INSN_H */
> -- 
> 2.25.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
