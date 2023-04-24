Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1C6ED760
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjDXWDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDXWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:03:14 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D941BD8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:03:11 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C77C83F364;
        Tue, 25 Apr 2023 00:03:02 +0200 (CEST)
Date:   Tue, 25 Apr 2023 00:03:01 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: Pass catalog pointers directly from
 RM instead of IDs
Message-ID: <ymq4kstme55dm3j5kr6trevnwdelhjq7e7m4yky6zcbnf7auid@66l7inxz4oq2>
References: <20230418-dpu-drop-useless-for-lookup-v2-0-acb08e82ef19@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v2-3-acb08e82ef19@somainline.org>
 <50d22e0c-84b3-0678-eb06-30fb66fd24cf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d22e0c-84b3-0678-eb06-30fb66fd24cf@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-21 16:25:15, Abhinav Kumar wrote:
> 
> 
> On 4/21/2023 1:53 PM, Marijn Suijten wrote:
> > The Resource Manager already iterates over all available blocks from the
> > catalog, only to pass their ID to a dpu_hw_xxx_init() function which
> > uses an _xxx_offset() helper to search for and find the exact same
> > catalog pointer again to initialize the block with, fallible error
> > handling and all.
> > 
> > Instead, pass const pointers to the catalog entries directly to these
> > _init functions and drop the for loops entirely, saving on both
> > readability complexity and unnecessary cycles at boot.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Overall, a nice cleanup!
> 
> One comment below.
> 
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c        | 37 +++++----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h        | 14 ++++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c        | 32 +++---------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h        | 11 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c       | 38 ++++-----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.h       | 12 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  2 +-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 40 ++++++-----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       | 12 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c         | 38 ++++-----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h         | 10 +++---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.c    | 33 +++----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_merge3d.h    | 14 ++++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 33 +++----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c       | 39 ++++------------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h       | 12 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c       | 33 +++----------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.h       | 11 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c         | 33 ++++---------------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h         | 11 +++----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           | 17 +++++-----
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c            | 18 +++++-----
> >   23 files changed, 139 insertions(+), 375 deletions(-)
> > 
> 
> <snipped>
> 
> > -struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
> > -		void __iomem *addr,
> > -		const struct dpu_mdss_cfg *m)
> > +struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> > +		void __iomem *addr)
> >   {
> >   	struct dpu_hw_intf *c;
> > -	const struct dpu_intf_cfg *cfg;
> > +
> > +	if (cfg->type == INTF_NONE) {
> > +		pr_err("Cannot create interface hw object for INTF_NONE type\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> 
> The caller of dpu_hw_intf_init which is the RM already has protection 
> for INTF_NONE, see below
> 
>          for (i = 0; i < cat->intf_count; i++) {
>                  struct dpu_hw_intf *hw;
>                  const struct dpu_intf_cfg *intf = &cat->intf[i];
> 
>                  if (intf->type == INTF_NONE) {
>                          DPU_DEBUG("skip intf %d with type none\n", i);
>                          continue;
>                  }
>                  if (intf->id < INTF_0 || intf->id >= INTF_MAX) {
>                          DPU_ERROR("skip intf %d with invalid id\n", 
> intf->id);
>                          continue;
>                  }
>                  hw = dpu_hw_intf_init(intf->id, mmio, cat);
> 
> So this part can be dropped.

I mainly intended to keep original validation where _intf_offset would
skip INTF_NONE, and error out.  RM init is hence expected to filter out
INTF_NONE instead of running into that `-EINVAL`, which I maintained
here.

If you think there won't be another caller of dpu_hw_intf_init, and that
such validation is hence excessive, I can remove it in a followup v3.

- Marijn

> >   	c = kzalloc(sizeof(*c), GFP_KERNEL);
> >   	if (!c)
> >   		return ERR_PTR(-ENOMEM);
> >   
> > -	cfg = _intf_offset(idx, m, addr, &c->hw);
> > -	if (IS_ERR_OR_NULL(cfg)) {
> > -		kfree(c);
> > -		pr_err("failed to create dpu_hw_intf %d\n", idx);
> > -		return ERR_PTR(-EINVAL);
> > -	}
> > +	c->hw.blk_addr = addr + cfg->base;
> > +	c->hw.log_mask = DPU_DBG_MASK_INTF;
> >   
> 
> <snipped>
