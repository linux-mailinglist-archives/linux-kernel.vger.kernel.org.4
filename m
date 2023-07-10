Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41774D2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGJKEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjGJKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1B35AC;
        Mon, 10 Jul 2023 03:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amPxAuRZMv3ZtsVpx+myWp1/MLziZKjYJTfSXl5VNG+gt8/dBG/m+3SrQlTioCSswpka4a3T2oNdIe7qJK7iq3IrjtX+ghdvULNVuMxbIrr/BcI75lcbWUfl8jq5xjUMPtgtUKyMVsFh0qavwSrEZZNjuGLXoHN4JbwY6qedOpCHrWGtzIMGui+Nz0vz5Ev86hiw4nykTC98Igtc41e7DligfdNI9H0LebqmF0pWV3jf9miFhMT8vZnnsKeTaTSRvko5nL+frReiUmWX+adZTOwZubMQD/ETWSUw6qrGRGjwGysAeHGXQZQpPfBzcNKEXZw5a3u+b/qh6Y1Shanq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4bfb4yk8VVql8CBIboaJds/47jikygD97Ynoj6D92M=;
 b=DBRoJauV/Iz36ttzdDJcffEnVR9Q6xznDu7sSg4GC0geuVPAM0ZEO5nwphZwb7jMBaLdfShohN2yQ3AqeY1Xrrk+hAW8zr6rK1qaWfeLHMp4yWhaaUB8OKqlbSNQ9L5DXzkRIY1ld7N+lrFVmcqcvgKIWtSgwK+mTMugkohlCWTwYiin0U2iyUdcgJIGV99sZsMO9zU8rGTnQS9gX0tWz1idczG9GqrHqxzTFKmZ3gQjKvbWIL8CsjiIpueuA4S6hxJRFU7fwzkQjN0p2ASSQafDmMi0nr0SPNSE+76ANzKQmV+gxijda6WSdfojYuEZi3qhaqV7ZxSrL7OsxgwyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4bfb4yk8VVql8CBIboaJds/47jikygD97Ynoj6D92M=;
 b=C3T3PJZpJN/zn5aiM8lnacNMd6abAXvlnGkLKkUO62KUrwB3bisy+Pqs1f8cgLWL3XQvHsW2Ny8wZgDZ7xOYZUDkJm9wPTtGmanWbTTbFfW2H5Aaa3eYv2apxK2bHKyII1nQAuaTItIVFMNM7IefVWC+237lDmM3xM1h1UO0PYIWqLU3srYRXyP70ocJnm/NSicAjg0FF8rqmxHf58BdFrkZuHLgEkasRLv5VwJDsGChFMAvoaqv+emR3it+MUM3hG29aet56M4s/0I64xelAo36OoJm2pcTu7jzSzg5hFrGgCXClrPfqPJWoyOeAoQUmVWo9GtM0hq/otIDnTItWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6096.apcprd06.prod.outlook.com (2603:1096:400:33e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/21] thermal: max77620: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:19 +0800
