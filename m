Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AC730C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjFOAsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFOAsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FF1BC9;
        Wed, 14 Jun 2023 17:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9CF61F4F;
        Thu, 15 Jun 2023 00:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82DC433C0;
        Thu, 15 Jun 2023 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686790088;
        bh=ljTHxAt2/H9b6qwb5RfqtZnhtJZN2CPWpT6t2q4z+44=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L10bqQ2XIuTNsKR/DVIaAOmKRB34mM779Gb5ukrZ/YtRbXXOzWwwEyxvAnbDVf8Cl
         V5jHQGhiqRCUw3qNbJa1QCoU4e8Ks050IjZYaywOEXfqdzFBFWRa9tDzsGr4Cayzd1
         W+TszLJXjmiRJUIFmowq9MNMxuN2anui4gnkHZ8vqtdWB6U4E0Yl3hNn1+q5ciqk/z
         +AiLHvblE9HxILjr+10y93R2M8853VZziuQt2FLcTDnPy0ALahEabJy0AAVMLIRLJm
         hGrfjUe776bD17fxL9EuQyQV9e0+BKSkT/+rbFPDK54riiT6YYabTL3sFIBLE1PB+5
         RsHk4IWAogE2Q==
Message-ID: <e2afd4bde3e85db358d50553a60a744f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230526-topic-smd_icc-v6-18-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org> <20230526-topic-smd_icc-v6-18-263283111e66@linaro.org>
Subject: Re: [PATCH v6 18/22] clk: qcom: smd-rpm: Separate out interconnect bus clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Jun 2023 17:48:06 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-06-14 11:04:37)
> The interconnect bus clocks are now handled within the ICC framework.
> They still however need to get a kickstart *before* we call
> clk_smd_rpm_enable_scaling(), or RPM will assume that they should all
> be running at 0 kHz and the system will inevitably die.
>=20
> Separate them out to ensure such a kickstart can still take place.
>=20
> As a happy accident, the file got smaller:
>=20
> Total: Before=3D41951, After=3D41555, chg -0.94%
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 278 +++++++++++++++++------------------=
------
>  1 file changed, 115 insertions(+), 163 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> index 6e7f0438e8b8..0d1d97659d59 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -498,13 +506,69 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk1, 11, 19200000=
);
>  DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk2, 12, 19200000);
>  DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
> =20
> +static struct clk_smd_rpm *bimc_pcnoc_icc_clks[] =3D {

Can these be const arrays?

> +       &clk_smd_rpm_bimc_clk,
> +       &clk_smd_rpm_bus_0_pcnoc_clk,
> +};
> +
[...]
> @@ -1332,6 +1275,15 @@ static int rpm_smd_clk_probe(struct platform_devic=
e *pdev)
>                         goto err;
>         }
> =20
> +       for (i =3D 0; i < desc->num_icc_clks; i++) {
> +               if (!desc->icc_clks[i])
> +                       continue;
> +
> +               ret =3D clk_smd_rpm_handoff(desc->icc_clks[i]);

This API can probably take a const struct clk_smd_rpm pointer as well.
