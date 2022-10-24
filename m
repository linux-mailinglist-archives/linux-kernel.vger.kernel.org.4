Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADFA60A1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJXLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJXLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A06659A;
        Mon, 24 Oct 2022 04:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38826125E;
        Mon, 24 Oct 2022 11:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D0C433C1;
        Mon, 24 Oct 2022 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611247;
        bh=XONUYrrBTIpNDIVeQuanVcQ94OVXm/q30QmP4QTO20M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAQ8DdUTn4cA4kXBumIiWfgCwZj8r++TXQs31zZ9q2+/MniKi1/s9M+kJykih7j0A
         BqF0YmiSmJB6PuGkssIdCnKPxV5B/gTla9yErlk0SoVDIeZlZQE2J2YU9dSlM1hJHU
         OhMBypH7gjMmdD0xcPXyT/X59MRJRufxXiKMCu2eWqm0hu353yVHeJHmuQVFsYUMIW
         LH/cB0bDDcRc1pGLgxQpuYhs7ZMW6yCvvMxuOGnZP//S+Owfjx+QZDbNLtwPQi5nMz
         o80e4z2fIZgkn5jOIm7wQSEvg6P22nA9KGNllj2gEjIPXKTfraSyfbII3HaJaBSk8T
         7+l0vbOwjVBYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1omviI-0006Ky-GC; Mon, 24 Oct 2022 13:33:50 +0200
Date:   Mon, 24 Oct 2022 13:33:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
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
Subject: Re: [PATCH v2 00/10] drm/msm: probe deferral fixes
Message-ID: <Y1Z4HrEcLDhe6gQr@hovoldconsulting.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <YymCll02tRIMb+9Z@hovoldconsulting.com>
 <Y1I77HYeOkx1fz1E@hovoldconsulting.com>
 <139426b9-0e5b-e4c3-27c6-584ab48517c2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139426b9-0e5b-e4c3-27c6-584ab48517c2@quicinc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:05:52AM -0700, Abhinav Kumar wrote:
> Hi Johan
> 
> On 10/20/2022 11:27 PM, Johan Hovold wrote:
> > On Tue, Sep 20, 2022 at 11:06:30AM +0200, Johan Hovold wrote:
> >> On Tue, Sep 13, 2022 at 10:53:10AM +0200, Johan Hovold wrote:
> >>> The MSM DRM driver is currently broken in multiple ways with respect to
> >>> probe deferral. Not only does the driver currently fail to probe again
> >>> after a late deferral, but due to a related use-after-free bug this also
> >>> triggers NULL-pointer dereferences.
> >>>
> >>> These bugs are not new but have become critical with the release of
> >>> 5.19 where probe is deferred in case the aux-bus EP panel driver has not
> >>> yet been loaded.
> >>>
> >>> The underlying problem is lifetime issues due to careless use of
> >>> device-managed resources.
> >>
> >> Any chance of getting this merged for 6.1?
> > 
> > Is anyone picking these up as fixes for 6.1-rc as we discussed?
> > 
> > Johan
> 
> All of these except the last two ( as discussed ) have landed in the 
> -fixes tree
> 
> https://gitlab.freedesktop.org/drm/msm/-/commit/6808abdb33bf90330e70a687d29f038507e06ebb

Ah, perfect, thanks.

When do you expect to send these on so that they end up in linux-next
and eventually Linus's tree?

Note that it looks like something happened with the commit messages when
you applied these. Specifically, the Fixes tags appears to now have a
line break in them and there's also some random whitespace before your
SoB:

	Fixes: c3bf8e21
	
	 ("drm/msm/dp: Add eDP support via aux_bus")
	Cc: stable@vger.kernel.org      # 5.19
	Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
	Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
	Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
	Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
	Patchwork: https://patchwork.freedesktop.org/patch/502667/
	Link: https://lore.kernel.org/r/20220913085320.8577-8-johan+linaro@kernel.org
	
	
	Signed-off-by: Abhinav Kumar's avatarAbhinav Kumar <quic_abhinavk@quicinc.com>

It's possible just the gitlab UI that's messed up, but perhaps you can
double check before they hit linux-next, which should complain about
this otherwise.

Johan
