Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2E7318D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFOMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbjFOMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:21:13 -0400
X-Greylist: delayed 635 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 05:19:26 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477253580;
        Thu, 15 Jun 2023 05:19:26 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AD4479F4;
        Thu, 15 Jun 2023 14:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686831539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Caj3WcHVhXv2orGAS3eW5p0U6TifL7MgYmHT2thsXY=;
        b=zeqVvJFr2EAj1fuB6oUIj/6PEbDQDew4ofZWxW4UM3mB8WsZlzMAr4y55a3nE8GYqd9c0Y
        Lft6AlIGpRxl+Oio0ZWRV951mmWmXdzuRYz1SbnT7Ws+k1te97Bna5/TI4oBCVGPsyvfqN
        OGXn34D27nvQ1gvvQwkuwItw52UYLro8d4oEhzkrkDQK+zvHz6lKsLrglo745Xbo5fwuVO
        Kth6/H8GjAMdoltgrkr9IOXrgZVkGwNB5McisG5eATfUi5OJEsqbKyURLmobLMoJV6yZLH
        Kr1bh2UDOwElBSnvFM+hPAIIxWTUCQW5h2JTHta2T7zu5ET2JZcKvhwWSoNKhA==
MIME-Version: 1.0
Date:   Thu, 15 Jun 2023 14:18:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP
 signal not connected
In-Reply-To: <20230615111649.36344-3-amit.kumar-mahapatra@amd.com>
References: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
 <20230615111649.36344-3-amit.kumar-mahapatra@amd.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fe5ebc619350c378a14e88275e5dab3b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-15 13:16, schrieb Amit Kumar Mahapatra:
> Setting the status register write disable (SRWD) bit in the status
> register (SR) with WP signal of the flash not connected will configure 
> the
> SR permanently as read-only. If WP signal is not connected, avoid 
> setting
> SRWD bit while writing the SR during flash protection.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 +++
>  drivers/mtd/spi-nor/core.h | 1 +
>  drivers/mtd/spi-nor/swp.c  | 5 +++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0bb0ad14a2fc..81b57c51f41c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2864,6 +2864,9 @@ static void spi_nor_init_flags(struct spi_nor 
> *nor)
>  	if (flags & NO_CHIP_ERASE)
>  		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
> 
> +	if (of_property_read_bool(np, "broken-wp"))
> +		nor->flags |= SNOR_F_BROKEN_WP;
> +
>  	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
>  	    !nor->controller_ops)
>  		nor->flags |= SNOR_F_RWW;
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 4fb5ff09c63a..6ac932eba913 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -132,6 +132,7 @@ enum spi_nor_option_flags {
>  	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
>  	SNOR_F_RWW		= BIT(14),
>  	SNOR_F_ECC		= BIT(15),
> +	SNOR_F_BROKEN_WP	= BIT(16),
>  };
> 
>  struct spi_nor_read_command {
> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
> index 0ba716e84377..074f3bce2034 100644
> --- a/drivers/mtd/spi-nor/swp.c
> +++ b/drivers/mtd/spi-nor/swp.c
> @@ -214,8 +214,9 @@ static int spi_nor_sr_lock(struct spi_nor *nor,
> loff_t ofs, uint64_t len)
> 
>  	status_new = (status_old & ~mask & ~tb_mask) | val;
> 
> -	/* Disallow further writes if WP pin is asserted */
> -	status_new |= SR_SRWD;
> +	/* Disallow further writes if WP pin is connected */

"is not broken" or similar. Maybe descibe what is broken.
Like I said, this might also be a valid use case.

Thinking more about this, maybe we should make this
configurable. I.e. make it possible to set the
locking region without disabling further writes. Although
I'm not sure how. Right now, we always enable both the
software and hardware write protection. (winbond distiguish
between software and hardware write protection here; software
here means not linux/kernel but just setting the protection
bits without the locking bit). And in the case WP# is tied
to low, one should not use the hardware write protection.

Although I'm not really sure, how to do that in a backwards
compatible way.

-michael
