Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAD6B94EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjCNMwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjCNMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:51:54 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0AA8C54;
        Tue, 14 Mar 2023 05:47:47 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbYFC2xbQzyQx;
        Tue, 14 Mar 2023 14:46:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678798015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNIkTOGZVK9lg+P67YKrsMU3zZ3VzJ0rYweBwLq8Dxw=;
        b=CsnpN5mkjzySx2lPYqXfQDvH4jFlroc32LqoQ7YO9uzrNtLLzX/H6AErLQcYUdptPeduao
        MAI7UvbHtfJFH/mlPVVnvwqbUnHmCXGJNItCqMElrSsoTfmUZyXo1w96rgafFwthi5/R3b
        rtPGuyqq20Vevoo3dgsg39e+wnSXV+E=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678798015; a=rsa-sha256; cv=none;
        b=LI+w63Eey2sycwDbYI2durS9vK02pufQF+vGQEhbNM6zT/U8Bd6f4kt520nXfbnXRjCgOs
        0LEIYzPz+RZ1kRJi2Uvk2bWZkvQOAFMfxKxBwDM8GhRm2vyhQxvs/Y1jt2vsgLDtjNZmek
        enJS6uPyyqorT2qMinWWwWOYVV/mQHM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678798015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNIkTOGZVK9lg+P67YKrsMU3zZ3VzJ0rYweBwLq8Dxw=;
        b=fsb1XSSfAFePp6Xsg3wZ4K/N7TQGj/rNcs6DAKR/LLRIOv1YZrYAMmc+drWOYRVA/lB6Ev
        f6vlzzf/bTDVvBsVtVwkiD3pOpKcjx1irYwSQGdMqI3uvu8jvnJJToRaBG2AYYkbAgxOdg
        raPHCDz9wRyriSQXwY8Y8lAEvwRTMMA=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 61E56634C92;
        Tue, 14 Mar 2023 14:45:53 +0200 (EET)
Date:   Tue, 14 Mar 2023 14:45:53 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Tue, Mar 14, 2023 at 01:32:16PM +0100, Francesco Dolcini wrote:
> Hello Sakari,
> 
> On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
> > On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > 
> > > Implement the introduced get_mbus_config operation to report the
> > > config of the MIPI CSI-2, BT.656 and Parallel interface.
> > > 
> > > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > > Changes in v2:
> > > - Take care of MIPI CSI-2, BT.656 and Parallel interface as
> > >   pointed out by Jacopo. Thanks!
> > > 
> > >  drivers/media/i2c/ov5640.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > > index 1536649b9e90..43373416fcba 100644
> > > --- a/drivers/media/i2c/ov5640.c
> > > +++ b/drivers/media/i2c/ov5640.c
> > > @@ -3774,6 +3774,24 @@ static int ov5640_init_cfg(struct v4l2_subdev *sd,
> > >  	return 0;
> > >  }
> > >  
> > > +static int ov5640_get_mbus_config(struct v4l2_subdev *sd,
> > > +				   unsigned int pad,
> > > +				   struct v4l2_mbus_config *cfg)
> > > +{
> > > +	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> > > +
> > > +	cfg->type = sensor->ep.bus_type;
> > > +	if (ov5640_is_csi2(sensor)) {
> > > +		cfg->bus.mipi_csi2.num_data_lanes =
> > > +			sensor->ep.bus.mipi_csi2.num_data_lanes;
> > > +		cfg->bus.mipi_csi2.flags = sensor->ep.bus.mipi_csi2.flags;
> > > +	} else {
> > > +		cfg->bus.parallel.flags = sensor->ep.bus.parallel.flags;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct v4l2_subdev_core_ops ov5640_core_ops = {
> > >  	.log_status = v4l2_ctrl_subdev_log_status,
> > >  	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > > @@ -3794,6 +3812,7 @@ static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
> > >  	.get_selection = ov5640_get_selection,
> > >  	.enum_frame_size = ov5640_enum_frame_size,
> > >  	.enum_frame_interval = ov5640_enum_frame_interval,
> > > +	.get_mbus_config = ov5640_get_mbus_config,
> > 
> > What's the reasoning for this patch?
> 
> Without this it's not possible to use it on i.MX6,
> drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
> details from Jacopo here [0].
> 
> Everything used to work fine up to v5.18, after that kernel version
> various changes broke it [1][2] (I assume you are pretty much aware of
> the history here, you commented on a few emails).
> 
> [0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
> [1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
> [2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/
> 
> > Drivers that don't have e.g. dynamic lane configuration shouldn't need to
> > implement get_mbus_config.

Not even for staging drivers. The driver should be fixed to get that
information from the endpoint instead.

I don't object having a helper in the framework to do this though. There
are many receiver drivers that need this to work with those devices that
have variable number of lanes.

-- 
Regards,

Sakari Ailus
