Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC373F455
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF0GPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjF0GPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:15:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920831BFB;
        Mon, 26 Jun 2023 23:15:00 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E256850B;
        Tue, 27 Jun 2023 08:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1687846497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvmboR1BMviOSQ7PsVkhSOxfTc1VG5c3nYyF5muyxD0=;
        b=EE1kURunazGQ1GVYw9yAX4tHHZaKj/eZzng78T1g3a4vD2YUolfM6OgJSTUKGvG0iV+Urw
        7YmVVweu87mPvKniop95Bec6euXwvGdTPaIwWiyPR6GMNPYVXuSobppkVnJLRfnhNUAcMB
        wLraEhPRd68gTgv+9a4jNkQqU250fgAAPuh2GLdHe4qCEMGQEKiYWk94w5/iema9p7e//w
        18HVbfKPfh2TEDtrFeqUYx6Z3S+sL3Z9EtR6J5CXc41fzytvUWCminuvAA9FFADiFMW4ET
        JK86a0tu6gx7+GynYtX3/SlLvl8Y7A5SJl7aJnoi8q2Qa6F/In/POuEHUX05uQ==
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 08:14:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP#
 signal not connected
In-Reply-To: <20230625100251.31589-3-amit.kumar-mahapatra@amd.com>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-3-amit.kumar-mahapatra@amd.com>
Message-ID: <5e5fe22aebe17da4f9ad2c4eaaa8985f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-25 12:02, schrieb Amit Kumar Mahapatra:
> Setting the status register write disable (SRWD) bit in the status
> register (SR) with WP# signal of the flash left floating or wrongly 
> tied to
> GND (that includes internal pull-downs), will configure the SR 
> permanently
> as read-only. If WP# signal is left floating or wrongly tied to GND, 
> avoid
> setting SRWD bit while writing the SR during flash protection.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 +++
>  drivers/mtd/spi-nor/core.h | 1 +
>  drivers/mtd/spi-nor/swp.c  | 9 +++++++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0bb0ad14a2fc..520f5ab86d2b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2864,6 +2864,9 @@ static void spi_nor_init_flags(struct spi_nor 
> *nor)
>  	if (flags & NO_CHIP_ERASE)
>  		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
> 
> +	if (of_property_read_bool(np, "no-wp"))
> +		nor->flags |= SNOR_F_NO_WP;
> +

Please put it below the of_property_read_bool() which is already
there, just to keep things sorted.

>  	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
>  	    !nor->controller_ops)
>  		nor->flags |= SNOR_F_RWW;
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 4fb5ff09c63a..55b5e7abce6e 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -132,6 +132,7 @@ enum spi_nor_option_flags {
>  	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
>  	SNOR_F_RWW		= BIT(14),
>  	SNOR_F_ECC		= BIT(15),
> +	SNOR_F_NO_WP		= BIT(16),

See the comment right above this enum :/

>  };
> 
>  struct spi_nor_read_command {
> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
> index 0ba716e84377..cfaba41d74d6 100644
> --- a/drivers/mtd/spi-nor/swp.c
> +++ b/drivers/mtd/spi-nor/swp.c
> @@ -214,8 +214,13 @@ static int spi_nor_sr_lock(struct spi_nor *nor, 
> loff_t ofs, uint64_t len)
> 
>  	status_new = (status_old & ~mask & ~tb_mask) | val;
> 
> -	/* Disallow further writes if WP pin is asserted */
> -	status_new |= SR_SRWD;
> +	/*
> +	 * Disallow further writes if WP# pin is neither left floating nor
> +	 * wrongly tied to GND(that includes internal pull-downs).

nit: space missing

Otherwise looks good.

Thanks,
-michael

> +	 * WP# pin hard strapped to GND can be a valid use case.
> +	 */
> +	if (!(nor->flags & SNOR_F_NO_WP))
> +		status_new |= SR_SRWD;
> 
>  	if (!use_top)
>  		status_new |= tb_mask;
