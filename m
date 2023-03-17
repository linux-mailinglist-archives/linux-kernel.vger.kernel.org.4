Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE9D6BEE3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCQQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCQQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:28:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7D52914;
        Fri, 17 Mar 2023 09:28:34 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H90I3r017582;
        Fri, 17 Mar 2023 16:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=45Sa0KvhtyZyoLD9CE/N9cMwquHru6OA03DUNWKKcFs=;
 b=YQF/Cw3mhBYIunNTh/caRsS69G+UAFVurB1+olgAz7INQpIG6uQPgoXscKrn0NmObw6I
 jW3Sr7ppvOtJVXadlgJgfA9vJR0TM0/dM2msOnxaMxj1SmtO8nIGhcI567SNvloSAza0
 T4jRAVo+1/ZICa0DbiIoxXz0B0ZT8Tk+3pfVGZlGiaNQImlwXpqaKLZYUs1pvFRqX6pB
 q0dDfZzHgqnZWAcI1k+YjKlxsxBQMAFxlb2vZfLtkgqbi2r8Eqg0lexTfhIiCSPMJdCs
 oXOFRGyLZE5ojBFUbKPvzTCaUdQMZGVuzKAB00STfp2ZMzMHOoHya8mFn8D8d25rIks7 jg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcn6f1hhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HGSVfQ031328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 16:28:31 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 09:28:28 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 2/5] pinctrl: qcom: Use qcom_scm_io_update_field()
Date:   Fri, 17 Mar 2023 21:57:59 +0530
Message-ID: <1679070482-8391-3-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FPVvtoiQVXniFzdJBhNB4yU5jGzcaQK_
X-Proofpoint-ORIG-GUID: FPVvtoiQVXniFzdJBhNB4yU5jGzcaQK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 mlxlogscore=650 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use qcom_scm_io_update_field() exported function introduced
in last commit.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index daeb79a..3d3d520 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1016,6 +1016,8 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	unsigned long flags;
 	bool was_enabled;
 	u32 val;
+	u32 tmp_val;
+	u32 mask;
 
 	if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
 		set_bit(d->hwirq, pctrl->dual_edge_irqs);
@@ -1049,24 +1051,21 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	 * With intr_target_use_scm interrupts are routed to
 	 * application cpu using scm calls.
 	 */
+	mask = (7 << g->intr_target_bit);
+	tmp_val = g->intr_target_kpss_val << g->intr_target_bit;
 	if (pctrl->intr_target_use_scm) {
 		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
-
-		val &= ~(7 << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
-
-		ret = qcom_scm_io_writel(addr, val);
+		ret = qcom_scm_io_update_field(addr, mask, tmp_val);
 		if (ret)
 			dev_err(pctrl->dev,
 				"Failed routing %lu interrupt to Apps proc",
 				d->hwirq);
 	} else {
 		val = msm_readl_intr_target(pctrl, g);
-		val &= ~(7 << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
+		val &= ~mask;
+		val |= tmp_val;
 		msm_writel_intr_target(val, pctrl, g);
 	}
 
-- 
2.7.4

