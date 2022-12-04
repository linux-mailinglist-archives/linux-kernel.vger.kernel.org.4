Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F21641E2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 18:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLDRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 12:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 12:11:57 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2079.outbound.protection.outlook.com [40.92.52.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238612A8C;
        Sun,  4 Dec 2022 09:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO371UINyFLpM4YvtDQ7JsluBEkY5vHNbo3Fr/TPETb/2EJzIMwquVZCs8v8Xz3Xha5hpWXKZbwruru8m6I5B4QCRjy7L6pJFPayvYoIBBJY1UHAgi0uWlNFMvgyEyMzorBrBHp0V13UEkAECtf3jJsgeVoA7lpvUdn81xY4myn+/WXLmTD0Ju2LVg9Koy7nvhlnT2INnRidTVLiUQ6mmYficWNrv+7B+kUoUBqvNvludTYB9Wu1YJRFLSQniHW68P5UvorvhyXvIl+TvTwzzrpHZRRF8N64b6Qw6J2nkeh13MLEXhhgRTMj38wQUebjhdKMd0qyRJR11oGNRDVUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzxoiPA7+XUkBdGacXVr8b3uRRVKpmaGFJzlxuHlg2E=;
 b=eHJzt4P6ZNWTCJVSzVqQxTqsifeaf+Dr7hJA9ZOzinuHZ1B168biNhwW2GNqVDkvxUefAC3++/7bQHTkpqWBCeyHUaqgcWR3AvH4LsW49b5LGLwn5iAlCzg9Heu7xH6bYTVH7SQC79RJFN8GqmQUyXk6FUjJBwEGndjHlE2OrxG3rqh0EaHaTOXiIP7C7ALELs3IkZ45gjXjiIOF3/dS/WKX4sLdRh2MjwV/HNTI7XWE9EsABVoDocxnFfFzlAFdzsogwe8nDk3mkWw2+Jmd8HS19trjk4/UG7EnrRtmB+1XA0jbyvYtPx5RJ5MCLMwOPLT43yfPKp97WVfAbtz/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzxoiPA7+XUkBdGacXVr8b3uRRVKpmaGFJzlxuHlg2E=;
 b=vMndUFmeqPHS0I7emGMnFPZzVys34+tTx/sqfJF8Oqme1xZp6R0bUBJKSSn13qDw+I8V76GwKm+/EwG58DjMgAv4+0k7DbFIPNozXajSWhQpJxNUlYsd/smdX2tohc6hPsLha6GA4laNmcCdihWqmSp5ks5k8nGlKgxfCAA1lwhOdv6yAVVLFCfgVz5OSFeaIlKUxaFZbt1D+m/a8u31f1CYe3X6GfMuArMP156egynRJuc1Uek78M9oR/v8ZrjDUqoHOep8FppqyyzTAgp1qaC3uIx6T0/xKYxCbCk6l3GX2jRxGEnWHVKk3IVcnQdgMJfWEjRpbOnTSAU/AIm2tA==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by KL1PR01MB4669.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sun, 4 Dec
 2022 17:11:52 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::483e:25f7:b655:9528%6]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 17:11:52 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: mm: Fixed a typo in balance.rst
