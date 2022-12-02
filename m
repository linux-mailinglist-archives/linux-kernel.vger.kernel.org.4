Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2F64092F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiLBPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiLBPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:20:50 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759BB393D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:20:49 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B14B388;
        Fri,  2 Dec 2022 16:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669994447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwzgqDrqryim/NXtkdBjmmP6OU79ug3+PLqn4ekooRM=;
        b=sV4anxgk90bSg8dMdOUUaUopcb9+aNEeAq/Fpw5HR1ui7sUGqHoZwDC3QzsxEtFw5Op+G3
        1+UBIMsw53W2vx5VmXVv41STRsQQoG+YEFzeOmOcgWdfN2dCOR2j62hhO62rzkuPbh5jyE
        KfzPrsAS5vdSPJkohJxkK3x+54mEMdTSWN+1tQrUEZUaOGJm6XWio1hLhtK6cwEgEQA15A
        uP9MRtI3NM75QB1jrSDYQ8ZolqTbbVShGCsIA5ui+TVsRK1Neqm3C3t3p5j4hxcd32lAdn
        xOoYeL/wuKCKwapeEr8q2YHtslb90UmL3bokofYEY//Q0qp/wN+w82L+IfUxWw==
MIME-Version: 1.0
Date:   Fri, 02 Dec 2022 16:20:47 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
In-Reply-To: <20221202135539.271936-4-nathan.morrison@timesys.com>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-4-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fa6f089e529b649603db4cf7024ae59b@walle.cc>
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

Am 2022-12-02 14:55, schrieb Nathan Barrett-Morrison:
> This adds the IS25LX256 chip into the ISSI flash_info parts table
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>  drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 89a66a19d754..362bc3603d8f 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -29,6 +29,35 @@ static const struct spi_nor_fixups is25lp256_fixups 
> = {
>  	.post_bfpt = is25lp256_post_bfpt_fixups,
>  };
> 
> +static int
> +is25lx256_post_bfpt_fixups(struct spi_nor *nor,
> +			   const struct sfdp_parameter_header *bfpt_header,
> +			   const struct sfdp_bfpt *bfpt)
> +{
> +	/*
> +	 * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
> +	 * However, the BFPT does not contain any information denoting this
> +	 * functionality, so the proper fast read opcodes are never setup.
> +	 * We're correcting this issue via the fixup below.  Page program
> +	 * commands are detected and setup properly via the 4BAIT lookup.
> +	 */
> +	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> +	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
> +				  0, 8, SPINOR_OP_READ_1_1_8,
> +				  SNOR_PROTO_1_1_8);
> +
> +	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_8_8;
> +	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_8_8],
> +				  0, 16, SPINOR_OP_READ_1_8_8,
> +				  SNOR_PROTO_1_8_8);
> +
> +	return 0;
> +}
> +
> +static const struct spi_nor_fixups is25lx256_fixups = {
> +	.post_bfpt = is25lx256_post_bfpt_fixups,
> +};
> +
>  static void pm25lv_nor_late_init(struct spi_nor *nor)
>  {
>  	struct spi_nor_erase_map *map = &nor->params->erase_map;
> @@ -74,6 +103,9 @@ static const struct flash_info issi_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
> +	{ "is25lx256", INFO(0x9d5a19, 0, 0, 0)
> +		PARSE_SFDP
> +		.fixups = &is25lx256_fixups },

Very nice!

Subject is slightly wrong because you fix up the BFPT to get
correct 1-1-8 and 1-8-8 read modes.

With that fixed:
Reviewed-by: Michael Walle <michael@walle.cc>
