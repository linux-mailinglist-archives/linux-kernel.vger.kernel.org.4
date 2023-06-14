Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370BB72FDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjFNL7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbjFNL7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:59:18 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1C1FE5;
        Wed, 14 Jun 2023 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jmYeyK9Ewec8Bl9HsoUWfQccPt1bY7Wsl0n3D6SYDBo=; b=KbQS1U1iA6z42wFeCi1SsW1pUi
        zuaiHCGLMz/0OgYzjOT6Jw6VV7UfA6l0/JBCVreDr2JKz3+gPqhiup1QacvQNZPheQGEdgLKH2FR/
        jtqTAcpC7pW3zwYUpeeLYc5jukDRGh1ThZX7iFyFoo7hJwv+bptI7x5tZ+BpNzYriQMI18KB3WuwC
        X0s7kYUl4/MAblvWol/kbauyUvtDLG5bmxLyTYh8FYs3nkvjGTe9dBBuGAFID6UW4Udnty7tKf+/a
        HeClj6cuJ1gWHePYCS4R8RxqNq8mSXVDjsN73qONareoFgj5qPaHrmTVr6+xP3JOI8bpKk0Ye1b/a
        1Z/7gPJg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1q9P9X-000FGU-62; Wed, 14 Jun 2023 13:59:07 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1q9P9W-000U1u-NP; Wed, 14 Jun 2023 13:59:07 +0200
Message-ID: <dd0dd53c-2ac5-a3c0-69f3-a95994b6f486@metafoo.de>
Date:   Wed, 14 Jun 2023 04:59:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] iio: adc: add buffering support to the TI LMP92064 ADC
 driver
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230614075537.3525194-1-l.goehrs@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230614075537.3525194-1-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26939/Wed Jun 14 09:25:18 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 00:55, Leonard Göhrs wrote:
> Enable buffered reading of samples from the LMP92064 ADC.
> The main benefit of this change is being able to read out current and
> voltage measurements in a single transfer, allowing instantaneous power
> measurements.
>
> Reads into the buffer can be triggered by any software triggers, e.g.
> the iio-trig-hrtimer:
>
>      $ mkdir /sys/kernel/config/iio/triggers/hrtimer/my-trigger
>      $ cat /sys/bus/iio/devices/iio\:device3/name
>      lmp92064
>      $ iio_readdev -t my-trigger -b 16 iio:device3 | hexdump
>      WARNING: High-speed mode not enabled
>      0000000 0000 0176 0101 0001 5507 abd5 7645 1768
>      0000010 0000 016d 0101 0001 ee1e ac6b 7645 1768
>      ...
>
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>

Patch looks good. A small comment for an improvement, but not a most have.

> ---
>   drivers/iio/adc/ti-lmp92064.c | 54 +++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
> index c30ed824924f3..03765c4057dda 100644
> --- a/drivers/iio/adc/ti-lmp92064.c
> +++ b/drivers/iio/adc/ti-lmp92064.c
> @@ -16,7 +16,10 @@
>   #include <linux/spi/spi.h>
>   
>   #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>   #include <linux/iio/driver.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>   
>   #define TI_LMP92064_REG_CONFIG_A 0x0000
>   #define TI_LMP92064_REG_CONFIG_B 0x0001
> @@ -91,6 +94,13 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
>   		.address = TI_LMP92064_CHAN_INC,
>   		.info_mask_separate =
>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 0,
> +		},
>   		.datasheet_name = "INC",
>   	},
>   	{
> @@ -98,8 +108,16 @@ static const struct iio_chan_spec lmp92064_adc_channels[] = {
>   		.address = TI_LMP92064_CHAN_INV,
>   		.info_mask_separate =
>   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 0,
> +		},
>   		.datasheet_name = "INV",
>   	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>   };
>   
>   static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
> @@ -171,6 +189,37 @@ static int lmp92064_read_raw(struct iio_dev *indio_dev,
>   	}
>   }
>   
> +static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct lmp92064_adc_priv *priv = iio_priv(indio_dev);
> +	int i = 0, j, ret;
> +	u16 raw[2];
> +	u16 *data;
> +
> +	ret = lmp92064_read_meas(priv, raw);
> +	if (ret < 0)
> +		goto done;
> +
> +	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	if (!data)
> +		goto done;
If you want to avoid allocating the buffer each time a sample-set is 
captured you can register the `update_scan_mode` callback and allocate 
the buffer in there. Or if you know the upper limit of your buffer size, 
base on number of channels, and its small you can also use a one time 
allocation directly embedded in the priv struct.
> +
> +	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
> +		data[i++] = raw[j];
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +
> +	kfree(data);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
]...\
