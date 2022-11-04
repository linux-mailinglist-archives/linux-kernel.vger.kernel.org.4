Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787F6192B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiKDI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKDI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:29:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F802610E;
        Fri,  4 Nov 2022 01:29:34 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A46sh0l024757;
        Fri, 4 Nov 2022 08:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=F523UAf1/s3baROaXRYF1jL25q1n1tGzBM/u38xKkvk=;
 b=TBEhM615QX7w14CYbKOAnSSZbJ8Nwe5pNgzgsEXzywf4ZLCLdmtywAw+T4V088hTitTk
 8A0glYME6NoXsemC4khtMfVMfPzipMbvsVw5VAfyfhNLcUvAwC3CErwSEhbopg0npbPz
 8RMpBvhDGtWQht/t07CwgLcg8r+m/G+28hAgBd7WlSGnwEz7VKmF2f2OVwvEPrV1tSlU
 Nbf5kLBG9ntg8BNxP2aJQdDDuRaSlfIfi6qPIvAMLbbtlpT8g1Dz49IYURczn1BBTWel
 ARG80xOD41muE/hqXU9E8vcC2mVSTohQzoG6ESgSfJ+b/kcLEERjh5tMDdStBrlP9iOU bQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmvdy8djp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 08:28:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A48SncK006786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 08:28:49 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 4 Nov 2022 01:28:46 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        "Youghandhar Chintala" <quic_youghand@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] wifi: ath10k: Add WLAN firmware image version info into smem
Date:   Fri, 4 Nov 2022 13:58:28 +0530
Message-ID: <20221104082828.14386-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ViL93cA0mf8EPKql2a8wzNtxT70RzuSY
X-Proofpoint-ORIG-GUID: ViL93cA0mf8EPKql2a8wzNtxT70RzuSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040055
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

Reported-by: kernel test robot <lkp@intel.com>

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>

---
Changes from v1:
 - Changed print format specifier to %zu from %i
 - Changed ath10k_qmi_add_wlan_ver_smem() API argument
	  to const char *fw_build_id from char *fw_build_id
 - Changed version_string_size with MACRO
---
 drivers/net/wireless/ath/ath10k/qmi.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 66cb7a1e628a..928d78f6d494 100644
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
@@ -536,6 +539,29 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
 	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
 }
 
+static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, const char *fw_build_id)
+{
+	u8 *smem_table_ptr;
+	size_t smem_block_size;
+	const u32 version_string_size = MAX_BUILD_ID_LEN;
+	const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
+
+	smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+				       ATH10K_SMEM_IMAGE_VERSION_TABLE,
+				       &smem_block_size);
+	if (IS_ERR(smem_table_ptr)) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem image version table not found");
+		return;
+	}
+	if (smem_img_idx_wlan + version_string_size > smem_block_size) {
+		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %zu",
+			   smem_block_size);
+		return;
+	}
+	memcpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id,
+	       version_string_size);
+}
+
 static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 {
 	struct wlfw_cap_resp_msg_v01 *resp;
@@ -606,6 +632,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
 			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
 	}
 
+	ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
+
 	kfree(resp);
 	return 0;
 
-- 
2.38.0

