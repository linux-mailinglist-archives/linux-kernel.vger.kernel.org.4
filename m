Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E81649335
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLKIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 03:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 03:41:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2067.outbound.protection.outlook.com [40.92.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E312095;
        Sun, 11 Dec 2022 00:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0hj/ynTA17cP/51HwPyKdj85P53zNLrCrxSOjhQ0Tx1dOhQbQi7BboC34U3ocxxmqkJWH0w8L5wuIlUiYf8GK24pdgF49VkFf0Klszj958JEa14uwtTlV4ho0jTQQDG9sBBX+Ow+1Nj2Hj462hUxvhZRoe+5H5pPPtQEijgU0Q5Uiyn7upuyNlRwKkdOEbxeFlamkegejGdyPm1asF8AuJAxLAJmj7XRteIOT6pubNhs3V3fsD0ktvo1yCBly8Y0JzzjrsGEadxw1LvGSjMb/KAcPQe59eyDeBUyxkBEJrggYAQxg4Bo8P0ZCbM6FFtoNgum9p5NAN6o8N7dnlBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z8yZa3MBYSHLL67aTDBLgpsTYf2yjah9chvTfC4f0A=;
 b=nAWnOThfv67mV5fmuP8PA+V1928nseSOZHrlvoD0gLqro6+tnrqw5nkP+8VMWPZMlucWyd5KvcAkWsqf5ozan2bvu6sK0EgRpT7qE/u3gvlOzSa3jaXhOQwZMM/sTPbzW69UnJfKih4EhA83c7rVR7lsLA3eviTGPIVMRZnRCqs6XraXpybHa2wjs0JloCIud7MhnAu13jXMnxVdcGrUb65DLWw+H3Th3I9h+MLLzo0G7R/KI+6rUV0UF7VoO4vy+hXbmbwltnjb1AeKGpP02HpC7aiG0RPntv+yhPnMLjYnaUen8r/K8vHH73/6FUNaAfn1JXbhEDq9zCbTJIu37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z8yZa3MBYSHLL67aTDBLgpsTYf2yjah9chvTfC4f0A=;
 b=clJjGCyohcODurIkwuEY4UOq6Vk4bUP2nvd/4AFzHYahwQrpYJM8+dy/KaaU98q1nE5yvB68ldra61h/YZbnOYUTcqWogaETbNn7ujXUwPWVs+DR1Va77rjto3OUjqjMBD4zehsdsriTT9PkU8qEJ1AGHyoTQMTXGNbYArrIQv4+Ecb+v4JvVQWzh5g4E6xhFrDgDLPTQL1NFlSV4C6gKo+ubJ5ju2Jh8YBbCglMRvjoqMVdWHDorKAQvIHx7ZM4HTEtZTHrfgmv5iAMHzY4PxzuaoClGoRARfu6r5CjKFK9/7DdHtu/GToCV+Mg+NXZ0EWQhCWPytrpAYx264A/Zw==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6260.namprd20.prod.outlook.com (2603:10b6:208:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Sun, 11 Dec
 2022 08:41:53 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::f892:b1e5:165b:c2ce]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::f892:b1e5:165b:c2ce%9]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 08:41:53 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH] HID: uclogic: Add support for recent Huion tablets
