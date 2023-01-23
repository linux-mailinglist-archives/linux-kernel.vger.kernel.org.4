Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD6F677512
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAWGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWGJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:09:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2034.outbound.protection.outlook.com [40.92.40.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE996166F9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgC1yiJa07KACk0mHx9gWQuU9vEEBFReLrKX/qFOnjluLqtrjnWHGoJTJQdAxPeEl63CUxuWIg4xtAHLWIVCf6eGdbUHtktByoQ5BJK1o6S83nAM/ElgDReTM3Jn7dAMOZ0eJ0HD/gUG+byPKyTPIa/THre0ZdKhTQjaLfhrXFHlmwm6xy9IH6CWs2aGF4KJhuBgQfwRDtwCU3xFJZ0PxbucySDSKXoV4S0P61sm1xQFsCnxeFTkJ/4NmsCqpAS9r9xK40LF8oH/p1uYrZmPV90SNPreZNp01zD/wJ28oai0wvVE3H2Wip5s/5LtqboH0p2RSuiPjSd7RXmvPWbPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF8IWSMGAUNIJhq11k/2x30mfSQeXR3mQZfd4Kiyglo=;
 b=lEEmDoGCOoydU7rFTYcIqZXOkU8w6m3SXzuTPf+l6ZPOirq1LQsHkhpoVmvl+PDprwBa2Y/Rh5NzGIyw1hHRaCsng28ES+D5umCeMNA/fC09D8y8ZPiH/bAG67EJxxKTXEjoTyZwVKSqwxm9YP5/uNq4MjbZZJhJfQSq23Q37RpGw+EQu6YIgtFkaMby4iFFrt7f3Tm0RT+hxcbHSih4L9PRwjW0CUfNIPu7gpRMcHCxzBeCx+xBPn/qNm1k5aQn98LOlH0GsM5tz3MOvZqJHwLZY7vLlQluAkQQ6UYUR0o35r+6ZXpYwPZK78Xo1MYQztdpBiw64JeCwWkZxYMdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF8IWSMGAUNIJhq11k/2x30mfSQeXR3mQZfd4Kiyglo=;
 b=ncMlWei/P3xuPVep1lwSuI975D1IPl8gOqc8xNzFjLyABoFyFk7WoUdEalZQkVca+rbXU9IiXoAegckdJ5yQVie2H8tA+7sHSsknz6mb7Yvo1rVRMIXXdgcYkY6ablVKsNbBNTdTGYY2iWGL3D6lcR33GtH7DbKw9PlngXkZIuy48Ua0lI8zDjjGGuuy/YtZvYkwLXQFqOBjsXF/zmT+5lPIAHXJUIQtedZxJWvWFIEWBaCbwiCyD41aU/ePlnKl4QU7YaruusTuWykdkdTN+0cTZvz1SSI7gzwsAzRw36jdCAgKUfFGL0JiJKkQZMY3w7+urOTa9O8lIIQxdg8ANQ==
Received: from BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 06:09:53 +0000
Received: from BL3PR12MB6402.namprd12.prod.outlook.com
 ([fe80::8d5c:4991:4b5e:ebb]) by BL3PR12MB6402.namprd12.prod.outlook.com
 ([fe80::8d5c:4991:4b5e:ebb%5]) with mapi id 15.20.6002.028; Mon, 23 Jan 2023
 06:09:53 +0000
Message-ID: <BL3PR12MB64020697013B84078A494080A9C89@BL3PR12MB6402.namprd12.prod.outlook.com>
Subject: [PATCH] staging: rtl8723bs: formatting cleanup ieee80211.h
From:   damay <damay27@outlook.com>
To:     "<gregkh@linuxfoundation.org> <gustavoars@kernel.org> "
         "<namcaov@gmail.com> <keescook@chromium.org> "
         "<linux-staging@lists.linux.dev>" <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Jan 2023 06:09:50 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-TMN:  [5Kkb8n3pcGlz7Bmq8VUdxe9TLUPHrjSS]
X-ClientProxiedBy: PH0PR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:510:f::31) To BL3PR12MB6402.namprd12.prod.outlook.com
 (2603:10b6:208:3b2::17)
