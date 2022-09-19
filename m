Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB25BCC42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiISMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiISMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:55:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E52871C;
        Mon, 19 Sep 2022 05:55:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A4649BA;
        Mon, 19 Sep 2022 14:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663592129;
        bh=lwwMmU7LDR16Rh26z5UQagpmACoPd+MPTHdQVhmI3HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPXP9sDRGOIhJffJfO6qMYYZSS327AoartD+sxSnYBjX1/tq/2L/EyIjN3ttGzPSX
         J4szdVxGLko6nSNX0EMWatfTkwGIKDADGQy5OYfq8Nm3Ir71J1pJUrv4ZuuL5Oym0S
         PyJI17CYr0rC6qtRAuptaSuflXsCkussW3fsqNC0=
Date:   Mon, 19 Sep 2022 15:55:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <Yyhmswpz6ON4q8fK@pendragon.ideasonboard.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 12:42:15PM +0000, Sakari Ailus wrote:
> Hi Marco,
> 
> On Fri, Sep 16, 2022 at 03:57:11PM +0200, Marco Felsch wrote:
> > Add support to report the link frequency.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > The v1 of this small series can be found here:
> > https://lore.kernel.org/all/20220818144712.997477-1-m.felsch@pengutronix.de/
> > 
> > Thanks a lot to Jacopo for the review feedback on my v1.
> > 
> > Changelog:
> > 
> > v2:
> > - use V4L2_CID_LINK_FREQ instead of V4L2_CID_PIXEL_RATE
> > ---
> >  drivers/media/i2c/mt9m111.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > index afc86efa9e3e..52be1c310455 100644
> > --- a/drivers/media/i2c/mt9m111.c
> > +++ b/drivers/media/i2c/mt9m111.c
> > @@ -1249,6 +1249,8 @@ static int mt9m111_probe(struct i2c_client *client)
> >  {
> >  	struct mt9m111 *mt9m111;
> >  	struct i2c_adapter *adapter = client->adapter;
> > +	static s64 extclk_rate;
> > +	struct v4l2_ctrl *ctrl;
> >  	int ret;
> >  
> >  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> > @@ -1271,6 +1273,13 @@ static int mt9m111_probe(struct i2c_client *client)
> >  	if (IS_ERR(mt9m111->clk))
> >  		return PTR_ERR(mt9m111->clk);
> >  
> > +	ret = clk_prepare_enable(mt9m111->clk);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	extclk_rate = clk_get_rate(mt9m111->clk);
> > +	clk_disable_unprepare(mt9m111->clk);
> 
> I don't think you'll need to enable a clock to just get its frequency.
> 
> > +
> >  	mt9m111->regulator = devm_regulator_get(&client->dev, "vdd");
> >  	if (IS_ERR(mt9m111->regulator)) {
> >  		dev_err(&client->dev, "regulator not found: %ld\n",
> > @@ -1285,7 +1294,7 @@ static int mt9m111_probe(struct i2c_client *client)
> >  	mt9m111->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> >  				 V4L2_SUBDEV_FL_HAS_EVENTS;
> >  
> > -	v4l2_ctrl_handler_init(&mt9m111->hdl, 7);
> > +	v4l2_ctrl_handler_init(&mt9m111->hdl, 8);
> >  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
> >  			V4L2_CID_VFLIP, 0, 1, 1, 0);
> >  	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
> > @@ -1309,6 +1318,16 @@ static int mt9m111_probe(struct i2c_client *client)
> >  				BIT(V4L2_COLORFX_NEGATIVE) |
> >  				BIT(V4L2_COLORFX_SOLARIZATION)),
> >  			V4L2_COLORFX_NONE);
> > +	/*
> > +	 * The extclk rate equals the link freq. if reg default values are used,

s/freq./frequency/

> > +	 * which is the case. This must be adapted as soon as we don't use the
> > +	 * default values anymore.
> > +	 */
> > +	ctrl = v4l2_ctrl_new_int_menu(&mt9m111->hdl, &mt9m111_ctrl_ops,
> > +				      V4L2_CID_LINK_FREQ, 0, 0, &extclk_rate);
> > +	if (ctrl)
> > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > +
> >  	mt9m111->subdev.ctrl_handler = &mt9m111->hdl;
> >  	if (mt9m111->hdl.error) {
> >  		ret = mt9m111->hdl.error;

-- 
Regards,

Laurent Pinchart
