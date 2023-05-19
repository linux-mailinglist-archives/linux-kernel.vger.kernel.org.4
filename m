Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334F709707
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjESMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjESMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:04:46 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B10518F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:04:44 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B44081F97E;
        Fri, 19 May 2023 14:04:40 +0200 (CEST)
Date:   Fri, 19 May 2023 14:04:38 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 6/8] drm/msm/dpu: separate DSC flush update out of
 interface
Message-ID: <ku27atp4yqkpmz7g4ttylvzd43jmu4cwcs76nqgzramgxetjna@bu76f4c73724>
References: <1684360919-28458-1-git-send-email-quic_khsieh@quicinc.com>
 <1684360919-28458-7-git-send-email-quic_khsieh@quicinc.com>
 <evkla3rkf4tge6gln4lgtulj7q5gt6vef3i2yqupc5lj2oszfx@7ttyxzlmvet5>
 <8e9feb23-a5f0-7cd8-ebff-8e9097ff0ca1@quicinc.com>
 <b2fcc9f5-ca11-ab87-e40b-9c6d2662325b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2fcc9f5-ca11-ab87-e40b-9c6d2662325b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 01:40:19, Dmitry Baryshkov wrote:
> 
> On 19/05/2023 01:09, Kuogee Hsieh wrote:
> > 
> > On 5/17/2023 3:31 PM, Marijn Suijten wrote:
> >>
> >>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> >>> @@ -139,6 +139,11 @@ static inline void 
> >>> dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
> >>>                   CTL_DSPP_n_FLUSH(dspp - DSPP_0),
> >>>                   ctx->pending_dspp_flush_mask[dspp - DSPP_0]);
> >>>           }
> >>> +
> >>> +    if (ctx->pending_flush_mask & BIT(DSC_IDX))
> >>> +        DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH,
> >>> +                  ctx->pending_dsc_flush_mask);
> >> Again, when do we reset this mask to 0?  (v8 review)
> > 
> > can not find it.
> > 
> > let me add a separate  patch to fix this.
> 
> The pending_dsc_flush_mask was added in this patch, so the reset should 
> be a part of this patch too.

Yes, same patch.

Related question I asked in v8: only the global pending_flush_mask and
pending_dspp_flush_mask are reset in dpu_hw_ctl_clear_pending_flush().
Shall I send a patch to clear the other missing ones (e.g. merge_3d etc)
as well?

> >>> +
> >>>       DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, ctx->pending_flush_mask);
> >>>   }
> >>> @@ -285,6 +290,13 @@ static void 
> >>> dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
> >>>       ctx->pending_flush_mask |= BIT(MERGE_3D_IDX);
> >>>   }
> >>> +static void dpu_hw_ctl_update_pending_flush_dsc_v1(struct dpu_hw_ctl 
> >>> *ctx,
> >>> +                           enum dpu_dsc dsc_num)
> >>> +{
> >>> +    ctx->pending_dsc_flush_mask |= BIT(dsc_num - DSC_0);
> >>> +    ctx->pending_flush_mask |= BIT(DSC_IDX);
> >>> +}
> >>> +
> >>>   static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl 
> >>> *ctx,
> >>>       enum dpu_dspp dspp, u32 dspp_sub_blk)
> >>>   {
> >>> @@ -502,9 +514,6 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
> >>> dpu_hw_ctl *ctx,
> >>>       if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
> >>>           mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
> >>> -    if (cfg->dsc)
> >>> -        DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH, cfg->dsc);
> >>> -
> >>>       if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
> >>>           mode_sel |= BIT(17);
> >>> @@ -524,10 +533,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct 
> >>> dpu_hw_ctl *ctx,
> >>>       if (cfg->merge_3d)
> >>>           DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
> >>>                     BIT(cfg->merge_3d - MERGE_3D_0));
> >>> -    if (cfg->dsc) {
> >>> -        DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> >> Again, this bugfix of now wrapping DSC_IDX in BIT() should go in a
> >> separate Fixes: patch to have this semantic change documented.  (v8
> >> review)
> > That will be this patch. let me add Fixes at this patch
> 
> _separate_ patch.

Separate patch, and documenting clearly what happens and why.  Kuogee, I
can send this as well if it makes things more clear, since it doesn't
seem (from the patch description) that anyone noticed the
implication/bugfix in this change as a drive-by effect of porting
sde_hw_ctl_update_bitmask_dsc_v1() from downstream.

- Marijn

<snip>
