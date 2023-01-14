Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39C66AD24
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjANRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjANRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:53:24 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C83693FA;
        Sat, 14 Jan 2023 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EwlRK873bQW6EMYn9B+dl2f2uA02s1q0ZG38QSTLXHc=; b=h5YAAFwNHLV9GJ2bKVpR9I4TAm
        wbSoHLK1QzuRIH1cSU5lavVE81zrSr+mJMA/bmWeLhvmOM+laQaaF9Kyqm2wbkJxox13TWqqxx0Y7
        eJp6t0lkHYuokXkasi6pyZupMAHAHrG4LeLy+GuTJEc7t1nmyTYijuNbxnXQ37nJnW3c=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41192 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pGkiP-0002ef-MF; Sat, 14 Jan 2023 12:53:14 -0500
Date:   Sat, 14 Jan 2023 12:53:13 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230114125313.3410f601fc8855d8fdb6b18b@hugovil.com>
In-Reply-To: <20230114162841.41358640@jic23-huawei>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-2-hugo@hugovil.com>
        <20230114162841.41358640@jic23-huawei>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 16:28:41 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 13 Jan 2023 14:49:58 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> > digital converter (ADC) with an I2C interface.
> > 
> > Datasheet: https://www.ti.com/lit/gpn/ads7924
> 
> This counts as a normal tag, so there shouldn't be blank line between
> it and the SOB.

Fixed.

> 
> A few other small things inline noticed on this read through.
> I can fix these up whilst applying if nothing else comes up for v3
> and DT binding reviewers are happy.  If you are doing a v4 for
> other reasons, please address these comments in that.

Ok,
I have already prepared a V4 with all these changes, just in case. Thank you for your comments.


> Jonathan
> 
> 
> 
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ...
> > diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> > new file mode 100644
> > index 000000000000..c24fae4ef8e0
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads7924.c
> > @@ -0,0 +1,474 @@
> 
> ...
> 
> > +static int ads7924_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	int ret, vref_uv;
> > +	struct ads7924_data *data = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&data->lock);
> > +		ret = ads7924_get_adc_result(data, chan, val);
> > +		mutex_unlock(&data->lock);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		vref_uv = regulator_get_voltage(data->vref_reg);
> > +		if (vref_uv < 0)
> > +			return -EINVAL;
> 
> Better to return the error value from regulator_get_voltage() rather
> than replace it with -EINVAL.

Of course, done.

> > +
> > +		*val =  vref_uv / 1000; /* Convert reg voltage to mV */
> > +		*val2 = ADS7924_BITS;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info ads7924_info = {
> > +	.read_raw = ads7924_read_raw,
> > +};
> > +
> > +static int ads7924_get_channels_config(struct i2c_client *client,
> > +				       struct iio_dev *indio_dev)
> > +{
> > +	struct ads7924_data *priv = iio_priv(indio_dev);
> > +	struct device *dev = priv->dev;
> > +	struct fwnode_handle *node;
> > +	int num_channels = 0;
> > +
> > +	device_for_each_child_node(dev, node) {
> > +		u32 pval;
> > +		unsigned int channel;
> > +
> > +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> > +			dev_err(dev, "invalid reg on %pfw\n", node);
> > +			continue;
> > +		}
> > +
> > +		channel = pval;
> > +		if (channel >= ADS7924_CHANNELS) {
> > +			dev_err(dev, "invalid channel index %d on %pfw\n",
> > +				channel, node);
> > +			continue;
> > +		}
> > +
> > +		num_channels++;
> > +	}
> > +
> > +	if (num_channels <= 0)
> 
> How would it be less than 0?  if (!num_channels) works fine I think.

Done.

> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ads7924_set_conv_mode(struct ads7924_data *data, int mode)
> > +{
> > +	int ret;
> > +	unsigned int mode_field;
> > +	struct device *dev = data->dev;
> > +
> > +	/*
> > +	 * When switching between modes, be sure to first select the Awake mode
> > +	 * and then switch to the desired mode. This procedure ensures the
> > +	 * internal control logic is properly synchronized.
> > +	 */
> > +	if (mode != ADS7924_MODECNTRL_IDLE) {
> > +		mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK,
> > +					ADS7924_MODECNTRL_AWAKE);
> > +
> > +		ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> > +					 ADS7924_MODECNTRL_MODE_MASK,
> > +					 mode_field);
> > +		if (ret) {
> > +			dev_warn(dev, "failed to set awake mode (%pe)\n",
> > +				 ERR_PTR(ret));
> 
> As below.

Agreed, converted to dev_err.

> 
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	mode_field = FIELD_PREP(ADS7924_MODECNTRL_MODE_MASK, mode);
> > +
> > +	ret = regmap_update_bits(data->regmap, ADS7924_MODECNTRL_REG,
> > +				 ADS7924_MODECNTRL_MODE_MASK, mode_field);
> > +	if (ret)
> > +		dev_warn(dev, "failed to set mode %d (%pe)\n", mode,
> > +			 ERR_PTR(ret));
> 
> Why warning? Seems like a fairly critical error to me.
> dev_err() more appropriate perhaps.

Agreed, converted to dev_err.

> > +
> > +	return ret;
> > +}
> > +
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
