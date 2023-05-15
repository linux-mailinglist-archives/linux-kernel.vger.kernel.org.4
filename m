Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9897030D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjEOPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjEOPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFF10C2;
        Mon, 15 May 2023 08:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiKNpPi/Pqc3CCC7qkfkyLM9t3A6VI1pI76MqwqP5j+02MRIGKrvfd9yUgHb7532dDx1AUMKvKlvotWD79g4i5/mYUUxRc4AhCYu4nxZU1welQ0XgRkO4ZlHEhSjC7IiwcMqGnvvVe084BM/MEnCtCIue5CEbYZuIKjA7BAIiuwl/+AGrCqZcJcZWFcgRVHzzRRlqyXagqpnyQQO+GRIpDhTXDvMmKRPOzfx1cLfFnbkR1S3yfu9oM/OFytQcnJ1D5Odv4vHpJ7DNBtvU5MexO/QqbTFEl8JaFT6SJ4VdOJQTkqLNsSUa3KMfJ4WO6jKi6HHt4qB9q6eosbJXt3cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dshsPAo++u9o6DL2oV0uKmYNROUNzWuw1+rmEUN4UUE=;
 b=kZ2KaTa9mAXLIHbAwRhGJQFGh3pMbgEgmDG5cwCRZM8eexIVw5WwhT6cBl/ebeF/YkfJVGYxR4y9WlhVbevsIkL1Vvjj4okemKQetdWX6CBrWeXfQ7s71QpTfI4EVCDtbYd5FHQguU6QBIdFqSQNMWQk5oOjYaHrBe0/E/9krUXi77HoV9yxU0i4R52+FOmNPt4rGTwS6G2kLC+xXlgq8e8SZyrGBfiW1wU6pJyCZ7AyleclpDukDJkcV9g5E9u0S2OlTYHW6I8aTVnVyseGsGjytgiKbc+6ws2T/y8AE6OdXKweoEHVJPGlpCWJkWtLerHW/f2/wvTcU3nEjYCxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dshsPAo++u9o6DL2oV0uKmYNROUNzWuw1+rmEUN4UUE=;
 b=tXMkh5Vi3T7Dr2BvlZWOINzBkpa6+/rga/XopaNK+b4rSqcZVJ+6yEFIcjmvHvpYkN3tTgAJxrBZNR0fpNnUJPL7jWKo3O283BVBPp/QiVXuShYaZeUe0eIGciZ6MJwM3mh4wdhRXyHitkma+QpgKyaA932j7YFT73vb68wibxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB9982.eurprd08.prod.outlook.com (2603:10a6:800:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 15:01:06 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:01:06 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 15 May 2023 17:01:00 +0200
Subject: [PATCH v2 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v2-3-f68a6bfe7a0f@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684162864; l=6684;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=M+YZI1K1J+Kh4MA1HKdyZxvjj6Vk6SOC4UKp3Gwdwag=;
 b=4MVZkZdyiQJHqLRGA22GENL5xPknLmgJ+2gN3Gb3Vay/OebDDAPNAV+rUrZwfGR8CHnk9eLkp
 bY6qwV9Gii0CthgIZcPgj9eOCNc0hblpdjeguwMV5JeBVSIAwPaE6hj
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d753767-e2e9-4eab-f279-08db5555356e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUAVAQHkCJ9yK/D99UK14aSS1sYn37j4C7SZayoKPALGucoqmjirnjvx2X5VPSm7RYfCsAyjdf3dUTnBBUPsnbAuaAjd6vgv0mPPpyRcJlDBA2PeNVwefH55BjF+JaqGF8FzOi5AoC2Kh+8B02eQWXOH+mtQzqwrGzg1fbv8BuEk3Nwz7WyyqfVz+n+/Xoq5ifqj0WsEBBP+2ZRfMZsF4I5oJxRfjIvvkzUxmcgRaASrpMHb5Z7A4mNO2MzsD6Xb7sWjc30AIl6kPjwoq/1qhLe5p+ek69lK3Kaxig77ld+i96n+w64PsIrUl37JGoWOmyN5sPKylOy1CVGdNv9ZKWm36LXZAcsGeV8lB2yysdtt9Ww22UFOmY+545ti4+P2FV09gCH8qkD4zpU3R68UHe0F0mXp1yABULEQuezjivZ+Zh/36+9cagF+WMFi+kioF+XmaxgJMFt6NrAKC6mxX3g/cWH+izO4/YKxtokL5v11sb8roAKmnuTF0HQGr/1/t17nvrcjxe2gHfUMUteUrSPHwHL9vDUKJK1cUP0s/h6BH4cT2GblPNILqpodidg20DcZCdBxIHdePeZLdkOc/LcrdRX3DGHMlHGeadt1gaq0eyNIju1HJEgKPur6jLoC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(478600001)(2616005)(86362001)(6486002)(83380400001)(6512007)(6506007)(26005)(186003)(38100700002)(38350700002)(107886003)(36756003)(52116002)(6666004)(110136005)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEx0c1BUbWdNMWlnclM0aFdwSXpSUjU2RldKSTFEZjVNdm5vMlFBRUErQjdG?=
 =?utf-8?B?QnhuRDVTUDk4Qi9WdTY4Z1Z5VWdCWWhLVDQycmhLZlUvS2dWSi9pUGpad2Jo?=
 =?utf-8?B?SmZoUjJzRGxIVGJMUmNlY21hQ3VsV2djcEFJYmNWWFhiaUY4TTN4Z0hpelRE?=
 =?utf-8?B?d1VtSmpUTEFsKzlzQ3FZQy9HaFBORGNIUUhENXVQWTQ2S3A5dlBFbTlkNVpR?=
 =?utf-8?B?Nlkzc1FSWmFPN3dqek5Wc3o5MitJWnZpdkpNb3JXQkZGUFAvbk1OSXA1c2sv?=
 =?utf-8?B?SWFRaGxqcE56cjY2TlRUOUgxWjdIL2tnSzZCR2N1bnlqS1lQY05xNnR0Q3VI?=
 =?utf-8?B?c21kdFN5aTdNRDZhVFJvMVJvcDBwMWdDVTRwRDlhbUN5dWZiMk5OeFUxbklL?=
 =?utf-8?B?TTZKN2s4a25PNGc4SWFnR1dTdWg1S1AxKzM2dWYramdIUjFwaCt2eHJOanRj?=
 =?utf-8?B?S2ZKTUxVUlJoOWROcFlmUjVLeFRqYklhMFU5dkRqRHljTGhpZXZsTkxqTmJr?=
 =?utf-8?B?VVljWlFDMmxzdXY3aDRCNXpiZ0ZzNldreFhPdEFVN2FvQ1EvZmYvcDNSZFMx?=
 =?utf-8?B?Zks1WHBiS0VGR2I4NlQ5Z0hnTi9SZTl5WEMyWVlQQ0VzZTM2dnY0a3kvMTFX?=
 =?utf-8?B?VDVHc1hMZmp4eXFjUzE4SnJLVGluU05Ec3Y1VktTcjZ1ZFQ1SE1URkRhZVUy?=
 =?utf-8?B?SGg4dkUyanJEamkvdmZLSnFUOXRBS3hZblJBTlRJSGV4RWpmTDl3UmRkY1Bl?=
 =?utf-8?B?MW9VaDJPdVdxdDZOQk5hb1craUQwZUt0cDZZcWsxVmN3TUVBbjhrYkdyRFVF?=
 =?utf-8?B?bGZLZ2J5aDdDc0NCUjRIRHpldkpkQ25IbFovWU14WDhhblVIMlBxZGZhTmVX?=
 =?utf-8?B?OXBxWDBaVUxIVGhZcGpUMS9jUTJCSWxEWXpSeDVFNWZXUitiQjZFSC9DcmNn?=
 =?utf-8?B?NjZ0MXd1SkswMW1Kb0FYSzNKdFpCdkU5bmJmU25uQm1CUC9JOWIwdDJ2UnV2?=
 =?utf-8?B?MWprd0kxUUJLYUZHMytzTC9EWkZyS0FFN21lbGpsSU1qSFF2dzU0dHdLMUpn?=
 =?utf-8?B?NS9hRHA0UndmaGJLcnBwSUlneUZ3ZU9pYjlvT3plOHVSZUhoTTVoN1RaMXgz?=
 =?utf-8?B?Q1RkSENGR21hcnNnZU5jTTJVTm4wRnRzZW9QM1lXam1MSXY0NVMrMlUwVXZk?=
 =?utf-8?B?WHpxNTBJZ211VGF5aDlyOTMyQkxRanVxcE12SHdMS1VMK1Z1dmpRczJhdHlI?=
 =?utf-8?B?SCtRb0I1TE9UZ2RwSkc5UzhhbDJHN21QekFFbDJxa3dtcUltSUNacDVPSURB?=
 =?utf-8?B?Mk8rMEpTZjNDMnRRNkJSRWY1MUlpcHY3SFBLZ252U2NRdkd2TGpZbi9kcGxH?=
 =?utf-8?B?WFVsTyswZFRJQ1pjM2xMSlNuNFpCT3N3eEJhbG16TTVmOUVvMWZCeHhibENH?=
 =?utf-8?B?V1dNMVoxMUJwdjBUVnJxRHBTdHFsSm1xc0RUT1p5Y01DeGlxNWFPYUV6a2Fx?=
 =?utf-8?B?SW5mQjQyQzl1N1ZFZUFDT1hleC9GZStFWVRjOHVaYk0rcUtJbi9mRk13OUlM?=
 =?utf-8?B?R1B4NDFFMEVwRnNEdTdEVE56RGl0SGVhRnUxNktKbkU3Ym1YSCtuNkxCWmph?=
 =?utf-8?B?Uktyb0JMYlc3NDlhSUgzTmd4anNvV3RnRVdadEl0MHgzbHoyZkdHUG5mZDhL?=
 =?utf-8?B?YUlsV3E5UXdUeXBCWFFpV3BXdFV2S21tekJUL3JqMXhMQzlJT3preTh4ZGVP?=
 =?utf-8?B?WHlQT2gveW9vdUw3MWFnZjVHcDJJWVlPejVpc0t5NFlMNlBBTzI0ZEt6dGda?=
 =?utf-8?B?WjV3WVdHdE4wbjRrczYrKzVEYlR3MURmN0hlRGxhS21NZkRWdzN6QThqaEhq?=
 =?utf-8?B?Z2x4VzJXa2NXUjRsYXFzQkh4Ny94c1RIT0kwalFTbmU5b3FmTk16SkR2WE9n?=
 =?utf-8?B?d25JS2RpYkJZNFJPVHJCZ201TXd5cy8yM09sdWRwYy9MRFNqenpDcEIxWmph?=
 =?utf-8?B?OGl6NU5vOElKUnFUMDc2MytWSy8yREF4Q0NjOUo2L1JvK3BqU3RWY2J0YmFx?=
 =?utf-8?B?Y3RsOGdzQ2RqeEQ4TU9JTVp5MHVqNU9LeWhqdHVTS2swamkwSG1wNmhYLzg0?=
 =?utf-8?B?UGQzZTBUSnVveHVtQVExdHl0MUhRZzk5VUlEdnIvWWozeVEvT2tINEJKbllV?=
 =?utf-8?Q?pWyjwvWY0Yul5vkgmq0dYdE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d753767-e2e9-4eab-f279-08db5555356e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:01:06.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDAZemVqe90ex0sAsjbR4KgIWqCLPi4pTNvz/GTi77E2kUTduwTChC+DJrtPR42BJIC6HI8S01k/RO7lIk0qm/e9/57FsabRAo5PegvjarE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ts-virtobj to support overlay objects such as buttons and resized
frames defined in the device tree.

If a virtual-touchscreen is provided, ignore touch events outside of
the area defined by its properties. Otherwise, transform the event
coordinates to the virtual-touchscreen x and y-axis if required.

If buttons are provided, register an additional device to report key
events separately. A key event will be generated if the coordinates
of a touch event are within the area defined by the button properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/Kconfig  |  1 +
 drivers/input/touchscreen/st1232.c | 87 ++++++++++++++++++++++++++++++--------
 2 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 0bdbe0a77b34..d975ca308439 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1215,6 +1215,7 @@ config TOUCHSCREEN_SIS_I2C
 config TOUCHSCREEN_ST1232
 	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
 	depends on I2C
+	select TOUCHSCREEN_TS_VIRTOBJ
 	help
 	  Say Y here if you want to support the Sitronix ST1232
 	  or ST1633 touchscreen controller.
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index f49566dc96f8..b8139b7daa40 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/ts-virtobj.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -56,6 +57,8 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct input_dev *virtual_keypad;
+	struct ts_virtobj_map *map;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -129,10 +132,12 @@ static int st1232_ts_read_resolution(struct st1232_ts_data *ts, u16 *max_x,
 
 static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 {
-	struct input_dev *input = ts->input_dev;
+	struct input_dev *tscreen = ts->input_dev;
+	__maybe_unused struct input_dev *keypad = ts->virtual_keypad;
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
+			if (ts_virtobj_is_button_slot(ts->map, i) ||
+			    ts_virtobj_button_press(ts->map, keypad, x, y, i)) {
+				button_pressed[i] = true;
+				continue;
+			}
+			/* Ignore events out of the virtual screen if defined */
+			if (!ts_virtobj_mt_on_touchscreen(ts->map, &x, &y))
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
+	if (ts_virtobj_mapped_buttons(ts->map)) {
+		for (i = 0; i < ts->chip_info->max_fingers; i++)
+			if (ts_virtobj_is_button_slot(ts->map, i) &&
+			    !button_pressed[i])
+				ts_virtobj_button_release(ts->map, keypad, i);
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
+	struct input_dev __maybe_unused *virtual_keypad;
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
 
+	/* map virtual objects if defined in the device tree */
+	ts->map = ts_virtobj_map_objects(&ts->client->dev, ts->input_dev);
+	if (IS_ERR(ts->map))
+		return PTR_ERR(ts->map);
+
+	if (ts_virtobj_mapped_touchscreen(ts->map)) {
+		/* Read resolution from the virtual touchscreen if defined*/
+		ts_virtobj_get_touchscreen_abs(ts->map, &max_x, &max_y);
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
 
+	/* Register keypad input device if virtual buttons were defined */
+	if (ts_virtobj_mapped_buttons(ts->map)) {
+		virtual_keypad = devm_input_allocate_device(&client->dev);
+		if (!virtual_keypad)
+			return -ENOMEM;
+
+		ts->virtual_keypad = virtual_keypad;
+		virtual_keypad->name = "st1232-keypad";
+		virtual_keypad->id.bustype = BUS_I2C;
+		ts_virtobj_set_button_caps(ts->map, virtual_keypad);
+		error = input_register_device(ts->virtual_keypad);
+		if (error) {
+			dev_err(&client->dev,
+				"Unable to register %s input device\n",
+				virtual_keypad->name);
+			return error;
+		}
+	}
+
 	i2c_set_clientdata(client, ts);
 
 	return 0;

-- 
2.39.2

