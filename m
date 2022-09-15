Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBEB5B9C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIOOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIOOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:09:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D29C2CB;
        Thu, 15 Sep 2022 07:09:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FDw35o014388;
        Thu, 15 Sep 2022 14:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bdnp4PyOxcNHL0V8OK4m7uU6PG88LE7nMYWQq2m2E5g=;
 b=PhwjtHuJm7QNu5fOPkNniL6Jwk2cISlW6kmoWWSKcPFUXha+6kMU1ijD7gi0x17T93p2
 rK6fpjd4hzUCdyvNGV8eDqCypYqxgZm7FzMH7umFh1GvROgQXhXwfdKQ0qucTOlns0mL
 W58k6ByMkM81v9IC8VIrbp9qUAWmuPEB8JkCqFcIFpEswIIxRYyIIEKHQcWHjj9s86bF
 ZVml+T0tJvn/W6ynxm0EeHxHMltyGeBHZKes3TCmcrwBOx9XQ95uWF3S6eDJLHQd0O+m
 +C1UQse96G5+VuS6cXKq7ReWiuqfV8sQiOlvKYsv7j+kWxxhRZf0Ipi5jYvmp2x23EUN oA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkvr31k08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 14:09:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FDlJHI003797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 13:47:19 GMT
Received: from hu-vhiren-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 06:47:15 -0700
From:   Hiren Gohel <quic_vhiren@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     Udipto Goswami <quic_ugoswami@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Hiren Gohel <quic_vhiren@quicinc.com>
Subject: [PATCH] usb: phy: qusb: Use scm call to update value in register
Date:   Thu, 15 Sep 2022 19:17:07 +0530
Message-ID: <1663249627-21151-1-git-send-email-quic_vhiren@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k3UMf0cqqUwzVOzOvcOgwA59SQcHlhQO
X-Proofpoint-GUID: k3UMf0cqqUwzVOzOvcOgwA59SQcHlhQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=642 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers used by vendors to control any functionality could be
implemented by making the register secured. In such cases the
register cannot be updated with a new value since the normal
write ops will fail.

Hence, use the scm_call to do a secure write to the register.

Signed-off-by: Hiren Gohel <quic_vhiren@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 19 +++++++++++++++++++
 drivers/firmware/qcom_scm.h |  1 +
 include/linux/qcom_scm.h    |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..7131df8 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -400,6 +400,25 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
 }
 EXPORT_SYMBOL(qcom_scm_set_remote_state);
 
+void qcom_scm_phy_update_scm_level_shifter(u32 val)
+{
+	int ret;
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_BOOT,
+		.cmd = QCOM_SCM_QUSB2PHY_LVL_SHIFTER_CMD_ID,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	desc.args[0] = val;
+	desc.args[1] = 0;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (ret)
+		pr_err("Failed to update scm level shifter=0x%x\n", ret);
+}
+EXPORT_SYMBOL(qcom_scm_phy_update_scm_level_shifter);
+
 static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 0d51eef..0a8c25b 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -81,6 +81,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_BOOT_SET_ADDR_MC	0x11
 #define QCOM_SCM_BOOT_SET_REMOTE_STATE	0x0a
 #define QCOM_SCM_FLUSH_FLAG_MASK	0x3
+#define QCOM_SCM_QUSB2PHY_LVL_SHIFTER_CMD_ID	0x1B
 #define QCOM_SCM_BOOT_MAX_CPUS		4
 #define QCOM_SCM_BOOT_MC_FLAG_AARCH64	BIT(0)
 #define QCOM_SCM_BOOT_MC_FLAG_COLDBOOT	BIT(1)
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644..3e5cbe9 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
+extern void qcom_scm_phy_update_scm_level_shifter(u32 val);
+
 #endif
-- 
2.7.4

