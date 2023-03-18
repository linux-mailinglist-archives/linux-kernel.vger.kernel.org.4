Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579246BFD09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCRWYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 18:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRWY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 18:24:28 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2136.outbound.protection.outlook.com [40.107.116.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2D1A250;
        Sat, 18 Mar 2023 15:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngfnS2JpwGIzWj9uRYZOIchWw/OC29UMz8B+zI+z0pWFInOKKwfyDydFHzSGVqtbktWfb5RPBLS+yFlqZ3YKjKgpt8jLBGQwyx5AiCwAi4DDTEPuh7zWknjxUHgLI9jVh1u4RpQuLp+F8Vsyl1gvYrdrre4Ph0cMqV+okVayBhZy4NgFqXuyMcWER7Wxk2d8OIvl951pDFpPId7+rlhhF4kPjKQWwk3cLrAlkmiw2a4/llh2DDXA4ZKFq5paaAh+Re7ucSyFKdtnXQmUV35fhATY0qPsIuuSSjlGbsUaUEIIx7r09h1RqnGdT785coSHHKadhggog0QbuXanySnNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTN5HJxtJJIUp/ridiU6Q9SHJ8OSJ/mXZR9pfYDLZ/o=;
 b=admoI/f1IgCKhHF8d8E4O4V/5zvT9/igCCiCSYmezuzSFgHHTNY4epvDgUgxAvP2NrkrfRKjchQfI6p4UBE7ETJeZTituYmd0fShB3injyoggd1IiWTqKjyw+LdTjB8WIoWIBeLC+Bpb4JM/4lC3S/ckCu+D+eFfAegBNdH9itzLan1ikGdIMC05IT6gt+T4XJnN6loMNqIT0/KqwOA3oRDlmp7bAP72UQYJx3MKi4mQebVqp56dpVt7TOyX3d8ZVbQuhJQz7rhy1F44HsceUmslw9kKbuHr4PU6R2ERyGivwtJCBK3tqCDO5b4gv3lcRjU+E4b0QzxJZz7rwkJLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTN5HJxtJJIUp/ridiU6Q9SHJ8OSJ/mXZR9pfYDLZ/o=;
 b=PuK5zLAbz5uvTyZD8BonKYO4Q396FAZRZTYJL1mWsk00o5NUHFvFYygKLA67UteRMDkjgNkGCaTTokw9ubP4nh+RcPz14jg0Tsdj/5TIrNfSiIj0PNMp4PYANwJTqeOQDvyX/FvXrEzAGyFpyARg0rW18TQVDjMMLKhZjxpgH/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT2PR01MB8807.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 22:24:23 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2a76:b922:37e2:e1d2]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2a76:b922:37e2:e1d2%3]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 22:24:23 +0000
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3
Date:   Sat, 18 Mar 2023 18:21:32 -0400
Message-Id: <20230318222132.3373-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::10) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB9670:EE_|YT2PR01MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: e75526e7-2994-4a57-44f4-08db27ff869a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K36BTOPI+y0sdYRZ/FoSSBmMsDRizkiwAd1eXYIsWtFyoOQDIYLVBk9pVxiOKvYyZplsmSLi1XzTJmWNgsfrmNW8gZyhZzxszeLt9WQhA1LKlUnE4i2QwEkKKN14aRbcva+6fHkHDfHnUyE9PohguTuyBqkvNgbTL3swuTAtJkQFkaWUakub5Pat1aKpPyWhP3RSvFf8vh/PgkPRU/oJdS3pe9pmZtbY5Rlhwn8hVCb7tUIc2hpBocAjgfkr6L9o1fZnauGEBO2YQJ46746ygjq6gpN9NLqRF8UGg6Agm0mcQiNorZVC8Rao3fPaoO/O4iprLD9vQSEOisRAKqvCu/Vy6UUVh+NLuQ12IFOYN9OqLqFMNIb+YkK8NxcKRJIqkhLhhsqJ3kur6p7ufieugFXaTMIJA9qSZl+VJG1c+C8SU8HuuCEaNQuCuedpVdnEoDot00Cz94BYiuEUte7ick6+strw1yxpb9XuTs/+oPWk49GJ8hsg7jbunghHIJ5bcjvpRkVZIDokZhziiGPjdNkcthkEuQTezi+cMDzBxbMFT5qckeyGqsouzsnpDbnmpbXh97sd2spQm1FqrySMmvUT524pLQmAXK1ZoegKLYOerMl3j9gJ6Ei72Dk+ejQk3OZ8pvs61sfPD9BfL7lSpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(39840400004)(366004)(396003)(451199018)(2616005)(6666004)(107886003)(186003)(6506007)(1076003)(26005)(6512007)(6486002)(316002)(110136005)(4326008)(66946007)(66556008)(66476007)(478600001)(83380400001)(41300700001)(8936002)(5660300002)(2906002)(8676002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBNV0ZodFZEK3FVb3Z2Nmgwcm1CV1czSlVqSmdqc2w1enhWTUF0U3czS2lj?=
 =?utf-8?B?bTA3TVMxUWY3aWFjbk5IMkVzRGJ4TFlIRFk2NHV6Q3hmRU93YUhlMjROYmI2?=
 =?utf-8?B?NzlJVk96MEhNTlJQemJjOVR4OFh6dURpVStSSGpCYkF6aWNlYkF5YlJJNzJQ?=
 =?utf-8?B?RDkxOFRpd2x6dFJBYVBFTDZKcTFuSEM0TDdPeFhDTVhSQkozeHZUMWttQUJT?=
 =?utf-8?B?UjBJZFZpdElwY2tkQzlxVjU0RTh3S2MwK3BuZHMrSnQ2bFFKUGZCMXNWbGtT?=
 =?utf-8?B?VEo1SHZHWTVvb1F4R2hCbnpyOFhIZVJ2S2tOajdvcVRNdDlqYlhMUTJkMkpk?=
 =?utf-8?B?cllLSVNXaU1WOVRxQjRDSG9XS0IwclkzU3J1aVdNOS9VN3R4QWRYTGE0bkNR?=
 =?utf-8?B?MzVNdjk3U2JobCtGbWtwdm5nLzFudmI0MEtaMGs2ZWFrUUtxdFk4eG9GMFVE?=
 =?utf-8?B?S3FUNU9OOUtMZi9OYUVIWTVnREE1Kyt1TnpSR21LazJMMXVnSDhoWDVwT2xD?=
 =?utf-8?B?citSSXlFU3BJeVMvTXVSSDhHMkR6YVI3cjhIanRKeTFuNldSalp3eUhVOXM3?=
 =?utf-8?B?dWdKTHpzL0FTMEV3cGdvVmsybmFsUXdURWRnVko3emtRQi8xNDVwSEtkNk5B?=
 =?utf-8?B?SHBQUi9GVm14WWdHU2NRSFpNZGxSU1RadFZyVjkraWt0N2hLZnZDd0xhZHkr?=
 =?utf-8?B?eFpTRGFJMlNmaGVFSTZoYkE5TitDeENEaFRxek5zcFI5ZlZFZXdKNFlYNVMy?=
 =?utf-8?B?Wi9KQUI0QkQyMzhqZTkwVTFqL2xUODBpRlRNMWE2c2ZGZ1dUNUV3YndoWitw?=
 =?utf-8?B?NlVUOVg4Zmx5amw0YkswTEEyd3JyQm5zWkRBaTlYdGtFZHZLYk1kWmZ6blZ3?=
 =?utf-8?B?TGx0VmxIZ1M0WUR3U1k3dS9HMG9UVGNDNEx0V1BMdWtPcElXUHVpNGNndkt0?=
 =?utf-8?B?VGpMU3lYWmlJcnkxTUVMODR5dTJ1RUZhTjVsUEtDOW1aTnk0U3QxV2R5K3J3?=
 =?utf-8?B?TXB3U0ZRbEtDMmlDNmppQjh1OU5yNkcvVUNvNC9sRzRUdkI2NEI2WGJyVnJz?=
 =?utf-8?B?dnpMMDBTanNJRzY5K1JVRzJoQ3FVamFveEpON1A3WjgrM3RGU09NNjlCNU1T?=
 =?utf-8?B?NGEwZC9zV3NKZ3I4Nlc5QU5icVZCYW0vK2JUR2xxRnNpa2RsbjBWMFk1Vkk0?=
 =?utf-8?B?ZFdrelBxc1VJTTI2aUU0c01UVTZ6Vzh4MHl4dnA4bzY5aXRKQ2RoYzFwSmNp?=
 =?utf-8?B?azZzamJZMzRodndVWEhuNWovWnhrbHg0c1lIY1dTNkZIS2UvTW1SbFBKbzl5?=
 =?utf-8?B?aDRJSk5IU3VoaGlVR29rRW1qL1gycHhWRlBIczRGaXdQWmlaM0VlWEtQYkRU?=
 =?utf-8?B?NURUalkyd3hNQWhIeXJBQmtlOVJHRVBSVWsyWm9HK1FxZXM4VThad202cUVm?=
 =?utf-8?B?ME8zeGVMTmZpOHhTOUtqOVV4aTV3cU4xTzdmMHk1djRUbkNDRzhXeURRMWo0?=
 =?utf-8?B?cWxCbU9oSlFLNnpBZ0Q3SWtSZ285M2Zta1dKU0RreDZ4QmJJNGM2WU9Rd0l0?=
 =?utf-8?B?VHBzbDFXY3NKdDFSMTlDenZFTk1WMkxoS2pTeTgya0c4T3A4OWwyYmYvdVQ1?=
 =?utf-8?B?ZzNHejhNNmQwdlVUdDI0Y1dkN2pSOHUvSzBmUmVBdmE4ak5LYkpxbTc5QXMx?=
 =?utf-8?B?Nk1lOERuTDhBZXZGenUrZ2hPWHQrVy9scGRTWFFMTTdxaWxNWm05YnhsYTFN?=
 =?utf-8?B?L1BOTWc2Tnk4K3pUS1QycmMvdWZ0dVFCU2JLQkp6M3F2L0tCNWlOaDl4eit3?=
 =?utf-8?B?VitUQ25JRnExbFY0eXJHcTNlTEE4MEpJck9lUkpXb0g0TzhVM2RXTWppUTNP?=
 =?utf-8?B?UUZadXU0RVh1STBwbDdROXcvbkZ2Ukpob2ZVR29VdTdoNElqUFpaMDFCYVdF?=
 =?utf-8?B?WDE5TnI0WUpvbHZmYnpkbGRKcStUL2hkM1llSkFUTXIrUGN3UmhYMVk2ZzRr?=
 =?utf-8?B?Q3AzMUhEKzQyL0dFRXYwbVV3L3MwUWdJSzhtTVVTMmxFZ3p0S2JVK2tmeXYv?=
 =?utf-8?B?bi9abXpjcWs5UFh0Z2c2dDlOTlJ3V1I1Z2NUdGNTVFhqSkdrOXNKTFpFTWtT?=
 =?utf-8?B?VmZETzZGdjRsMTkyb1QyZDh2c0VPSW4xRGFJTEdxL0pJMHpGTEFKUW5uMnpG?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75526e7-2994-4a57-44f4-08db27ff869a
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 22:24:23.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1HQouJl0/clkvMF7u9kdZps4DqhrhEmpYnB2LFPl2q4VnsTKh/DK2hYBl2r/7IfDay3IsF+8Hrh3YL57cU7EtUEsOqsLedQTRIXO2qtb+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using gpio based chip select the cs value can go outside the range
0 – 3. The various MX51_ECSPI_* macros did not take this into consideration
resulting in possible corruption of the configuration.

For example for any cs value over 3 the SCLKPHA bits would not be set and
other values in the register possibly corrupted.

One way to fix this is to just mask the cs bits to 2 bits. This still
allows all 4 native chip selects to work as well as gpio chip selects
(which can use any of the 4 chip select configurations).

Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/spi/spi-imx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e4ccd0c329d0..c61c7ac4c70c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -252,6 +252,18 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	return true;
 }
 
