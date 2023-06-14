Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B301C72FE79
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244571AbjFNMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244606AbjFNMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:23:42 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C591BFB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:23:40 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 57B7D3F403;
        Wed, 14 Jun 2023 14:23:38 +0200 (CEST)
Date:   Wed, 14 Jun 2023 14:23:36 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag
 for DPU >= 5.0
Message-ID: <ycgei43x4kfmjk7g7gbeglehtiiinfbqmrjbdzcy56frxbtd2z@yk2f5kgrkbrt>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-1-c7069f2efca1@quicinc.com>
 <wpjxrnhbcanbc5iatxnff25yrrdfrtmgb24sgwyo457dz2oyjz@e2docpcb6337>
 <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4fb042c-1458-6077-3c49-8cc02638b27c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 15:01:59, Dmitry Baryshkov wrote:
> On 14/06/2023 14:42, Marijn Suijten wrote:
> > On 2023-06-13 18:57:11, Jessica Zhang wrote:
> >> DPU 5.x+ supports a databus widen mode that allows more data to be sent
> >> per pclk. Enable this feature flag on all relevant chipsets.
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 ++-
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
> >>   2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> index 36ba3f58dcdf..0be7bf0bfc41 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> >> @@ -103,7 +103,8 @@
> >>   	(BIT(DPU_INTF_INPUT_CTRL) | \
> >>   	 BIT(DPU_INTF_TE) | \
> >>   	 BIT(DPU_INTF_STATUS_SUPPORTED) | \
> >> -	 BIT(DPU_DATA_HCTL_EN))
> >> +	 BIT(DPU_DATA_HCTL_EN) | \
> >> +	 BIT(DPU_INTF_DATABUS_WIDEN))
> > 
> > This doesn't work.  DPU 5.0.0 is SM8150, which has DSI 6G 2.3.  In the
> > last patch for DSI you state and enable widebus for DSI 6G 2.5+ only,
> > meaning DPU and DSI are now desynced, and the output is completely
> > corrupted.

Tested this on SM8350 which actually has DSI 2.5, and it is also
corrupted with this series so something else on this series might be
broken.

> > Is the bound in dsi_host wrong, or do DPU and DSI need to communicate
> > when widebus will be enabled, based on DPU && DSI supporting it?
> 
> I'd prefer to follow the second approach, as we did for DP. DPU asks the 
> actual video output driver if widebus is to be enabled.

Doesn't it seem very strange that DPU 5.x+ comes with a widebus feature,
but the DSI does not until two revisions later?  Or is this available on
every interface, but only for a different (probably DP) encoder block?

- Marijn
