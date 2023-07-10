Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A8974D2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGJKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGJKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:03:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA8D35B1;
        Mon, 10 Jul 2023 03:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI/s1nT7F4GNc8h3G+3IZXilBEYwOOUmWEHNROGlChKYY3LeknUiI7Pux8PR2aC2pANH5+6Qjt9UTcikBGZTV9OdyN/w6Kes/3kHFTHI47+Ry5g8bR8v8Q07zZ5fPYP2dMk4KvDhI/3RXd6oAgvD7PKmVEYWHNOUWXN554GviaiAFb+aqaHPnIONQz4vfEgJxK27bXdr2N94H5uphxIX+V3MM9L2/ZGA7SBSTnC9uvSX28v+dn4QE3DdrAog/VhckG8HNLDpAy36aYgrre/3wqoYS/xeCX5dS9MOukJUXs2B5gpq+3e0w2Kq6YsSPDiVsFf8bM8SQl+jceqHdV74SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHS28mIWTpLDBdxBKQHMC8i2TLY/+VTjWtqoEmhSPRU=;
 b=Iz7csKauyQ3v7FI3hVHVddE55P1CAg0rFd3mM8UQ4Y4iV1BITRI0T7jZ7QWTtnWwyGDtgQVvpcheD+hdUCQLIdT2o/bf4SguznBt4Z9+/wJY2I0vUvg6wwhaxABHCr9m1qNn06BK9vG8JZlL2ZHU56atkiA4dsZWXj+5kZJZRZvPRWs9TxU8JANxdsNsjLa5KJvgcOLGmaghwKMz8PDBk9xMMCO7xgv9XNzmAdCALKUG21yHcyHgkxAZTzVN9MyU3tNuyA+ltBHWPFamvsL4ktdd72vfFPL29OAXlXEwUuojvSdVTGICC7p7u8lIWTZ1KMig76mjFvcLYGp01V5x5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHS28mIWTpLDBdxBKQHMC8i2TLY/+VTjWtqoEmhSPRU=;
 b=GoUD/cVqI5lPxSS09PDJO3cGMIEA3NC1x+cTeabIgL3jC29Bg84EFrRFX5PYZa5rOUr5nmUJsL3cB2CVT7UsFAKX93Ro9z7Wq9oXLjunzhoVmrnMvCX0asIF6Bv9qGUxfH1hOat0jtrFXWDS3zzMrFUK/dZ5SJEWtw2c2qtV1QlY94cqW0Jq1xwcEeYZF+iLiSB4fL2DmU9az7ns2lzApta4e7q9pi9w2uignhozU8/OGoXu60B6/YRRyVHFusH3P4g8tAKzpw71vvoOS60FWr2ms3xd0m8N+nC82azgyUPEdrrY5kATIoeyi4XZNCHYQL1/9kQzfzo3ElFbAy3n3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:00:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:00:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/21] thermal/drivers/uniphier: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:24 +0800
