Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D9709787
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjESMt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjESMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:49:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE310D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:49:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561c46e07d7so43927147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684500583; x=1687092583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GFqTBcslc6DLLEdQujNs5o7w2U9WLB+vITq+ASy0dBI=;
        b=k6rTK1bCuyU1IZn9OVmF00sEndwQ2WXjTRcbBCViUG3ny9XGVQgVKH7XKn91OJicrj
         F21KSOQtnCGsOsLouGtuydLE09f219E09pN+CXuV960NNy9YRK2VLHmGzgPwD9pQv/4i
         pHFvXFsHB2rCqoR0whXlmmLTAfdWIDIrWh7fe1vSLhLnqVlIe2TquFno47/Cp/pacOLQ
         KE7AP9D/nML+KcxRTNUxrHsYh6shfyUmjkJzXGAyhPhzHZS30eDnJ0VDc8xg2cjNuyRu
         Qph13ErRzE70yURaq36X1151K4JR9NzYs1mqJd6peyVhVsS+pZIhSfDD3uksPlgjyub0
         TOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500583; x=1687092583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFqTBcslc6DLLEdQujNs5o7w2U9WLB+vITq+ASy0dBI=;
        b=M8hcmUY2acppGKxUZIQH2Z5uMTRdb1TLow/Ga6fsLNYeXJ1woFxMavTa74nXyzFHRu
         MNzaEhluGXQg1M6GRYAPL1j90HGZ+MqCO3UsgU1RQ3xW57gFZhAoTp40C2DvZPDfq71w
         dms1GXneR75Z1q+CjIzUVdesLrsCHL2y9wSGWn5M5fJ8FNqSGfRXKFf8ItDLI8UMKGZ+
         e/Er9iXm8PY/kP+eftXoqnRAYdQBXtjYVbpKSEMSkgYHaPz/nyknCWXgD+LsFClkf2cZ
         +ayrJoC3f66KfWWqTXi5jFwWA247KAg/LaK21LBL6dcBW+vauoQlklPIwdsT7/zA4yvu
         O+HA==
X-Gm-Message-State: AC+VfDyfHWoOId9/XhvcuEdwgrEsd/GOnzbJQxMa3PLiWcUAg/4tI276
        eN8OubxswZL+1Q1Gzw+owawnnUMjcOPRHuyPrdZ1fA==
X-Google-Smtp-Source: ACHHUZ615++0zR/oJu8Lz/o2N60nAqzg3i9l+s8mTV6UAbCaZVNXzAqCHIue51mZ0me14gZz2RBCzicW2XdBYU6q/Bw=
X-Received: by 2002:a0d:cbd7:0:b0:561:a7d9:7f0f with SMTP id
 n206-20020a0dcbd7000000b00561a7d97f0fmr1874127ywd.29.1684500583458; Fri, 19
 May 2023 05:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230509172148.7627-1-quic_tdas@quicinc.com> <20230509172148.7627-3-quic_tdas@quicinc.com>
 <CAA8EJprHgOaiH2CFKmz_E+NvJpA+DRNE-r1wQXbSfYi+5qoBmA@mail.gmail.com> <2b013e9d-e4d9-075f-519b-0ce5c4f62894@quicinc.com>
