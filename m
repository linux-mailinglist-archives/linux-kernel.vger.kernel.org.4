Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5906259B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKKLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiKKLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:43:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0CE45ECF;
        Fri, 11 Nov 2022 03:43:02 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABAt9kZ025079;
        Fri, 11 Nov 2022 11:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=seBFUaRp3ouDX4be0OELujUijoj4Q03BoNVadg0/LK4=;
 b=oVitbTaMdAuM7waoylsi39KLcq28CejbgAl/pb+ujA7f78qkVkD0+774T9TRPwDhxz26
 Vzo8MkcDofre/6lm2Cbng98/C98GDb4t9ZkLmy6UjuRoNMDvHCUK7n9o7xJpKt1jP14N
 /VNhtcx8lC8vXuCUjLVPkyptYqTgmuBrv+1od+YUBSS9li6Q+o0bvwWfrWyTEsxYeeRx
 7q0Nj5nk7Au+a2DOO9SIPltuGl6GDDtoT6GEGemn8ZDrkHJayH4PWnJPpZ2nm9i/nk/q
 HDD+MS65+iR8kd3cQ/nEJIj35Z4vofYmph0g9YXzCY8uE4DWoNrMsoIlKFyFnSx9a8y0 fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksada1t6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:42:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABBgu7J010956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:42:56 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 11 Nov 2022 03:42:54 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        "Youghandhar Chintala" <quic_youghand@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] wifi: ath10k: Add WLAN firmware image version info into smem
Date:   Fri, 11 Nov 2022 17:12:35 +0530
Message-ID: <20221111114235.10287-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pn7p2lM7IEusjRFCpMHEAhgXTRTm8JN8
X-Proofpoint-GUID: pn7p2lM7IEusjRFCpMHEAhgXTRTm8JN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110078
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

This change is applicable only for WCN399X targets.

Example:
cat /sys/kernel/debug/qcom_socinfo/cnss/name
QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Reported-by: kernel test robot <lkp@intel.com>

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
Changes from v2:
 - Removed blank line between trailers
 - Changed memcpy to strscpy
 - Removed version_string_size
 - Added new condition fw_build_id against max length
 - Added depends on QCOM_SMEM for ath10k_snoc
---
 drivers/net/wireless/ath/ath10k/Kconfig |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c   | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index ca007b800f75..e6ea884cafc1 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -44,6 +44,7 @@ config ATH10K_SNOC
 	tristate "Qualcomm ath10k SNOC support"
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 66cb7a1e628a..6c3ddad26417 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -14,6 +14,7 @@
 #include <linux/net.h>
 #include <linux/platform_device.h>
 #include <linux/qcom_scm.h>
+#include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
 #include <net/sock.h>
 
@@ -22,6 +23,8 @@
 
 #define ATH10K_QMI_CLIENT_ID		0x4b4e454c
 #define ATH10K_QMI_TIMEOUT		30
+#define ATH10K_SMEM_IMAGE_VERSION_TABLE       469
+#define ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX     13
 
 static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
 					 struct ath10k_msa_mem_info *mem_info)
@@ -536,6 +539,35 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
 	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
 }
 
+static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, const char *fw_build_id)
+{
+	u8 *smem_table_ptr;
+	size_t smem_block_size;
+	const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
+
+	smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+				       ATH10K_SMEM_IMAGE_VERSION_TABLE,
+				       &smem_block_size);
+	if (IS_ERR(smem_table_ptr)) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI,
+			   "smem image version table not found\n");
+		return;
+	}
+
+	if (smem_img_idx_wlan + MAX_BUILD_ID_LEN > smem_block_size) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %zu\n",
+			   smem_block_size);
+		return;
+	}
+
+	if (strlen(fw_build_id) > MAX_BUILD_ID_LEN) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "fw_build_id length more than max length\n");
+		return;
+	}
+
+	strscpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id, MAX_BUILD_ID_LEN);
+}
+
 static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 {
 	struct wlfw_cap_resp_msg_v01 *resp;
@@ -606,6 +638,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
 	}
 
+	ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
+
 	kfree(resp);
 	return 0;
 
-- 
2.38.0

