Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082667ECB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjA0RsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0RsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:48:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1DC93F6;
        Fri, 27 Jan 2023 09:47:59 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P3Q1q33SLz67Q6Z;
        Sat, 28 Jan 2023 01:44:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 17:47:57 +0000
Date:   Fri, 27 Jan 2023 17:47:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ian Ray <ian.ray@ge.com>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: adc: ltc2497: fix LSB shift
Message-ID: <20230127174756.00007299@Huawei.com>
In-Reply-To: <20230127125714.44608-1-ian.ray@ge.com>
References: <20230127125714.44608-1-ian.ray@ge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 14:57:14 +0200
Ian Ray <ian.ray@ge.com> wrote:

> Correct the "sub_lsb" shift for both ltc2497 and ltc2499.

Hi Iain, Thanks for the patch.

> 
> An earlier version of the code shifted by 14 but this was a consequence
> of reading three bytes into a __be32 buffer and using be32_to_cpu(), so
> eight extra bits needed to be skipped.  Now we use get_unaligned_be24()
> and thus the additional skip is wrong.
> 
> Fixes 2187cfe ("drivers: iio: adc: ltc2497: LTC2499 support")

This isn't in standard Fixes tag format.  If nothing else comes
up I'll fix up whilst applying.

> Signed-off-by: Ian Ray <ian.ray@ge.com>
> ---
>  drivers/iio/adc/ltc2497.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 17370c5..ec198c6 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -28,7 +28,6 @@ struct ltc2497_driverdata {
>  	struct ltc2497core_driverdata common_ddata;
>  	struct i2c_client *client;
>  	u32 recv_size;
> -	u32 sub_lsb;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> @@ -65,10 +64,10 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  		 * equivalent to a sign extension.
>  		 */
>  		if (st->recv_size == 3) {
> -			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
> +			*val = (get_unaligned_be24(st->data.d8) >> 6)
>  				- BIT(ddata->chip_info->resolution + 1);
>  		} else {
> -			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
> +			*val = (be32_to_cpu(st->data.d32) >> 6)
>  				- BIT(ddata->chip_info->resolution + 1);
>  		}
>  
> @@ -122,7 +121,6 @@ static int ltc2497_probe(struct i2c_client *client)
>  	st->common_ddata.chip_info = chip_info;
>  
>  	resolution = chip_info->resolution;
> -	st->sub_lsb = 31 - (resolution + 1);
>  	st->recv_size = BITS_TO_BYTES(resolution) + 1;
>  
>  	return ltc2497core_probe(dev, indio_dev);

