Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33B643773
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiLEVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiLEVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:53:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E647DF92
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:52:50 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so14941758lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kuK9hVAK9ivy8KVXRuGDH0nYibTFqY0DHBsRiT7wIRo=;
        b=FM1XULbh1TpfkuGS69VVSTTviriSeM0ZiCDIVa9j0F/bhk8YNgVT924odZ/AjoHTCX
         KEiA/8LhkDp4wHHH7nUfNDKmlAEVsCwzc5SAIkXEmfkiN2pdVyYRLrBk0FAA+Ln54F3z
         nkJHnl9H8k1mphts9vxrsY2fL5yAWQUDgXbKHJu9PqwyVP11BnDOsIAFhXw4osYGa6GG
         z5nISpQMr73TZ3CxdlOeS88EuAQ0OleZ1Llk3I7ZXKlHAm7TNCIxXjC1sK4tnohZhu10
         pxvce0GWhVsj1Q3bTP3dKUbLXJDuXkO1LFlE0xZB44BEjmQdtcR1E9j2LzSGQ0ZsIkt9
         EpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuK9hVAK9ivy8KVXRuGDH0nYibTFqY0DHBsRiT7wIRo=;
        b=W3sJGVyioRZhQOC0lwIhz/O+WaLl3mRHArqWWq+d+95Wj6D9Sn3fcl/ex+6zEsM0su
         HkFs1qr33LXph0aKylj85GhD7Iq/ENoGQBJrTwLKI3gu1y9rVGGq4qDESSpzacYlGicx
         HyQaEywKEeD9DWowIENFbqDPBhLEREQi3azRMiqSXVEDMIhB04VVjpxWE4gf8/lePx39
         VYYwisali50rOT77xuMyc/h8mV7zkZgwfPuZPwYUYycX26rBxpviTaXYMaIB2jh67pKz
         BGeNoIqsLck8FPQImAJd5llXR3M3nj1s/IQyMbynxIpDoXTJEUyz382K+jNp0wGpAoZi
         TWaw==
X-Gm-Message-State: ANoB5pns5D4ajYVTTuJfYulqtQzkOa9/eNISLASfoKWeyiYTZei1F0M7
        rjlgntnUeYa1SL7zGHhvMdiJYA==
X-Google-Smtp-Source: AA0mqf6krTpDWudv1bCJYy/0cg7PO9E7qQS6Zm4FAqE9X3v0jpLqT/nEm1HjHkZmindew1wtlX2vYw==
X-Received: by 2002:a05:6512:3483:b0:4a2:8836:c07d with SMTP id v3-20020a056512348300b004a28836c07dmr27045002lfr.661.1670277168837;
        Mon, 05 Dec 2022 13:52:48 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512348f00b00492b0d23d24sm2247814lfr.247.2022.12.05.13.52.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:52:48 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:52:44 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_08/23=5D_phy=3A_qcom-qmp-ufs?= =?US-ASCII?Q?=3A_Add_HS_G4_mode_support_to_SM8250_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-9-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-9-manivannan.sadhasivam@linaro.org>
Message-ID: <AC700E4A-05D3-4735-8CCE-98F5E1DA8DD6@linaro.org>
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



On 1 December 2022 20:43:13 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>UFS PHY in SM8250 SoC is capable of operating at HS G4 mode=2E Hence, add=
 the
>required register settings using the tables_hs_g4 struct instance=2E This
>also requires a separate qmp_phy_cfg for SM8250 instead of reusing SM8150=
=2E
>
>Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>---
> =2E=2E=2E/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5=2Eh    |  1 +
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec       | 62 ++++++++++++++++++-
> 2 files changed, 62 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5=2Eh b/drivers/p=
hy/qualcomm/phy-qcom-qmp-pcs-ufs-v5=2Eh
>index bcca23493b7e=2E=2E3aa4232f84a6 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5=2Eh
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5=2Eh
>@@ -13,6 +13,7 @@
> #define QPHY_V5_PCS_UFS_PLL_CNTL			0x02c
> #define QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
> #define QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
>+#define QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
> #define QPHY_V5_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
> #define QPHY_V5_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
> #define QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 269f96a0f752=2E=2Ed5324c4e8513 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -449,6 +449,34 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_h=
s_g4_pcs[] =3D {
> 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
> };
>=20
>+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_tx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
>+};
>+
>+static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_rx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
>+};
>+
> static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
> 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
>@@ -805,6 +833,38 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg =
=3D {
> 	=2Eregs			=3D sm8150_ufsphy_regs_layout,
> };
>=20
>+static const struct qmp_phy_cfg sm8250_ufsphy_cfg =3D {
>+	=2Elanes			=3D 2,
>+
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
>+	=2Etbls_hs_b =3D {
>+		=2Eserdes		=3D sm8150_ufsphy_hs_b_serdes,
>+		=2Eserdes_num	=3D ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
>+	},
>+	=2Etbls_hs_g4 =3D {
>+		=2Etx		=3D sm8250_ufsphy_hs_g4_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
>+		=2Erx		=3D sm8250_ufsphy_hs_g4_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
>+		=2Epcs		=3D sm8150_ufsphy_hs_g4_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
>+	},
>+	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
>+	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
>+	=2Evreg_list		=3D qmp_phy_vreg_l,
>+	=2Enum_vregs		=3D ARRAY_SIZE(qmp_phy_vreg_l),
>+	=2Eregs			=3D sm8150_ufsphy_regs_layout,
>+};
>+
> static const struct qmp_phy_cfg sm8350_ufsphy_cfg =3D {
> 	=2Elanes			=3D 2,
>=20
>@@ -1297,7 +1357,7 @@ static const struct of_device_id qmp_ufs_of_match_t=
able[] =3D {
> 		=2Edata =3D &sm8150_ufsphy_cfg,
> 	}, {
> 		=2Ecompatible =3D "qcom,sm8250-qmp-ufs-phy",
>-		=2Edata =3D &sm8150_ufsphy_cfg,
>+		=2Edata =3D &sm8250_ufsphy_cfg,
> 	}, {
> 		=2Ecompatible =3D "qcom,sm8350-qmp-ufs-phy",
> 		=2Edata =3D &sm8350_ufsphy_cfg,

--=20
With best wishes
Dmitry
