Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7B69F722
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjBVOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjBVOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:51:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89D3C7BA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:50:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so6100931eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyGJcM/CNYvxVDjRCxgWwJCXDNBvesm1g6l5GuMQqYI=;
        b=uVCabMD3nUeKBlq607KTwdWZCTtyG2226qHGszeCUD4k5oF67RX8d8G6AdJVTdopAu
         mcS/MsdkJ1+1uBgq5w+Pr6aM1cyVH/aI+4MkzcgG7QlloQjU/oeCQjST9bxOl62XuGLl
         RYrbXHbfw/PsgCvq4lADzLPrz8B8zur3FkrkXCfOoqVheuRfr/his2Sron2TLRQ16Uqc
         eYceDypckN6AnmJwB4K5VGdj7NS+jcTywNE2G42F+yAcnWEBLhWz6BbB3FzlmcUlKPh8
         E2VaOknSRWp9tcQtYZv9w/0dQCuCtfeDNF5lz/PEXWbncKXlA5YrjnW8vZMZDpQXrLFp
         iXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyGJcM/CNYvxVDjRCxgWwJCXDNBvesm1g6l5GuMQqYI=;
        b=cHORQCFkcHQmY+IZ4oIkNxm0TpSIh/NZo1HJW00u5jvzQb80lAlmU8mF2T9lETv88N
         gpWFEzb8hOWwwNHYe1phMHU5NCOyrvVMtMGOWePQ2wyQJEGoIdQxeetbmQwmeOUMrCdj
         oFeAE1WsQqavPY+QUcEMFJiBzdwBGx4e+vRn6KTLikJRpiyF3Nt3NBF+rIXqPmexjvz4
         ZNxhtHo+SMDFo51mWzj3w/9+oN9LmSHQ208jjnTb395CMoNXtwvkMN+bgRB0a8AO1eMT
         6qx2NmkOTSqGvl7meUJJ5bMa2DTkS0N8nqc3oFOP9n7kr+RIjmdivYctd9Jjy4vw3kfp
         k2kg==
X-Gm-Message-State: AO0yUKU0jkVBApYAXsrw7apa8JJPtJJBzR7wKjMQAMjur5RJG8VoDowe
        OTPDr81YiHvU+EYyFAU/+iJuLw==
X-Google-Smtp-Source: AK7set9K8rHF8R28ZBg/MGbro/2Anb89o6p8DNRcxlldZn2zsldpgxzumJ+25sW15VyUtq16CZbrdQ==
X-Received: by 2002:a17:906:c7ce:b0:87b:dac0:b23b with SMTP id dc14-20020a170906c7ce00b0087bdac0b23bmr17096543ejb.55.1677077444345;
        Wed, 22 Feb 2023 06:50:44 -0800 (PST)
Received: from [192.168.0.109] ([82.77.80.204])
        by smtp.gmail.com with ESMTPSA id gw20-20020a170906f15400b008ea5f4fab5fsm256953ejb.145.2023.02.22.06.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:50:43 -0800 (PST)
Message-ID: <d87efbd8-5290-b462-beb3-c2d3be267ade@linaro.org>
Date:   Wed, 22 Feb 2023 14:50:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mtd: spi-nor: fix shift-out-of-bounds in
 spi_nor_set_erase_type()
Content-Language: en-US
To:     Andrea Righi <andrea.righi@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230221111346.34268-1-andrea.righi@canonical.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230221111346.34268-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should be fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=f0f0cfdc3a024e21161714f2e05f0df3b84d42ad

Which base did you use?

Cheers,
ta

On 2/21/23 11:13, Andrea Righi wrote:
> It seems that according to JEDEC JESD216B Standard erase size needs to
> be a power of 2, but sometimes we set the size to 0 (e.g., in
> spi_nor_parse_4bait()) causing UBSAN warnings like the following:
> 
>    UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2026:24
>    shift exponent 4294967295 is too large for 32-bit type 'int'
>    Hardware name: Dell Inc. XPS 13 9300/077Y9N, BIOS 1.11.0 03/22/2022
>    Call Trace:
>     <TASK>
>     show_stack+0x4e/0x61
>     dump_stack_lvl+0x4a/0x6f
>     dump_stack+0x10/0x18
>     ubsan_epilogue+0x9/0x3a
>     __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
>     spi_nor_set_erase_type.cold+0x16/0x1e [spi_nor]
>     spi_nor_parse_4bait+0x270/0x380 [spi_nor]
>     spi_nor_parse_sfdp+0x47f/0x610 [spi_nor]
> 
> Fix by checking if size is a power when setting struct
> spi_nor_erase_type, otherwise consider size, mask and shift as invalid.
> 
> Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>   drivers/mtd/spi-nor/core.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d67c926bca8b..3c5b5bf9cbd1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2019,11 +2019,17 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
>   void spi_nor_set_erase_type(struct spi_nor_erase_type *erase, u32 size,
>   			    u8 opcode)
>   {
> -	erase->size = size;
>   	erase->opcode = opcode;
>   	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> -	erase->size_shift = ffs(erase->size) - 1;
> -	erase->size_mask = (1 << erase->size_shift) - 1;
> +	if (likely(is_power_of_2(size))) {
> +		erase->size = size;
> +		erase->size_shift = ffs(erase->size) - 1;
> +		erase->size_mask = (1 << erase->size_shift) - 1;
> +	} else {
> +		erase->size = 0u;
> +		erase->size_shift = ~0u;
> +		erase->size_mask = ~0u;
> +	}
>   }
>   
>   /**
