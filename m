Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027FB7151CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjE2WVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjE2WVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:21:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42897D9;
        Mon, 29 May 2023 15:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMzfX0XvPoFwNsXJngJaSecoGvjI0J84HZylrDzxrad+sl89wcD5aJiYCqsn1ENhZlTfcZYw05em/a0ECdus+NzIAm6xBlqn+xKh9+4SMccdDzn31U/6ZVEFb2e9kSKC8fvamqBC4YRQB/yZZPt3du63IN4GHFFj7Zmbh58dQtku+rAgSbQTG18i8jSAFgn8UhGIt5aHMdyveFBAEaPxLeZnmULOPfpnwmtkSWXIhHe9YFvA3oJko9k4WcdvpJZD99SA5cOoVPai8qUHJmIm+YaJNWiQglNynYYh2DKc+4tV6FjhzLbk2WEsvXNDXF0+y20ijup1WKZu+vobPGxV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUe8hSLSkY6kC/+7P2GtOEmkhIVmW9KSZfXa6hRn4Ck=;
 b=Lf7jDt5WKG0acHlxdJG/GBhLqMsWsJByDQPx5J2dfgVzbBbeLiGUL/09Za2rFWvjx4/0z1Znc0bjmm8zT4erWW+h90WkxAEQlKWKWIpYMt/AYS50Uo6saq25N8K+/kN4iLDWmc5PiXUEBLd7qqTtFUVjQ4Z6FvhG/HXaE+ycg0/r4XolU6RCSWq/c8OqQHZyIBZPSr+E4VnIFDhAaJ2vkKULcmgLaYea4E2KV5NWexqqqy4clGzq5TxDrDu9QRL6p4xGBd1pNlUClrerO2h+SppTD6pssAvtsSDaSoqFNBSFhmjyOy0Z22O9y4+53ma3ILrgEbz+Vh3yN8vWmYZuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUe8hSLSkY6kC/+7P2GtOEmkhIVmW9KSZfXa6hRn4Ck=;
 b=qKgDYRASL9hWUjcH+xuwchrI35zTUUAuw3hVCRc+p8sZ65V7H6RLNKxtHzXgxduCMuUcShkAY+JdV+P9u8S2RFkShLBvzQqbNFwG1eyfacpOvPDUgfk9vDpoSic477IrmxZcNyADG25Yj2D/eg3q//FZWZcWsAEWaOQrA0gbOPkQIrZ3NzVWi7NzrkGepRy/qTtWuA7q+eNAGrJDOOS7RP3t27fr3Tgb4FbpOsPq91IkkvEZEEhdUG/mRcaQHtvhnfgytPbNVY7ytHZ55rsU1ZS2n1st3XaOMBdpQI4cYVdXppDMiuFBRVl34qwdAZR8lxMf5BPLNJfaFM8vFAiAgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 22:21:04 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1%5]) with mapi id 15.20.6433.018; Mon, 29 May 2023
 22:21:04 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC v1 1/3] HID: nvidia-shield: Add mappings for consumer HID USAGE buttons
