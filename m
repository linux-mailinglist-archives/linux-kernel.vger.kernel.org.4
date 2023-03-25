Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039A6C9072
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCYTYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:24:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2330C0;
        Sat, 25 Mar 2023 12:24:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1CE7789F;
        Sat, 25 Mar 2023 20:24:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679772290;
        bh=tG8wxnDoKhE6wm3AvyjW+76dHK/YLCiCysUyipc/yhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWjPw8uONxngtUjdrdiW6BYpT8VyfZWnbPubrTVOw9IaNipY+6kwvaZQdi6cA3m3L
         N+t3QDVjYdSwNg9ghdL9KU3VJWMY1bVV0wkl/yDaKc49CyXXfuKdPb+dXhC7QYjWsF
         Gth9J41F+BXyOopFAiqzTFz4mLlwj+piAmrgzCTA=
Date:   Sat, 25 Mar 2023 21:24:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: rkisp1: Make local immutable array
 variables static const
Message-ID: <20230325192456.GE9876@pendragon.ideasonboard.com>
References: <20221117084217.3892680-1-paul.elder@ideasonboard.com>
 <20221117084217.3892680-3-paul.elder@ideasonboard.com>
 <Y3lYcRySWnrLKpWe@pendragon.ideasonboard.com>
 <Y9MMhSVrWujmfgCR@pendragon.ideasonboard.com>
 <20230324103744.ww67j3di73xg4ois@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324103744.ww67j3di73xg4ois@uno.localdomain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Fri, Mar 24, 2023 at 11:37:44AM +0100, Jacopo Mondi wrote:
> Hello
>    the change seems trivial, do we need an explicit ack from Dafna ?

An alternative patch has been merged in commit 4ee8191c7c9f ("media:
rkisp1: make a few const arrays static").

> Dafna are you comfortable being listed as maintainer of this driver or
> do you think you won't be able to dedicate time to it and need help ?
> 
> Thanks
>    j
> 
> On Fri, Jan 27, 2023 at 01:28:05AM +0200, Laurent Pinchart wrote:
> > On Sun, Nov 20, 2022 at 12:28:01AM +0200, Laurent Pinchart wrote:
> > > Hi Dafna,
> > >
> > > Are you fine with this patch, can I include it in my next pull request
> > > along with the other ones from the series ?
> >
> > Ping.
> >
> > > On Thu, Nov 17, 2022 at 05:42:16PM +0900, Paul Elder wrote:
> > > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > > The max_widths and max_heights variables in rkisp1_try_fmt() are
> > > > immutable and don't need to be allocated on the stack every time the
> > > > function is called. Make them static.
> > > >
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > ---
> > > >  .../media/platform/rockchip/rkisp1/rkisp1-capture.c  | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > > > index 7695ef134908..91e685fdbbe9 100644
> > > > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > > > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > > > @@ -1150,13 +1150,17 @@ static void rkisp1_try_fmt(const struct rkisp1_capture *cap,
> > > >  			   const struct rkisp1_capture_fmt_cfg **fmt_cfg,
> > > >  			   const struct v4l2_format_info **fmt_info)
> > > >  {
> > > > +	static const unsigned int max_widths[] = {
> > > > +		RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> > > > +		RKISP1_RSZ_SP_SRC_MAX_WIDTH,
> > > > +	};
> > > > +	static const unsigned int max_heights[] = {
> > > > +		RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> > > > +		RKISP1_RSZ_SP_SRC_MAX_HEIGHT,
> > > > +	};
> > > >  	const struct rkisp1_capture_config *config = cap->config;
> > > >  	const struct rkisp1_capture_fmt_cfg *fmt;
> > > >  	const struct v4l2_format_info *info;
> > > > -	const unsigned int max_widths[] = { RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> > > > -					    RKISP1_RSZ_SP_SRC_MAX_WIDTH };
> > > > -	const unsigned int max_heights[] = { RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> > > > -					     RKISP1_RSZ_SP_SRC_MAX_HEIGHT};
> > > >
> > > >  	fmt = rkisp1_find_fmt_cfg(cap, pixm->pixelformat);
> > > >  	if (!fmt) {

-- 
Regards,

Laurent Pinchart
