Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5D5EBB51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiI0HPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiI0HOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D9642EE;
        Tue, 27 Sep 2022 00:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF08F6162A;
        Tue, 27 Sep 2022 07:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C4C433D6;
        Tue, 27 Sep 2022 07:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664262892;
        bh=AXaJuNbMdlA3wyGDnt3C65MZ5fPprSXOkBzMm29GxKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg4xfg3HPJJgLOswp5R4rRvhCSHY80EEGlrkDDVTVmIf2RUUaZq4gKG1UC71/6yLz
         sPW8a/BHJdKNLENWTlp2IZMlB37kPRyLzwizM0Y+fg2pGMGSB8RRPAIVVFiWYph/GI
         /PD0BNHVcy0b2gUBr33oPPSpFsFGWijRzO/kaFrDiw5v1bMca3zoPgr5Bs9EyuH3UQ
         Kv7FLpRzeSCWj/rCg+FaZFP0GaWsoiyd2rbO06yL+HygmEOq49g3dFpPedckH9Cux7
         Ntod7/E2gqpN1vNIOeGBdmB+TcNsp5fbDNY7Z5Or9rRdoROehDde0FZJa1UAfydqhv
         PW+swX5ksnP+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od4nx-0005GW-Jb; Tue, 27 Sep 2022 09:14:57 +0200
Date:   Tue, 27 Sep 2022 09:14:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: Re: [PATCH v2 09/10] drm/msm/dp: drop modeset sanity checks
Message-ID: <YzKi8XfV6V0p0TJi@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-10-johan+linaro@kernel.org>
 <d05290d8-7603-13b3-3cc4-d8509b03fc02@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05290d8-7603-13b3-3cc4-d8509b03fc02@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:17:20AM -0700, Abhinav Kumar wrote:
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
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")

Perhaps that's a requirement for drm, but I wouldn't add a Fixes tag for
this otherwise as it's not a bug.

You also have to watch out for Sasha and his autosel scripts which will
probably try to backport this to stable if it finds a Fixes tag.

Johan
