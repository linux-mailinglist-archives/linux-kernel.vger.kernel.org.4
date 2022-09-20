Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7A5BE4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiITLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiITLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:53:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641007437B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:53:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaboY-0002Zo-IA; Tue, 20 Sep 2022 13:53:22 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaboW-0003iQ-RR; Tue, 20 Sep 2022 13:53:20 +0200
Date:   Tue, 20 Sep 2022 13:53:20 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <20220920115320.awkb5nir7b6d3j7j@pengutronix.de>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de>
 <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
 <20220920104854.2wugqxffkf4qeib6@pengutronix.de>
 <Yymgr3pdbNWq6hn0@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yymgr3pdbNWq6hn0@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 22-09-20, Laurent Pinchart wrote:
> Hi Marco,
> 
> On Tue, Sep 20, 2022 at 12:48:54PM +0200, Marco Felsch wrote:
> > On 22-09-19, Laurent Pinchart wrote:
> > > On Mon, Sep 19, 2022 at 07:11:42PM +0200, Marco Felsch wrote:
> > > > On 22-09-19, Laurent Pinchart wrote:
> > > > > On Fri, Sep 16, 2022 at 03:45:35PM +0200, Marco Felsch wrote:

...

> > > > > > +static int tc358746_apply_misc_config(struct tc358746 *tc358746)
> > > > > > +{
> > > > > > +	struct v4l2_subdev *sd = &tc358746->sd;
> > > > > > +	struct v4l2_subdev_state *sink_state;
> > > > > > +	struct v4l2_mbus_framefmt *mbusfmt;
> > > > > 
> > > > > This can be const.
> > > > 
> > > > Sure
> > > > 
> > > > > > +	const struct tc358746_format *fmt;
> > > > > > +	struct device *dev = sd->dev;
> > > > > > +	u32 val;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	sink_state = v4l2_subdev_lock_and_get_active_state(sd);
> > > > > > +	mbusfmt = v4l2_subdev_get_pad_format(sd, sink_state, TC358746_SINK);
> > > > > > +	v4l2_subdev_unlock_state(sink_state);
> > > > > 
> > > > > You should keep the state locked until the end of this function,
> > > > > otherwise the format could change.
> > > > 
> > > > That couldn't be the case since this function is called during
> > > > .s_stream(on) and my understanding was that it is not allowed to change
> > > > the active format after calling .s_stream(on). But I can move it to the
> > > > end.
> > > 
> > > You're right, my bad. I can't wait for the .enable_streams() and
> > > .disable_streams() operations to replace .s_stream(), the state will
> > > then be passed by the framework to the drivers, simplifying all this.
> > 
> > Ah.. there are changes coming :) Is there some roadmap or todo or so?
> > Maybe we/I could support on some internal work.
> 
> The .enable_streams() and .disable_streams() operations are part of [1].
> The first 16 patches should be in v6.1. Reviews of the rest of the
> series would be appreciated.

Ah :)

> Further updates on top of that are just in my head for now :-) One idea
> is to rework media_pipeline_start() to split it into multiple functions,
> with a function that would lock all active states in the pipeline prior
> to calling .enable_streams(). The details are still vague at this point,
> but the goal is to move state locking out of drivers and pass it
> explicitly to all subdev functions.

Yes, that would be a lot easier since this are details which shouldn't
be implemented within the driver. Also it would be more robust since it
is handled in a central place.

> If there's anything you dislike with the subdev API that could be solved
> by increasing usage of the subdev state, let me know, we could cooperate
> on development.

Sure, for now I like that we finally get rid of the local
try-fmt/selection handling. This was also something the subdev driver
shouldn't care about.

> [1] https://lore.kernel.org/linux-media/20220831141357.1396081-1-tomi.valkeinen@ideasonboard.com

...