X-Microsoft-Original-Message-ID: <a2c5abaa6370e6c69d1c1c1b4a45adb5fa1f6286.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6402:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fb5138-0b74-4a57-62cf-08dafd087154
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vg1pSy2DBkMHAc5oU9tMJtXys4WAACrswHSKn3Wk6eLezCP0EfWwDuLpJjTqRih1hE++3QuC5A35MI4WoowowCMJEBtHLXkdAspDh0s0a6Gn15Usm4HghlzP2CIPIlzx3fJgXow2oRC+cmcK7S0Tnjzm0v+xtuKkFQ6N2wTS/joDdcSVXcCfSwRdU6FV/1kkQbohh1FWgj/pGyguARnEWge3SJfg0W4fx3lxryAkJQSwTLdFA2zVnaYr+kJIb7CezcWDI4UOqNcLXGI8Ni8GaQV669my37V4rb+R4PVIfUIHLe77B67DWk7r5e1/mxYxtiZXVdujTekM/JZiSG4zHW8VFnNvWe1WUps2T/MJtsI+/cfqXfBVO06GMw7wR6avjMXYj5+CymZPJtvM8X5UtK9URR+c/OOqPibAmEmg6OPuQ53bgvD2i+bGlB6nKnT8u2LOImUxvltH/NSlEw1MJ+eP6LsnR3vj/3p83Mi11g2C2YXLSES8BqZIqIFGd7bvXcBnQf5C9bLalAKYnvSF00Bp8831AbS6ST7lg+5Hd2A7wIb7dTi+vC4gaNcwFf1iMg6hZSvHBINjx3tbpuPRaO42dtei+5j6+kJnqGVIZ0Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dFNFd0enYvSHRzblk4bFhxbGxWVjJMT1A0dEFndUs4eXNvLzlXS0R0YWU1?=
 =?utf-8?B?L1BGc0tyU21SbGtmNWJ5Zk5Dc3gxMTRteWZjQnhxVWlHOVgzTXM4ODQxamV2?=
 =?utf-8?B?bDQveE1hY0k1bjk0YVlTSGlRaVZJOUhMa1hSaWM1QkVhTEVNaE0rNE12cnVO?=
 =?utf-8?B?WjcrcGVXYnRzdmF5UldTNUw2RWhyWkJRMnpGNW9Tc0d4Z0xyTnpxY052TGVP?=
 =?utf-8?B?L2tLVTVIZmRBakd3TU05NDFPaDNqNE9WSHpMVkxwZFgrSGZmT25mMlI3UXVo?=
 =?utf-8?B?Q1ZsaGFRRDN3ZUg4Y3YvWjJSZ2lTQUVHWUU0T3p5K0daMCs1LzU0TXJZYWZP?=
 =?utf-8?B?Q3VsYm9KeUFqeFJnRHNFTnFuVEY1RE1LaEZoR2k2ZEhrVEpzZjRHMkFIaDBB?=
 =?utf-8?B?YXNjMElHemNuSUVaNjh4OE5VMmpobEdQWFR1YkRpNjA3UXZycFdsbGlhc3RH?=
 =?utf-8?B?MGJzZi9xY2ZMcUFFNU44U0liM1NoMk9kWkFDd0RRYWI4WlN3NGxPa21STlVG?=
 =?utf-8?B?eWFaaFl4ZytwYU9zTUlSUVdaMDY4TW1qcTBJaU40c0poemVlQnNDd1ozTmdD?=
 =?utf-8?B?Zng0SzdZcXhvS3VPb3dvVkszTGtLQlVnUkZTWkVqT1FMYzRyaHJCaHNTaFNu?=
 =?utf-8?B?WVJzU2ExcFdFOUNWN1JDMU0zVnk5aldGbm83RHhVZ2MrRjFDa3JXYkNmOUwr?=
 =?utf-8?B?RmtGSGhPZU0vWkc5cG1SRXZrZXZCbDhOS0lXMlI2czZBZno5QlQrUThXOEJZ?=
 =?utf-8?B?UXA5MDBaK1lLOWw5ZjJpK2FUQnp6ZXdaejR0TEpRZTlHazUwclZHVjk4Sjhk?=
 =?utf-8?B?TmF4d29WMkloVEVWNElRVkw2aEN6a2hFVUpRNTFLZ0FzeTN5S3ljbUVBbFR5?=
 =?utf-8?B?YTVJN3VCeS9iSHYyYzd5M1MrOC9Vek12UFV1aDk5bENxUFEzRDh4WkFrNDN0?=
 =?utf-8?B?NGdWQSswQTJuYXpmNFZBNytScldsdkc1L3JFNjFFZ0draG1Ja0RJWFRvRXdi?=
 =?utf-8?B?RU43S05ub2dQbi9wSjhORFFNL3oySGFKWHdXNktGNUk0dlJ3cDNsZjRCNUow?=
 =?utf-8?B?SUZmR3hRZExHeFA2MW1GdjlhYlBUWHFJOTNUY0pqaytXQVFPWmV3WVdNSzUv?=
 =?utf-8?B?ZVYydGkvaW1jQkRWWnMrRWdCdU5yZ25STG9vK3J3VDk3M1NlM203ZDZ6UE81?=
 =?utf-8?B?RDZPZjNubmk3K21vQ1dnOS9WaGVMOFRHSjhKdnQyWEtXSUhHUVIrbWx2bXMy?=
 =?utf-8?B?MndMZ0RURVdUR2VvcGN0TTVwd1JmbnloMkk0YlozSHo3VUpKMisyKzhycXVi?=
 =?utf-8?B?VXFlM2lLOGV1MVliMkNCN1R0VlN5TWE5MXYvK2ZodmZhWFhkMVFVdG5GOWtG?=
 =?utf-8?B?TGRtM0hPa0w4YWJsRVFBWW5KNjVWUW5pWnMyM1Z2SHorclVtakJTQ0MxRzRS?=
 =?utf-8?B?WkpQcldudWM3ZTAvZHVrQTFyaGU5dVBOLzhHUExWekVFMWZrU2J5Q1NsbUdo?=
 =?utf-8?B?Y0w2dFBITFJCcGVJdUJWMVBoamVIOXhSTnc5QmU1aWJNeGY3K2dFYnZjVFRu?=
 =?utf-8?B?SWo3ZXNZWE00SEtqUzh3QmI3Q0xNRDZBTk5IOXZMZUF5S0hKbE56YndWRVJK?=
 =?utf-8?B?a3J5RzZweE5rcmYwK3IzTUhGNGdVaXRPTlVpcHNyb0VUcmg3d3hqWGJ1aEpZ?=
 =?utf-8?B?UGpzNTZ6QWxRZWJFY2pUc2FPdlgrT1hZSEZ6OXVFUXAwSWw2WUtJcGNnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fb5138-0b74-4a57-62cf-08dafd087154
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 06:09:53.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 558248b0ce349c63e908b69f45c7ae74a4413669 Mon Sep 17 00:00:00 2001
From: Daniel May <damay27@outlook.com>
Date: Mon, 23 Jan 2023 05:12:37 +0000
Subject: [PATCH] staging: rtl8723bs: formatting cleanup ieee80211.h

