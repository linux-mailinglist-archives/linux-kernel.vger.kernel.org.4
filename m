Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A564BF51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiLMWY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMWYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:24:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5AC28;
        Tue, 13 Dec 2022 14:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3451E615B9;
        Tue, 13 Dec 2022 22:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B112C433D2;
        Tue, 13 Dec 2022 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970261;
        bh=8KDQaVBEYbG4DZdbHVeTVitMLcZQSUsPaXO6w4+Dp4s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ci3hzPgReGmg2iGCZgyMvJTXpbfQvPs9pvHUgu+dkZHx3AQq/Iy25IUX9PgkGlmZ5
         Wle730BtgUeflp+YObvw32o3HCZUu+miBCvt9ZD78brAmN/PvEmA3XhFzqzPBTyzif
         WhWF+CmMqOgFX3g+t3T0Uuo3I+dNGO1jJkt0Qe8RzcBNmEnS8M1ajFlODuYVh4JPJO
         Ls7ynxnSqxdj1vO+hNKcHsb0WDZoVRtK0qJHfSQlW3exuUCWAe6EwAiXSU+qUuxQU1
         r6X1m25pfVPjnmgp6bZI9CB8Q/w2DsAjN5D99src0AdNenpJH1Q6r66/jg71nGINMG
         gl79zOUBbn+Fw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221213104333.27548-1-konrad.dybcio@linaro.org>
References: <20221213104333.27548-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH] clk: qcom: dispcc-sm6115: Shrink single-parent definitions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org
Date:   Tue, 13 Dec 2022 14:24:19 -0800
User-Agent: alot/0.10
Message-Id: <20221213222421.7B112C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-12-13 02:43:33)
> @@ -284,12 +268,13 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src =
=3D {
>         .cmd_rcgr =3D 0x20a4,
>         .mnd_width =3D 0,
>         .hid_width =3D 5,
> -       .parent_map =3D disp_cc_parent_map_1,
>         .freq_tbl =3D ftbl_disp_cc_mdss_esc0_clk_src,
>         .clkr.hw.init =3D &(struct clk_init_data){
>                 .name =3D "disp_cc_mdss_vsync_clk_src",
> -               .parent_data =3D disp_cc_parent_data_1,
> -               .num_parents =3D ARRAY_SIZE(disp_cc_parent_data_1),
> +               .parent_data =3D &(const struct clk_parent_data){
> +                       .index =3D DT_BI_TCXO,
> +               },
> +               .num_parents =3D 1,
>                 .flags =3D CLK_SET_RATE_PARENT,
>                 .ops =3D &clk_rcg2_shared_ops,

Is clk_rcg2_shared_ops and clk_rcg2_ops prepared for a NULL
'parent_map' pointer? _freq_tbl_determine_rate() is never called?
