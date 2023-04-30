Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D16F29FE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjD3R0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjD3R0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:26:18 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D626AD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 10:26:14 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id tAoLpfGTXV1EUtAoLpsODA; Sun, 30 Apr 2023 19:26:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682875572;
        bh=Ff9zLIel8IkcYw54eNME8HFBBN/fErD49ahKsmeOXpk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YN8IWWnZR20YHKSoKyGtLlVnpeVWliXD1bnewgdefXmWjpFtNrIXM7QLFcY3zp+fQ
         2wOFv94Mhf82yEqo3wwGsF8yiMhvHuJcq+WsFpqfqSM5T3XCA6SfQirCK04+kTDT/N
         KHMq7HgHiWA3dpFrF3RSip2YHKvQabDu41HqwMA6PiOB1sBQo0gc2L1AP4F73XQlCJ
         NesSxS0QLda6jGOJTIZcPdRhXNTQtRgzyXfCHGyDiD8zwctzOv1WXTZdAiLd7Gk2in
         MBsOA4ukU9cnwXCmuWBGCumQyZmrVksDCXYwz4c2k6uF4pgv2fGs++NYopcf0kVhfu
         7CghrtJiRaKjA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Apr 2023 19:26:12 +0200
X-ME-IP: 86.243.2.178
Message-ID: <2d11fffd-efa5-9922-fd89-9e7246195f66@wanadoo.fr>
Date:   Sun, 30 Apr 2023 19:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
Content-Language: fr, en-AU
To:     Frank Li <Frank.Li@nxp.com>
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        imx@lists.linux.dev, jdelvare@suse.de, jic23@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, petrm@nvidia.com, pn@denx.de,
        u.kleine-koenig@pengutronix.de
References: <20230427213038.1375404-1-Frank.Li@nxp.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230427213038.1375404-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/04/2023 à 23:30, Frank Li a écrit :
> VCNL4035 register(0xE) ID_L and ID_M define as:
> 
>   ID_L: 0x80
>   ID_H: 7:6 (0:0)
>         5:4 (0:0) slave address = 0x60 (7-bit)
>             (0:1) slave address = 0x51 (7-bit)
>             (1:0) slave address = 0x40 (7-bit)
>             (1:0) slave address = 0x41 (7-bit)
>         3:0 Version code default	(0:0:0:0)
> 
> So just check ID_L.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> 
> Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc@public.gmane.org>
> ---
>   drivers/iio/light/vcnl4035.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 3ed37f6057fb..8b7769930f3b 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -413,7 +413,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
>   		return ret;
>   	}
>   
> -	if (id != VCNL4035_DEV_ID_VAL) {
> +	if ((id & 0xff) != VCNL4035_DEV_ID_VAL) {
>   		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
>   			id, VCNL4035_DEV_ID_VAL);

Hi,
should the error message be updated as well?

Cj

>   		return -ENODEV;

