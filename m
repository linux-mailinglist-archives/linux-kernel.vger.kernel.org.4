Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241472FA23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjFNKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjFNKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:09:42 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884EE69
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:09:41 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DA6493F7F8;
        Wed, 14 Jun 2023 12:09:38 +0200 (CEST)
Date:   Wed, 14 Jun 2023 12:09:37 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for databus widen mode
Message-ID: <daltbzem4x5azhqt4xtjip4alc2r6huis4qnukl5h2w3rle56y@7b7kkoltys4s>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-13 18:57:10, Jessica Zhang wrote:
> DPU 5.x+ and DSI 6G 2.5.x+ support a databus-widen mode that allows for
> more compressed data to be transferred per pclk.
> 
> This series adds support for enabling this feature for both DPU and DSI
> by doing the following:
> 
> 1. Add a DPU_INTF_DATABUS_WIDEN feature flag
> 2. Add a DPU INTF op to set the DATABUS_WIDEN register
> 3. Set the DATABUS_WIDEN register and do the proper hdisplay
>    calculations in DSI when applicable
> 
> Note: This series will only enable the databus-widen mode for command
> mode as we are currently unable to validate it on video mode.
> 
> Depends on: "Add DSC v1.2 Support for DSI" [1]
> 
> [1] https://patchwork.freedesktop.org/series/117219/

Didn't Dmitry already pick that up for msm-next-lumag?

- Marijn

> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Jessica Zhang (3):
>       drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag for DPU >= 5.0
>       drm/msm/dpu: Set DATABUS_WIDEN on command mode encoders
>       drm/msm/dsi: Enable DATABUS_WIDEN for DSI command mode
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c       |  3 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h       |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 12 ++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
>  drivers/gpu/drm/msm/dsi/dsi.xml.h                    |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c                   | 19 ++++++++++++++++++-
>  7 files changed, 41 insertions(+), 2 deletions(-)
> ---
> base-commit: 1981c2c0c05f5d7fe4d4552d4f352cb46840e51e
> change-id: 20230525-add-widebus-support-f785546ee751
> 
> Best regards,
> -- 
> Jessica Zhang <quic_jesszhan@quicinc.com>
> 
