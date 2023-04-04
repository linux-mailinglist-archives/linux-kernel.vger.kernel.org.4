Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07646D596A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjDDHX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDDHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:23:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FD2726;
        Tue,  4 Apr 2023 00:23:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3345fKv8004992;
        Tue, 4 Apr 2023 07:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yoO9hOORUgp4tejOSXtitoR4zpiwg+9WL5jAsVzw0/k=;
 b=JNIONuEFJiL+Yg/q8wZnn54KhxzKqOtlKUxE6HdrRH/u4akwBiNLoQnCPgTIOCzOPNCo
 8GaJbPRJpIdss0F/wy/r4fIC6aVsnvWMeYI6MPidJGVSwy8aGiQkzCZZDhYHRlUF6gco
 2+Sp03AUJ3hU55igCw+pzGAUUuVDcNHQKPie29yjNzRokzeLSWV5XgJMFSui+vKKk6MY
 OJN/D5crEKQJTImPgrN3P6lgeE6+NRf/JI/4gnrBCkQ791vnYINTJO8TgwZ07j5yl+Yb
 PfHSLppp5JYrqJ9xlC1Ar5DZSt7Ycy8ZMAqcU9PHmfNEIjmTaNCxw/QB0VLcotrrF5EJ NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquxtjr16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 07:23:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3347NCHr019809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 07:23:13 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 00:23:10 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 1/3] wifi: ath11k: Use proper API to get peer id for WCN6750
Date:   Tue, 4 Apr 2023 12:52:32 +0530
Message-ID: <20230404072234.18503-2-quic_youghand@quicinc.com>
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
X-Proofpoint-GUID: JD2p7Oc9xWhAIZBfuJQb54shoYu7SoNC
X-Proofpoint-ORIG-GUID: JD2p7Oc9xWhAIZBfuJQb54shoYu7SoNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_01,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=942 priorityscore=1501
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
value in station dump is incorrect. This is because of registering an
incorrect mpdu_info_get_peerid() API for WCN6750. Due to this, we get an
invalid peer id while processing the peer stats, and the signal average
field will have invalid values in station dump.

Fix this by registering correct mpdu_info_get_peerid() API for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 60ac215e0678..9321613721a0 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -1122,7 +1122,7 @@ const struct ath11k_hw_ops wcn6750_ops = {
 	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_wcn6855_reo_setup,
-	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
+	.mpdu_info_get_peerid = ath11k_hw_wcn6855_mpdu_info_get_peerid,
 	.rx_desc_mac_addr2_valid = ath11k_hw_ipq9074_rx_desc_mac_addr2_valid,
 	.rx_desc_mpdu_start_addr2 = ath11k_hw_ipq9074_rx_desc_mpdu_start_addr2,
 	.get_ring_selector = ath11k_hw_wcn6750_get_tcl_ring_selector,
-- 
2.38.0

