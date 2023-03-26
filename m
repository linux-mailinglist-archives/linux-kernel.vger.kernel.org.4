Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB86C96CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCZQYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:24:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E049D5;
        Sun, 26 Mar 2023 09:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 164D3B80D17;
        Sun, 26 Mar 2023 16:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99907C433EF;
        Sun, 26 Mar 2023 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847857;
        bh=IGEd5W7TwFuc13MCnmwDt/Gvu0l2lx3AZLXmSs0KZaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewq4zUSujBGB09GG5DHTJZAqjRatXUnzpUniRWLo99ayZFw1yySCLo2zk91eBe0Sc
         v3dPgsrk6chXLJ6ET7r36WegTurp0GuUpIE204OcRI9CK9sC2meRX0lCJuP5WZjB80
         tD5XiysuHatR6TotxgHkfoMpgitiOWYf/7GQMpk8mMNuBbRfuaANfvUHC+UJ9AcF40
         SuwpYT0IBiayVfaFcJebL7haaFs9mGD/2TVivRQVFARLYAGTwicXPjfcSwniKHlBUT
         cKuyRRq1a8JTEb3mYIGuJEOt+cwOufYy9Fe+Pk2zm7QdoQqebm5yhU2ipml982kqAk
         8u8+NIJ7d30LA==
Date:   Sun, 26 Mar 2023 09:27:23 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        quic_bjorande@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
Subject: Re: [PATCH v14 14/14] drm/msm/dp: set self refresh aware based on
 PSR support
Message-ID: <20230326162723.3lo6pnsfdwzsvbhj@ripper>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:03:17PM +0530, Vinod Polimera wrote:
> For the PSR to kick in, self_refresh_aware has to be set.
> Initialize it based on the PSR support for the eDP interface.
> 

When I boot my sc8280xp devices (CRD and X13s) to console with this
patch included I get a login prompt, and then there are no more screen
updates.

Switching virtual terminal (ctrl+alt+fN) causes the screen to redraw.

Blindly login in and launching Wayland works and from then on screen
updates works as expected.

Switching from Wayland to another virtual terminal causes the problem to
re-appear, no updates after the initial refresh, switching back go the
Wayland-terminal crashed the machine.



Reverting this single patch resolves both the issue with the console
updating as exected and flipping between the virtual terminal with
Wayland and the others no longer crashes my machine.

Regards,
Bjorn

> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_drm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 029e08c..785d766 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -117,6 +117,8 @@ static int edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
>  	if (WARN_ON(!conn_state))
>  		return -ENODEV;
>  
> +	conn_state->self_refresh_aware = dp->psr_supported;
> +
>  	if (!conn_state->crtc || !crtc_state)
>  		return 0;
>  
> -- 
> 2.7.4
> 
