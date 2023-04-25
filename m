Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E366EDC64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjDYHYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDYHYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:24:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACDF93F6;
        Tue, 25 Apr 2023 00:24:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-95316faa3a8so1001258166b.2;
        Tue, 25 Apr 2023 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682407451; x=1684999451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lGD3IbluNSS6nqLoy9ilpoHVWHy0mRWF17/iGSUXE4=;
        b=jdz7J+hnZeRhBeUa7UYzoWpEfn9qbXp6XSCFGJRIuAv3y9EPwVLc2QcRcW0o8JCmXb
         xUEpUsY9HQwocB5j4/Z4hZKHh9DxCHYOBUJJGWQ6HsJUjYDdC3H7bVx1WEkY1jgCE0pX
         IKsNo4CPUBXACfQ96CMya2TXrZdn4vRhRghzQRqiheE+SP7N8fIue6cSVdArq/y0gGxh
         5KD+O+b8ALYAdzZxLvG1pTFnyDHTrzUIAEpOWIemi+GocFOI8KRVZ33A3f7br9PjbKVC
         r92QA1CkGExpMtaaYNmPKlkIUFCY5CDZDVMHfSNzhFS4k3t/Iq3ov9N3tBHHq/hKZ1so
         bo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682407451; x=1684999451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lGD3IbluNSS6nqLoy9ilpoHVWHy0mRWF17/iGSUXE4=;
        b=RN4YtgNhkpp1SZbdXffjUPZQTGvBOuXZt098vrhtLxEDHC7z4hN98vT+mQEkWxtX5h
         v75X/vJWjMYXD7vHQZlA/INnm4H3asxt6+PsPSs4gFB4xiTqw4bu6NN2E52olRGNSAqI
         NV/ESZOX/1kIKDazypn1XZ3f/oM7c/KhN2fftRr3YjkOnvByGz1QtOqAWQ1PPJdyq6op
         Esh2B5NiQkR4qMwcGXJLLenr9mNXDrrVYS3HEsfdMpxu5xBwvbifiPFc91kLDUODAyg9
         eP1iuE/BD6nU6Rv5k+mq1C3ZZcl2xCr7hWuFAV8Fi2xRLz3eRwFa6BGdU5vWJaQSRoEA
         kCIA==
X-Gm-Message-State: AAQBX9f+blMSrvnTXXH0OrlxEg321eowA97ooJcOEjUKUQASyF1EINoX
        8g1Noh1tSDWs+lxmD/deMBuNiI26khM=
X-Google-Smtp-Source: AKy350ZfMbn3VrV0me7KXZqmGHgWa0EpNAGwyCdSQL+kUzAPWaTA+DA33zsHJInPC5Fzx/KlKZqdCQ==
X-Received: by 2002:a17:906:2e9b:b0:94f:a309:67b7 with SMTP id o27-20020a1709062e9b00b0094fa30967b7mr12505675eji.56.1682407450817;
        Tue, 25 Apr 2023 00:24:10 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::2d16])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906338f00b0094c3ac3c2bbsm6414511eja.212.2023.04.25.00.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 00:24:10 -0700 (PDT)
