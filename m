Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B4744D2F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGBKJN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:09:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA01B0;
        Sun,  2 Jul 2023 03:09:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv4Sh5Djxz67qJT;
        Sun,  2 Jul 2023 18:05:56 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:09:07 +0100
Date:   Sun, 2 Jul 2023 18:09:03 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
CC:     <kernel@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: add buffering support to the TI LMP92064
 ADC driver
Message-ID: <20230702180903.00004a1a@Huawei.com>
In-Reply-To: <20230622065341.1100525-1-l.goehrs@pengutronix.de>
References: <20230622065341.1100525-1-l.goehrs@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 08:53:41 +0200
Leonard Göhrs <l.goehrs@pengutronix.de> wrote:

> Enable buffered reading of samples from the LMP92064 ADC.
> The main benefit of this change is being able to read out current and
> voltage measurements in a single transfer, allowing instantaneous power
> measurements.
> 
> Reads into the buffer can be triggered by any software triggers, e.g.
> the iio-trig-hrtimer:
> 
>     $ mkdir /sys/kernel/config/iio/triggers/hrtimer/my-trigger
>     $ cat /sys/bus/iio/devices/iio\:device3/name
>     lmp92064
>     $ iio_readdev -t my-trigger -b 16 iio:device3 | hexdump
>     WARNING: High-speed mode not enabled
>     0000000 0000 0176 0101 0001 5507 abd5 7645 1768
>     0000010 0000 016d 0101 0001 ee1e ac6b 7645 1768
>     ...
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>

A minor follow up comment inline.

>  static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
> @@ -171,6 +192,29 @@ static int lmp92064_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
> +	struct {
> +		u16 values[2];
> +		int64_t timestamp;
> +	} data;
> +	int ret;
> +
> +	ret = lmp92064_read_meas(priv, data.values);
> +	if (ret >= 0) {
Even thought it's more code, in IIO at least we tend to prefer to handle
errors out of line

	if (ret) 
		goto err;
	
	iio_push_to_buffers....


err:
	iio_trigger_notify_done()

	return IRQ_HANDLED;

Also, read_meas doesn't return > 0 which is implied by the above check.

> +		/* Only push values if the read succeeded */
> +		iio_push_to_buffers_with_timestamp(indio_dev, &data,
> +						   iio_get_time_ns(indio_dev));
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +

