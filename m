Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A27615C17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKBGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:14:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4B22514;
        Tue,  1 Nov 2022 23:14:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A25qY4a005300;
        Wed, 2 Nov 2022 06:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xDWRRIQ1wf0+iOYlAZ8Oe2lQzK3V4SJ6qgIugj3Dzvs=;
 b=XPhU4JIi9lfm73/0IOR8b1SR3n8eIcelNtEFyiI/P/HBcFq34u6q5PfH9BIHYc4nYJeV
 yCdTa5fjN0EGMKRu9oxVAKIAyUMLOkE2pOgn0GJDnUvMgkinDbPFnZtcxeQ6goM0MnVF
 6J0yWc2AtmUgFaida1jic2g1gVolPt2c2fXDgmHbuS6XND77eRB3XKyoPGWqJeymu/X/
 OHw3NKmPrpkOWqDN1CPQNX84qe4X6K0GjE5skhkL72sUZNe0GYZSFALhoafFAhm5rqXn
 qukU0KUvfh0JAwo0v4lHGKxfX/nF0p8V+fEikw6CiAunt/4muEXdqQCQoUErz7UFnngL Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7nfhdx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 06:14:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A26EkD3022047
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 06:14:46 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 1 Nov 2022 23:14:44 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH] wifi: ath11k: Trigger sta disconnect on hardware restart
Date:   Wed, 2 Nov 2022 11:44:23 +0530
Message-ID: <20221102061423.1032-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uzQBI0wKQxUnHrBge5KRaC-THVOQNW4P
X-Proofpoint-GUID: uzQBI0wKQxUnHrBge5KRaC-THVOQNW4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_02,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently after the hardware restart triggered from the driver, the
station interface connection remains intact, since a disconnect trigger
is not sent to userspace. This can lead to a problem in targets where
the wifi mac sequence is added by the firmware.

After the target restart, its wifi mac sequence number gets reset to
zero. Hence AP to which our device is connected will receive frames with
a  wifi mac sequence number jump to the past, thereby resulting in the
AP dropping all these frames, until the frame arrives with a wifi mac
sequence number which AP was expecting.

To avoid such frame drops, its better to trigger a station disconnect
upon target hardware restart which can be done with API
ieee80211_reconfig_disconnect exposed to mac80211.

The other targets are not affected by this change, since the hardware
params flag is not set.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 6 ++++++
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 0ab2f190f1ec..edf78df9b12f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -195,6 +195,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -277,6 +278,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -356,6 +358,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -438,6 +441,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -519,6 +523,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -597,6 +602,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = false,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
 		.smp2p_wow_exit = true,
+		.support_fw_mac_sequence = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 8a3f24862edc..0c5ef8a526d8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -219,6 +219,7 @@ struct ath11k_hw_params {
 	bool tcl_ring_retry;
 	u32 tx_ring_size;
 	bool smp2p_wow_exit;
+	bool support_fw_mac_sequence;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6426a38f8961..780841613bc6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8045,6 +8045,13 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 				ath11k_dbg(ab, ATH11K_DBG_BOOT, "reset success\n");
 			}
 		}
+		if (ar->ab->hw_params.support_fw_mac_sequence) {
+			list_for_each_entry(arvif, &ar->arvifs, list) {
+				if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_STA)
+					ieee80211_hw_restart_disconnect(arvif->vif);
+			}
+		}
+
 	}
 
 	mutex_unlock(&ar->conf_mutex);
-- 
2.38.0

