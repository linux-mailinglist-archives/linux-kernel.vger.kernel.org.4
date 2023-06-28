Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBB741170
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjF1Mk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:40:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:52800 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231706AbjF1Mhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:37:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBDGQm002370;
        Wed, 28 Jun 2023 12:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jirypYn/l5H9pX+tgaMIYr1LepA3IkncZEaWrvK3Yog=;
 b=IrI3QiEuouHDdScyw2E4Z94ukTES20W3LZvX5/la8kT0FartU23ky/RAVSAJNZfymVGZ
 iiiL4zdmrCti1HX/BOBYSoGcyeNVBzI9jE+kpPHQcMlLrblFT4b89qLdfn/e2PZeWcmj
 vbzxPnPIBlMFOtKzFPHeelpKi9InYSW4Pb0yf9NQRqydl6wReuC7q4jwY+L85as0G5LV
 XWRm0pqxfmNGYgdBJRX9G+fW+AQFk8w8kHSFi3UmcfjmUEutaH94rVxWUZj0pPKEZyfO
 pxEf2kJrF1+xM+lmwdZP+zsvmfZXP+EACKHlwqW+PLselI6FaFXcLRC9hauaraUiQGVe Bw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpgw7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:37:20 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCbJPk028450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:37:19 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:37:12 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 18/21] pinctrl: qcom: Use qcom_scm_io_update_field()
Date:   Wed, 28 Jun 2023 18:04:45 +0530
Message-ID: <1687955688-20809-19-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LkvDYJLcaIHW74S5BXOR2kSeIJcmyq30
X-Proofpoint-GUID: LkvDYJLcaIHW74S5BXOR2kSeIJcmyq30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=903 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use qcom_scm_io_update_field() exported function introduced
in last commit.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index c5f52d4f7781..f31b54bf98e4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1041,6 +1041,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	const struct msm_pingroup *g;
 	unsigned long flags;
 	bool was_enabled;
+	u32 mask;
 	u32 val;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
@@ -1075,23 +1076,20 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * With intr_target_use_scm interrupts are routed to
 	 * application cpu using scm calls.
 	 */
+	mask = (GENMASK(2, 0) << g->intr_target_bit);
 	if (pctrl->intr_target_use_scm) {
 		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
-
-		val &= ~(7 << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
-
-		ret = qcom_scm_io_writel(addr, val);
+		val = g->intr_target_kpss_val << g->intr_target_bit;
+		ret = qcom_scm_io_update_field(addr, mask, val);
 		if (ret)
 			dev_err(pctrl->dev,
 				"Failed routing %lu interrupt to Apps proc",
 				d->hwirq);
 	} else {
 		val = msm_readl_intr_target(pctrl, g);
-		val &= ~(7 << g->intr_target_bit);
+		val &= ~mask;
 		val |= g->intr_target_kpss_val << g->intr_target_bit;
 		msm_writel_intr_target(val, pctrl, g);
 	}
-- 
2.7.4

