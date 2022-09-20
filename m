Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE575BE070
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiITIlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiITIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:40:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0481AF3E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:39:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaYmb-0005c5-NA; Tue, 20 Sep 2022 10:39:09 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oaYma-0001Ji-JI; Tue, 20 Sep 2022 10:39:08 +0200
Date:   Tue, 20 Sep 2022 10:39:08 +0200
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
Message-ID: <20220920083908.st4h3pb6usn4zavu@pengutronix.de>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de>
 <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
 <YyjI/JOcryD8yKzT@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyjI/JOcryD8yKzT@paasikivi.fi.intel.com>
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
> On Mon, Sep 19, 2022 at 08:37:23PM +0300, Laurent Pinchart wrote:
> > > > > +	ctrl = v4l2_ctrl_new_int_menu(&tc358746->ctrl_hdl, NULL,
> > > > > +				      V4L2_CID_LINK_FREQ, 0, 0,
> > > > 
> > > > Shouldn't the max argument be set to the number of items minus 1 ?
> > > 
> > > Right now I would keep it that way since the driver only supports one
> > > link-frequencies setting. So the ctrl don't let the userspace assume
> > > that there are more than one link-frequency.
> > 
> > Good point. Can you add a short comment above the call to explain this ?
> 
> Wouldn't it be just easier to do what Laurent suggested originally? The end
> result is the same, isn't it, and no comment needed?

The end result depends on the device-tree given "link-frequencies"
property. The driver currently takes only one frequency but the
system-integrator of course can specify many more. In such case the 1st
is used. If I go with Laurent's comment, all frequencies would be shown
to the user-space but IMHO this shouldn't be the case since the driver
supports only 1 frequency.

> > 
> > > > > +				      link_frequencies);
> > > > > +	if (ctrl)
> > > > > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> 
> Now that this is a bridge, this value presumably doesn't need to change.

The value can change, e.g. if you have a few freq. to allow a wide range
of frame sizes. This can be the case to conform the emv tests. So there
can be a freq. for smaller frame sizes and one for larger frame sizes.

> There will just be more blanking if the source sub-device pixel rate is
> slower, right?

Please see above.

Regards,
  Marco
