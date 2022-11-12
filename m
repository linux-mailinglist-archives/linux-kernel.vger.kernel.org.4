Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870FD626AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiKLRP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8513EE2A;
        Sat, 12 Nov 2022 09:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7384FB808CB;
        Sat, 12 Nov 2022 17:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A2C433D6;
        Sat, 12 Nov 2022 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668273353;
        bh=W31q06kN6rnrEtl4xOhZtSzA3v0LdvOyhIGkt0wJ+qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OG06CHCgCNb1f3Z5xVnsufEOxvnIUMX1iwoRyR6BvuZ7Ux2yFddiB8gv5heoI52dx
         w0iqDpas46leFKA1cggeKyvmZF7Sml8obCgi2zhr2WPTsdqjy+Xpwvri19uRzbc+y4
         eCdsgnsyVxBEnIJEMkO1OG8qiBFygOsVbNjJjJmGwUch1QLzSlkhDyJdTdC/UNSN6e
         QS+R2asIntMKcL0VD7Wdn8PAnnleS0PJI7PXf8IUB2LXY5f7UGnGYEcyx9DEkCg8fH
         uvL4GBMKKW24AkT5UZJbN3s/GJZGfUNkIIMPsVlEHKXbOKAzbZhr2cx3EPPBfmJAza
         ElGSZk9FMcyVA==
Date:   Sat, 12 Nov 2022 17:28:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: mcp3422: allow setting gain and sampling
 per channel
Message-ID: <20221112172806.6db090eb@jic23-huawei>
In-Reply-To: <20221111112657.1521307-3-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-3-mitja@lxnav.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 12:26:54 +0100
Mitja Spes <mitja@lxnav.com> wrote:

> General improvements:
> - allow setting gain and sampling per channel
> - setting scale can also set sampling rate (combined setting)
> - use per channel config setting
> - do not update mcp register on setting write (we might be reading it...)
>   instead it's updated on next value read
> - output all scale values (sample rates x gain)
> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
Hi Mitja,

Was it possible for these scales to differ before this change?
If not, then why was the previous patch a fix rather than simply a precursor
to this change (where it now matters).

There are a number of changes in here which are more stylistic cleanup
than anything to do with the functional change. Please pull those out
to a precursor patch where we can quickly check they make not functional changes
rather than having them mixed in here.

> ---
>  drivers/iio/adc/mcp3422.c | 119 ++++++++++++++++++++------------------
>  1 file changed, 64 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 3d53de300c89..cfb629b964af 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -28,14 +28,19 @@
>  #define MCP3422_CHANNEL_MASK	0x60
>  #define MCP3422_PGA_MASK	0x03
>  #define MCP3422_SRATE_MASK	0x0C
> -#define MCP3422_SRATE_240	0x0
> -#define MCP3422_SRATE_60	0x1
> -#define MCP3422_SRATE_15	0x2
> -#define MCP3422_SRATE_3	0x3
> -#define MCP3422_PGA_1	0
> -#define MCP3422_PGA_2	1
> -#define MCP3422_PGA_4	2
> -#define MCP3422_PGA_8	3
> +
> +#define MCP3422_SRATE_240	0
> +#define MCP3422_SRATE_60	1
> +#define MCP3422_SRATE_15	2
> +#define MCP3422_SRATE_3		3
I have no particular problem with taking these from hex
to decimal, though I'm not really seeing the necessity.

However, it is really a style question and should not be in this
patch where it mostly adds noise making it slightly harder
to spot the functional changes.

> +#define MCP3422_SRATE_COUNT	4
> +
> +#define MCP3422_PGA_1		0
> +#define MCP3422_PGA_2		1
> +#define MCP3422_PGA_4		2
> +#define MCP3422_PGA_8		3
> +#define MCP3422_PGA_COUNT	4
> +
>  #define MCP3422_CONT_SAMPLING	0x10
>  
>  #define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
> @@ -52,32 +57,32 @@
>  		.indexed = 1, \
>  		.channel = _index, \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
> -				| BIT(IIO_CHAN_INFO_SCALE), \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +				| BIT(IIO_CHAN_INFO_SCALE) \
> +				| BIT(IIO_CHAN_INFO_SAMP_FREQ), \

Hmm. This is an ABI change.  Hopefully no one will notice however.

