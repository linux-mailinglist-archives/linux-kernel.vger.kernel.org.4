Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41905643785
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiLEV4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLEV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:56:15 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2BF19
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:55:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d6so20700351lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oKO88ao55DxeeXnBljoXeld0kkAkjM3hR01wftgKVTw=;
        b=LGmal3EdUpWrC1R3nF6mkwM7Df/F/iOHovzKOGvspnP8S0/6optExX0dgJx1r0NI8P
         JnTquIdtNcngTOk2jvqi46vEF4u9YUwXWEdKPdzsT9gLjw19VUW/lkeCp5/nWKT9nK18
         B6lujK1mJ5qNwhpP+k8U0kvHvPJfnE4pCmzVmYkeIcaOYh/bNZyHCrR4dtGi779nu336
         cUzJ5DL/0R7IBNZDm5UHVQlzQ625m15k7CGHGnx1sFsRaY73R7LHWJCn9wt+0OT877qY
         pXmaHqAEod8VB7YF2WRTYwAoTPTWSa7pVaKNdrpVBbFeO3agAHKqBCjLDYZT4RAgSUVE
         3BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oKO88ao55DxeeXnBljoXeld0kkAkjM3hR01wftgKVTw=;
        b=IUJEs/gl7gGWZFgtCIqXruIG9BOowV9hH+pHkEmv6wsoI6ua0JPAGp06xZ/6FzgUjS
         rFqk98bQYmA+Ou2kYuxYSL+WV2pq/pbxA0yqs1o0tjfY3Zk4SLMueKUTWlOtSL1IqTcl
         9NluKnkziYktfl+9z1WFCHFIpZBgDF2bMSy3YEF0PrKX24gGfMcyjFVWoyNUktTRgDJ5
         GfKUphx3ws8ohhsBvvi+So4OuCVqFwObOCEQ+sOqaieLaJRw3XE29ANX2rIQI+qaeXNj
         CVGMZ6QqCtzclx3aTN16GE0Cy5uHo9AfbkNjhpL8tu6sBpjzRcKqYjdd9k710og+iQVR
         9Oag==
X-Gm-Message-State: ANoB5pkmJJjfnCTWRWmsnB0YHFTEgsayJ4tr8RYmpcLkcqPN2Xfivv8e
        IdbY3T7Dl29/UtYGahdgBPYvDA==
X-Google-Smtp-Source: AA0mqf5SswWygv24y9yRXfk5wHX/CIUMUkg6260+JfxCoIclzTWfee5uW70fP+owZxwIDKvbFGsPdg==
X-Received: by 2002:a19:760b:0:b0:4b5:67d8:e3c2 with SMTP id c11-20020a19760b000000b004b567d8e3c2mr3416705lff.166.1670277352663;
        Mon, 05 Dec 2022 13:55:52 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.129])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651c118900b00279d206a43bsm1250265ljo.34.2022.12.05.13.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 13:55:52 -0800 (PST)
Date:   Tue, 06 Dec 2022 00:55:48 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
CC:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_11/23=5D_phy=3A_qcom-qmp-ufs?= =?US-ASCII?Q?=3A_Add_HS_G4_mode_support_to_SM8450_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221201174328.870152-12-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org> <20221201174328.870152-12-manivannan.sadhasivam@linaro.org>
Message-ID: <977DEE2E-FCD8-44AD-BB52-49EDF586B796@linaro.org>
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



On 1 December 2022 20:43:16 GMT+03:00, Manivannan Sadhasivam <manivannan=
=2Esadhasivam@linaro=2Eorg> wrote:
>UFS PHY in SM8450 SoC is capable of operating at HS G4 mode and the init
>sequence is compatible with SM8350=2E Hence, add the tbls_hs_g4 instance
>reusing the G4 init sequence of SM8350=2E

Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>

>
>Signed-off-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eor=
g>
>---
> drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/phy/qual=
comm/phy-qcom-qmp-ufs=2Ec
>index 75e55c4181c9=2E=2E96e03d4249da 100644
>--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>@@ -935,6 +935,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg =
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
> 	=2Eclk_list		=3D sm8450_ufs_phy_clk_l,
> 	=2Enum_clks		=3D ARRAY_SIZE(sm8450_ufs_phy_clk_l),
> 	=2Evreg_list		=3D qmp_phy_vreg_l,

--=20
With best wishes
Dmitry
