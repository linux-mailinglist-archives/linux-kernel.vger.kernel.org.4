Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD16EBFC3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDWNaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:30:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236361716
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvlsmX2rTxziMF2ABPGPoM9afrgYlSg4mUxLyQ5rAyUuIxSPawE5uV1yQrM/M2oZPgdZXhhNK9WhuQIi4kNrtD/wFXZFCjr174AQyWl3LhPrz5JVMnnPUbHhZx0CdePun5KN3lsDngBbmp82Gc7TyPLjFlF5GNanouSrb73c7hfSyhYu/o8vaga2Eli3izUE8cLAyNs5BAFBM1QYQNg2coPcbwfZHCV3CvI0EI5WqT6parusvpIprz1mEBX6UNZ+Ra51mHI1cOfg797l91oSkp9Bb9KPaIRyRFHxsgupkfTPh4X7Q43qjBhYXjMGKzf3dge6Iy+QOGSifqfIH0pt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clf+2IbK56RT3Obg0ZMaawd3iiZvIARsZqzEqkrNonk=;
 b=hpJEwbICjnZZZCMRTGmHhwHiIOuAvOwtKPTYi9yoeoAH9J8k7XmFesgJaZqgUACcZOjgksamaT1DI74a7DALAohj71qvXfJO41t3H9eZyxYktQkUva8CwpHy/yT08ono2oE6kCb4dpVdrvE53ZAvDNsjWS1ixGoGTUsQe5gUGT2eIQmmKO6e9S2nrwO5/3NqGanKCD7MSfCxCuYTlIN+TDFJ5Z6OH3m8cIDhhr8LVEvo8UYL4YPRUnKXpJ0WzwvmLz2uXKzxmdVvYjMbOTBvS5prHPsUdsG2rj8teBZTGVsEYhHydtOCL7+WdLYBMrqyOM/tRwoLqSoaYgLYBU/2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clf+2IbK56RT3Obg0ZMaawd3iiZvIARsZqzEqkrNonk=;
 b=LOJA7IZRh++qYBtGKtFcmefkNP3drdyU0e1k1GNlbl2KxiYMIrfHYLzv+O0jx4G5GKz7mzzqAyQKVkhhDYOZ4TqJ1QPNbrf0HROs5Vo3+pik6Jo0dabVq0+fOkayfaK8B+FjiQgIjYrZZG8tlE5eL8r/0lf4VOmHo8+qLpC3qPex/L1tsjRsJm03l3W0e7wqbH6WfzUv01y+Nnh7id4fb354+HkXUSU8X7z3OWCZXckVaurKP1JTzPL3jdcFaM4Du2x0XEjJeN7tkhwLONChMBQfLcByaQReq18hj/c+tzIxGMEmlsxNN0vRwtxwu4TkahZPX3njj16RipsJk0yGew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.polimi.it;
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
 by DU0P251MB0719.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Sun, 23 Apr
 2023 13:30:09 +0000
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::ee0:bb65:f9ae:29a7]) by GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::ee0:bb65:f9ae:29a7%7]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 13:30:09 +0000
From:   Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
To:     rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix some coding style errors in memblock.c
Date:   Sun, 23 Apr 2023 15:29:35 +0200
Message-ID: <87r0sa7mm8.fsf@mail.polimi.it>
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0072.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::7)
 To GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP251MB0767:EE_|DU0P251MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b2f908-6607-46e8-91b6-08db43fedbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T25AFBzObfb+8wDC9srF689qqMJIifY5WV4veVdZCv0cMa/SxtWQinlocVZB+/13rfBTeSqGL7ChboR8uyXRX+ESX8aZn32DFX6jNwZRfoAcHEt0am0sVSI6SSz1XBXgFa7cG/70ZUOLh+i+Hb7h8O75QpgnJXXHFMr0XHK08q2hL2AaRZKET4ddoM+FSA+FwtZIqVwkvSxyELPueAWY0AC/vWSLJYFglQFt3wj2p/mYJiS7jyNKp/9ftRxLiPnxVg8ClUA2jK8RH87SBZnWEAUPz2j22iKJ/bnSHIwKfzKVgfJSmIvvrzfmHV2IQ73NunzEFGI1s03A/dNXw8vhjKka6w4IG6X+d4TnA5Qf6fOZs7h6vaKD3ZX05Var0ETc3H6mHqTiIrMA/Hc13QL0f5N1RZRaRxoMDrG6QBwbC5vmMoW/mEcUIOLn/kt3TvuJ/mLC6wE06KYvI5U6lZcPNeQwgI0qwd2EKmw4zx1rWUw7jg0hLvBS3NDuvW5+ZcD66fr7CIG0liOq4tqIi8a82xqz/LU07cbWGCSZCqqvVGd7Ve+9m3SMXbYXhu6+FfdP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP251MB0767.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(44832011)(5660300002)(478600001)(8936002)(8676002)(86362001)(38100700002)(2906002)(316002)(786003)(6666004)(66946007)(6486002)(6916009)(41300700001)(4326008)(66556008)(41320700001)(66476007)(6506007)(6512007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9zWMOHEXK5bL0scOA0xzra2o0E9Bm0e69r7NjZr5s4tMXrvYovNrACkyJOB2?=
 =?us-ascii?Q?PdJH7kFpKKgh02nKRO7Aa5AUN8EY8B2QMSf6TkiVE8apRWTm1WtSB+DYOGUa?=
 =?us-ascii?Q?O5aegbmTghwiVgJTjA9HrCvtGrfkfHf10EhlOyPYEdCYLivTja953NwgQg0t?=
 =?us-ascii?Q?6jMMX8srMf5hPH8oEk3J3ivBBDYA8hGQU3KFevQR3XUo6dhsUYM/J0/0YJrk?=
 =?us-ascii?Q?hIfJJJwiNWWu1sMFfUtGE9A52PpXKLHun2hgw/NR0erxMYtykcmmVXALEPmd?=
 =?us-ascii?Q?YdfFtfMAE4qvstDtoaMh3BdHXeeX0ZGlEAi5BkIJ1LOjqBrLuaKFXb91n6GC?=
 =?us-ascii?Q?A/6v/RoH4LrUZ7I+oBtOUvElg0/gCpdZjAQ+okD82CEzy5qGsoa6z62lXlJl?=
 =?us-ascii?Q?omlbMK4QAw3gC2Ot2aw16RGdj3DNNrpHsrtOTlrBdX031gh6J+zi6Eojq1xW?=
 =?us-ascii?Q?r8Vh5c6gVlWSxkWGk7liZtYJC9pQi2zdx3iwYhUPORhbB8UclKulLH36d/Tc?=
 =?us-ascii?Q?77b/sEx2dz9rT2Kj/xlRpwJWOUZ4NK/Eaqi9Z+8pFbBpcIAZCI1n0V2x+gFm?=
 =?us-ascii?Q?vPM4GEnht7t9kQnvSx0Vtu0WGMx9W4svzY1fecuRX1h9XDq0uEU+WZr2Sg7+?=
 =?us-ascii?Q?XRQofnEOqVvBOlqo5/pu0RaCI42v6hCtHZtnLkGVXjLKjiLg7gXrFbWCtMMb?=
 =?us-ascii?Q?xbbKBL1xHz4ZrsxvyE4yTQBAqhUVS0RD6tgh+LM+SlC6vf5XnZkhuURT29Ax?=
 =?us-ascii?Q?Ylrjq5LPVwCd/ZK+SqdrExYbU+jQZWSLzP6pBYRyRkTfO2v4PQKFzVWQ5g6y?=
 =?us-ascii?Q?s8KFTvel0i3Fjiw5o+q9Zk7da8SfBFprm+qe05aynPz9ljVhFumoME5sPWxz?=
 =?us-ascii?Q?yLvHDlfsrce15CFZoqKuAFYkAvxWaQmM1e5ZQmO56XizoIlCaB0SZKyU4PHy?=
 =?us-ascii?Q?rTvk7siqhEwL36/b5oSQ10QW4Ye2lFR1D41V77LAWyiURIELK6z9wCDWTsl0?=
 =?us-ascii?Q?rsZuvbEwIsFim/+/VavLudjSkJ6yxm/U/vNjoGYho/raD5DZLQqfknGQO/Mp?=
 =?us-ascii?Q?O4ZnhOuYPDwY2kYwsxrdn4zzggwIQW6J8ZtyC+cpsg3q3q5NKUt5WsJeIFqZ?=
 =?us-ascii?Q?jhjWbOBAI6+b/4H942Bx81lKUTgbvZU1g7xM0+sdEeN0rkx62fX5DAL09iE9?=
 =?us-ascii?Q?lnHINqzQjrt1oxnX6n6XQDvPOlgzBNCQ56I6wwnEZoCXnSiy7eE1zeLt6nyZ?=
 =?us-ascii?Q?rl+AF8cJByKSoMJiwyVJtXhPJu0jfUC//UbvQTIB+XohMjn9vysozo3etf/v?=
 =?us-ascii?Q?vOYMyo2ASLAgPJ6mrw4JgMdc0/pATHdRplb7Fmxok+KGzj5W82jbrpn9CFCw?=
 =?us-ascii?Q?KoFuyunNo2+MBaoHVrn3aj6bMm4K9acDt5SHubL83etwPEvrMh6T+KQB4oku?=
 =?us-ascii?Q?5LCUgcC+VAevyhAmsC1HrVFNsiDKHHpzKJ7swJhF53iRAaQAkm1F3tTFX+dy?=
 =?us-ascii?Q?sS0LBig/jzlBPH+FYbZqcGtG+IpUT4fDJr2MjITQkjW3R8ZsFT9HxGEajEJN?=
 =?us-ascii?Q?B5sLqxp8DgyKzw68hTZyirsS8glGvzM13X0/MXr6?=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b2f908-6607-46e8-91b6-08db43fedbe6
X-MS-Exchange-CrossTenant-AuthSource: GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 13:30:09.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPjXKkPkVPCT9FmoZajMa/FbStmoH2D5e/iGCP2RQjkZGSaDvBX442uXl0MGW1tK2ztlY+kJAcr3zB0+2Czy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P251MB0719
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the initialization of some static variables to 0 and
`false` in the memblock source file, according to the coding style
guidelines.

Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
---
 mm/memblock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..6f0a2eda427c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -156,10 +156,10 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	} while (0)
 
 static int memblock_debug __initdata_memblock;
-static bool system_has_some_mirror __initdata_memblock = false;
+static bool system_has_some_mirror __initdata_memblock;
 static int memblock_can_resize __initdata_memblock;
-static int memblock_memory_in_slab __initdata_memblock = 0;
-static int memblock_reserved_in_slab __initdata_memblock = 0;
+static int memblock_memory_in_slab __initdata_memblock;
+static int memblock_reserved_in_slab __initdata_memblock;
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
-- 
2.38.4


