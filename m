Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD46EBF81
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDWMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428310E2;
        Sun, 23 Apr 2023 05:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292D06116C;
        Sun, 23 Apr 2023 12:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED39C433D2;
        Sun, 23 Apr 2023 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682253690;
        bh=R792KDP/CZCy6wKwT5yt1t1FNrvo29PMZFubgULs/xU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d5iQr+tOguPTvn2TJANwbLx8pgQNzAq6hjxiXYBWRJ4MRots/GOz/tOQOAr86NcC0
         lDwsj+pcZDDewru6GuKuepzc60JAuSqxjRbBcXAzmTBlBGwYJwGewhquuuqtYqKjBF
         2pPpg+YVXH2clKJ6ZVyztJcLEUAEBViozVuoqcbT9uARcpHnBS39JMpdJTUp0WspTH
         9SksfdDJ3yBspvP7OhV2gshZCMe1MVM6dlD0/oBSvhvz8tKA628k7uKpY2PhJRQH1J
         zjeyxHGc9MG/+UrAJnE867SyJqV7zqzmEzFTBfmkAdnMl6+FBSGBfQH8FO8/+xiu5G
         LTuJL15fZ48CA==
Date:   Sun, 23 Apr 2023 13:57:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: light: ROHM BU27008 color sensor
Message-ID: <20230423135706.008206da@jic23-huawei>
In-Reply-To: <28ace0e26267df5618fbd23625425292391ad7f0.1682067567.git.mazziesaccount@gmail.com>
References: <cover.1682067567.git.mazziesaccount@gmail.com>
        <28ace0e26267df5618fbd23625425292391ad7f0.1682067567.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 12:39:36 +0300
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

Hi Matti,

Biggest issue in here is some confusion over data packing when some channels
are enabled.  The driver must pack the channels that are enabled (seen
from active_scan_mask) according to general IIO rules.  So naturally aligned
buffers.  Thus for this device it should always be packed into

struct scan {
	__le16 chans[4];
	s64 ts __aligned(8); /*it's aligned anyway but better not to make reviewers think ;) */
};

Even though there are 5 possible channels.  If one in the middle isnt' enabled (e.g. blue)
then clear and IR shift to lower words. of the buffer.

The demux code in the IIO core then deals with userspace requesting less than this
by repacking the data if needed.   That allows it to present different views to different
consumers (e.g. userspace IIO access, and an inkernel buffer user - though there aren't
any of those for light sensors AFAIK.

I'd not thought about the issue of the weird scales interacting with someone changing
the integration time. That's nasty and I don't have a better suggestion than what you have
currently.

Otherwise some trivial stuff inline.

Jonathan



> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> new file mode 100644
> index 000000000000..6fca193eeb9e
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -0,0 +1,1028 @@

...

> +
> +enum {
> +	BU27008_RED,	/* Always data0 */
> +	BU27008_GREEN,	/* Always data1 */
> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
> +	BU27008_CLEAR,	/* data2 or data3 */
> +	BU27008_IR,	/* data3 */
> +	BU27008_NUM_CHANS
> +};
> +
> +enum {
> +	BU27008_DATA0, /* Always RED */
> +	BU27008_DATA1, /* Always GREEN */
> +	BU27008_DATA2, /* Blue or Clear */
> +	BU27008_DATA3, /* IR or Clear */
> +	BU27008_NUM_HW_CHANS
> +};
> +
> +/* We can always measure red and green at same time */
> +#define ALWAYS_SCANNABLE (BIT(BU27008_RED) | BIT(BU27008_GREEN))
> +
> +#define BU27008_CHAN_DATA_SIZE		2 /* Each channel has 16bits of data */
> +#define BU27008_BUF_DATA_SIZE (BU27008_NUM_CHANS * BU27008_CHAN_DATA_SIZE)

Buffer should be same size as the number you can grab in one read.  So
it should be same as BU27008_HW_DATA_SIZE. The data is packed when only some
channels are enabled.

> +#define BU27008_HW_DATA_SIZE (BU27008_NUM_HW_CHANS * BU27008_CHAN_DATA_SIZE)
> +#define NUM_U16_IN_TSTAMP (sizeof(s64) / sizeof(u16))
> +
> +static const unsigned long bu27008_scan_masks[] = {
> +	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
> +	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_BLUE),
> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),

Good, this looks correct for allowing the IIO core to deal with demuxing
the data as necessary.  Note that this is saying that if one of these
modes is active scan mask it will be backed into lowers set of __le16
buffer elements.

> +	0
> +};
> +

> +
> +struct bu27008_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct device *dev;
> +	struct iio_gts gts;
> +	struct iio_gts gts_ir;
> +	int64_t timestamp, old_timestamp;

As noted later, not sure what old_timestamp is for.

