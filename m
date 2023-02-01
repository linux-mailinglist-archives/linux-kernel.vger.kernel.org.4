Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C45686A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBAPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjBAPXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:23:21 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6F66F91;
        Wed,  1 Feb 2023 07:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTbbE+u8a+baN7mhRzOoiz4r2YV6PGi5pKdAIn7eT5DTND7mdeJccPyY5CdFJ698Vb4tEfrxGwde9wFPHU/xsYCG4DV6GCb75ErLoYlnouuy1Ab6Qv9lCxo6VFb640OWBLNSsbzy5vI+dzWROl6zjHdCe5jjjxJragpg3lD8ONVkd3GITQkLYlIXDI7IVtiWJUXP2Li+nX5eeF1LxA1HuVFRNlZqCPE4ASoetHGKVb7Fb6hXm8bUNPGOHVEU+Kh1g1H6Hjm0LV9AO8oDSfTQF6kS/Hx8yiNv/ncokPrnktw0owux+Eo/yjGKQO90IGrbSV2LeRyJlpY08uwOnZh/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RtcZgibdLmaBEk4+G+xsLnM253T6SNgGtNlHbB1GvU=;
 b=Uk6yo18TCFaKf6UNts6ICtiCeAJ82o7ytWLLKbjFyTRJ9TXoWbwVF94gxJcDzGybqOvfMqoPwBw9hWvTqnh5PMAhTPDK7uuYwi7HuyFe9fuVKZLxbXk/1xKMxp4Sz+YPFut/t4UXI4AXxKODyPybMnhBNaDfXvWqdxmLtVC5aRMSiiNW4iW9VDNq3hlSX97uEywAbY7RHr4Mnd+6QbXUPVjOmfgudIGiaOmo/7cruGUrFKmApr98RbJro6Dotdyz8Zi/hMpmulD57ZxxTzrl9iIy7lg5Ei7wnJU/5HGSMxMk6Llie1XutHGPtKAWdKem4vaiXjPtXgyXHQbevNk75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RtcZgibdLmaBEk4+G+xsLnM253T6SNgGtNlHbB1GvU=;
 b=EuUirJWAYhhoI7/L3gnL3bJckgFJuljfaJ4MrNQNgw/CYb64FwwS2ZrlkLroPe5siP94u6hRyRt+z2XF7488ly427AgP+HxW7PnP7I8+94jwIz9/f+RsMX9vGhlLEaoca2kLk1DODCExTMbkSoXmF3TT0UEfWQ+ix7bm52llr2waiZULe4YKGeC6uHstWiVS1uVdIYch0/YJy2zhmlVZ6DvQBzlOliSE2T5bg5xWitQarcGEyniY5DHyqrAVdk+c1EJj5NGOdc3dc15rp+Nmbcu2UqYQBqy9WQLRdsRGaDRSkkmXhoqPvtMk88MDiJpQZFLRTO5t0kVgypSt3PvHiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7380.eurprd03.prod.outlook.com (2603:10a6:20b:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:21:40 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:21:40 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 4/4] input: pwm-beeper: set volume levels by devicetree
