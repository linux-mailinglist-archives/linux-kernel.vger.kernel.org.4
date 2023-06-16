Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D52F7328DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbjFPH3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245011AbjFPH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF626A9;
        Fri, 16 Jun 2023 00:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiNFtqIaNYOlCABg2sKaq4TbAaB9MJqmnZ/vHs2JkuCFd/JkL6lPbstnqfxQOpEzdMaWgVfQFs/+K3No2qCTKQYo9gi/CvD24Tl5takBBPu2S1oQMZ/qofFVTFcaRo9dg6sXXF4J5BffAYDLGRPQGRCquGg4NGJCkf8blk+MVlC9AlJVELFBEJ+t0+G7Z74tTs1uEZqj7MCpvjcIlDRWTzS2xb1ZYoKHnU6eeYGlREWQwyIunrUI/4LTqVX6ySFGK2nuVuDKGu5YtgPnOZNBwMfR4XivniCrVUfMOU3dtewGKv6yyehmGDFtE3sGNZPnB8hFkobZI7+hZxh0MaUONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLgaUQuMEy87mQOE6+9pRSxODWfmtoB2wTXnumPyZpI=;
 b=ee4A7BHVGXjseLzhd7KzH2vEuSUF4p3hMz2RNh9nGjAZs8vEUCuFgwTmZYQY9IfbPnJkJ86mCVQ1y6bI1PqR04j++ptJHFMZ6ODyoXjx06qsMQZqjz+D6DGcWTIg89hQWaZFpTXTFoVcDrT6CkrxrdE0yE85xUE3N295qsLOc4WaVazOkyNTDACgEHpIQZa6WKy0GJUre5ZVzOw8jRz5/pkEp6JxTn22gUZgsIzKNx1TPRwCsnQ6zc1YVBCuAK4yYskwgyCdXhlpv0X+xgEpt6CfsL3xr+j+PkHf1FaVi6+tgWRx6dkbUeGPfXM/OJXluJlZh7DWyzLkZYIs0eVrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLgaUQuMEy87mQOE6+9pRSxODWfmtoB2wTXnumPyZpI=;
 b=J2xSIIzq+gLBreJq7GpbCWQKP3Dre6WP9QEGJk9Xhz5k6Jl+DGtYMYUMEw/baKyHGf4v/Piijn3g35KnkTZhBjp8XNidJ3j/7K+TOMoQzcd/PkW0rxsOF/wMb3kQlfnw7pjQGu04A+LGzpY7P7c44kDLXNwdXJD2wqU3m/k6doU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB9916.eurprd08.prod.outlook.com (2603:10a6:150:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 07:29:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:29:11 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 16 Jun 2023 09:28:53 +0200
Subject: [PATCH v3 3/4] Input: st1232 - add overlay touchscreen and buttons
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v3-3-b4fb7fc4bab7@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686900549; l=6684;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=Ufj+40UV5TZ6PtKmvGP2w2PJ/I7zFECdsQf3vvqBzHU=;
 b=375jOJh0X/XWT8jYPZJRozUoliXOe5jkfsTwibeMlUaYt9ii4Dw9RajpyCwrhZP/I3PrsITna
 8RVEfXMii4kAzI9WpMbz4bnIdd8QxnWhQhuG+AZpwgGH7TZnX3w6zGE
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: a76a3520-f15c-492f-52ac-08db6e3b6085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUNPbzUEyYlJ0etxSaHPvjxqH3fYoIO9syALhg9fkpMzP5bOrosyCGooV9escL8prwIB/DdZGZpTtMMb8yjCPiFdupq3gznd737ZORhQU4VzfaYShqu6YU37FvJnw2q9oIq+w/yfP2MYEczXSztEYaGLa3wAGYvOO7TN12zeT3Fv4X1p9LxKE/925ZVar3I/FdouJJWwn8yodPAERcHsGeB6so6ASp7fLvpQ5qWwo0GaplucQe9G95IBMVMOlxeFDmhr0rvS7oND1zKBK73PqznIFJffW8fbpYwBsvRstpxMdvvmgWvO0y6MmJQsXFnsZj8724UAWEsQxk7o7Fo3pKhuHYkBWWc8oKabsF28taXxc2oQRe5spHzdaw/5zOte9N3CakviTnFmPFgx9ZLjAZPH3srJR8F9vUcvbo6kOakEe5R29fYEHKJMI45MX/ANii2NgNLZYlPzbdmWDwybuZq39lmXJanex22MZe+SapX6zvmuHrJPe05tQqwU5SNpFuNcgt8gBXgYKi/KhO5dycYf8lHYV7Q5TxCJ7IP87yZi1Ha56inIS5bWrXY9bW587O3EJrvVeSze/ctl2lhQXiCH1NEPlov4Zh/bjjgmb9lFO3ImLHyT2y3e9y7OyqxQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(36756003)(86362001)(2906002)(44832011)(83380400001)(6486002)(6666004)(186003)(52116002)(107886003)(6512007)(6506007)(26005)(6636002)(66476007)(110136005)(316002)(41300700001)(38100700002)(4326008)(66556008)(2616005)(38350700002)(66946007)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NklaMEIrRytqVFphOEZjS1EzOEZncExxOUVqb21zL1B4REgwaExBYVRFRWg5?=
 =?utf-8?B?eWd6OWhpQnl4OVRVSHg1UElTSnBhM0p3Q25tS2RGM2lBWS8zZUdVUWdVNVhD?=
 =?utf-8?B?aGxSZE5LV1VwZkNoTGkvQ0g2cUw4Wk5jQitWOWNMMDdPbXIzUExid2o1bG4z?=
 =?utf-8?B?UzR4cjRWNklldmNzTmdDOGhqa0NmRGtkZkI5a2tZL0d6cFdjbXZreElSS0Zi?=
 =?utf-8?B?Z3hFaVI0U3NRR0MwOUh1dkdDd1lxYUUxN1lTNXlkYzR3R0lZR1BLNjNiVzB3?=
 =?utf-8?B?dk90bG5pL3IrUUpwOUV2MHdOaDJrdjRRT2l5dXBLS2w5NFlkeXk5dUp5MllK?=
 =?utf-8?B?TFlyK25oWFNIWmNPMFZjNm9VVStEMngybm9GbHA4TWN4QVV6bXV5bVl5bWJ1?=
 =?utf-8?B?SmhSTXBOVmRBUkNLeVZlTWkvS0duTkVHMlhTNXh1TEhaemIrcDlCNFNsaW1G?=
 =?utf-8?B?N2VpSVlUWXliT045YzJzVENob1ZieS9EdjV3UGlOb0NjeUpSSVE5TDRjcStM?=
 =?utf-8?B?elJMZlMwUzBQU0poTUlWek1tQmozNzBMOWdyaFNnYjMreksyZmRRZlJ4cy9r?=
 =?utf-8?B?SFVwSFJWWm5DWTVXZkUybk5rak93cllUbXJuV0taaTlVM04wMXcwMktycU0y?=
 =?utf-8?B?d3BvMytpYS9tU0pTVjNKMmxMVmdPSU5GOTRsRHcvUmZjUTRMZFN6aGFNcXNp?=
 =?utf-8?B?Z2hnWWdIeW1IYnkxZTQ4dnlMOWJjSlBzejNlMHdSdDFOZmFWYXFIUzI4OFF1?=
 =?utf-8?B?T3FvQm1VWXFrSDVkK1dRRkxQWU5UemJqNzZ6UnNVSEI2b2c4MmZpUDBkUHVQ?=
 =?utf-8?B?a3ZwQlEvVVVlOG53djZ5L2VkeVJzQVpKOTdxTzdpQm5yUWFHNU5YSkl4cmVs?=
 =?utf-8?B?YjhvMHRyZzNkWFpLL0VPS2ZENnpBZGFncVFiRlF4S1pYaWNBZUNzNFZxa3pD?=
 =?utf-8?B?amJia2VQbWdxMStlU29BczBqbVJkelRPcTJFQ29TTHJsaGxsMktqaDg1SXZn?=
 =?utf-8?B?R29qc1g5Z24vYUIyU0s0NXB4TFk3SXZWeVNsUDY3ZEk1U2p4cHVFRktzRkl4?=
 =?utf-8?B?Nm14MXNja21VS2ZHVlZ4UVlTY0ZjQnJ4S0Z4ZVFpYlFSVGVEQjZvLzVQS2Y0?=
 =?utf-8?B?UUN1ZkpsWmpzbWdPT04wVVJ6U1NFWmNKdEQwMzQ2dnJrelZ3bVkvUUVKSjdx?=
 =?utf-8?B?aVA0cnVGTEp5QUluWFlybUd6bitwZHkzQmp4OW5hbUxWa2UwR244eEEya2lo?=
 =?utf-8?B?VENSeVFIU3dYU25TWE1RR0lnU3ZRd0lCMjh5U2twRTFWYndBZTZTYnk2cUsw?=
 =?utf-8?B?eS80bHRhL28zTjV0L0NYVUo4RXFaMXlFZHB4UlpzMStpbXhYb1RDUk9UQzNr?=
 =?utf-8?B?RGxuMXpnc3A3UkNTTmR0UUV1aUloWW5GcWxxM0NqeDdiYnFtWFM5YzFrU0R2?=
 =?utf-8?B?Y2JMSVNscHlpRGtBQ0s1S1gxSFJhYU5Wa2V1RWdlL1gvVmRDMC8xUmliUlZV?=
 =?utf-8?B?N004cWtreGduSVNUdkw3MW1jNlJINVdFOGZab0xYelJQdWFxbitVcjYyNS9P?=
 =?utf-8?B?azQ1YjNVOW9MRWVXL1ZpRzZqVnBpdFkyeTVlVkpPRnNTNmxNaUFmVk1TSlZM?=
 =?utf-8?B?eXNpdkEvMEFLc0hLMHA3U1VjZjZZRmdFNTYwNXJTZ0E3eElmVnQxMnZzSm1V?=
 =?utf-8?B?a3VFeGtoSEZvV2xkdEJ2UWhEMjAvOXByR1VkUHc5azVZRTNNYU5RZmFCaUFX?=
 =?utf-8?B?Y2tsUEMveHFUSmp6VHlROHAzZ0N6bTMxT0tDN3cyamdCMHEveXpYM0N5aXBK?=
 =?utf-8?B?dmw1bXZ3QmJadzJiY2pjMzFRUHN1dFVKU2dmRXpMTFFoR3ErWUFHamsyaVZP?=
 =?utf-8?B?Rlhoclh1UTVVSXM5Ui96TG1oRm9VMVczb3pwVG53cHdOQ29TaGZLRnFRRlNJ?=
 =?utf-8?B?QkFBKy9qUHBieUxzNG9WVUlrVEhZRDIvd0g0WHNKQ0lLSVV2bWJ3ekJjeVFF?=
 =?utf-8?B?Nks3YVhFeldQaXd5S2diREwrOVhyc1AxU3lWTDJzdXR6THZXV2RnYUxNQzVM?=
 =?utf-8?B?NDB1Yndub0l0SFFnZHhuWWd3bHlaeFFsZi9Kd2xOTDNXU0NpSlZ2RStZYkUv?=
 =?utf-8?B?c0VXNVRKRkFFN1ljeTdtMXFWNXJWQmt4cEN3UWphTWkyMk1GS0VmcmRXRVly?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a76a3520-f15c-492f-52ac-08db6e3b6085
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:29:10.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6+21fR4sRzRrJDkYi+NIwWOR9MZaOK2Od8oEk3t894xu3pgdCL+rO5IWYCqL5AeWKD8pSGKKylEgsJUYcXeGopC1nGxUQ9XuKOwAQvpvbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ts-overlay to support overlay objects such as buttons and resized
frames defined in the device tree.

If a overlay-touchscreen is provided, ignore touch events outside of
the area defined by its properties. Otherwise, transform the event
coordinates to the overlay-touchscreen x and y-axis if required.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/Kconfig  |  1 +
 drivers/input/touchscreen/st1232.c | 87 ++++++++++++++++++++++++++++++--------
 2 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 8382a4d68326..202e559371e8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1215,6 +1215,7 @@ config TOUCHSCREEN_SIS_I2C
 config TOUCHSCREEN_ST1232
 	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
 	depends on I2C
+	select TOUCHSCREEN_TS_OVERLAY
 	help
 	  Say Y here if you want to support the Sitronix ST1232
 	  or ST1633 touchscreen controller.
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index f49566dc96f8..7d8a69e4831b 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/ts-overlay.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -56,6 +57,8 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct input_dev *overlay_keypad;
+	struct ts_overlay_map *map;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -129,10 +132,12 @@ static int st1232_ts_read_resolution(struct st1232_ts_data *ts, u16 *max_x,
 
 static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 {
-	struct input_dev *input = ts->input_dev;
+	struct input_dev *tscreen = ts->input_dev;
+	__maybe_unused struct input_dev *keypad = ts->overlay_keypad;
 	struct input_mt_pos pos[ST_TS_MAX_FINGERS];
 	u8 z[ST_TS_MAX_FINGERS];
 	int slots[ST_TS_MAX_FINGERS];
+	__maybe_unused bool button_pressed[ST_TS_MAX_FINGERS];
 	int n_contacts = 0;
 	int i;
 
@@ -143,6 +148,15 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
 			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
 
+			/* forward button presses to the keypad input device */
+			if (ts_overlay_is_button_slot(ts->map, i) ||
+			    ts_overlay_button_press(ts->map, keypad, x, y, i)) {
+				button_pressed[i] = true;
+				continue;
+			}
+			/* Ignore events out of the overlay screen if defined */
+			if (!ts_overlay_mt_on_touchscreen(ts->map, &x, &y))
+				continue;
 			touchscreen_set_mt_pos(&pos[n_contacts],
 					       &ts->prop, x, y);
 
@@ -154,18 +168,25 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 		}
 	}
 
-	input_mt_assign_slots(input, slots, pos, n_contacts, 0);
+	input_mt_assign_slots(tscreen, slots, pos, n_contacts, 0);
 	for (i = 0; i < n_contacts; i++) {
-		input_mt_slot(input, slots[i]);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
-		input_report_abs(input, ABS_MT_POSITION_X, pos[i].x);
-		input_report_abs(input, ABS_MT_POSITION_Y, pos[i].y);
+		input_mt_slot(tscreen, slots[i]);
+		input_mt_report_slot_state(tscreen, MT_TOOL_FINGER, true);
+		input_report_abs(tscreen, ABS_MT_POSITION_X, pos[i].x);
+		input_report_abs(tscreen, ABS_MT_POSITION_Y, pos[i].y);
 		if (ts->chip_info->have_z)
-			input_report_abs(input, ABS_MT_TOUCH_MAJOR, z[i]);
+			input_report_abs(tscreen, ABS_MT_TOUCH_MAJOR, z[i]);
+	}
+	input_mt_sync_frame(tscreen);
+	input_sync(tscreen);
+
+	if (ts_overlay_mapped_buttons(ts->map)) {
+		for (i = 0; i < ts->chip_info->max_fingers; i++)
+			if (ts_overlay_is_button_slot(ts->map, i) &&
+			    !button_pressed[i])
+				ts_overlay_button_release(ts->map, keypad, i);
+		input_sync(keypad);
 	}
-
-	input_mt_sync_frame(input);
-	input_sync(input);
 
 	return n_contacts;
 }