General formatting changes.

Signed-off-by: Daniel May <damay27@outlook.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 107 ++++++++++--------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 9041d8dc5fb1..1753fe841d6a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -174,7 +174,7 @@ struct ieee_param {
 			u8 reserved[32];
 			u8 data[];
 		} wpa_ie;
-	        struct{
+		struct{
 			int command;
 			int reason_code;
 		} mlme;
@@ -232,7 +232,7 @@ struct eapol {
 	u8 version;
 	u8 type;
 	u16 length;
-} __attribute__ ((packed));
+} __packed;
 
 #define IEEE80211_FCS_LEN    4
 
@@ -271,11 +271,11 @@ struct eapol {
 #define P80211_OUI_LEN 3
 
 struct ieee80211_snap_hdr {
-        u8    dsap;   /* always 0xAA */
-        u8    ssap;   /* always 0xAA */
-        u8    ctrl;   /* always 0x03 */
-        u8    oui[P80211_OUI_LEN];    /* organizational universal id */
-} __attribute__ ((packed));
+	u8    dsap;   /* always 0xAA */
+	u8    ssap;   /* always 0xAA */
+	u8    ctrl;   /* always 0x03 */
+	u8    oui[P80211_OUI_LEN];    /* organizational universal id */
+} __packed;
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
 
