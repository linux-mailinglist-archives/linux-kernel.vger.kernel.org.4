Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680E16477B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHVJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:09:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB56FF23;
        Thu,  8 Dec 2022 13:09:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CC762067;
        Thu,  8 Dec 2022 21:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55DC433F0;
        Thu,  8 Dec 2022 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670533772;
        bh=G8BQaFYJmt2WISpWVDJiLLDJliL/iewvE0hv4aZ7DGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQe0ERjH2+peYAhgkJAN45eONKdM1NNP2U0WSx8OYOBz4ny1IjHUgGcTag5kvs/OB
         bFJHRy3TiNXFZrL5+1MyqjkrWQ1ARiQ26A/6cwFEbal9RVx6a/eDrYoIKvO/FnnbLJ
         EEgFmiP+aiHhZobfro+bEYAMqE/AgL823WhpfvmmWFg23qIPszBxLvcRVLVV3hBJGW
         ZpappejoAkgLAGFcY9IdaNzNv+HHm6iJk/k8J9bBJCFooZ6Uy5vA7FvJHN0uqwXS87
         l5lP3yCT5jcfIUq6QYJ4skzjwBui8Ts+9+JIof0IN6WAoeyIMhfq3Y9WG8Q8lnx+92
         SN3w2Yo7AqPiw==
Date:   Thu, 8 Dec 2022 15:09:29 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Message-ID: <20221208210929.capfm7jaltxvgpvq@builder.lan>
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221005143618.v7.4.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
 <CAPDyKFp8ynYSyMc+gXWuW8dC1j07X+8k3omsKKnLA_u+4X-vvA@mail.gmail.com>
 <76812eb1-ef4a-48b3-7b7a-231adc8c7c36@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76812eb1-ef4a-48b3-7b7a-231adc8c7c36@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:54:39PM +0530, Akhil P Oommen wrote:
> On 12/7/2022 9:16 PM, Ulf Hansson wrote:
> > On Wed, 5 Oct 2022 at 11:08, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >> Allow a consumer driver to poll for cx gdsc collapse through Reset
> >> framework.
> > Would you mind extending this commit message, to allow us to better
> > understand what part is really the consumer part.
> Sure. I can do that.
> >
> > I was expecting the consumer part to be the GPU (adreno) driver, but I
> > may have failed to understand correctly. It would be nice to see an
> > example of a typical sequence, where the reset is being
> > asserted/deasserted, from the consumer point of view. Would you mind
> > explaining this a bit more?
> https://elixir.bootlin.com/linux/v6.1-rc8/source/drivers/gpu/drm/msm/adreno/a6xx_gpu.c#L1309
> You are correct. The consumer is adreno gpu driver. When there is a gpu fault, these sequences are followed:
> 1. drop pm_runtime_put() for gpu device which will drops its vote on 'cx' genpd. line: 1306
> 2. At this point, there could be vote from either smmu driver (smmu is under same power domain too) or from other subsystems (tz/hyp).

Can you confirm that this is happening completely independent of what
the kernel does?

> 3. So we call into gdsc driver through reset interface to poll the gdsc register to ensure it collapsed at least once. Line: 1309

I other words, if we engineered 1. such that it would wait in
gdsc_disable() until the condition for 3. is reached, that should work
for you? (Obviously depending on the ability for us to engineer this...)

Regards,
Bjorn

> 4. Then we turn ON gpu. line:1314.
> 
> -Akhil.
> >
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Kind regards
> > Uffe
> >
> >> ---
> >>
> >> (no changes since v3)
> >>
> >> Changes in v3:
> >> - Convert 'struct qcom_reset_ops cx_gdsc_reset' to 'static const' (Krzysztof)
> >>
> >> Changes in v2:
> >> - Minor update to use the updated custom reset ops implementation
> >>
> >>  drivers/clk/qcom/gpucc-sc7280.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
> >> index 9a832f2..fece3f4 100644
> >> --- a/drivers/clk/qcom/gpucc-sc7280.c
> >> +++ b/drivers/clk/qcom/gpucc-sc7280.c
> >> @@ -433,12 +433,22 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
> >>         .fast_io = true,
> >>  };
> >>
> >> +static const struct qcom_reset_ops cx_gdsc_reset = {
> >> +       .reset = gdsc_wait_for_collapse,
> >> +};
> >> +
> >> +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
> >> +       [GPU_CX_COLLAPSE] = { .ops = &cx_gdsc_reset, .priv = &cx_gdsc },
> >> +};
> >> +
> >>  static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
> >>         .config = &gpu_cc_sc7280_regmap_config,
> >>         .clks = gpu_cc_sc7280_clocks,
> >>         .num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
> >>         .gdscs = gpu_cc_sc7180_gdscs,
> >>         .num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
> >> +       .resets = gpucc_sc7280_resets,
> >> +       .num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
> >>  };
> >>
> >>  static const struct of_device_id gpu_cc_sc7280_match_table[] = {
> >> --
> >> 2.7.4
> >>
> 
