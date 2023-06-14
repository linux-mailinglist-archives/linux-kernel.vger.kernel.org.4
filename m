Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178EC72F99F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjFNJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbjFNJoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:44 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085C1FEE;
        Wed, 14 Jun 2023 02:43:33 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AC2483F80E;
        Wed, 14 Jun 2023 11:43:29 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:43:27 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Enable BURST_MODE for command mode for DSI
 6G v1.3+
Message-ID: <o57lsyxwzz5ihqlzq4ewnlnevj36rrq44ohyaxm3htnxzmomxn@fuv2sa5frph3>
References: <20230608-b4-add-burst-mode-v1-1-55dfbcfada55@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608-b4-add-burst-mode-v1-1-55dfbcfada55@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-12 16:37:36, Jessica Zhang wrote:
> During a frame transfer in command mode, there could be frequent
> LP11 <-> HS transitions when multiple DCS commands are sent mid-frame or
> if the DSI controller is running on slow clock and is throttled. To
> minimize frame latency due to these transitions, it is recommended to
> send the frame in a single burst.
> 
> This feature is supported for DSI 6G 1.3 and above, thus enable burst
> mode if supported.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 744f2398a6d6..8254b06dca85 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -994,6 +994,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL,
>  			DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
>  			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay));
> +
> +		if (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> +				msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3)
> +			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2,
> +					DSI_CMD_MODE_MDP_CTRL2_BURST_MODE);

This is not part of the timing setup, and a similar BURST_MODE flag is
enabled for video-mode in dsi_ctrl_config() - should it be moved there?

(There is a dsi_sw_reset() in between the calls to dsi_timing_setup()
 and dsi_ctrl_cfg())

Note that that function sets up the CMD_CFG0 and CMD_CFG1 register, with
the former having a very similar layout to MDP_CTRL2... is there
documentation outlining the difference?

- Marijn

>  	}
>  }
>  
> 
> ---
> base-commit: dd969f852ba4c66938c71889e826aa8e5300d2f2
> change-id: 20230608-b4-add-burst-mode-a5bb144069fa
> 
> Best regards,
> -- 
> Jessica Zhang <quic_jesszhan@quicinc.com>
> 
