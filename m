Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE236C11F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCTMeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCTMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:34:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9659D0;
        Mon, 20 Mar 2023 05:34:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgDfM6fkLz6J71p;
        Mon, 20 Mar 2023 20:32:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 12:34:08 +0000
Date:   Mon, 20 Mar 2023 12:34:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Mehdi Djait <mehdi.djait.k@gmail.com>, <jic23@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <andriy.shevchenko@linux.intel.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <20230320123408.000008c0@Huawei.com>
In-Reply-To: <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
        <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
        <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 20 Mar 2023 11:35:06 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/17/23 01:48, Mehdi Djait wrote:
> > Refactor the kx022a driver implementation to make it more
> > generic and extensible.
> > Add the chip_info structure will to the driver's private
> > data to hold all the device specific infos.
> > Move the enum, struct and constants definitions to the header
> > file.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> >   drivers/iio/accel/kionix-kx022a-i2c.c |  19 +-
> >   drivers/iio/accel/kionix-kx022a-spi.c |  22 +-
> >   drivers/iio/accel/kionix-kx022a.c     | 289 ++++++++++++--------------
> >   drivers/iio/accel/kionix-kx022a.h     | 128 ++++++++++--
> >   4 files changed, 274 insertions(+), 184 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> > index e6fd02d931b6..21c4c0ae1a68 100644
> > --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> > +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> > @@ -15,23 +15,35 @@
> >   static int kx022a_i2c_probe(struct i2c_client *i2c)
> >   {
> >   	struct device *dev = &i2c->dev;
> > +	struct kx022a_chip_info *chip_info;
> >   	struct regmap *regmap;
> > +	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> >   
> >   	if (!i2c->irq) {
> >   		dev_err(dev, "No IRQ configured\n");
> >   		return -EINVAL;
> >   	}
> >   
> > -	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
> > +	chip_info = device_get_match_data(&i2c->dev);
> > +	if (!chip_info)
> > +		chip_info = (const struct kx022a_chip_info *) id->driver_data;
> > +
> > +	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
> >   	if (IS_ERR(regmap))
> >   		return dev_err_probe(dev, PTR_ERR(regmap),
> >   				     "Failed to initialize Regmap\n");  
> 
> Hm. I would like to pull the regmap_config out of the chip_info struct. 
> As far as I see, the regmap_config is only needed in these bus specific 
> files. On the other hand, the chip-info is only needed in the 
> kionix-kx022a.c file, right?
> 

I disagree.  We've moved quite a few drivers away from the enum route
because the indirection doesn't add anything useful and leads to
nasty casting to enums.  In particular, we have to avoid using enum
value of 0 if we want to check if there is a match. For a pointer that's
an easy check against NULL.

The regmap is product specific so makes sense as part of the chip_info
structure.

> So, maybe you could here just get the regmap_config based on the chip-id 
> (enum value you added - the data pointer in match tables could be just 
> the enum value indicating the IC type). Then, you could pass this enum 
> value to kx022a_probe_internal() - and the chip-info struct could be 
> selected in the kionix-kx022a.c based on it. That way you would not need 
> the struct chip-info here or regmap_config in kionix-kx022a.c. Same in 
> the *-spi.c
> 
> Something like:
> 
> enum {
> 	KIONIX_IC_KX022A,
> 	KIONIX_IC_KX132_xxx, /* xxx denotes accurate model suffix */
> };
> 	
> static const struct of_device_id kx022a_of_match[] = {
> 	{ .compatible = "kionix,kx022a", .data = KIONIX_IC_KX022A },
> 	...
> 
> chip_id = device_get_match_data(&i2c->dev);

This fails for probes using the i2c_device_id table entries.
So you need to check for invalid entry.  Unfortunately that is
a NULL return which you can't detect if your enum has a value of 0.

> 
> regmap_cfg = kx022a_kx_regmap_cfg[chip_id];
> regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
> ...
> return kx022a_probe_internal(dev, chip_id);
> 
> Do you think that would work?

It would work with the enum starting at 1, and it's a pattern that
used to be common. Less so now because with multiple firmware types
we want to be able to check trivially if we have a match.

> 
> OTOH, to really benefit from this we should probably pull out the 
> regmap-configs from the kionix-kx022a.c. I am not really sure where we 
> should put it then though. Hence, if there is no good ideas how to split 
> the config and chip-info so they are only available/used where needed - 
> then I am also Ok with the current approach.

Definitely stick to current approach.  If I had the time I'd
rip out all the code useing enums in match tables. It's bitten us
a few times with nasty to track down bugs that only affect more obscure
ways of binding the driver.

...

> 
> >   
> > +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	__le16 buf_status;
> > +	int ret, fifo_bytes;
> > +
> > +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
> > +	if (ret) {
> > +		dev_err(dev, "Error reading buffer status\n");
> > +		return ret;
> > +	}
> > +
> > +	buf_status &= data->chip_info->buf_smp_lvl_mask;
> > +	fifo_bytes = le16_to_cpu(buf_status);
> > +
> > +	/*
> > +	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
> > +	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> > +	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> > +	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> > +	 * is that full 258 bytes of data is indicated using the max value 255.
> > +	 */
> > +	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
> > +		fifo_bytes = KX022A_FIFO_MAX_BYTES;
> > +
> > +	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
> > +		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
> > +
> > +	return fifo_bytes;
> > +}  
> 
> I like adding this function. Here I agree with Jonathan - having a 
> device specific functions would clarify this a bit. The KX022A "quirk" 
> is a bit confusing. You could then get rid of the buf_smp_lvl_mask.

I'd missed the type quirk. Good point, definitely have a callback.
Get rid of that 'type' element of the chip_info.
That is a bad design pattern as it doesn't scale to lots of devices
as you end up with big switch statements.


> 
> > +
> >   static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >   {
> >   	/*
> > @@ -593,35 +588,22 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
> >   	 */
> >   	data->timestamp = 0;
> >   
> > -	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
> > +	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
> >   }
> >   
> >   static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >   			       bool irq)
> >   {
> >   	struct kx022a_data *data = iio_priv(idev);
> > -	struct device *dev = regmap_get_device(data->regmap);
> > -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> > +	__le16 buffer[data->chip_info->fifo_length * 3];  
> 
> I don't like this. Having the length of an array decided at run-time is 
> not something I appreciate. Maybe you could just always reserve the 
> memory so that the largest FIFO gets supported. I am just wondering how 
> large arrays we can safely allocate from the stack?

I'd missed this as well.  Definitely don't have a variable length array.
Allocate it as a buffer accessed via a pointer in kx022a_data

> 

> 
> >   	if (ret)
> >   		goto unlock_out;
> >     
> 
> > -int kx022a_probe_internal(struct device *dev)
> > +int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)  
> 
> As mentioned elsewhere, this might also work if the chip-type enum was 
> passed here as parameter. That way the bus specific part would not need 
> to know about the struct chip_info...

It only knows there is a pointer.  Doesn't need to know more than that.
+ argument against as above.


Jonathan

