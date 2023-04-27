Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017CF6F0D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjD0U0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjD0U0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:26:23 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270D114
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:26:22 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6C5D41FA82;
        Thu, 27 Apr 2023 22:26:20 +0200 (CEST)
Date:   Thu, 27 Apr 2023 22:26:19 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: remove GC related code from dpu
 catalog
Message-ID: <lbd7vhrjbl5lsno2gc2pdd56rp7n4lfhmr5xvbxnjwaacn4nub@7p27sam6t6gp>
References: <20230426192246.5517-1-quic_abhinavk@quicinc.com>
 <20230426192246.5517-3-quic_abhinavk@quicinc.com>
 <a1a4f31e-b591-498d-d99e-872661d154d1@linaro.org>
 <5b0fb557-482b-a3df-613e-371eddfee93b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b0fb557-482b-a3df-613e-371eddfee93b@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27 13:20:28, Abhinav Kumar wrote:
<snip>

> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> >> @@ -127,12 +127,10 @@ enum {
> >>   /**
> >>    * DSPP sub-blocks
> >>    * @DPU_DSPP_PCC             Panel color correction block
> >> - * @DPU_DSPP_GC              Gamma correction block
> >>    * @DPU_DSPP_IGC             Inverse gamma correction block
> >>    */
> >>   enum {
> >>       DPU_DSPP_PCC = 0x1,
> >> -    DPU_DSPP_GC,
> >>       DPU_DSPP_IGC,
> > 
> > Don't we need to remove this one too (in the previous patch)?
> 
> Yes, we should. I thought of it right after sending this. will push a v3 
> which fixes it in the prev patch.

Yes please.  Don't forget to mention that dpu_dspp_sub_blks didn't even
have an igc member describing the block.

- Marijn

> >>       DPU_DSPP_MAX
> >>   };
> >> @@ -433,22 +431,18 @@ struct dpu_sspp_sub_blks {
> >>    * @maxwidth:               Max pixel width supported by this mixer
> >>    * @maxblendstages:         Max number of blend-stages supported
> >>    * @blendstage_base:        Blend-stage register base offset
> >> - * @gc: gamma correction block
> >>    */
> >>   struct dpu_lm_sub_blks {
> >>       u32 maxwidth;
> >>       u32 maxblendstages;
> >>       u32 blendstage_base[MAX_BLOCKS];
> >> -    struct dpu_pp_blk gc;
> >>   };
> >>   /**
> >>    * struct dpu_dspp_sub_blks: Information of DSPP block
> >> - * @gc : gamma correction block
> >>    * @pcc: pixel color correction block
> >>    */
> >>   struct dpu_dspp_sub_blks {
> >> -    struct dpu_pp_blk gc;
> >>       struct dpu_pp_blk pcc;
> >>   };
> > 
