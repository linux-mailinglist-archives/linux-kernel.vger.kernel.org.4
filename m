Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D333643752
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiLEVuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLEVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:49:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830001C40F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:46:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f21so19809552lfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rs6LN4l8ZgCV03Txw6CfdvhgqFteOqFaHY0fdcPtk+M=;
        b=wnZegiJgfcinJhubqEEXuQDn8snEl5kA4FSCgMyRzYqvoRELI+5NN/sRCVg6gn/Cjc
         rLjDjRMXNC7icoPlX189Pt8C8SfwO0HQn5zSSrURCyiZA3HJSBF8XlroShJmyc7VaqFr
         OOdmck/s6XnEu+E5y7CtqQAY0SfF+/R/Y8lYXzu7Wt8yc8f0h3E5qUh4p/4fC5nZXAvX
         JnzgOGPpZy/hf6c5z9RvLrpsDr1iSOxQBBvx1l3DwUEvA9D8dsQJ2f5V2SGcKtEz0+ET
         G90egPp4B62ekdozFANO0X1l3EpJ/3boeW1ywISvPf8YrOEn+DaC+1aGxqfHF8EwRJYk
         zEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rs6LN4l8ZgCV03Txw6CfdvhgqFteOqFaHY0fdcPtk+M=;
        b=AHrHVf3NYLnY0mXuW0S6tmeczmU1KaUQS5ni+tw5n582TE8Dg5kIYpR/X1rqi8VseT
         yepcRXPKjrtDCbqXNXQ3YREmiPSjWGqXcb0Ukr8z4as7J9OXWnInVvmnWs7+4UtBFJez
         DS9jUGsEljXDF5T3UGFSBwL42xURgYWECsAl4so6WxjGjh+1q8kFbgWh8zST/NMrH6xu
         wcacPKoaB+aRHZ80vORB0VpCkiZZgLY6fx3YbCzmxDWMhoSePiqUCKvBfjy1HuuWlHFM
         gRZ5XomNixvUWRCegBd8itPO2H/C/cHPamzn2h8L+Vj9Rs3m0J8+xvcj2d00vKoLwAMP
         tLmg==
X-Gm-Message-State: ANoB5pnjkBH8TwuOog5WXxnZZItwEMh0PEg8vjqI11Bt9zAsJwevvEmh
        3Wjp5fLhhqOt/Z+5iLo+mI51R7x9ULiO7nzu
X-Google-Smtp-Source: AA0mqf5mXHEAEeXavkwuZy+lKnaa7ahPBnOcRUn4KdKyIS9HAUNS7hVNkKg3aoPLFxIU1qUHF+83Xw==
X-Received: by 2002:a05:6512:3703:b0:4a2:22cf:f44d with SMTP id z3-20020a056512370300b004a222cff44dmr22863589lfr.118.1670276777903;
        Mon, 05 Dec 2022 13:46:17 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512074d00b004b5732080d1sm585321lfs.150.2022.12.05.13.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:46:17 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:46:12 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_02/23=5D_phy=3A_qcom-qmp-?= =?US-ASCII?Q?ufs=3A_Rename_MSM8996_PHY_definitions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-3-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-3-manivannan.sadhasivam@linaro.org>
Message-ID: <6D3E7F39-086E-48C3-BB80-394CFBE8E682@linaro.org>
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



On 1 December 2022 20:43:07 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>Only MSM8996 is using "_ufs_" naming convention for PHY definitions inste=
ad
>of "_ufsphy_" as like other SoCs=2E So to maintain the uniformity, let's
>rename all of the definitions to use "_ufsphy_"=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>


Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 20fcdbef8c77=2E=2E35b77cd79e57 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -94,7 +94,7 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPH=
Y_LAYOUT_SIZE] =3D {
> 	[QPHY_PCS_POWER_DOWN_CONTROL]	=3D QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
> };
>=20
>-static const struct qmp_phy_init_tbl msm8996_ufs_serdes[] =3D {
>+static const struct qmp_phy_init_tbl msm8996_ufsphy_serdes[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
> 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
> 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
>@@ -143,12 +143,12 @@ static const struct qmp_phy_init_tbl msm8996_ufs_se=
rdes[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
> };
>=20
>-static const struct qmp_phy_init_tbl msm8996_ufs_tx[] =3D {
>+static const struct qmp_phy_init_tbl msm8996_ufsphy_tx[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
> 	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x02),
> };
>=20
>-static const struct qmp_phy_init_tbl msm8996_ufs_rx[] =3D {
>+static const struct qmp_phy_init_tbl msm8996_ufsphy_rx[] =3D {
> 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
> 	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x02),
> 	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x00),
>@@ -629,15 +629,15 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets=
_v5 =3D {
> 	=2Erx2		=3D 0xa00,
> };
>=20
>-static const struct qmp_phy_cfg msm8996_ufs_cfg =3D {
>+static const struct qmp_phy_cfg msm8996_ufsphy_cfg =3D {
> 	=2Elanes			=3D 1,
>=20
>-	=2Eserdes_tbl		=3D msm8996_ufs_serdes,
>-	=2Eserdes_tbl_num		=3D ARRAY_SIZE(msm8996_ufs_serdes),
>-	=2Etx_tbl			=3D msm8996_ufs_tx,
>-	=2Etx_tbl_num		=3D ARRAY_SIZE(msm8996_ufs_tx),
>-	=2Erx_tbl			=3D msm8996_ufs_rx,
>-	=2Erx_tbl_num		=3D ARRAY_SIZE(msm8996_ufs_rx),
>+	=2Eserdes_tbl		=3D msm8996_ufsphy_serdes,
>+	=2Eserdes_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_serdes),
>+	=2Etx_tbl			=3D msm8996_ufsphy_tx,
>+	=2Etx_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_tx),
>+	=2Erx_tbl			=3D msm8996_ufsphy_rx,
>+	=2Erx_tbl_num		=3D ARRAY_SIZE(msm8996_ufsphy_rx),
>=20
> 	=2Eclk_list		=3D msm8996_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(msm8996_ufs_phy_clk_l),
>@@ -1156,7 +1156,7 @@ static int qmp_ufs_probe(struct platform_device *pd=
ev)
> static const struct of_device_id qmp_ufs_of_match_table[] =3D {
> 	{
> 		=2Ecompatible =3D "qcom,msm8996-qmp-ufs-phy",
>-		=2Edata =3D &msm8996_ufs_cfg,
>+		=2Edata =3D &msm8996_ufsphy_cfg,
> 	}, {
> 		=2Ecompatible =3D "qcom,msm8998-qmp-ufs-phy",
> 		=2Edata =3D &sdm845_ufsphy_cfg,

--=20
With best wishes
Dmitry
