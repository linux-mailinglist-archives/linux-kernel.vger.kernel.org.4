Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF49643789
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiLEV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiLEV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:56:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7010BD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:56:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so20669423lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ouwMuYuz2oARizUtl7vzXJdY8RwuaCzneky9hi1f4c=;
        b=l2lQpqKKFAiJUi7/jAj8kNG5nQy91Jn341kmeJ5FkG/igoqQYJ78WDLru7D56uLTVa
         N5iAxwfXk/DC+m3bhinTJuHu4Gr94G3XcF81t0E/9Wnjjp0rpUtcc8gxftJqA1i1GsQi
         NnZBfXYmv0gF0Kf5W1bPM3NVNjFDrUuHR80LaM0w9dSKiYg1/kO4+39PNez37/YY51rC
         F4DQSOUHq4NOxy5KtyzTQoLMIZJdvvBAYllMiw8y2KViGrdfl7kJwpg35eXAVIUQlJIr
         NgAb1WGlKj4HIXbbkQ/3+gvPD6w0LRDgrqiRlxcLQutoKmCKuq9iLUHxEcj5a9tUSDyF
         weZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ouwMuYuz2oARizUtl7vzXJdY8RwuaCzneky9hi1f4c=;
        b=iFGeDo/KFPiUHO2BmHkErwp+0rP7GZSGE0Sfz8qFPblmSCDCHStWEEiRNW1VI1H/Ss
         sanKdqjQH0PT6UvKY1B1bvhxHVg3t26VX+KmPw27F0qaqArlRWBw8LqULh33hOqcCk7x
         1wMo/W0JV0cnnbW2rUwRultuQsBib7DDUVVapYl+xLmS8Mll9cgkteifYQrqpm+6HOmT
         lu+iXWAvG4pf1IZyiHFj6xHRL5iYL800NAod5Qg+ZGbNNq2Puyc7eZ4JKwM2FN5ud43K
         kwyugxEuBilWXAEb1YM4Iqo+TN8+XpzjiWD/332UO/gj3tOLxbUayNt905K7F/FQARaV
         oWbA==
X-Gm-Message-State: ANoB5pnimRl0N1DiprvUeeTSfcDSbZgP7G8XCXOI/Oz7szWR9KOeGCGJ
        qiFiPQHIhZpOiDjhq09ZLhcQew==
X-Google-Smtp-Source: AA0mqf4zwnAwfKtw3LMPJAu09UOZ7qPeq7PZzh98m4mubNvYFfJNS6m7yZZh8qckmGXoI80VmkzSYA==
X-Received: by 2002:a05:6512:2591:b0:4ae:c2b5:29c4 with SMTP id bf17-20020a056512259100b004aec2b529c4mr24285208lfb.614.1670277375355;
        Mon, 05 Dec 2022 13:56:15 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id l7-20020a056512110700b004a46f92a15bsm2246422lfg.41.2022.12.05.13.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:56:15 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:56:10 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_12/23=5D_phy=3A_qcom-qmp-ufs=3A?= =?US-ASCII?Q?_Add_HS_G4_mode_support_to_SC8280XP_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-13-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-13-manivannan.sadhasivam@linaro.org>
Message-ID: <6799A9DF-2CFC-47FE-B8AE-EF74C54E0C9B@linaro.org>
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



On 1 December 2022 20:43:17 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>UFS PHY in SC8280XP SoC is capable of operating at HS G4 mode and the ini=
t
>sequence is compatible with SM8350=2E Hence, add the tbls_hs_g4 instance
>reusing the G4 init sequence of SM8350=2E
>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>


>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 96e03d4249da=2E=2E9f5526758985 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -763,6 +763,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg =
=3D {
> 		=2Eserdes		=3D sm8350_ufsphy_hs_b_serdes,
> 		=2Eserdes_num	=3D ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
> 	},
>+	=2Etbls_hs_g4 =3D {
>+		=2Etx		=3D sm8350_ufsphy_g4_tx,
>+		=2Etx_num		=3D ARRAY_SIZE(sm8350_ufsphy_g4_tx),
>+		=2Erx		=3D sm8350_ufsphy_g4_rx,
>+		=2Erx_num		=3D ARRAY_SIZE(sm8350_ufsphy_g4_rx),
>+		=2Epcs		=3D sm8350_ufsphy_g4_pcs,
>+		=2Epcs_num	=3D ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
>+	},
> 	=2Eclk_list		=3D sdm845_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,

--=20
With best wishes
Dmitry
