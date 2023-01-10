Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3C664704
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjAJRH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjAJRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:07:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F135F9E;
        Tue, 10 Jan 2023 09:07:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nrxxc6h3Tz689yL;
        Wed, 11 Jan 2023 01:04:36 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 17:07:09 +0000
Date:   Tue, 10 Jan 2023 17:07:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Anup Sharma <anupnewsmail@gmail.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light : max44009 : Convert to i2c's .probe_new()
Message-ID: <20230110170708.00001054@huawei.com>
In-Reply-To: <Y72Py9i91MEYFzH2@yoga>
References: <Y72Py9i91MEYFzH2@yoga>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Tue, 10 Jan 2023 21:48:19 +0530
Anup Sharma <anupnewsmail@gmail.com> wrote:

> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
This driver didn't get converted due to a mess up by me when applying patches.
I've now picked up Uwe's original patch.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=22cd9320b11a2eb05e5d490863a4219ca32e8ec9

> ---
>  drivers/iio/light/max44009.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 801e5a0ad496..3dadace09fe2 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -487,8 +487,7 @@ static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
>  	return IRQ_NONE;
>  }
>  
> -static int max44009_probe(struct i2c_client *client,
> -			  const struct i2c_device_id *id)
> +static int max44009_probe(struct i2c_client *client)
>  {
>  	struct max44009_data *data;
>  	struct iio_dev *indio_dev;
> @@ -538,7 +537,7 @@ static struct i2c_driver max44009_driver = {
>  	.driver = {
>  		.name = MAX44009_DRV_NAME,
>  	},
> -	.probe = max44009_probe,
> +	.probe_new = max44009_probe,
>  	.id_table = max44009_id,
>  };
>  module_i2c_driver(max44009_driver);