Date:   Wed,  1 Feb 2023 16:21:28 +0100
Message-Id: <20230201152128.614439-5-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201152128.614439-1-manuel.traut@mt.com>
References: <20230201152128.614439-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc5e311-2e35-441c-1980-08db04680496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsl0KsVt/O7vxH8S6BH1V9+mdOT2FI7oBNK7FbaaPMMTBC0HKFpKMAaax1LsAN8VT4DdZK5QGs6ESW0ETEE81UkQgenyyZuH2Cjzb5+nlExjNS3LgpaoPJa9SPZoNX0KnkRTjZ4TQIJT906yTGuiUFCFWNifuZA5CN+ahV+5gVxFUv7ubmZ7NdmCF2OO62ukemBuBOEFJCVvRKABl+tMa1DGtId/7Hve8pl3IpBPO4hJcpZ1KM2t555gwCOIdz/Z/C82TZS+jvcU83XPob2aQb7YoNIklxomgnCxjENT00I4CZNwtLyymYf0uLdKz9Ive5k4D26VNrxmAquScMbVghMMN6DLrqv3II4E1oqUpuR2wy1Ov8yaVX82YTNKYl+rQ04iPCVnRmCzVthG6wo31/PLIJ3fWdBGsfeG+7za0SJCGv1PnFbfNncfpVfoN8KjN49RwmQ8xZ3pIoLSqEMrKjr5rZWDhz6jHoMwGqeUReYqgK8kq8XEXEgqpNA3rMW3eLEmGHc+uMauYnKmFkZ3u3QYFz3e+n6aT2plFAHNam2/FYDDhJKtIS8L6YTOHe3KqrbtZDlhK706FijTL0P3g0UKLL46KajZ6nSkMe3SkKvnniur03LMBhdFfPvZHMPCvjOLnAkIl9+L4c9zUnHxFcbT3wp/wyFdLgFvyiPRR1CabTuLnOIXLy5k7yIXWn/Wwl9kQBV0RtLblvk4dQH9kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38350700002)(38100700002)(54906003)(36756003)(86362001)(5660300002)(4326008)(6916009)(8676002)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(44832011)(2616005)(83380400001)(2906002)(6486002)(52116002)(478600001)(186003)(26005)(6512007)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2KZPZPFNtBcJqTxdmirO68wgps/QyCHOSSSLfeiE5em5v87y+oyRHaPYrNh?=
 =?us-ascii?Q?iHVvZ1A8Lh0D1wqM90NFoRV3R2DvznpTzDvrIa2+3yxAynAB5/WzB//UZ28R?=
 =?us-ascii?Q?AawVghfQ39HCP5Oq6uhGZpTVOvc9/vYo6MxrHlectZ0q2spBnGYeQ/yuh7Eb?=
 =?us-ascii?Q?TquX7DFmj3fRrQjrh0KOa6VfDxoxWnABkC1Z3IPKy5gIZy7qR/pbWVScE6nf?=
 =?us-ascii?Q?ndOgrygv8EHi0NrOjShBQrtjCUgYnhVWne+LMIHpZM0ItCw4xZ2hjcqFmnuk?=
 =?us-ascii?Q?BxpJd15PmcJ8+IoldkQpt8sCF3wHwegwixczQv9sYGuYct/chXCmuWsDUsYw?=
 =?us-ascii?Q?il9fbfb3BoXymyUVC1870nqGIvFJhmMBT/IK7nZqU11JZjthMbzI8UgE0FEC?=
 =?us-ascii?Q?wj908DkvHB6EtGNubXZNjkGv9mjpJ/PU5J4Hv6FTIdaEmGoEu4Hgy00j/WaP?=
 =?us-ascii?Q?14gwmBlGkUxthtL3nnZHp5AhZ6fnAeABAyirKDLHGU8+NgxbRpES7J+GMO+w?=
 =?us-ascii?Q?zupjnAE6lizVUn6zslVT2tZwLH+WVMrOMZXhDxzNb61pLLIaGsP2kwF85B/+?=
 =?us-ascii?Q?vsGsM3WKAQvlWkUueUId0zfZHgUv1plOB7sns5yAWABiIuaO8n+xJBtH5GpK?=
 =?us-ascii?Q?48HW49MaeFbCBSGH44xJAvBWl3nS2kD5iotVaia00NQzhp8MsPoQ8QX5GUcQ?=
 =?us-ascii?Q?IERGZ8c18FOgJ8Leej0hoZ6gyqTlFSZaMUIiHTmTz4o4pklnTCL8PXJUojRZ?=
 =?us-ascii?Q?h/AxTURhrN6Z5NA/8ujhZyR6X9yTN3ZEl+xFgSuWJqLFPb4FQDJsEV6yobPk?=
 =?us-ascii?Q?zw5gH9GIlPQ4PveXuGyBZv+3iiLjRoIhVio1r0qLdTY8jyQE4X/6G7eeqB9c?=
 =?us-ascii?Q?EP6ln2siYPZUyAbgivFM/MTr757cH2uZp0H/NpUBFsxOvJwgzRTumKq9e/mb?=
 =?us-ascii?Q?V7Nl/v7MSe+PWRoGxm+flj+DaWEvcsjm46a3KTtTtSE0AgeUnSMVZbdr3JQg?=
 =?us-ascii?Q?J2shhGpP/cm6n9JwoYeE+5+zBdUqnr029D8G/Tb0IGr5iCTw47YcwfeJr8Bb?=
 =?us-ascii?Q?lvGV2xFKCkqtJnrsFAuyRQpqd7RJsomO6k4FadgO7u3E3/QKKU/36x6hrwBO?=
 =?us-ascii?Q?xX0MGvN19e0vaCPb/O4khXz3TuIq1oW/DISPXqTwcQHWFZDB33NtcTWvp6qf?=
 =?us-ascii?Q?dihu4oXKChOIWgTbU5SNpTxKdqN7+Sns4k5IwOsdLVhGRauGkdARFptM8vw6?=
 =?us-ascii?Q?B/N3cH55uJOqUhRA96Rk/uq4PJfuke8DLqNzcmBYDZrpELZ1+OgepveZ55Wg?=
 =?us-ascii?Q?+VEFMSOIF93beMk+ikRkkBDLlHNbvLzDAhcBGkwIWNQ+xKySEsFJ1CwCPiEJ?=
 =?us-ascii?Q?ugPCo4CiUdtqaJQ9rnrNMzwUVDbdDVzVycUvPo+Fhk3VOYRCTfl0d/0Qt1O6?=
 =?us-ascii?Q?3TTjCE2Jsqbx19sLcAk4hYA1HVnVfpkcsS0zrcmIhMR3B9EGm3BFVMkc+rNN?=
 =?us-ascii?Q?yspceueyXLHmuFSTo95i4Zq4dh9oKP0sfaO+X6SfTdGNHWGG1LrN/ITpqsv8?=
 =?us-ascii?Q?JpTAKyMMOiDcigsf7AqSZ2BZfixYV59Sgf/IQzzU?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc5e311-2e35-441c-1980-08db04680496
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:21:40.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qs+b0Dc/OLi/sEb5eUQh9Gu3msg5s/iSc8SyDCa+AKQeTEQZhtlkHsDZ5ZT3Qzz8ICeAKfYlwsZJE3QqWcl8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add devicetree bindings to define supported volume levels and the
default volume level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>
---
 drivers/input/misc/pwm-beeper.c | 73 +++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 214d3fa0a06d..fc367a249490 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -93,7 +93,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 
 	state.enabled = true;
 	state.period = period;
