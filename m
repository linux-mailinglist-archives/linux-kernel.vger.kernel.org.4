Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62FE707DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjERKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjERKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:16:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7C1BD3;
        Thu, 18 May 2023 03:15:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9lVQa012027;
        Thu, 18 May 2023 10:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=dcN+4220TMTISoGzML+7Qx5uu4pIw0lq+Nsrz+AQF9s=;
 b=ilTWcMv6wyJ+netH2RGWfqy97ClvN0EOJAYomiN24x5o4ukGhH4YM770OvrT1Wx+jZpJ
 xRXwRU0x+7oqchh4+ZatpwMFrkKxkEL+UutrsUoe4WGZA0Ers6E+mM3AQZwf83p3rtvF
 Fz0JFQM3JSIbwT2KsJfO0ZTrbY+FURZlN7DSS70FDVMgPgyyj3Qu0j5LLi/RNnZcSLdj
 8p1gOv4ktbx32tUTIPFTe6xfpmNO+j6FLLIjhHA615H+BBbPeyve4V9aVwDL9xxS2+V/
 /QHhcKex/ML0lhgPy8neZK7j6f8pNCdrAORxJUPuMBXx0I58rzVtW/+FRx6Yp65Dpt8d +A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnc30rnxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:15:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAFpFq004835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:15:51 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:15:49 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH] wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart
Date:   Thu, 18 May 2023 15:45:15 +0530
Message-ID: <20230518101515.3820-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: glgPWhpa2swMSDRImm7wieI1PJNqX3a9
X-Proofpoint-ORIG-GUID: glgPWhpa2swMSDRImm7wieI1PJNqX3a9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, on WCN3990, the station disconnect after hardware recovery is
not working as expected. This is because of setting the
IEEE80211_SDATA_DISCONNECT_HW_RESTART flag very early in the hardware
recovery process even before the driver invokes ieee80211_hw_restart().
On the contrary, mac80211 expects this flag to be set after
ieee80211_hw_restart() is invoked for it to trigger station disconnect.

Set the IEEE80211_SDATA_DISCONNECT_HW_RESTART flag in
ath10k_reconfig_complete() instead to fix this.

The other targets are not affected by this change, since the hardware
params flag is not set.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Fixes: 2c3fc50591ff ("ath10k: Trigger sta disconnect on hardware restart")
Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 9 ---------
 drivers/net/wireless/ath/ath10k/mac.c  | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 533ed7169e11..6cdb225b7eac 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2504,7 +2504,6 @@ EXPORT_SYMBOL(ath10k_core_napi_sync_disable);
 static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
-	struct ath10k_vif *arvif;
 	int ret;
 
 	set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
@@ -2543,14 +2542,6 @@ static void ath10k_core_restart(struct work_struct *work)
 		ar->state = ATH10K_STATE_RESTARTING;
 		ath10k_halt(ar);
 		ath10k_scan_finish(ar);
-		if (ar->hw_params.hw_restart_disconnect) {
-			list_for_each_entry(arvif, &ar->arvifs, list) {
-				if (arvif->is_up &&
-				    arvif->vdev_type == WMI_VDEV_TYPE_STA)
-					ieee80211_hw_restart_disconnect(arvif->vif);
-			}
-		}
-
 		ieee80211_restart_hw(ar->hw);
 		break;
 	case ATH10K_STATE_OFF:
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 9c4bf2fdbc0f..ab12e3e0c515 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8109,6 +8109,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 				     enum ieee80211_reconfig_type reconfig_type)
 {
 	struct ath10k *ar = hw->priv;
+	struct ath10k_vif *arvif;
 
 	if (reconfig_type != IEEE80211_RECONFIG_TYPE_RESTART)
 		return;
@@ -8123,6 +8124,13 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
 		clear_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags);
+		if (ar->hw_params.hw_restart_disconnect) {
+			list_for_each_entry(arvif, &ar->arvifs, list) {
+				if (arvif->is_up && arvif->vdev_type == WMI_VDEV_TYPE_STA)
+					ieee80211_hw_restart_disconnect(arvif->vif);
+				}
+		}
+
 	}
 
 	mutex_unlock(&ar->conf_mutex);
-- 
2.38.0

