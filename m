Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4672671ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAROD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjARODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812483C2F;
        Wed, 18 Jan 2023 05:39:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 434D7158E;
        Wed, 18 Jan 2023 14:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674049148;
        bh=z6/1ugtEqIPsW6HeLc7cP9ykrW1lmEKW7n77LGtAvGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TF5LGQ2V9lfP5/L0a8+RvazAmRTdz+9ol4iSdyWytTYH40zRLOmTrFvAGTm2m21Po
         HcFEqUwrvfzcdmk9YotuaGbCx/YIDA5h1chHHiArnjRlw1oZujzdssVjjyt/up2BGn
         ssKh15IsX2cU/LtqnMs3dHtugw+k7gb1iHPLzy/c=
Date:   Wed, 18 Jan 2023 15:39:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Message-ID: <Y8f2elExwiwxK2n+@pendragon.ideasonboard.com>
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
 <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
 <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Wolfram,

On Wed, Jan 18, 2023 at 02:30:51PM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 18, 2023 at 2:21 PM Laurent Pinchart wrote:
> > On Wed, Jan 18, 2023 at 01:20:02PM +0100, Wolfram Sang wrote:
> > > The earliest revision of these SoC may hang when underrunning. Later
> > > revisions have that fixed. Bail out when we detect a problematic
> > > version.
> > >
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >
> > > The BSP tries to work around the issue, yet this is neither upstreamable
> > > nor are we sure the solution is complete. Because the early SoC revision
> > > is hardly in use, we simply "document" the problem upstream.
> >
> > The workaround isn't upstreamable as-is, but I think it could be
> > upstreamed after being cleaned up.
> >
> > Overall, how much support do we still have upstream for H3 ES1.x, and do
> > we need to keep it ? H3 ES.1x is relatively old, does someone still rely
> > on it ?
> 
> I think the upstream support level for R-Car H3 ES1.x is about the same
> as for H3 ES2.0.

Question is, do we need to keep it ? :-) And if we do, instead of
black-listing devices in the VSP driver, how about dropping them from
r8a77950.dtsi ? We already delete quite a lot of devices there.

Note that without VSP support, you will get no display either, so the
DU device (and the LVDS encoder) so also be deleted.

-- 
Regards,

Laurent Pinchart
