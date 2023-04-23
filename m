Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B716EBFDA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDWOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:00:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2066.outbound.protection.outlook.com [40.92.53.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5C10C8;
        Sun, 23 Apr 2023 07:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOwY/DwiuNhrAO3ZmGgx3J69eO+TrTBBfrx5SqIxd3HogX29w7dDHY0lM+IZV3ayHJBPJm7kucr46+6FVnrcW7i/IYpvnpU/mrn2KO3CzaiSnS+rSlmAJ+WEKn9WvdsZ4lDQygA9tn4f8BmPkG6CXO3AEmAzcYoDTWZknHHafzysyAJfWhgAf60nCzY9FZtKjNlgaBNpKeLm9rCvETXItf4Az6C3yaHgjIJt2rPsGSvV7/hl0ZDEcZn+UPfjI3auZkSpJ3H7+J5AIH56fAZ74tTyRljphnAvI7EHH44Ism6v7w5EQPwoQx5x4zAKV956tJii9M2mNX6g0clGguLAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZtAJ42XVnr7fKAiI8iqrmXTJnda4s1twzyRvpRMR90=;
 b=nu7Sul5/EQ7F0jhR2i22eAIR+khCwtq83QlJwsuZ329jXZDfXk6uwcgme2i+EmHR65JUd9p2+PDvRYe0ZaW+LWMfbtjM7WJZTI6PjPob8YqHohSZL7flQnbL+NaFzQFrtDdeD8SJ9Xmqu49t3EOCNTjjyg2149pgi4mbaE5fiBh5HoLzgKRFs/7EPqgA1ppRdc0jaVx/eHOsOfZ7LUDgMkCFjJKse4dIICN4GKSU/rQ1gV96/wAmkmC1LRvCQvPhVZwuObzzR6sEWqv2hC2/U4gtVgk1Yzg0OZ53UqSq+e0J+HRJuOpU71hlQa3a/OCJlrQyHbum8v5f0MPd89E0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZtAJ42XVnr7fKAiI8iqrmXTJnda4s1twzyRvpRMR90=;
 b=H5dpMGnXKJd5DBQ3pNoyDqY0TUoFgILrqjFQ9v20afcd0iyouXAwkaodF8RGCo4C54s+S5WU/fPxdEnkVBQXmUzbLtL76qjTpTzHZ+bwg2GW0kDwxkeo+fjllrXgBaITcbDFL1hqoScvqY71a7QLegh29Yhh7J4MVXMcDFSahEY65LDbXDi9YG98hYV0k6y5T2XnB3wAiokySOK2m2xA6ZhtwLXwIRFEpCr+5DZAi9SQ+UXAynRBSsM8j6MkuW6fGYwaRRNptZXVtdxjJav7hxAc8jqF6RMTteSL1cheX35ciF9eI9MXSu9zndCw2BTNU2NyP+R6tHfY+Iz0EWMGlg==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by SEZPR01MB4183.apcprd01.prod.exchangelabs.com
 (2603:1096:101:38::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sun, 23 Apr
 2023 14:00:05 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3%5]) with mapi id 15.20.6340.018; Sun, 23 Apr 2023
 14:00:05 +0000
