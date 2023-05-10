Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AB6FDF42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjEJNxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbjEJNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:52:56 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82844DC54;
        Wed, 10 May 2023 06:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt5/nr0qEKeaNQdjfBTR+T11sr1l9/Nb6BCj552HU6+ED4KmhPhobLJI+AtCqQampY2t6LEwkB2P2nd6l8WbkyJMvC49GDymfvq2mis4BB+WlqkJr6E9cQd5PjJWb0QOSnyo5SkPyLLqMnlTqEgyojjKnFpUHDiRtQQxSjvUMrOzNRMRwfFKLSzv5p3hChAh8RlfLTvLHtvxdfB4wwCH3cDZ2CpSB1U2YtY+TYteG2hLKxbXJCWejcDDHTMQPLdKDZNe28JS+IEsembknI9vC4LZg95ICh1CJciDfbK9tWEznTzUxzoMTcTDlRBEt+DvcR8w935ParCzLa7789QHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOuqX80ES/n3XjsvI7/oioFCWoheiOJW/6TgOGVbclM=;
 b=mZS1APL6mf++221zv3eW30stDIkJSp12g0a5fyrtdk20iaaXeaNGQab09y2QP3p5XZz82MThovXPk7Conr/KDGAlZdT4g4VoJDTPgc/dBnDu60RnPgnXH2Izhub/F8dZYspH59xxgf46Z0pfn00QEfS4AfeI4Wzpn9ecnGCjR7bC1yHMT6ZDtSx8f4F7wOmPw//qUD+VtTrHKwU60sK/73Yhl99HacIe0yICNwLKimYTQQYGHT8U3tRTCMhNTgYNPe4ssOZQYLcWeDBTMjP1e3IvqeJtDqvFwjoDCwW8PTHucby0s8gqSOAkwDcGvtGH8ztPV5VOgxZ2BtEcJK+uHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOuqX80ES/n3XjsvI7/oioFCWoheiOJW/6TgOGVbclM=;
 b=WgdWAUaF6oEGyX1fPeyT/+/rrWm6NJ8ttHqk3NO24OTPcwDcHHkkgm74dk+jWVszYT7T7PZIhRUoCRud22Xmg3Q0pKqE8Qpv+l2gkQtUuqw+AFxEA3a62CHfjcirxzFQzhhv8UvYBLVSO8/mJ+Y8NlXxv31V/AR42x/xEEHrjIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB10212.eurprd08.prod.outlook.com (2603:10a6:102:369::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 13:51:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 13:51:13 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Wed, 10 May 2023 15:50:48 +0200
Subject: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683726670; l=5714;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=fWrCGxaXlY48WwSbRN/CYfxP5nues3x9k/+33c+j4hk=;
 b=aVn1MhrI4JhXOMAF279flCvJahcG4mP/BJWunH9hIKJheOxmF6mGL10i+kBzbNeNiK308QbdY
 W1JeUKzqa8qCmnlafjvuy0mSPtjh2rbx3PPvsDufKP7aw5JMxuUHj+N
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::34) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: 232d81bc-852d-428c-00c8-08db515d9dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i5s+7sy7N1zpBERTKW773zpFALz/rNXAWBMCaz7tsDi3jfFAhxmkpgAPUlpoYrS7n1QC+4C4mglcwWNqjhVt+/4seM9OEJVzujEaYS2TLEyrV4LV9PLJz6ytCXc09DL6v/O0Fqu4VFlsHNGz9OTkUFa19jqHwqEIVfMGxg4M/SzmYk9Ey/wVU9kOhKWyMJMwJZMPyvIZ4QzYLfUNL0UBTf+hzaK6aLIh8G4NCnBheJp7QWewUakmbggPUVqtAEqiLC6xgYgqs+akepb5nqHnAUcg+0i4iI/Phe9fJBNqR0ybkPTxHfXiPhjL1egIAmbbXQjelIEACehHKwdZVwpKIulbHa/9uf5hHAW4+48ZHivkbIjfO9VVb5aXYmPAuWEehggaxyaokP1oxTYfCOu4YcIiGWxNcqlGiqBpplkA0kKEBbTF1XBsDrYMF2LIIyiIN/puBRpO8AJWTy8Opmq4oGk0abw/68xrGXB4b/uKF+GOxctR+PbfxFbQKYEvHJ4JAS2MW5ChUbYBfNVQspZ6NuVpuSkuyvvuE4wWB0kE6S6bsZHdBn04a9xu98HLWiFVEPtz/iy9mDLlpH1edC/YkuqagCayQsjRcAOaiJ2lWLcA1kQTpYXuT1BG+KM9kfYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39850400004)(396003)(451199021)(86362001)(36756003)(6666004)(110136005)(316002)(6636002)(4326008)(66476007)(52116002)(478600001)(66946007)(66556008)(6486002)(41300700001)(5660300002)(44832011)(8936002)(8676002)(2906002)(38100700002)(38350700002)(186003)(2616005)(26005)(6512007)(107886003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxvd29YdC9MUVBSMnR4VnB1cER1Z3NCMXRBVXhhVHd0Y05oRFJUcnVDN2pY?=
 =?utf-8?B?V21IQ1B2MzE1ZzB4UlFYbmJNTU5yQ3EyYXJEZ2s2L3F0aFpFZCsrRER2M1hv?=
 =?utf-8?B?ZnM1TmdsSThUTE50dlFNTWpRbFpxM1dRT0w3MmdvQmNvTlQyNVNVanQxaUg4?=
 =?utf-8?B?SFNjbDRyWjFZK2RKN2J4bTdPR3Y2OTBWSWMxeHZzNnFWSklkWXVwb3RLZDMx?=
 =?utf-8?B?aDZHdFhJbFNhT3Ztb0F5eGlXcXIzV29WZ28xbmlLWW1ib09jNDcveG15TkQv?=
 =?utf-8?B?NHFjV3A1YWtzaUk5dzR1bGRrT0pjUm1zaDZrNG14TUI5ZFpybUdJK1oxT3FM?=
 =?utf-8?B?SXdocTFGbHUwQzY3Rys4cGZwM3d1K0NRNXU5SHJJOUlLbko3ayt5THNybkhw?=
 =?utf-8?B?YVBTb1pOckdxYjNYVXc2d20zdVlIL3BwZlA4YXJzNXZ2d1BLS2t4Mm4wMUlE?=
 =?utf-8?B?bmNGV1lmTEdlNnJmSzV1U05oTHYrZ25JUHRIRkV0R0MyQ0NvOFB0TDRUelY0?=
 =?utf-8?B?TlZydi85SkJxOTRUWTRjRktZZHU5VG8xYjJRMG41ZXhadjhJL3ZyWGFQU3pn?=
 =?utf-8?B?VVlLUzdQYmhic29oYWJCWHNOeXUrUnJqbHVNVG4rMklKOVR5dlBMTFR3T3ZS?=
 =?utf-8?B?anVubHJGT3UrN2RHenZDWm52dE5JaWwwNU83Q3pZcE9Ha3kxQmM2NCt0akxo?=
 =?utf-8?B?K0FpNjZMeHlYcVVkcTRIYXQxbk5kMm9qUmFiemlQVk1uZkZqM3MwOENON1Y2?=
 =?utf-8?B?ZnNsc0srTXhNZ0t0L0JWeHpsQVJ4U0dnS1VhdklLOXFxTk55T2RYbG16VS85?=
 =?utf-8?B?UnFiTWlnWFhKSTJ5YzhPQmg4TGVOdm1Wdk5oWUkvUjJRV2I2anBaaFpTV3Jy?=
 =?utf-8?B?N3VGQlV4QXRjTUl0V0hiOGx4TTBzNWJLazNtSzYwU2ZzeXhrQWwxYXF3NnBQ?=
 =?utf-8?B?MklQbkptK2xpajdMQ2o1NTliaHRZYlQ3RkRXOTV5NGVISUo0MVIvN2YrMStN?=
 =?utf-8?B?Z01XMm01TEZEUmtzQ0lTRGxFMWZYNUhzS0wrdk9aZ1crbGF0ZVozdkFLeUdX?=
 =?utf-8?B?WjNDQ2dVeDN0b2pRanBoVldKUFEwQUk1bTd4Y1FTcjJxSG5sQTRQRUNLZG5L?=
 =?utf-8?B?TXdxdUF4cGpPZ2lEbjVsZTBtNy90aXBtQktRa1Nsd3BpbUJtUlpOSHZTdExN?=
 =?utf-8?B?dWNXdHZURTVOcmNMM3JZcU02eVlOcGJBa2xGSlA5YnhFWjZwRW1DU2lxMHox?=
 =?utf-8?B?eURtN0EwODZWREVwYklhVFZHMUt5UFFpQTM5Y2ZZd1lhWmFKQjhZaEUrSG5G?=
 =?utf-8?B?TSs0OUlCSkt1bWJsN0ZYQitySmdHZ1NsSWYxT3ZBbXlZTHJIa2sybHFaL0pM?=
 =?utf-8?B?ZXg2VE82TmsvdkgwYkhYNFJDUUxxMjNCOTRoZTJSQmJoYlJIVUdLUGJmK3Vs?=
 =?utf-8?B?UnFOekJEMWdoNVFFQkt2REZKUlkxeHBMTXFmVmY3dURpYWMzbXk5dklSQWhR?=
 =?utf-8?B?Ujk5WGRKQkxFYzZuRGM2NGN0WnZmM3d6ZjVrOWx6b0wxeHVrYVRrN0ovVWJO?=
 =?utf-8?B?bTNqQWdvYThLbTNaTmVEdVlXTDVzTW9sOW1BRjcxTzUyNDB1anRWNUlCM3R0?=
 =?utf-8?B?dStMa01XdTF4RG04SVBHRjM4YzM3eGp2TlcxRkxGYTVnelJIck5VNEpSYjVk?=
 =?utf-8?B?SUMvRys3QnBGSENHdkVlWUNKSVRYK2U2bDNGbm1UYjVYWTVUUTFUWkFhc2g0?=
 =?utf-8?B?RXg1ZjNmWXJua2dTbGU1V0tXUlc3OVNsekdaQ1FtaitHTXhZd1JyK3Y2T0dY?=
 =?utf-8?B?OE4rMytVc1cwR3dBbFVKdTBpemZvRm5Od3dzZE1qYzdrTzQxc0dLVzE4cWlN?=
 =?utf-8?B?a0VUNkFKakhYMzhVaUwzNXd1Q2EvVklQbnA4QmFxaGp1QkxBS0UrZFpDNlc2?=
 =?utf-8?B?NkhJeU9xR1Bxa3M4N2Vmbm1QeWVNUlRGS3dZOXlLN1RCVEdoQ0pRTnc5NEQx?=
 =?utf-8?B?NGFuZGRsRHlGTG9nb1JVd1hBQVJEOU1KcGpzYU9ISCtNSFRZRHY2ZWluYlYx?=
 =?utf-8?B?SVpPemU1SmM4ajE4Tzk0Sy9kckNxa2k3RW54bVFLOEttVTRJVXZsQmdPN001?=
 =?utf-8?B?Q3g5cm9WQzk3c2ZVdjFsUGdWeWJYbnJET0JUTytncmFWUEJoOVZGcThRRzZE?=
 =?utf-8?Q?6sUcvEbFYzjHe+0kFEklE5g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 232d81bc-852d-428c-00c8-08db515d9dcd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:51:13.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3HvyBafXPCY0h1FuzM/JTxPCcX58gjEz3jzKVVGbuXvpAOlTAhAxvjIy6m8RwQWQ28nLBuMKPU6ekHUny0ILch9WMErqGy3RMKqHkX0qPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ts-virtobj to support overlay objects such as buttons and resized
frames defined in the device tree.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 87 ++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 18 deletions(-)

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

