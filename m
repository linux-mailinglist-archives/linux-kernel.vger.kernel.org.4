Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701646A7F34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCBJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCBJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:56:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB062B62C;
        Thu,  2 Mar 2023 01:56:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229Y9L0007938;
        Thu, 2 Mar 2023 09:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=MTsgqO7xP3p9rwDXfqj5sodizXPDanLo7GrBOLQSl88=;
 b=hpO0dG81ZQdeRzaI/JymlVYxAeq2oxjSsfZ2s6VTt1bsox6PqFKdeteJFJtICZsxdLTP
 fUCetmjOohctHequfh0mvYXjLGetBlTw85UwxCyw2wEg6rrN9LGGXMzotoB1aBXrhRy7
 dRHVs7ewAIWAjAgZA0gP9OB8WX/XVHnbOzKU1Rop5JZQ/vvd40gpIWUP2Q90zCicshwI
 3A3HXU/nzbYadGJFun8GzY2SG4vtCEjIBz5ldhNu4DxNBCAdFsVNLuhGtIhH2VCOTSNU
 eCDi5CGrk+zAAnW3kM5nj0ry+Dwx+oU/fRJiVKOROAB5NvMrk5Npz3yILTPcbFwQ9H2W GQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2rbg86ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 09:56:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3229uSXI004698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 09:56:28 GMT
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 01:56:25 -0800
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mpubbise@qti.qualcomm.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH v2 1/2] wifi: cfg80211: Add beacon hint notifier support
Date:   Thu, 2 Mar 2023 15:25:50 +0530
Message-ID: <20230302095551.5510-2-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230302095551.5510-1-quic_youghand@quicinc.com>
References: <20230302095551.5510-1-quic_youghand@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: khrtZ2QWnlU6W8nzttTmPGbLgJ-54qY5
X-Proofpoint-ORIG-GUID: khrtZ2QWnlU6W8nzttTmPGbLgJ-54qY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 include/net/cfg80211.h | 7 +++++++
 net/wireless/reg.c     | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..7a00f5317e1f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5096,6 +5096,10 @@ struct wiphy_iftype_akm_suites {
  * @reg_notifier: the driver's regulatory notification callback,
  *	note that if your driver uses wiphy_apply_custom_regulatory()
  *	the reg_notifier's request can be passed as NULL
+ * @beacon_hint_notifier: the driver's beacon hint notification callback,
+ *	which will trigger when there is channel flag updates seen in
+ *	beacon hints. The beacon_hint_notifier's request can be passed
+ *	with chan context.
  * @regd: the driver's regulatory domain, if one was requested via
  *	the regulatory_hint() API. This can be used by the driver
  *	on the reg_notifier() if it chooses to ignore future
@@ -5386,6 +5390,9 @@ struct wiphy {
 	void (*reg_notifier)(struct wiphy *wiphy,
 			     struct regulatory_request *request);
 
+	void (*beacon_hint_notifier)(struct wiphy *wiphy,
+				     struct ieee80211_channel *chan);
+
 	/* fields below are read-only, assigned by cfg80211 */
 
 	const struct ieee80211_regdomain __rcu *regd;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c3d950d29432..2dc6880a28c5 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2219,8 +2219,11 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 		channel_changed = true;
 	}
 
-	if (channel_changed)
+	if (channel_changed) {
 		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
+		if (wiphy->beacon_hint_notifier)
+			wiphy->beacon_hint_notifier(wiphy, chan);
+	}
 }
 
 /*
-- 
2.38.0