> > > > > > +static int tc358746_set_fmt(struct v4l2_subdev *sd,
> > > > > > +			    struct v4l2_subdev_state *sd_state,
> > > > > > +			    struct v4l2_subdev_format *format)
> > > > > > +{

...

> > > > > > +	sensor = media_entity_to_v4l2_subdev(link->source->entity);
> > > > > > +	sensor_pclk_rate = v4l2_get_link_freq(sensor->ctrl_handler, 0, 0);
> > > > > 
> > > > > Shouldn't you set the last two arguments to non-zero values, to support
> > > > > sources that only implement the V4L2_CID_PIXEL_RATE control ?
> > > > 
> > > > Nope, I don't wanna support PIXEL_RATE right now. This can be changed
> > > > later I think.
> > > 
> > > Would it be hard to support it already, given that the
> > > v4l2_get_link_freq() should make it easier ? That would avoid having to
> > > come back to this code later.
> > 
> > I had the pixel-rate first, then Jacobo mentioned (correctly) that my
> > usage of pixel-rate was wrong. Supporting PIXEL_RATE as well would add
> > more complexity because we need to take core of the mbus format to get
> > the correct mul/div settings.
> 
> That's right, but the required information could be stored in the
> tc358746_format structure, can't it ?

Sure.

> > Also I think that only a few drivers
> > implementing the PIXEL_RATE correctly in case of parallel sensors _and_
> > this is just a fallback which will print a warning if triggered. All I
> > want to do here is: "give me the link frequence" :) If there are drivers
> > not supporting this but support PIXEL_RATE it shouldn't be that hard for
> > those driver to add the LINK_FREQ ctrl. This would also improve the
> > kernel quality since there are now heuristics and no warnings printed.
> > 
> > Is it okay, to keep it simple and just go with LINK_FREQ. for now?
> 
> OK, I won't insist much.
> 
> > > > > I'd also name the variable source_link_freq, as it may not be a sensor,
> > > > > and it's a link frequency, not a pixel clock rate.
> > > > 
> > > > In parallel case (which is the only supported right now) the pclk is the
> > > > link_freq. but I can change it of course.
> > > 
> > > I read "pclk" as "pixel clock". That makes me think of
> > > V4L2_CID_PIXEL_RATE, which indicates the number of pixels per second.
> > > With YUV 4:2:2 2X8 media bus formats, the link frequency will be twice
> > > the pixel rate.
> > 
> > Hm.. the link frequency is the frequency on the physical parallel bus,
> > as far as I understood the ctrl. In parallel use-case this is pixelclk.
> > 
> > Also according PIXEL_RATE documentation, it is defined as
> > pixel-per-second. For YUV 4:2:2 those this mean mean:
> >  - y1 == 1st pixel,
> >  - u1 == 2nd pixel,
> >  - y2 == 3rd pixel,
> >  - ...
> 
> YUYV8_2X8 transfers Y0, U0, Y1, V0, Y2, U2, Y3, V2, ... 

Of course, zero based ^^

> You need two cycles per pixel. 

To be even more precise: I need 4 cycles for 2 pixels.

> That's why sensor_pclk_rate can be misleading, as it may refer to the
> sensor pixel sampling clock, or the parallel bus clock, and those two
> are different. It's just a variable naming issue to avoid confusion.

You're right, i've changed it to source_link_freq as you suggested. I
also dropped the complete sensor variables and used source instead.

