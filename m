Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58916CF010
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjC2RCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjC2RCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:02:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2277C19B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:02:06 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TGc3Oj016818;
        Wed, 29 Mar 2023 17:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zCQXXN/Wg/wEu1S1v8j4TpZIT3LNu+b8cRHAKfjnjsE=;
 b=e1VhNwFRYMSHVWP46mjifY/yShJkBO8rR3yIxAH4laFhLpSqXRT1yB4fTWoMaFZBqMOq
 bPMdsf9d8hQCWFZ/JmuPBGxb/MOhTIoh6TnTKnfuLtwmqGG3+lS2REs8o/9G28pQjvos
 WwH7JZxDS+bG7pJf26hmLbvjfEVvBlKg6u/kgOFEB5SGHalrfffuV8CiGvNKT9rQYmiN
 naxpwN4jkTgCDGecoO+/Zzfs1s0PNuXQ506BXSMgzoqpmmEFaLhic2MOAlB2HDQaraxs
 7orDSWsMZPXzn8eo0lv71CoSVcyg9PF+XdMoCLxyxA+pepCJhnwePp4DrM1ATmIE4BQ4 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmkg1txkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:02:02 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TGoPvu026159;
        Wed, 29 Mar 2023 17:02:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmkg1txjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:02:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SKcNUn019495;
        Wed, 29 Mar 2023 17:01:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6n5rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH1v3p29950346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F1220040;
        Wed, 29 Mar 2023 17:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C22F2004E;
        Wed, 29 Mar 2023 17:01:55 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:55 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 4/5] staging: r8188eu: Replace "<<" with BIT macro
