Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC246D596E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjDDHXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjDDHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:23:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435392D4C;
        Tue,  4 Apr 2023 00:23:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3346B9Gn022550;
        Tue, 4 Apr 2023 07:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=mAzCkR2VqhS11ARx312yaABAYga51ffC2WXsE4hi42Y=;
 b=DnuKvYehH3W8aHPcnIK3Y/X2AC6UbctK/0krYuaNEqZxYGjIUyQh42oRcOnDAU3K5X5H
 YuFu9TLxhX2ufBfAAC4kZ1wXg7cXjMftCQOedNxNX6sWA1hVAlckr3qury0eq2cpL8k2
 nat/8QjWY+3UzW+DjZvU4nQWqf0yOwRQFLkCYl5k0X95eTxg7A/5ixtcrKfDTtMELuds
 EnOfVFFjuK5bZ6uyR7wxsg1IN+KgNhMdtE5U2A0CB8OnFF4TpoVbY4mTAoBo2lWi18U9
 9MyVw2Uj3zD5PJh+y5Zslle411Kh+okw4TaLD+11AG11URZ64GfCLMHDs9yWVc5oRJay 0Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquxtjr1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 07:23:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3347NNWP014135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 07:23:24 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 00:23:21 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 3/3] wifi: ath11k: Populate the signal average field properly
Date:   Tue, 4 Apr 2023 12:52:34 +0530
Message-ID: <20230404072234.18503-4-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230404072234.18503-1-quic_youghand@quicinc.com>
References: <20230404072234.18503-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fKrIbQp3Y7dHpLOoKB1Z-IBlw3vtQ6JM
X-Proofpoint-ORIG-GUID: fKrIbQp3Y7dHpLOoKB1Z-IBlw3vtQ6JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_01,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=860 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040066
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on WCN6750, we are seeing an issue where signal average field
value in station dump is incorrect. Signal average field is populated
without checking for dB to dBm conversion. For WCN6750 devices, the
signal average value is already in dBm units, so no need to convert it
again.

If signal average is valid, then fill it based on dB to dBm conversion
condition to fix this.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..531a881d8623 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8278,7 +8278,7 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
 	struct ath11k *ar = arsta->arvif->ar;
-	s8 signal;
+	s8 signal, signal_avg;
 	bool db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
 			       ar->ab->wmi_ab.svc_map);
 
@@ -8330,9 +8330,12 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
 
-	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi) +
-		ATH11K_DEFAULT_NOISE_FLOOR;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+	signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+	if (signal_avg) {
+		sinfo->signal_avg = db2dbm ? signal_avg : signal_avg + ATH11K_DEFAULT_NOISE_FLOOR;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+	}
+
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.38.0

