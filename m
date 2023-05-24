Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1E70F6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjEXMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjEXMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:52:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2101.outbound.protection.outlook.com [40.107.21.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E19E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IasvVHNYDaZIaxUfNmJ33W8lwqVxaqSSLGGCi/25lkgpFi9h/iI/i5smIOuqpZ8wJ92NPrVDZ+/OMwTReWWCKqq9GGZi8QUaiVDWTnp+HjNJbcomcljG0U7+7tPAABJ9WOVLBKYbIgsmaiDTXKMylq/wVRgMpJ4hGjmzd/Q/8b4eZh2UFYaEMGpT8F6OZ0WATO3MfXHBkC6uqKOetwIzGXZSXqJEs1DmhIowHVHqVDOVLAXYZuTqaj6HtK+FDRj9JH6WEWHBi9nMssgLXq3lMko2y0ndM/qIVpDzJq6BfvKwb05D+WzcMAX6CLYCpzNdvbV/sLR1fwyzG7fJRLtFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmk+PTR2uWy+mNoxLZnuwRlfJDqTBRNtaWyXPwDpbF0=;
 b=PiSiYrSj2gaOqJ2ImiRFI/Y1SxyleCzHfcJTrDhfXi19z5KsK2kZWS9SQmnzBXgBIarDV3sjAJx6vMTUEhHvziKcEvPNAKyBuUeUaEPcedoN7HoHWhlOVUAzpdwx6B7r7e2wRWhpWyD+6IQJ7QRmYiQ07Lv0ZoxJe4N/H7TGsp9R9YXSpzTpwuHCNuKaXkZBq0NygJcEbnnTwJtWhyUCUzyXsuSrHQtxZH8sv1eW5fVUmcfzEk2QiJfzaLkXIiu5NjLmeCNziSvZPbhSmvxrlh+AqHmrXV5NtnyIliKupUNgMfU1LVmvV728+0a7TTYzSR5VDSytVCJkdptBcH+0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmk+PTR2uWy+mNoxLZnuwRlfJDqTBRNtaWyXPwDpbF0=;
 b=GllLCYETwYyzNoNXiwPI2sGcoEaX6c9wXe4A4gYOBgrXiR1+yWKGUD6b7GHZpempYZVGPV8yjjzOaJTzRWasq4YJBgiusB1ws1wBdS0PfjeAVStEpl3FBdUQBUfKl4VWlMhDkp8PoKUpxik2nO1QSjcxiKZAXizfDta7jhYH7yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9229.eurprd02.prod.outlook.com (2603:10a6:102:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 12:52:40 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 12:52:40 +0000
Message-ID: <946cea0c-6d7f-c2e3-4412-4967ece40b94@axentia.se>
Date:   Wed, 24 May 2023 14:52:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH v2] mux: mmio: depend on REGMAP as the code has that
 dependency
From:   Peter Rosin <peda@axentia.se>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
 <20230210115625.GA30942@pengutronix.de>
 <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
Content-Language: en-US
In-Reply-To: <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ce744a-d253-4d8a-a92c-08db5c55c25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McunrYeIJJKS/dhQ9eM+gtK9XmCCE00XVhN1N8HK2EMXDAu4Yqnu5wlHtN6C3++U8PNOuJe5mEH++tQNPSnPFtorTdDd6NOJt+RDHdRACSjF01Kc3FC+LPbGymhc+/ndo32oSPHlu1nTQubKRAbRxP7/g/4dGN5+2TBbLSGY2AL4GI+aPmqR6Ib+gn/P+bjpdJ03A4BL/wUJZVJPNnVrQ+J7fTIU0z7SohQy5C91Nx2gYeFfnrYWbGgT7XSBaJPbwU/KC3uvZAB5oXSvDVHj0Wbm33edk60sBS4Iy0ARwVgQOoJEbN4rLJraJIaUOaoXVwQ019q3loKUpOmh88mbr5BJHwbKGcALQdH9fOX2ms1ELgS8bF4oGqbbjHxXtES/Y2QMidR2ye8z5PEcUWno7OfnnoBRG9lijhmO7lW4wNB9WDzroz5UKJKiYhmLNDeL1tOAKtFkgCLKlDGVjh899EcpZJvxVLHADmbx7wX88o7QXO2Vb4Rk2Ow9PUsXo2aGvRh5YnTEMiGqcsalMoHcD+9dxA0A4yuHEBC1ADb0jKk+j6fV86GmLDbq8eTR3DysMeXRYuyjsxdsCIp/h1f23I0q6NgsljeuszSXNMqq/UbGBsajkIyIRNOrn1Q2m3o1s8EAdoCYhmwclMulYyxy2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39840400004)(451199021)(31686004)(83380400001)(966005)(5660300002)(54906003)(66946007)(66556008)(4326008)(6916009)(6486002)(316002)(66476007)(41300700001)(86362001)(478600001)(2616005)(31696002)(26005)(6506007)(6512007)(186003)(36756003)(8936002)(2906002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5zQjZBTW1CdGNGREdzNkRIVmVtY01ydnJaU004dDlBOHZ0OHRxTnZZeVll?=
 =?utf-8?B?dVM5YTRISElsclNyUC9pSVBFdmZQNGcwMXVxaUpyejB1elJCVytZZVYvQTVs?=
 =?utf-8?B?eGVSMG0yeFpwcGRSMnMxR2pNRUZqMEk5OVZHLzBRUktObGVtRmdSaFhWd1Yx?=
 =?utf-8?B?U0NrVTVRWnlmQ2IyN1lSVnlnRXZCaWV1MzY4VEF0dEV1UkdwSEtiR1c1L04z?=
 =?utf-8?B?anFsYnQrV3NORlBIVytUTVhrclVxSjJGQ3dvSElNUll0V3lKa3hYbVlxbHFD?=
 =?utf-8?B?dC9pdkpYLzZGUWlGRU1ibHFQQkZWLzAxQi9WSExUZWt4dzF0OTZWcHk2TnJY?=
 =?utf-8?B?MDFQUE9IVXNwOFhtajByZ05jbGxlblJiT1ZDeGVJdUxmYzlZRVlnZ0ZVZlhi?=
 =?utf-8?B?cytLaG91L3BKY0R1LzJNQmJJSDJhY1NnaEVBU1lpazVsZXVLZHhtWXB4MXo4?=
 =?utf-8?B?KzJKRnllYkM5TzdldEZpTkFrenpBeTZZbFEveENhZWRaZVZLY21vclYxc0FC?=
 =?utf-8?B?dEZiaXgvWnRKdlNTRGxzd0JDbU9STm13SS9oOGQ1d3dSN3dzRVFzTXpBU1ZZ?=
 =?utf-8?B?K28yWjNLVnlWeUd6Uk5DN0ljTXJWR2krdnNscUkyeHdvbkpTNUpYeU5HZzVD?=
 =?utf-8?B?OXI1WlRxeGh2S0pCOFk5Zjg1QXdFekltVFU0QktWL0Ywdmw1Tk1ISFM4LzBy?=
 =?utf-8?B?RjNiQnoyZzB6NndqZUNsbzltK0xxc1lHWDVXSnNXNlE0YlZvVWhkMGtKS1Ro?=
 =?utf-8?B?elJWV3dyUklJRlBWSUpzSVBieWY0ek82dlpWbStUTWxNak82RHgvU3psVjhJ?=
 =?utf-8?B?TzJXaTRsY1JKRVJPN0tDcGF0NkJMSFN5YnFIRmFpVWVkaWdpdHliY1ozVFFw?=
 =?utf-8?B?TjVXZ1EyM1lrOUY5dzFFK0RlODkwTWNtRW5lRkc1SllKWjJzRUJMeWc0L3ZV?=
 =?utf-8?B?cUg1UlpXcTY4R3RsMmc4dkFNUElFWXIwUzBvUkhPbm01NXFvbllEbDM3Tk5L?=
 =?utf-8?B?OVVLNGw3c2M3eGx4MlowS2ttd3hSMEVMbXl4WVJFYVVWRW8zY2RvVXdCTEZO?=
 =?utf-8?B?a3RrYlQzd3FHNnllSzhiZ1BhWkx5bDRJbjdqOVpZR1c3aXlrZ3MrZllka3JS?=
 =?utf-8?B?Ulg2ZVYzeGt1aWlVdkNqNEFlMUFTbHc3cGxrRGZkYUJsejYvZDQrUC9kN2JJ?=
 =?utf-8?B?anMzN2VpNXFjeW1mOUd6K3czWm4rSnU4QVk0SytIWTlwdDBrWC8rV05SWFBw?=
 =?utf-8?B?MGg1Nkhud1F2a2t5dEJSVVFTQUpHUkJSdUpPM1FEVGVLUUdkN1kxOWxBNUNL?=
 =?utf-8?B?V3V0Q2QzcXFUa0t1MWRhTDlNbWJoY2UxYW9oQldGd0xlU0RXdGs5LzJHUFpP?=
 =?utf-8?B?ZWlaV0NWZEZjM2RxemQrN0lzelhTa3l5Zi9tN0hwSFdVOE5odTJqbmQwL3hK?=
 =?utf-8?B?YkpYQmFHQk5RYmo4YkVxVWJYWEdqTUx5R3NXSDU0TkNkZFJQSVZXM1hZOWRt?=
 =?utf-8?B?NE85NUZyWHFJNDNpbUV5QzEwYkl6R3JvQWUrUHVBQXh1b09aY3Q5Qms5b1Ew?=
 =?utf-8?B?NFk3UGthUjR6MjUrc1JCMTZsNlc0SWFmaGJ0THl1VVd6SjliQS92Ly93enc4?=
 =?utf-8?B?ZUQvK2dCN3FpYk9vbm9CMDNFSWpSTi9JeE5qbUxjbnRzSkJiSFdFS3VmamNE?=
 =?utf-8?B?YVY3d1dIU3l0R0d3bitIeUlhYkxiajZKb2RFelh6TzVIK2JzekUyOEZGVVhi?=
 =?utf-8?B?SE5FRTQrakk3VUtwS3ByeGtTQytZc2FPRXdaZmpybW5JTklDWjMyYzUrT0Rp?=
 =?utf-8?B?N1I0di90Q05DRGxzelBUbFovZTFpTHZ5THVwcFpXNFp4U1Z1bVBxMS9saG1C?=
 =?utf-8?B?bmxld0JuT3RaNkVjb2pHQll3M2hxUGU2bzBMcUl4bFNFeCtLQ056U3NwNW9W?=
 =?utf-8?B?NVYyc3BkZzNMUWxzbnFqNmljOHRxcGVLLzYxSEZNdTA3N3hGQTZ0Z2RWaXpz?=
 =?utf-8?B?cnZFZnQ3TXZra1h1bTBCYm9KVVorY1JsS3BWcGJGaVdhcVJpdkkxL2QwTHdt?=
 =?utf-8?B?V21MRVFxSUFoTTNZZXZjQ29mV05wdDk5ck4xbWdqUXoyRjJLamhETXBrOGJM?=
 =?utf-8?Q?WKGgCbMEhoTqRudxthwvm3dF5?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ce744a-d253-4d8a-a92c-08db5c55c25f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:52:40.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeZUnu3WPwha9xOhhejuGUkMUOKs0PPyNVAt+LRgZEaRc4IqPXPkrumOt9UPF43w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9229
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_REGMAP is not active, the build errors out like this:

../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
   76 |                 struct reg_field field;
      |                                  ^~~~~
In file included from ../include/linux/bits.h:21,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/mux/mmio.c:8:
../include/linux/bits.h:23:28: error: first argument to ‘__builtin_choose_expr’ not a constant
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |                            ^~~~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:16:62: note: in definition of macro ‘BUILD_BUG_ON_ZERO’
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                   ^
../include/linux/bits.h:23:10: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |          ^~~~~~~~~~~~~~~~~
../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
  102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
   76 |                 struct reg_field field;
      |                                  ^~~~~

REGMAP is normally "selected", but that causes a recursive dependency.
But since REGMAP is "depended on" in other places, do so here as well.
The (implicit) REGMAP dependency was lost when the strict dependency
on MFD_SYSCON was removed.

Reported by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based multiplexer")
Link: https://lore.kernel.org/lkml/64cf625b-2495-2382-0331-519d1cab0adf@infradead.org/
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Note, there is a patch in linux-next that removes "|| COMPILE_TEST" from the
pre-existing depends.

Cheers,
Peter

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 80f015cf6e54..7f07ca06eb2b 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -48,6 +48,7 @@ config MUX_GPIO
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
 	depends on OF
+	depends on REGMAP
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
-- 
2.20.1