@@ -226,6 +247,7 @@ static int st1232_ts_probe(struct i2c_client *client)
 	const struct st_chip_info *match;
 	struct st1232_ts_data *ts;
 	struct input_dev *input_dev;
+	struct input_dev __maybe_unused *overlay_keypad;
 	u16 max_x, max_y;
 	int error;
 
@@ -292,18 +314,28 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	/* Read resolution from the chip */
-	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to read resolution: %d\n", error);
-		return error;
-	}
-
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);
 
+	/* map overlay objects if defined in the device tree */
+	ts->map = ts_overlay_map_objects(&ts->client->dev, ts->input_dev);
+	if (IS_ERR(ts->map))
+		return PTR_ERR(ts->map);
+
+	if (ts_overlay_mapped_touchscreen(ts->map)) {
+		/* Read resolution from the overlay touchscreen if defined*/
+		ts_overlay_get_touchscreen_abs(ts->map, &max_x, &max_y);
+	} else {
+		/* Read resolution from the chip */
+		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to read resolution: %d\n", error);
+			return error;
+		}
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
@@ -335,6 +367,25 @@ static int st1232_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	/* Register keypad input device if overlay buttons were defined */
+	if (ts_overlay_mapped_buttons(ts->map)) {
+		overlay_keypad = devm_input_allocate_device(&client->dev);
+		if (!overlay_keypad)
+			return -ENOMEM;
+
+		ts->overlay_keypad = overlay_keypad;
+		overlay_keypad->name = "st1232-keypad";
+		overlay_keypad->id.bustype = BUS_I2C;
+		ts_overlay_set_button_caps(ts->map, overlay_keypad);
+		error = input_register_device(ts->overlay_keypad);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to register %s input device\n",
+				overlay_keypad->name);
+			return error;
+		}
+	}
+
 	i2c_set_clientdata(client, ts);
 
 	return 0;

-- 
2.39.2