Date:   Sun, 11 Dec 2022 16:37:34 +0800
Message-ID: <PH7PR20MB49624FFCDF1F9382886933D3BB1E9@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4uZkW4fJMWZeP9zV3tfzo7Of6Ov2XGjz7y/US5qKn8Q=]
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID: <20221211083734.1504212-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 142d12a4-bdad-4168-7c78-08dadb538d5f
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicB5qK9jKkWuStJwctdoPmcF4GArdOMPFFhSJEVIDZi4KjxGCcQuqlSIasvaNqjsvm9kFTYHaT21Uv9B1RhlClHyaAdabEJQyLj38+LOmOta0ad7L6qDP835vj/j/NfogTwsInFCKNkBREDO/kCmAhqIct1JzzjOsHSKxadkWSBQkphGnb3PR54bpCQBJ4+59rvXy6fg3jwA3Obvbyg+spPMQArlOKDPsb13+9OlVq4b96yvRa0/aGaUp9x5RHo/XuJMSLJJFR478QzSTY8kPojwA7jArlgmk0gz6HRTZZutbWEfFsPEJ4cEOSy/vRar//whOvGSckkOYHG+IvBocxlEDC8bYq3I9zSctCuvzPQ5esA0OuWb5u/vLGLw+I1LzvhOmaP2liNToIhUc0/4j3vPAfYSmGmd2aGbtH/dKEy3rjtOWR7+/3NkW49i8+XsniB/C2mpFh8JtEyl8n4FFLd/pqO2X5Q1Sv9MZKTE/tlejvvSKvN3pEMm6ChHlzuIzbIGVvAV5RuQyb6XjLujq+khX6OTLw58Qm0Y2iH5QQsN0AfqrUB8TEFtNS3lG/33vwyu4/iHwcTbpkRtl/QNw8xgoKO9sabfWF9dEBeZkoF148GO+nsS3ogF/mEU6+lJ9DnV9UwVJE0ph31NjFUCSnzxWieU27vWXtp9H68EF2UDSJjrW+6XXD/fCEHqx6oqqDzGWm2/08HlN0U1HsHYHXW+qF7/8ULhMFMpJe2i74a0/w==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKISgd4fmTqlqpJwdy18Hl44jicAJ1T0Wq+LS60LjTrjvueGhu1uGFIUoWMnjtJkruIB8FAt4jaqDpMol71ZLvFBMTzeufOxrg5gY5VAOYnkfv/21m1XScpmSXfpKIk9Aq2cAsVf8GITnlUrtHSHcI0sD+q2w7opsxJfcE/rI4A1SMQ87iIPxlrNYsjGW+/hw101sLXfUusymQkQHW2Uc1GrBI30uGmR7yArdGy/nvTIgDlTuQqRygHJ6faPpMv/8WIQwFRhVf7DJ9kPvSkZLgxGrlEBaWTNj5ye1wCcMcVSGAl02FBA493mMZZP5pRDJYMRGZIqzL96RbH3+yXkOj/gVKuC5V3GiRtCi8K3SLD4uXekTwmZNPg9uepbf1Y/BMoKaVgC+HUftV+PI6hCa7IBwVKcjlVK8v3cjHm/JQyUySjWlSJAI3znXwyMtzcl6/GRdyYV+AzdLePzdbeJanylpBCwABA4HmITOgTViuu9RgiG3gwSclEyUS+mjRV/hfaotf0d4/Ph/61MvWUKFt+yY14rY8w8fM7zoiruVjbLOIupC9XM21tGvvZx8PPDTQilJbniTq9ZDCUdBkqTTJ6y+0XVdQxr9eKYdtwfWQBirTEfg64XS8HNXkZcByCrE18YAGzcfLElTndH3ikSKg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0CjRBqMRRU8q8RHpB9aJ6uLkPJ0eehjU958qJ0npMbXoZ/ltf8kZ+D4Idth?=
 =?us-ascii?Q?iq0evkHlN2YEiq+U0cYygibMDgdJQkGS/tF6C5v6Trsd4G7RIUvrZa6/bn73?=
 =?us-ascii?Q?oGIWf49IryNUXCOQoez47dhl8xlk+BHcOnA6h6l6IoPI5UtQQfhiq4OBeY2z?=
 =?us-ascii?Q?i1KA3S6klApj92G/NyL27SGQbtQA9xQtFQXeCXA34QEV0DAmTEQEcOjkEHUl?=
 =?us-ascii?Q?EYMVZhvqdAfct6xAz8Gwpu04jiXe3+20NfTYUX6vlMi5n+lTLMXjR9z7nWkE?=
 =?us-ascii?Q?LGTGAn6DCF4KHH+rHf4nigDYWNk3d2wWrXB13HulR09XycHNoGSeSf3hw+pW?=
 =?us-ascii?Q?MILdrDUYpdWJr+EfoyDv4ZZpbQVT0doM6FrS139YedORRba3TbMnOqCHv0ns?=
 =?us-ascii?Q?HePoBNn97UetPGPz9X2KLeCV86fkgT2SNJ1Xnk2SsJWUzBEkh+kdvXQ9Ptc2?=
 =?us-ascii?Q?nBzldYI3+x7pdNvnb71DR7itMp582Kdrse7pHakTHsEOdzD+PJbdfpWpw1Pl?=
 =?us-ascii?Q?JIRLOuXvbdaDtaGxhkPjCwxRkAK2CVjUbZS76IpRPM/6OcBjGOXs7Ffo8pNG?=
 =?us-ascii?Q?Rk9wdDiIsDO4BxMqaHGMHVQuflnLB7vtoDNsD5jz1q54lCBAOKINRVSnXtVv?=
 =?us-ascii?Q?8NDmY3W5NLDi3gqXRD0Aqem+vqe/6czrHrLB2KyRhcf6f4tdCgpEkjijkopO?=
 =?us-ascii?Q?0w3+xRTX2qwcdWuK6hiWueyVh8pJno7tcRE4outMZVtg+B0evO4jHS/TguvQ?=
 =?us-ascii?Q?ADA3yVu0wXN3DJHfO0GbzfP8sSU+Ct6qnyXbc7+pehMl64YZC+ejHh3PjQ8a?=
 =?us-ascii?Q?tvg/DhDzAeiE6S8mrj+biDTCdx3E+CvI3EqsqJXc15rt3FwGjCj3M+jGjb3i?=
 =?us-ascii?Q?1cTT1OBQroQPBbUExQA0EcHnXDgHQZY+gw8pcWDy+iQn2MdI2Jk8Hod9PUAZ?=
 =?us-ascii?Q?YKDOJW+Xhl+YxXJmrrVeEbO4Jp6/+bNVTwIFkh2KkstufzbHkSdKaLOmZ59+?=
 =?us-ascii?Q?GmOjwXd1/BpWRN9GQmBF2/uLgBq6uUpfn4YhjhZhTrwyjJ2OZW+lR6Rj2bRU?=
 =?us-ascii?Q?v0069dYypS3NbXXgbt1i7kG8Ir3Afh1PpzO2n2PBy5SbsiigzBHv8/6Bfa91?=
 =?us-ascii?Q?TdKZdeZgLvkhp+pUgIVaGZo0/U7MVpb8ZobOODBvJngppQlZV1tdZWmVK6H3?=
 =?us-ascii?Q?Y8i01Us05PlswJvwj2xC9XDOAGXkTUbIQQCPfUOXGv4XDh5UjXYtV3tH6uNI?=
 =?us-ascii?Q?E2vpaqpl0MWUriUJpqESStEMzdsZ9B9uuPxS6erL91eLfHnQn5HUm3Pz+RxE?=
 =?us-ascii?Q?aRc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142d12a4-bdad-4168-7c78-08dadb538d5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 08:41:53.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Huion uses a new device id for recent tablets, add a new