-	pwm_set_relative_duty_cycle(&state, beeper->volume_levels[beeper->volume], 1000);
+	pwm_set_relative_duty_cycle(&state, beeper->volume_levels[beeper->volume], 10000);
 
 	error = pwm_apply_state(beeper->pwm, &state);
 	if (error)
@@ -181,8 +181,9 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_beeper *beeper;
 	struct pwm_state state;
 	u32 bell_frequency;
-	int error;
+	int error, i, length;
 	size_t size;
+	u32 value;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -228,23 +229,59 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	beeper->bell_frequency = bell_frequency;
 
-	beeper->max_volume = 4;
-
-	size = sizeof(*beeper->volume_levels) *
-		(beeper->max_volume + 1);
-
-	beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
-		GFP_KERNEL);
-	if (!beeper->volume_levels)
-		return -ENOMEM;
-
-	beeper->volume_levels[0] = 0;
-	beeper->volume_levels[1] = 80;
-	beeper->volume_levels[2] = 200;
-	beeper->volume_levels[3] = 400;
-	beeper->volume_levels[4] = 5000;
+	/* determine the number of volume levels */
+	length = device_property_read_u32_array(&pdev->dev, "volume-levels-bp", NULL, 0);
+	if (length <= 0) {
+		dev_dbg(&pdev->dev, "no volume levels specified, using max volume\n");
+		beeper->max_volume = 1;
+	} else
+		beeper->max_volume = length;
+
+	/* read volume levels from DT property */
+	if (beeper->max_volume > 0) {
+		size = sizeof(*beeper->volume_levels) *	beeper->max_volume;
+
+		beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+			GFP_KERNEL);
+		if (!beeper->volume_levels)
+			return -ENOMEM;
+
+		if (length > 0) {
+			error = device_property_read_u32_array(&pdev->dev, "volume-levels-bp",
+						beeper->volume_levels,
+						beeper->max_volume);
+
+			if (error < 0)
+				return error;
+
+			error = device_property_read_u32(&pdev->dev, "default-volume-level-bp",
+						   &value);
+
+			if (error < 0) {
+				dev_dbg(&pdev->dev, "no default volume specified, using max volume\n");
+				value = beeper->max_volume - 1;
+			} else {
+				for (i = 0; i < length; i++) {
+					if (beeper->volume_levels[i] == value) {
+						value = i;
+						break;
+					}
+				}
+				if (value != i) {
+					dev_dbg(&pdev->dev,
+						"default-volume-level-bp %d invalid, using %d\n",
+						value, beeper->max_volume - 1);
+					value = beeper->max_volume - 1;
+				}
+			}
+		} else {
+			beeper->volume_levels[0] = 5000;
+			value = 0;
+		}
 
-	beeper->volume = beeper->max_volume;
+		beeper->volume = value;
+		beeper->max_volume--;
+	}
 
 	beeper->input = devm_input_allocate_device(dev);
 	if (!beeper->input) {
-- 
2.39.1