> +	int irq;
> +
> +	/*
> +	 * Prevent changing gain/time config when scale is read/written.
> +	 * Prevent changing gain/time when raw data is read.
Does more than that.  Probably need a bit more detail here.

> +	 */
> +	struct mutex mutex;
> +	bool trigger_enabled;
> +
> +	__le16 buffer[BU27008_NUM_CHANS];

As below, you should be able to always read directly into the element you
also use to push to the iio buffer.

> +
> +	struct {
> +		__le16 channels[BU27008_NUM_CHANS];
> +		s64 ts __aligned(8);
> +	} scan;

As noted below. This has write structure for a buffer scan, but you don't use it.
Mind you, no need to have it in here that I can see. I'd just put it on the stack.

> +};

> +
> +static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts, int *gain)
> +{
> +	int ret, sel;
> +
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, &sel);
> +	if (ret)
> +		return ret;
> +
> +	sel = FIELD_GET(BU27008_MASK_RGBC_GAIN, sel);
> +
> +	ret = iio_gts_find_gain_by_sel(gts, sel);
> +
No blank line here.  Keep call and it's error handler in one block of code.

> +	if (ret < 0) {
> +		dev_err(data->dev, "unknown gain value 0x%x\n", sel);
> +

Blank line here doesn't add anything. Drop it.

> +		return ret;
> +	}
> +
> +	*gain = ret;
> +
> +	return 0;
> +}
> +
> +static int bu27008_write_gain_sel(struct bu27008_data *data, int sel)
> +{
> +	int regval;
> +
> +	regval = FIELD_PREP(BU27008_MASK_RGBC_GAIN, sel);
> +
> +	/*
> +	 * We do always set also the LOW bits of IR-gain because othervice we
> +	 * would risk resulting an invalid GAIN register value.
> +	 *
> +	 * We could allow setting separate gains for RGBC and IR when the
> +	 * values were such that HW could support both gain settings.
> +	 * Eg, when the shared bits were same for both gain values.
> +	 *
> +	 * This, however, has a negligible benefit compared to the increased
> +	 * software complexity when we would need to go through the gains
> +	 * for both channels separately when the integration time changes.
> +	 * This would end up with nasty logic for computing gain values for
> +	 * both channels - and rejecting them if shared bits changed.
> +	 *
> +	 * We should then build the logic by guessing what a user prefers.
> +	 * RGBC or IR gains correctly set while other jumps to odd value?

Ah.  This is fiddly because integration time is shared. I'd missed that detail.
We could break that up, so that which they care about is dependent on which
one they wrote but it's a bit ugly.

> +	 * Maybe look-up a value where both gains are somehow optimized
> +	 * <what this somehow is, is ATM unknown to us>. Or maybe user would
> +	 * expect us to reject changes when optimal gains can't be set to both
> +	 * channels w/given integration time. At best that would result
> +	 * solution that works well for a very specific subset of
> +	 * configurations but causes unexpected corner-cases.
> +	 *
> +	 * So, we keep it simple. Always set same selector to IR and RGBC.
> +	 * We disallow setting IR (as I expect that most of the users are
> +	 * interested in RGBC). This way we can show the user that the scales
> +	 * for RGBC and IR channels are different (1X Vs 2X with sel 0) while
> +	 * still keeping the operation deterministic.
> +	 */
> +	regval |= FIELD_PREP(BU27008_MASK_IR_GAIN_LO, sel);
> +
> +	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL2,
> +				  BU27008_MASK_RGBC_GAIN, regval);
> +}

> +
> +static int bu27008_meas_set(struct bu27008_data *data, bool enable)
> +{
> +	if (enable)
> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> +				       BU27008_MASK_MEAS_EN);
> +
> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> +				 BU27008_MASK_MEAS_EN);

Might be cleaner with regmap_update_bits()

> +}


> +static int bu27008_validate_trigger(struct iio_dev *idev,
> +				   struct iio_trigger *trig)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +
> +	if (data->trig != trig)

Hmm. I thought we had a standard function for this, but turns out we only have
the one that validates in the other direction.  Perhaps it's wroth something
generic like iio_device_validate_own_trigger which would be similar to
iio_trigger_validate_own_device in that it would use the common parentage of
the trigger and iio_dev to check the match.

> +		return -EINVAL;
> +
> +	return 0;
> +}

> +static int bu27008_chip_init(struct bu27008_data *data)
> +{
> +	int ret;
> +
> +	/* Reset */

Kind of obvious from the code, I'd drop the comment as something that might rot over
time.

> +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
> +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> +
> +	msleep(1);

Good to state what reset time min is from datasheet.

> +
> +	return ret;
> +}
> +
> +static int bu27008_set_drdy_irq(struct bu27008_data *data, bool state)
> +{
> +	if (state)
> +		return regmap_set_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> +					BU27008_MASK_INT_EN);
> +	return regmap_clear_bits(data->regmap, BU27008_REG_MODE_CONTROL3,
> +				 BU27008_MASK_INT_EN);
regmap_update_bits() maybe with the mask and value supplied.
> +}
> +

