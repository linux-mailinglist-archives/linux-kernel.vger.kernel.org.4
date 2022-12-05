Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4A64375A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiLEVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLEVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:49:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C3E10568
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:48:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so16341800lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7uT5TtJWGIMMU4mkgNIM3r+VjvkyvxyOjeUB42jY+NA=;
        b=bLp2CcQFcFlJhfG8awwHKMk75JUqv9Fut0JCVWVm10pVYEJ7rb/P96sAjScY7Dnj1x
         8u+bnB6VpUvj3E8kn9FQFJjS5JvkXMJQ4flbH0FXu8SDCZYw+k5hHtN0sxK7sO9Rn8SA
         cRnsycibN815WjBnuH/TlUnoqVWqQWyDO+rLS3PI9pDwJNH5RnrL+dzY4ra5JVOzKe3H
         kms6Y2ZldpnSXXGeDKKqcuJWtdCQHmXx7s60Hdu/l/F8gzqC0Mai4zQCtu7eHLg8c2/q
         56uhK+c4GtQjtWeAw83FgD5/l8iQPrWx3yM4cH7W4IniIDWMjDL8UP6Lm+73ErF8y0nq
         AkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uT5TtJWGIMMU4mkgNIM3r+VjvkyvxyOjeUB42jY+NA=;
        b=ZSpV+k7L1VlKkyJJfvezX4Jn9Z1VsIXeBXHhaEYReHD5lo77P3AMFWZrCpyIg00Hvz
         kKlq5sJq2f9V4Zqwqpkc0WVEMnaYOosE5SEs7XtWMaLVrxKiCRMllHbQefuczHAjFIyM
         ALd2PiQyazXexfytKwDhS7Dhavjtl7Xn153CzoJ3U3uj1yIv363NtK6991QLWrlk07VD
         eZ0uqObL5dEv53Omfk9IGzlxA16/crEvi+nc5UQZfW8wU1zN72tn1JmIPQD9FFUmeNcm
         9JlTPtrJrX6Y2bX8Xae9gHVJFPFFKUkW4ymUGrUP0BJXNTzYEW0GtERLbaOahF8wKVPy
         5KvA==
X-Gm-Message-State: ANoB5pn3WekGYWQl1+Mj/cRczR/dVk2bsfk1Kh3oQFQC6Rku6tQhtdMZ
        PEl8pkAKnipoakGAGR1mBXhjwQ==
X-Google-Smtp-Source: AA0mqf5VFMe8sF7aylyvi3c4Q+bMMZzx+OVFaAEWkk61F3dcBv5hUb5KC2XHconnbVBA/qNdoWzGqw==
X-Received: by 2002:a19:6717:0:b0:4b4:e13f:6a17 with SMTP id b23-20020a196717000000b004b4e13f6a17mr23928665lfc.372.1670276917832;
        Mon, 05 Dec 2022 13:48:37 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b4bb6286d8sm2252922lfr.84.2022.12.05.13.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:48:37 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:48:33 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_03/23=5D_phy=3A_qcom-qmp-ufs=3A_Move?= =?US-ASCII?Q?_register_settings_to_qmp=5Fphy=5Fcfg=5Ftbls_struct?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-4-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-4-manivannan.sadhasivam@linaro.org>
