Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C726F98F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjEGOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB213C12;
        Sun,  7 May 2023 07:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C457A60EA4;
        Sun,  7 May 2023 14:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF649C433EF;
        Sun,  7 May 2023 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683470322;
        bh=YdVovzlI+Oo3QHlBZtEyFh8kvZoU+pkM8tBPRt02jks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJ3H+1zPq8b+DCR++/HsW5CGYJEvyV/RwHILrP0cKsv+mXYs/f2/9xVGGEoG2WfqJ
         4jRNx13o8iARGtagquqGnkCOzV6UZ3h5c8/NT8PAdiutZgZE+4LLVDZCKJVrgYHWJF
         OyCnj6p1JCR2dG3dkMMjchvw9VoxcqdOhvOtPPWoW9I+GMoYTfDo5pydAflQ9IIPsL
         dEmYEdZCPhRzARTxNOASjhU8nA35Bizl6gEKYMlkbuiU0E/X2EMNrPcwXfV7STUKSH
         5L+WuNxefbJ5eSouUA1HYcaCOMBlrmWjfTidktK9CJZhuBUk7DCG1hqe+saRHiimxk
         L1IkebqIjWHEw==
Date:   Sun, 7 May 2023 15:54:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230507155434.3d05daa5@jic23-huawei>
In-Reply-To: <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
        <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
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

On Wed, 3 May 2023 12:50:14 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
> and IR) with four configurable channels. Red and green being always
> available and two out of the rest three (blue, clear, IR) can be
> selected to be simultaneously measured. Typical application is adjusting
> LCD backlight of TVs, mobile phones and tablet PCs.
> 
> Add initial support for the ROHM BU27008 color sensor.
>  - raw_read() of RGB and clear channels
>  - triggered buffer w/ DRDY interrtupt
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Mostly stuff that you asked about in response to earlier version but
which I hadn't replied to until today.

Upshot, don't need the manual irq handling in here.

Whilst you aren't setting IRQF_ONESHOT for the pollfunc side of the trigger
(the downstream IRQ / IRQ thread) the IIO utility functions are.

Jonathan


> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> new file mode 100644
> index 000000000000..c04d845062ba
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -0,0 +1,993 @@
...


> +
> +static int bu27008_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +	int busy, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		busy = iio_device_claim_direct_mode(idev);
> +		if (busy)
> +			return -EBUSY;
> +
> +		mutex_lock(&data->mutex);
> +		ret = bu27008_read_one(data, idev, chan, val, val2);
> +		mutex_unlock(&data->mutex);
> +
> +		iio_device_release_direct_mode(idev);
> +
> +		return ret;
> +	}
Why {}? 

I guess there was a local variable, but isn't any more?


> +	case IIO_CHAN_INFO_SCALE:
> +		ret = bu27008_get_scale(data, chan->scan_index == BU27008_IR,
> +					val, val2);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = bu27008_get_int_time_us(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = 0;
> +		*val2 = ret;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int bu27008_write_raw(struct iio_dev *idev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +	int ret;
> +
> +	/*
> +	 * Do not allow changing scale when measurement is ongoing as doing so
> +	 * could make values in the buffer inconsistent.
> +	 */
> +	ret = iio_device_claim_direct_mode(idev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = bu27008_set_scale(data, chan, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val)
> +			ret = -EINVAL;
Slight preference for
		if (val) {
			ret = -EINVAL;
			break;
		}

		ret = bu27008....
		break;

so that the error path is out of line of the main flow.

Ever so slightly helps people follow this stuff if they are reading 'a lot'
of code (every little helps!). I have to look closer at anything other than
an obvious direct break / goto / return on error paths to make sure nothing
else snuck in that shouldn't be there.


> +		else
> +			ret = bu27008_try_set_int_time(data, val2);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	iio_device_release_direct_mode(idev);
> +
> +	return ret;
> +}


> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bu27008_data *data = iio_priv(idev);
> +	struct {
> +		__le16 chan[BU27008_NUM_HW_CHANS];
> +		s64 ts __aligned(8);
> +	} raw;
> +	int ret, dummy;
> +
> +	memset(&raw, 0, sizeof(raw));
> +
> +	/*
> +	 * After some measurements, it seems reading the
> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
> +	 */
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
> +			       sizeof(raw.chan));
> +	if (ret < 0)
> +		goto err_read;
> +
> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	enable_irq(data->irq);

As below. This shouldn't be needed (and if it was it should be in the
reenable path that is ultimately a result of that notify_done above and
some reference counting fun).

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bu27008_buffer_preenable(struct iio_dev *idev)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +	int chan_sel, ret;
> +
> +	/* Configure channel selection */
> +	if (test_bit(BU27008_BLUE, idev->active_scan_mask)) {
> +		if (test_bit(BU27008_CLEAR, idev->active_scan_mask))
> +			chan_sel = BU27008_BLUE2_CLEAR3;
> +		else
> +			chan_sel = BU27008_BLUE2_IR3;
> +	} else {
> +		chan_sel = BU27008_CLEAR2_IR3;
> +	}
> +
> +	chan_sel = FIELD_PREP(BU27008_MASK_CHAN_SEL, chan_sel);
> +
> +	ret = regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> +				 BU27008_MASK_CHAN_SEL, chan_sel);
> +	if (ret)
> +		return ret;

Hmm. I'd missed this before but. This is in the wrong place really
(though it probably doesn't make much difference), stuff related to
enabling particular channels should be in iio_info->update_scan_mode()

It's arguable that the actual measurement mode setting might come
in the postenable callback (after the update_scan_mode() call which
in turn follows the preenable callback).

All these callbacks have become a bit blurry over time as we end
up with devices that need to do nasty thing in one place.  In this
particular case it's pretty simple though, so nicer to move
the scan mask stuff to the callback that is given the active_scan
mask as a parameter.

> +
> +	return bu27008_meas_set(data, BU27008_MEAS_EN);
> +}
> +
> +static int bu27008_buffer_postdisable(struct iio_dev *idev)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +
> +	return bu27008_meas_set(data, BU27008_MEAS_DIS);
> +}
> +
> +static const struct iio_buffer_setup_ops bu27008_buffer_ops = {
> +	.preenable = bu27008_buffer_preenable,
> +	.postdisable = bu27008_buffer_postdisable,
> +};
> +
> +static irqreturn_t bu27008_data_rdy_poll(int irq, void *private)
> +{
> +	/*
> +	 * The BU27008 keeps IRQ asserted until we read the VALID bit from
> +	 * a register. We need to keep the IRQ disabled until this
> +	 */
> +	disable_irq_nosync(irq);

As per my late reply to your question on this, shouldn't be needed
as IRQF_ONESHOT is ultimately set for the interrupts nested below this
so they'll get the resulting queuing on the threads which is fine.

Note if this were needed, you might want to provide the reenable callback
for the trigger to do the irq reenabling and to implement that correctly
against some race conditions, that might need to do another read of the
register.  That handles weird ordering conditions where another consumer
of the trigger is enabled before the device acting as a consumer has
it's own buffer enabled.

Anyhow, I don't think it's relevant here and you shouldn't need this unless
I've miss understood / remembered how all that interrupt logic is working.

Jonathan


> +	iio_trigger_poll(private);
> +
> +	return IRQ_HANDLED;
> +}