>  	}
>  
> -static const int mcp3422_scales[4][4] = {
> +static const int mcp3422_scales[MCP3422_SRATE_COUNT][MCP3422_PGA_COUNT] = {
>  	{ 1000000, 500000, 250000, 125000 },
>  	{ 250000,  125000, 62500,  31250  },
>  	{ 62500,   31250,  15625,  7812   },
>  	{ 15625,   7812,   3906,   1953   } };
>  
>  /* Constant msleep times for data acquisitions */
> -static const int mcp3422_read_times[4] = {
> +static const int mcp3422_read_times[MCP3422_SRATE_COUNT] = {
Reasonable to make this change, but I think it belongs in a precursor patch.

>  	[MCP3422_SRATE_240] = 1000 / 240,
>  	[MCP3422_SRATE_60] = 1000 / 60,
>  	[MCP3422_SRATE_15] = 1000 / 15,
>  	[MCP3422_SRATE_3] = 1000 / 3 };
>  
>  /* sample rates to integer conversion table */
> -static const int mcp3422_sample_rates[4] = {
> +static const int mcp3422_sample_rates[MCP3422_SRATE_COUNT] = {
>  	[MCP3422_SRATE_240] = 240,
>  	[MCP3422_SRATE_60] = 60,
>  	[MCP3422_SRATE_15] = 15,
>  	[MCP3422_SRATE_3] = 3 };
>  
>  /* sample rates to sign extension table */
> -static const int mcp3422_sign_extend[4] = {
> +static const int mcp3422_sign_extend[MCP3422_SRATE_COUNT] = {
>  	[MCP3422_SRATE_240] = 11,
>  	[MCP3422_SRATE_60] = 13,
>  	[MCP3422_SRATE_15] = 15,
> @@ -87,8 +92,8 @@ static const int mcp3422_sign_extend[4] = {
>  struct mcp3422 {
>  	struct i2c_client *i2c;
>  	u8 id;
> -	u8 config;
> -	u8 pga[4];
> +	u8 active_config; // config currently set on mcp
> +	u8 ch_config[4];  // per channel config
>  	struct mutex lock;
>  };
>  
> @@ -98,7 +103,7 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
>  
>  	ret = i2c_master_send(adc->i2c, &newconfig, 1);
>  	if (ret > 0) {
> -		adc->config = newconfig;
> +		adc->active_config = newconfig;
>  		ret = 0;
>  	}
>  
> @@ -108,7 +113,7 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
>  static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
>  {
>  	int ret = 0;
> -	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> +	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->active_config);
>  	u8 buf[4] = {0, 0, 0, 0};
>  	u32 temp;
>  
> @@ -136,18 +141,13 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  
>  	mutex_lock(&adc->lock);
>  
> -	if (req_channel != MCP3422_CHANNEL(adc->config)) {
> -		config = adc->config;
> -		config &= ~MCP3422_CHANNEL_MASK;
> -		config |= MCP3422_CHANNEL_VALUE(req_channel);
> -		config &= ~MCP3422_PGA_MASK;
> -		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> -		ret = mcp3422_update_config(adc, config);
> +	if (adc->ch_config[req_channel] != adc->active_config) {
> +		ret = mcp3422_update_config(adc, adc->ch_config[req_channel]);
>  		if (ret < 0) {
>  			mutex_unlock(&adc->lock);
>  			return ret;
>  		}
> -		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
> +		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->active_config)]);
>  	}
>  
>  	ret = mcp3422_read(adc, value, &config);
> @@ -164,9 +164,9 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  	struct mcp3422 *adc = iio_priv(iio);
>  	int err;
>  
> -	u8 req_channel = channel->channel;
> -	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> -	u8 pga		 = adc->pga[req_channel];
> +	u8 config = adc->ch_config[channel->channel];
> +	u8 sample_rate = MCP3422_SAMPLE_RATE(config);
> +	u8 pga = MCP3422_PGA(config);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -181,7 +181,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  		return IIO_VAL_INT_PLUS_NANO;
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val1 = mcp3422_sample_rates[MCP3422_SAMPLE_RATE(adc->config)];
> +		*val1 = mcp3422_sample_rates[sample_rate];
>  		return IIO_VAL_INT;
>  
>  	default:
> @@ -197,26 +197,25 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  {
>  	struct mcp3422 *adc = iio_priv(iio);
>  	u8 temp;
> -	u8 config = adc->config;
>  	u8 req_channel = channel->channel;
> -	u8 sample_rate = MCP3422_SAMPLE_RATE(config);
> -	u8 i;
> +	u8 config = adc->ch_config[req_channel];
> +	u8 i, j;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		if (val1 != 0)
>  			return -EINVAL;
>  
> -		for (i = 0; i < ARRAY_SIZE(mcp3422_scales[0]); i++) {
> -			if (val2 == mcp3422_scales[sample_rate][i]) {
> -				adc->pga[req_channel] = i;
> -
> -				config &= ~MCP3422_CHANNEL_MASK;
> -				config |= MCP3422_CHANNEL_VALUE(req_channel);
> -				config &= ~MCP3422_PGA_MASK;
> -				config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> -
> -				return mcp3422_update_config(adc, config);
> +		for (j = 0; j < MCP3422_SRATE_COUNT; j++) {
> +			for (i = 0; i < MCP3422_PGA_COUNT; i++) {
> +				if (val2 == mcp3422_scales[j][i]) {
> +					config &= ~MCP3422_PGA_MASK;
> +					config |= MCP3422_PGA_VALUE(i);
> +					config &= ~MCP3422_SRATE_MASK;
> +					config |= MCP3422_SAMPLE_RATE_VALUE(j);
> +					adc->ch_config[req_channel] = config;
> +					return 0;
> +				}
>  			}
>  		}
>  		return -EINVAL;
> @@ -241,12 +240,10 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  			return -EINVAL;
>  		}
>  
> -		config &= ~MCP3422_CHANNEL_MASK;
> -		config |= MCP3422_CHANNEL_VALUE(req_channel);
>  		config &= ~MCP3422_SRATE_MASK;
>  		config |= MCP3422_SAMPLE_RATE_VALUE(temp);
> -
> -		return mcp3422_update_config(adc, config);
> +		adc->ch_config[req_channel] = config;
> +		return 0;
>  
>  	default:
>  		break;
> @@ -282,14 +279,18 @@ static ssize_t mcp3422_show_samp_freqs(struct device *dev,
>  static ssize_t mcp3422_show_scales(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
> -	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> -
> -	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
> -		mcp3422_scales[sample_rate][0],
> -		mcp3422_scales[sample_rate][1],
> -		mcp3422_scales[sample_rate][2],
> -		mcp3422_scales[sample_rate][3]);
> +	ssize_t count = 0;
> +	int i;
> +
> +	for (i = 0; i < MCP3422_SRATE_COUNT; i++) {
> +		count += sprintf(buf + count, "0.%09u 0.%09u 0.%09u 0.%09u%s",
> +			mcp3422_scales[i][0],
> +			mcp3422_scales[i][1],
> +			mcp3422_scales[i][2],
> +			mcp3422_scales[i][3],
> +			(i < MCP3422_SRATE_COUNT - 1 ? " " : "\n"));

What does the output of this now look like?
For available attributes we tend to only show the values available assuming
just the one thing is changing.  Hence hold sampling frequency static, then
show what scales are available
It can get complex if there are nasty interactions so we might have a
situation where one attribute allows to all the possible values.
So maybe we have all scales available and on a write try to find
the nearest frequency to the current at which we can deliver the
required scale.

Right now this looks like it prints repeated values...

My gut feeling for this device is make the sampling frequency the dominant
attribute.  So just list the available sampling frequencies not taking
scale into account.  For current sampling frequency just list the available
scales and only accept those to be written to the scale attr.

> +	}
> +	return count;
>  }
>  
>  static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> @@ -336,6 +337,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct mcp3422 *adc;
>  	int err;
> +	int i;
>  	u8 config;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> @@ -376,6 +378,13 @@ static int mcp3422_probe(struct i2c_client *client,
>  	}
>  
>  	/* meaningful default configuration */
> +	for (i = 0; i < 4; i++) {
> +		adc->ch_config[i] = (MCP3422_CONT_SAMPLING
> +		| MCP3422_CHANNEL_VALUE(i)
> +		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
> +		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> +	}
> +
>  	config = (MCP3422_CONT_SAMPLING
>  		| MCP3422_CHANNEL_VALUE(0)
>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)

Perhaps use the first channel configuration for this?