device id 0x0064 to support recent Huion tablets.

At least these tablets are using device id 0x0064:

Gaomon 1060 Pro (0x256c:0x0064)
Gaomon M6       (0x256c:0x0064)
Huion KD200     (0x256c:0x0064)
Huion KD100     (0x256c:0x0064)

This patch was tested on Gaomon 1060 Pro and Huion KD200. This patch
may affect other models with the same id, however, it's seems that the
other models of Huion do not have incompatible hardware changes, so
this patch should still work.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8f58c3c1bec3..142186a6c14d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -620,6 +620,7 @@
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
 #define USB_DEVICE_ID_HUION_TABLET2	0x006d
+#define USB_DEVICE_ID_HUION_TABLET3	0x0064
 
 #define USB_VENDOR_ID_IBM					0x04b3
 #define USB_DEVICE_ID_IBM_SCROLLPOINT_III			0x3100
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 7fa6fe04f1b2..0c31c13bfbfd 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -493,6 +493,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
 				USB_DEVICE_ID_HUION_TABLET2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
+				USB_DEVICE_ID_HUION_TABLET3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TRUST,
 				USB_DEVICE_ID_TRUST_PANORA_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 34fa991e6267..f27292d71b6d 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1514,6 +1514,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_HUION,
 		     USB_DEVICE_ID_HUION_TABLET2):
+	case VID_PID(USB_VENDOR_ID_HUION,
+		     USB_DEVICE_ID_HUION_TABLET3):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
-- 
2.38.1

