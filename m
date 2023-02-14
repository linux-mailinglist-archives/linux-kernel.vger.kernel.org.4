Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A8F69665E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjBNORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjBNORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:17:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4629E09;
        Tue, 14 Feb 2023 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676384233; x=1707920233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zXTf3MmymcGTYiS/8pw46Ic62YElU9b0FxEiZvXIB58=;
  b=el8DD9mi6F7KmDJC+KMY5RvnMSPbDTBKp6RkK902MoYb/xVeZAiRo6mp
   EoZVIARPeb6aJP2y4usa4TBXiABME/vJpEHChFAWXPgmpeb8Nuz8Kr92M
   giV+8rSjWBhGUAsarwU4Ps7cpDx6t8wSsU28WqbbjxZy81fpSdZtr5Jte
   /v/PqCHOl0FREVMV+GOJqJmSPRaWBc9ZdwpXLqJi8Sgmk2jFDFj7riG9D
   01AvXm0MPggLTPOWLW61NTdy3HyTuo523pz6Meq24hPbjDExO8/0oQE0A
   MT1jXyzubpjh6dOgpwG+zK/xEzlCf9IPrVmyO7EtKR86X4ZftEJjxlV8B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="328879391"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="328879391"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 06:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="671231034"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="671231034"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga007.fm.intel.com with SMTP; 14 Feb 2023 06:16:41 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 14 Feb 2023 16:16:41 +0200
Date:   Tue, 14 Feb 2023 16:16:41 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liu Ying <victor.liu@nxp.com>, marex@denx.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, LW@karo-electronics.de
Subject: Re: [PATCH v3 3/6] drm: lcdif: Determine bus format and flags in
 ->atomic_check()
Message-ID: <Y+uXyfZLyZ7Bm4j8@intel.com>
References: <20230213085612.1026538-1-victor.liu@nxp.com>
 <20230213085612.1026538-4-victor.liu@nxp.com>
 <1755644.VLH7GnMWUR@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1755644.VLH7GnMWUR@steina-w>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 03:12:55PM +0100, Alexander Stein wrote:
> Hi Liu,
> 
> thanks for the update.
> 
> Am Montag, 13. Februar 2023, 09:56:09 CET schrieb Liu Ying:
> > Instead of determining LCDIF output bus format and bus flags in
> > ->atomic_enable(), do that in ->atomic_check().  This is a
> > preparation for the upcoming patch to check consistent bus format
> > and bus flags across all first downstream bridges in ->atomic_check().
> > New lcdif_crtc_state structure is introduced to cache bus format
> > and bus flags states in ->atomic_check() so that they can be read
> > in ->atomic_enable().
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v2->v3:
> > * No change.
> > 
> > v1->v2:
> > * Split from patch 2/2 in v1. (Marek, Alexander)
> > * Add comment on the 'base' member of lcdif_crtc_state structure to
> >   note it should always be the first member. (Lothar)
> > 
> >  drivers/gpu/drm/mxsfb/lcdif_kms.c | 138 ++++++++++++++++++++++--------
> >  1 file changed, 100 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > b/drivers/gpu/drm/mxsfb/lcdif_kms.c index e54200a9fcb9..294cecdf5439 100644
> > --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > @@ -30,6 +30,18 @@
> >  #include "lcdif_drv.h"
> >  #include "lcdif_regs.h"
> > 
> > +struct lcdif_crtc_state {
> > +	struct drm_crtc_state	base;	/* always be the first 
> member */
> 
> Is it strictly necessary that base is the first member? to_lcdif_crtc_state() 
> should be able to handle any position within the struct. I mean it's sensible 
> to put it in first place. But the comment somehow bugs me.

NULL pointers is where these things go bad if it't not at
offset 0. Unless you're willing to always handle those
explicitly.

-- 
Ville Syrjälä
Intel
