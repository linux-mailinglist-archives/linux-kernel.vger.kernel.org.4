Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729946A2FD8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBZNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZNhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:37:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26611BE;
        Sun, 26 Feb 2023 05:37:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7047260C16;
        Sun, 26 Feb 2023 13:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC023C433D2;
        Sun, 26 Feb 2023 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677418670;
        bh=e+K63+jPc0d6paFyvJsrDiBfQkQM0sXKW//u1dNvAlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dyS8PxSVNvmOel3tk3eTqVGc6xxANHX7zXkvEChQfoOwNWF4MzGLB/SeimY9LdTQ4
         qVSDL73ZkuqOQPjjoQ5QMwKpGxdEYfimAh7a8tfx0HAPybxq1zqDRVUVo5hZQSPS0e
         CNKNTZDnDi56dNCkTXFBY8jANGAdv+kVqMa+kHeRNG7xCVGenoCbhyVX7y55hj+n7o
         Z7VQZqJDQovNQuoVljkke7pSKKl8s0iDsEIOr8+Fr1tKiT5UEU4AZ45j5qAWhpHI4i
         aZ9SpdGsuphk8qvxgqYI1Spu3kvoz082hVq2GcWTZOiwwQdHIeeCCJ/wTeLslH0mLk
         YxcppYOTQzGUw==
Date:   Sun, 26 Feb 2023 13:52:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230226135216.3f962b51@jic23-huawei>
In-Reply-To: <02f948ee-34ee-c15e-09e4-d0d8c5161c9b@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
        <02f948ee-34ee-c15e-09e4-d0d8c5161c9b@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 12:41:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 2/22/23 18:15, Matti Vaittinen wrote:
