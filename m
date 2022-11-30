Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C663D101
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiK3Ipq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiK3IpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:45:20 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012133F061
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:45:09 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4614F124D;
        Wed, 30 Nov 2022 09:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669797907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUiquKgXaXWZX/knROtvM3ke86lnOfB8epY4uKc9fSo=;
        b=kcA9YG/PY3aaR974uQrPVIQm2RuWkqhocmwaI0R2r4WgVXebIJ+el9mfHRwootzMo1m1Rm
        jkmTzK37heS+OmCQFGUBQMT5GC0oUNO/Xpr2c3HC9qznLD/0/jHFqWKX2mh300kLgprKjI
        4+tFDlX8xSMD9qvei46L0cP+/DDN3M9nUmtueWJ0Zxr2vv3Wm2mTpoT8EaymCTNn/74/6p
        wcZ2kCv6UWQnJJ/il/HKMPV1ip4Gv0GhIc7AX69FyooyCS+572NBszXSWqPFj59yr8QvLQ
        +5c75MqlQJVXbqrFhmo1CCVchkclyXArYOHzi+eFt9cQQypL6vGg4Q9EzOdYyw==
MIME-Version: 1.0
Date:   Wed, 30 Nov 2022 09:45:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: Add in support for IS25LX256 chip,
 operating in 1S-1S-8S mode.
In-Reply-To: <20221128172455.159787-1-nathan.morrison@timesys.com>
References: <20221128172455.159787-1-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2acae3be377a5d8c3df66f860d944dbb@walle.cc>
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

Am 2022-11-28 18:24, schrieb Nathan Barrett-Morrison:
> Adds the is25lx256 entry to the nor_parts table along with the 
> additional
> fixup logic to operate in 1S-1S-8S mode while programming.
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>  drivers/mtd/spi-nor/issi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 89a66a19d754..e9b32b726bf3 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -29,6 +29,21 @@ static const struct spi_nor_fixups is25lp256_fixups 
> = {
>  	.post_bfpt = is25lp256_post_bfpt_fixups,
>  };
> 
> +static void is25lx256_post_sfdp_fixup(struct spi_nor *nor)
> +{
> +	/* Fixup page program command to 1S-1S-8S */
> +	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_8;
> +	spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_1_1_8],
> +				SPINOR_OP_PP_1_1_8, SNOR_PROTO_1_1_8);

Does this flash have SFDP data? If possible, this should be
derived from that. Could you dump the SFDP table and
post it here [1].

> +
> +	/* Disable quad_enable */
> +	nor->params->quad_enable = NULL;

why?

> +}
> +
> +static struct spi_nor_fixups is25lx256_fixups = {
> +	.post_sfdp = is25lx256_post_sfdp_fixup,
> +};
> +
>  static void pm25lv_nor_late_init(struct spi_nor *nor)
>  {
>  	struct spi_nor_erase_map *map = &nor->params->erase_map;
> @@ -74,6 +89,10 @@ static const struct flash_info issi_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
> +	{ "is25lx256",  INFO(0x9d5a19, 0, 128 * 1024, 256)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
> +		.fixups = &is25lx256_fixups },
> 
>  	/* PMC */
>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2)

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
