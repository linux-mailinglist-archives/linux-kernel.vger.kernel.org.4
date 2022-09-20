Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA395BE494
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiITLfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiITLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:35:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028376CD25
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:35:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oabXC-0008TL-5B; Tue, 20 Sep 2022 13:35:26 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oabXA-000335-Om; Tue, 20 Sep 2022 13:35:24 +0200
Date:   Tue, 20 Sep 2022 13:35:24 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        hverkuil@xs4all.nl, jacopo@jmondi.org,
        kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <20220920113524.yq2abqbunvfipnb2@pengutronix.de>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhjB+RbLokmBKPx@paasikivi.fi.intel.com>
 <YyhlQPhezmLG8ZCn@pendragon.ideasonboard.com>
 <Yyhonw7SEjkAPivN@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyhonw7SEjkAPivN@paasikivi.fi.intel.com>
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

On 22-09-19, Sakari Ailus wrote:
> On Mon, Sep 19, 2022 at 03:49:04PM +0300, Laurent Pinchart wrote:
> > On Mon, Sep 19, 2022 at 12:39:35PM +0000, Sakari Ailus wrote:
> > > > +	dev_set_drvdata(dev, tc358746);
> > > > +	pm_runtime_set_autosuspend_delay(dev, 200);
> > > > +	pm_runtime_use_autosuspend(dev);
> > > > +	pm_runtime_enable(dev);
> > > > +
> > > > +	err = tc358746_init_hw(tc358746);
> > > 
> > > The driver depends on runtime PM being enabled but does not depend on
> > > CONFIG_PM. I'd suggest to power the device on and only then enable runtime
> > > PM. See
> > > <URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html#power-management>.
> > 
> > Or simply depend on CONFIG_PM :-)
> 
> The user can still disable runtime PM.

You mean by user-space? If I read the runtime.c code correctly in such
case the core handles this enabling if one forbid it by increasing the
usage-counter and calling the resume callback. So it is powered as you
want. To fix the PM Kconfig, I will add "depends on PM".

Regards,
  Marco

> I guess few do though. This should be addressed separately from this
> driver, it'd be good to be able to deny that. In fact, no-one has ever
> probably tested this for a large number of drivers and I guess it exists
> just to have a way to disable runtime PM support in drivers that do not
> work with it...
> 
> -- 
> Sakari Ailus
> 