From:   Yan Wang <rk.code@outlook.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     Yan Wang <rk.code@outlook.com>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
Date:   Sun, 23 Apr 2023 21:59:43 +0800
Message-ID: <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202304232146.7M89pwCz-lkp@intel.com>
References: <202304232146.7M89pwCz-lkp@intel.com>
Content-Type: text/plain
X-TMN:  [KaQ/JvKzjW08PnlwxR9ubaa9qnNChpCFeVAix8Mhsmc=]
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <20230423135943.1433-1-rk.code@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|SEZPR01MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbc8e68-ec6f-464c-0790-08db44030a4a
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3kpnoAp0BLte3KMHHlGHUDRtiUdCriPD/E7WQXBlqOx2DZFKs//gOMbnop3XUDrchpV/nX4MxJAq3w1+DN82HrEMPU98jtWeM54hVPbsLtpYe/eN1MQJZFlX86CdR0/aDxOnN2iqVqo+9cF5NRndGly4CuRZH59jWI+bIvyQDw1ECDGY5z5gJ++fe4itk6fRTjQ5Wlv2FAQMg8kosTer2XeUorse4M3IhWp5T7THAgGzEQpU+UuVoGqlA8j+c73wR0TDqlIeeTEofpYy51iKdACUic8YP2bIRvJ8P3JMuQ7L4sVt8zMQA96yn4KjjzLsxp4Tmj9h2tZwpRjq5xeECtu0aUNHDtSFbQeHInuvuWNpcs6YqjniyigivTZ+wwDyeGi57Ehpgq1I9uled28MXLBfagbDc/fty3nwhmFjgrx5DfJYlPxLUTHN0q7NzD2NvBCGhhyfTimpSAAvYSRZtVZXYvF2ESjTdAqsx5AzEqDJNXdrVX+LBkC4RzUffiSY0ntL0fVfVidf+VitKKugquTTFS/7ce541OWy1HubNGDQ0EUVgurj4Z2bDPPYe+6LPAx6Y+fx6fOzbAmJeDSi0hzA0iq/SXuXmjc4bymRUdwt0oROLDslYOuIb3pqliYk+lMAizYr6K9ekriEQEXCplPL2OQjr8s8Yf962AAxC1NhyDYbr9+02jNtfIFhGg1BsBlSUhuIS4KklMZYZsa26K0k1htHmr1qckopQiJPoZWnw3Ma/qHyRzcWyhWNx6tiz1G+kN8op+aF7G2HZCXm0tb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkqI2dvJiuBox5gGCtm6QszHPkpVITHoHxuLEMhq6gv53ssc/pF0Ijti8jJsCbYzTtQNQjhPiw6ub4K1C0a1bDKgi3bsv7FoyFAN7dae2jYgb+mgn/6ewbJKtplyTYq7p6Hb/vnJQK7G41ME3MwaQmAvFZ3yuFW8rQL0AwyAuCkkM7oETxwkWk2PvJ3UFfqtUhePDKR5ETBCbUhIMOUYsXA/2aZGkgIRYWW/88kfKZztZgR1qbT/FYtSHqWYubQdB8etdqbfHnWVVAc9sX8dm3j04DLHkJwAy6xObeRuGlBPkyhrfr38RfN9TuhE+8TpkTCFrk2qjbbU2i2oyIo6EIDR7GyJJeixNhIIgPqbTYsabSns307i2fgy91btUdNsFDkuIaODVa+3ea30neoytIT9yd3X0EymEtXJnBFnZJsnQSS6pga4swCtVTqP4R80w0H8hmDnSmgwsIaRNPTXfHI2t7/fZHaJhn5gdzVWY5K1ruTO2d42yMKjJVs8l8owYxszrKXPvV64QW/cIuDs+v5ig3Z1f6tG34rVXQ1Tf60ny4sALgvMNN0X3rqdtgiqXdzhhYJMoZFqSOfKb4rzBTUSFFQLoWxzmNoqD5VSVvE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQ2NvsHnvZW4wxR5N+nyE9z2g1WVFIhnxmB2Uvvz1OPXsPZdwFC6e9kuYtFD?=
 =?us-ascii?Q?iCmR/bXrhue7IUilfhiUXvv6p83ApfF2eAYo2d9Yvl3Kanh4O6LZy+w6rhnF?=
 =?us-ascii?Q?7pMEv+Qnhjx6ezYzHLTQSv9LXjc1HkEVRV5zOE/3ma0yyckwYea0i+J47l9O?=
 =?us-ascii?Q?fCgMd5zd474OYdq3C8sq5nn1BrRx3IpQNEqoM8oZWL3gUh2cApN8cpUejFju?=
 =?us-ascii?Q?tYvHu1ZPiZrgegG2YM0zOGyJZTtXei7vmTgsPTKgZJ4si4r82/PzJ+WXlEw/?=
 =?us-ascii?Q?pCkoWozVnFZHaHhooDgMgVO1VWpfXAPG+DcvULuI7kencaf0zF2DDJCQurY+?=
 =?us-ascii?Q?rEJFivArYpXoi47f9SsM5tvHWMNmBbAxN5HzSRsPaGCHUzb8Z2XB/MVL1pwY?=
 =?us-ascii?Q?ZF0/9mykqJdtY+RylSpWRBv8gy62D3axXvCLVmUOEthv3Gn2yU4RtSCD+Re1?=
 =?us-ascii?Q?7PN9mcj7ePdKBgA5N6/SITJ15iFvM2INGBe3Hd+2kVZwLT5onvo4JN9j+FFz?=
 =?us-ascii?Q?L/wTbJ+tY1TeUFeFHhct5wPmgeSXFfif5GEAFbj1dWMvLxWj6cp1C1BZ8e2D?=
 =?us-ascii?Q?8FugPqREV7e5Zx7u483lhQ6nnwOo8akRNAQp1am8yFtkD35Zf6GJSmcBytv9?=
 =?us-ascii?Q?CPIF1OomjyEi89bURjC0oFQIcrqt+xW6eHEeqowY/jb6Fb5wtw/M/I+WCSfW?=
 =?us-ascii?Q?JQa5it7biBEdH2USbFNwtgaY+Ie8LqpHErtMbxfI5hB2pVf+N3IhJQp1w3h+?=
 =?us-ascii?Q?hVvtdWRHTCUffxnh9CNe28oTelBg7Tf1LLu13RQoIfqljb3sS0Jx3htpHuXi?=
 =?us-ascii?Q?aeqKYZSMtwctdKuVBSG9IyKNVgewLql3+afj/9DtakOBRaSm5y6GcDmZ5dMi?=
 =?us-ascii?Q?rnv4kE8ydSZGGwOhgYlYdwE+zn1Tx2UNcYwjFVRPzaP9r8rSRB2+2SxDUPDz?=
 =?us-ascii?Q?7h0Oapq76bW+WMBuF7nDptDM5ixFfuCdxIb8KyYFrAHZvwYxErc8k9vdXYSC?=
 =?us-ascii?Q?VCBuNZvdF1KFh+i+BJ4gk2DLiJQx4O0UwFtxcx6qUmLogkzrsBDzGGohop0J?=
 =?us-ascii?Q?D/pi3AmbeUTuFwqaFW3Ba7JjJzTnOPrCJR/AbSiOBuLpuzsUWlDMjOwrUx3S?=
 =?us-ascii?Q?TV39u/JsXhy1dbNimd+THsuVf/qDUyQerI4jwx4JmIpqZFdmXeX3KeGL5Qho?=
 =?us-ascii?Q?cD5FzJUwiB6h15Z0IrvHo+F+rT6NI+uadLEaZg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc8e68-ec6f-464c-0790-08db44030a4a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 14:00:05.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if hardware number different to array index,it needs to clear to points
memory space if the array_info have been assigned a value.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304232146.7M89pwCz-lkp@intel.com/
Signed-off-by: Yan Wang <rk.code@outlook.com>
---
v1->v2: fixed building warning
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 04fb05df805b..8b2a8db44b54 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4359,6 +4359,8 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			 * hardware number is different from its array index.
 			 */
 			if (bitmap_full(array_info->get_mask, descs->ndescs)) {
+				/*clear descs->info*/
+				memset(array_info, 0, sizeof(struct gpio_array));
 				array_info = NULL;
 			} else {
 				__clear_bit(descs->ndescs,
-- 
2.17.1

