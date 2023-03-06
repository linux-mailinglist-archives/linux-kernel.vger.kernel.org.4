Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98F6AB447
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCFBVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFBVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:21:34 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D12C64D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 17:21:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k23so6629880ybk.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 17:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t4EaRQ3PQLnaSbIzJ1xDrG/yiuAekyCN/l27BB6BVow=;
        b=hng/kQMZutgEdyE/gzZW30gqgQ7LhVkUP++nEdIxm37bN7/TPqJpom5c9XZhaF3KC3
         C65H1wvNutb3l5fwFHyYHsqQAf+OoAgW8AAmWiweaxAbQWCCDuLArB73Wtifyx7rIi0X
         GtV6s26Fvb2bfmz2QF9XXBCnfCA+TXvz8+/5yLs2b1gJGCgRvzZS9zrdLRwNZwxo9EGB
         J4NZ1Y/lzgYfkpoQ1SZabVD3GOCw0vIfOZfN8lUwwKW0e77Xcn13T6TPNDscFNd2xWWA
         BiFSyTmzY/GahaEP2InsRI+5MWzJ1B3eBOC/CdeuydrgLVpbtgOa8YkOF/pFrY+5btI/
         2mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4EaRQ3PQLnaSbIzJ1xDrG/yiuAekyCN/l27BB6BVow=;
        b=4o8EyvmTVaMPRc3uQ0bEARxqXWdj7Fg281aCg2RdI+4xxBBFCaD90hESIrRWTqutAu
         zefD/6eB/cIy4tV1KccYASPq2faugNsdAoqyBnlFxhpctMd4DIAOb7KiC24Zy0oCyWxx
         brTBdta9k3qV9/kIDx5NrUp4hKUyESm1hmVuqdc+2TS0IaqI/xUWpQ3XSH/5bHve8xDP
         6htLMG/ZHtvmBzAORwmvuy5KNFkDkdWb4lcTP54Z7NxOSPzIP6VK8C+U0w+nRc3YjJjc
         Q7ucCwmDh6at1TUYdkgLHEl3YvAtSaxuTfPqGc2/hQz4Z0gaMt1GnSgLamXeN38GS46o
         G7QA==
X-Gm-Message-State: AO0yUKVQC9kdrQVyaViG7DkZLdsw9kn1rQz+mjLj46qEl+pfJKRc+wjk
        ySr1gnFURliTDtlvKzSKTHrdZQjr37ZK9fD4gXi3K+XE0dWQLwO9C1M=
X-Google-Smtp-Source: AK7set/GU8d4vjOxKd9fbYvSIG9uMb8Ul4SqQMbcOJrl45wmlirEe13RLR166rNZVHUvwShRO6tBgScmojzDuTIO1CU=
X-Received: by 2002:a25:9b48:0:b0:a8a:a652:2a69 with SMTP id
 u8-20020a259b48000000b00a8aa6522a69mr4075875ybo.10.1678065690998; Sun, 05 Mar
 2023 17:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org> <20230303-topic-rpmcc_sleep-v1-3-d9cfaf9b27a7@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v1-3-d9cfaf9b27a7@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Mar 2023 03:21:24 +0200
Message-ID: <CAA8EJpp6cxY5+L28qsTeXCmA31e4dv21u1Tz9SquAugaV+EqfQ@mail.gmail.com>
Subject: Re: [PATCH RFT 03/20] clk: qcom: smd-rpm: Add support for keepalive votes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2023 at 15:27, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Some bus clock should always have a minimum (19.2 MHz) vote cast on
> them, otherwise the platform will fall apart, hang and reboot.
>
> Add support for specifying which clocks should be kept alive and
> always keep a vote on XO_A to make sure the clock tree doesn't
> collapse. This removes the need to keep a maximum vote that was
> previously guaranteed by clk_smd_rpm_handoff.
>
> This commit is a combination of existing (not-exactly-upstream) work
> by Taniya Das, Shawn Guo and myself.
>
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index cce7daa97c1e..8e017c575361 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -178,6 +179,8 @@ struct clk_smd_rpm_req {
>  struct rpm_smd_clk_desc {
>         struct clk_smd_rpm **clks;
>         size_t num_clks;
> +       struct clk_hw **keepalive_clks;
> +       size_t num_keepalive_clks;
>  };
>
>  static DEFINE_MUTEX(rpm_smd_clk_lock);
> @@ -1278,6 +1281,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>         struct qcom_smd_rpm *rpm;
>         struct clk_smd_rpm **rpm_smd_clks;
>         const struct rpm_smd_clk_desc *desc;
> +       struct clk_hw **keepalive_clks;
>
>         rpm = dev_get_drvdata(pdev->dev.parent);
>         if (!rpm) {
> @@ -1291,6 +1295,7 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>
>         rpm_smd_clks = desc->clks;
>         num_clks = desc->num_clks;
> +       keepalive_clks = desc->keepalive_clks;
>
>         for (i = 0; i < num_clks; i++) {
>                 if (!rpm_smd_clks[i])
> @@ -1321,6 +1326,24 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err;
>
> +       /* Leave a permanent active vote on clocks that require it. */
> +       for (i = 0; i < desc->num_keepalive_clks; i++) {
> +               if (WARN_ON(!keepalive_clks[i]))
> +                       continue;
> +
> +               ret = clk_prepare_enable(keepalive_clks[i]->clk);
> +               if (ret)
> +                       return ret;

Would it be better to use CLK_IS_CRITICAL instead? Using the existing
API has a bonus that it is more visible compared to the ad-hoc
solutions.

> +
> +               ret = clk_set_rate(keepalive_clks[i]->clk, 19200000);

Don't we also need to provide a determine_rate() that will not allow
one to set clock frequency below 19.2 MHz?

> +               if (ret)
> +                       return ret;
> +       }
> +
> +       /* Keep an active vote on CXO in case no other driver votes for it. */
> +       if (rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC])
> +               return clk_prepare_enable(rpm_smd_clks[RPM_SMD_XO_A_CLK_SRC]->hw.clk);
> +
>         return 0;
>  err:
>         dev_err(&pdev->dev, "Error registering SMD clock driver (%d)\n", ret);


I have mixed feelings towards this patch (and the rest of the
patchset). It looks to me like we are trying to patch an issue of the
interconnect drivers (or in kernel configuration).


--
With best wishes
Dmitry
