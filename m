Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D06D7352
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjDEEV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjDEEV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:21:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3576710CC;
        Tue,  4 Apr 2023 21:21:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33E95496;
        Wed,  5 Apr 2023 06:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680668484;
        bh=06b+qUYIeMEy2j8ZVYH6n4c5h8AQzDzTI/K0SUs6hpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3DXZAgPSkFBSo349r719aTrMG7jL1OCfZ9KbK4o1fsp7QOcrbMaCRgkDyEV9l+tL
         8Rfv6IRNp4kn9ARMeNqKbl9eJJSgw/Dc6xBDN8wdyXmxC1B4CIGSaSa3KHRae7vWtB
         DUwjObQxnBwC+v856IkhPUrrk+TgLUIXLO6dLmKI=
Date:   Wed, 5 Apr 2023 07:21:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/9] media: v4l2: Add NV12_16L16 pixel format to v4l2
 format info
Message-ID: <20230405042131.GO9915@pendragon.ideasonboard.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
 <20230325210120.GB22214@pendragon.ideasonboard.com>
 <40774dc0ef32246af76a202caca3632abc1ae25f.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40774dc0ef32246af76a202caca3632abc1ae25f.camel@ndufresne.ca>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Fri, Mar 31, 2023 at 02:54:20PM -0400, Nicolas Dufresne wrote:
> Le samedi 25 mars 2023 à 23:01 +0200, Laurent Pinchart a écrit :
> > On Fri, Mar 24, 2023 at 04:12:21PM +0100, Paul Kocialkowski wrote:
> > > Represent the NV12_16L16 pixel format in the v4l2 format info table.
> > > This is a 16x16 tiled version of NV12.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-common.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> > > index 3d044b31caad..5101989716aa 100644
> > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > @@ -280,6 +280,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
> > >  		/* Tiled YUV formats */
> > >  		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> > >  		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> > > +		{ .format = V4L2_PIX_FMT_NV12_16L16,	.pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2,
> > > +		  .block_w = { 16, 16, 0, 0 }, .block_h = { 16, 16, 0, 0 } },
> > 
> > Not necessarily related to this patch, but I'm a bit puzzled by why
> > V4L2_PIX_FMT_NV12_4L4 doesn't list block sizes.
> 
> It looks like Ezequiel introduced that initially, but didn't introduce any tiled
> format, as a side effect, we missed it and no one ever used it.
> 
> In practice, its not dramatic, since most of the time, the alignment needed is
> bigger then the block (specially with only 4x4 tiles), but we should certainly
> fix that, thanks for spotting.

Just to make sure this won't fall through the cracks, will you send a
patch ?

> > >  
> > >  		/* YUV planar formats, non contiguous variant */
> > >  		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },

-- 
Regards,

Laurent Pinchart
