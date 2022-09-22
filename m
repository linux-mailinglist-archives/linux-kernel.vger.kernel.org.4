Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B525E64F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIVOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:19:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63BF312B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:19:21 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9F2711D4A;
        Thu, 22 Sep 2022 16:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663856359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AauVWltcSpfrIG4GiR/ILpgSYrrVzj7d64kjUXfFDp0=;
        b=0KcVU38HiTtBViW2cgpNdonzzwPAsMjeKN2HGf++0HHEPjtquMr5PwCSDR1muiRNiIegFV
        LagLGb10JN2a4BoOgA4dgTf0jPceHX9zM2Km/vaSmwmj9Cp6s5n5tlQitqk/ZqtSJOkPjc
        bCj3L3NgdgnOqL1VOnb3gLIDYxlKHWQA4OXzU2d1o6tD3mS8FELjwFi/EIfDm3wjIrf71j
        6oun+jjlnN5061w3XRcERDTq4/eN/4HADUJnlSO7GpV7Zpj+tIKj0tezV1lUQtEbJfBFIT
        rJew8M5eLnznPubdm4J5NHE3fKsfp6s+wdOFWqWWrFPjM2mbVS+PPR0mGO38ow==
MIME-Version: 1.0
Date:   Thu, 22 Sep 2022 16:19:19 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on
 SFDP
In-Reply-To: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1b62d0d80d3680e94172149946c936a0@walle.cc>
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

Am 2022-09-20 20:48, schrieb Sudip Mukherjee:
> The datasheet of is25wp256 says it supports SFDP. Get rid of the static
> initialization of the flash parameters and init them when parsing SFDP.
> 
> Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
> SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
> After this patch, it parses the SFDP information and still uses the
> same opcodes.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
> 
> No change from v2, just resending again with the next patch.
> Results from the tests given by Tudor in the following mail.
> 
> 
>  drivers/mtd/spi-nor/issi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index 89a66a19d754f..8b48459b5054c 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)

I'm curious, does it also work with:
   	{ "is25wp256", INFO(0x9d7019, 0, 0, 0)
		PARSE_SFDP
-michael

> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +		PARSE_SFDP
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
