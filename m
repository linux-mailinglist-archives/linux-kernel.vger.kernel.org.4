Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A3A5BCCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiISNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiISNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:19:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA827FF4;
        Mon, 19 Sep 2022 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663593544; x=1695129544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZvHfGOxcYz6x4E6FinWKgAgs6KZfo4V8zT+OOteJ0Y=;
  b=EGICckaeGgPU4S+kQ0uaVP+iFM+PtCJMvCw3LakJ34ZISidrZwjVXTkO
   IixoMhSfvqmSwcjS8uHA+G2dbfTP4M92lnmw3R3DWJ96e+hzQ6861Molh
   CEN2jREK2v517O9BtJAIQKCrgVsKbg3sDJaOVATmiAwJjJR28fWwVlROu
   FPHKJKiR+iVv5UJEqSVuCz7uZMElEnx/BgXvI4EMOmF+CRyd2TShjVyd7
   8PCJY09m0mpvYuVSjdSrkQV0zcP1OQBRzY0U3wB5ezibAc3fU71DGBaty
   3oql/6ugVehj5+fniLJIYFy4WtDVvErVEWH0bLF3HcHnSLn3Q8Hb4kUOs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282422317"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="282422317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:19:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="744112139"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:19:02 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id E19C3202D2;
        Mon, 19 Sep 2022 16:18:59 +0300 (EEST)
Date:   Mon, 19 Sep 2022 13:18:59 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <YyhsQ+l1Sls00F0M@paasikivi.fi.intel.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
 <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Sep 19, 2022 at 03:08:29PM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 22-09-19, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > On Fri, Sep 16, 2022 at 03:57:11PM +0200, Marco Felsch wrote:
> > > Add support to report the link frequency.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > The v1 of this small series can be found here:
> > > https://lore.kernel.org/all/20220818144712.997477-1-m.felsch@pengutronix.de/
> > > 
> > > Thanks a lot to Jacopo for the review feedback on my v1.
> > > 
> > > Changelog:
> > > 
> > > v2:
> > > - use V4L2_CID_LINK_FREQ instead of V4L2_CID_PIXEL_RATE
> > > ---
> > >  drivers/media/i2c/mt9m111.c | 21 ++++++++++++++++++++-
> > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > > index afc86efa9e3e..52be1c310455 100644
> > > --- a/drivers/media/i2c/mt9m111.c
> > > +++ b/drivers/media/i2c/mt9m111.c
> > > @@ -1249,6 +1249,8 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  {
> > >  	struct mt9m111 *mt9m111;
> > >  	struct i2c_adapter *adapter = client->adapter;
> > > +	static s64 extclk_rate;
> > > +	struct v4l2_ctrl *ctrl;
> > >  	int ret;
> > >  
> > >  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> > > @@ -1271,6 +1273,13 @@ static int mt9m111_probe(struct i2c_client *client)
> > >  	if (IS_ERR(mt9m111->clk))
> > >  		return PTR_ERR(mt9m111->clk);
> > >  
> > > +	ret = clk_prepare_enable(mt9m111->clk);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	extclk_rate = clk_get_rate(mt9m111->clk);
> > > +	clk_disable_unprepare(mt9m111->clk);
> > 
> > I don't think you'll need to enable a clock to just get its frequency.
> 
> The official API states that you need to turn on the clk before
> requesting it and it makes sense. Also there is a new helper
> devm_clk_get_enabled() which addresses simple clk usage since most of
> drivers don't enable it before requesting the rate.

I guess the rate could change in the meantime, unless exclusive access is
requested. The clock framework currently doesn't offer a way to set the
assigned rate and prevent changing it. But above, couldn't the clock
frequency be changed again once the clock has been disabled?

-- 
Sakari Ailus