In-Reply-To: <2b013e9d-e4d9-075f-519b-0ce5c4f62894@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 19 May 2023 15:49:32 +0300
Message-ID: <CAA8EJprUd-_9D+Xt=4vrXuzYuadhJFu1mA6Fow3K63U=0N2g5A@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] clk: qcom: videocc-sm8450: Add video clock
 controller driver for SM8450
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_jkona@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 at 13:53, Taniya Das <quic_tdas@quicinc.com> wrote:
>
> Hello Dmitry,
>
> Thank you for your review.
>
> On 5/10/2023 2:03 AM, Dmitry Baryshkov wrote:
> > On Tue, 9 May 2023 at 20:22, Taniya Das <quic_tdas@quicinc.com> wrote:
> >>
> >> Add support for the video clock controller driver for peripheral clock
> >> clients to be able to request for video cc clocks.
> >>
> >> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >> ---
> >> Changes since V3:
> >>   - Use lower case hex.
> >>   - Check the return value here and bail out early on failure in probe.
> >>
> >> Changes since V2:
> >>   - Update the header file name to match the latest upstream header
> >>     files.
> >>
> >> Changes since V1:
> >>   - Use DT indices instead of fw_name.
> >>   - Replace pm_runtime_enable with devm_pm_runtime_enable.
> >>   - Change license to GPL from GPL V2.
> >>
> >>   drivers/clk/qcom/Kconfig          |   9 +
> >>   drivers/clk/qcom/Makefile         |   1 +
> >>   drivers/clk/qcom/videocc-sm8450.c | 461 ++++++++++++++++++++++++++++++
> >>   3 files changed, 471 insertions(+)
> >>   create mode 100644 drivers/clk/qcom/videocc-sm8450.c
> >
> > [skipped]
> >
> >
> >> +static const struct qcom_reset_map video_cc_sm8450_resets[] = {
> >> +       [CVP_VIDEO_CC_INTERFACE_BCR] = { 0x80e0 },
> >> +       [CVP_VIDEO_CC_MVS0_BCR] = { 0x8098 },
> >> +       [CVP_VIDEO_CC_MVS0C_BCR] = { 0x8048 },
> >> +       [CVP_VIDEO_CC_MVS1_BCR] = { 0x80bc },
> >> +       [CVP_VIDEO_CC_MVS1C_BCR] = { 0x8070 },
> >
> > Can we have a common VIDEO_CC prefix here please?
>
> The BCR names are coming from hardware plan and software interface, thus
> we would like to keep them intact.

We have had a similar discussion on the sm8350-videocc driver. While
keeping the hardware names is nice, name uniformity also should not be
neglected. It is much easier to follow and verify the patches if all
videocc resets start with VIDEO_CC name.

>
>
> >
> >> +       [VIDEO_CC_MVS0C_CLK_ARES] = { 0x8064, 2 },
> >> +       [VIDEO_CC_MVS1C_CLK_ARES] = { 0x808c, 2 },
> >> +};
> >> +
>
> The ARES resets are coming from VideoCC clocks(CBCR), hence the name
> starts with VIDEO_CC.
>
> >> +static const struct regmap_config video_cc_sm8450_regmap_config = {
> >> +       .reg_bits = 32,
> >> +       .reg_stride = 4,
> >> +       .val_bits = 32,
> >> +       .max_register = 0x9f4c,
> >> +       .fast_io = true,
> >> +};
> >> +
> >> +static struct qcom_cc_desc video_cc_sm8450_desc = {
> >> +       .config = &video_cc_sm8450_regmap_config,
> >> +       .clks = video_cc_sm8450_clocks,
> >> +       .num_clks = ARRAY_SIZE(video_cc_sm8450_clocks),
> >> +       .resets = video_cc_sm8450_resets,
> >> +       .num_resets = ARRAY_SIZE(video_cc_sm8450_resets),
> >> +       .gdscs = video_cc_sm8450_gdscs,
> >> +       .num_gdscs = ARRAY_SIZE(video_cc_sm8450_gdscs),
> >> +};
> >> +
> >> +static const struct of_device_id video_cc_sm8450_match_table[] = {
> >> +       { .compatible = "qcom,sm8450-videocc" },
> >> +       { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, video_cc_sm8450_match_table);
> >> +
> >> +static int video_cc_sm8450_probe(struct platform_device *pdev)
> >> +{
> >> +       struct regmap *regmap;
> >> +       int ret;
> >> +
> >> +       ret = devm_pm_runtime_enable(&pdev->dev);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       regmap = qcom_cc_map(pdev, &video_cc_sm8450_desc);
> >> +       if (IS_ERR(regmap)) {
> >> +               pm_runtime_put(&pdev->dev);
> >> +               return PTR_ERR(regmap);
> >> +       }
> >> +
> >> +       clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
> >> +       clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
> >> +
> >> +       /*
> >> +        * Keep clocks always enabled:
> >> +        *      video_cc_ahb_clk
> >> +        *      video_cc_sleep_clk
> >> +        *      video_cc_xo_clk
> >> +        */
> >> +       regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
> >> +       regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
> >> +       regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
> >> +
> >> +       ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
> >> +
> >> +       pm_runtime_put(&pdev->dev);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static struct platform_driver video_cc_sm8450_driver = {
> >> +       .probe = video_cc_sm8450_probe,
> >> +       .driver = {
> >> +               .name = "video_cc-sm8450",
> >> +               .of_match_table = video_cc_sm8450_match_table,
> >> +       },
> >> +};
> >> +
> >> +static int __init video_cc_sm8450_init(void)
> >> +{
> >> +       return platform_driver_register(&video_cc_sm8450_driver);
> >> +}
> >> +subsys_initcall(video_cc_sm8450_init);
> >> +
> >> +static void __exit video_cc_sm8450_exit(void)
> >> +{
> >> +       platform_driver_unregister(&video_cc_sm8450_driver);
> >> +}
> >> +module_exit(video_cc_sm8450_exit);
> >
> > module_platform_driver() ?
> >
>
> We would like to keep the clock drivers all probed at subsys_initcall.
> We could revisit and update as cleanup if we want to move them to module
> init.

Any particular reason?

>
> >> +
> >> +MODULE_DESCRIPTION("QTI VIDEO_CC SM8450 Driver");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.17.1
> >>
> >
> >
>
> --
> Thanks & Regards,
> Taniya Das.



-- 
With best wishes
Dmitry
