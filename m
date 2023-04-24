Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19B86ED7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjDXW0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDXW0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:26:07 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE419765
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:25:35 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A9DAE3F5BC;
        Tue, 25 Apr 2023 00:25:32 +0200 (CEST)
Date:   Tue, 25 Apr 2023 00:25:31 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: Re: [PATCH v2 03/17] drm/msm/dpu: Move non-MDP_TOP INTF_INTR offsets
 out of hwio header
Message-ID: <7j6ww6nkplq6adjgpzu3uyswdmid2oxldpwlmis6cyw7tcbkrh@whpmzhsl5rpj>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-3-ef76c877eb97@somainline.org>
 <62d78d23-e191-a64f-5c4c-cd2c26217bdf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d78d23-e191-a64f-5c4c-cd2c26217bdf@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-24 13:44:55, Abhinav Kumar wrote:
> 
> 
> On 4/17/2023 1:21 PM, Marijn Suijten wrote:
> > These offsets do not fall under the MDP TOP block and do not fit the
> > comment right above.  Move them to dpu_hw_interrupts.c next to the
> > repsective MDP_INTF_x_OFF interrupt block offsets.
> > 
> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> This change itself is fine, hence
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> One comment below.
> 
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 5 ++++-
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h          | 3 ---
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > index 53326f25e40e..85c0bda3ff90 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> > @@ -15,7 +15,7 @@
> >   
> >   /*
> >    * Register offsets in MDSS register file for the interrupt registers
> > - * w.r.t. to the MDP base
> > + * w.r.t. the MDP base
> >    */
> >   #define MDP_SSPP_TOP0_OFF		0x0
> >   #define MDP_INTF_0_OFF			0x6A000
> > @@ -24,6 +24,9 @@
> >   #define MDP_INTF_3_OFF			0x6B800
> >   #define MDP_INTF_4_OFF			0x6C000
> >   #define MDP_INTF_5_OFF			0x6C800
> > +#define INTF_INTR_EN			0x1c0
> > +#define INTF_INTR_STATUS		0x1c4
> > +#define INTF_INTR_CLEAR			0x1c8
> >   #define MDP_AD4_0_OFF			0x7C000
> >   #define MDP_AD4_1_OFF			0x7D000
> >   #define MDP_AD4_INTR_EN_OFF		0x41c
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> > index feb9a729844a..5acd5683d25a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h
> > @@ -21,9 +21,6 @@
> >   #define HIST_INTR_EN                    0x01c
> >   #define HIST_INTR_STATUS                0x020
> >   #define HIST_INTR_CLEAR                 0x024
> 
> Even HIST_INTR_*** need to be moved then.

These are relative to MDP_SSPP_TOP0_OFF too just like
INTR(2)_{CLEAR,EN,STATUS} so I left them here.  Otherwise, *all* these
interrupt masks are probably best moved to dpu_hw_interrupts.c for
clarity, as that's also the only place they are used?

Let me know which way you prefer.

- Marijn

> > -#define INTF_INTR_EN                    0x1C0
> > -#define INTF_INTR_STATUS                0x1C4
> > -#define INTF_INTR_CLEAR                 0x1C8
> >   #define SPLIT_DISPLAY_EN                0x2F4
> >   #define SPLIT_DISPLAY_UPPER_PIPE_CTRL   0x2F8
> >   #define DSPP_IGC_COLOR0_RAM_LUTN        0x300
> > 