Message-Id: <20230710095926.15614-15-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710095926.15614-1-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dcfbf2-5a46-4162-c532-08db812c773f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8I1eu3K6KqQGqmD41urPvcBoQ9wIEltkQJe39hNYOKrZo6Q7CTUbobRoDrZ8GE21MNs6lieQy8X5D2BFylHSIC+MRWVEl/UvubD9RJKCDgtngJvRU3tC0tPfr34AAPO+fiWg/zoHcyoHt9+2MhGLVK987CzWcCTqBX6Uujt2b2FOQrpB6z0DT6O0owe3/vv5Ja29uoD4tekgmPHUtMHAE31qQ/WFfy7FwxZ0xHcgl2+z17pjAK8Newql+Ro/T49MzvVnqAkpvx9fK2cMZdPAbT6m/89qFBP6pmtM41F9R85hBbgMZRAJWP+5s5MrmY9r045n707bskp9+YSstr9yI8WeW7LlQJjn4FS5m3Pc2v3gM8VAgo8CZDeEU2833s+3NzPxpPBuPPO9kvsfnLVriPXJ0qFrjmWdUt7QFnpkgW1LuhSM8xQyedgtWF+YO9+rWW2LROTNwape2GfnLtr4x56aP8ELekZdybdmA9nIR6gtAM0wqRIEfPd5ei2RYq+A6q5JFV04Mte0R3y+5Te7Lqjn7a3I8Ca1pU6J9TXjARqZJ5lLwmIAofH+Vbc2heyVN84Iy7uP24ATaOvA4Gy/ihF14YNS/thC0mdc+9CnHGgqYe6nY4CgyRH1bl6ffIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(366004)(136003)(346002)(396003)(451199021)(186003)(6506007)(1076003)(2616005)(6512007)(26005)(66574015)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(110136005)(54906003)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZBYXl5b2NvbFJFYlF1aEF5bU8yUzJ6QmVDR1hQaU5HeG9LNWpUeWM1b0dE?=
 =?utf-8?B?azFyM1BXNXhvVWpDdnAvMlVFdG5GYXRWTTBhV0ZkT3JPZ1VnWlpwdmhaeFB3?=
 =?utf-8?B?RXQvZjNuZVlrZ1gwckNpNGxvT2cyczQ1SGJZV0Q1MmpjVWZmb2JJNFpQUUlo?=
 =?utf-8?B?cTc5eG91VHpMTUFjVEZUYmwxNG50eTYzK2hzOE5TTUZOalVROEgvV3ExQXBx?=
 =?utf-8?B?QURiU0o5Wm1STXB6aUFwQk1KYTFMTmU3UG9rdVF6V0tzRC9qbXdtc1dKcDUx?=
 =?utf-8?B?RTdLempic1FYMVQ2WGFBajM4b3o0Y2k2aDNnZUJiUU9VdDVUSjNqc1kvTDFM?=
 =?utf-8?B?ZW1nNWVLRS90NWRwSTlJc0ZsRFpQR1Y0b0hIcnI0UnhGdlZtRHRGVDh3aFpv?=
 =?utf-8?B?dkpHcFdXTnF1bVRwUlhUVlRVYTlFTElsaWtPMWJYZGRZTENGT3hWc1RleGVT?=
 =?utf-8?B?dFlScmJRbk1YUU9scDVIOXE5NmVpZUpiUjRIKytIU2tKVWhLbGV1NWVJQ05F?=
 =?utf-8?B?bmtTZU1BS3VSNktUR1NVVEFCaDl4R0d5WUlZMjZHLzZvUlFIc0RFSDk3SDRv?=
 =?utf-8?B?S3JVbGoyVWRETXhlcmRTMjBEbHZBYlBFUHZ2Y0t3cVpLdXg4MmJ2RTJvbENp?=
 =?utf-8?B?L1lqbVU3VVY5OE1UdllkWEpTN3JMU2pLVkozajdGQk1uUXVrdW1WM3FJODFL?=
 =?utf-8?B?QmpJRk1xc044dkpzUzhZT256U0JONUM1bmRTWmNlZEExN0pTY1FHZFJYbk1G?=
 =?utf-8?B?dHVCWFUxQm9oRWRIQ0ltQTVWOFZpazkxUlJxTXJKbjFRNWFyR3dqWXFNSHRn?=
 =?utf-8?B?RURJSU9udjFBSWRXekZyaW5FRDV6V3RndmRqeXI0VlZlNzV6YlBVZTFOQUxa?=
 =?utf-8?B?Mm1EYzBKNXVMZElIZjk4UEtncE9RdE9VcmNPbkNxL2trV2JUWjhaWk5BR0Vr?=
 =?utf-8?B?N2hqc3hWYzVkVzh3Vkh1UitpRXNXUGpFYVRPdy9nYVJxZER0OFYweUVuaWl4?=
 =?utf-8?B?OGlTWXM0MXZsTzVrS3k0eTF5NityZ2lrVGJYTjBkVWllQU5iTzJhWGVGNWJN?=
 =?utf-8?B?Ti9LNVRtd2pHQVpscmhrT1JoRnNXSW1zSm1zQXJjTmFkaTR0VkJ5S3dpQmhy?=
 =?utf-8?B?cmh2OTdobmZoeTUxUy9HVVlBMVpTODFnNFFySW10NlNNb2xUTmNWNVRqbGl0?=
 =?utf-8?B?eVFZTUxZejhPbmJLbk9XMDVZQzVMbXRwYUVNNSt2RVNjMUplRTEyUXZCMFdM?=
 =?utf-8?B?ckEwczFtTkhBME1VL3o3U2lwbEJRV0xMK2I1ZTNKd2dNZ053cS9od0gyNnF5?=
 =?utf-8?B?a3BuMWdRYjNRUGgrbjd5VEplS1RpOUYvRU9VNG1aN1JOQlJPSFQ0YmdCNXZ6?=
 =?utf-8?B?Y3hpcmxVcmx3VDlPRWNLL3E5cHE0eGVLOTZEYld0VmhEZzNaN2xTWW8rUzgy?=
 =?utf-8?B?VGd5eno1RnRnd29STVVoQTFFR3FXc00ycWJWTGlieUdPeEYzTnc3RHR5RTVS?=
 =?utf-8?B?NHdOUVBkUDNVQVd5Q0d2anBJcnh5OXhMNWMrSmhTWVZvVlFob0ZjM1ZUc25E?=
 =?utf-8?B?bGUwN3o4VHNwYTBlbTBuUGZmNjI4cDQ2bzBVaWpZMWREVmtCYzhIZWF4anI1?=
 =?utf-8?B?YlhHaTBtRDBldG8wNEVLZWdBcUpyczhKbG5VMGJGZkVmb1dSMGNtWWxyVGd3?=
 =?utf-8?B?TFdmQ1BlTFBwYkQ3bTNWSm1XNkRGc3VQMlo0bjJRR0hCNERvZ0RwZzhBc0Jv?=
 =?utf-8?B?VFNoTTlkQ3ZOSmtQQlZOQXI2YUFXeWhLNll4T0REamZhUTRyMjJRK1I0Sy9L?=
 =?utf-8?B?ZnVQMC9PZ2pMK0dCalU1UFBxZW1Xd1lLckp1eGtzT21iVDVXWU9LZWVIUEhF?=
 =?utf-8?B?UWdJVFVaS3BJWUFxNDJSSXgzNmZOZnh3Njk1ejQ1M0JIRkJEUHIrZW4wYWRO?=
 =?utf-8?B?MG85VHl0Q3NNd1JxWWYrU1hsZ0llYXRrVGsrU0pJcTU4MFczVW5JOXhkckFm?=
 =?utf-8?B?a0FrdFBNU3IxZGZId2JncDg4WWhjVXZUOVU0QlJQMEsySTQ1cGpBSDYyM3Nw?=
 =?utf-8?B?WFpwODF5TUpPbWVSMm9qV1BRRkE3Yk9XZTRTRC9BR0k3OUNlVTJkUTJ5ZkY2?=
 =?utf-8?Q?En7we+HkuoQY/upNDKuwobVzH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dcfbf2-5a46-4162-c532-08db812c773f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:18.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIXbOWjlJ80Dk9egs0TsY20W0ZLJOCSnGrwM2b2dbMgpToCpwsOKQoOSBWFUTCDCOQRl2GyZ0t++LOnNKVXiAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/max77620_thermal.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 61c7622d9945..92289498fa17 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -121,23 +121,19 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq1: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm1, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq1");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm2, NULL,
-					max77620_thermal_irq,
-					IRQF_ONESHOT | IRQF_SHARED,
-					dev_name(&pdev->dev), mtherm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request irq2: %d\n", ret);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, mtherm->irq_tjalarm2, NULL,
+					      max77620_thermal_irq,
+					      IRQF_ONESHOT | IRQF_SHARED,
+					      dev_name(&pdev->dev), mtherm, "irq2");
+	if (ret < 0)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, mtherm);
 
-- 
2.39.0

