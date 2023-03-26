Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7D6C969E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjCZQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjCZQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C37ABD;
        Sun, 26 Mar 2023 09:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D4160F08;
        Sun, 26 Mar 2023 16:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B8C433EF;
        Sun, 26 Mar 2023 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679846689;
        bh=WKccT1h5XfTtlzLxHv3J7Dgzv4Ryg5YYOKnQQmn72H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sI+HbKR+65CNu5jrwNIFK533ioyoPaGWeIt0lGYMPBK/YHU+0S1ThbZ0qq9tu/SmY
         0p5puTIWZQQ3/ezyHg8HycJPLgjBvFEF/+iBOuyX448qidEb/sFc8HDzkw2K2MvWvR
         CZeFD2uk/vnKXWCBtEU5uXc8ChK9Glp5VcrexMAz2ENaJWxRDmN6DpSvyyD8Z1RBB2
         +US660vcMMbO2tpmO0WZKFXqP7DekOxafB87lcdZMnpve6rLh2CJ8eIkMKkBqsyiTh
         5kEnCoaG3k3PPhuxp8K2E+9Vk6ZpO/MGMPP/rB6P5ZXmvo0xKXfcdag5uP6h2t7j4m
         PzcMtMcvNeIUw==
Date:   Sun, 26 Mar 2023 17:19:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 7/8] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230326171951.0e815ec3@jic23-huawei>
In-Reply-To: <af8901957884c9c658be21ee89f837d5ca4ddac9.1679474247.git.mazziesaccount@gmail.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
        <af8901957884c9c658be21ee89f837d5ca4ddac9.1679474247.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 11:07:56 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment alone can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property that can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to try to adjust the GAIN so that the
> 	  overall scale is kept as close to the original as possible.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Hi Matti,

A few minor comments inline.  I'll take a closer look at the rest of the
series when the discussions around the tests and devices to be used
for them settle down.

Thanks,

Jonathan

> +
> +static u64 bu27034_fixp_calc_t1(unsigned int coeff, unsigned int ch0,
> +				unsigned int ch1, unsigned int gain0,
> +				unsigned int gain1)
> +{
> +	unsigned int helper, tmp;
> +	u64 helper64;
> +
> +	/*
> +	 * Here we could overflow even the 64bit value. Hence we
> +	 * multiply with gain0 only after the divisions - even though
> +	 * it may result loss of accuracy
> +	 */
> +	helper64 = (u64)coeff * (u64)ch1 * (u64)ch1;
> +	helper = coeff * ch1 * ch1;
> +	tmp = helper * gain0;
> +
> +	if (helper == helper64 && (tmp / gain0 == helper))

Similar to below.  Don't bother with the non 64 bit version.

> +		return tmp / (gain1 * gain1) / ch0;
> +
> +	helper = gain1 * gain1;
> +	if (helper > ch0) {
> +		do_div(helper64, helper);
> +
> +		return gain_mul_div_helper(helper64, gain0, ch0);
> +	}
> +
> +	do_div(helper64, ch0);
> +
> +	return gain_mul_div_helper(helper64, gain0, helper);
> +}
> +
> +static u64 bu27034_fixp_calc_t23(unsigned int coeff, unsigned int ch,
> +				 unsigned int gain)
> +{
> +	unsigned int helper;
> +	u64 helper64;
> +
> +	helper64 = (u64)coeff * (u64)ch;
> +	helper = coeff * ch;
> +
> +	if (helper == helper64)
> +		return helper / gain;
> +
> +	do_div(helper64, gain);
> +
> +	return helper64;

I suspect that this is a premature bit of optimization so I'd just
do it in 64 bits always.

Also, if you did want to do this, check_mul_overflow() etc would help.
(linux/overflow.h)


> +}

> +
> +static int bu27034_calc_mlux(struct bu27034_data *data, __le16 *res, int *val)
> +{
> +	unsigned int gain0, gain1, meastime;
> +	unsigned int d1_d0_ratio_scaled;
> +	u16  ch0, ch1;

Stray space after the u16

> +	u64 helper64;
> +	int ret;
> +
> +	/*
> +	 * We return 0 luxes if calculation fails. This should be reasonably

0 lux 
(I think)

> +	 * easy to spot from the buffers especially if raw-data channels show
> +	 * valid values
> +	 */
