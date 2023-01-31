Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A468385E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjAaVJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjAaVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:09:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200953E70;
        Tue, 31 Jan 2023 13:09:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 945CCB81EC1;
        Tue, 31 Jan 2023 21:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C923C433D2;
        Tue, 31 Jan 2023 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675199388;
        bh=TeAj1pk7O6E1JVedktsQhJ3Ys9GXO7ESMgqosCMUVnE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G6mcf/DDL6vf7xFiIYlppye1Ul+9zLH0DIJhGYcWnuEtEvsnQjlgLngSQB1ltPIYn
         qTyBFZmcjbQaejYEX4bbVbBtX/SyZhV2l7uwk9l1wmkfMFtt6lTKZ4jS7cDoYr0nhd
         HzA5wwqF7GtX7OyePNk8aW92XN/jPLYjIqxlY+XolHTXAha8fwcOFRGnLENMECYe9L
         lsxOC3ggK9Cd8u5kNGT8oMWbRIgfRxqV9ipItTGjcfS9xzZTj3FNd5HsLZjlq9kue1
         7NbxyyTM5sxJoXizC7FJWQIrlaxwY84v9Ksq7trnthEHDSqew2xB5dnzH9VGp/BmB5
         8dUefDgZJoMWw==
Message-ID: <84f68577f5629e6ef6d6b14357a79f84.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230130114702.20606-6-quic_kathirav@quicinc.com>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com> <20230130114702.20606-6-quic_kathirav@quicinc.com>
Subject: Re: [PATCH V2 5/9] clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, mturquette@baylibre.com,
        nfraprado@collabora.com, quic_gurus@quicinc.com,
        robh+dt@kernel.org, robimarko@gmail.com, shawnguo@kernel.org,
        will@kernel.org
Date:   Tue, 31 Jan 2023 13:09:46 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-01-30 03:46:58)
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq533=
2.c
> new file mode 100644
> index 000000000000..a8ce618bb81b
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -0,0 +1,3954 @@
[...]
> +
> +static const struct clk_parent_data gcc_parent_data_xo =3D { .index =3D =
DT_XO };
> +
> +static struct clk_alpha_pll gpll0_main =3D {
[...]
> +};
> +
> +static const struct parent_map gcc_parent_map_3[] =3D {
> +       { P_XO, 0 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_3[] =3D {

Isn't this the same as gcc_parent_data_xo?

> +       { .index =3D DT_XO },
> +};
> +
> +static const struct parent_map gcc_parent_map_4[] =3D {
> +       { P_XO, 0 },
> +       { P_GPLL0_OUT_MAIN, 1 },
> +       { P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC, 4 },
> +       { P_SLEEP_CLK, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_4[] =3D {
> +       { .index =3D DT_XO },
> +       { .hw =3D &gpll0.clkr.hw },
> +       { .hw =3D &gpll0_div2.hw },
[..]
> +
> +static int gcc_ipq5332_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap =3D qcom_cc_map(pdev, &gcc_ipq5332_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       return qcom_cc_really_probe(pdev, &gcc_ipq5332_desc, regmap);

If you don't need to write anything in probe you can simply use
qcom_cc_probe().
