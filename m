Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26336C96D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjCZQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCZQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93C5B9B;
        Sun, 26 Mar 2023 09:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB2760EFE;
        Sun, 26 Mar 2023 16:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF88C433D2;
        Sun, 26 Mar 2023 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679848371;
        bh=4AFK6vcfElFe6Azrg1VDaxL1rJ8+QETKpTAkUymE5/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDnpg47FHroEp8sgXzAIC7qL3pEBM3uc7ZxohsNWhmoYklx8cxRO+oHPxeUZsdfJp
         n5tzkV1o4buQnD6XvczIhvI87NbsiW3NHgi3ayAS0DudJ+FbG394hK28ANLEyXtcpg
         ga36DxxKzvd+x4Uu6UGv4znjC/I6CphlEzVhXAmipLf56YW6NbnTMz8rE73WcXYh5b
         l4Sgi7XLFr6aY9Mi1GISxh7Ca+TEjK6WeESFUOUFyEDv5uurYvbzhcm7txlNHwFjDA
         DAIcsHFmndgelOlurrVMipk8+Hqf+pP3ZQju0xIbrMKpPjJzv0QvO2bU1ynV36Xk0e
         QxHUOkSQxG51g==
Date:   Sun, 26 Mar 2023 09:35:56 -0700
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
Message-ID: <20230326163556.iesjkoh3nw3iwvf2@ripper>
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
 <1677774797-31063-15-git-send-email-quic_vpolimer@quicinc.com>
 <20230326162723.3lo6pnsfdwzsvbhj@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326162723.3lo6pnsfdwzsvbhj@ripper>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 09:27:23AM -0700, Bjorn Andersson wrote:
> On Thu, Mar 02, 2023 at 10:03:17PM +0530, Vinod Polimera wrote:
> > For the PSR to kick in, self_refresh_aware has to be set.
> > Initialize it based on the PSR support for the eDP interface.
> > 
> 
> When I boot my sc8280xp devices (CRD and X13s) to console with this
> patch included I get a login prompt, and then there are no more screen
> updates.
> 
> Switching virtual terminal (ctrl+alt+fN) causes the screen to redraw.
> 
> Blindly login in and launching Wayland works and from then on screen
> updates works as expected.
> 
> Switching from Wayland to another virtual terminal causes the problem to
> re-appear, no updates after the initial refresh, switching back go the
> Wayland-terminal crashed the machine.
> 

Also, trying to bring the eDP-screen back from DPMS gives me:

<3>[ 2355.218099] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
<3>[ 2355.218926] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
<3>[ 2355.262859] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
<3>[ 2355.263600] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
<3>[ 2355.305211] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
<3>[ 2355.305955] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
<3>[ 2355.345250] [drm:dp_catalog_ctrl_set_pattern_state_bit [msm]] *ERROR* set state_bit for link_train=1 failed
<3>[ 2355.346026] [drm:dp_ctrl_setup_main_link [msm]] *ERROR* link training #1 failed. ret=-110
<3>[ 2355.405650] [drm:dp_display_process_hpd_high [msm]] *ERROR* failed to complete DP link training
<3>[ 2355.668988] [drm:dpu_encoder_phys_vid_wait_for_commit_done:488] [dpu error]vblank timeout
<3>[ 2355.669030] [drm:dpu_kms_wait_for_commit_done:510] [dpu error]wait for commit done returned -110
<3>[ 2355.699989] [drm:dpu_encoder_frame_done_timeout:2398] [dpu error]enc35 frame done timeout

And then the machine just resets.

Regards,
Bjorn

> 
> 
> Reverting this single patch resolves both the issue with the console
> updating as exected and flipping between the virtual terminal with
> Wayland and the others no longer crashes my machine.
> 
> Regards,
> Bjorn
> 
> > Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_drm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> > index 029e08c..785d766 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> > @@ -117,6 +117,8 @@ static int edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
> >  	if (WARN_ON(!conn_state))
> >  		return -ENODEV;
> >  
> > +	conn_state->self_refresh_aware = dp->psr_supported;
> > +
> >  	if (!conn_state->crtc || !crtc_state)
> >  		return 0;
> >  
> > -- 
> > 2.7.4
> > 