@@ -346,8 +346,8 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_CCK_BASIC_RATES_MASK	(IEEE80211_CCK_RATE_1MB_MASK | \
 	IEEE80211_CCK_RATE_2MB_MASK)
 #define IEEE80211_CCK_DEFAULT_RATES_MASK	(IEEE80211_CCK_BASIC_RATES_MASK | \
-        IEEE80211_CCK_RATE_5MB_MASK | \
-        IEEE80211_CCK_RATE_11MB_MASK)
+	IEEE80211_CCK_RATE_5MB_MASK | \
+	IEEE80211_CCK_RATE_11MB_MASK)
 
 #define IEEE80211_OFDM_RATES_MASK		0x00000FF0
 #define IEEE80211_OFDM_BASIC_RATES_MASK	(IEEE80211_OFDM_RATE_6MB_MASK | \
@@ -360,7 +360,7 @@ struct ieee80211_snap_hdr {
 	IEEE80211_OFDM_RATE_48MB_MASK | \
 	IEEE80211_OFDM_RATE_54MB_MASK)
 #define IEEE80211_DEFAULT_RATES_MASK (IEEE80211_OFDM_DEFAULT_RATES_MASK | \
-                                IEEE80211_CCK_DEFAULT_RATES_MASK)
+				IEEE80211_CCK_DEFAULT_RATES_MASK)
 
 #define IEEE80211_NUM_OFDM_RATES	    8
 #define IEEE80211_NUM_CCK_RATES	            4
