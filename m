Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A66EBAB8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDVRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B801FD8;
        Sat, 22 Apr 2023 10:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0119F60F75;
        Sat, 22 Apr 2023 17:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515EC433D2;
        Sat, 22 Apr 2023 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682184677;
        bh=hgoRS/yWzeoZruLFwSsdMe9K0VREpno3tr/ydZmBT4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BfJTqDUR/ZpLMUEzxeRqw9I5BGCYvaAFJPzR20Bcpao13r7wuHM2dbFP7h6XZYnRl
         EGfeBjIPbpIFQKuWfH/MTyif75TZ2QFA2NdWsV7nJ82harQJZHi7vopNcTp3StVzx0
         jR5LOKOnbCS7b4krEJRfF/ECMypOoz64y3Lqs1G6wXYPCT3BFXwK+KJn+LWSZIYP0v
         jbB6xRs9RgcVaLGYJhuEM5782UYe/Iu4FjzZLFHIiBIu0EyMGEglsl4GL1FwAbBo8G
         YzIg83kAGJ7D4Pm6lzshfGKbV1ciO9fZFYOMFYjqlScOnhXNGg3ofYLbm1lU6INs5C
         cM56/WclZXF8A==
Date:   Sat, 22 Apr 2023 18:46:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <20230422184653.7ae28d5a@jic23-huawei>
In-Reply-To: <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
        <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 22:22:04 +0200
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.
> Move the driver's private data to the header file to support the new function.
> Make the allocation of the "buffer" array in the fifo_flush function dynamic
> and more generic.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

This results in some fifo_length changes in here and some in the previous patch.
Either keep it fixed for first patch, then make those changes and the ones you have
here in a single patch, or if that's hard maybe a single patch is cleaner.

I'd only expect the stuff about bytes in buffer to be in this patch.

Jonathan



> ---
> v2:
> - separated this change from the chip_info introduction and made it a patch in v2 
> - changed the function from generic implementation for to device-specific one
> - removed blank lines pointed out by checkpatch
> - changed the allocation of the "buffer" array in __kx022a_fifo_flush
> 
>  drivers/iio/accel/kionix-kx022a.c | 72 +++++++++++++------------------
>  drivers/iio/accel/kionix-kx022a.h | 37 ++++++++++++++++
>  2 files changed, 66 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 7f9a2c29790b..1c81ea1657b9 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -150,36 +150,6 @@ static const struct regmap_config kx022a_regmap_config = {
>  	.cache_type = REGCACHE_RBTREE,
>  };
>  
> -struct kx022a_data {
> -	struct regmap *regmap;
> -	struct iio_trigger *trig;
> -	struct device *dev;
> -	struct iio_mount_matrix orientation;
> -	int64_t timestamp, old_timestamp;
> -
> -	int irq;
> -	int inc_reg;
> -	int ien_reg;
> -
> -	unsigned int state;
> -	unsigned int odr_ns;
> -
> -	bool trigger_enabled;
> -	/*
> -	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> -	 * middle of a configuration, or when the fifo is enabled. Also,
> -	 * protect the data stored/retrieved from this structure from
> -	 * concurrent accesses.
> -	 */
> -	struct mutex mutex;
> -	u8 watermark;
> -
> -	/* 3 x 16bit accel data + timestamp */
> -	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> -	struct {
> -		__le16 channels[3];
> -		s64 ts __aligned(8);
> -	} scan;
>  };
>  
>  static const struct iio_mount_matrix *
> @@ -340,7 +310,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
>  		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
>  
>  	return ret;
> -

Grumpy maintainer hat on:  I don't want to see white space changes in unrelated code
in a patch doing anything other than white space cleanup.

>  }
>  
>  static int kx022a_turn_off_lock(struct kx022a_data *data)
> @@ -595,34 +564,50 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>  	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
>  }
> 