Date:   Sun,  4 Dec 2022 22:41:27 +0530
Message-ID: <HK0PR01MB28010D0398A34AD3031CE42EF8199@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VIJDzyOm0Y7o81dZ7jejOB3uJcjcvlZ83JT5GofIGWgsjoBcykiAcTgcOAyWFwFgin+hNsnx5hk=]
X-ClientProxiedBy: PN3PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::8) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20221204171127.11269-1-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR01MB2801:EE_|KL1PR01MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: fd16557b-d386-4df3-0d0c-08dad61aa322
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/G+erGN5cKVxwEShY2Dw+p/snpVwzGVHt0h7YnapgB2/QfpuHIPflto7wz1crzMm2qN4aQEcGi36KVnL1gAsLN2anuRUY9aZXHpUhmSXe0SXVzct05Ec9ZffwulFQ7Qnne1yf+r+j10gEZmFOdiuCB9ZK+LcXIIIQdcFNzQAG3sCzwrMcPyBdAtkGJDmW+L8eUL2BOkdi2ljlavkqykyESbmFHRtocUf3rJwF+Jn6u/77V39VCcQl4c01BN2y5tHbI430r6u02rXT2HaeLlexDuDXvsNNKsRY9ClrKUfoP/+I0+pRndMMgqMzTonq8utAoApVWd9DOFJG767SpORv1yLVPPIpG0Trd+q4T/Dg1LBLYP9Xb7sVJvE8+XDeaf3sic7QdhHG0AvN4891MnDShcl0uMiEtuyMNYgY/BUIog89YJYBTz98PIiVhtgI2wYeEfZmKf56wJKaSR4RwsujsJiK8GODgDC/GUierfkC+QHX9dhd1UTANiWibVm9jh6+pMNLlhhoBijI5GBamGEsfs3PkPQOfyVJyGaZ/8EaWShk6YTcKnx7ZxLx6d8/JL440mLlA+g6bPMyKj02/C1wbnVNA8HBoSQenyNsD9lbI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDIvKLPWcFolvPclT6owfDSzL6Efa82Pz4f8fYiXefSJma0NedcPCkCBqyAQ?=
 =?us-ascii?Q?bLEN9ATRSUvqmHYNgjzNI9xlrZZ0sBQSUY/wSvrVMK0gC4xv3dIPPguo9Bup?=
 =?us-ascii?Q?00eKUmabFJDFfEDulxONOcmjyfBTxXlghap0xRjXa19fMjlfTr/HHWdMZcTm?=
 =?us-ascii?Q?Jup1tJ0avoOIKxbPGm7wuwJ4XVl+vZ1jWr44IQLNkYk0wgMspLL+5Kg8hBd+?=
 =?us-ascii?Q?Sa4F1SsiEir59ar3xvXD1UdPcSCmmNabfvuUFXZdIlvIrNPo42oV9/vDh4um?=
 =?us-ascii?Q?ec+a2d3yhDTHZQw8/1X5ZzhcRHxYJwyOW59CI4Y2Xyl0apuahUhhZBzNiTF8?=
 =?us-ascii?Q?UPUmcfjw8alJ631d0zvCdsZxPRwEJLmMWl1GbhDqA+T+dZzxHKDHCi/GzWAI?=
 =?us-ascii?Q?PznJwg5f9IKQEcZcdMVJNq0ywsS7JwwBOYIO6UwFSmA6ix7zhpdMcUqY6SBg?=
 =?us-ascii?Q?cKkc63OFF+YYYx/pHjipp98dXa4AVpgTZSBZBmbOlxn1IgR302RmEXKJ/CdN?=
 =?us-ascii?Q?+cpk3dGkNF7ChzJVjKtoLnD5UlnGbuKkUCaJGJT9VPZtGx0wI/esDkg/qZC7?=
 =?us-ascii?Q?I4pgHmuxHK/OS5NwUvbhXDOdFsu+QoCQCIAUAie6aCn6b//x/qEBUHzepR99?=
 =?us-ascii?Q?p6VCUkChTbqKkbGo1XTCY1qLz/DEFJ0domivKq0BtfEcMM70BKJCwd1rt2WR?=
 =?us-ascii?Q?I/k3y7erNRv86WnEIfh/XDvQ7vGWaXCwUPklP5JDsLZeC+fCD2l1X8vM8QmX?=
 =?us-ascii?Q?robiQSMwBeqcd6n5ZKZWq6PPUz2DLG/rxHwA50P9xN9e01F4dOPobd5QZZ9b?=
 =?us-ascii?Q?eVn17gunQqKkt6qhMldhM3TwCiaESFy9XS44BWGZlVrlp6GoqWnTVkROPwTy?=
 =?us-ascii?Q?aKjG8AKCZ9KcmfTF6WFHxO3kCMKuqak613V/jWXw8R4nBeRWpiWhu+3mk2hE?=
 =?us-ascii?Q?RS7XmZl2oQK3Y2oUgX3xfgE+bjKP/ZH/dpKcmv+2Vbid3oWsdIyvLJ666pKM?=
 =?us-ascii?Q?E3lcOry8ckV67L7CzX3HH1tQRHQ+WH7bWtcsFCCKUkZmuBI2iDmJqFh0XwiD?=
 =?us-ascii?Q?HkOlDgpE8p+lZ8+s5HmyelmwghPRVTQi0WrrQA2sScI0+TF83n09nnTr+nmP?=
 =?us-ascii?Q?lJDyn2ox5DhTAzT+kYydGLSKHycb/1NC8VMv1xjosyIBwoAml3QAwnNRp/93?=
 =?us-ascii?Q?o7NPy8r0XpKgxWVGSD+PEfGUyt4ruia/7MTCOCid8y8RHytHLWnEH9I034r4?=
 =?us-ascii?Q?hGrgdv5hg7I/KS4JNJXcSDxJ48WY8VbY9+UCxX++G0DYxfl6Eg3H/jpEvzbO?=
 =?us-ascii?Q?u37QkrJyiH2dtOAea9miXjr2jcA3JmCoN9MAQXwQc53cIqrTK8l6qDMNfuOW?=
 =?us-ascii?Q?iCBkVVU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16557b-d386-4df3-0d0c-08dad61aa322
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 17:11:52.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4669
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a typo in the word 'watermark'.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 Documentation/mm/balance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
index 6a1fadf3e173..3cab51dbe649 100644
--- a/Documentation/mm/balance.rst
+++ b/Documentation/mm/balance.rst
@@ -83,7 +83,7 @@ Page stealing from process memory and shm is done if stealing the page would
 alleviate memory pressure on any zone in the page's node that has fallen below
 its watermark.
 
-watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
+watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
 are per-zone fields, used to determine when a zone needs to be balanced. When
 the number of pages falls below watermark[WMARK_MIN], the hysteric field
 low_on_memory gets set. This stays set till the number of free pages becomes
-- 
2.38.1

