Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181463FA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiLAWM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiLAWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:12:44 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D022BE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:12:42 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1EFA911C;
        Thu,  1 Dec 2022 23:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669932760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HyuiWb9CSRxQhFtA9qePcq+AZj4yl2L9uNfDxE/SMM=;
        b=vougSaIvKYcrIvIq5ZgHtUrJLns2tFLfJSfhDyUhdkvKCrxP5iZS9p+iqbZNQ7EtZaI+di
        qauQwLoJPdDOP1m6OrwRcitqIPCIcaNwh6GPUOT2fR0YEEpLygbZrDrSLC3+ddovUbGBAj
        yyR26PAF40hg//T446tym81mhDCheKNp/sIxWoTQc2v/PBPQ0JcwP9jvEixnKhs1VVIISf
        ufnAAIRn01k7i6xQ+jXTQjLLo9LNDpDJZlR87puxkq9ayX/rGuZflzMKI02zwaX+PKPxJe
        7XEK2KQDXXTXsdarmGUmjeeXeZkxn44QcOoKWq30UEB6GYurIWjID6yQjTUlnw==
MIME-Version: 1.0
Date:   Thu, 01 Dec 2022 23:12:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
In-Reply-To: <20221201212750.267721-4-nathan.morrison@timesys.com>
References: <20221201212750.267721-1-nathan.morrison@timesys.com>
 <20221201212750.267721-4-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3f51282076fb3e209aa4cae7bc0a4c46@walle.cc>
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

Am 2022-12-01 22:27, schrieb Nathan Barrett-Morrison:
> This adds the IS25LX256 chip into the ISSI flash_info parts table
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>  drivers/mtd/spi-nor/issi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 89a66a19d754..98cc5e1d9c18 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -74,6 +74,9 @@ static const struct flash_info issi_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
> +	{ "is25lx256", INFO(0x9d5a19, 0, 128 * 1024, 256)

Please use INFO(0x9d5a19, 0, 0, 0)

> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_4B_OPCODES |
> +			      SPI_NOR_OCTAL_READ_1_8_8) },

Neither of these flags should be needed. As mentioned before,
you'd need a fixups for the missing 1-1-8 and 1-8-8 fast read ops.

-michael