> 
> //snip
> 
> > 	- Driver starts the measurement on the background when it is
> > 	  probed. This improves the respnse time to read-requests
> > 	  compared to starting the read only when data is requested.
> > 	  When the most accurate 400 mS measurement time is used, data reads
> > 	  would last quite long if measurement was started only on
> > 	  demand. This, however, is not appealing for users who would
> > 	  prefere power saving over measurement response time.  
> 
> //snip
> 
> > +static bool bu27034_has_valid_sample(struct bu27034_data *data)
> > +{
> > +	int ret, val;
> > +
> > +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL4, &val);
> > +	if (ret)
> > +		dev_err(data->dev, "Read failed %d\n", ret);
> > +
> > +	return (val & BU27034_MASK_VALID);
> > +}
> > +
> > +static void bu27034_invalidate_read_data(struct bu27034_data *data)
> > +{
> > +	bu27034_has_valid_sample(data);
> > +}
> > +
> > +static int _bu27034_get_result(struct bu27034_data *data, u16 *res, bool lock)
> > +{
> > +	int ret = 0;
> > +
> > +retry:
> > +	if (lock)
> > +		mutex_lock(&data->mutex);
> > +	/* Get new value from sensor if data is ready - or use cached value */
> > +	if (bu27034_has_valid_sample(data)) {
> > +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> > +				       &data->raw[0], sizeof(data->raw));
> > +		if (ret)
> > +			goto unlock_out;
> > +
> > +		data->cached = true;
> > +		bu27034_invalidate_read_data(data);
> > +	} else if (unlikely(!data->cached)) {
> > +		/* No new data in sensor and no value cached. Wait and retry */
> > +		if (lock)
> > +			mutex_unlock(&data->mutex);
> > +		msleep(25);
> > +
> > +		goto retry;
> > +	}
> > +	res[0] = le16_to_cpu(data->raw[0]);
> > +	res[1] = le16_to_cpu(data->raw[1]);
> > +	res[2] = le16_to_cpu(data->raw[2]);
> > +
> > +unlock_out:
> > +	if (lock)
> > +		mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int bu27034_get_result_unlocked(struct bu27034_data *data, u16 *res)
> > +{
> > +	return _bu27034_get_result(data, res, false);
> > +}
> > +
> > +static int bu27034_get_result(struct bu27034_data *data, u16 *res)
> > +{
> > +	return _bu27034_get_result(data, res, true);
> > +}  
> 
> //snip
> 
> > +	case IIO_CHAN_INFO_RAW:
> > +	{
> > +		u16 res[3];
> > +
> > +		if (chan->type != IIO_INTENSITY)
> > +			return -EINVAL;
> > +
> > +		if (chan->channel < BU27034_CHAN_DATA0 ||
> > +		    chan->channel > BU27034_CHAN_DATA2)
> > +			return -EINVAL;
> > +		/*
> > +		 * Reading one channel at a time is inefficient.
> > +		 *
> > +		 * Hence we run the measurement on the background and always
> > +		 * read all the channels. There are following caveats:
> > +		 * 1) The VALID bit handling is racy. Valid bit clearing is not
> > +		 * tied to reading the data in the hardware. We clear the
> > +		 * valid-bit manually _after_ we have read the data - but this
> > +		 * means there is a small time-window where new result may
> > +		 * arrive between read and clear. This means we can miss a
> > +		 * sample. For normal use this should not be fatal because
> > +		 * usually the light is changing slowly. There might be
> > +		 * use-cases for measuring more rapidly changing light but this
> > +		 * driver is unsuitable for those cases anyways. (Smallest
> > +		 * measurement time we support is 55 mS.)
> > +		 * 2) Data readings more frequent than the meas_time will return
> > +		 * the same cached values. This should not be a problem for the
> > +		 * very same reason 1) is not a problem.
> > +		 */
> > +		ret = bu27034_get_result(data, &res[0]);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = res[chan->channel - BU27034_CHAN_DATA0];
> > +
> > +		return IIO_VAL_INT;
> > +	}  
> 
> //snip
> 
> > +static int bu27034_chip_init(struct bu27034_data *data)
> > +{  
> 
> //snip
> 
> > +
> > +	/*
> > +	 * Consider disabling the measurement (and powering off the sensor) for
> > +	 * runtime pm
> > +	 */
> > +	ret = bu27034_meas_en(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(data->dev, bu27034_meas_stop, data);
> > +}  
> 
> Well, this "works on my machine" - but I am slightly unhappy with this. 
> I have a feeling I am effectively making a poor, reduced version of data 
> buffering here. I am starting to think that I should
> 
> a) Not start measurement at chip init. (saves power)
> b) Start measurement at raw-read and just block for damn long for each 
> raw-read. Yep, it probably means that users who want to raw-read all 
> channels will be blocking 4 * measurement time when they are reading all 
> channels one after another. Yes, this is in worst case 4 * 400 mS. 
> Horrible. But see (c) below.

Hmm. Light sensors tend to be slow in some modes, but rarely do people actually
have such low light levels that they are using them with 400mS integration times.

> c) Implement triggered_buffer mode. Here my lack of IIO-experience shows 
> up again. I have no idea if there is - or what is - the "de facto" way 
> for implementing this when our device has no IRQ? I could cook-up some 
> 'tiny bit shorter than the measurement time' period timer which would 
> kick the driver to poll the VALID-bit - or, because we need anyways to 
> poll the valid bit from process context - just a kthread which polls the 
> VALID-bit. Naturally the thread/timer should be only activated when the 
> trigger is enabled.

Firstly you don't have to have a trigger. In a case where it's a bit hacky
and unlikely to be particularly useful for other devices, you can just implement
a buffer directly.

There are various options that exist.. 
1) iio-trig-loop - this is nasty but occasionally useful approach.  You then
   make the iio_poll_func wait on the flag.
2) Drivers that do exactly what you describe with their own management of timing.
  grep for kthread should find something.

> 
> Actually, my question (with this driver, the big question in the RFC is 
> the gain-time-scale helper) seems to be - should I implement 
> triggered_buffer and do we have some generic IIO trigger (timer or 
> thread or whatever) the driver could use or should each driver (which 
> needs this) implement own one?

It's a bit hard because we don't generally know how to hint the timing to
a trigger.  But we do have the loop trigger that spins as fast as possible
thus allowing devices to then take a long time to read.  It was added for
a similar case (something like a pressure sensor on a drone IIRC) though
not sure anyone uses it much currently.

Jonathan

> 
> 
> Thanks for the patience :)
> 	-- Matti
> 

