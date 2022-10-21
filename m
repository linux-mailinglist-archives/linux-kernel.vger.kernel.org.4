Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00560700C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJUG2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJUG2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B423B692;
        Thu, 20 Oct 2022 23:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06D5761DB4;
        Fri, 21 Oct 2022 06:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FB5C433B5;
        Fri, 21 Oct 2022 06:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666333691;
        bh=vki3SV9SSyngMAmDw2B3Z/Wta7lXrBwkYK2vC4dHXsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XejgPAxhO/ZnuUjU7V4eEv8ZNsIq5EHgiZwVRaQg7SqALQHSOvn1pbEX1kK7Wl5nu
         MGEapxwGWcGFJrgPZ7Iuw78CLtoChPKaiP/lMrUFVDd3rncHXnFKFCbOB8O7sXTbYl
         xkuxrAie2iu9GeckYRe1o9gdhPQdfpZ99E6GVsNjXUwiRl9y2wHvPSz9FqetXSqkWm
         Vng1In4qGW2AkZFbrAXz7Ys9Ae+Px8E2gfRSAiTaL6nu7gPtMNgEeujdkSDeJfyZNX
         3gkEKFh5qiMCoxHjBVB7e2tDpnnCRN4b6CQ0XYSsySd9WSFr/C+OZS1ECHqr+Tnplp
         fspZK3lJ2y3Ag==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ollVc-0000lm-HY; Fri, 21 Oct 2022 08:27:57 +0200
Date:   Fri, 21 Oct 2022 08:27:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] drm/msm: probe deferral fixes
Message-ID: <Y1I77HYeOkx1fz1E@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <YymCll02tRIMb+9Z@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YymCll02tRIMb+9Z@hovoldconsulting.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 11:06:30AM +0200, Johan Hovold wrote:
> On Tue, Sep 13, 2022 at 10:53:10AM +0200, Johan Hovold wrote:
> > The MSM DRM driver is currently broken in multiple ways with respect to
> > probe deferral. Not only does the driver currently fail to probe again
> > after a late deferral, but due to a related use-after-free bug this also
> > triggers NULL-pointer dereferences.
> > 
> > These bugs are not new but have become critical with the release of
> > 5.19 where probe is deferred in case the aux-bus EP panel driver has not
> > yet been loaded.
> > 
> > The underlying problem is lifetime issues due to careless use of
> > device-managed resources.
> 
> Any chance of getting this merged for 6.1?

Is anyone picking these up as fixes for 6.1-rc as we discussed?

Johan
 
> > Changes in v2
> >  - use a custom devres action instead of amending the AUX bus interface
> >    (Doug)
> >  - split sanity check fixes and cleanups per bridge type (Dmitry)
> >  - add another Fixes tag for the missing bridge counter reset (Dmitry)
> > 
> > 
> > Johan Hovold (10):
> >   drm/msm: fix use-after-free on probe deferral
> >   drm/msm/dp: fix memory corruption with too many bridges
> >   drm/msm/dsi: fix memory corruption with too many bridges
> >   drm/msm/hdmi: fix memory corruption with too many bridges
> >   drm/msm/dp: fix IRQ lifetime
> >   drm/msm/dp: fix aux-bus EP lifetime
> >   drm/msm/dp: fix bridge lifetime
> >   drm/msm/hdmi: fix IRQ lifetime
> >   drm/msm/dp: drop modeset sanity checks
> >   drm/msm/dsi: drop modeset sanity checks
> > 
> >  drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++++++-------
> >  drivers/gpu/drm/msm/dp/dp_parser.c  |  6 +++---
> >  drivers/gpu/drm/msm/dp/dp_parser.h  |  5 +++--
> >  drivers/gpu/drm/msm/dsi/dsi.c       |  9 +++++----
> >  drivers/gpu/drm/msm/hdmi/hdmi.c     |  7 ++++++-
> >  drivers/gpu/drm/msm/msm_drv.c       |  1 +
> >  6 files changed, 37 insertions(+), 17 deletions(-)
