Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB567BEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbjAYViY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbjAYViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9372ED42;
        Wed, 25 Jan 2023 13:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2778615AD;
        Wed, 25 Jan 2023 21:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB93C433D2;
        Wed, 25 Jan 2023 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674682696;
        bh=bmq9nscR0EgSU6fvc32oRHpBhN1RRimmYW62O6DIiZE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qe+JY92dmT+G+YKxGHzlrcnkItmlqhnSMBDUvzjxW06cgIUVYEGnhYXFGw7/AoGvR
         TwCcuYuiobaRRtXKBT8/rq2by9cOLucsgqX7myHZ8TQuX7fbykQvTNSjpivrE+0DY4
         cubxeHMZI/n2DlTvQ6GSP12tK8C6Rh3OGDFq5ahugpaiyNfknHWCXZj8+ZIktbZ/Tn
         pWBluZI+C0wwUDTik2qP42U/QY2iyRqDOVQ4CZCd3i27aTraNI5z8F/6DEaq/m0etz
         NoX6PJ7NQWOts1il55m2JiMF3zq9x0Wy2LOzYCo4ouNixzdhpx/+DO2YA6mRYr22J1
         lmbqL1N9+R2TQ==
Message-ID: <7055af43f4a8894ac34e53c5847fb3de.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230118132254.2356209-8-dmitry.baryshkov@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org> <20230118132254.2356209-8-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 7/7] clk: qcom: add the driver for the MSM8996 APCS clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 Jan 2023 13:38:14 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-01-18 05:22:54)
> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8=
996.c
> new file mode 100644
> index 000000000000..7e46ea8ed444
> --- /dev/null
> +++ b/drivers/clk/qcom/apcs-msm8996.c
> @@ -0,0 +1,76 @@
[...]
> +
> +static int qcom_apcs_msm8996_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device *parent =3D dev->parent;
> +       struct regmap *regmap;
> +       struct clk_hw *hw;
> +       unsigned int val;
> +       int ret =3D -ENODEV;
> +
> +       regmap =3D dev_get_regmap(parent, NULL);
> +       if (!regmap) {
> +               dev_err(dev, "failed to get regmap: %d\n", ret);
> +               return ret;
> +       }
> +
> +       regmap_read(regmap, APCS_AUX_OFFSET, &val);
> +       regmap_update_bits(regmap, APCS_AUX_OFFSET, APCS_AUX_DIV_MASK,
> +                          FIELD_PREP(APCS_AUX_DIV_MASK, APCS_AUX_DIV_2));
> +
> +       /* Hardware mandated delay */

Delay for what? Setting the divider? What if the register value didn't
change at all? Can you skip the delay in that case?

> +       udelay(5);
> +
> +       /*
> +        * Register the clock as fixed rate instead of being a child of g=
pll0
> +        * to let the driver register probe as early as possible.

The function doesn't block or return EPROBE_DEFER if the clk is orphaned
when registered. Why is this necessary? Are you getting defered by the
fw_devlink logic thinking it needs to defer probe of this driver until
gpll0 provider probes? We should fix fw_devlink to not do that. Maybe if
the node is a clk provider (#clock-cells exists) then we don't wait for
clocks property to be provided, because the clk core already handles
that itself.

> +        */
> +       hw =3D devm_clk_hw_register_fixed_rate(dev, "sys_apcs_aux", NULL,=
 0, 300000000);
