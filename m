Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0722680FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjA3N5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjA3N5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:57:13 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2099.outbound.protection.outlook.com [40.107.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C9F39CE1;
        Mon, 30 Jan 2023 05:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyzjX8CcjZSlNXtW855dIZ3HusFVCiPMup2jtVavaNo8ulmF+scHgYzQlR6ltEUlEmoiSn8dFXl7RG/7C9SZ+ER0uGMaD01gX7m4quFnAisuEB+Ep+Nw3U8a3Er41M6DWUo0EqsuF0GnXqf47ShCKHGaGOmsHNe8VSbFPQSfoCpLvUqDoIQCU6g/w11V2ST0Eu/O6CLujO2gc7vx52Mq3Lg81jNTi1ztLsUDJpBISiyYg9wBG5VvK3dpt6D3ge/Aa3Mfe53006aejUkA1AMkp4+94MO4x2qX7X0Jq0jrqAHMjQtmxEqRtA07kTkZKlrsUOBeBBLsAM9Uz6gE+4Tl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU5lR4KqLbCbHm/PIjKvuM2WQNlI/qNO/U6FvcYVC0M=;
 b=mUtMtC2fRKgbVahcGJt1+m9OLDOj3alpMKPIddtFudNtO6gPLoQrP22dTaFL+8DB98ujJvxlqutYJLGOMWblnH8WerYKv1KCP6tXChoY5zUjozzBjzyn7a+6fH29TK43t0AIWKzlhPSgWL1MdF/QYDl90Cdm9CY2bt64VZFw1iMZX66CDZPEhEG15uHxZZCcF+lNJqFzc8txlLFmj8eSrPaXh64WeU/yoiLhlXWhBbJgMykQsFR7zwPg7jlamSdYuR0kgiDl+3LE1WxG8TaxJBTNiDB55K7HE5+Jfjp6Z0rNrNoydWNvrXk97AG3dkCCaYbzVl6PfX/j/vt9UwcKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU5lR4KqLbCbHm/PIjKvuM2WQNlI/qNO/U6FvcYVC0M=;
 b=UDuIqgEKUjWEm0/oGRlJt1nJE3E85XekYxPrFikSZu44tm75Jak+KyINSrAfX2FX1EBx+H6EM2mAFFG08/iDRiEOhIoFWtUrXkP+7wmmrYA/NGGXFDD1YvOY5UbMXi25DWo0Tj58sCzoGqSGETCXGw/ZA3znM8q4pP0WCK5mXvOSVRjeIdbzNLkBaYyT3y71NNCHY7h/83GZWtpoPB0RUXeLIyIKrNCJT4sQwSPsVwndvyeo3+SIv+j8VgOduCcB9j673Dn/5uIf2UH7WsF6qQZg+ZXvvza6k2ZGTr9Lmssjl8mgEuh0RbQi7H2eFmHQdOcngSQUG9d+a0cNPVfjNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAWPR03MB9081.eurprd03.prod.outlook.com (2603:10a6:102:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 13:57:10 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:57:10 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manuel Traut <manuel.traut@mt.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 4/4] input: pwm-beeper: set volume levels by devicetree
Date:   Mon, 30 Jan 2023 14:56:50 +0100
Message-Id: <20230130135650.1407156-5-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130135650.1407156-1-manuel.traut@mt.com>
References: <20230130135650.1407156-1-manuel.traut@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAWPR03MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d76efc7-29ea-4c40-8a26-08db02c9e214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xO3l4LYCXUHKJO53H74OedGb9tUXbYQtumd2D/Ra1LQECYMA3xDwA+CPb0vKX9ZYdQV23sy/VWjhg76KM5fJ2se90Ctyb6ewZscET8TkLAgtkk9tc2qqwIXPubh1VOcNg4/KlOIBNI3R6tWb2LBYvff7HAZ5vLRrILgpgPyn96DOak8aGmsce0tyU9mxCDICyitxD1UOZusyQlPI2vbxR6g444UIr1J6wbhAjdcdbdmLQ18mmDfrdtd//xwtNzvQSWjofby7w7hFrALOzVpDBTAlaBYtPuy46JafoP7DQVcS5cylBnbznVQ1EeMHHJwp14MSkzcHoTnQsAHZ7JGFL04ydeGizClPU1JkzhVTMcjPtC4CEVtXlF2VOHvTEYXge5X/Jbp3ROp7q7HCWcTfprFEVyUpch0bIjqsBFEYUfZVu2yrB/xp7PnhatVGeo/DGBx+mR8Z8TtZzxRdcLQKcY+ppg+22Ww81DhfoOGViYU3TpIqxhMFIMwk852fumakSV8oKbQ6M2EWtUz1L2CaABLXQkrtVOLMQCFNayT77f4fZh9NDtgx4ifkeWYbaGoUqxecXamfBa8I0VAGnmdMfvXlCn+YPMXjwGt0J1BlNVE/l/wODYBBZWIQvprpFZkEjh3/bVr3dm1EYcPcwMHqV0MonOFr8rwwyVECBrxuzUEnjVO4ZAojI5HkepZomzXragVGZX0W72kjOqdqeLy6hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(36756003)(86362001)(44832011)(38100700002)(38350700002)(2906002)(2616005)(52116002)(6486002)(6512007)(186003)(478600001)(1076003)(26005)(6506007)(83380400001)(54906003)(4326008)(66556008)(66476007)(8676002)(66946007)(6666004)(6916009)(316002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JKy4XGf4wrGYPl/+8lACYhOCl+N2wwYm3kOFzUyCY1v/ehcAoOcnekTD2BWF?=
 =?us-ascii?Q?Mzn4hZV79VcNuJTR+kr3n+wgeyXd7DlRYe+ZbPZaOU79EtBR3AkPr++x3a90?=
 =?us-ascii?Q?XdoE1GheY5CAEpnK8PKJIp2xXY7BItNxWDPgsI+KKG9VElyvdn5zkDmFYBya?=
 =?us-ascii?Q?a25aMT/sm9MjSj5HCekBT+0JtBLu4gK31y0l7Cvirn/2uxY22R4XvGH1j0aG?=
 =?us-ascii?Q?wMhksHw7A+UfXe4pc5QEJmCzLPG6nMXqk3os5gTMvSAW1X+pm7IC9OF5S0yQ?=
 =?us-ascii?Q?heKLgLNQkfeC/ZuDh4lA8iHRro3OsZMCL3Oj0P9fcQnWEsLmrGYYMMa97dq1?=
 =?us-ascii?Q?ptLMyulr1nz1j+OmqKVdltcx8EXaY4PZuP1HH0CTZWK86gZ2TFkrbfv7LoRg?=
 =?us-ascii?Q?kj/S8mDO0d6Jj/k+V1EpoXFwmN2DfyzfRNB++6P+cym+Ie8i6rMbD1Gm6r61?=
 =?us-ascii?Q?Oyo5/cyexte8uZj8yUTd2pIsT3fQQHv0TEZMmB619aJcEgqj4mzBuuRWngmx?=
 =?us-ascii?Q?PzYeCVfyXy1lwZCRlonH/BXKk/rK7E2UoQwg+T2oxv4htAPGUM6dL3oKcU9C?=
 =?us-ascii?Q?cnO8dPWc1h6qpffErU2raJMymgMOdZ1GkjshHjLLB6DWZj+qIS5yRtUU48Nv?=
 =?us-ascii?Q?Fsoum0TJKS1ed/qH4azXyQ/RJUvBRcT/l1Y+5SfEt2fm2tly2wPBPGojKioj?=
 =?us-ascii?Q?dl4rOecdgeHToe2kfdFjatGbbR3leGL9rsSgdGoAlSgry6Uc1hd5MrCUCP9f?=
 =?us-ascii?Q?gUtugaoyffKDuhMR0SUV+9yyocxPnRNFciqTfx+BotDZKSFPQvqjemiM2Zde?=
 =?us-ascii?Q?X92EydB5ZOiZtNBpA+ANVjWhp3LOuB9BUFt3Nziet0HZT6kQTuVmDe4uy6B7?=
 =?us-ascii?Q?TBBW+dh8rCKoxVKiWSv0aSSSnfZkALZ9cQwnIIzFHvLKbBKxHhAuKRnPV4Z6?=
 =?us-ascii?Q?GbO0VXu05IITYe6O4FXBUpK06KuNTaOSEqTLKQo11o/N4fgUsbREMapM7IGT?=
 =?us-ascii?Q?yCXA5vbnLeddUBHsPfR/OvaqKIj0xeA61sKsrShtaU0eVQvwa8ybGtM8dsES?=
 =?us-ascii?Q?oeYBRkgMvjen6N5rdfQpERfO4lttUFHxZo6KBK4wio54x0VltEvaD7MVtlp1?=
 =?us-ascii?Q?DjbHA3XhT0H4zmVXPAhazZTtY4SfDgBSU1Rphg+0KEmDbZ8/Y9QSSo/a/vZ7?=
 =?us-ascii?Q?h4L+I1gw0qz7OV7cZdIhjF+fqLZ8PaRs3u7TW/BT4g7R2XeI0S+wAyfFIqeG?=
 =?us-ascii?Q?Lv2lc6Ku+He0Rvq4HoGaUetMLSkJTyYJKhnmZXMASzOKyE50+3VcflQkQVgE?=
 =?us-ascii?Q?D6KcyuajF4U2v0ESuoZ1xrIq1v0XNo6tjMRlbEJMq+5X41D07yKUKaRV+Bo7?=
 =?us-ascii?Q?hpnwgmymd/WmAv7ov5V031Az85HFtvLqm8LZNH0b/vd2thb9QPdUitS9TUUa?=
 =?us-ascii?Q?D4RwsYDaAHLsuX85isWbXlgkcX/AppuJxEFDkTfczhPsnPzKrmipcDqwawu8?=
 =?us-ascii?Q?Lu9cHDnOZ3B+ZSxqzqOLKLG+YdaKA1MGVXcdiMgQ8/p0qghpaoaXlOKj69M7?=
 =?us-ascii?Q?2G5XelvdtD0ZgWKy7AtbudR3LVAW2oCfl/sTTqhY?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d76efc7-29ea-4c40-8a26-08db02c9e214
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:57:10.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znQfLRlCC/40zxP+sarJlUa2wcVpTS5QhQCMQbbXWDXGqHTlCDy+3UZekTxPxY9Q53/PoUWZx35GHyXtEAQIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9081
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
2.39.0

