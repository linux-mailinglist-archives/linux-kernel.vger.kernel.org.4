Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6015BE169
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiITJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiITJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB56D9E9;
        Tue, 20 Sep 2022 02:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57026274F;
        Tue, 20 Sep 2022 09:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E58C433D6;
        Tue, 20 Sep 2022 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663664788;
        bh=6pYIi9glaYZlye/aQHBoMpVkZ1qcD8dJmGfOqYp0ROA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUD8S2gvOniifTyASmpBcDPIJdMlH8cRZA4WNglMYAr0pYRbk+Zw4hK34lc+dq20g
         I51hhRJ9LhYOzCL/W3aridwhiHSOGHKpEibeUa6BYHz7PrE3D072LoJ8eWqt2ywMHy
         oiPv4Dl5cuEuMknH2wHA7UGt/l2rw75KZrz0oF9k69yFtgkUbhkMsxbCFxn4POyG7W
         J2fN42NBPcPXPdQsiOE2Sa2mR+zPMVr9qxbsT5hU9SLMcnxECbTwlp2uICH5vFAtPV
         GeNPbY959ihZSBZmuOFuL3Tl3tS1nXoFHezTwXXvvN9ZlS1hsgtBARVHQMUm1mb85f
         k8PuqZSa7AOxg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaZD4-0002LH-9A; Tue, 20 Sep 2022 11:06:30 +0200
Date:   Tue, 20 Sep 2022 11:06:30 +0200
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
Message-ID: <YymCll02tRIMb+9Z@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913085320.8577-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:53:10AM +0200, Johan Hovold wrote:
> The MSM DRM driver is currently broken in multiple ways with respect to
> probe deferral. Not only does the driver currently fail to probe again
> after a late deferral, but due to a related use-after-free bug this also
> triggers NULL-pointer dereferences.
> 
> These bugs are not new but have become critical with the release of
> 5.19 where probe is deferred in case the aux-bus EP panel driver has not
> yet been loaded.
> 
> The underlying problem is lifetime issues due to careless use of
> device-managed resources.

Any chance of getting this merged for 6.1?

Johan

> Changes in v2
>  - use a custom devres action instead of amending the AUX bus interface
>    (Doug)
>  - split sanity check fixes and cleanups per bridge type (Dmitry)
>  - add another Fixes tag for the missing bridge counter reset (Dmitry)
> 
> 
> Johan Hovold (10):
>   drm/msm: fix use-after-free on probe deferral
>   drm/msm/dp: fix memory corruption with too many bridges
>   drm/msm/dsi: fix memory corruption with too many bridges
>   drm/msm/hdmi: fix memory corruption with too many bridges
>   drm/msm/dp: fix IRQ lifetime
>   drm/msm/dp: fix aux-bus EP lifetime
>   drm/msm/dp: fix bridge lifetime
>   drm/msm/hdmi: fix IRQ lifetime
>   drm/msm/dp: drop modeset sanity checks
>   drm/msm/dsi: drop modeset sanity checks
> 
>  drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_parser.c  |  6 +++---
>  drivers/gpu/drm/msm/dp/dp_parser.h  |  5 +++--
>  drivers/gpu/drm/msm/dsi/dsi.c       |  9 +++++----
>  drivers/gpu/drm/msm/hdmi/hdmi.c     |  7 ++++++-
>  drivers/gpu/drm/msm/msm_drv.c       |  1 +
>  6 files changed, 37 insertions(+), 17 deletions(-)
