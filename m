Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA16ED9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjDYBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDYBWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F05273;
        Mon, 24 Apr 2023 18:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083ED62AAB;
        Tue, 25 Apr 2023 01:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F69FC433D2;
        Tue, 25 Apr 2023 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682385759;
        bh=NXv2pfWTZu2vC/ltC9EBZjzxRHTO+30j39cQI4dlOcI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QJz5cVl4PhMTJze+KDFWmNZN+FXdOg3aVsZ/KR+Y+3QjbyY2nS/TfywqnRsgKaBTF
         nJOqM35LATYQeGQr6PFCS97a2xp7TeBqn8cgkHFXYJSlODrxGYHdKzrCrhv7upaRdI
         fboWksg5SsnAYQjZRPz19/6iyzcpJf4r+wR/b/pu0id/R/6Ez82JngI29Mc5HdjFmv
         O8Bmf3dc/gJ5pNaUv8rJ+LoLGgboVQ960jpOhZ5gKQ/rpJTNAGAjFwVf4rgcqzf8Vl
         g6etBREYdQfQnQQPaBlWU+ihDWuorrak90eRAdlGNJyOQwFwiru1icSFqgY4W4j5oK
         Atl76ju7cy1Xw==
Message-ID: <2b56630aa93c1c1e9cd45a745046a12e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1c6fe00696f808e889ce72571b8ed8e7fa20f661.1682092324.git.quic_varada@quicinc.com>
References: <cover.1682092324.git.quic_varada@quicinc.com> <1c6fe00696f808e889ce72571b8ed8e7fa20f661.1682092324.git.quic_varada@quicinc.com>
Subject: Re: [PATCH v9 4/8] clk: qcom: gcc-ipq9574: Add USB related clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kishon@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, mturquette@baylibre.com,
        quic_wcheng@quicinc.com, robh+dt@kernel.org, vkoul@kernel.org
Date:   Mon, 24 Apr 2023 18:22:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Varadarajan Narayanan (2023-04-21 08:54:46)
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> index a4cf750..8d7f543 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -2025,6 +2025,41 @@ static struct clk_regmap_mux usb0_pipe_clk_src =3D=
 {
>         },
>  };
> =20
> +static struct clk_branch gcc_usb0_pipe_clk =3D {
> +       .halt_reg =3D 0x2c054,
> +       .halt_check =3D BRANCH_HALT_DELAY,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2c054,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const

> +                       .name =3D "gcc_usb0_pipe_clk",
> +                       .parent_hws =3D (const struct clk_hw *[]) {
> +                               &usb0_pipe_clk_src.clkr.hw
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_usb0_sleep_clk =3D {
> +       .halt_reg =3D 0x2c058,
> +       .clkr =3D {
> +               .enable_reg =3D 0x2c058,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const

> +                       .name =3D "gcc_usb0_sleep_clk",
> +                       .parent_hws =3D (const struct clk_hw *[]) {
> +                               &gcc_sleep_clk_src.clkr.hw
> +                       },
> +                       .num_parents =3D 1,
> +                       .flags =3D CLK_SET_RATE_PARENT,
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
>  static const struct freq_tbl ftbl_sdcc_apps_clk_src[] =3D {
>         F(144000, P_XO, 16, 12, 125),
>         F(400000, P_XO, 12, 1, 5),