Date:   Tue, 25 Apr 2023 09:24:08 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZEeAGN3TBcao3CNA@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Tue, Apr 25, 2023 at 09:50:11AM +0300, Matti Vaittinen wrote:
> On 4/25/23 01:22, Mehdi Djait wrote:
> > Add the chip_info structure to the driver's private data to hold all
> > the device specific infos.
> > Refactor the kx022a driver implementation to make it more generic and
> > extensible.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v3:
> > - added the change of the buffer's allocation in the __kx022a_fifo_flush
> >    to this patch
> > - added the chip_info to the struct kx022a_data
> > 
> > v2:
> > - mentioned the introduction of the i2c_device_id table in the commit
> > - get i2c_/spi_get_device_id only when device get match fails
> > - removed the generic KX_define
> > - removed the kx022a_device_type enum
> > - added comments for the chip_info struct elements
> > - fixed errors pointed out by the kernel test robot
> > 
> >   drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
> >   drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
> >   drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
> >   drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
> >   4 files changed, 147 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> > index 8f23631a1fd3..ce299d0446f7 100644
> > --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> > +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> > @@ -15,6 +15,7 @@
> 
> ...
> 
> 
> >   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> > @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   {
> >   	struct kx022a_data *data = iio_priv(idev);
> >   	struct device *dev = regmap_get_device(data->regmap);
> > -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> > +	__le16 *buffer;
> >   	uint64_t sample_period;
> >   	int count, fifo_bytes;
> >   	bool renable = false;
> >   	int64_t tstamp;
> >   	int ret, i;
> > +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> > +	if (!buffer)
> > +		return -ENOMEM;
> 
> Do you think we could get rid of allocating and freeing the buffer for each
> flush? I feel it is a bit wasteful, and with high sampling frequencies this
> function can be called quite often. Do you think there would be a way to
> either use stack (always reserve big enough buffer no matter which chip we
> have - or is the buffer too big to be safely taken from the stack?), or a
> buffer stored in private data and allocated at probe or buffer enable?

I tried using the same allocation as before but a device like the KX127 
has a fifo_length of 342 (compared to 86 for kx132, and 43 for kx022a). 
Allocating this much using the stack will result in a Warning.

> 
> Also, please avoid such long lines. I know many people don't care about the
> line length - but for example I tend to have 3 terminal windows open
> side-by-side on my laptop screen. Hence long lines tend to be harder to read
> for me.

That is the case for me also, but Jonathan asked me to change
"fifo_length * 6" and the KX022A_FIFO_SAMPLES_SIZE_BYTES is already
defined. 

> 
> > +
> >   	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> >   	if (ret) {
> >   		dev_err(dev, "Error reading buffer status\n");
> > @@ -621,8 +625,10 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> >   	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
> > -	if (!count)
> > +	if (!count) {
> > +		kfree(buffer);
> >   		return 0;
> > +	}
> >   	/*
> >   	 * If we are being called from IRQ handler we know the stored timestamp
> > @@ -679,7 +685,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   	}
> >   	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
> > -	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
> > +	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
> >   				&buffer[0], fifo_bytes);
> >   	if (ret)
> >   		goto renable_out;
> > @@ -704,6 +710,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   	if (renable)
> >   		enable_irq(data->irq);
> > +	kfree(buffer);
> >   	return ret;
> >   }
> > 
> ...
> 
> > -int kx022a_probe_internal(struct device *dev)
> > +const struct kx022a_chip_info kx022a_chip_info = {
> > +	.name		  = "kx022-accel",
> > +	.regmap_config	  = &kx022a_regmap_config,
> > +	.channels	  = kx022a_channels,
> > +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
> > +	.fifo_length	  = KX022A_FIFO_LENGTH,
> > +	.who		  = KX022A_REG_WHO,
> > +	.id		  = KX022A_ID,
> > +	.cntl		  = KX022A_REG_CNTL,
> > +	.cntl2		  = KX022A_REG_CNTL2,
> > +	.odcntl		  = KX022A_REG_ODCNTL,
> > +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> > +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> > +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
> > +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> > +	.buf_read	  = KX022A_REG_BUF_READ,
> > +	.inc1		  = KX022A_REG_INC1,
> > +	.inc4		  = KX022A_REG_INC4,
> > +	.inc5		  = KX022A_REG_INC5,
> > +	.inc6		  = KX022A_REG_INC6,
> > +	.xout_l		  = KX022A_REG_XOUT_L,
> > +};
> > +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> 
> Do you think the fields (or at least some of them) in this struct could be
> named based on the (main) functionality being used, not based on the
> register name? Something like "watermark_reg", "buf_en_reg", "reset_reg",
> "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", "int2_pinconf_reg",
> "int1_src_reg" ...
> 
> I would not be at all surprized to see for example some IRQ control to be
> shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be moved to
> cntl<Y> or to buf_cntl<Y> for next sensor we want to support. Especially
> when new cool feature is added to next sensor, resulting also adding a new
> cntl<Z> or buf_cntl<Z> or INC<Z>.
> 
> I, however, believe the _functionality_ will be there (in some register) -
> at least for the ICs for which we can re-use this driver. Hence, it might be
> nice - and if you can think of better names for these fields - to rename
> them based on the _functionality_ we use.
> 
> Another benefit would be added clarity to the code. Writing a value to
> "buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to me)
> than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". Especially if
> you don't have a datasheet at your hands.
> 
> I am not "demanding" this (at least not for now :]) because it seems these
> two Kionix sensors have been pretty consistent what comes to maintaining the
> same functionality in the registers with same naming - but I believe this is
> something that may in any case be lurking around the corner.

I agree, this seems to be the better solution. I will look into this. 

> 
> 
> 
> All in all, looks nice and clean to me! Good job.

Thank you :)

--
Kind Regards
Mehdi Djait
