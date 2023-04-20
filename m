Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D66E9E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjDTVvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDTVvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:51:40 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84041FFB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:51:39 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B91F320548;
        Thu, 20 Apr 2023 23:51:36 +0200 (CEST)
Date:   Thu, 20 Apr 2023 23:51:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: Re: [PATCH v2 11/17] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
Message-ID: <fxph57xh3waxv7fpjnmgai4krpgrdxf3bmp2b3vbpgqbmkcy6u@ib3ds6idhgwz>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-11-ef76c877eb97@somainline.org>
 <20fab838-e05b-163d-aa72-bd8235df9f2c@linaro.org>
 <38030486-f08a-33e6-f8d1-3f4de379a75b@linaro.org>
 <3d1b08f0-adf9-8815-46f7-c31b54a7140c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d1b08f0-adf9-8815-46f7-c31b54a7140c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 04:03:31, Dmitry Baryshkov wrote:
[..]
> >>>    -static void dpu_hw_setup_vsync_source(struct dpu_hw_mdp *mdp,
> >>> +static void dpu_hw_setup_vsync_source_v1(struct dpu_hw_mdp *mdp,
> >>>            struct dpu_vsync_source_cfg *cfg)
> >>
> >> In my opinion _v1 is not really descriptive here. Could you please rename it to dpu_hw_setup_vsync_source_no_vsync_sel() ?
> > v1 refers to the CTL rev 100 a.k.a 1.0.0 a.k.a 1, but that's not
> > yet very well formulated upstream.. if we even need it..

I think v1 just refers to "the first next variant of this function",
similar to how for example Microsoft COM APIs start without a suffix,
then get 1, 2, 3 etc appended as new variants "of the same" trickle in.

> Yeah, but this mdp_top, not the ctl. And for CTL I'd probably rename _v1 
> to _active to follow actual feature name.

Correct, I just got lazily inspired by downstream here.  There it
switches on SDE_MDP_VSYNC_SEL which is based on DPU >= 5.0.0 as
explained in the patch.

> >> Or maybe rename dpu_hw_setup_vsync_source() to dpu_hw_setup_vsync_source_vsync_sel() and drop _v1 from this function.

Maybe add _and_ in there?

> >>
> >> Up to you.

- Marijn
