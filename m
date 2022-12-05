Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BE64376C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiLEVxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiLEVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:52:35 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823DC9597
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:51:48 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a19so15160301ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdQPMv6gJPn05Six/YfmIDR/4tup258UDHVnm5qhvZo=;
        b=spC0ecwu248DgOvZ0F1NPg0nncvPkHSxeBDyyPLmMWmsyxxCcbBJUUtuCohCyWPp4v
         FbLbsXO9hTM2UDULDBKClQdMM9lG9kvWLpWNNiebwNeWiurj9s2Tjk2uWGiWJsv12UyF
         d3BbYyomcIfGABVutvq+r6eBx5JIZkkQ0EIXpDfT+yc6Lar4vdVZjxVBEzJoZ5xs5I9q
         b5cKFCouoYFt9Omorbp1HMZ5adK6kvJtgD7k2mR+DNyW4OKZH2zl7FiFPPphhA+Oeb8u
         QZQvCNpdFHYw4ResG7NcwAJOmhbVXG5h7FINskx7VeXD0zmi2OjJNluG3ttfQR0QMLXI
         Sp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdQPMv6gJPn05Six/YfmIDR/4tup258UDHVnm5qhvZo=;
        b=D286qypdcaZBPftYuskEOZE5QpiCXaC7LuwC+eUHsnGSGWw7PH0YX0YgJMsjh6Lkht
         9KMqJejsvkQV0Qwg/kyBntn7NalO7q0xJ4tXHhkVRzM0gEIQNuutK842OZMqVt8Ao85+
         +tgBYqBm5nGU3UQegda0E3qNHeS6FPwfmt2ZjMxHmJVEEiNhtzu8bXVvy2h+fMc2mC9f
         if5xIQlaxQa7gK2BgBPnYkKZG69ZiU4r60mhliSr6nchwdRgw7Q9rouqb4vyUbTlqEBl
         +7fyZsalWM7ozsDNkU2HKv8q7SHmsd7hBpLjvLf9ifAYr0FB4jP2keIrJpCKKeWiEQYV
         vKNw==
X-Gm-Message-State: ANoB5pmFtpFwDmkQ49nBJxhsJihU0FBqsUHitSl3YhE+GuxECk+ffZ31
        F19lMPkHilTcQ72CNo2ZQCjSqA==
X-Google-Smtp-Source: AA0mqf4tRdGqPeB+CrgbTj5zAmEYI7RFoWPpMckQKFd5XiSBV3yLWK0KDKhaTunSunUt+yNOLIxFyA==
X-Received: by 2002:a05:651c:313:b0:279:b566:7489 with SMTP id a19-20020a05651c031300b00279b5667489mr9958854ljp.137.1670277106898;
        Mon, 05 Dec 2022 13:51:46 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id v10-20020ac2558a000000b00494a603953dsm2243058lfg.89.2022.12.05.13.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:51:46 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:51:42 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_04/23=5D_phy=3A_qcom-qmp-ufs=3A_Add_s?= =?US-ASCII?Q?upport_for_configuring_PHY_in_HS_Series_B_mode?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-5-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-5-manivannan.sadhasivam@linaro.org>
Message-ID: <32201EF1-8169-4940-99E1-31CC0C37C522@linaro.org>
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



On 1 December 2022 20:43:09 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>Add separate tables_hs_b instance to allow the PHY driver to configure th=
e
>PHY in HS Series B mode=2E The individual SoC configs need to supply the
>serdes register setting in tables_hs_b and the UFS driver can request the
>Series B mode by calling phy_set_mode() with mode set to PHY_MODE_UFS_HS_=
B=2E
>
>Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 516027e356f0=2E=2E2d5dd336aeb2 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -547,6 +547,8 @@ struct qmp_phy_cfg {
>=20
> 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
> 	const struct qmp_phy_cfg_tbls tbls;
>+	/* Additional sequence for HS Series B */
>+	const struct qmp_phy_cfg_tbls tbls_hs_b;
>=20
> 	/* clock ids to be requested */
> 	const char * const *clk_list;
>@@ -580,6 +582,7 @@ struct qmp_ufs {
> 	struct reset_control *ufs_reset;
>=20
> 	struct phy *phy;
>+	u32 mode;
> };
>=20
> static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
>@@ -841,6 +844,8 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, con=
st struct qmp_phy_cfg_tbls
> static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp=
_phy_cfg *cfg)
> {
> 	qmp_ufs_serdes_init(qmp, &cfg->tbls);
>+	if (qmp->mode =3D=3D PHY_MODE_UFS_HS_B)
>+		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);

I still think that qmp_ufs_init_registers() is a way to go here , see the =
pcie driver=2E

> 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
> 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
> }
>@@ -1011,9 +1016,19 @@ static int qmp_ufs_disable(struct phy *phy)
> 	return qmp_ufs_exit(phy);
> }
>=20
>+static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int sub=
mode)
>+{
>+	struct qmp_ufs *qmp =3D phy_get_drvdata(phy);
>+
>+	qmp->mode =3D mode;
>+
>+	return 0;
>+}
>+
> static const struct phy_ops qcom_qmp_ufs_phy_ops =3D {
> 	=2Epower_on	=3D qmp_ufs_enable,
> 	=2Epower_off	=3D qmp_ufs_disable,
>+	=2Eset_mode	=3D qmp_ufs_set_mode,
> 	=2Eowner		=3D THIS_MODULE,
> };
>=20

--=20
With best wishes
Dmitry
