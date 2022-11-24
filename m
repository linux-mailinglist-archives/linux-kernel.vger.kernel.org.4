Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02A6377AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKXLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKXLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:30:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65072BF52;
        Thu, 24 Nov 2022 03:30:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F136A496;
        Thu, 24 Nov 2022 12:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669289431;
        bh=6iBaI/QCGoo2ZY32zk5Z6cIBXzXMw3aWSd+M5LBjEro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDoOGVB9NV/+PAaVf6hnJ3gmE64oNM0totgTZe2GeQCKZshBs217M279RbgCpXq/M
         M8VKPO/ZwyrrPPgxuMJ0b0Nt7EIBlSNngDZhAw4aLU3ZtDOjxt+4/GYpIaYy1e+vft
         xdPGIncIclM3C/judVqykvC5qA2N1Q1HpdOGOFGg=
Date:   Thu, 24 Nov 2022 13:30:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCHv3 1/1 RESEND] media: imx: Round line size to 4 bytes
Message-ID: <Y39Vx6L7MovBxOfs@pendragon.ideasonboard.com>
References: <20221016163928.1ef0a4fe.dorota.czaplejewicz@puri.sm>
 <Y00SSRMFuL3Drjd4@pendragon.ideasonboard.com>
 <20221017163059.377ac677.dorota.czaplejewicz@puri.sm>
 <20221101133834.0c1a20db.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101133834.0c1a20db.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On Tue, Nov 01, 2022 at 01:38:34PM +0100, Dorota Czaplejewicz wrote:
> On Mon, 17 Oct 2022 16:30:59 +0200 Dorota Czaplejewicz wrote:
> > On Mon, 17 Oct 2022 11:28:57 +0300 Laurent Pinchart wrote:
> 
> [snip]
> 
> > > I would also very much appreciate feedback from NXP on this. There's a
> > > risk of ill side-effects that I would prefer ruling out very clearly.  
> > 
> > I posted a question on the NXP forum: https://community.nxp.com/t5/i-MX-Processors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p/1538629#M196448
> > 
> 
> This question received a reply from NXP today: https://community.nxp.com/t5/i-MX-Processors/i-MX8MQ-CSI-line-size-constraint-documentation-mistake/m-p/1546872/highlight/true#M197067
> 
> Quoting NXP's answer:
> 
> > Do I understand correctly, that streams divisible by 4×4 will work on other i.MX8 hardware too? - Yes
> > Will those kind of resolutions work on i.MX7 series CSI hardware? - Yes
> 
> which implies no bad side effects the way I read it. Is this
> sufficient for the kernel?

Ideally I'd like to test that on i.MX7 but I don't think I'll have time
to do so in the near future. I don't want to block the patch on this, so
I'm fine merging it, but I'd like a comment in the code that explains
why it's safe to depart from the documentation.

Also, the discussion on the NXP forum said that a width that is a
multiple of 4 bytes but not a multiple of 8 bytes works only if the
height is also a multiple of 4. I don't see that constraint being
enforced in the code, am I missing something ?

You mentioned in the forum that you tried 1052x779 and that failed. How
did it fail ? Have you also tried 1052x778 ?

> > > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > > ---
> > > > Hello,
> > > > 
> > > > the Librem 5 is using an out-of-tree driver for s5k3l6xx, and
> > > > rounding to 4 is optimal to operate it.
> > > > 
> > > > This revision improves the commit message.
> > > > 
> > > > Cheers,
> > > > Dorota Czaplejewicz
> > > > 
> > > >  drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
> > > > index a0553c24cce4..af821b410c3f 100644
> > > > --- a/drivers/staging/media/imx/imx7-media-csi.c
> > > > +++ b/drivers/staging/media/imx/imx7-media-csi.c
> > > > @@ -999,10 +999,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
> > > >  	}
> > > >  
> > > >  	/* Round up width for minimum burst size */
> > > > -	width = round_up(mbus->width, 8);
> > > > +	width = round_up(mbus->width, 4);
> > > >  
> > > >  	/* Round up stride for IDMAC line start address alignment */
> > > > -	stride = round_up((width * cc->bpp) >> 3, 8);
> > > > +	stride = round_up((width * cc->bpp) >> 3, 4);
> > > >  
> > > >  	pix->width = width;
> > > >  	pix->height = mbus->height;    

-- 
Regards,

Laurent Pinchart
