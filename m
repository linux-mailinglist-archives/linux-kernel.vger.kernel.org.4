Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E95E7D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiIWOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIWOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:38:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421C143287
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:38:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1objoi-00045V-NU; Fri, 23 Sep 2022 16:38:12 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1objoh-0001T7-SC; Fri, 23 Sep 2022 16:38:11 +0200
Date:   Fri, 23 Sep 2022 16:38:11 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        hverkuil@xs4all.nl, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <20220923143811.d5gk52vh2koczyhk@pengutronix.de>
References: <20220922134843.3108267-1-m.felsch@pengutronix.de>
 <20220922134843.3108267-5-m.felsch@pengutronix.de>
 <Yy2rNit+rRGkcFdL@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2rNit+rRGkcFdL@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 22-09-23, Sakari Ailus wrote:
> Hi Marco,
> 
> Thanks for the update. A few small things below.
> 
> On Thu, Sep 22, 2022 at 03:48:43PM +0200, Marco Felsch wrote:
> ...
> > +static int tc358746_apply_misc_config(struct tc358746 *tc358746)
> > +{
> > +	const struct v4l2_mbus_framefmt *mbusfmt;
> > +	struct v4l2_subdev *sd = &tc358746->sd;
> > +	struct v4l2_subdev_state *sink_state;
> > +	const struct tc358746_format *fmt;
> > +	struct device *dev = sd->dev;
> > +	u32 val;
> > +	int err;
> > +
> > +	sink_state = v4l2_subdev_lock_and_get_active_state(sd);
> > +	mbusfmt = v4l2_subdev_get_pad_format(sd, sink_state, TC358746_SINK);
> > +	v4l2_subdev_unlock_state(sink_state);
> > +
> > +	fmt = tc358746_get_format_by_code(TC358746_SINK, mbusfmt->code);
> 
> You can no longer access mbusfmt here as you've already unlocked subdev
> state.

You're right, Laurent also mentioned this but this function gets called
during .s_stream(on) so the format shouldn't be changed that late.
However since you're the 2nd with the thought, I will fix it in the v4.

> > +
> > +	/* Self defined CSI user data type id's are not supported yet */
> > +	val = PDFMT(fmt->pdformat);
> > +	dev_dbg(dev, "DATAFMT: 0x%x\n", val);
> > +	err = tc358746_write(tc358746, DATAFMT_REG, val);
> > +	if (err)
> > +		return err;
> > +
> > +	val = PDATAF(fmt->pdataf);
> > +	dev_dbg(dev, "CONFCTL[PDATAF]: 0x%x\n", fmt->pdataf);
> > +	err = tc358746_update_bits(tc358746, CONFCTL_REG, PDATAF_MASK, val);
> > +	if (err)
> > +		return err;
> > +
> > +	val = tc358746->vb_size / 32;
> > +	dev_dbg(dev, "FIFOCTL: %u (0x%x)\n", val, val);
> > +	err = tc358746_write(tc358746, FIFOCTL_REG, val);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Total number of bytes for each line/width */
> > +	val = mbusfmt->width * fmt->bpp / 8;
> > +	dev_dbg(dev, "WORDCNT: %u (0x%x)\n", val, val);
> > +	return tc358746_write(tc358746, WORDCNT_REG, val);
> > +}
> 
> ...
> 
> > +static int tc358746_s_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +	struct tc358746 *tc358746 = to_tc358746(sd);
> > +	struct v4l2_subdev *src;
> > +	int err;
> > +
> > +	dev_dbg(sd->dev, "%sable\n", enable ? "en" : "dis");
> > +
> > +	src = tc358746_get_remote_sd(&tc358746->pads[TC358746_SINK]);
> > +	if (!src)
> > +		return -EPIPE;
> > +
> > +	if (enable) {
> > +		err = pm_runtime_resume_and_get(sd->dev);
> > +		if (err)
> > +			return err;
> > +
> > +		err = tc358746_apply_dphy_config(tc358746);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		err = tc358746_apply_misc_config(tc358746);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		err = tc358746_enable_csi_lanes(tc358746, 1);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		err = tc358746_enable_csi_module(tc358746, 1);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		err = tc358746_enable_parallel_port(tc358746, 1);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		err = v4l2_subdev_call(src, video, s_stream, 1);
> > +		if (err)
> > +			goto err_out;
> > +
> > +		return err;
> 
> This can be return 0.

Sure.

Regards,
  Marco

> 
> > +
> > +err_out:
> > +		pm_runtime_mark_last_busy(sd->dev);
> > +		pm_runtime_put_sync_autosuspend(sd->dev);
> > +
> > +		return err;
> > +	}
> 
> -- 
> Kind regards,
> 
> Sakari Ailus
> 
