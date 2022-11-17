Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A69A62E3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiKQSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiKQSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:06:02 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB9A697D2;
        Thu, 17 Nov 2022 10:06:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHqJ9R026486;
        Thu, 17 Nov 2022 18:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=23YpcWHp7RXhRkJzkYcEYErF8JfBkyEzzT7Mr4ILTDk=;
 b=BQzngDN/k1BIi9flXfs14CuP1AbywTFOY/bz65u85R3gC/4K5DwpXFJYNd4Ew+ui/MVh
 pY5PCwHvqLAikZ3eVWao/Q2zSyJopwKEFL/gcx9JNwcPyfsKrgkbODCbFqFN2RxnFvSB
 k8bDgQyHEO7l3mQsM6/NspaN0OsvR7/BMHpsGV3Wje945PSrYQv1WrG1wAlYvAhXPk2z
 J/gyY7j3R5J8HPi+ifYtlCUHqnwjiMDrTuX0sDzhgfPm5YlOPbFbMFfzpbwajw+J79EJ
 busdH3KbRxBl0PbVUX7DasVw2Qye+0/bxmYMwHF02D1WeIztZhJTxL7YPwsoByMTc9qP vA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwrsk0c8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:05:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHI5u8B009282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:05:56 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 10:05:53 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <rameshn@qti.qualcomm.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH v4] wifi: ath10k: Store WLAN firmware version in SMEM image table
Date:   Thu, 17 Nov 2022 23:35:34 +0530
Message-ID: <20221117180534.2267-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3gFMwSTY54VgrZoOZN1D5KT-CuEznU46
X-Proofpoint-ORIG-GUID: 3gFMwSTY54VgrZoOZN1D5KT-CuEznU46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a SoC based solution, it would be useful to know the versions of the
various binary firmware blobs the system is running on. On a QCOM based
SoC, this info can be obtained from socinfo debugfs infrastructure. For
this to work, respective subsystem drivers have to export the firmware
version information to an SMEM based version information table.

Having firmware version information at one place will help quickly
figure out the firmware versions of various subsystems on the device
instead of going through builds/logs in an event of a system crash.

Fill WLAN firmware version information in SMEM version table to be
printed as part of socinfo debugfs infrastructure on a Qualcomm based
SoC.

This change is applicable only for SNOC/QMI based targets.

Example:
cat /sys/kernel/debug/qcom_socinfo/cnss/name
QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
Changes from v3:
 - Changed patch title
 - Changed naming conventions
 - Removed MAX_BUILD_ID_LEN usuage
 - Added condition to call API
 - Changed depends on QCOM_SMEM to select QCOM_SMEM
---
 drivers/net/wireless/ath/ath10k/Kconfig |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c   | 35 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index ca007b800f75..e0a51dad8e42 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -44,6 +44,7 @@ config ATH10K_SNOC
 	tristate "Qualcomm ath10k SNOC support"
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SMEM
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 66cb7a1e628a..cdcb162f93c2 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -14,6 +14,7 @@
 #include <linux/net.h>
 #include <linux/platform_device.h>
 #include <linux/qcom_scm.h>
+#include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
 #include <net/sock.h>
 
@@ -22,6 +23,10 @@
 
 #define ATH10K_QMI_CLIENT_ID		0x4b4e454c
 #define ATH10K_QMI_TIMEOUT		30
+#define SMEM_IMAGE_VERSION_TABLE       469
+#define SMEM_IMAGE_TABLE_CNSS_INDEX     13
+#define SMEM_IMAGE_VERSION_ENTRY_SIZE	128
+#define SMEM_IMAGE_VERSION_NAME_SIZE	75
 
 static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
 					 struct ath10k_msa_mem_info *mem_info)
@@ -536,6 +541,33 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
 	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
 }
 
+static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, const char *fw_build_id)
+{
+	u8 *table_ptr;
+	size_t smem_item_size;
+	const u32 smem_img_idx_wlan = SMEM_IMAGE_TABLE_CNSS_INDEX *
+				      SMEM_IMAGE_VERSION_ENTRY_SIZE;
+
+	table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+				  SMEM_IMAGE_VERSION_TABLE,
+				  &smem_item_size);
+
+	if (IS_ERR(table_ptr)) {
+		ath10k_err(ar, "smem image version table not found\n");
+		return;
+	}
+
+	if (smem_img_idx_wlan + SMEM_IMAGE_VERSION_ENTRY_SIZE >
+	    smem_item_size) {
+		ath10k_err(ar, "smem block size too small: %zu\n",
+			   smem_item_size);
+		return;
+	}
+
+	strscpy(table_ptr + smem_img_idx_wlan, fw_build_id,
+		SMEM_IMAGE_VERSION_NAME_SIZE);
+}
+
 static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 {
 	struct wlfw_cap_resp_msg_v01 *resp;
@@ -606,6 +638,9 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
 	}
 
+	if (resp->fw_build_id_valid)
+		ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
+
 	kfree(resp);
 	return 0;
 
-- 
2.38.0

