Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0574BDDB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGHOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36CE56;
        Sat,  8 Jul 2023 07:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F3AE60D24;
        Sat,  8 Jul 2023 14:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F82DC433C7;
        Sat,  8 Jul 2023 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826820;
        bh=BtREnF/FHSlJj9mFLLZpBLSlekgW0q2HSfzaVXuq4DA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SrUxWRlzBX6GT6bmGeWsIPLQOykYMiLC9cvbhWvuHYY9EMfPGyP+alz5Mw71nTb1g
         TZKktVT/4+mbNb+K4ocA76N+Xtsw0aSiAbc3z9jcc9xVisMx8Tik+rC1bgu1JWrfKF
         QivngfYrUSWCRPj1pmtX2jdhDrXtdVw29VpZ6HY3ZF1C+m2ErC8uwgamxaBDyagHDK
         Euz+A8YmxgylLt54lwxTdcVu8s/jt0whzE9td6ZCF+3uBYXbFVTN7xnSIb+MA/z25v
         VoL2+m0M6RzF4z0RUjOd2SpGGvjw7hsSAeGmUK+Gp5aJthUNiiKkjlFhd/aJQBI8vW
         dvRjmPJaR4XIg==
Date:   Sat, 8 Jul 2023 15:33:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd4x: Add pressure compensation
Message-ID: <20230708153334.034995d9@jic23-huawei>
In-Reply-To: <e575a7b0-20a4-39c6-9fa5-87185108e683@protonic.nl>
References: <20230704084706.370637-1-roan@protonic.nl>
        <20230706092819.000022df@Huawei.com>
        <e575a7b0-20a4-39c6-9fa5-87185108e683@protonic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Thu, 6 Jul 2023 14:27:26 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> It seems I missed that one, didn't know it you can't have a channel with 
> only calibias.
> In the next version of this patch I will change it to an output channel 
> like the other cases.
> I saw the scd30 did this as well.
It's not so much that you can't have such a channel, more that we seem
to have sort of standardized on using a straight forward output for this.

Doesn't change the suggestion for this patch, but there 'might' be a usecase
for such a channel in the future..

Jonathan

> 
> Roan
> 
> On 06-07-2023 03:28, Jonathan Cameron wrote:
> > On Tue,  4 Jul 2023 10:47:06 +0200
> > Roan van Dijk<roan@protonic.nl>  wrote:
> >  
> >> This patch adds pressure compensation to the scd4x driver. The pressure can
> >> be written to the sensor in hPa. The pressure will be compensated
> >> internally by the sensor.
> >>
> >> Signed-off-by: Roan van Dijk<roan@protonic.nl>  
> > Why treat this as a channel with just calibbias?
> >  From what I can recall we've previous treated such cases as an
> > output channel with the advantage that the units are then fully
> > defined.  I may well be forgetting some argument or a case that
> > does it with calibbias though.
> >
> > Jonathan
> >
> >  
> >> ---
> >>   drivers/iio/chemical/scd4x.c | 41 +++++++++++++++++++++++++++++++++---
> >>   1 file changed, 38 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> >> index a4f22d926400..fe6b3f3f7186 100644
> >> --- a/drivers/iio/chemical/scd4x.c
> >> +++ b/drivers/iio/chemical/scd4x.c
> >> @@ -36,6 +36,8 @@
> >>   #define SCD4X_WRITE_BUF_SIZE 5
> >>   #define SCD4X_FRC_MIN_PPM 0
> >>   #define SCD4X_FRC_MAX_PPM 2000
> >> +#define SCD4X_AMB_PRESSURE_MIN 700
> >> +#define SCD4X_AMB_PRESSURE_MAX 1200
> >>   #define SCD4X_READY_MASK 0x01
> >>   
> >>   /*Commands SCD4X*/
> >> @@ -45,6 +47,8 @@ enum scd4x_cmd {
> >>   	CMD_STOP_MEAS           = 0x3f86,
> >>   	CMD_SET_TEMP_OFFSET     = 0x241d,
> >>   	CMD_GET_TEMP_OFFSET     = 0x2318,
> >> +	CMD_SET_AMB_PRESSURE	= 0xe000,
> >> +	CMD_GET_AMB_PRESSURE	= 0xe000,
> >>   	CMD_FRC                 = 0x362f,
> >>   	CMD_SET_ASC             = 0x2416,
> >>   	CMD_GET_ASC             = 0x2313,
> >> @@ -373,7 +377,10 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
> >>   		return IIO_VAL_INT_PLUS_MICRO;
> >>   	case IIO_CHAN_INFO_CALIBBIAS:
> >>   		mutex_lock(&state->lock);
> >> -		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
> >> +		if (chan->type == IIO_TEMP)
> >> +			ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
> >> +		else if (chan->type == IIO_PRESSURE)
> >> +			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
> >>   		mutex_unlock(&state->lock);
> >>   		if (ret)
> >>   			return ret;
> >> @@ -386,6 +393,25 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
> >>   	}
> >>   }
> >>   
> >> +static const int scd4x_pressure_calibbias_available[] = {
> >> +	SCD4X_AMB_PRESSURE_MIN, 1, SCD4X_AMB_PRESSURE_MAX,
> >> +};
> >> +
> >> +static int scd4x_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> >> +			    const int **vals, int *type, int *length, long mask)
> >> +{
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_CALIBBIAS:
> >> +		*vals = scd4x_pressure_calibbias_available;
> >> +		*type = IIO_VAL_INT;
> >> +
> >> +		return IIO_AVAIL_RANGE;
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +
> >>   static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> >>   				int val, int val2, long mask)
> >>   {
> >> @@ -395,9 +421,11 @@ static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
> >>   	switch (mask) {
> >>   	case IIO_CHAN_INFO_CALIBBIAS:
> >>   		mutex_lock(&state->lock);
> >> -		ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
> >> +		if (chan->type == IIO_TEMP)
> >> +			ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
> >> +		else if (chan->type == IIO_PRESSURE)
> >> +			ret = scd4x_write(state, CMD_SET_AMB_PRESSURE, val);
> >>   		mutex_unlock(&state->lock);
> >> -
> >>   		return ret;
> >>   	default:
> >>   		return -EINVAL;
> >> @@ -503,9 +531,16 @@ static const struct iio_info scd4x_info = {
> >>   	.attrs = &scd4x_attr_group,
> >>   	.read_raw = scd4x_read_raw,
> >>   	.write_raw = scd4x_write_raw,
> >> +	.read_avail = scd4x_read_avail,
> >>   };
> >>   
> >>   static const struct iio_chan_spec scd4x_channels[] = {
> >> +	{
> >> +		.type = IIO_PRESSURE,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),
> >> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS),
> >> +		.scan_index = -1,
> >> +	},
> >>   	{
> >>   		.type = IIO_CONCENTRATION,
> >>   		.channel2 = IIO_MOD_CO2,  

