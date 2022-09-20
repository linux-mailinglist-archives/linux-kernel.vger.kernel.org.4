Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A725BE1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiITJUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiITJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:19:47 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B492668;
        Tue, 20 Sep 2022 02:19:39 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 59911200014;
        Tue, 20 Sep 2022 09:19:35 +0000 (UTC)
Date:   Tue, 20 Sep 2022 11:19:33 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, mchehab@kernel.org,
        laurent.pinchart+renesas@ideasonboard.com, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Message-ID: <20220920091933.kokk4le3cxpw4hvp@lati>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <YyhjpxHHFR4u+k+X@paasikivi.fi.intel.com>
 <20220919130829.ddoe2ajnrarkywgy@pengutronix.de>
 <YyhsQ+l1Sls00F0M@paasikivi.fi.intel.com>
 <20220920085617.7cfflloegh7en4mj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920085617.7cfflloegh7en4mj@pengutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, Sep 20, 2022 at 10:56:17AM +0200, Marco Felsch wrote:
> Hi Sakari,
>
> On 22-09-19, Sakari Ailus wrote:
>
> ...
>
> > > > > +	ret = clk_prepare_enable(mt9m111->clk);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	extclk_rate = clk_get_rate(mt9m111->clk);
> > > > > +	clk_disable_unprepare(mt9m111->clk);
> > > >
> > > > I don't think you'll need to enable a clock to just get its frequency.
> > >
> > > The official API states that you need to turn on the clk before
> > > requesting it and it makes sense. Also there is a new helper
> > > devm_clk_get_enabled() which addresses simple clk usage since most of
> > > drivers don't enable it before requesting the rate.

Had the same question on v1 and Marco pointed me to the clk_get_rate()
documentation
https://elixir.bootlin.com/linux/v6.0-rc1/source/include/linux/clk.h#L682

which indeed specifies
"This is only valid once the clock source has been enabled."

However none (or very few) of the linux-media i2c drivers actually do
that.

I have added in cc the clk framework maintainer to see if he can help
shed some light on this


> >
> > I guess the rate could change in the meantime, unless exclusive access is
> > requested.
>
> Not only that, there are a bunch of clk provider hw around which may
> need to turned on first. Anyway, I really don't care on this topic. As
> I said I wanted to fullfil the API and if drop clk_prepare_enable() I
> don't. So if this okay for you I will go that way.
>
> > The clock framework currently doesn't offer a way to set the assigned
> > rate and prevent changing it. But above, couldn't the clock frequency
> > be changed again once the clock has been disabled?
>
> Yes it could.
>
> Regards,
>   Marco
