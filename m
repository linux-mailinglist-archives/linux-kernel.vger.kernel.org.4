Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B266AB34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjANLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:37:33 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E093A9E
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 03:37:32 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 5CB211B001E6;
        Sat, 14 Jan 2023 13:37:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673696246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHAgeT9fE6pOE0z6NcA1m9r1NboS0o+w2mo9Eni7BvQ=;
        b=sQvy3jfvIqc2lkU3dbT/bE8QTrS7qfEW3nQXZ1/K5w0vELaBiVRWIas59OlQuUl5Tefiry
        u+jzN6AqWgJ4UZcBqTQybX/wl+0lyEBtZ2oxvF4zihFDB7swhT+Hc/68vyPQAb2jk4/0zn
        oGmp54bVWfYC60c1ZJwN0/bvvMeOzAG3DGk8Hz1IQBdnUGzx5VoEsxZYLaQzg2iHiedI/C
        mrxruitVUMWA25TnuciTMhq/MD7r6eu7beMGYR3rQLQ4Z3Sau7+4oKEXh/w1xYpvmJWfEr
        YV2OJHP8Ku2wXOYC1UTIDq4ZD8vFzZ+ZHkv0HONyqq2kX5Tb8N+c2+Od3gAZhg==
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 39D2220168;
        Sat, 14 Jan 2023 13:37:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1673696240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHAgeT9fE6pOE0z6NcA1m9r1NboS0o+w2mo9Eni7BvQ=;
        b=GaRZ/vTu/Tn20PMGAhFIsqlIGYo21OqQRUC5wgSp25c6/fcYI2hBUvrsvpuZF2FwskOFmd
        m1jJv9SaTWuoMe2VheT7TqkWdyfo3TgHxhyMyYooLsA3KdEBWMlHDfuR9e8sWLZmP+EjV6
        EuvkSQhlS3z39h8xMsGfDfeGsWEyH/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1673696240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHAgeT9fE6pOE0z6NcA1m9r1NboS0o+w2mo9Eni7BvQ=;
        b=oe3W7Jqg1knHnxvxEBhC07XE1JgbdYVR+RJSeYdIAYDg5E7fVKTL1yCrbPitjdWDyD+Ei1
        YDLcEKD9yqOUwUme2xsvjIDDIjbsV9VMyB+NfSNe0pPznCr2y+RLSwInTZfZ9ncVSnXJwt
        G/l8H/Iic05i0AtPzlpzOSBFpbyAlaU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1673696240; a=rsa-sha256; cv=none;
        b=YzUkxOzOcio//uqVPj2pHJ5q5tHfE32chgttuV1UVBZm16aDnWcGle9Yl2XsGRhkgu3B96
        o39dnSCVlkhSyAHWo4Cn0ugfdr6rNcRZlo+gC8TiP8iNIJ3OS60mAcZSW190uIeMEx6VLb
        Bu6DynnZOjEFpXpRSS7dLinpsuhm3Hs=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A0448634C91;
        Sat, 14 Jan 2023 13:37:19 +0200 (EET)
Date:   Sat, 14 Jan 2023 13:37:19 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] media: i2c: imx334: update pixel and link
 frequency
Message-ID: <Y8KT70qSSVnFiQJG@valkosipuli.retiisi.eu>
References: <20230113010135.2620818-1-shravan.chippa@microchip.com>
 <20230113010135.2620818-5-shravan.chippa@microchip.com>
 <20230113093133.6lqbnlhqkyhzhwyd@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113093133.6lqbnlhqkyhzhwyd@uno.localdomain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, Shravan,