Date:   Wed, 29 Mar 2023 22:31:38 +0530
Message-Id: <47bfa0e878fc33bed59f7835f9beafd7cb0f326f.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
References: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pi6KnU2bB0OgtVm1k0SkXps0khNAQ-50
X-Proofpoint-ORIG-GUID: PRcOeq9A1DFaJ10RNiKt6upVjoz_8P2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290128
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the "<<" operator with BIT macro, in accordance to the
checkpatch.pl script and Linux kernel coding-style guidelines.

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 82 ++++++++++-----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index e7a4f8af497a..4b58bd782944 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -300,15 +300,15 @@ struct ieee80211_snap_hdr {
 
 #define WLAN_AUTH_CHALLENGE_LEN 128
 
-#define WLAN_CAPABILITY_BSS (1<<0)
-#define WLAN_CAPABILITY_IBSS (1<<1)
-#define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
-#define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
-#define WLAN_CAPABILITY_PRIVACY (1<<4)
-#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
-#define WLAN_CAPABILITY_PBCC (1<<6)
-#define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
-#define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
+#define WLAN_CAPABILITY_BSS BIT(0)
+#define WLAN_CAPABILITY_IBSS BIT(1)
+#define WLAN_CAPABILITY_CF_POLLABLE BIT(2)
+#define WLAN_CAPABILITY_CF_POLL_REQUEST BIT(3)
+#define WLAN_CAPABILITY_PRIVACY BIT(4)
+#define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
+#define WLAN_CAPABILITY_PBCC BIT(6)
+#define WLAN_CAPABILITY_CHANNEL_AGILITY BIT(7)
+#define WLAN_CAPABILITY_SHORT_SLOT BIT(10)
 
 /* Status codes */
 #define WLAN_STATUS_SUCCESS 0
@@ -382,17 +382,17 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_DATA_HDR3_LEN 24
 #define IEEE80211_DATA_HDR4_LEN 30
 
-#define IEEE80211_STATMASK_SIGNAL (1<<0)
-#define IEEE80211_STATMASK_RSSI (1<<1)
-#define IEEE80211_STATMASK_NOISE (1<<2)
-#define IEEE80211_STATMASK_RATE (1<<3)
+#define IEEE80211_STATMASK_SIGNAL BIT(0)
+#define IEEE80211_STATMASK_RSSI BIT(1)
+#define IEEE80211_STATMASK_NOISE BIT(2)
+#define IEEE80211_STATMASK_RATE BIT(3)
 #define IEEE80211_STATMASK_WEMASK 0x7
 
 #define IEEE80211_CCK_MODULATION    (1<<0)
 #define IEEE80211_OFDM_MODULATION   (1<<1)
 
-#define IEEE80211_24GHZ_BAND     (1<<0)
-#define IEEE80211_52GHZ_BAND     (1<<1)
+#define IEEE80211_24GHZ_BAND     BIT(0)
+#define IEEE80211_52GHZ_BAND     BIT(1)
 
 #define IEEE80211_CCK_RATE_LEN			4
 #define IEEE80211_NUM_OFDM_RATESLEN	8
@@ -412,18 +412,18 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_OFDM_RATE_54MB		0x6C
 #define IEEE80211_BASIC_RATE_MASK		0x80
 
-#define IEEE80211_CCK_RATE_1MB_MASK		(1<<0)
-#define IEEE80211_CCK_RATE_2MB_MASK		(1<<1)
-#define IEEE80211_CCK_RATE_5MB_MASK		(1<<2)
-#define IEEE80211_CCK_RATE_11MB_MASK		(1<<3)
-#define IEEE80211_OFDM_RATE_6MB_MASK		(1<<4)
-#define IEEE80211_OFDM_RATE_9MB_MASK		(1<<5)
-#define IEEE80211_OFDM_RATE_12MB_MASK		(1<<6)
-#define IEEE80211_OFDM_RATE_18MB_MASK		(1<<7)
-#define IEEE80211_OFDM_RATE_24MB_MASK		(1<<8)
-#define IEEE80211_OFDM_RATE_36MB_MASK		(1<<9)
-#define IEEE80211_OFDM_RATE_48MB_MASK		(1<<10)
-#define IEEE80211_OFDM_RATE_54MB_MASK		(1<<11)
+#define IEEE80211_CCK_RATE_1MB_MASK		BIT(0)
+#define IEEE80211_CCK_RATE_2MB_MASK		BIT(1)
+#define IEEE80211_CCK_RATE_5MB_MASK		BIT(2)
+#define IEEE80211_CCK_RATE_11MB_MASK		BIT(3)
+#define IEEE80211_OFDM_RATE_6MB_MASK		BIT(4)
+#define IEEE80211_OFDM_RATE_9MB_MASK		BIT(5)
+#define IEEE80211_OFDM_RATE_12MB_MASK		BIT(6)
+#define IEEE80211_OFDM_RATE_18MB_MASK		BIT(7)
+#define IEEE80211_OFDM_RATE_24MB_MASK		BIT(8)
+#define IEEE80211_OFDM_RATE_36MB_MASK		BIT(9)
+#define IEEE80211_OFDM_RATE_48MB_MASK		BIT(10)
+#define IEEE80211_OFDM_RATE_54MB_MASK		BIT(11)
 
 #define IEEE80211_CCK_RATES_MASK		0x0000000F
 #define IEEE80211_CCK_BASIC_RATES_MASK	(IEEE80211_CCK_RATE_1MB_MASK | \
@@ -458,15 +458,15 @@ struct ieee80211_snap_hdr {
  * 2 kB of RAM and increasing cache size will slow down frame reassembly. */
 #define IEEE80211_FRAG_CACHE_LEN 4
 
-#define SEC_KEY_1	(1<<0)
-#define SEC_KEY_2	(1<<1)
-#define SEC_KEY_3	(1<<2)
-#define SEC_KEY_4	(1<<3)
-#define SEC_ACTIVE_KEY  (1<<4)
-#define SEC_AUTH_MODE   (1<<5)
-#define SEC_UNICAST_GROUP (1<<6)
-#define SEC_LEVEL	(1<<7)
-#define SEC_ENABLED     (1<<8)
+#define SEC_KEY_1	BIT(0)
+#define SEC_KEY_2	BIT(1)
+#define SEC_KEY_3	BIT(2)
+#define SEC_KEY_4	BIT(3)
+#define SEC_ACTIVE_KEY  BIT(4)
+#define SEC_AUTH_MODE   BIT(5)
+#define SEC_UNICAST_GROUP BIT(6)
+#define SEC_LEVEL	BIT(7)
+#define SEC_ENABLED     BIT(8)
 
 #define SEC_LEVEL_0      0 /* None */
 #define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
@@ -550,9 +550,9 @@ Total: 28-2340 bytes
 #define MAX_P2P_IE_LEN (256)
 #define MAX_WFD_IE_LEN (128)
 
-#define NETWORK_EMPTY_ESSID (1<<0)
-#define NETWORK_HAS_OFDM    (1<<1)
-#define NETWORK_HAS_CCK     (1<<2)
+#define NETWORK_EMPTY_ESSID BIT(0)
+#define NETWORK_HAS_OFDM    BIT(1)
+#define NETWORK_HAS_CCK     BIT(2)
 
 #define IEEE80211_DTIM_MBCAST 4
 #define IEEE80211_DTIM_UCAST 2
@@ -584,8 +584,8 @@ static inline int is_broadcast_mac_addr(const u8 *addr)
 	       (addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff);
 }
 
-#define CFG_IEEE80211_RESERVE_FCS (1<<0)
-#define CFG_IEEE80211_COMPUTE_FCS (1<<1)
+#define CFG_IEEE80211_RESERVE_FCS BIT(0)
+#define CFG_IEEE80211_COMPUTE_FCS BIT(1)
 
 #define MAXTID	16
 
-- 
2.31.1

