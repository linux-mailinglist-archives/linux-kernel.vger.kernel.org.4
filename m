Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4469DB14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjBUHU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBUHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:20:53 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2066.outbound.protection.outlook.com [40.92.53.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E91F4A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:20:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbRPEoyzv7b0TopQ1Gi0XKXzDluASKi+vX6XBEvurdYl+V+tufxdUkZ03CqDaLKhZrq/Vgjh28s2TAW63hD++YJEWK8cK2P0TYUloRpww2CVrpJ7JwVLFl2C5Jt/LhB25uJhdRsUivO36sWzlMRIhdAmyrHArHvh0OqOdpW4/aLsckCCX02G+/JGaIzeoiA+nOYejbObRn0A2c53zFmtjINZrGyP5Al9tJDGJBpPzvvyYZ8HNwmXjm2gJ40ln8e5hZozFlOZhly5G07Cd3gr3VWmZZiGhH6J0rcxmZoHGfNAzWvc8DJBnDtB26P5qa0bN+E17R4GWN1KBakXU1K+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxbd5hUx7XQgsX8pA/M9HUKxRf+A79EGUzcskJNKMO0=;
 b=QxsKa5Xw9ageMOniUU59nbZyG2ZXn+RPg8jL/AjMFnFy+kyYEUaDKaCWLCHSf/migWgz8HwSawFQR4VHv1R101zDoEA4fp9m6HKrjaVG85pHLtbP9CNgIXOdhNnRZmX4zkXfRiZilvnmhtAd9rml1v4Ykh04JUELsm8YAk6fVLwQ9T/UBLy/cEP0jkdBjnnisbSdCTElT87W/q+cv3HoGZBk3Q994rejQdFbRkLeoo0uoF//6mYGPq7kAbgUOOO1YjkkgeD9t63NK0YACxg8dqFkSy8kK0cEf3aL8h+PS5G4OYBTF54Pvy7oze7Os8AN18gwH2C2PcjxQmU+RexBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxbd5hUx7XQgsX8pA/M9HUKxRf+A79EGUzcskJNKMO0=;
 b=N/1f0S6GJahS1Nr7HGvm9W6vWOxgaHig0bqZpg48Tl+xEtoP+f9+FLWpC12YHVEhaDhsLnK48r1e8o6hjDKqov5A48jkFLbO6Q/9vn324womCqd+JRKtayyta8EkmdTrWEqRGhcBROjgcKI/8mLOYNUFwjTNmQYR9RqRin004a55AmNnzPbfkGHH19QKesPkfdAyzMi+V7LnH59Vd9cZXrUSI+mXGwos2t9UJWrsi/J0qmeG4NJKgheX7ameibet2/0otqHlyRJkGDWcsJ7eI9j+Lc3YY6iFbo8urloECi0TYF3R9RJDSD0ke5zbwOADriYYI43ovjf8d/Jvi72Okw==
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9) by SEYPR01MB5268.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 21 Feb
 2023 07:20:46 +0000
