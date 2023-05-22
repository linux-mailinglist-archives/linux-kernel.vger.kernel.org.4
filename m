Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B670CBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjEVVIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjEVVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:08:04 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BDCC4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:08:03 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B42D83F289;
        Mon, 22 May 2023 23:07:56 +0200 (CEST)
Date:   Mon, 22 May 2023 23:07:54 +0200
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
Subject: Re: [PATCH v12 01/10] drm/msm/dpu: set DSC flush bit correctly at
 MDP CTL flush register
Message-ID: <hkuonozf7gll3dd3bp6otdu6dspyrn633yokfx7sckqjs6tx2k@7nu77thwfaxs>
References: <1684783853-22193-1-git-send-email-quic_khsieh@quicinc.com>
 <1684783853-22193-2-git-send-email-quic_khsieh@quicinc.com>
 <d5e232d6-b789-a8c3-4ec5-7af0b9d8b9ae@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e232d6-b789-a8c3-4ec5-7af0b9d8b9ae@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 23:18:02, Dmitry Baryshkov wrote:
> On 22/05/2023 22:30, Kuogee Hsieh wrote:
> > DSC flush bit is the bit 22 of CTL flush register. BIT(22) is expected
> > to be written to CTL flush register to indicates that DSC is ready for
> > flush. However 0x22 (BIT(1) and BIT(5)) was written mistakenly at current
> 
> DSC_IDX is 22, not 0x22.
> 
> > implementation. Fix this problem by writing BIT(22) to CTL flush register
> > for DSC to work properly.

Perhaps this whole comment needs a rewrite anyway, instead of pointing
out grammar errors and confusion:

    The DSC CTL_FLUSH register should be programmed with the 22th bit
    (DSC_IDX) to flush the DSC hardware blocks, not the literal value of
    22 (which corresponds to flushing VIG1, VIG2 and RGB1 instead).

Patch contents are good though, thanks!

- Marijn

> > Changes in V12:
> > -- split this patch out of "separate DSC flush update out of interface"
> > 
> > Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> > index 4f7cfa9..69d0ea2 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> > @@ -525,7 +525,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
> >   		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
> >   			      BIT(cfg->merge_3d - MERGE_3D_0));
> >   	if (cfg->dsc) {
> > -		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
> > +		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, BIT(DSC_IDX));
> >   		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> >   	}
> >   }
> 
> -- 
> With best wishes
> Dmitry
> 