Date:   Mon, 29 May 2023 15:20:50 -0700
Message-Id: <20230529222052.68913-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
In-Reply-To: <20230529222052.68913-1-rrameshbabu@nvidia.com>
References: <20230529222052.68913-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 423125f8-d8a8-4efd-882c-08db6092fda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTBbCaONemfe9ZJH8f/4mfoc29VDjpI7qhUBCLIywA723t0H6Ik/QXvxBcL+fKDSxLD3rpas0J11Hh905v9eYOrSZ1G3CPzp6thB3SsRO3urd5IHmP0D8oXS0pY3s4XGxWJ9C5Lm2P+NRuXoVmjdTPaVpKgmwA0kBRKV5EMH1JYLBSuuqnl3qw8spzpPVMF32wU8+o2Dt5j01a+JOL++hRkFUoiIx9qRCF1UrtwTS5wPGgMKqYdm8ik5rWag4qTBcdvlh6qvOx2DQoC10svZvfwLye5Lpl7sVVSPu5JdxL2RN3dM25DUnfgkAZCDNHH/1SXFSI3f5a0U15OrGdtttj0YXYjkrlAWTx5qg0b6DcjbO9BFuzz6ltjEDMYAbzb7Uk3jKa3qy8gh5leN08XLlAH/dq3DllyQ2QtWw6Vxqa0cX3mLwTxFFq3u9yDd2l8/Re+NczAXPz+ISPffgORl+L62V7VljledTZOpibgxJ/vkHJ3XLavsX1GqyfwARwp8cKDi+V7UNxj/55D2Pn92FbWgJY3EZwG5Hvcf3EOPHfisJ5p0EUf1sVbt2ijtvLMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(6506007)(6512007)(186003)(2906002)(2616005)(110136005)(478600001)(26005)(1076003)(83380400001)(8676002)(41300700001)(38100700002)(8936002)(6486002)(86362001)(6666004)(316002)(66946007)(5660300002)(66476007)(66556008)(36756003)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34JsuWz3l1zXILzMP7H5ynEiU7ELQzTaJwmIFpdx+R0rQ09DgaVLpDh2HHkw?=
 =?us-ascii?Q?XwsQcxN461IEbOHNOuy0bGOjMurFxN3/1wXXpoRVsXo8PQ/8WrjRhKt6x0pV?=
 =?us-ascii?Q?5zO/n00Zqo2Z0ppHgvzAyS7P0i9VFbDAgGLstOSnH6OLYhdL3Xlz5b2a4OR7?=
 =?us-ascii?Q?d2+3XA8ZPxqWyxXafVfe6RG6NOUQ/d8XdnnT6oL9LjD7H72XEdBbJr1VgRpW?=
 =?us-ascii?Q?fIRgqzSwebglZPrq1zz0aWHZ9ksuBb9j5jN1iG+W8A2h9vpocUTTXIQs4ooN?=
 =?us-ascii?Q?NHiS230/8kXZqAWCk0rpT2pBkpn+af3tahk2/WHpyu9uEtE8laQV/4+1/dO3?=
 =?us-ascii?Q?6mHlXSccwF5mo7cBfyBvSIfvJhjCre278cCgU5+EbUTG6G8sADmNW8K7dlSJ?=
 =?us-ascii?Q?2dEUu6NQpM3FCGDKltX9XjuPeGdNlVtuSd30ceU7S9fiChB5VWxEqHoT8snz?=
 =?us-ascii?Q?Sm5Zi0qkdHzXSq7eCwyKFuCXEPmqNq5zc3T+/6esuX8X+prQbi/iYcZ3gmcN?=
 =?us-ascii?Q?Kh9BRqudPFvfC8AK59J+g+JW3mz+qNEZWbRRsuLzzGmWHM/PUGPL90QfBAWQ?=
 =?us-ascii?Q?CIaAT12AYSNodT/6F+3v+ZynaPP2Z2YOObiCiEy1dX9G7TjxlWVYy4lKQFwJ?=
 =?us-ascii?Q?GTlds65os80nNTylKWvCZu4/hsCzypB0SSKVMp+SsDfdoi2ewVUuDxIRYnkZ?=
 =?us-ascii?Q?IMa7YIMolE816i2tk1P1K/2H96u+fHzz51zw1hnhDRD5hFKqugASkFexgcE1?=
 =?us-ascii?Q?Lzs10iRtuF586iwTqSMVS6lQNPyza+9IZ/QlB5LLLalX1Q7bRUpoPG8dEs+s?=
 =?us-ascii?Q?4fcDj+zdBNh18DSo9w3kubIojQmxrMqOgp6yFkGusb4/sbvX4su7lUq+5EtA?=
 =?us-ascii?Q?HATZ3S3Gamn4E8Z1SQrmec7NtjT2XKMcKEdPeq47e33iJMW1xGO3aFF18jLe?=
 =?us-ascii?Q?gJY/VmczTJxt7PCxlDrhmMFeIx4OEjvVp0mY3FWZIlK6DNy8HIr4jpyahytV?=
 =?us-ascii?Q?mVY2uKZoTXzC/UlqrdZeC/BSjEAd10G8RfqDWy4kKax14aCHgfGQocIhx83/?=
 =?us-ascii?Q?h/3zswuQUS/jkHF2KPoAWTdOOaqOqaDwXfP7H430ZVJAKh4Ast2hoXlfn7g3?=
 =?us-ascii?Q?/2Fn9RgCLcmhDBCk9iYhSRYDrrJfnYHO5MuxuggYN2eVCgR10Rd10Ha1+nVW?=
 =?us-ascii?Q?j4M4qUk8W+m9gQMznVWdOENkWUX8yeEGlgwNRVn3yiA/rJzrfOAKlAEOu75v?=
 =?us-ascii?Q?7i9HrZKS/ssbqlKiTYSBaP1zxoapBGBB99R8kTMWowcTFHEB+4Da6Dp0ifcH?=
 =?us-ascii?Q?qPZwu1JRnkHfIxsWODsfNm/74H9yInp5qeSJP4AhNGI14K3W5SP3jQIENTrf?=
 =?us-ascii?Q?mKDj9ggO7cVx3rk+APnOawL3lzFonVQ+CjVuw8fZHJMuW+CDfn1YorpCEH8q?=
 =?us-ascii?Q?x6YVWkojF2th+D8jOSgz48GAHd7EVXGb3uYlpz7VSd+gYU//uDYgQeTpx/Sc?=
 =?us-ascii?Q?QTENZrxGEFA1UPVNmzT8iH4jPM4SAzEik8Aq8VYvX5+LINi81w+gSUweNzvF?=
 =?us-ascii?Q?wTJIoIDgxe6XspMb5xbKprddwlmn9hRLO45tKhQFAjqVpqgrYqy3liQ9QVEH?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423125f8-d8a8-4efd-882c-08db6092fda9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 22:21:04.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdfj+Xmbq9sbfbWGoUB/ACpI3JZ3EZM15tiuQgzGIlxx9aAQg/m1q/YnPkZJ9bqM/qnkkH6pMsHYBJxpT4kNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map Android Home, Back, Search, VolumeUp, VolumeDown, and PlayPause buttons