+/*
+ * Note the number of natively supported chip selects for MX51 is 4. Some
+ * devices may have less actual SS pins but the register map supports 4. When
+ * using gpio chip selects the cs values passed into the macros below can go
+ * outside the range 0 - 3. We therefore need to limit the cs value to avoid
+ * corrupting bits outside the allocated locations.
+ *
+ * The simplest way to do this is to just mask the cs bits to 2 bits. This
+ * still allows all 4 native chip selects to work as well as gpio chip selects
+ * (which can use any of the 4 chip select configurations).
+ */
+
 #define MX51_ECSPI_CTRL		0x08
 #define MX51_ECSPI_CTRL_ENABLE		(1 <<  0)
 #define MX51_ECSPI_CTRL_XCH		(1 <<  2)
@@ -260,16 +272,16 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_CTRL_DRCTL(drctl)	((drctl) << 16)
 #define MX51_ECSPI_CTRL_POSTDIV_OFFSET	8
 #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
-#define MX51_ECSPI_CTRL_CS(cs)		((cs) << 18)
+#define MX51_ECSPI_CTRL_CS(cs)		((cs & 3) << 18)
 #define MX51_ECSPI_CTRL_BL_OFFSET	20
 #define MX51_ECSPI_CTRL_BL_MASK		(0xfff << 20)
 
 #define MX51_ECSPI_CONFIG	0x0c
-#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs) +  0))
-#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
-#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
-#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
-#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
+#define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1 << ((cs & 3) +  0))
+#define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
+#define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
+#define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
 #define MX51_ECSPI_INT_TEEN		(1 <<  0)
-- 
2.34.1

