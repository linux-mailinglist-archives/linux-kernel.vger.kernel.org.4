Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BC5EBB59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiI0HQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI0HQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA97E86899;
        Tue, 27 Sep 2022 00:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A6C615D3;
        Tue, 27 Sep 2022 07:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8ACC433D6;
        Tue, 27 Sep 2022 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664262962;
        bh=2rBhUwN8aOjx4dsbrO7nxEdpmx2ukolgAtSl/fXvzfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jU3TtDbLbimU5uWXGZkS3IneVkExqfjI5gn5BS8buZA27w4ha96ISHEyyxJzF8m/a
         AltVPvIt8pDCYSmvzLwEaNJB7OMiXqrp93Eyd/m0AM2TDqM4S6W7bfacd/3ga3RPi/
         Wqk8F+Qr97nefIOlnAAaQRoESdl1DnW7PFzTHF3qaXSOaLuXDTRw8esMhwB20L4pY7
         40gXeg6f15RWtM0eYaBeYSrwSNCtmx9I9rsul62ISb7ms7ZNqULW0ZBT99qr62E5tc
         0w4d8szuSurKtE1pS+AVQyDDHK4WbJ/PalTDe2K4crYkqCWr7AhK7VKP7+nKSs8I6h
         /bD4Qu/+Uts8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od4p6-0005H7-10; Tue, 27 Sep 2022 09:16:08 +0200
Date:   Tue, 27 Sep 2022 09:16:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Steev Klimaszewski <steev@kali.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [Freedreno] [PATCH v2 10/10] drm/msm/dsi: drop modeset sanity
 checks
Message-ID: <YzKjODjbQMx/hEk1@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-11-johan+linaro@kernel.org>
 <dc33f8c9-761a-deec-d1e5-ea30c4120729@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc33f8c9-761a-deec-d1e5-ea30c4120729@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:21:38AM -0700, Abhinav Kumar wrote:
> 
> 
> On 9/13/2022 1:53 AM, Johan Hovold wrote:
> > Drop the overly defensive modeset sanity checks of function parameters
> > which have already been checked or used by the callers.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> The change LGTM, hence
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> I think we can use below fixes tag so that we can pick up this entire 
> series for the fixes cycle.
> 
> Fixes: 3f0689e66352 ("drm/msm/dsi: check msm_dsi and dsi pointers before
> use")

Same here. I wouldn't add a Fixes tag unless required by some DRM
process.

Johan