Message-ID: <C2E22524-75E6-4AAF-B487-63D55F58E046@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 December 2022 20:43:08 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>As done for Qcom PCIe PHY driver, let's move the register settings to the
>common qmp_phy_cfg_tbls struct=2E This helps in adding any additional PHY
>settings needed for functionalities like HS-G4 in the future by adding on=
e
>more instance of the qmp_phy_cfg_tbls=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>


Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 196 ++++++++++++++----------
> 1 file changed, 113 insertions(+), 83 deletions(-)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 35b77cd79e57=2E=2E516027e356f0 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -527,21 +527,26 @@ struct qmp_ufs_offsets {
> 	u16 rx2;
> };
>=20
>+struct qmp_phy_cfg_tbls {
>+	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>+	const struct qmp_phy_init_tbl *serdes;
>+	int serdes_num;
>+	const struct qmp_phy_init_tbl *tx;
>+	int tx_num;
>+	const struct qmp_phy_init_tbl *rx;
>+	int rx_num;
>+	const struct qmp_phy_init_tbl *pcs;
>+	int pcs_num;
>+};
>+
> /* struct qmp_phy_cfg - per-PHY initialization config */
> struct qmp_phy_cfg {
> 	int lanes;
>=20
> 	const struct qmp_ufs_offsets *offsets;
>=20
>-	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>-	const struct qmp_phy_init_tbl *serdes_tbl;
>-	int serdes_tbl_num;
>-	const struct qmp_phy_init_tbl *tx_tbl;
>-	int tx_tbl_num;
>-	const struct qmp_phy_init_tbl *rx_tbl;
>-	int rx_tbl_num;
>-	const struct qmp_phy_init_tbl *pcs_tbl;
>-	int pcs_tbl_num;
>+	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>+	const struct qmp_phy_cfg_tbls tbls;
>=20
> 	/* clock ids to be requested */
> 	const char * const *clk_list;
>@@ -632,12 +637,14 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets=
_v5 =3D {
> static const struct qmp_phy_cfg msm8996_ufsphy_cfg =3D {
> 	=2Elanes			=3D 1,
>=20
>-	=2Eserdes_tbl		=3D msm8996_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_serdes),
>-	=2Etx_tbl			=3D msm8996_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_tx),
>-	=2Erx_tbl			=3D msm8996_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_rx),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D msm8996_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(msm8996_ufsphy_serdes),
>+		=2Etx		=3D msm8996_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(msm8996_ufsphy_tx),
>+		=2Erx		=3D msm8996_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(msm8996_ufsphy_rx),
>+	},
>=20
> 	=2Eclk_list		=3D msm8996_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(msm8996_ufs_phy_clk_l),
>@@ -655,14 +662,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg=
 =3D {
>=20
> 	=2Eoffsets		=3D &qmp_ufs_offsets_v5,
>=20
>-	=2Eserdes_tbl		=3D sm8350_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>-	=2Etx_tbl			=3D sm8350_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>-	=2Erx_tbl			=3D sm8350_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>-	=2Epcs_tbl		=3D sm8350_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sm8350_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>+		=2Etx		=3D sm8350_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>+		=2Erx		=3D sm8350_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>+		=2Epcs		=3D sm8350_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -673,14 +682,16 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg=
 =3D {
> static const struct qmp_phy_cfg sdm845_ufsphy_cfg =3D {
> 	=2Elanes			=3D 2,
>=20
>-	=2Eserdes_tbl		=3D sdm845_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sdm845_ufsphy_serdes),
>-	=2Etx_tbl			=3D sdm845_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sdm845_ufsphy_tx),
>-	=2Erx_tbl			=3D sdm845_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sdm845_ufsphy_rx),
>-	=2Epcs_tbl		=3D sdm845_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sdm845_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sdm845_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sdm845_ufsphy_serdes),
>+		=2Etx		=3D sdm845_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sdm845_ufsphy_tx),
>+		=2Erx		=3D sdm845_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sdm845_ufsphy_rx),
>+		=2Epcs		=3D sdm845_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sdm845_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -693,14 +704,16 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg =
=3D {
> static const struct qmp_phy_cfg sm6115_ufsphy_cfg =3D {
> 	=2Elanes			=3D 1,
>=20
>-	=2Eserdes_tbl		=3D sm6115_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sm6115_ufsphy_serdes),
>-	=2Etx_tbl			=3D sm6115_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sm6115_ufsphy_tx),
>-	=2Erx_tbl			=3D sm6115_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sm6115_ufsphy_rx),
>-	=2Epcs_tbl		=3D sm6115_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sm6115_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sm6115_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm6115_ufsphy_serdes),
>+		=2Etx		=3D sm6115_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm6115_ufsphy_tx),
>+		=2Erx		=3D sm6115_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm6115_ufsphy_rx),
>+		=2Epcs		=3D sm6115_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm6115_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -713,14 +726,16 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg =
=3D {
> static const struct qmp_phy_cfg sm8150_ufsphy_cfg =3D {
> 	=2Elanes			=3D 2,
>=20
>-	=2Eserdes_tbl		=3D sm8150_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sm8150_ufsphy_serdes),
>-	=2Etx_tbl			=3D sm8150_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sm8150_ufsphy_tx),
>-	=2Erx_tbl			=3D sm8150_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sm8150_ufsphy_rx),
>-	=2Epcs_tbl		=3D sm8150_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sm8150_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sm8150_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm8150_ufsphy_serdes),
>+		=2Etx		=3D sm8150_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8150_ufsphy_tx),
>+		=2Erx		=3D sm8150_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8150_ufsphy_rx),
>+		=2Epcs		=3D sm8150_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8150_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -731,14 +746,16 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg =
=3D {
> static const struct qmp_phy_cfg sm8350_ufsphy_cfg =3D {
> 	=2Elanes			=3D 2,
>=20
>-	=2Eserdes_tbl		=3D sm8350_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>-	=2Etx_tbl			=3D sm8350_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>-	=2Erx_tbl			=3D sm8350_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>-	=2Epcs_tbl		=3D sm8350_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sm8350_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>+		=2Etx		=3D sm8350_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>+		=2Erx		=3D sm8350_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>+		=2Epcs		=3D sm8350_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -749,14 +766,16 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg =
=3D {
> static const struct qmp_phy_cfg sm8450_ufsphy_cfg =3D {
> 	=2Elanes			=3D 2,
>=20
>-	=2Eserdes_tbl		=3D sm8350_ufsphy_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>-	=2Etx_tbl			=3D sm8350_ufsphy_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>-	=2Erx_tbl			=3D sm8350_ufsphy_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>-	=2Epcs_tbl		=3D sm8350_ufsphy_pcs,
>-	=2Epcs_tbl_num		=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	=2Etbls =3D {
>+		=2Eserdes		=3D sm8350_ufsphy_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm8350_ufsphy_serdes),
>+		=2Etx		=3D sm8350_ufsphy_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8350_ufsphy_tx),
>+		=2Erx		=3D sm8350_ufsphy_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8350_ufsphy_rx),
>+		=2Epcs		=3D sm8350_ufsphy_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8350_ufsphy_pcs),
>+	},
> 	=2Eclk_list		=3D sm8450_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,
>@@ -790,16 +809,40 @@ static void qmp_ufs_configure(void __iomem *base,
> 	qmp_ufs_configure_lane(base, tbl, num, 0xff);
> }
>=20
>-static int qmp_ufs_serdes_init(struct qmp_ufs *qmp)
>+static void qmp_ufs_serdes_init(struct qmp_ufs *qmp, const struct qmp_ph=
y_cfg_tbls *tbls)
> {
>-	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> 	void __iomem *serdes =3D qmp->serdes;
>-	const struct qmp_phy_init_tbl *serdes_tbl =3D cfg->serdes_tbl;
>-	int serdes_tbl_num =3D cfg->serdes_tbl_num;
>=20
>-	qmp_ufs_configure(serdes, serdes_tbl, serdes_tbl_num);
>+	qmp_ufs_configure(serdes, tbls->serdes, tbls->serdes_num);
>+}
>=20
>-	return 0;
>+static void qmp_ufs_lanes_init(struct qmp_ufs *qmp, const struct qmp_phy=
_cfg_tbls *tbls)
>+{
>+	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
>+	void __iomem *tx =3D qmp->tx;
>+	void __iomem *rx =3D qmp->rx;
>+
>+	qmp_ufs_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
>+	qmp_ufs_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
>+
>+	if (cfg->lanes >=3D 2) {
>+		qmp_ufs_configure_lane(qmp->tx2, tbls->tx, tbls->tx_num, 2);
>+		qmp_ufs_configure_lane(qmp->rx2, tbls->rx, tbls->rx_num, 2);
>+	}
>+}
>+
>+static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_c=
fg_tbls *tbls)
>+{
>+	void __iomem *pcs =3D qmp->pcs;
>+
>+	qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
>+}
>+
>+static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp=
_phy_cfg *cfg)
>+{
>+	qmp_ufs_serdes_init(qmp, &cfg->tbls);
>+	qmp_ufs_lanes_init(qmp, &cfg->tbls);
>+	qmp_ufs_pcs_init(qmp, &cfg->tbls);
> }
>=20
> static int qmp_ufs_com_init(struct qmp_ufs *qmp)
>@@ -886,25 +929,12 @@ static int qmp_ufs_power_on(struct phy *phy)
> {
> 	struct qmp_ufs *qmp =3D phy_get_drvdata(phy);
> 	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
>-	void __iomem *tx =3D qmp->tx;
>-	void __iomem *rx =3D qmp->rx;
> 	void __iomem *pcs =3D qmp->pcs;
> 	void __iomem *status;
> 	unsigned int val;
> 	int ret;
>=20
>-	qmp_ufs_serdes_init(qmp);
>-
>-	/* Tx, Rx, and PCS configurations */
>-	qmp_ufs_configure_lane(tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
>-	qmp_ufs_configure_lane(rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
>-
>-	if (cfg->lanes >=3D 2) {
>-		qmp_ufs_configure_lane(qmp->tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
>-		qmp_ufs_configure_lane(qmp->rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
>-	}
>-
>-	qmp_ufs_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>+	qmp_ufs_init_registers(qmp, cfg);
>=20
> 	ret =3D reset_control_deassert(qmp->ufs_reset);
> 	if (ret)

--=20
With best wishes
Dmitry
