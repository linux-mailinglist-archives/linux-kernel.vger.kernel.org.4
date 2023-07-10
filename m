Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E874D2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGJKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGJKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A02D48;
        Mon, 10 Jul 2023 03:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe1CizoIC3zGG8UUHs/qu0Mk6M84VwvhR1euJPwQRxZ1i0xK4MJLhyEYVAOLcyGfwENHoloRdAWkr1+rRLHaIa9sS1Y0Xzspxm4DS8zyayaM4qoAttwX8RKZz50gawkalXE3duz0rFRQWdzLGPp6w8RB4EESpTbr4GpCSb93jfGJGiCE1xd/essmzvhygb89kg8zyBvu/jO5MqNDV+ZVuW5wesEMQZpN6zZh3DdRbEYLA6fYoP+whKjUUjHwwO9xWZ9kqzb0BAK48jgZ5A61RDNCetTlJ1zcpAqCT61WlaHH7CbX47PNVpsqujal4XQWBji9qVbt/v0nMUWlTaF5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f85Sj1Pf7S/hIg2p7O0a1eybgIjJgZrXjkRNBEWx7tE=;
 b=cwfftvOT4GFACIDHm5AB/vmXjbY92050hl1RLTMSDAFL7/mJQSljCSTW+Tw97XhyqLZ6n289rMVpooxxqXSRKrFvCeInYur3yZnYWtkCCqUfvjyhqT4GFB114IwND1kRGgd6bFwRrnV/TAHKHK3eSIkIjQi//cYUCXHjlV3GwKgjYR8skiPXv6GVotzaacw/FxTeIoi9GgZ1B4ZMbYvb58m7exP4Qoeg4q8fPjxumnE7CfGi+Kxb8ZSD1MzQHmGt1NnWxkwHTnBfC1ZSFMzzk1f7UqlvjdAJP5V9I2ZD7eqUzjVwQs+aG6u4E6JSSrtIyqVLJpMC23Lw5mHhI2TOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f85Sj1Pf7S/hIg2p7O0a1eybgIjJgZrXjkRNBEWx7tE=;
 b=IqyVESDTbH2qB0d4Ut6esix+jGGnFkEVOWa2PGmK4PJEeL5EehA/OlAbKzDLZxmnUbCZS4yjMEQlXELe1UgEshEysqB0D8gs5Y2UNXZPsTztPKTdN2mE6ap5FfA5auHUKzh8oFQSpqjqQnTmeQ7ivTokMlkkMpl4mlo3lSBt6CGe4RYYMUC/b31gyq1gxWfnGtaKuNIfGUfaxolLoKiEvmHCLHU+p81biinRx4LhNxgbzGFH98OVjFCNa9HVMmtjQ9bPBY+aJUyLZv25j+5tYdJ92uO54MlzyaVPJOFM36UGmE2jh5t5sP2o0fOi+GOzyZdFNHt1pxMqpXfnMERAUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:44 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:44 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v4 03/21] thermal/drivers/armada: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:07 +0800
