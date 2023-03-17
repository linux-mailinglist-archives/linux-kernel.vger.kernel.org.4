Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306A6BF0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCQSad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:30:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874E4A1F8;
        Fri, 17 Mar 2023 11:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D016BB826AE;
        Fri, 17 Mar 2023 18:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5030CC433D2;
        Fri, 17 Mar 2023 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679077827;
        bh=B7OSJyjdwKWY48GIx7sDwmRKjhiHNgvWng4QzsAwV84=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nwwi4JG5I1IYOhStnJN394y1Zn5VO4TEtmLeapCjCzjIDJvkNtSbmazFBMWnaJQFi
         RnDwc4K44CU+GCouF7bW7H27yje0alaQazaVyIvyHMPIbZPgW3xJUD7Ivg9puP8hQY
         CvK2gIm+YaoXVhN3b5uJaZTLRx32qBtW7TJv4fKwBG3dHF86Jry5cPKiXvREUBXiFl
         IsWfW2tddyFQ5EK7sef3PzA83HE6riToguObK9pGiz6scyVpyUT91TZHhdg7pN0FWV
         L8D2SNDM3dcy4Z8WJwqTg/TGGmfPXY2wUbThz6vvYh102VxDqwEuU+1mhHD/ga285T
         FmX+UsPsStZSg==
Message-ID: <51362ea7a2e0571ccc5154939030d37b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230317141622.1926573-3-quic_mohs@quicinc.com>
References: <20230317141622.1926573-1-quic_mohs@quicinc.com> <20230317141622.1926573-3-quic_mohs@quicinc.com>
Subject: Re: [PATCH v9 2/4] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_visr@quicinc.com, robh+dt@kernel.org,
        swboyd@chromium.org
Date:   Fri, 17 Mar 2023 11:30:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mohammad Rafi Shaik (2023-03-17 07:16:20)
> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>=20
> The qdsp6ss memory region is being shared by ADSP remoteproc device and
> lpasscc clock device, hence causing memory conflict.
> As the qdsp6ss clocks are being enabled in remoteproc driver, skip qdsp6ss
> clock registration if "qcom,adsp-pil-mode" is enabled.
>=20
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC=
7280")
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/clk/qcom/lpasscc-sc7280.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc=
-sc7280.c
> index 5c1e17bd0d76..85dd5b9d64f0 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -118,12 +118,14 @@ static int lpass_cc_sc7280_probe(struct platform_de=
vice *pdev)
>                 goto destroy_pm_clk;
>         }
> =20
> -       lpass_regmap_config.name =3D "qdsp6ss";
> -       desc =3D &lpass_qdsp6ss_sc7280_desc;
> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode=
")) {
> +               lpass_regmap_config.name =3D "qdsp6ss";
> +               desc =3D &lpass_qdsp6ss_sc7280_desc;
> =20
> -       ret =3D qcom_cc_probe_by_index(pdev, 0, desc);
> -       if (ret)
> -               goto destroy_pm_clk;
> +               ret =3D qcom_cc_probe_by_index(pdev, 0, desc);
> +               if (ret)
> +                       goto destroy_pm_clk;
> +       }

I noticed that we don't set any max_register on the regmap_config. Can
you also do that in a patch before this patch? I think without that set
you can oops the kernel by reading the debugfs file for the regmap.

> =20
>         lpass_regmap_config.name =3D "top_cc";
>         desc =3D &lpass_cc_top_sc7280_desc;
