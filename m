Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839396B9549
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjCNNEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjCNNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:04:18 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E5643445
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:00:28 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3CF2C202F6;
        Tue, 14 Mar 2023 13:59:52 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:59:50 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] drm/msm/dsi: Fix DSI index detection when
 version clash occurs
Message-ID: <20230314125950.a2qsrrkxdf37ww7d@SoMainline.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-3-8bd7e1add38a@linaro.org>
 <20230313235109.u7cpusjr6t2xyxmk@SoMainline.org>
 <1eea079d-c0e8-b941-60d2-e0656cbb73be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eea079d-c0e8-b941-60d2-e0656cbb73be@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 12:59:40, Konrad Dybcio wrote:
> 
> 
> On 14.03.2023 00:51, Marijn Suijten wrote:
> > On 2023-03-07 14:01:41, Konrad Dybcio wrote:
> >> Currently, we allow for MAX_DSI entries in io_start to facilitate for
> >> MAX_DSI number of DSI hosts at different addresses. The configuration
> >> is matched against the DSI CTRL hardware revision read back from the
> >> component. We need a way to resolve situations where multiple SoCs
> >> with different register maps may use the same version of DSI CTRL. In
> >> preparation to do so, make msm_dsi_config a 2d array where each entry
> >> represents a set of configurations adequate for a given SoC.
> > 
> > Note that this code isn't fool-proof against different SoCs sharing the
> > same DSI host address but for different indices (for example, the
> > address at variant 0 DSI 0 could be the same as variant 1 DSI 1) and the
> > matching logic would wrongly return ID 0 instead of 1 for SoC variant 1,
> > because that's the first matching address it finds.
> I don't think we've had that happen yet, but if it ever does, that's out
> of scope of this patchset.

Sure, as long as we're at least aware of this.

> >> This is totally fine to do, as the only differentiating factors
> >> between same-version-different-SoCs configurations are the number of
> >> DSI hosts (1 or 2, at least as of today) and the set of base registers.
> >> The regulator setup is the same, because the DSI hardware is the same,
> >> regardless of the SoC it was implemented in.
> >>
> >> In addition to that, update the matching logic such that it will loop
> >> over VARIANTS_MAX variants, making sure they are all taken into account.
> > 
> > "in addition to that" makes it sound like you're doing a separate new
> > thing in this patch, when the match logic must in fact be updated to
> > make it compatible with the change described above (as in, it doesn't
> > compile if you don't account for the extra depth in the array).
> I really think you're nitpicking here..

It's not, this genuinely had me confused for a while.  Could have at
least been addressed as part of v4 that had to be sent regardless.

- Marijn