@@ -399,12 +399,14 @@ enum {
 
 /* NOTE: This data is for statistical purposes; not all hardware provides this
  *       information for frames received.  Not setting these will not cause
- *       any adverse affects. */
+ *       any adverse affects.
+ */
 
 /* IEEE 802.11 requires that STA supports concurrent reception of at least
  * three fragmented frames. This define can be increased to support more
  * concurrent frames, but it should be noted that each entry can consume about
- * 2 kB of RAM and increasing cache size will slow down frame reassembly. */
+ * 2 kB of RAM and increasing cache size will slow down frame reassembly.
+ */
 #define IEEE80211_FRAG_CACHE_LEN 4
 
 #define SEC_KEY_1         (1<<0)
@@ -430,19 +432,32 @@ enum {
 #define BIP_AAD_SIZE  20
 
 /*
+ * 802.11 data frame from AP
+ *
+ *       ,-------------------------------------------------------------------.
+ * Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
+ *       |------|------|---------|---------|---------|------|---------|------|
+ * Desc. | ctrl | dura |  DA/RA  |   TA    |    SA   | Sequ |  frame  |  fcs |
+ *       |      | tion | (BSSID) |         |         | ence |  data   |      |
+ *       `-------------------------------------------------------------------'
+ *
+ * Total: 28-2340 bytes
+ *
+ */
 
- 802.11 data frame from AP
-
-      ,-------------------------------------------------------------------.
-Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
-      |------|------|---------|---------|---------|------|---------|------|
-Desc. | ctrl | dura |  DA/RA  |   TA    |    SA   | Sequ |  frame  |  fcs |
-      |      | tion | (BSSID) |         |         | ence |  data   |      |
-      `-------------------------------------------------------------------'
-
-Total: 28-2340 bytes
-
-*/
+/*
+ * 802.11 data frame from AP
+ *
+ *       ,-------------------------------------------------------------------.
+ * Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
+ *       |------|------|---------|---------|---------|------|---------|------|
+ * Desc. | ctrl | dura |  DA/RA  |   TA    |    SA   | Sequ |  frame  |  fcs |
+ *       |      | tion | (BSSID) |         |         | ence |  data   |      |
+ *       `-------------------------------------------------------------------'
+ *
+ * Total: 28-2340 bytes
+ *
+ */
 
 #define BEACON_PROBE_SSID_ID_POSITION 12
 
@@ -466,7 +481,8 @@ Total: 28-2340 bytes
 /* MAX_RATES_LENGTH needs to be 12.  The spec says 8, and many APs
  * only use 8, and then use extended rates for the remaining supported
  * rates.  Other APs, however, stick all of their supported rates on the
- * main rates information element... */
+ * main rates information element...
+ */
 #define MAX_RATES_LENGTH                  ((u8)12)
 #define MAX_RATES_EX_LENGTH               ((u8)16)
 #define MAX_NETWORK_COUNT                  128
@@ -496,11 +512,11 @@ Total: 28-2340 bytes
 #define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST
 #define IW_ESSID_MAX_SIZE 32
 /*
-join_res:
--1: authentication fail
--2: association fail
-> 0: TID
-*/
+ * join_res:
+ * -1: authentication fail
+ * -2: association fail
+ * > 0: TID
+ */
 
 #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
 #define DEFAULT_FTS 2346
@@ -509,18 +525,18 @@ Total: 28-2340 bytes
 
 static inline int is_multicast_mac_addr(const u8 *addr)
 {
-        return ((addr[0] != 0xff) && (0x01 & addr[0]));
+	return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
 static inline int is_broadcast_mac_addr(const u8 *addr)
 {
-	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
+	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
 static inline int is_zero_mac_addr(const u8 *addr)
 {
-	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
+	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
 }
 
@@ -572,8 +588,8 @@ enum {
 	ACT_PUBLIC_MAX
 };
 
-#define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs)
-				* 00:50:F2 */
+#define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs) */
+
 #define WME_OUI_TYPE 2
 #define WME_OUI_SUBTYPE_INFORMATION_ELEMENT 0
 #define WME_OUI_SUBTYPE_PARAMETER_ELEMENT 1
@@ -612,17 +628,17 @@ enum {
  * @RTW_IEEE80211_CHAN_NO_HT40MINUS: extension channel below this channel
  *      is not permitted.
  */
-  enum rtw_ieee80211_channel_flags {
-          RTW_IEEE80211_CHAN_DISABLED         = 1<<0,
-          RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
-          RTW_IEEE80211_CHAN_NO_IBSS          = 1<<2,
-          RTW_IEEE80211_CHAN_RADAR            = 1<<3,
-          RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
-          RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
-  };
+enum rtw_ieee80211_channel_flags {
+		RTW_IEEE80211_CHAN_DISABLED         = 1 << 0,
+		RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1 << 1,
+		RTW_IEEE80211_CHAN_NO_IBSS          = 1 << 2,
+		RTW_IEEE80211_CHAN_RADAR            = 1 << 3,
+		RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1 << 4,
+		RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1 << 5,
+	};
 
   #define RTW_IEEE80211_CHAN_NO_HT40 \
-          (RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
+		(RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
 
 /* Represent channel details, subset of ieee80211_channel */
 struct rtw_ieee80211_channel {
@@ -653,7 +669,7 @@ struct rtw_ieee80211_channel {
 	/*"orig_mpwr:%d\n"*/
 
 #define CHAN_ARG(channel) \
-	/*(channel)->band*/ \
+	(/*(channel)->band*/ \
 	/*, (channel)->center_freq*/ \
 	(channel)->hw_value \
 	, (channel)->flags \
@@ -664,6 +680,7 @@ struct rtw_ieee80211_channel {
 	/*, (channel)->orig_flags*/ \
 	/*, (channel)->orig_mag*/ \
 	/*, (channel)->orig_mpwr*/ \
+	)
 
 /* Parsed Information Elements */
 struct rtw_ieee802_11_elems {
-- 
2.25.1


