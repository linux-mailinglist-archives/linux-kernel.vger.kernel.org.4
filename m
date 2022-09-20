Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48775BE0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiITI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiITI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:56:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3056B170
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:56:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaZ3C-0008RQ-Ba; Tue, 20 Sep 2022 10:56:18 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaZ3B-0002kh-He; Tue, 20 Sep 2022 10:56:17 +0200
Date:   Tue, 20 Sep 2022 10:56:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <20220920085617.7cfflloegh7en4mj@pengutronix.de>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
 <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
 <YyhsQ+l1Sls00F0M@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyhsQ+l1Sls00F0M@paasikivi.fi.intel.com>
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

...

> > > > +	ret = clk_prepare_enable(mt9m111->clk);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	extclk_rate = clk_get_rate(mt9m111->clk);
> > > > +	clk_disable_unprepare(mt9m111->clk);
> > > 
> > > I don't think you'll need to enable a clock to just get its frequency.
> > 
> > The official API states that you need to turn on the clk before
> > requesting it and it makes sense. Also there is a new helper
> > devm_clk_get_enabled() which addresses simple clk usage since most of
> > drivers don't enable it before requesting the rate.
> 
> I guess the rate could change in the meantime, unless exclusive access is
> requested. 

Not only that, there are a bunch of clk provider hw around which may
need to turned on first. Anyway, I really don't care on this topic. As
I said I wanted to fullfil the API and if drop clk_prepare_enable() I
don't. So if this okay for you I will go that way.

> The clock framework currently doesn't offer a way to set the assigned
> rate and prevent changing it. But above, couldn't the clock frequency
> be changed again once the clock has been disabled?

Yes it could.

Regards,
  Marco