> +static irqreturn_t bu27008_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct bu27008_data *data = iio_priv(idev);
> +
> +	data->old_timestamp = data->timestamp;

What is old_timestamp for?  Without out setting that, this
is the same as iio_pollfunc_store_time() with the timestamp
stored in a slightly difference place and always waking the thread
(which probably doesn't matter)


> +	data->timestamp = iio_get_time_ns(idev);
> +
> +	if (data->trigger_enabled)
> +		return IRQ_WAKE_THREAD;
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t bu27008_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct bu27008_data *data = iio_priv(idev);
> +	__le16 raw[BU27008_NUM_CHANS + NUM_U16_IN_TSTAMP];

Not immediately obvious this is correct.  
I'm fairly sure it's not...


Timestamp needs to be aligned to 8 bytes.  Here it's 10 bytes
in.  That's why we often use a structure to make that explicit though
even then you need to force alignment of the s64 (as it would be 32 bit aligned
on x86_32 otherwise.)  Note that you only actually read 4 channels so once
you've fixed the code below, this all gets simpler.  Even then, you should
use a structure to make it more obviously correct for a reviewer.


> +	int ret, dummy;
> +
> +	memset(&raw, 0, sizeof(raw));
You'll need this after you make it a structure as suggested as then it will
have holes and memset is needed to fill them.  As code stands ] = {};
would have been cleaner but that only assigns the elements of a structure
so you'll need the memset if you change to one.

> +
> +	/*
> +	 * After some measurements, it seems reading the
> +	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line

'it seems' worries me.  In docs? Not that we have them but would be nice
if this statement was stronger!

> +	 */
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL3, &dummy);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, data->buffer,
> +			       BU27008_HW_DATA_SIZE);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	/* Red and green are always in dedicated channels. */
> +	if (*idev->active_scan_mask & BIT(BU27008_RED))
> +		raw[BU27008_RED] = data->buffer[BU27008_RED];
> +	if (*idev->active_scan_mask & BIT(BU27008_GREEN))
> +		raw[BU27008_GREEN] = data->buffer[BU27008_GREEN];

Write them in even if disabled. The IIO core will deal with any data shuffling
needed to drop any that aren't used.  That's what the avail_masks stuff
is used for.

> +
> +	/*
> +	 * We need to check the scan mask to determine which of the
> +	 * BLUE/CLEAR/IR are enabled so we know which channel is used to
> +	 * measure which data.
> +	 */
> +	if (*idev->active_scan_mask & BIT(BU27008_BLUE)) {
> +		raw[BU27008_BLUE] = data->buffer[BU27008_DATA2];
> +
> +		if (*idev->active_scan_mask & BIT(BU27008_CLEAR))
> +			raw[BU27008_CLEAR] = data->buffer[BU27008_DATA3];
> +	} else {
> +		if (*idev->active_scan_mask & BIT(BU27008_CLEAR))
> +			raw[BU27008_CLEAR] = data->buffer[BU27008_DATA2];
> +	}
> +	if (*idev->active_scan_mask & BIT(BU27008_IR))
> +		raw[BU27008_IR] = data->buffer[BU27008_DATA3];

This dance doesn't seem right.  If a channel  is disabled, then we should
pack the data in the the buffer passed to iio_push_to_buffers_with_timestamp()
not attempt to have it at a fixed offset.  Hopefully if the scan_index etc
all match up in the right order you should be able to just do the regmap_bulk_read
directly into the buffer you are going to push out later (that buffer needs to be
a bit larger to take the timestamp.)  You have a nice scan element in
your idev, but you don't use it.