On Fri, Jan 13, 2023 at 10:31:33AM +0100, Jacopo Mondi wrote:
> Hi Shravan
> 
> On Fri, Jan 13, 2023 at 06:31:35AM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Update pixel_rate and link frequency for 1920x1080@30
> > while changing mode.
> >
> > Add dummy ctrl cases for pixel_rate and link frequency
> > to avoid error while changing the modes dynamically
> >
> > Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >  drivers/media/i2c/imx334.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> > index 4ab1b9eb9a64..373022fbd6b2 100644
> > --- a/drivers/media/i2c/imx334.c
> > +++ b/drivers/media/i2c/imx334.c
> > @@ -49,7 +49,8 @@
> >  #define IMX334_INCLK_RATE	24000000
> >
> >  /* CSI2 HW configuration */
> > -#define IMX334_LINK_FREQ	891000000
> > +#define IMX334_LINK_FREQ_891M	891000000
> > +#define IMX334_LINK_FREQ_445M	445500000
> 
> Good!
> 
> >  #define IMX334_NUM_DATA_LANES	4
> >
> >  #define IMX334_REG_MIN		0x00
> > @@ -144,7 +145,8 @@ struct imx334 {
> >  };
> >
> >  static const s64 link_freq[] = {
> > -	IMX334_LINK_FREQ,
> > +	IMX334_LINK_FREQ_891M,
> > +	IMX334_LINK_FREQ_445M,
> >  };
> >
> >  /* Sensor mode registers */
> > @@ -468,7 +470,7 @@ static const struct imx334_mode supported_modes[] = {
> >  		.vblank_min = 45,
> >  		.vblank_max = 132840,
> >  		.pclk = 297000000,
> > -		.link_freq_idx = 0,
> > +		.link_freq_idx = 1,
> >  		.reg_list = {
> >  			.num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
> >  			.regs = mode_1920x1080_regs,
> > @@ -598,6 +600,11 @@ static int imx334_update_controls(struct imx334 *imx334,
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = __v4l2_ctrl_modify_range(imx334->pclk_ctrl, mode->pclk,
> > +				       mode->pclk, 1, mode->pclk);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
> >  				       mode->hblank, 1, mode->hblank);
> >  	if (ret)
> > @@ -698,6 +705,8 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
> >  		pm_runtime_put(imx334->dev);
> >
> >  		break;
> > +	case V4L2_CID_PIXEL_RATE:
> > +	case V4L2_CID_LINK_FREQ:
> >  	case V4L2_CID_HBLANK:
> >  		ret = 0;
> >  		break;
> > @@ -1102,7 +1111,7 @@ static int imx334_parse_hw_config(struct imx334 *imx334)
> >  	}
> >
> >  	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> > -		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ)
> > +		if (bus_cfg.link_frequencies[i] == IMX334_LINK_FREQ_891M)
> 
> Is it legit to specify 445MHz in device tree ? I think so, as it's one
> of the frequencies the sensor can operate at. If that's the case the
> code here will fail, as it only recognize 891MHz ?
> 
> The DTS property serve to specify a sub-set of all the link-frequencies the
> driver can to operate at. If a dtb specifies 445MHz only, it means
> your driver cannot operate at 891MHz full resolution mode. Sakari, is
> my understanding correct here ?
> 
> In theory you could require dtbs to support both frequencies, but
> old dtbs will only have 891MHz specified, should they continue to work but
> with only the full resolution mode available ?

The driver should enable only those frequencies present in DT here, and one
matching frequency is enough for the driver to work.

Also the CCS driver does this but it does quite a bit more as well. The
code below seems good to me, too (see comments).

> 
> A possible way out is to:
> 
> 1) Collect the allowed frequencies at dtbs probe time
> 
>         static const s64 link_freq[] = {
>                 IMX334_LINK_FREQ_891M,
>                 IMX334_LINK_FREQ_445M,

This should go to the control framework menu.

>         };
>         static s64 enabled_link_freq[ARRAY_SIZE(link_freq)] = {};
> 
> 
>         ...
> 
>   	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
>                 for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
>                         if (bus_cfg.link_frequencies[i] == link_freq[j])
>                                 enabled_link_frequencies[j] = link_freq[j];

I'd use a bit mask you can pass to the control framework directly.

>                 }
>         }
> 
>         for (i = 0; i < ARRAY_SIZE(link_freq); i++) {
>                 if (enabled_link_freq[i] != 0)
>                         break;

With a bitmask, you can remove this entirely loop.

>         }
>         if (i == ARRAY_SIZE(link_freq)) {
> 		dev_err(imx334->dev, "no valid link frequencies in DTS");
> 		ret = -EINVAL;
> 		goto done_endpoint_free;
>         }
> 
>         ...
> 
> 2) When enumerating or setting mode, make sure the mode's
>    enabled_link_freq[mode->link_freq_idx] != 0
> 
>    but this might quickly get complex and error prone.
> 
> Sakari, what is the best way to handle situations like this one ?
> The driver is upstream working with a single link_frequency of 891MHz.
> A new link frequency is added, and it is now allowed to have DTS
> specify both frequencies, or just one of them. Should the driver rule
> out all modes that require a link_frequency not specified in DTS ?
> 
> There are several examples of drivers handling multiple link_freqs in
> media/i2c/ but I haven't find out that filters the modes according to
> the specified frequencies (I admit I only quickly looked).

-- 
Kind regards,

Sakari Ailus