Message-Id: <20230710095926.15614-20-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ec64332-74e2-46a1-c5e2-08db812c802d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nRFuOtEBI3RTkTY1kG3BdkhA/mxTaPq25KPoW6TN+sS/02Vay/ARsXu5zPdStC4nHUXk3r7FUV0fbFv74NY79BQvSkxxzkO1JdOGjbPv1sc2oxLAIOfguF8aaimnPyA+YEfpGuLKylbNtTYQlvXsWNXxeBqBHC4sYAdsBzHBuFkl1nyjnYE6ZKpFjQxPCsGKFKNgIY8TLJrvv5WBgLS6kF5Dy+OqA1nR9CDaovnyeBzIKGiTRtDngx00sYD3UqKcGXxAIUcXn7VF719T93bZ3CP2kWwonvgat7QYXHWcR7u1f2jdGJOyFkPFyZRGQTELkThk9rbH0kDlK9qR21/z/woUFeK6THMFPoM/7wkIC1nG5aHmNSX5dieouyVjEE8JEzsI7hKHgq5yOvLk6pxC7ThmXAKHdBT1kbfcqG50ir6aDiHF/AkXU01hwcIEyW/SGeLaWMFJ1aWbS8pkicCVEVuBqrbtFYk16QWQPLjqyJbnnis3MnhMW/A521Jr0E7KJ6hmEuLTTN7pjeJbUnn5Wz9Aw1Fj/y0UsgtVAFFQBMkggFDWtmWFh1foyaEkXCOBN405zWpJvjEN5noeo4RI+WAOtFSYbbEZ4QUA1xzwkCg2JvzsS+c522oEOH95qds
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0t6VTRtckhLUHNodzlEODRKVXdDN3ZkK25vRzF2MUJTNmwvNnlHa1h0bHBn?=
 =?utf-8?B?TmpTbFFhN0JzMkNST2w3UmorTDBzdlNTSVh4cFlRc0creXprSGc3bnJna1Mx?=
 =?utf-8?B?TTRyTWNYMmN6T2psVTdqdXlqbkVsSU1IcVNFVDZhOC9oeE9yd1Y3cTkvR2J3?=
 =?utf-8?B?NnZxN1hia0Rja25YVENlSGg2Tyt0QmV1RjZKVm42MDVvZnhDc1ZydGlCWXAv?=
 =?utf-8?B?K0VDUG8rRmRNU2t5clJZZTRQZ1NKZU92eTJoeG16ZXVweW5DNjg0NllVSVpJ?=
 =?utf-8?B?czg3ZkdVZ2lhejJuSkY3bEdOSVpyNk9SbGs1NmFFQzFoWnZDK2t2VkdCZWYy?=
 =?utf-8?B?azVsNVFYTHA0aXVQWXE4WlQ4QzliS1dxMGtVUDMwUHI3WlZCcXFnUkcvaUdM?=
 =?utf-8?B?QkJxTDNpdFhmVFZ2STVxUGVpVVJXTGJjMHhGQkREL1plc0t3V3psbTdON0ZI?=
 =?utf-8?B?VW9aazIzZEVJTTlwWXB6S3F0WmR6MjkzdXEvSExNRmIwaUFXZFZNaGhkZHhs?=
 =?utf-8?B?YWwxREtxUzFPck5Ja3U3dGo0VzRtMmcwd0ZmZjZwUW1pcjliNlN5NitQd3Nz?=
 =?utf-8?B?VlNraXRCUk1VZkxrMU44UC9ja2RLZEg4V1MydGhHRjdicDErbkVSYVhjNWc3?=
 =?utf-8?B?QWZQMnAwZ2pmQkIvWmtZUllBZGtoNkFvT3lhMnZUSDVlNXd5YTB4NUxuQ1FF?=
 =?utf-8?B?MGFJQ0F4YTVobm1Za2VEZ3RtWHRyYkxQcTdmdU0rYW1FY3dtcit6c2xBNjl6?=
 =?utf-8?B?Yzk3MXIzamdXalVGSDZDTTJ3USt6WUxjU09Pb01yaTJLQU1PeG5UcTQwekdC?=
 =?utf-8?B?SnYxZjhyc3FxMzNwRXJ0MmR1N2NDRmZRcXlETmZ1eTFqVEh3S3dpclVxR1pl?=
 =?utf-8?B?Q0RyRXBhdVlpUnlYaW9hTVJ0VXA2SjZjbmdiOUxsOXJwQnVINzdvUnFKRjQ2?=
 =?utf-8?B?YjZNWk9OL1pCY09VVXQ3RGZKQkhjdVM1UjI5M0xRZXZFNm5QK1BCYWlOa05t?=
 =?utf-8?B?VlpvZG1nTVBLeVRDUlVoenk5blZxZkE1NWY3ZGpSbitEd3ZJYkFDT3dUc1dm?=
 =?utf-8?B?akNDU1JvUzkzb28xTVUvQVdiaWpOeUNiRnRHbVowSnVveHJ0Q0RpNFNUQWZq?=
 =?utf-8?B?NDVXMUhsQWFYSTBWSUJIcTE2dG0vbFhZVHVMcmd2dkVXSEkrZnduZDV3Z3hN?=
 =?utf-8?B?Yy9VcnJ4M3BRYng0KzNqOE92VW5aTFlQems4OWtLQitKVTR2QkJjd3hwSnZZ?=
 =?utf-8?B?ZkxuUlI3enhkVjlQZXh6N29UWFdYVU9ySko1c2VYY3JOY1FCS0RXcWFDdTFa?=
 =?utf-8?B?dllWTjNienhaYjgraU1FK3hXOEFSMzYyR0RMaGVwK0w4Tk9mb2RldHpmV3Er?=
 =?utf-8?B?dGs5c0puZVVZS1FkUExnUk9reE1oR25ZWm9TUnhOWWNwMys0ZGRKYURjbFhD?=
 =?utf-8?B?TVNoSFlJV1dlVnBwbWFrQWNCeDBmRWNjSHZWRmlGdWplSkxGem1vaVYydkI2?=
 =?utf-8?B?N0pRZmZlTzQ1VjFnWXJoSlFwT2VkTjJuU3hHdVkxbm9OR1d2dWNKZUhOTHEv?=
 =?utf-8?B?dDZOUWl6WTFybDdOWkU4VktXOGtRa3BvOFpSRThxRDJkZ0kyQXUvWHhNaThR?=
 =?utf-8?B?NS9GdWVwaFNHd0dhRFZHQU15UW4rZllnekcrNVdQWStIbVVMRUR1OEFmYThy?=
 =?utf-8?B?aWNBZ2pwM0txTHJWTWlIVmV1cE9ZWVZDNXkxcWphenMwcnR3YnRxSFhCUlQ3?=
 =?utf-8?B?N0hwZTQvUGluRVhYMU1SclZ0Z2hwT2RrQmg2OVZmZFAxRkNwcFN0Ty85MFhm?=
 =?utf-8?B?L01ONTV3cThuVW53cnprMDdDRDFqMlNUeGNrMmdXQ09VK0V5V1RoUlJiWU5D?=
 =?utf-8?B?MVpHSENWaWFjWWxJbDRwTWZiakVVTGFsVDRyZ0VSeG5UQ2l0Z1JFYUdDeTcw?=
 =?utf-8?B?QXlSZUZoYXp1bDNQVENqdk1jdlRPV0pRcVMwa3l2blltL1M1ZVNYQWNtSFll?=
 =?utf-8?B?SHE4MzBhYzNHNTZ0N1ltM05BNndkVFp6YTRhVW05MXlqc0Q4ZW8xbUNvRmpY?=
 =?utf-8?B?dlNVUGpUS0tIOUtXaW0zN2YvMUhhcjFPeFp2YTZ5a3dHYlN2N2JZbWZLVSty?=
 =?utf-8?Q?mu02+E4Aumvt4Fh+losfGpQuN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec64332-74e2-46a1-c5e2-08db812c802d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:00:33.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH7Rf9GFzypxmdlxNU5OBBiNXki223smMMQeIVnlo33vIYY/4bXzRA0WOYgWva+H20kpDjplvbNiJF4HFQfGcQ==
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
---
 drivers/thermal/uniphier_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index aef6119cc004..34d8eb2138d3 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -278,9 +278,9 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(dev, irq, uniphier_tm_alarm_irq,
-					uniphier_tm_alarm_irq_thread,
-					0, "thermal", tdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, uniphier_tm_alarm_irq,
+					      uniphier_tm_alarm_irq_thread,
+					      0, "thermal", tdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0