Received: from TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::6568:2bfa:c7e6:41e1]) by TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 ([fe80::6568:2bfa:c7e6:41e1%8]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 07:20:46 +0000
From:   tianyaxiong <iambestgod@outlook.com>
To:     f.fainelli@gmail.com
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        tianyaxiong <tianyaxiong@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] vlynq: Fix a compilation with CONFIG_VLYNQ_DEBUG=y
Date:   Tue, 21 Feb 2023 15:20:35 +0800
Message-ID: <TYZPR01MB4784D2F5E55D5DBE85150AD0D5A59@TYZPR01MB4784.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [ZKeeyGoee5RJZQ1e6EyeUDFnLOvVgS5D3cTjKuxK1LI2rmbOvrT2nCe3EnZVv3w4]
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To TYZPR01MB4784.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28d::9)
X-Microsoft-Original-Message-ID: <20230221072035.15711-1-iambestgod@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB4784:EE_|SEYPR01MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4736079c-1e2f-4f05-dbb0-08db13dc2668
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP/bpYPFLcGPcyPdjcdGvtccc0VyNkOphO6L8VGdWHg/GCKw8uS0a0zNK+ZIGCVEg6iBBOTHgecreutaQdDsgUBC78N/XlVX+mPmQoeKbEE8gI150iO4cd0p4O7LmZIiuA0Lx/gZC8vUIL0FxKW0V81ZG7wOxBKOjrcywCsT9wFmBkU+zTwb3HC8vgYrq7u/fNk//xERjT0+zbhPP4rAItt1h2v6FiynJTT7Mc0EN4mdQrMQntL2pzYKHrQeLoH3TcHt2okXpaWie/M5O8dRTRDgUAaDaEO6cfeQcyJr9NL+Gm4pTbeH9jawJg2jLouANSb0iCTtsTGnT2ZRriXN1gLnbsgMxEPQvRMBxsUIxBmI3gecst86y02ZCflzrIlhP7F6SagnD20zaZjEdmIWq4/cclVa7n82aytDquyS6LUdJyfvhlBZY3KTT8fgy8i3drmrDFsK307QLsjFfRWM4fQz4nM78Vgs/O4HPNNRzn7vDY864nc7RpEklwDIuRpyGKaFHtJnxQVUTTBzLzTVN/00pcTF/aa5mS40VOflIFAAhTMvaVxldVlDh/zwlFOn11GJgk45IQ8PQrbsUFfFMPpPvQIUxN6M9JjnHWj6MRI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBWVDBKN1YrUjNFeEpLajZ0ZS9Mb1FsVEExVm9YcU0rUEFuRFEzcFhrbVBL?=
 =?utf-8?B?UktqL1ZiS1BiWExPeVMyRHRpYTd1TjlJc0xjbHVrQ0JqTDhXN3VEb0w2Zlli?=
 =?utf-8?B?YWo4RmRIb0RvZmFMQWQxZUtVUFl3T3V1OTUvaHdWeWpVdGdTL3B6bHYybTZJ?=
 =?utf-8?B?bDg5cFVIdUYzN3lHTmFXWmV2RVMxOUdYR2JPVldpMzJvcmdUTmFzQlJhUGlL?=
 =?utf-8?B?ZkU0eWJzV1RhVzI5T2FxdDgwWFFaZmVHdXpoUGJEV2duMWJVWHNzWHJzVnJp?=
 =?utf-8?B?M1ZWcTJIUk9WZ1QwcDJSa3V2TzUvNGg5SDBaUkUwWkJxSUNVSGZ0dGZZNjhR?=
 =?utf-8?B?Wk9Wbm9wZDdIZUxvd1QxbjNpcEYvaUFJakpjY3luNXkyWUhjUEVNMGNZU2N6?=
 =?utf-8?B?MUtVZTQ1eUtnbkFFM21VNTcwZTlBcFYvc1QyVG9XOXNXaGtNWjMvdDRySXFm?=
 =?utf-8?B?M2RmMmVBRWxUTVBmbUNOZlNNc1BpT2Q3K3VlYmZRY2hKeHpzd2ttdEs1UVQz?=
 =?utf-8?B?ZG80RU9yUGNtRzBsRjFVZnNQRXZpaVN1UzRJQXN0TXFEUXh1bFlTSmNTOGwx?=
 =?utf-8?B?VlBaUWwyQWZEeHliRWtBMVA3Wk94bG5KQXZqb293d0hRZ0JQZTNDMUt5ZGxa?=
 =?utf-8?B?b3V2dzFJdXgxNFV3Q1lUYmN1RTd1SUVqWGtRaUtoc3MvQXlqMG8zMWRQS0FF?=
 =?utf-8?B?WDhrRm1sN3NnSUpHL3RnWWNiRTIxcEh1YUcxb0xKTFZCS2ZBMDRsU0hZWGxG?=
 =?utf-8?B?K0RrcytHUXpCaytSc2tnQ3VKcGJrYTVQVTJFaXRNUWk3YjVwQ1AzVDV5Y1By?=
 =?utf-8?B?MUozazBYL2lTKy9qZE83ZUpHUTgzSkU2ZWJaVFhBeVp2WWxKcUdMSEpEbUdP?=
 =?utf-8?B?ZW9lNitEdWhmT1BlaEpjWVRYL0FpRmp4bEVrK2V3bTJzblRJSHBrWkFWZ0l3?=
 =?utf-8?B?cSsyNFp0a3cyMnIrQ0FpOHlsa3R2M0V4YW8xcXAyb1RmdXN6TkFGTUpzK1pG?=
 =?utf-8?B?TGI4MFNJazRZWVNLRDlqQ2RkQi9QNXRkUFBnQjk0cUdnVmdkU3llbmVXMENJ?=
 =?utf-8?B?dGpMSFBpcHRrZWdacUVnY3JwWHZhZTZQbldiN2hIeUU1UThUd25QMHVxd0VO?=
 =?utf-8?B?QjhSRHJFV3NPeUVHTm0wcHNjdlFld2pRc0swaTNlV3dtR3lab3ZTZllwcW51?=
 =?utf-8?B?ZURwWHlYUUN2ZDZKS1c1SjVycFI2UDc1UUx4MnVzUW1YUnRVOE5rYzJqbDZr?=
 =?utf-8?B?RXhPMlVHekVaMVRETTMvZEhGMmJGdndUVkZwQXhEODJhSisxelppZUFkOHNO?=
 =?utf-8?B?VTU2d295dHFHKzJiTC9CdDZPZFF3bW1qNzJhZjJJTDB4bXhkdWNGUm9XMFNy?=
 =?utf-8?B?emx5L2ZtRHJ6cDhaZDduUGtOUkU2djVULzdzWitOTStkR1IyNkdDMTlScG4z?=
 =?utf-8?B?UTVDREtzMHRlTVpvZDMweGxZS1oya2VlY1AyUkhrZUdIUytiMHRBN2lJRVFn?=
 =?utf-8?B?bzVoc01scnJCNFZxVjZPQURSQ1JYNGZESzM1QVJ0TVRFeWI4QUFacVMzSXBq?=
 =?utf-8?B?TUw0MVN5ZHc2S3lyMkhjR3JzdlF3VWhhTVloQngxc3VPQ2xzOFRiSnNZc1hw?=
 =?utf-8?B?UDVneVFlbDVSdWZMR2NZS1lxTDk1QUtOK1Z3NE9WMzBtRVRSVnRKMm5JbEtu?=
 =?utf-8?B?N0ZNbmliVUUxdExTOU9hR3pvci92SThoZi9pRHFoVkhleEovNmluQ1pBZWNP?=
 =?utf-8?B?NFIxck1wa2V3ZVJ4cTd1WE5kc0k3NlNJbTJ5aEQ1WCtGMHJGUW8vd0lkWGtT?=
 =?utf-8?B?VFNPQjRmOFJCdDFxclRxZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4736079c-1e2f-4f05-dbb0-08db13dc2668
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4784.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 07:20:46.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tianyaxiong <tianyaxiong@kylinos.cn>

  The vlynq_dump_regs() and vlynq_dump_mem() are unused ,so when
