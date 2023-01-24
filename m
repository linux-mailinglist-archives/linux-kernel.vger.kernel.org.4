Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAF679F11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjAXQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjAXQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:44:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF0172B;
        Tue, 24 Jan 2023 08:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zcu+tPwNzaeX+/SayU5fPOZiGVaVTd4aEjJkia6668se/09B0QlkqXnqj8Fim+20bvZzGOMGxKUEGOCDz++y13udcOZ+4ULZ2WLaO4dL6/CJk4lViAWRbKFhOzQHQg/DJVLDhsJrT2qXcLpqDXSIyq3HxJ4zup8LabR6/3NxqyH6Ew/K+DTvdWgrjuW5n6ZUe+rPORsEUnYO1aUAjrkXS/3ATiP/esfjPvpTwRcvTpS72yXW4pTdSaTH2DhyUqx4D7jirXheJfJsBG2Psx0mfnLJrwHu02r4KiUEjzyWFbTdRNuKkGuGe7LRPX0JMBYZIHH11B1vksV1KJD8xwP9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPJNZHYLnRKCBG/xVFcDHq+Eqy5RvEbA+M00/mDWA4A=;
 b=ab80QRK48xRAkh/Qmhvx1Mb9dk8S1YSaf9b2ijY21f8tYvup4Xl4tN6RD4aC8zSdrrZAA8X1BJGmIYknNJjktN9ew7kkyKwX4/qScSIr3wibKlNLx584t+M1VxfGWPogSsjkQ3Dhoe7Za8BDjYWBOusdkmIUTU2aqsKq+sC9HNohPqXAYKLDZaUMF3sf3jvoM2KZWC24aPunIeo3/gob0zwTLx84RM8ewzArSa7E28lAnzITi2n3yTz8Mln3kcKLHMqTF85tBig52elB+0pnAK4yqB1LwUGQr8M2oaBFACZfk6OO0Fentg/Ix7HcOZ9HNhbHUcM8L1VV2g9xJ0zYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPJNZHYLnRKCBG/xVFcDHq+Eqy5RvEbA+M00/mDWA4A=;
 b=sGWSP621tGtfS2Wa3ntyWBpJSr3V7Elll6qLiLip/h5TFi+p9D1NtrS/YACXlyOrnP4Q9ZhTglbmdkq9Bd4igaL6IFuqbEy0Curyedsdw/b5JfTle3EludV9A/D3BRBImiMtcK2a/yTnb02PUiV/yyRXZQDOJuxEvNu2z6p+eQ8AfORmEvKTKH1bWVZdxY8pVLhqbSs+VL1tdCrv5jyjb1B1XcWxAwAxbSrz9DhhVLVMNqAqSd0V7Rx2jndJ/tgIyOgunkodSZLG+c2MB/8WGEIpcKUHsjWW3Fe0vtgbXAyWc1ZGUNpwyWCEUlnQ4GnpyQpGSmWdRfR9DO7NPER99g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by PAXPR03MB7981.eurprd03.prod.outlook.com (2603:10a6:102:21b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Tue, 24 Jan
 2023 16:44:33 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:44:33 +0000
Date:   Tue, 24 Jan 2023 17:44:31 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 5/5 v7] input: pwm-beeper: handle module unloading properly
Message-ID: <Y9AK71Q7X4d+1E4f@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|PAXPR03MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b26b8f-6e43-4bd8-7204-08dafe2a4554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaPdC4ffOIqXhad7C4pIxXbSltKuxB3SMn6BwWPFyrNg9u/EBlYjpmVl6gB6ZoFYfo0b3zCPDpxj91NxDICQlZYLh94DrCYIvmTw14UAbQf4MD+nE3puts1PyhDPvVLzgMtWE3eCN8WOYQa9fCYQnh5x/7ARXzEqRESSTXdj3xnAleaHptsiZsm6JNpPrifrIQLik1ZtIcDZKFu7vtkWu2WKZT5AqepbhR1p8/ufP5ZwL9E/3JkNZjRwBEpy9be7/+d2cN9rP9V4U+KerSe0hUsp5DTnR5lYEvpRbit05hTkElrfhBC45oDwgMyve3ZoDMk0MFMgI597lNgpVW5D6mcwMfuEM4Sh+vZyIJMtXS9C5HObuabjrOoFDf/0ZDQdIMU8GTo0Mkv1yCXqaoxnw25VLthACgoji6u8GSCvGY+yl0Ain5DABP+aIoFIqaGHj+VQj8Oq0+WgaS6kOUqdqD06p4XWQGvC4OnTeB0KefbNyRkpYNkei2ajlPUCAgFqVUu6ckP4IoZr8sXD3kW/lZWkpngSl4W8iPhZarVYMCqQZjG65AT61+wMojzBsAY9JL5M68ucd/tareq13tuq5BKi9wX+i7pKst0n2eXgugMaMcHKEG1nZSeEDqXmIAAjzWM0xPs6Z28ylqdSdx/rx6uXXnZJqjCgE06ii7JISKLNNovmewqnU5CPP8bUInz0xr8yToX2pOwV6D44HFwruAfU0z1Be/Ov51g0vY7mOik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(66476007)(44832011)(6916009)(66946007)(4326008)(86362001)(5660300002)(8676002)(8936002)(66556008)(2906002)(38350700002)(38100700002)(316002)(478600001)(52116002)(54906003)(6486002)(6506007)(41300700001)(186003)(83380400001)(2616005)(6512007)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkgzSERxTm81WG5OUVlkZ05taVNkUXlENW9kT2hkZ1V2TEMxMjhhcHRxR0NI?=
 =?utf-8?B?NEhFbThBV3l2cm80NzQ0MDkrYTViUTJYbDkzSkFVd3dZZkhnc00zN2ViMktW?=
 =?utf-8?B?M2ltV1BBN2hSK3RabUd6K2tUWFV3VWQ1ejluWitFUHNjWXQvbU9ITklKYmtO?=
 =?utf-8?B?THRmSUIzWE13NTV4QnM4UEszbGVFNkkva3I5K0QwRTVpbDYyUGozLy84TTd6?=
 =?utf-8?B?czh3WWRuWDhJQU9DSXVidXBFQ1BNenNaVmhpZmp4UzJIdFdDUWdoOFpzblVN?=
 =?utf-8?B?SCtpRDJVYi83cDFkNGN1aFNPT0tEUjFxSGY4ODRiLytIU2IxSnhGdWVmanFY?=
 =?utf-8?B?eWZjKzdtSmZrQTlHeVAxUHduWDlhSXByRnhPWWtXenhzUTQwZGx3S0ptWXQ1?=
 =?utf-8?B?SjJIR2p5SFc0M2xsVG5vNVMzNHJObkswVndaTVlYcDYzK0VGUzc5UVo0RVAr?=
 =?utf-8?B?cHhyUjR6WHc5b0N3NFFmRm90elhXblpFY0xsVkZUTzJteTlJM2MvSU5DdkZq?=
 =?utf-8?B?eGV5b3h1MEhDajJZZC9rdDE5WE5CbWhVekw0UzlEWVNyc2ZrNXhnVWs4VjZT?=
 =?utf-8?B?NEtmSHU5Ym1IQVZjM1BobUU3ZkJFUWlDNlV5MVlGckZGRzNGS3l2azNBOWhS?=
 =?utf-8?B?QXcvTnVVcmlIZ3YxVjBOZ2l5MSt5YWs5eFdHY1F2TUNsSmtqMFh2aEF2bVJs?=
 =?utf-8?B?T1pybXNVZjBNbGNLUUFGY1hoRlhxNWxFYXB0b1BudXE5cHJPeUFLU0VGQ2sr?=
 =?utf-8?B?NXlFVWxiR3dET3ZmTGNCRHVMME1WNVVkekVSalVUOUIvWTNBdDN0THl4eVpV?=
 =?utf-8?B?REZKaGVPUTFmRzR5ZVdUL3o5WStRYUY4aFRZbEZBejhlYml5RW5TZmg4cUtr?=
 =?utf-8?B?RG1kcVR4SEhld3ovTWJXc2YyNXlJZGJLbGZFWGN2enpJc0w1ZjZKcHRpQmNT?=
 =?utf-8?B?NDRQQjNlbG42a0ZNOEpoSm9ZaHNWbjJJcVpyVDd3eFdRZkJIRkJLVlFPQ2Za?=
 =?utf-8?B?MEw2N2pnZms3U3FJd2NyYllRSGFqcUhHaEI1OXJhKzErS0xGNWw1TmI1d3FL?=
 =?utf-8?B?NG9yL2hKQmFRUU1rUWdvcXdHcStRMzM3MDBlemhrZmxJbDVpRkpjcEZ3VDly?=
 =?utf-8?B?TmpBeCt5R0xXMUtKQmR4aU91cDBGaXVGakJNdzRZUk1NZ2l1WjRDUldEbTd2?=
 =?utf-8?B?b29JRm5rcUVJc1hEOWFrWG1MQnRFVzBjbW9JL3dOQXRHNnJ6VzlQaWthRXFs?=
 =?utf-8?B?NEJUcDFXNXBuUHhFRnFSclJVR0JZdS9ibWl1ak95bnhNSVVmQW5QbnM1dmZV?=
 =?utf-8?B?cG93bTlzZzRtblZDRjB2V1dVT2RibHFqUTVvZVEvQzFhSHBCV0sxdU9Uc2lG?=
 =?utf-8?B?QzJ3WkJZbVZoNWhGR2orcFdJcXVYSzZ1Y2hqVzVEblIxS3F1OUFlMkdIY3or?=
 =?utf-8?B?SjlEa1h4azF5QS9EbUFpQ3ZqLzFDT2tPY3FGWlZnaXVubVQvb1ROeTRQMHhw?=
 =?utf-8?B?djNmT3AvMmVtR09uc0JrdldpNVhCMmQrT3d4NzV6Y0xqOWNBYTdHK2x2aGMr?=
 =?utf-8?B?Nzc3dmdydlA0ZWUvaEpBVGpTSW9Ycmd0NXlmMVFLU3IvRkp6MGRBSTdwYTZJ?=
 =?utf-8?B?bTR1NkoyZGtxSVFTak51dUpWejU1ZGdqQ0JhWEdhZWF4MGxhNGRseHJDNmp1?=
 =?utf-8?B?ZTM0cEJVYW9vQ1BGTHhBRnVvVGdoblo0amlxUkp2dFQwUVhjOFZFOE9WMkVF?=
 =?utf-8?B?T0JMQ2lXQ1JyQWlqemFUWWFsb0hsak8vbFJaWnJRZTlxS1hPYjhselhMc2M5?=
 =?utf-8?B?OE1iRStabXUyajh3cG4wZDhxSHVTMFNzelpMUGtBanY0TC9xd0JUSXBnaWl3?=
 =?utf-8?B?Zi91TmdiZ096VTdBNFVEbkJMa0JqWmhaT2w1NmxlRThESWN3Q1UzMW56YkJv?=
 =?utf-8?B?V1VZeEVBdm14VnhBTGRMYUI0cy9YTXNJaG5DM2h2Sm1JcW1GNHpRTURHSVFG?=
 =?utf-8?B?VFo2c252VWtFMENMNGtNbTNwSEh2ajFVTGNGMUZwVFh1SkhneUVqM1JKK0Ex?=
 =?utf-8?B?S016Mk15YTErZWxSMU5ZT2FKOFE3Um16UjdhUFhoKzZ3eVEzU2tNMm1QYzV2?=
 =?utf-8?Q?n+OJWrtDshVL71vqRjokcToxP?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b26b8f-6e43-4bd8-7204-08dafe2a4554
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:44:33.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzmWVYX/+auwnbYlTratqUOOkxdoc/3QRwJFMEDl9AP6VrzyaV39eO8slhGrcMdNfuSIxzvuFZz6wFi+SzyimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7981
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'input: pwm-beeper: add feature to set volume via sysfs' adds device
attributes without removing them on error or if the module is unloaded.

This change removes the device attributes on module unloading or if
registering on the input subsystem fails.

If the module will be unloaded and loaded again it fails:
[ 1007.918180] sysfs: cannot create duplicate filename '/devices/platform/buzzer/volume'

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 drivers/input/misc/pwm-beeper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index fe543c4151d6..8ef2937e8f21 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -300,6 +300,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	error = input_register_device(beeper->input);
 	if (error) {
+		sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
 		dev_err(dev, "Failed to register input device: %d\n", error);
 		return error;
 	}
@@ -309,6 +310,17 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int pwm_beeper_remove(struct platform_device *pdev)
+{
+	struct pwm_beeper *beeper;
+
+    beeper = platform_get_drvdata(pdev);
+	input_unregister_device(beeper->input);
+	sysfs_remove_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+
+	return 0;
+}
+
 static int __maybe_unused pwm_beeper_suspend(struct device *dev)
 {
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
@@ -354,6 +366,7 @@ MODULE_DEVICE_TABLE(of, pwm_beeper_match);
 
 static struct platform_driver pwm_beeper_driver = {
 	.probe	= pwm_beeper_probe,
+	.remove	= pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
 		.pm	= &pwm_beeper_pm_ops,
-- 
2.39.0

