Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94789652915
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiLTWcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiLTWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:32:12 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923E1DA47
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:32:10 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 477B2201D6;
        Tue, 20 Dec 2022 23:32:06 +0100 (CET)
Date:   Tue, 20 Dec 2022 23:32:04 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] drm/msm/dpu1: Wire up DSC mask for active CTL
 configuration
Message-ID: <20221220223204.i3tfa2biq7bgkg5o@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>, Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-4-marijn.suijten@somainline.org>
 <184d22f1-7ed1-4a67-1c25-9fafeb94db83@linaro.org>
 <20221214193026.dv2fuubysctcvlkg@SoMainline.org>
 <658da2cf-1e1a-af27-b085-edf0887b8dae@linaro.org>
 <8f33c1d0-a2ca-dc49-1884-01541ad83d49@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f33c1d0-a2ca-dc49-1884-01541ad83d49@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-16 14:20:52, Abhinav Kumar wrote:
> 
> 
> On 12/14/2022 5:08 PM, Dmitry Baryshkov wrote:
> > On 14/12/2022 21:30, Marijn Suijten wrote:
> >> On 2022-12-14 20:43:29, Dmitry Baryshkov wrote:
> >>> On 14/12/2022 01:22, Marijn Suijten wrote:
> >>>> [..]
> >>> We usually don't have DSC with the writeback, don't we?
> >>
> >> I am unsure so ended up adding them in writeback regardless.  Downstream
> >> uses a separate callback to process intf_cfg.dsc instead of going
> >> through setup_intf_cfg().
> >>
> >> To prevent these from being missed again (in the case of copy&paste),
> >> how about instead having some function that sets up intf_cfg with these
> >> default values from a phys_enc?  That way most of this remains oblivious
> >> to the caller.
> > 
> > I'm not sure this is possible. E.g. intf_cfg.dsc should not be set for 
> > the WB.
> > 
> 
> Although this change is harmless because 
> dpu_encoder_helper_get_dsc(phys_enc) will not return a valid DSC mask 
> for the WB encoder, hence the setup_intf_cfg will just skip the DSC 
> programming, I also agree that we can skip setting the intf_cfg.dsc for 
> the writeback encoder in this patch.

Since both of you agree that it is useless I'll drop this in V2.  Have
to confess that I know nothing about the writeback interface and haven't
even read the code; does it run in parallel to a "physical" (e.g.
DP/DSI) interface to capture screenshots (or even video) of what is
currently being shown on the screen?  By that logic the WB may have
needed to know what is going on in the HW, but it wouldn't have made any
sense regardless if the presented planes first pass through DSC before
being captured.  Something for me to read up on :)

- Marijn
