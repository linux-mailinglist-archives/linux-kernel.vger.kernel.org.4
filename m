Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABF67965C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjAXLOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjAXLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:14:14 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D13E622;
        Tue, 24 Jan 2023 03:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFnfUOJerRBCqlOvh1HbGD5iN+ihiUkwmF0qFVeaSOH18GBTVfs3Aer+2V+9BrtKJQn6ZK7IPE0z/dza2b/iJPe6PlYAUWO0X7B0yf/jkcp5bTImPEwStJFTc4SahUBnjpS+22E+QHchDEo3rL6QKMiKydAviSA322vjFs1hLcWlLYvRXWynB6SFK+z24orSTvX1e7rbvQ/5t84dQYQVN/lEVF0s+pAPFrCQqAg+a9d/QEiC9CVioqjwy9ccXtIlRBVFAelYr7fiH/r/2ZupIzfxenNobzMYMIYLhwIJ6utdiO9MJV7PuQdT/KMfsKXpAni+krjR9ArzQATfWHMV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rk0Ec+f7oeGVYewHTLfrRpUquwMeGurtyfD8/9RDIw=;
 b=aU5x6Skv6QfjrN4oTE04wpvxerYiPThjj5mtThgIYfHgDdNJqoGfC091HRji37A9IQ9xqUs3CDO7OsGLN1+N98uKyfo18iTcjl/mwyiaQVggKJQJXnd4/M0q2ZeztMYss9VE/e/PoCvYEpSPKtgZnXEAAujQojwsrLMPdmz4AFe5Kp0gz+c18JT9jX+Itq42cVVGR/N3XDBea9OE1wsxjyBPjLG6H5HYi3GNujRUru7P4taiNXPq8fHCn+XJG3UnFCiwZCa6nDf+zCDQBC5UjEB7uS/etwbWZqamY1WX9HALanvQMXi/u1kU0kbrHjvNiAEiXgckquNxIqgP+XhYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rk0Ec+f7oeGVYewHTLfrRpUquwMeGurtyfD8/9RDIw=;
 b=t0vGNhSCPY1PSZI69MO6yxsCYR83u3tUBNd63ZcCFj2ENVVFtTW68E5+ebR5GzFxlcPnHhaM9XBxllUISZpXZDV5TpvfQ7raZnJvMogvip/dNMRfPNjJJzrQyvcH2b58JzMphJbTYcmEKyx0NPdEHWkFEWSc+1B34L45IwVTnH+NzQxkcfxLPLnkwrdinLPFLPnd3NxICnXHCGPtR7VyvoDZvS7k757Qm+ZvLxtIez932E7HEw68iQidv32tc1b4Dpygrp2TqDo14WGJN5qbrdYmn7SII+tjWWKtLuWiZMJZKSiIgTuthn/oht7JBlj1t4ffmzKKbydSaj+012baEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DB9PR03MB9639.eurprd03.prod.outlook.com (2603:10a6:10:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:14:07 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:14:06 +0000
Date:   Tue, 24 Jan 2023 12:14:04 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: [PATCH 3/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <Y8+9fEIFVuLL+8+6@mt.com>
References: <Y8+8824hy/fWkpEk@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8+8824hy/fWkpEk@mt.com>
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DB9PR03MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a47523-e166-42e7-f3b1-08dafdfc1bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VHmlfZV2o+WRqMuDqIefGbUy5j2xgKhQjXAxCX2XA4RRnHsYGuLUukxdK0NaVqdy13d8nL8Us6BdqhOtEz5jC369d3UH2dWgD3/ksfKTAnhQN12xeDsdC3qX7RrSLKXNG7DqFTO23dO7cCQdbShwhlWJnjjI0Va0bUq5fLeHT92c3Aq4jBYOST04Y/DbV3KPdymWfiPFXQiyaBeNofWPo9ZXOX/KM9hOBMzDC+cKeaDikFlN+stXPTpa45ErlP1w7aa4a96sypy8LESTKaHSurIP3MvmUv/ZRZbRhvWMO+uBxbYlhlxQGw8nreeBiL2Akk1rHl5FdSA5yLOk18mHtifMVg0BuEmaPShXXTKs4WVI8w2o9Fsgj4lauR8kU+VBlYYvXZXTnFjzMBgtELUbxSR/N5fZ7BG/Ar3t3Y51/0gsYGOjMhPDLiIzgRQS93Wp/+ZM7jx0FI7Pb11x3s6rA+cAmGSAs95ZvnbACRK7cH5HwN7G/s+KMB41B3WUjLj21OcL5jtxaasqAFjJ7JoZNE14+mXligyDgtnBgXARf0jcolvzyOcXXiZwNkrPFQv2iQ08LFVN2HcnTVnryv7Nnk4DVbZ3caPIsCg+wmk5Y2g7N4f5CclHooMPezjWPmT033FnuT5r3ZIP1qk98mVAT2tGkyDR9PxgSq4rdp69dLTwx3S913RtEp3atUTIgTDJp3yv4lA2PKmDWuo9sAGJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(2906002)(83380400001)(54906003)(41300700001)(4326008)(66476007)(66946007)(36756003)(6916009)(66556008)(8676002)(44832011)(5660300002)(2616005)(8936002)(316002)(186003)(6512007)(38350700002)(86362001)(6506007)(38100700002)(26005)(52116002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZEMEtQUzU2VmVYN2hyb1RCcUt4L05MT0F5MndqbGI0K1pnSENjTjhVT09y?=
 =?utf-8?B?OGJybzFETThyYnJSZ0Z4UlErQ0ZXZXcwdUcwN1kvRUxTLzNHTW9hT3FXMUdx?=
 =?utf-8?B?VCtxK2NPZ2ZZWjNQS3cyWWM3TER1YUVYalJTanRQZ2pKQkpTUE5EZkdMM1V2?=
 =?utf-8?B?ODFaZTdjaXFiTTRYbDBVbk9McDN4M2RzVUdFMkJGbk1BSGVlUUZjVG1iQ0Zu?=
 =?utf-8?B?aG11TTlpa2gvc2RnS2pNZWM5NlVkSmoxTFVRMU1iNUFiS2NMTjBpVW5wbG1h?=
 =?utf-8?B?MGRpSDRrUGNKOGYvMWdXcmZhWkJ5d2xrTFZUSlVXSE54TjZrN1pZdDlTWGdk?=
 =?utf-8?B?Y2FiY2N3RFNoTmNPSnJkNVAycWxBTjMxbC9PcXc3VXRpQ1ZXTEdqRjk2YzJy?=
 =?utf-8?B?WlpsL2lidU54R01TTjJTa0dEeFhIVUdPY0RDOFFUbFhrUWZpUWs2SU1tYkRN?=
 =?utf-8?B?ZnFtL29zR25XY1JPSVpXblJzcmt0QnFKRHY0NzJZaUxzOEp0NzloK0NSR1Fh?=
 =?utf-8?B?c3BHajFTeXNJQUY0M3FmZUt3TmNSMG1tTGtJc0Z3RktybFI2VVQ1d1RyVWVj?=
 =?utf-8?B?Ri9XLythT1d1dzVlSjZxWUt0WTRsQmVNRVZPcG9nVkMvTmJPbXBiQW5BS0M4?=
 =?utf-8?B?bjdVSHprNHhrenJpTFJPaXlNYlRMTjQrdWhHQ1Nnc3BBZlhRbFhVMWMxOFhT?=
 =?utf-8?B?dGhqeUkxY3pVUk1XUnA2OUx1Q0dkQWQ2NW5EVEpUN2dZdFJnZEU2MVhQaysw?=
 =?utf-8?B?ZmRwbFZ1ay9vTHViMnRZOE5vQWpCMVl4Y3h0WnhIOGs4Ty9LMzZPeXk0UXNj?=
 =?utf-8?B?QUVBb1Qxc3JRUEtqSjlkRGhPZDFuVWI0UkM0TUJJYWJzdzFySVZnVHlXcm5u?=
 =?utf-8?B?T0dhSkdpQUJyZU82L3JFSUFZS01oamFLSHpTMWh6d1RaQXROQlZNV0krcTlL?=
 =?utf-8?B?cjR6a2dTRFJpa2h5aExRQnlNOHI2UWduTXB3cHBpRnVkZk1QS2NpaU9ySzYx?=
 =?utf-8?B?NXRlVUFQbWlaaEZLeTl0NzMyTmZtWlpSVUU0czVITG1QWXZMN0NzL3FqNnhK?=
 =?utf-8?B?MzBPWjNkK1ZneWxSeDBkdFpDaFB6SW5yWWlVaC9UVHN6cUtVTGNJUC8yMXk0?=
 =?utf-8?B?dUp2VG4zRFBCcU1RcHU2QlZHcmJoL1VrdVcrc0ZWY3ZYN2Vla0NCMXFKQS85?=
 =?utf-8?B?ZkgxbjM3ZjZ2Qm1NeHBmQ3ZDSklsbGhhYzRsQk4rMzlQR1VueG1WcnFoWWxI?=
 =?utf-8?B?NVpjYTRzMzN6UWNjK29kckRtYWZ3V1BheWx0VUxKSlZNUm5IazBBeDkrMnh3?=
 =?utf-8?B?TFBzTHJuQ0pxRUZNMnp6cEE1c05SRlVjdkVpTU4wRXFrVDkvQXhSV0tCZGk5?=
 =?utf-8?B?L3ZzVTR5ams3SG83clFKaW1nU0FFYy91ekQwVjN5TUJZOGRTNWt2S2xaRDlm?=
 =?utf-8?B?SkVTdElMeDlxQ01WTFNpczk1N2owaFNHelhoNWtYSklaWXBTWGM3ekJsUDA0?=
 =?utf-8?B?SFo3NnJibXZkazU2VnR4UWpBK0FSdDhwQUZDamZybFpOL1VqQXpDTnBLek9l?=
 =?utf-8?B?YTh2UzBlMEM0VUVpNmxuWDVuZFN2TE5sQWthMXB2M1FsSG9nSDZOd2Nvb0J2?=
 =?utf-8?B?aTR6SURTYzYrWE0rdGJDMysxcGtqd3ZFanZHMnN3THh5V3kzTGxpTWRXRDJv?=
 =?utf-8?B?bTg2QVdQbGEyNm53THRyL200S204MmVMbGx3MU0vMVlZVHdDdjBMTUpIaS9v?=
 =?utf-8?B?T1c1Z3RteWZPSU14OWZJK0dWSGRkVUlJeHNDVUhCaUp5ZEx2dXczVGt2RU5x?=
 =?utf-8?B?VmVKcTMwQ0ViaXpDcTJWeVZ5VkN1WHN4bzIxTVVqVk5HSmw5Y1YvR1NzVDFu?=
 =?utf-8?B?alF2UWVnWDdJVGxqY2JJQlVPS00xTit2VnFNdnFHWEhtb1hXdm5UdEpwR1Rv?=
 =?utf-8?B?NU40V0ExZ2ZzOXpKZ2pxVUxWS0FLcEhrb2NhVUVXM0Y2K28rZng3aUJ1TGh1?=
 =?utf-8?B?YkxYYWhIeURXLzkrVDB0VXZuWWJQcStLaXkwWlJPb29ObFM2RnAwekUrdjFF?=
 =?utf-8?B?NkZpY21wb2JhVXM0N1hlOEV0eFp0SzFwNDlZTFFRL2h4TUQxVHN6NXZ2Nnk2?=
 =?utf-8?Q?i9lsnqtXwn6/2AWnFVPLBLqVJ?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a47523-e166-42e7-f3b1-08dafdfc1bc1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:14:06.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66PhHALcmEW1OXc9G8yCoMqYw9AsCd6aP2zZqDZdx8+uGt84cTppCS/o0lEP74PVf8wzOVzJ+ZLRNkkkgUbH+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the devicetree bindings to set the volume levels
and the default volume level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/input/misc/pwm-beeper.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index fadc73e1c89a..f95d6b5899c7 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -181,8 +181,9 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_beeper *beeper;
 	struct pwm_state state;
 	u32 bell_frequency;
-	int error;
+	int error, length;
 	size_t size;
+	u32 value;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -228,23 +229,46 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
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
-	beeper->volume_levels[1] = 8;
-	beeper->volume_levels[2] = 20;
-	beeper->volume_levels[3] = 40;
-	beeper->volume_levels[4] = 500;
+	/* determine the number of volume levels */
+	length = device_property_read_u32_array(&pdev->dev, "volume-levels", NULL, 0);
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
+			error = device_property_read_u32_array(&pdev->dev, "volume-levels",
+						beeper->volume_levels,
+						beeper->max_volume);
+
+			if (error < 0)
+				return error;
+
+			error = device_property_read_u32(&pdev->dev, "default-volume-level",
+						   &value);
+
+			if (error < 0) {
+				dev_dbg(&pdev->dev, "no default volume specified, using max volume\n");
+				value = beeper->max_volume - 1;
+			}
+		} else {
+			beeper->volume_levels[0] = 500;
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

