Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F563FA50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiLAWIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLAWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:08:46 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA74421BD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:08:44 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6063811C;
        Thu,  1 Dec 2022 23:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669932522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCoKb4GGFgwOloHgPPyLK39clFt7P0eA0h+X5bcYVQY=;
        b=WPQXKu+uq7XQ+WmL/YQWOO1lBsrRZDdiVn0jwZaAIisQpB558jnb6+InWVM6UqnEz2yIeO
        SvEEnER0haqoGklkh/KEiXOJAKUG9ErM2zfKvGGIpbJUgGwNlCFJ1osGj7wzQkE7bnKo+3
        TAR7ZeQYrkUfy9K6slBElIyuV+7saTPTgup1u4QzohAt3gRuowN4RahXBtXxgwLr8JV6l4
        tDzRLcLq9NhJW6sxBTzEcQDu4NRsvfIAv5L2OrdOnf2W68XCzcxEBjGCEcWhNI+zhLpfha
        x9dGoq998agypYDG/jXpEpDCNVB23l0MEDn1iAXXohyq9AwvJa+zcrPZbNlVMg==
MIME-Version: 1.0
Date:   Thu, 01 Dec 2022 23:08:42 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: Add additional octal-mode flags to
 be checked during SFDP
In-Reply-To: <20221201212750.267721-3-nathan.morrison@timesys.com>
References: <20221201212750.267721-1-nathan.morrison@timesys.com>
 <20221201212750.267721-3-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0537b888aa4e6b7ce4194e8242a231fd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[In general, please post new versions after a reasonable
amount of time for reviews. Like a day or so.]

Am 2022-12-01 22:27, schrieb Nathan Barrett-Morrison:
> This adds some support for searching a chips SFDP table for:
> 
> read commands: 1S-8S-8S
> program commands: 1S-1S-8S, 1S-8S-8S
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>  drivers/mtd/spi-nor/core.c | 8 ++++++++
>  drivers/mtd/spi-nor/core.h | 5 +++--
>  drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index bee8fc4c9f07..2f882608abc6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2359,6 +2359,13 @@ static void spi_nor_no_sfdp_init_params(struct
> spi_nor *nor)
>  					  SNOR_PROTO_1_1_8);
>  	}
> 
> +	if (no_sfdp_flags & SPI_NOR_OCTAL_READ_1_8_8) {
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
> +					  0, 16, SPINOR_OP_READ_1_8_8,
> +					  SNOR_PROTO_1_8_8);
> +	}

This should only be done for flashes which doesn't support
SFDP at all (see the comment for spi_nor_no_sfdp_init_params()).

Yours supports SFDP, has the correct flags in the
4BAIT table but doesn't have the 17th DWORD in the BFPT. I'm not
sure if this is correct or if it's a mistake in the SFDP of this
flash device.

If it's correct, we would need to somehow call
spi_nor_set_read_settings() in sfdp.c; but we don't know the
mode or wait clocks. If it's a mistake in the SFDP, we'd need
to add a fixup for this particular flash which sets the read
settings. I'd go with the second because we just haven't enough
information.

-michael

> +
>  	if (no_sfdp_flags & SPI_NOR_OCTAL_DTR_READ) {
>  		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
>  		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
> @@ -2514,6 +2521,7 @@ static void
> spi_nor_init_params_deprecated(struct spi_nor *nor)
>  	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
>  					SPI_NOR_QUAD_READ |
>  					SPI_NOR_OCTAL_READ |
> +					SPI_NOR_OCTAL_READ_1_8_8 |
>  					SPI_NOR_OCTAL_DTR_READ))
>  		spi_nor_sfdp_init_params_deprecated(nor);
>  }
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 85b0cf254e97..7bc1cde049b7 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -514,8 +514,9 @@ struct flash_info {
>  #define SPI_NOR_DUAL_READ		BIT(3)
>  #define SPI_NOR_QUAD_READ		BIT(4)
>  #define SPI_NOR_OCTAL_READ		BIT(5)
> -#define SPI_NOR_OCTAL_DTR_READ		BIT(6)
> -#define SPI_NOR_OCTAL_DTR_PP		BIT(7)
> +#define SPI_NOR_OCTAL_READ_1_8_8	BIT(6)
> +#define SPI_NOR_OCTAL_DTR_READ		BIT(7)
> +#define SPI_NOR_OCTAL_DTR_PP		BIT(8)
> 
>  	u8 fixup_flags;
>  #define SPI_NOR_4B_OPCODES		BIT(0)
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index e4e87815ba94..e1b7547bf81e 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -1089,6 +1089,14 @@ static int spi_nor_parse_4bait(struct spi_nor 
> *nor,
>  		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
>  					SPINOR_OP_PP_1_4_4_4B,
>  					SNOR_PROTO_1_4_4);
> +	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_8)
> +		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_8],
> +					SPINOR_OP_PP_1_1_8_4B,
> +					SNOR_PROTO_1_1_8);
> +	if (pp_hwcaps & SNOR_HWCAPS_PP_1_8_8)
> +		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_8_8],
> +					SPINOR_OP_PP_1_8_8_4B,
> +					SNOR_PROTO_1_8_8);
> 
>  	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
>  		if (erase_mask & BIT(i))
