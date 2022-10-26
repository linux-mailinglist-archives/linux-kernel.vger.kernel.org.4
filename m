Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793DE60E697
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiJZRfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiJZRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:35:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0067A2ABC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:35:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onkJG-0005YF-1O; Wed, 26 Oct 2022 19:35:22 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1onkJD-00060f-7f; Wed, 26 Oct 2022 19:35:19 +0200
Date:   Wed, 26 Oct 2022 19:35:19 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>, devicetree@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 8/9] media: i2c: ov5645: Don't return early on
 failures for s_stream(0)
Message-ID: <20221026173519.bm22im7uov6b4nnp@pengutronix.de>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026171721.4nfvhamguwnrw6zf@pengutronix.de>
 <CA+V-a8urKEjEKP0n9mki8xx1B9JLOMTYM4F1aXC3h_5Ne0+tCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8urKEjEKP0n9mki8xx1B9JLOMTYM4F1aXC3h_5Ne0+tCw@mail.gmail.com>
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

On 22-10-26, Lad, Prabhakar wrote:
> Hi Marco,
> 
> Thank you for the review.
> 
> On Wed, Oct 26, 2022 at 6:17 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Prabhakar,
> >
> > thanks for the patch, please see below my comments.
> >
> > On 22-10-26, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Make sure we dont stop the code flow in case of errors while stopping
> > > the stream and return the error code of the first error case if any.
> > >
> > > v4l2-core takes care of warning the user so no need to add a warning
> > > message in the driver.
> > >
> > > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v2->v3
> > > * Now propagating the first error code in case of failure.
> > >
> > > v1->v2
> > > * New patch
> > > ---
> > >  drivers/media/i2c/ov5645.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > > index eea3067ddc8b..5702a55607fc 100644
> > > --- a/drivers/media/i2c/ov5645.c
> > > +++ b/drivers/media/i2c/ov5645.c
> > > @@ -996,17 +996,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> > >               if (ret < 0)
> > >                       goto err_rpm_put;
> > >       } else {
> > > +             int stream_off_ret = 0;
> > > +
> > >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> >
> > If this write failed..
> >
> > >               if (ret < 0)
> > > -                     return ret;
> > > +                     stream_off_ret = ret;
> > >
> > >               ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > >                                      OV5645_SYSTEM_CTRL0_STOP);
> >
> > why should this write be successful?
> >
> Indeed that will fail unless I have a lucky day ;-)
> 
> But it seemed to be an overkill for adding an additional check to see
> if the previous write succeeded. Do you think this will create an
> issue?

Why not just say?

	ret = ov5645_write_reg();
	if (ret < 0)
		goto out;

	...

	out:

	dev_pm_xxx();

	return ret;

Regards,
  Marco