> +
> +	iio_push_to_buffers_with_timestamp(idev, raw, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bu27008_irq_thread_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct bu27008_data *data = iio_priv(idev);
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	mutex_lock(&data->mutex);
> +	if (data->trigger_enabled) {
> +		iio_trigger_poll_nested(data->trig);

Add a comment here on why it makes sense to hold the mutex whilst
calling this.

> +		ret = IRQ_HANDLED;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bu27008_buffer_preenable(struct iio_dev *idev)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +	int chan_sel, ret;
> +
> +	/* Configure channel selection */
> +	if (*idev->active_scan_mask & BIT(BU27008_BLUE)) {
> +		if (*idev->active_scan_mask & BIT(BU27008_CLEAR))

Whilst in this case active_scan_mask is a single long, you should treat
it as if it were a bitmap and use the bitmap accessors as per comments in
linux/bitmap.h
test_bit() is probably appropriate here.

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
> +
> +	return bu27008_meas_set(data, true);
> +}
> +
> +static int bu27008_buffer_postdisable(struct iio_dev *idev)
> +{
> +	struct bu27008_data *data = iio_priv(idev);
> +
> +	return bu27008_meas_set(data, false);
> +}
> +
> +static const struct iio_buffer_setup_ops bu27008_buffer_ops = {
> +	.preenable = bu27008_buffer_preenable,
> +	.postdisable = bu27008_buffer_postdisable,
> +};
> +
> +static int bu27008_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct iio_trigger *indio_trig;
> +	struct bu27008_data *data;
> +	struct regmap *regmap;
> +	unsigned int part_id, reg;
> +	struct iio_dev *idev;
> +	char *name;
> +	int ret;
> +
> +	if (!i2c->irq) {
> +		dev_err(dev, "No IRQ configured\n");

If it's possible to relax this requirement for an IRQ you should definitely
do so, even if you loose a lot of functionality.  It's annoyingly common for
board designers to think it's not necessary to wire up IRQs.

> +		return -EINVAL;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(i2c, &bu27008_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +
> +	data = iio_priv(idev);
> +
> +	ret = regmap_read(regmap, BU27008_REG_SYSTEM_CONTROL, &reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	part_id = FIELD_GET(BU27008_MASK_PART_ID, reg);
> +
> +	if (part_id != BU27008_ID)
> +		dev_warn(dev, "unknown device 0x%x\n", part_id);
> +
> +	ret = devm_iio_init_iio_gts(dev, BU27008_SCALE_1X, 0, bu27008_gains,
> +				    ARRAY_SIZE(bu27008_gains), bu27008_itimes,
> +				    ARRAY_SIZE(bu27008_itimes), &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_init_iio_gts(dev, BU27008_SCALE_1X, 0, bu27008_gains_ir,
> +				    ARRAY_SIZE(bu27008_gains_ir), bu27008_itimes,
> +				    ARRAY_SIZE(bu27008_itimes), &data->gts_ir);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +	data->regmap = regmap;
> +	data->dev = dev;
> +	data->irq = i2c->irq;
> +
> +	idev->channels = bu27008_channels;
> +	idev->num_channels = ARRAY_SIZE(bu27008_channels);
> +	idev->name = "bu27008";
> +	idev->info = &bu27008_info;
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

Should be INDIO_BUFFER_TRIGGERRED I think. which is set by
devm_iio_triggered_buffer_setup() for you.  So just DIRECT_MODE here.


> +	idev->available_scan_masks = bu27008_scan_masks;
> +
> +	ret = bu27008_chip_init(data);
> +	if (ret)
> +		return ret;

Blank line here to separate the blocks of connected code from those that
are unrelated.

> +	ret = devm_iio_triggered_buffer_setup_ext(dev, idev,
> +						  &iio_pollfunc_store_time,
> +						  bu27008_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &bu27008_buffer_ops,
> +						  NULL);

I'm guessing this is left from a point in development where last parameter wasn't NULL.
Given it is you can just use the more common
devm_iio_triggered_buffer_setup() that also assumes it's an input buffers (which this is)


> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +	indio_trig = devm_iio_trigger_alloc(dev, "%sdata-rdy-dev%d", idev->name,
> +					    iio_device_id(idev));

Bit of a mix of naming conventions in here. Both occur in various drivers, but
not normally mixed up.  Either
idev, itrig
or
indio_dev, indio_trig

> +	if (!indio_trig)
> +		return -ENOMEM;
> +
> +	data->trig = indio_trig;
> +
> +	indio_trig->ops = &bu27008_trigger_ops;
> +	iio_trigger_set_drvdata(indio_trig, data);
> +
> +	/*
> +	 * No need to check for NULL. request_threaded_irq() defaults to
> +	 * dev_name() should the alloc fail.

Whilst true, it's very unlikely we'll get a failure here and
the code to check is shorter than the comment. Hence I'd just check and error
out on failure anyway in interests of readability and simplicity.


> +	 */
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
> +			      dev_name(data->dev));
> +
> +	ret = devm_request_threaded_irq(data->dev, i2c->irq, bu27008_irq_handler,

(dev, ...
in all of these.

> +					&bu27008_irq_thread_handler,
> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
> +
> +
> +	ret = devm_iio_trigger_register(dev, indio_trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,

Be consistent on data->dev vs dev.  I'd prefer dev as it's shorter.

> +				     "Trigger registration failed\n");
> +
> +	ret = devm_iio_device_register(data->dev, idev);
> +	if (ret < 0)

if (ret) for consistency and as it's documented as never taking a postive value
anyway.


> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}

