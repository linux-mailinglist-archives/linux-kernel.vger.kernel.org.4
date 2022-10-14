Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF685FF64D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJNWNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJNWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:12:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92029183DB3;
        Fri, 14 Oct 2022 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665785541; x=1697321541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=innQEexkiOpISbHesBJVPN2seV6UbE7z457Qn2L2iNw=;
  b=cIt2Fi8m6l4CkR30Ala+DAvs4BZRmu2+p/TOWrQ6z/DGs4mHmP1TouJk
   paCgvLNeq9Ay+HOyZu9USFEFwh+fcZcCIBFzApUadYq2JUqu1n7CBkI1S
   zJy0/cKShjAgaQiGiPvV7UZWyzgO0zMcgSP/Cl8n24oY9c370qp2zVdOC
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Oct 2022 15:11:52 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 15:11:52 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:11:38 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 3/4] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
Date:   Fri, 14 Oct 2022 15:11:20 -0700
Message-ID: <20221014221121.7497-4-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221121.7497-1-quic_molvera@quicinc.com>
References: <20221014221121.7497-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the power domains exposed by RPMH in the Qualcomm QDU1000
and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 092f6ab09acf..4b8198697245 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -353,6 +353,19 @@ static const struct rpmhpd_desc sm8450_desc = {
 	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
 };
 
+/* QDU1000/QRU1000 RPMH powerdomains */
+static struct rpmhpd *qdu1000_rpmhpds[] = {
+	[QDRU1000_CX] = &cx,
+	[QDRU1000_EBI] = &ebi,
+	[QDRU1000_MSS] = &mss,
+	[QDRU1000_MX] = &mx,
+};
+
+static const struct rpmhpd_desc qdu1000_desc = {
+	.rpmhpds = qdu1000_rpmhpds,
+	.num_pds = ARRAY_SIZE(qdu1000_rpmhpds),
+};
+
 /* SC7180 RPMH powerdomains */
 static struct rpmhpd *sc7180_rpmhpds[] = {
 	[SC7180_CX] = &cx_w_mx_parent,
@@ -430,6 +443,8 @@ static const struct rpmhpd_desc sc8280xp_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
+	{ .compatible = "qcom,qru1000-rpmhpd", .data = &qdu1000_desc },
 	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
-- 
2.38.0

