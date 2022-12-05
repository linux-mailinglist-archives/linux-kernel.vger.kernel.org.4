Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A617643770
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiLEVxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiLEVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:53:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BBA17E1D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:52:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d6so20687733lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YWL38Jz9htavTQDVlFdW/bcVhtufVVr4oj0XxVls8ro=;
        b=HFSfF/BkkP0ll1pKwYsrh5YBG9UA/CEy65OcP3uJ9QCDXYc/dMeiPxeGj6qqbmk+2P
         FIr2LpkYpMaWULsmPJy/a+Td3mcrvfJjg3ykB3UKGPm9eWnBDNUhVhxxU3WWLHI5++6Q
         eeL6vIV+OVnfrfTIgndOn8FBXeXnHBz+jc77XYXc0I8gpeSzp6Ir8kQ4JA5f5bL/DOeh
         Ffzqs8BUSYLFppaqxtN+nDu46irpDqHlV/cWIIBAiqxWzscS1aSoYK1b+VUVOU4ANzah
         1K8+jqSiZa3aYg0K2QEJk7fA26E/+yhr0nz21aZ3FhprFCuqdqy/QCwpLJPj2WH+7q1z
         jTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWL38Jz9htavTQDVlFdW/bcVhtufVVr4oj0XxVls8ro=;
        b=mspjdrQlEPCZ2JCBgqlNoWxPy7VEaa4Iqt70lBx9f7m3q9iGdl2AGhUtuc7d+y+lsI
         CLonNDP0ViH8+Ei2s8rK7nnWJ5BsOy0dobFQ+J7vj6VCJ1cBwKCwZYbOYaXROPsCBH7E
         +QZUZzPik+osx5G69yKooqNnSgXRBFL/cqHFxjPDWr6wfMTIZGc0TWM8WE0H+RU5ABw3
         0p7x+nMA7ZQUyovSbZstVfbgiwq+n6EMALLSOTJED8/nUGd86zB77fUbyQajlYNzGG5m
         tgzy4e1mFbTa5NzuaKEG5hh+tkG8GuagaIM7ua1SPgr9ywHraz8t7jtfQcTpsJ61VuGI
         fEtg==
X-Gm-Message-State: ANoB5pmdw0nxp2Pp8cy/Px4EG8Fu7qLqTCOBfmoNcF2tNg5F4p6ro0de
        7YuI7fpfhucSVJpAQ9ZFw8P8Hg==
X-Google-Smtp-Source: AA0mqf5iP79DZ9YVzIymp+mc2pG7BFZIAmXvZxQz2E9Q93ONya6s3g4ndO4nB3jGGu7rpuqyfhrQzA==
X-Received: by 2002:a05:6512:3f08:b0:4b4:efcf:93b with SMTP id y8-20020a0565123f0800b004b4efcf093bmr19727647lfa.277.1670277136658;
        Mon, 05 Dec 2022 13:52:16 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id m18-20020a194352000000b004b55ca53543sm1173298lfj.233.2022.12.05.13.52.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:52:16 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:52:11 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_07/23=5D_phy=3A_qcom-qmp-ufs?= =?US-ASCII?Q?=3A_Add_HS_G4_mode_support_to_SM8150_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-8-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-8-manivannan.sadhasivam@linaro.org>
Message-ID: <84BEB11D-127C-4156-ACA4-5BF193AFF5E7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 December 2022 20:43:12 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>UFS PHY in SM8150 SoC is capable of operating at HS G4 mode=2E Hence, add=
 the
>required register settings using the tables_hs_g4 struct instance=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 36 +++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 97d0baa9bac3=2E=2E269f96a0f752 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -374,6 +374,10 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_t=
x[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
> };
>=20
>+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_tx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x75),
>+};
>+
> static const struct qmp_phy_init_tbl sm8150_ufsphy_rx[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
> 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
>@@ -411,6 +415,25 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_r=
x[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
> };
>=20
>+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_rx[] =3D {
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x6c),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
>+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
>+};
>+
> static const struct qmp_phy_init_tbl sm8150_ufsphy_pcs[] =3D {
> 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
> 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
>@@ -421,6 +444,11 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_p=
cs[] =3D {
> 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
> };
>=20
>+static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] =3D {
>+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x10),
>+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
>+};
>+
> static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
> 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
>@@ -762,6 +790,14 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg =
=3D {
> 		=2Eserdes		=3D sm8150_ufsphy_hs_b_serdes,
> 		=2Eserdes_num	=3D ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
> 	},
>+	=2Etbls_hs_g4 =3D {
>+		=2Etx		=3D sm8150_ufsphy_hs_g4_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8150_ufsphy_hs_g4_tx),
>+		=2Erx		=3D sm8150_ufsphy_hs_g4_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8150_ufsphy_hs_g4_rx),
>+		=2Epcs		=3D sm8150_ufsphy_hs_g4_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,

--=20
With best wishes
Dmitry