>  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  			       bool irq)
>  {
>  	struct kx022a_data *data = iio_priv(idev);
> -	struct device *dev = regmap_get_device(data->regmap);
> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> +	__le16 *buffer;
>  	uint64_t sample_period;
>  	int count, fifo_bytes;
>  	bool renable = false;
>  	int64_t tstamp;
>  	int ret, i;
>  
> -	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> -	if (ret) {
> -		dev_err(dev, "Error reading buffer status\n");
> -		return ret;
> -	}
> +	/* 3 axis, 2 bytes of data for each of the axis */
> +	buffer = kmalloc(data->chip_info->fifo_length * 6, GFP_KERNEL);

Split that 6 up into sizeof(*buffer) * 3 
Then just comment on 3 axis.  Or use a define for number of axis and drop the
comment entirely.

Also, this feels like it fitst better in previous patch.


> +	if (!buffer)
> +		return -ENOMEM;
>  
> -	/* Let's not overflow if we for some reason get bogus value from i2c */
> -	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> -		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> +	fifo_bytes = data->chip_info->get_fifo_bytes(data);

Only this small part is what this patch claims to do.. (+ the callback of course).


>  
>  	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
>  		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
>  
>  	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> -	if (!count)
> +	if (!count) {
> +		kfree(buffer);
>  		return 0;
> +	}
>  
>  	/*
>  	 * If we are being called from IRQ handler we know the stored timestamp
> @@ -704,6 +689,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
>  	if (renable)
>  		enable_irq(data->irq);
>  
> +	kfree(buffer);
>  	return ret;
>  }
>  
> @@ -1016,6 +1002,7 @@ const struct kx022a_chip_info kx022a_chip_info = {
>  	.inc5		  = KX022A_REG_INC5,
>  	.inc6		  = KX022A_REG_INC6,
>  	.xout_l		  = KX022A_REG_XOUT_L,
> +	.get_fifo_bytes	  = kx022a_get_fifo_bytes,
>  };
>  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
>  
> @@ -1143,7 +1130,6 @@ int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chi
>  	if (ret)
>  		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>  
> -

Another one.  If those predate your series, feel free to clean them up either
at the start or end of this series.


>  	ret = devm_iio_trigger_register(dev, indio_trig);
>  	if (ret)
>  		return dev_err_probe(data->dev, ret,
> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> index 3c31e7d88f78..43e32e688258 100644
> --- a/drivers/iio/accel/kionix-kx022a.h
> +++ b/drivers/iio/accel/kionix-kx022a.h
> @@ -11,6 +11,8 @@
>  #include <linux/bits.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/iio.h>
> +
>  #define KX022A_REG_WHO		0x0f
>  #define KX022A_ID		0xc8
>  
> @@ -76,6 +78,39 @@
>  
>  struct device;
>  
> +struct kx022a_data {
> +	const struct kx022a_chip_info *chip_info;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct device *dev;
> +	struct iio_mount_matrix orientation;
> +	int64_t timestamp, old_timestamp;
> +
> +	int irq;
> +	int inc_reg;
> +	int ien_reg;
> +
> +	unsigned int state;
> +	unsigned int odr_ns;
> +
> +	bool trigger_enabled;
> +	/*
> +	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
> +	 * middle of a configuration, or when the fifo is enabled. Also,
> +	 * protect the data stored/retrieved from this structure from
> +	 * concurrent accesses.
> +	 */
> +	struct mutex mutex;
> +	u8 watermark;
> +
> +	/* 3 x 16bit accel data + timestamp */
> +	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +};
> +
>  /**
>   * struct kx022a_chip_info - Kionix accelerometer chip specific information
>   *
> @@ -100,6 +135,7 @@ struct device;
>   * @inc5:		interrupt control register 5
>   * @inc6:		interrupt control register 6
>   * @xout_l:		x-axis output least significant byte
> + * @get_fifo_bytes:	function pointer to get number of bytes in the FIFO buffer
>   */
>  struct kx022a_chip_info {
>  	const char *name;
> @@ -123,6 +159,7 @@ struct kx022a_chip_info {
>  	u8 inc5;
>  	u8 inc6;
>  	u8 xout_l;
> +	int (*get_fifo_bytes)(struct kx022a_data *);
>  };
>  
>  int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);

