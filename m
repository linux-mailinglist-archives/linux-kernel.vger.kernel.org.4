Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79F05BCC94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiISNIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiISNIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:08:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639A2BB1E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:08:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaGVi-00054t-4C; Mon, 19 Sep 2022 15:08:30 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaGVh-0005KK-Iv; Mon, 19 Sep 2022 15:08:29 +0200
Date:   Mon, 19 Sep 2022 15:08:29 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
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

Hi Sakari,

On 22-09-19, Sakari Ailus wrote:
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

The official API states that you need to turn on the clk before
requesting it and it makes sense. Also there is a new helper
devm_clk_get_enabled() which addresses simple clk usage since most of
drivers don't enable it before requesting the rate.

Regards,
  Marco

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
> 
> -- 
> Regards,
> 
> Sakari Ailus
> 