CONFIG_VLYNQ_DEBUG=y,a compilation issue occurred.
drivers/vlynq/vlynq.c:82:13: error: ‘vlynq_dump_mem’ defined but not used [-Werror=unused-function]
drivers/vlynq/vlynq.c:68:13: error: ‘vlynq_dump_regs’ defined but not used [-Werror=unused-function]

  we can add __always_unused to fix it.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: tianyaxiong <tianyaxiong@kylinos.cn>
---
 drivers/vlynq/vlynq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
index 4af6615808cc..6b6d6ad8ee1f 100644
--- a/drivers/vlynq/vlynq.c
+++ b/drivers/vlynq/vlynq.c
@@ -65,7 +65,7 @@ struct vlynq_regs {
 };
 
 #ifdef CONFIG_VLYNQ_DEBUG
-static void vlynq_dump_regs(struct vlynq_device *dev)
+static void __always_unused vlynq_dump_regs(struct vlynq_device *dev)
 {
 	int i;
 
@@ -79,7 +79,7 @@ static void vlynq_dump_regs(struct vlynq_device *dev)
 	}
 }
 
-static void vlynq_dump_mem(u32 *base, int count)
+static void __always_unused vlynq_dump_mem(u32 *base, int count)
 {
 	int i;
 
-- 
2.25.1

