Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103895F6568
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJFLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:52:36 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9589938
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:52:35 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E56FA1244;
        Thu,  6 Oct 2022 13:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1665057154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZe/U/2fgPatLd94i7eLXrAEz+0HGRCtOhliaKB6zJ0=;
        b=GRfAMRSc2WqOBy6QcR0DJ4tjLdZYTTLVq0XZ7XTWKS5mhxx4NRPlI9PEGJKxPbF3BnsLHm
        4zpBICbXGn+X+vA6acySvyeKCEe/U+ZOzFo4UikoqKe50L8Z65JVKO1B85qiWrOAMIyelL
        QKrnkCMlEiyt08jLsRVLgVm2nPv/YSbixbOFViuwKfeVt8DgM5bG8UL/qUm+0afQDX8o4b
        bH3SWxt0dot+2i7QjUWTDjJywc5Oi/jaVTfaDsd4NvpWcBLT0EL1G+gchJ87H68KEWEy4p
        f1J0d9Ymw8Vqgk8/+CxIQ83sshm3sVaBd3+sfEbfyuzriQqZzl70GIyc1txX8A==
MIME-Version: 1.0
Date:   Thu, 06 Oct 2022 13:52:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     ~sircmpwn/email-test-drive@lists.sr.ht, patrick@stwcx.xyz,
        garnermic@fb.com, Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
In-Reply-To: <20221006070841.2106194-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20221006070841.2106194-1-Delphine_CC_Chiu@Wiwynn.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0dde4fa6ddeefa23314dbdcd1dd1b28b@walle.cc>
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

Hi,

Am 2022-10-06 09:08, schrieb Delphine CC Chiu:
> Add support for winbond w25q01jv-im chip.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index ffaa24055259..2b02b05ceb0a 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -139,6 +139,9 @@ static const struct flash_info winbond_nor_parts[] 
> = {
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "w25q01jv-im", INFO(0xef7021, 0, 64 * 1024, 2048)

The name should be w25q01jvm.

> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

That flash should support SFDP, so please try the following:
+	{ "w25q01jvm", INFO(0xef7021, 0, 0, 0) PARSE_SFDP },

Also, we require an SFDP dump for new flash submissions, see [1].

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