to the appropriate input event codes.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/hid/hid-nvidia-shield.c | 55 ++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index bcf345e365c0..1a9d32b2c80c 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -15,6 +15,16 @@
 #include "hid-ids.h"
 
 #define NOT_INIT_STR "NOT INITIALIZED"
+#define android_map_key(c) hid_map_usage(hi, usage, bit, max, EV_KEY, (c))
+
+enum {
+	HID_USAGE_ANDROID_PLAYPAUSE_BTN = 0xcd, /* Double-tap volume slider */
+	HID_USAGE_ANDROID_VOLUMEUP_BTN = 0xe9,
+	HID_USAGE_ANDROID_VOLUMEDOWN_BTN = 0xea,
+	HID_USAGE_ANDROID_SEARCH_BTN = 0x221, /* NVIDIA btn on Thunderstrike */
+	HID_USAGE_ANDROID_HOME_BTN = 0x223,
+	HID_USAGE_ANDROID_BACK_BTN = 0x224,
+};
 
 enum {
 	SHIELD_FW_VERSION_INITIALIZED = 0,
@@ -416,6 +426,40 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 	return shield_dev;
 }
 
+static int android_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+				 struct hid_field *field,
+				 struct hid_usage *usage, unsigned long **bit,
+				 int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case HID_USAGE_ANDROID_PLAYPAUSE_BTN:
+		android_map_key(KEY_PLAYPAUSE);
+		break;
+	case HID_USAGE_ANDROID_VOLUMEUP_BTN:
+		android_map_key(KEY_VOLUMEUP);
+		break;
+	case HID_USAGE_ANDROID_VOLUMEDOWN_BTN:
+		android_map_key(KEY_VOLUMEDOWN);
+		break;
+	case HID_USAGE_ANDROID_SEARCH_BTN:
+		android_map_key(BTN_Z);
+		break;
+	case HID_USAGE_ANDROID_HOME_BTN:
+		android_map_key(BTN_MODE);
+		break;
+	case HID_USAGE_ANDROID_BACK_BTN:
+		android_map_key(BTN_SELECT);
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
 static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -571,11 +615,12 @@ static const struct hid_device_id shield_devices[] = {
 MODULE_DEVICE_TABLE(hid, shield_devices);
 
 static struct hid_driver shield_driver = {
-	.name         = "shield",
-	.id_table     = shield_devices,
-	.probe        = shield_probe,
-	.remove       = shield_remove,
-	.raw_event    = shield_raw_event,
+	.name          = "shield",
+	.id_table      = shield_devices,
+	.input_mapping = android_input_mapping,
+	.probe         = shield_probe,
+	.remove        = shield_remove,
+	.raw_event     = shield_raw_event,
 	.driver = {
 		.dev_groups = shield_device_groups,
 	},
-- 
2.38.4

