Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFE679F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjAXQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjAXQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:43:22 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2112.outbound.protection.outlook.com [40.107.7.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E64DBF4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWU18Zhe2Zo+Qj9zfTGMJWZqOOi6jR21aSx5C7mJKQTjfWSNDiKmy9weef72eK4mfJ2QmGMj9fnmc1FVBlVcoa+iNWE2hw5Hib7eo/erqYUMD1upeQqcx6cjfJbHzAt85DQLQTACGNDjXEvgZDmXUm1H+qb4W9CxCx/aTF0OD32Lkzw0NtC5en5e7W5gUC5gGwLT84NRy5GwUA9g7WgOFEmW0mRIQ62kyI31yZMqRzPpKJRCoFn0SLvE9cXnzvlkwvZJiGVSBfqQZFxCsu9QaR7PCHCdVh/08sVWEXyR9p2zKkoB/EkptjeM7PzZdp1DJQJup22d45mds9DMEGHuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdcH2axOv2c7o0Vt6zlylT4AeahmKORGfip2xDaBbyE=;
 b=fFUX3H8iYHfh1GWD7LKImQtVwDuZl1Xr9HsCsnsinbxEaXvpf5KlZyTQ9KELpvhdvDJ5obdZQyyN6W/WcvmE35I18U6S/bf3i/l2H8MAXHamldfvkvoDCgwDSFnfcFamf/+a+aaGO0pphfNDbUBYKSu7J1U+sDLDLTHUg8bZ1Sb9z4/C4wUXQMRTGsWO7hVVJZDyOqF1ViRWGUSrvdte9DrX0LZ9UHu/V5WZmaRqU6l1UsmtbpiwpEWL6OqTdrxx1/hldFWtUWNZJ5Lu2ATQtCT+exaAUW5qrDKcwa5NJ0ip8+1rxGLJ5d38L/iLFJFZ164qJDXR/s4yJjnSVVIjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdcH2axOv2c7o0Vt6zlylT4AeahmKORGfip2xDaBbyE=;
 b=FI1EwIRBbzy5Ic91Ov4L7382uTt6oCnX1snotre5okVdCP6BDhfBghTPt7v/nxujaqlNk/Yfi6ygQShEyxSvSp+IdkzWHq01hh62kBAiymCcGpQRLAaL3PRd/0w7b7zfjIRfa37RevKlCYIk4hYpwHhS8xKBDAvcKmfc6T1A99sP2r9PYp9jLhhXe908tm7xSXxIr4lY/jGjDw5mnZBUO8tfBn9LMVPyTK5rLfYNLW6OM3tKhWQKAXT4TQjz60TfqjmYwCk/BtjIwgOm7ZHhJ8qhOh8T+ZVW1JjxSuEeDrW5di89DXEqm25GfntR+MDS0pTcPiIMz4cw3wfJH3APyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAVPR03MB9848.eurprd03.prod.outlook.com (2603:10a6:102:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:42:57 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:42:57 +0000
Date:   Tue, 24 Jan 2023 17:42:56 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5 v7] input: pwm-beeper: add devicetree bindings to set
 volume levels
Message-ID: <Y9AKkHdX2T1SO/g6@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAVPR03MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 17546beb-53a8-4b6d-ccb0-08dafe2a0c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ao8Vq4+OGKTFDnvySOM7CYys7cyP/eXOmJbfuJhhZ/k1or9ogxdMxCRUJvY+SCIRI8dohg6ykvLds/ooKqFvortkO88/RO4PgIW0lyUYLSkexY0HdX2f/3CDVnkP9R+oFtJkdPP4UsA6lP42bKjST+nci1veNvjs05XFrDvqCLVc7B/+QAD2anuZH7alv8tnXITT/7Ag6q06gCIa0FocDUE0CmvVZL6TVp1sIBaj//Nt03LiZK0eppQ+AlkhScNCRAdFwTBSU7Tz/QzCDRVEKrAeC/BgpPyAeVTC6PVQuAvH9mQ+G0/nf5YPtMbdGONV1K3hUJDmjZQz5n2HcqiMhL3Ex39bvUU3JXq2XFWxzlZiBbkplJjqiD1DXj+46Klwwb51RKsnDksBiklN5Zx0cJ3xfPzZ4ISA0FPMA256EiMyk+dVoqoazkD3Wq1f2tUgI+YH98zbpBmu2cTEMWXpe6eSvza5xW/grVHOD09h+/s2qByF/YJZbGWz6Chky+QFrtp6wde75ykMe5+0ojBcGaDCHi2d2GRuolUYGc6n7K8sA3ixuWf0YqmXyrShrWyw8+MVlHz4vTzn0ki+A+m8wSeXxomoSVIuhJSQUVIU6VSVYb8+SAi5QS3z+Hb622N76xujNTMDI2bsRw11Jt5nKs6xVRy+G4zCpmr/pg6Sp7q++jt8Mw1IvGCodhI2dQj+wht7QalubBDbsUi+ErpSYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(38350700002)(38100700002)(83380400001)(41300700001)(86362001)(44832011)(2906002)(8936002)(5660300002)(316002)(6916009)(26005)(6512007)(6506007)(8676002)(186003)(66476007)(66556008)(2616005)(478600001)(52116002)(6486002)(66946007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1k4citHOGtid2NSUlErSEhKWnFncXovbWVtZzdadll6SlloL3RuUlVHdnhu?=
 =?utf-8?B?b0QvOERtR1Myd3pEOXpnZlQzMk8xNUFFWUhpZ2t4UTFGbzJjdzZuV05oVmp0?=
 =?utf-8?B?SytXRm5QSW5uaWxNbW1WMDEzaGlEZVNNMlZGK216Y3NGallpeHFSSmpRaWlX?=
 =?utf-8?B?cVB5ZGRXQmxzQzNoazhLK3pxL0x0WTUzR1RPeWpvWFJDSFRHTUhDRzU5WXBI?=
 =?utf-8?B?UEs4VHJaNG0rTzcrTTFSRnJqRndwb3VjaHE1aW82dS8zcHloN2M3aHhoRk04?=
 =?utf-8?B?WHloTWM4c1M2QkNmclF2SUJYKzRsZXdLYW51NVVZRndQNkJUTXVKMm9VQlNL?=
 =?utf-8?B?RXRlbDR0WW16dUsyVnF2UDRRY3FENHQrZEhQdWRqbnRBaDRFNVNIUFM3MXhY?=
 =?utf-8?B?elp6ZTBSMFA4QTBkamluOWZtcW9GeW9FQVlYR0htWFZsaHlnSnE2MzhnMCtI?=
 =?utf-8?B?NjBod29OMCtuNG9mbDEwN0ZYRGtaYWZsRXFsbC82K1BsWXZWdXp3dDMvS1cw?=
 =?utf-8?B?cGVRUzVGTGNING41WERwcUtSS0dVVXY5VlphWm93OXlPNWFjTytyQ0NFRHRm?=
 =?utf-8?B?dC8wbCt1UHE2QjlYUjhGK3JSTFZmR29Tc1c0VXV5cXcvd1BTVUxjU2QxeXo0?=
 =?utf-8?B?bVBZZWp4WDZtajZ4cTh4Q1ZNWEJJVHNNcFFITU5XNG1JQTdWMkJTQktQVWx1?=
 =?utf-8?B?cmNsWk0yWkdnSFVtdnNOYjJhNURQVXRHSFRYUTdqMFdVMVR6MjhHUDhCaWhY?=
 =?utf-8?B?ZDdzd2FBWE9ON0tSNDFqbitsdW92d3BCbWdsejhKbm1rbXlCbGxVS240bXhW?=
 =?utf-8?B?UWh5a0JaRU1Jd3NFMnlGQk9jdXdDa05INFdEbE1vSXNCN2lTN1pXTE83VDRl?=
 =?utf-8?B?bXdLV0wyZi9JZHZITWZaaDJEazBWWDBFR1RZSlZCb1VmR1lhWXlSSUVvaXli?=
 =?utf-8?B?QWdBRTJHdnVjdzk0b3YzdlhZY1JJYkVMcmo4QUZQZXRoSkdyVFE4NUZOUjlH?=
 =?utf-8?B?N3hnVmozWnVyT2hWWkZWMGRYVUJoVXJtNmNOWkpRMHZnUnZBbWxuWmpKQ1BD?=
 =?utf-8?B?OE4wUTE4aVhEdjZnYUhLR0xHckNjN3lkMUxqS3ZMa2wrQjJpcnZNMEs2MnNa?=
 =?utf-8?B?U1l6M29mVjVzNTJzTEtiL1BJSXJjYmNrZWFHZ2pvb3I2eHNobCsvYkU4aS9B?=
 =?utf-8?B?RFJuMlZ5aUR6V21uRU0rRnljYk1LVVZlTWtpSGRRSTc3TWdQaW5YamNOQmlW?=
 =?utf-8?B?enlBU3o5bENINmlvU0QvM0RobUVyYitDbTN4Qkg0U3hwSGRuU1pyTHJNMmhx?=
 =?utf-8?B?eXp2dDBYY0FUc1NMN2h1bTEyazNENTdYSENFY2tXOVJmTEsveU9WS3BRYi9w?=
 =?utf-8?B?WVhlMlFPR2tlRWQrbzZ3TUpFRFI4QkdxK0hMdVFDdm80STRXZnpiVVVqNDNm?=
 =?utf-8?B?K214dGRYUWhkMmtxbG1XYWd0VVpnMFNNNjFUczJCcFRhNjBRMlRjWGtLd08x?=
 =?utf-8?B?eDhoeGNGMHZYdlNGNVd5b0ZCL0tBcGJmTzNhT1hVTGxNcnI2dTFwOE1lWU9O?=
 =?utf-8?B?bkd3VVNDSitsQUFnWloyaFM1WHlzYzEzdnQvdlNGOEZjamkzenNwcGZkSmMx?=
 =?utf-8?B?dm45NmZxZ3l5MzdocVJEMEpSVUNsWlp0UnRIOUJiRkVEMU5TSnp3TVV6Y2tU?=
 =?utf-8?B?Tyt3dE1tODU0WUtMWks4d25uYTNrWnFLVzlFOWRycjFBakJsTTRoUkR2QkFU?=
 =?utf-8?B?R3lseTY3eUVtNlFuUEptL2k0MlVqSDdBUGpnWWVPRzc0a2NpejVVeTkzdUZl?=
 =?utf-8?B?blBST1RibTQyMk82Q0tGKzF2WnYrbUlabER0Y1JtUFZmTzJYVldTME8wTmlQ?=
 =?utf-8?B?VWFwZFoxVWxvRjBXdVRUemUzeVdKUWVHOW5vZEZQWGpUNlhMb2w0eGRuZysw?=
 =?utf-8?B?SFlmbVRaeFVidFAwNnJ3b2F6MXVNZEFhcFZDa3R1ZU95cWpGMGwvN1VRU3E1?=
 =?utf-8?B?UDVNakRsSTJDbjExTzR3azZWYnROYlhyaTYvb0JRZHFZemxBc2w0YjJVTHN2?=
 =?utf-8?B?clU4WGRzd1VVRWRQUVhkZWhHZHRYUWF6eWZHcFQ5MFUzOWRDRUhvRExJcTRH?=
 =?utf-8?Q?OiLsHQe4rFGdOLpj+p5PBMjMh?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17546beb-53a8-4b6d-ccb0-08dafe2a0c6f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:42:57.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k/5O+cT291bZS/OJqxd+7Y07/oUdAAbBh8NuLWsiIIgJEDSSTxAEkmnKZenizRgdei72BOJ/0aL3C9ldA5WZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the devicetree bindings to set the volume levels
and the default volume level.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Tested-by: Manuel Traut <manuel.traut@mt.com>
---
 drivers/input/misc/pwm-beeper.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index fb7b377fee6a..fe543c4151d6 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -182,8 +182,9 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	struct pwm_beeper *beeper;
 	struct pwm_state state;
 	u32 bell_frequency;
-	int error;
+	int error, length;
 	size_t size;
+	u32 value;
 
 	beeper = devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -229,23 +230,46 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
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
