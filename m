Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14B6A9581
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCCKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCCKo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:44:27 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE4B14E8B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:44:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y144so1461613yby.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8pG0nVLUvEEf9hUN17FT427i/glkZx20ndqtH8ijFQ=;
        b=JbAH9KQ0cBOXbBizl0HybTOhuI/QRBZiP2KH/wzmToTl50GUphD6z+jHj28KlkBkH0
         +bUlkrRz3AE7aPgXVL7zCS2IO2o+2nheJtNxgpvtwOkTw/YzOtncAAXHxmfJKv2kq8yN
         MbIwBXm4iPJxKYWOxEVZApqFCdzuj7kjik2ZD3Yw+E+cJ6SLI6WH7gmM2j2riAQR9/wk
         uzBAjSdZLB0jTRQ0DusEDCOotOr5Ai7KZ5svX4gBNkCRTVrwf4D6RCVOkotgM6+usSQL
         TtTHvSy60hQTDvAp/8im6+MmU+VEpVOXkmTe6OJL0MmNIxYWSMxZOQZDTMs+AJqUiY3M
         Jy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8pG0nVLUvEEf9hUN17FT427i/glkZx20ndqtH8ijFQ=;
        b=1NU0IdQZY8ZinZU2urfDY7ZrJCbeRZih+/w7bIXddjxEUYQhpRBPmiFfs1zgruTxtZ
         kpQrgcPS8HbsF2e10MoftqUGmczUJ9qSbmC65LuAYviPsUi8gsVyaOAoNWSDLjZnaEed
         ugp4vHDk1MWvUJujDs49yr/qxLL+vvWQUGakcfJKrcsuRxlDDXGFZnNkRGlwDERzOvwF
         ByR5v9pKlHkg6A7j1/jX5/Z2Hj8PWhePLLBRyUkVohEjMsCNefQJANhzdpEzbpp7/Ujl
         gxO9R3vhkO7FB5ZXhfVN0ZEBV10EhZ99Sb25oszFOvTS0qfGLWlrov5T9PEg6OpipDok
         v7Fw==
X-Gm-Message-State: AO0yUKWUuvDaTCsZHuBWxB0AXFEnxJb15FVQb8Grhnt4CUhOtxgnZJHa
        5jznWI1QQR17f7uhveo2vuBlHeEKbY+1xHBonU+j5g==
X-Google-Smtp-Source: AK7set9GaHdC4Ug5fCNn3crDoOUpfCFfnJXG+HCzbCO8SmQlTliIagkSZtDCmQh+454wscX+X527ZvjYvfNS2Hl7uHM=
X-Received: by 2002:a05:6902:312:b0:a58:af0b:5150 with SMTP id
 b18-20020a056902031200b00a58af0b5150mr583253ybs.3.1677840265743; Fri, 03 Mar
 2023 02:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20230303092859.22094-1-quic_tdas@quicinc.com> <20230303092859.22094-2-quic_tdas@quicinc.com>
In-Reply-To: <20230303092859.22094-2-quic_tdas@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 3 Mar 2023 12:44:14 +0200
Message-ID: <CAA8EJpq5xBF=Wt-1_hGR-7qZHREcALurmR4ucmMmZaC-R_7Ttg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: common: Handle invalid index error
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 11:30, Taniya Das <quic_tdas@quicinc.com> wrote:
>
> Introduce start_index to handle invalid index error
> seen when there are two clock descriptors assigned
> to the same clock controller.

Please provide details of the exact case that you are trying to solve
(this might go to the cover letter). I think the commit message is
slightly misleading here. Are you trying to add error messages or to
prevent them from showing up?

I'm asking because error messages do not seem to correspond to patch
2. You add start_index to make the kernel warn for the clock indices
less than LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC = 4, while quoted
messages show indices 5,6,7.

Nit: please don't overwrap the commit message, the recommended line
width is about 72-77 chars.

>
> [ 3.600604] qcom_cc_clk_hw_get: invalid index 5
> [ 3.625251] qcom_cc_clk_hw_get: invalid index 6
> [ 3.648190] qcom_cc_clk_hw_get: invalid index 7

>
> Fixes: 120c15528390 ("clk: qcom: Migrate to clk_hw based registration and OF APIs")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/common.c | 12 ++++++++----
>  drivers/clk/qcom/common.h |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..0e80535b61f2 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -21,6 +21,7 @@ struct qcom_cc {
>         struct qcom_reset_controller reset;
>         struct clk_regmap **rclks;
>         size_t num_rclks;
> +       u32 rclks_start_index;
>  };
>
>  const
> @@ -226,12 +227,13 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>         struct qcom_cc *cc = data;
>         unsigned int idx = clkspec->args[0];
>
> -       if (idx >= cc->num_rclks) {
> +       if (idx >= cc->rclks_start_index && idx < cc->num_rclks)
> +               return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> +       else if (idx < cc->rclks_start_index && idx >= cc->num_rclks)
>                 pr_err("%s: invalid index %u\n", __func__, idx);
> -               return ERR_PTR(-EINVAL);
> -       }
>
> -       return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> +       return ERR_PTR(-EINVAL);
> +
>  }
>
>  int qcom_cc_really_probe(struct platform_device *pdev,
> @@ -281,6 +283,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>
>         cc->rclks = rclks;
>         cc->num_rclks = num_clks;
> +       if (desc->start_index)
> +               cc->rclks_start_index = desc->start_index;
>
>         qcom_cc_drop_protected(dev, cc);
>
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..924f36af55b3 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -23,6 +23,7 @@ struct qcom_cc_desc {
>         const struct regmap_config *config;
>         struct clk_regmap **clks;
>         size_t num_clks;
> +       u32 start_index;
>         const struct qcom_reset_map *resets;
>         size_t num_resets;
>         struct gdsc **gdscs;
> --
> 2.17.1
>


--
With best wishes



Dmitry
