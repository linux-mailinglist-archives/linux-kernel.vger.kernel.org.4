Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50C76988F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBOX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBOXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:55:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865E03864F;
        Wed, 15 Feb 2023 15:55:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72CE510B;
        Thu, 16 Feb 2023 00:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676505355;
        bh=xk5vBg/Iz8a0qsDOR7HVUgH7GHTgpabQoQX9UvpnwQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnCQ7g1HJ7UDnweuIrJb5hOmkxgrbwvyCESUQoL5/RRyCDaVRMnpgLFc1j7U6waP4
         i2U0QzMD9Kg/ud5VJh+Q5Y+P7QFtuPu5GB5olUm3bmhs8djJC0nzwnVd6HmKyHQ39g
         PXp39l1vaPYBElxfeVolTI3zOUOIHzaqUeCak8O8=
Date:   Thu, 16 Feb 2023 01:55:54 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
Message-ID: <Y+1xCtdxIoPtnOws@pendragon.ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <CAHCN7x+9E8qcBVOQZKTKagDkvkKVnqDtjvpNX-iNFYwCLRoYug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7x+9E8qcBVOQZKTKagDkvkKVnqDtjvpNX-iNFYwCLRoYug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Feb 15, 2023 at 07:57:53AM -0600, Adam Ford wrote:
> On Fri, Nov 18, 2022 at 3:44 AM Paul Elder wrote:
> 
> > This series depends on v3 of "dt-bindings: media: Add macros for video
> > interface bus types" [1].
> >
> > This series extends the rkisp1 driver to support the ISP found in the
> > NXP i.MX8MP SoC.
> 
> I'm going to spend some time testing this over the weekend.  Is there a V4
> pending, or should I just test whatever is in Laurent's repo?

I've updated all the v6.2-based branches on
https://gitlab.com/ideasonboard/nxp/linux.git (and renamed them to
v6.2/*). Beside a rebase, the v6.2/isp branch contains (at the bottom) 6
additional patches that I've previously posted to the linux-media
mailing list (feel free to review them ;-)).

My only concern with this series is with patch "media: rkisp1: Add match
data for i.MX8MP ISP", and in particular with the following hunk:

 enum rkisp1_cif_isp_version {
 	RKISP1_V10 = 10,
 	RKISP1_V11,
 	RKISP1_V12,
 	RKISP1_V13,
+	IMX8MP_V10,
 };

It's not a very nice versioning scheme :-S I'll see if I can find
something better, but regardless of that, I'll post v4 with the goal of
merging it in v6.4.

> I have an IMX219 camera with 4-lane support and an i.MX8M Plus kit from
> Beacon, and I want to test the RGGB bayer conversion to see how well it
> works.
> 
> > The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
> > and in the NXP i.MX8MP have the same origin, and have slightly diverged
> > over time as they are now independently developed (afaik) by Rockchip
> > and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
> > and is close enough to the RK3399 ISP that it can easily be supported by
> > the same driver.
>
> Is there a reason the driver cannot be renamed to a more generic name than
> rkisp1 if the Rockchip and VeriSilicon had similar origins?  Having the
> name Rockchip referenced from an NXP i.MX8M Plus seems odd to me.

The common roots of the IP core predate both Rockchip and VeriSilicon.
Those two implementations have now diverged (as with all forks), so
either name would be wrong in some cases :-S

> > The last two patches add support for UYVY output format, which can be
> > implemented on the ISP version in the i.MX8MP but not in the one in the
> > RK3399.
> >
> > This version of the series specifically has been tested on a Polyhex
> > Debix model A with an imx219 (Raspberry Pi cam v2).
> >
> > [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/
> >
> > Laurent Pinchart (3):
> >   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
> >   media: rkisp1: Add and use rkisp1_has_feature() macro
> >   media: rkisp1: Configure gasket on i.MX8MP
> >
> > Paul Elder (11):
> >   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
> >   media: rkisp1: Add match data for i.MX8MP ISP
> >   media: rkisp1: Add and set registers for crop for i.MX8MP
> >   media: rkisp1: Add and set registers for output size config on i.MX8MP
> >   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
> >   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
> >   media: rkisp1: Add register definitions for the test pattern generator
> >   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
> >   media: rkisp1: Support devices without self path
> >   media: rkisp1: Add YC swap capability
> >   media: rkisp1: Add UYVY as an output format
> >
> >  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
> >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
> >  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
> >  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
> >  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
> >  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
> >  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
> >  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
> >  include/uapi/linux/rkisp1-config.h            |   2 +
> >  9 files changed, 509 insertions(+), 40 deletions(-)

-- 
Regards,

Laurent Pinchart
