Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF96654136
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiLVMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiLVMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:43:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660625E85;
        Thu, 22 Dec 2022 04:43:34 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMAn5Qn007102;
        Thu, 22 Dec 2022 12:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4Hkgp5mqnwYGMLAnV4qH/U21gdaKpSgaflWbxhX8fhk=;
 b=E9TS/Zc+EYzbZIvW1UGJ3hD+eiYb4Y6/421Vab2fbnPIN4NW8WzpSLKzRCdvSaoYqlpG
 +Z6etqqkBRb/eEnJPHGBNB/SM8NE8yoXhgj24q5oY99EKbUkEPUK7prqumKc5zVXJjNA
 BayjvO8iFtNcZJMc3SE86oDAJmKkzK7Nb5vQal0l7XP2q8JV+4LmZNUKVsgY326NbgF8
 lBFJG/x+h/qcnVHAMKSljQ06Wq+gv1YX+SlooEMDMT23piSYeK0rCBuz+IPKHYlotuWI
 w2Y48A3BrBjKrlH+B2ofYT65bk1uMArzOZv3X+uAQnZcrBL9KEjMBukOSCaPIzu2ux2v wA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk83xwvxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BMChHq2020906
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:43:17 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 04:43:14 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH 1/2] wifi: cfg80211: Add beacon hint notifier support
Date:   Thu, 22 Dec 2022 18:12:20 +0530
Message-ID: <20221222124221.30894-2-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221222124221.30894-1-quic_youghand@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RGea825zRoHe3_Ml7V84IKaS5X6xfbqA
X-Proofpoint-GUID: RGea825zRoHe3_Ml7V84IKaS5X6xfbqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_06,2022-12-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are connection failures in hidden SSID case when the device is
with default reg domain WW.
For WW reg domain most of the 5 GHz channels are passive. When device
listens to the beacon on that channel, the driver is updating its
channel flag but firmware is not aware of it and firmware is not
sending probes on that channels.
Due to this, we are seeing connection failures when the device is trying
to connect with hidden SSID AP.

In the case of devices using the ath10k driver, it is required to update
the change in channel flags to firmware as well. Therefore, we need a
mechanism to notify the driver from the regulatory core regarding the
channel flag changes.
Adding a beacon hint notifier logic, so that drivers can register
callbacks to get notified whenever there is a change in channel flags.

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 include/net/cfg80211.h | 2 ++
 net/wireless/reg.c     | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..07b2f2da77d6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5386,6 +5386,8 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	void (*beacon_hint_notifier)(struct wiphy *wiphy);
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c3d950d29432..6ea2455d4964 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2219,8 +2219,11 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 		channel_changed = true;
 	}
 
-	if (channel_changed)
+	if (channel_changed) {
 		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
+		if (wiphy->beacon_hint_notifier)
+			wiphy->beacon_hint_notifier(wiphy);
+	}
 }
 
 /*
-- 
2.38.0

