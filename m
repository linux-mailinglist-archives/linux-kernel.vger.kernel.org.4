Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7A6D4EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjDCR2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjDCR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:28:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A01BE3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:28:35 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jNynpkUGwB8bjjNyopm0fW; Mon, 03 Apr 2023 19:28:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1680542913;
        bh=5Np8023Y6FAt/94NM8u49tVSNsULJ4IHT6grFImpIW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=as3/9nh1jKYq0g3MGVyo9lUN2uMiXBM0L5xt++SqOqLzzQSfVoVGvMSKBBDUypyRZ
         E2s4pAePuf/px+rmHV5ViDQ6jBD0Q+EYsj6/F2fgdOG4zCT+qoMwT8wecoMjh+g1M2
         LrvAgfwDb2vgW1/WR64cZyysmPxae6YitJx74vtmYKwv/VVNAsRuWbasI0dD5zCbQU
         OK3tOJHGr+d7cZr3chHZPEl5saqEDoRWBSA6SgcqvnWyvykPRo+HnjMsM13MDn3FCf
         UeelKMtt4ik1qaGAoSfagDQtFr1FnxvnYjuvNyHeuDHtRa7zeV341oGj3c00ZV54jM
         JRKCVeje8gFyg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Apr 2023 19:28:33 +0200
X-ME-IP: 86.243.2.178
Message-ID: <9085c8bb-1419-9381-242f-98d8d5be5e8d@wanadoo.fr>
Date:   Mon, 3 Apr 2023 19:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] iio: accel: bmi088: Correctly compute the address of
 the struct spi_device
To:     Jonathan.Cameron@huawei.com, jic23@kernel.org, lars@metafoo.de,
        linus.walleij@linaro.org, mike.looijmans@topic.nl
Cc:     kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8da05ad95015e048e3058f275bd57d382420b46f.1680469082.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <8da05ad95015e048e3058f275bd57d382420b46f.1680469082.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/04/2023 à 22:58, Christophe JAILLET a écrit :
> bmi088_regmap_spi_write() is said to be similar to the SPI generic write
> function.
> However, regmap_spi_write() calls to_spi_device() in order to find the
> reference to the "struct spi_device", instead of considering that 'context'
> is already the correct value.

Just NACK.
The patch looks just plain wrong.

Sorry for the noise.

CJ


> 
> This works because "struct device	dev" is the first entry of
> "struct spi_device".
> 
> Align bmi088_regmap_spi_write() and regmap_spi_write() to be more
> future proof, should "struct spi_device" be shuffled one day.
> 
> Also update bmi088_regmap_spi_read() in the same way.
> 
> Fixes: c19ae6be7555 ("iio: accel: Add support for the Bosch-Sensortec BMI088")
> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> ---
> v2: do the same for bmi088_regmap_spi_read()
> ---
>   drivers/iio/accel/bmi088-accel-spi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index ee540edd8412..79e4b5392312 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -15,7 +15,8 @@
>   
>   static int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
>   {
> -	struct spi_device *spi = context;
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
>   
>   	/* Write register is same as generic SPI */
>   	return spi_write(spi, data, count);
> @@ -24,7 +25,8 @@ static int bmi088_regmap_spi_write(void *context, const void *data, size_t count
>   static int bmi088_regmap_spi_read(void *context, const void *reg,
>   				size_t reg_size, void *val, size_t val_size)
>   {
> -	struct spi_device *spi = context;
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
>   	u8 addr[2];
>   
>   	addr[0] = *(u8 *)reg;