> > All I want is to get the rate/frequency of the physical bus from the
> > input device :) According my above explanation, could we please go with
> > "the LINK_FREQ ctrl only" since this would avoid possible kernel
> > warnings and is the most accurate one.
> > 
> > > > > > +	if (sensor_pclk_rate <= 0) {
> > > > > > +		dev_err(tc358746->sd.dev,
> > > > > > +			"Failed to query or invalid sensor link frequency\n");
> > > > > > +		/* Return -EINVAL in case of sensor_pclk_rate is 0 */
> > > > > > +		return sensor_pclk_rate ? : -EINVAL;
> > > > > > +	}
> > > > > > +	sensor_bitrate = sensor_pclk_rate * fmt->bus_width;
> > > > > > +
> > > > > > +	csi_bitrate = tc358746->dphy_cfg.lanes * tc358746->pll_rate;
> > > > > > +
> > > > > > +	dev_dbg(tc358746->sd.dev,
> > > > > > +		"Fifo settings params: sensor-bitrate:%lu csi-bitrate:%lu",
> > > > > > +		sensor_bitrate, csi_bitrate);
> > > > > > +
> > > > > > +	/* Avoid possible FIFO overflows */
> > > > > > +	if (csi_bitrate < sensor_bitrate) {
> > > > > > +		dev_err(sd->dev,
> > > > > > +			"Link validation failed csi-bitrate:%lu < sensor-bitrate:%lu\n",
> > > > > > +			csi_bitrate, sensor_bitrate);
> > > > > 
> > > > > As this can be triggered by userspace, I'd make it a dev_dbg().
> > > > 
> > > > So you would rather fail silently without printing the reason? Is there
> > > > a common kernel agreement when to use dev_err() or info() or dbg()?
> > > 
> > > It's not completely silent :-) The idea is that an error condition that
> > > can be triggered by unpriviledged userspace shouldn't be able to flood
> > > the kernel log. dev_dbg() will still allow debugging.
> > 
> > Okay, I droppped it completely since the dev_dbg() in front of this
> > call.
> > 
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* Best case */
> > > > > > +	if (csi_bitrate == sensor_bitrate) {
> > > > > > +		tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > > > > +		goto out;
> > > > > > +	}
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Avoid possible FIFO underflow in case of
> > > > > > +	 * csi_bitrate > sensor_bitrate. For such case the chip has a internal
> > > > > > +	 * fifo which can be used to delay the line output.
> > > > > > +	 *
> > > > > > +	 * Fifo size calculation:
> > > > > > +	 *
> > > > > > +	 * fifo-sz, image-width - in bits
> > > > > > +	 * sbr                  - sensor_bitrate in bits/s
> > > > > > +	 * csir                 - csi_bitrate in bits/s
> > > > > > +	 *
> > > > > > +	 *                1             1      1
> > > > > > +	 * image-width * --- + fifo-sz --- >= ---- * image-width
> > > > > > +	 *               sbr           sbr    csir
> > > > > 
> > > > > Given that csir > sbr, 1/csir < 1 sbr, so this will always be true,
> > > > > even with fifo-sz set to 0. Am I missing something ?
> > > > 
> > > > Nope, that is right. Didn't checked that while I was coding it.
> > > > 
> > > > > > +	 *
> > > > > > +	 * fifo-sz >= abs(sbr/csir * image-width - image-width)
> > > > > > +	 *                `-----´
> > > > > > +	 *                   n
> > > > > 
> > > > > The n variable doesn't store sbr/csir but csir/sbr (multiplied by a
> > > > > precision factor). And do I understand correctly that, as sbr < csir,
> > > > > this would be equal to the following ?
> > > > > 
> > > > > 	 * fifo-sz >= image-width - sbr/csir * image-width
> > > > 
> > > > Exactly, my above comment and the below code is a bit of, you're right
> > > > but the calc is still correct:
> > > > 
> > > >         (mbusfmt->width * precision)   (mbusfmt->width * precision)
> > > >   tmp = ---------------------------- = ----------------------------
> > > >                         n                    csi_bitrate
> > > > 			                     --------------
> > > > 					     sensor_bitrate
> > > > 
> > > > 					`---------------------------´
> > > >    					   sbr/csir * image-width
> > > > 
> > > > maybe I should comment it like:
> > > > 
> > > > > * fifo-sz >= abs(sbr/csir * image-width - image-width)
> > > > > *
> > > > > * with n = 1/(sbr/csir) = csir/sbr
> > > > > *
> > > > > * fifo-sz >= abs(image-width / n - image-width)
> > > > > *
> > > > > *  or
> > > > > *
> > > > > *  fifo-sz >= image-width - image-width / n
> > > > 
> > > > > > +	 *
> > > > > > +	 */
> > > > > > +
> > > > > > +	sensor_bitrate /= TC358746_PRECISION;
> > > > > > +	n = csi_bitrate / sensor_bitrate;
> > > > > > +	tmp = (mbusfmt->width * TC358746_PRECISION) / n;
> > > > > > +	fifo_sz = mbusfmt->width - tmp;
> > > > > > +	fifo_sz *= fmt->bpp;
> > > > > > +	tc358746->vb_size = round_up(fifo_sz, 32);
> > > > > > +
> > > > > > +out:
> > > > > > +	dev_dbg(tc358746->sd.dev,
> > > > > > +		"Found FIFO size[bits]:%u -> aligned to size[bits]:%u\n",
> > > > > > +		fifo_sz, tc358746->vb_size);
> > > > > > +
> > > > > > +	return tc358746->vb_size > TC358746_VB_MAX_SIZE ? -EINVAL : 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int tc358746_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
> > > > > > +				    struct v4l2_mbus_config *config)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > > +
> > > > > > +	if (pad != TC358746_SOURCE)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	config->type = V4L2_MBUS_CSI2_DPHY;
> > > > > > +	config->bus.mipi_csi2 = tc358746->csi_vep.bus.mipi_csi2;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +int __maybe_unused
> > > > > 
> > > > > As reported by the buildbot, this should be static. Same for s_register.
> > > > 
> > > > Yes.
> > > > 
> > > > > > +tc358746_g_register(struct v4l2_subdev *sd, struct v4l2_dbg_register *reg)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > > +
> > > > > > +	/* 32-bit registers starting from CLW_DPHYCONTTX */
> > > > > > +	reg->size = reg->reg < CLW_DPHYCONTTX_REG ? 2 : 4;
> > > > > > +
> > > > > > +	if (pm_runtime_resume_and_get(sd->dev)) {
> > > > > > +		dev_err(sd->dev, "Failed to resume the device\n");
> > > > > > +		return 0;
> > > > > > +	}
> > > > > 
> > > > > Is there a point in powering the hardware on here if it's off, in order
> > > > > to read a register that will have been reset due to the power cycle ?
> > > > > pm_runtime_get_if_in_use() seems better. Same in .s_register().
> > > > 
> > > > You're right, I will change that.
> > > > 
> > > > > > +	tc358746_read(tc358746, reg->reg, (u32 *)&reg->val);
> > > > > > +
> > > > > > +	pm_runtime_mark_last_busy(sd->dev);
> > > > > > +	pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +int __maybe_unused
> > > > > > +tc358746_s_register(struct v4l2_subdev *sd, const struct v4l2_dbg_register *reg)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > > > > > +
> > > > > > +	if (pm_runtime_resume_and_get(sd->dev)) {
> > > > > > +		dev_err(sd->dev, "Failed to resume the device\n");
> > > > > > +		return 0;
> > > > > > +	}
> > > > > > +
> > > > > > +	tc358746_write(tc358746, (u32)reg->reg, (u32)reg->val);
> > > > > > +
> > > > > > +	pm_runtime_mark_last_busy(sd->dev);
> > > > > > +	pm_runtime_put_sync_autosuspend(sd->dev);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct v4l2_subdev_core_ops tc358746_core_ops = {
> > > > > > +#ifdef CONFIG_VIDEO_ADV_DEBUG
> > > > > > +	.g_register = tc358746_g_register,
> > > > > > +	.s_register = tc358746_s_register,
> > > > > > +#endif
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_video_ops tc358746_video_ops = {
> > > > > > +	.s_stream = tc358746_s_stream,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_pad_ops tc358746_pad_ops = {
> > > > > > +	.init_cfg = tc358746_init_cfg,
> > > > > > +	.enum_mbus_code = tc358746_enum_mbus_code,
> > > > > > +	.set_fmt = tc358746_set_fmt,
> > > > > > +	.get_fmt = v4l2_subdev_get_fmt,
> > > > > > +	.link_validate = tc358746_link_validate,
> > > > > > +	.get_mbus_config = tc358746_get_mbus_config,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_ops tc358746_ops = {
> > > > > > +	.core = &tc358746_core_ops,
> > > > > > +	.video = &tc358746_video_ops,
> > > > > > +	.pad = &tc358746_pad_ops,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct media_entity_operations tc358746_entity_ops = {
> > > > > > +	.get_fwnode_pad = v4l2_subdev_get_fwnode_pad_1_to_1,
> > > > > > +	.link_validate = v4l2_subdev_link_validate,
> > > > > > +};
> > > > > > +
> > > > > > +static int tc358746_mclk_enable(struct clk_hw *hw)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > > +	unsigned int div;
> > > > > > +	u32 val;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	div = tc358746->mclk_postdiv / 2;
> > > > > > +	val = MCLK_HIGH(div - 1) | MCLK_LOW(div - 1);
> > > > > > +	dev_dbg(tc358746->sd.dev, "MCLKCTL: %u (0x%x)\n", val, val);
> > > > > > +	err = tc358746_write(tc358746, MCLKCTL_REG, val);
> > > > > > +	if (err)
> > > > > > +		return err;
> > > > > > +
> > > > > > +	if (tc358746->mclk_prediv == 8)
> > > > > > +		val = MCLKDIV(MCLKDIV_8);
> > > > > > +	else if (tc358746->mclk_prediv == 4)
> > > > > > +		val = MCLKDIV(MCLKDIV_4);
> > > > > > +	else
> > > > > > +		val = MCLKDIV(MCLKDIV_2);
> > > > > > +
> > > > > > +	dev_dbg(tc358746->sd.dev, "CLKCTL[MCLKDIV]: %u (0x%x)\n", val, val);
> > > > > > +	return tc358746_update_bits(tc358746, CLKCTL_REG, MCLKDIV_MASK, val);
> > > > > > +}
> > > > > > +
> > > > > > +static void tc358746_mclk_disable(struct clk_hw *hw)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > > +
> > > > > > +	tc358746_write(tc358746, MCLKCTL_REG, 0);
> > > > > > +}
> > > > > > +
> > > > > > +static long
> > > > > > +tc358746_find_mclk_settings(struct tc358746 *tc358746, unsigned long mclk_rate)
> > > > > > +{
> > > > > > +	unsigned long pll_rate = tc358746->pll_rate;
> > > > > > +	const unsigned char prediv[] = { 2, 4, 8 };
> > > > > > +	unsigned int mclk_prediv, mclk_postdiv;
> > > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > > +	unsigned int postdiv, mclkdiv;
> > > > > > +	unsigned long best_mclk_rate;
> > > > > > +	unsigned int i;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 *                          MCLK-Div
> > > > > > +	 *           -------------------´`---------------------
> > > > > > +	 *          ´                                          `
> > > > > > +	 *         +-------------+     +------------------------+
> > > > > > +	 *         | MCLK-PreDiv |     |       MCLK-PostDiv     |
> > > > > > +	 * PLL --> |   (2/4/8)   | --> | (mclk_low + mclk_high) | --> MCLK
> > > > > > +	 *         +-------------+     +------------------------+
> > > > > > +	 *
> > > > > > +	 * The register value of mclk_low/high is mclk_low/high+1, i.e.:
> > > > > > +	 *   mclk_low/high = 1   --> 2 MCLK-Ref Counts
> > > > > > +	 *   mclk_low/high = 255 --> 256 MCLK-Ref Counts == max.
> > > > > > +	 * If mclk_low and mclk_high are 0 then MCLK is disabled.
> > > > > > +	 *
> > > > > > +	 * Keep it simple and support 50/50 duty cycles only for now,
> > > > > > +	 * so the calc will be:
> > > > > > +	 *
> > > > > > +	 *   MCLK = PLL / (MCLK-PreDiv * 2 * MCLK-PostDiv)
> > > > > > +	 */
> > > > > > +
> > > > > > +	if (mclk_rate == tc358746->mclk_rate)
> > > > > > +		return mclk_rate;
> > > > > > +
> > > > > > +	/* Highest possible rate */
> > > > > > +	mclkdiv = pll_rate / mclk_rate;
> > > > > > +	if (mclkdiv <= 8) {
> > > > > > +		mclk_prediv = 2;
> > > > > > +		mclk_postdiv = 4;
> > > > > > +		best_mclk_rate = pll_rate / (2 * 4);
> > > > > > +		goto out;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* First check the prediv */
> > > > > > +	for (i = 0; i < ARRAY_SIZE(prediv); i++) {
> > > > > > +		postdiv = mclkdiv / prediv[i];
> > > > > > +
> > > > > > +		if (postdiv % 2)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		if (postdiv >= 4 && postdiv <= 512) {
> > > > > > +			mclk_prediv = prediv[i];
> > > > > > +			mclk_postdiv = postdiv;
> > > > > > +			best_mclk_rate = pll_rate / (prediv[i] * postdiv);
> > > > > > +			goto out;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	/* No suitable prediv found, so try to adjust the postdiv */
> > > > > > +	for (postdiv = 4; postdiv <= 512; postdiv += 2) {
> > > > > > +		unsigned int pre;
> > > > > > +
> > > > > > +		pre = mclkdiv / postdiv;
> > > > > > +		if (pre == 2 || pre == 4 || pre == 8) {
> > > > > > +			mclk_prediv = pre;
> > > > > > +			mclk_postdiv = postdiv;
> > > > > > +			best_mclk_rate = pll_rate / (pre * postdiv);
> > > > > > +			goto out;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	/* The MCLK <-> PLL gap is to high -> use largest possible div */
> > > > > > +	mclk_prediv = 8;
> > > > > > +	mclk_postdiv = 512;
> > > > > > +	best_mclk_rate = pll_rate / (8 * 512);
> > > > > > +
> > > > > > +out:
> > > > > > +	tc358746->mclk_prediv = mclk_prediv;
> > > > > > +	tc358746->mclk_postdiv = mclk_postdiv;
> > > > > > +	tc358746->mclk_rate = best_mclk_rate;
> > > > > > +
> > > > > > +	if (best_mclk_rate != mclk_rate)
> > > > > > +		dev_warn(dev, "Request MCLK freq:%lu, found MCLK freq:%lu\n",
> > > > > > +			 mclk_rate, best_mclk_rate);
> > > > > > +
> > > > > > +	dev_dbg(dev, "Found MCLK settings: freq:%lu prediv:%u postdiv:%u\n",
> > > > > > +		best_mclk_rate, mclk_prediv, mclk_postdiv);
> > > > > > +
> > > > > > +	return best_mclk_rate;
> > > > > > +}
> > > > > > +
> > > > > > +unsigned long tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > > +	unsigned int prediv, postdiv;
> > > > > > +	u32 val;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	err = tc358746_read(tc358746, MCLKCTL_REG, &val);
> > > > > > +	if (err)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	postdiv = FIELD_GET(MCLK_LOW_MASK, val) + 1;
> > > > > > +	postdiv += FIELD_GET(MCLK_HIGH_MASK, val) + 1;
> > > > > > +
> > > > > > +	err = tc358746_read(tc358746, CLKCTL_REG, &val);
> > > > > > +	if (err)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	prediv = FIELD_GET(MCLKDIV_MASK, val);
> > > > > > +	if (prediv == MCLKDIV_8)
> > > > > > +		prediv = 8;
> > > > > > +	else if (prediv == MCLKDIV_4)
> > > > > > +		prediv = 4;
> > > > > > +	else
> > > > > > +		prediv = 2;
> > > > > > +
> > > > > > +	return tc358746->pll_rate / (prediv * postdiv);
> > > > > > +}
> > > > > > +
> > > > > > +static long tc358746_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
> > > > > > +				     unsigned long *parent_rate)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > > +
> > > > > > +	*parent_rate = tc358746->pll_rate;
> > > > > > +
> > > > > > +	return tc358746_find_mclk_settings(tc358746, rate);
> > > > > > +}
> > > > > > +
> > > > > > +static int tc358746_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
> > > > > > +				  unsigned long parent_rate)
> > > > > > +{
> > > > > > +	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
> > > > > > +
> > > > > > +	tc358746_find_mclk_settings(tc358746, rate);
> > > > > > +
> > > > > > +	return tc358746_mclk_enable(hw);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct clk_ops tc358746_mclk_ops = {
> > > > > > +	.enable = tc358746_mclk_enable,
> > > > > > +	.disable = tc358746_mclk_disable,
> > > > > > +	.recalc_rate = tc358746_recalc_rate,
> > > > > > +	.round_rate = tc358746_mclk_round_rate,
> > > > > > +	.set_rate = tc358746_mclk_set_rate,
> > > > > > +};
> > > > > > +
> > > > > > +static int
> > > > > > +tc358746_init_subdev(struct tc358746 *tc358746, struct i2c_client *client)
> > > > > > +{
> > > > > > +	struct v4l2_subdev *sd;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	sd = &tc358746->sd;
> > > > > 
> > > > > You could initialize the variable when declaring it.
> > > > 
> > > > Yes.
> > > > 
> > > > > > +	v4l2_i2c_subdev_init(sd, client, &tc358746_ops);
> > > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > > +	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> > > > > > +	sd->entity.ops = &tc358746_entity_ops;
> > > > > > +
> > > > > > +	tc358746->pads[TC358746_SINK].flags = MEDIA_PAD_FL_SINK;
> > > > > > +	tc358746->pads[TC358746_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
> > > > > > +	err = media_entity_pads_init(&sd->entity, TC358746_NR_PADS,
> > > > > > +				     tc358746->pads);
> > > > > > +	if (err)
> > > > > > +		return err;
> > > > > > +
> > > > > > +	err = v4l2_subdev_init_finalize(sd);
> > > > > > +	if (err)
> > > > > > +		media_entity_cleanup(&sd->entity);
> > > > > > +
> > > > > > +	return err;
> > > > > > +}
> > > > > > +
> > > > > > +static int
> > > > > > +tc358746_init_output_port(struct tc358746 *tc358746, unsigned long refclk)
> > > > > > +{
> > > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > > +	struct v4l2_fwnode_endpoint *vep;
> > > > > > +	unsigned long csi_link_rate;
> > > > > > +	struct fwnode_handle *ep;
> > > > > > +	unsigned char csi_lanes;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), TC358746_SOURCE,
> > > > > > +					     0, 0);
> > > > > > +	if (!ep) {
> > > > > > +		dev_err(dev, "Missing endpoint node\n");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* Currently we only support 'parallel in' -> 'csi out' */
> > > > > > +	vep = &tc358746->csi_vep;
> > > > > > +	vep->bus_type = V4L2_MBUS_CSI2_DPHY;
> > > > > > +	err = v4l2_fwnode_endpoint_alloc_parse(ep, vep);
> > > > > > +	fwnode_handle_put(ep);
> > > > > > +	if (err) {
> > > > > > +		dev_err(dev, "Failed to parse source endpoint\n");
> > > > > > +		return err;
> > > > > > +	}
> > > > > > +
> > > > > > +	csi_lanes = vep->bus.mipi_csi2.num_data_lanes;
> > > > > > +	if (csi_lanes == 0 || csi_lanes > 4 ||
> > > > > > +	    vep->nr_of_link_frequencies == 0) {
> > > > > > +		dev_err(dev, "error: Invalid CSI-2 settings\n");
> > > > > > +		err = -EINVAL;
> > > > > > +		goto err;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* TODO: Add support to handle multiple link frequencies */
> > > > > > +	csi_link_rate = (unsigned long)vep->link_frequencies[0];
> > > > > > +	tc358746->pll_rate = tc358746_find_pll_settings(tc358746, refclk,
> > > > > > +							csi_link_rate * 2);
> > > > > > +	if (!tc358746->pll_rate) {
> > > > > > +		err = -EINVAL;
> > > > > > +		goto err;
> > > > > > +	}
> > > > > > +
> > > > > > +	err = phy_mipi_dphy_get_default_config_for_hsclk(tc358746->pll_rate,
> > > > > > +						csi_lanes, &tc358746->dphy_cfg);
> > > > > > +	if (err)
> > > > > > +		goto err;
> > > > > > +
> > > > > > +	tc358746->vb_size = TC358746_VB_DEFAULT_SIZE;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +err:
> > > > > > +	v4l2_fwnode_endpoint_free(vep);
> > > > > > +
> > > > > > +	return err;
> > > > > > +}
> > > > > > +
> > > > > > +static int tc358746_init_hw(struct tc358746 *tc358746)
> > > > > > +{
> > > > > > +	struct device *dev = tc358746->sd.dev;
> > > > > > +	unsigned int chipid;
> > > > > > +	u32 val;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	err = pm_runtime_resume_and_get(dev);
> > > > > > +	if (err < 0) {
> > > > > > +		dev_err(dev, "Failed to resume the device\n");
> > > > > > +		return err;
> > > > > > +	}
> > > > > > +
> > > > > > +	 /* Ensure that CSI interface is put into LP-11 state */
> > > > > > +	err = tc358746_sw_reset(tc358746);
> > > > > > +	if (err) {
> > > > > > +		pm_runtime_put_noidle(dev);
> > > > > 
> > > > > Don't you need a regular put (possibly with autosuspend) here ?
> > > > > Otherwise a reset failure will decrement the runtime PM use count but
> > > > > leave the decide powered.
> > > > 
> > > > The runtime_disable() will be called within the probe(). Please see
> > > > the error path there for tc358746_init_hw().
> > > 
> > > Those are two different things, I don't think pm_runtime_disable() will
> > > power the device off.
> > 
> > Arg.. Yes you're right. I will fix it by using the
> > pm_runtime_put_sync_suspend() now. Thanks.
> 
> I think pm_runtime_put_sync() is enough, or even pm_runtime_put() if you
> don't need the power to be turned off immediately.

This will end in the same, but as you prefer. I used the sync version
since the error handling will execute it anyways.

Regards,
  Marco
