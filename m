Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81A6C385F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCURfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCURfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:35:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B88532AA;
        Tue, 21 Mar 2023 10:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57595B81908;
        Tue, 21 Mar 2023 17:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B9EC4339C;
        Tue, 21 Mar 2023 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679420071;
        bh=kwmBUU9WFc//wAOTsHeeQNScNVfG/4HR6pbYmzcyOf0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KCnyTme5s6Xgat1J1YBKgJttYPdWPVtocYSgMStUwLDt3IsVFr3hjedcLwgdyi50e
         +MfhbbuImrDLhntQLfG9CMIriizUTj0NLG1H6/6Ue1GnfFt1QuJxrYggyXl6iSA6Bz
         y5gVYUtq9V5bKVgYjGZGDfkelAzksK6yEul047QY3MSjVs2gKv2ymylQAyJoeTBcYW
         2ql0vN0aeKfU+tCan8RbV1Z+vfRmd1zMPVbB8HP4eVDTSGNyTfMMrA75uY3M9b6DgK
         2EQk0PXVhsroDpG/YC89kkh364EK2+PDdbeVsyX0SsaAQcv//9CqpmDgYSjv4Z4Zyc
         FWxT1TEJNz4kg==
Message-ID: <c087fa09f92838b4e1a2a3e7139b7106.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230320204042.980708-3-mmyangfl@gmail.com>
References: <20230320204042.980708-1-mmyangfl@gmail.com> <20230320204042.980708-3-mmyangfl@gmail.com>
Subject: Re: [PATCH v5 2/5] clk: hisilicon: Extract common functions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>
Date:   Tue, 21 Mar 2023 10:34:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-20 13:40:35)
> To be reused with other Hi3798 series SoCs.
>=20
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

Please squash this patch in

---8<---
diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg=
-hi3798.c
index 3a8d70b7c8ec..0d6886bca3ba 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -203,8 +203,9 @@ struct hi3798_clks {
 	int complex_clks_nums;
 };
=20
-static struct hisi_clock_data *hi3798_clk_register(
-		struct platform_device *pdev, const struct hi3798_clks *clks)
+static struct hisi_clock_data *
+hi3798_clk_register(struct platform_device *pdev,
+		    const struct hi3798_clks *clks)
 {
 	struct hisi_clock_data *clk_data;
 	int ret;
@@ -257,8 +258,8 @@ static struct hisi_clock_data *hi3798_clk_register(
 	return ERR_PTR(ret);
 }
=20
-static void hi3798_clk_unregister(
-		struct platform_device *pdev, const struct hi3798_clks *clks)
+static void hi3798_clk_unregister(struct platform_device *pdev,
+				  const struct hi3798_clks *clks)
 {
 	struct hisi_crg_dev *crg =3D platform_get_drvdata(pdev);
=20
@@ -276,8 +277,9 @@ static void hi3798_clk_unregister(
=20
 #define HI3798_SYSCTRL_NR_CLKS 16
=20
-static struct hisi_clock_data *hi3798_sysctrl_clk_register(
-		struct platform_device *pdev, const struct hi3798_clks *clks)
+static struct hisi_clock_data *
+hi3798_sysctrl_clk_register(struct platform_device *pdev,
+			    const struct hi3798_clks *clks)
 {
 	struct hisi_clock_data *clk_data;
 	int ret;
@@ -302,8 +304,8 @@ static struct hisi_clock_data *hi3798_sysctrl_clk_regis=
ter(
 	return ERR_PTR(ret);
 }
=20
-static void hi3798_sysctrl_clk_unregister(
-		struct platform_device *pdev, const struct hi3798_clks *clks)
+static void hi3798_sysctrl_clk_unregister(struct platform_device *pdev,
+					  const struct hi3798_clks *clks)
 {
 	struct hisi_crg_dev *crg =3D platform_get_drvdata(pdev);
=20
@@ -623,8 +625,8 @@ static const struct hi3798_clks hi3798cv200_crg_clks =
=3D {
 	.phase_clks_nums =3D ARRAY_SIZE(hi3798mv100_phase_clks),
 };
=20
-static struct hisi_clock_data *hi3798cv200_clk_register(
-				struct platform_device *pdev)
+static struct hisi_clock_data *
+hi3798cv200_clk_register(struct platform_device *pdev)
 {
 	return hi3798_clk_register(pdev, &hi3798cv200_crg_clks);
 }
@@ -653,8 +655,8 @@ static const struct hi3798_clks hi3798cv200_sysctrl_clk=
s =3D {
 	.gate_clks_nums =3D ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
=20
-static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
-					struct platform_device *pdev)
+static struct hisi_clock_data *
+hi3798cv200_sysctrl_clk_register(struct platform_device *pdev)
 {
 	return hi3798_sysctrl_clk_register(pdev, &hi3798cv200_sysctrl_clks);
 }



> diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/c=
rg-hi3798.c
> index 7e9507de2..2f8f14e73 100644
> --- a/drivers/clk/hisilicon/crg-hi3798.c
> +++ b/drivers/clk/hisilicon/crg-hi3798.c
> @@ -59,6 +59,119 @@ static const struct hisi_fixed_rate_clock hi3798_fixe=
d_rate_clks[] =3D {
>         { HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
>  };
> =20
> +struct hi3798_clks {
> +       const struct hisi_gate_clock *gate_clks;
> +       int gate_clks_nums;
> +       const struct hisi_mux_clock *mux_clks;
> +       int mux_clks_nums;
> +       const struct hisi_phase_clock *phase_clks;
> +       int phase_clks_nums;
> +};
> +
> +static struct hisi_clock_data *hi3798_clk_register(
> +               struct platform_device *pdev, const struct hi3798_clks *c=
lks)
> +{
> +       struct hisi_clock_data *clk_data;
> +       int ret;
> +
> +       clk_data =3D hisi_clk_alloc(pdev, HI3798_CRG_NR_CLKS);
> +       if (!clk_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* hisi_phase_clock is resource managed */
> +       ret =3D hisi_clk_register_phase(&pdev->dev, clks->phase_clks,
> +                                     clks->phase_clks_nums, clk_data);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       ret =3D hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
> +                                          ARRAY_SIZE(hi3798_fixed_rate_c=
lks),
> +                                          clk_data);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       ret =3D hisi_clk_register_mux(clks->mux_clks, clks->mux_clks_nums=
, clk_data);
> +       if (ret)
> +               goto unregister_fixed_rate;
> +
> +       ret =3D hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_n=
ums, clk_data);

Please make a follow-up patch that passes the pdev->dev pointer to these
registration functions so they can use devm APIs.

> +       if (ret)
> +               goto unregister_mux;
> +
> +       ret =3D of_clk_add_provider(pdev->dev.of_node,

Please make a follow-up patch that migrates this to
devm_of_clk_add_hw_provider.

> +                       of_clk_src_onecell_get, &clk_data->clk_data);
> +       if (ret)
> +               goto unregister_gate;
> +