Message-Id: <20230710095926.15614-3-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 88995225-9557-4dd9-e69a-08db812c6322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRJdLopltKtt1ChKXDmD0czfr3mkNSL66HDEYNHZNXTCEQDRU0vNrGToZrGI0zKN1cZAe3mI/50k9sF2N0+aQXWmfhSu5Jh9xdU8d9qRvKrPojm6esHxX4sRLEVKT/LpHVQv0I8Zd8l/aEs/tk+AKBo3sYw4Cl9Ts9saLuxGLypVC+gDrQP+AM3qUzZsMRL4XxtoGEbNSzQHPOydvE3HhL3jxdnfJIWPQT9hFC0M/4+0s0n0WMarkgzmYEu4UnXqO2j0soy2R4BPo6A+LaFFLTStlTH1rsG00wTV5qMH/yyqvcjTfg+GyFbNNVRbUEbxGjCJYFbasAOE7EvO6MR6K3ajs/JS6DabxBIkKgCmu9LEg0D+4v/ZGrrpEyXNyarLy8uJAbtjbXRtTf6CJiT6kmYsKkotrcn6BYe1Bx6tFS2bQQglqbey/68tBuXjKtBaGiJq57y9EvJsVZvhU0GJEzxAuitv63lJBk2MyzdRorsGIl8ZxSCcAHDVOhtasPL42RvRwByn2zNRR87IY/53Q5xdaD6pRDTz8vCJEYuMRI6lrKonpjJ7alh8ebuT89+kuWFI8VhGTwBW3pMJegc4GBrHFDcaZpsr/ukOddIcQRHJIFj086ZCrrWPvGk0dwc9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGppVFVueUlFb3pxNHhydUxHTGRPSzNLNFA1eVhjWFVTZmVsOGhQUGZ4d2Y0?=
 =?utf-8?B?aEFLZU1BRy9VRWZNM0wvWjRTNE9oTTU5a3p5NG9IN3dWYit4b3JSVWRoSmFw?=
 =?utf-8?B?VTJvWk5VMHRzajZLRjVFNUtIQkdjSFJ0RWd6RzNLNzdudjJDOWxZR2lnbXBr?=
 =?utf-8?B?R0xsL01WSkhDWFFKajdqUThNNUxDWk5vMnlHWTlKZnJQM3NWRzhMV09ja3Jx?=
 =?utf-8?B?eTdWRTZYTE1ENTJQLy9sb1JLaVd4Ny9pTWZ6Z21TRytMQkZ4MU1MQWhkOGw0?=
 =?utf-8?B?endwK05pVkNZOEFjY3lkS3IrSy8rZm0yaXhSaHZFVHlsZEFqRExnM0lYcW5Q?=
 =?utf-8?B?UUV0M0JMQnNxbXV0UUtKaFptVGRlaHZxVk11Nzl1ODdyaWl5WmxwckR5NDcy?=
 =?utf-8?B?OWp0eWJJRmVaZEJPTWVnWWNjZnlLeDhjbXpoWFY3MFFFOWhuVTU5L0VsNllz?=
 =?utf-8?B?OFlLMlNOb0UzUUhvTTZGNXlxNWkyTkZIUzhxWGVuWlJ2L0Vqay9qQWozNHJw?=
 =?utf-8?B?ODhKZWFET21lVGZOSnFPcUZyN1NOZGZiY0xmYkNCeW9MS3dtTGFFRW5kRXVx?=
 =?utf-8?B?T0t6Mml1T2tycWtRcXRKU0lUMERyaXk1NDFSZU85MElyWExMbkJzSTNOT05H?=
 =?utf-8?B?aC9YQ2hwOS8rcGVzNU1IcmNqZmQwUFBLMVdYYVNHN3RoWURqa2R6ZitESm1B?=
 =?utf-8?B?Sk1kZnZoeXJsZVhTV0lYVlBMdStZSUY4L2tNTnE5TG9nVUVqeDhMdU5RV2ox?=
 =?utf-8?B?SllZNnNrYnZLNjlTdFJHK0t3N0kyOHBmejhUNVgveEtmbUxQVkNBNjlBTkVN?=
 =?utf-8?B?dmlzV3dLWWpXdFBPUGFrVGRKdmkwK3Y4U25jUjZoYUNzQzhsV3p3YklKNDE2?=
 =?utf-8?B?WUU1OGNXanFSbWMvV2JJcWNWTGhVRnpHT1VGckQvNzArVEVScFhSNldBS3hX?=
 =?utf-8?B?Qk1xSEdTL2lHVUJlVVhweFEvSnFzNnp5OXBoWUl0cDVseUZYd1RoZWZOek0z?=
 =?utf-8?B?R3lpTXRkZG0rNjlPU0dETTZzRzZMZFo5K1NTNDZ0MW1ISlByMWR2UjFLZzY3?=
 =?utf-8?B?bTlMR21CVm9zMVRuVUI4dVJCT0tNRS9lZGVJWFo0S2MxRHJ1OFZhbVNNNkJM?=
 =?utf-8?B?QnZvSHp0cGZCMEJISzY0NjB4UGpYQ1B1SElvcjdZcVZ1dEY3MER3c25EbVk4?=
 =?utf-8?B?MEdLYWFIV3ZNTGY5MVNoQjJLeWNmeXZpcnZSUkxRaE1uUEIrYjkvTDB4Z1J4?=
 =?utf-8?B?V2VaWFNIWU91ZGlKY1BZSmN6TExqVklaSENodVBFNjZhVTlJOWRmTTlvSzJG?=
 =?utf-8?B?bkFIbEJsMHdWVWJIU3M1anQ4dng5Nk4zWDdVbERBRnliVUxzN0NaeHVwYUpI?=
 =?utf-8?B?dEQ4YS95NGhoSmNPYmJ2eG9VRnNzbC9sVDlYR2xKdlB1ZlRaVkswMDVqNUhC?=
 =?utf-8?B?UitjQzc2Nm0zd1R5VlNaRmNpZExvRnR5VkY5dEpJYkxMZHFSZjFpQlNackdN?=
 =?utf-8?B?cEQrdHNqZkVlQTlaQnh1c21QdW8vbHZjd200akhFMittRU9zN2NJbWY3Q0Ra?=
 =?utf-8?B?bFM2Mzg3WCs4WGFoTDNjRDVrck5vM0oyc2RjcjJ1cll6dWRNeEVkdCtlVkhS?=
 =?utf-8?B?UmZpaWxUNHdTYTlNMzI0RDNJMG9Qb2JIMlA3Nm00amlua3dRSGlEZ1dTTk5a?=
 =?utf-8?B?VmYwR0pPcnUzc3gvNlFlQkFXNm5XT1pVT1Zua2F0R1E5aFI3L29aRmNYcHZB?=
 =?utf-8?B?UzZTZTJrM1hqdXh6aTJpVEE4YXFIM3dlckNSVDYvKzR3aWtCMFhOYXVoZklX?=
 =?utf-8?B?b1NWVVNOYXRPVTVHTnJhRzdOU1V6UHNSMXYwNVhVR0d3aUh5cW9oUGZYa1Bp?=
 =?utf-8?B?WGd2M0JxYzJXK3ltWGZlNXZlbHlrKzZ2KzhFakh4b2xvS2I4bW9qNkFZWTRF?=
 =?utf-8?B?RGQ3WG9BYjV0SGVZSWtnRnE3RGEwU1dIUzNiYXdPa3kzV3dDZ2dONzc5alpD?=
 =?utf-8?B?ekdYY3lTVStLenh1Y3IxVzd5TTlsUUZGK3JjRG5xZTU2cE1xZmwrMzByRmJ0?=
 =?utf-8?B?R2NQeWFQL0wyWjYySVVxbENIc0V2OTVPTFhuTTY1OS81ZzZSeE93cUpXblBi?=
 =?utf-8?Q?ApqShO0LMUKAQ7P3+Ss1hMNOj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88995225-9557-4dd9-e69a-08db812c6322
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:44.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZABljUqseFgpI+MF83k/wjVo3yMI/9pUy60wOb3zKC8lz0LTRrJAD2Hz6MKU7hnxccZEJsPwiRrNaQztMDoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/thermal/armada_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 9f6dc4fc9112..b7f549b6f825 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -913,15 +913,12 @@ static int armada_thermal_probe(struct platform_device *pdev)
 
 	/* The overheat interrupt feature is not mandatory */
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq,
-						armada_overheat_isr,
-						armada_overheat_isr_thread,
-						0, NULL, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "Cannot request threaded IRQ %d\n",
-				irq);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+						      armada_overheat_isr,
+						      armada_overheat_isr_thread,
+						      0, NULL, priv, NULL);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/*
-- 
2.39.0

