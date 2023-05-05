Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991806F887E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjEESLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjEESLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:11:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C31C0D7;
        Fri,  5 May 2023 11:11:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29555219a12.1;
        Fri, 05 May 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683310296; x=1685902296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nd1nRrArnnbxZ/6yDMypPmNKlocui+NeEXIajpk0CTA=;
        b=pQICc57928GvYredg4Lkr+crak0z5+/zHwdNaRu3UkkuFnRR3+Zu4UhVXYLGrUqA8U
         Uh1JQkAm0YtmQPSCvbQmez29M2biXHSHS5TFDux7H6UERizWOJSMc4k7/t5dzq+nw94a
         D6kbp88TOtlu6QhjS0EYWETXmR95BNvjJ7EFHWwfdSgUmy+tOo+tOV1qqqyV9NW+8wLP
         9gQI/dznqrSeLkhGsn5h1CnkSw2uIESPuwBkA6EHfI+88hFFRXGC+6MyOojeHM0fPHUB
         FStnwhuy1C87kAW7zIfKSsyvk9XHbUY4KAqRM0I+823U0kF8yie3CDzs5+WAu7gKEyuJ
         AIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310296; x=1685902296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd1nRrArnnbxZ/6yDMypPmNKlocui+NeEXIajpk0CTA=;
        b=gV1fztsrQZDZHhkW3gvn/2jp4L8/HpxeQ6RhaA1wLsR4vULhHLUSPsoLKQ7LVfee5l
         M9gjyddtNGnqBU78BBQfKKvRhMokYALwSrSP7r+4bW+pulO9uc44RDDxDtK2XMYV8gKs
         /e2dtLz6lyCMHK7EWRkmC+2n5nIYYIX0tt9ZBWgO+8y8pV8wSOPnbNKDYmR4Acyb4qhw
         xTwVFP5vKCkiLKaBejV0x2X6uMA3NvUnsHWPGjfhTrZFIagtYsg0Wn41JuaUWdaN+cjW
         tavy4rdzUYMgCQt2rJO1kEd027dheH1x2hpDDOXSb1bPyTRxTXSCsap07n4oZSAf54Ed
         +VsQ==
X-Gm-Message-State: AC+VfDw76DyUb4NUrqtvFoahvGjDe2IRuWVV5e8x9xPg/gNKDIL4dkFX
        wkAZnzJz7ZPo628BCGX/Mcg=
X-Google-Smtp-Source: ACHHUZ65mn3IQ/hKgx+NHNuZrzFlw+JJ817PYazVbx/Uf//Bi+cD2stNAkZ5D4GK5m0wvJR58z4ALQ==
X-Received: by 2002:a05:6402:42c6:b0:506:b94f:3d8f with SMTP id i6-20020a05640242c600b00506b94f3d8fmr3154413edc.5.1683310295832;
        Fri, 05 May 2023 11:11:35 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::5908])
        by smtp.gmail.com with ESMTPSA id be25-20020a0564021a3900b004fd1ee3f723sm3133138edb.67.2023.05.05.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:11:35 -0700 (PDT)
Date:   Fri, 5 May 2023 20:11:33 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZFVG1cyY/Ge/nXOh@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
 <20230501155645.435242f0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230501155645.435242f0@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Mon, May 01, 2023 at 03:56:45PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Apr 2023 00:22:27 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> > ranges from ±2G to ±16G, digital output through I²C/SPI.
> > Add support for basic accelerometer features such as reading acceleration
> > via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> > 
> > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> 
> Two tiny things inline.  
> 
> > +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	__le16 buf_status;
> > +	int ret, fifo_bytes;
> > +
> > +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> > +			       &buf_status, sizeof(buf_status));
> > +	if (ret) {
> > +		dev_err(dev, "Error reading buffer status\n");
> > +		return ret;
> > +	}
> > +
> > +	fifo_bytes = le16_to_cpu(buf_status);
> > +	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;
> 
> Slight preference for FIELD_GET() as it saves me checking the mask includes
> lowest bits.

This will mean I have the remove the chip_info member buf_smp_lvl_mask
and use KX132_MASK_BUF_SMP_LVL directly because otherwise the
__builtin_constant_p function will cause an error when building. 
Check: https://elixir.bootlin.com/linux/latest/source/include/linux/bitfield.h#L65

I can change it to FIELD_GET() if you want to.

> 
> 
> > +
> > +	return fifo_bytes;
> > +}
> > +
> >  static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >  			       bool irq)
> >  {
> > @@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info = {
> >  };
> >  EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> >  
> > +const struct kx022a_chip_info kx132_chip_info = {
> > +	.name		  = "kx132-1211",
> > +	.regmap_config	  = &kx132_regmap_config,
> > +	.channels	  = kx132_channels,
> > +	.num_channels	  = ARRAY_SIZE(kx132_channels),
> > +	.fifo_length	  = KX132_FIFO_LENGTH,
> > +	.who		  = KX132_REG_WHO,
> > +	.id		  = KX132_ID,
> > +	.cntl		  = KX132_REG_CNTL,
> > +	.cntl2		  = KX132_REG_CNTL2,
> > +	.odcntl		  = KX132_REG_ODCNTL,
> > +	.buf_cntl1	  = KX132_REG_BUF_CNTL1,
> > +	.buf_cntl2	  = KX132_REG_BUF_CNTL2,
> > +	.buf_clear	  = KX132_REG_BUF_CLEAR,
> > +	.buf_status1	  = KX132_REG_BUF_STATUS_1,
> > +	.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,
> 
> There are some things in here (typically where the define isn't used
> anywhere else) where I think it would be easier to follow if the
> value was listed here.  Masks and IDs for example. 
> 

After removing buf_smp_lvl_mask, which members will be easier to understand (besides id) ? 

--
Kind Regards
Mehdi Djait
