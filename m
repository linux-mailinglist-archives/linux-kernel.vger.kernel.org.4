Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC81F642AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiLEO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLEO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:56:19 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353F1CFDF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbRTuZPb9Oxh9wMNZlX2MFdygJSgt/H/mAMzvgjAKKVzMUSutGNUhc7gzlsfgO///JAZFuNuF231F7ESaIzZubMw5z3jM+sYoJwMzf1BdKjIrR/kZcXAGo/T7gBEM4cahK8lChZXIcbmoDC4EhaQ+T6UnBkpMriyLTq0ck3F1Nk5102kZygeJQc/rJwjqlVOrOYEEcO8kj4EzNTcpwNGlSoMUpiCa50tnsAARCeZd8ZO8btrlvHTPTi0ZuVf76X2VEn/95QbHPmE5lVRQH+JwqnacZh+J+jKSIjaf92PrNwhdAdsni4hu2o8YloWeK5HJR96hyX7hrd/zUz6iSzgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwZPEk0/yDwOeWJJRjEiTYic+YzaSVaIcjeYboXWcow=;
 b=J9Bis7fg3Iq5zs0NdMoW/T/eGgMJvsfPEZNpGxAwv1/NJMh+jwlxIeGpOC/eJXwvtPZ8z1OXHgQkE+xWalsSH1isMGFHtG6RRcrUV4fuExIVKPfH+IwAumEVtdIjLHVLq5vfs41XY6cyzzSfg4swg8p4OsXxBA6Fw9PQ7H7yhf6KtHjlTGjZEJKKTV2P4DKlNnyYPgkExnTrwCaHzTgRZiM2eJJ8pW+wcZYTql7EO/gKuoFZ94wJWYEZfSlCG6LcjSvAjnS8DHByV7xvlA6WmLXoTunrm5xLRn7X3NBYJN+cyK7ZYHn6JmeEvNGlrm/xNroAkS3IJW3iUf5rYozByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwZPEk0/yDwOeWJJRjEiTYic+YzaSVaIcjeYboXWcow=;
 b=bcaWHSyGxz22YR0Djujrq8MK24gY4KsAtvxrxFS+941pF+oWpqzOYHVoqZhPfk8obJEN1RKgcNrTo3ndzjvho5mvtJsVE2RDu8J4pCNFyqkm4j0rTZqTSk4c+M0TLivXJHsEAQZtpFZTnJkB3rV9ORtnoM+AsBFKRYFSJCruVRgPVR7GTQsufvnFx0lGUk0fvRVKzA46c9hDa+A0xBHtacf44Bo/dc2yLTmdoUAnp2ruIGDcpuaigmzXYMY0MZhfvsaXDzbuEBvTe5t+f1WuyiBO4NZ2tcS15Sqm87pmKjq4H38/VyAZwOHMAgQovUhC4mgYINfzrKZL7L47c8BlSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TYZPR06MB4015.apcprd06.prod.outlook.com (2603:1096:400:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 14:56:13 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::1a6b:98db:3289:3369]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::1a6b:98db:3289:3369%8]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 14:56:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix iostat parameter for discard
Date:   Mon,  5 Dec 2022 22:56:03 +0800
Message-Id: <20221205145603.70779-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TYZPR06MB4015:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d6fd88-fe49-4986-b863-08dad6d0da4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udJCzo3SZOhmgMv/AbCMJcnBRQLdCJ96RMnIxbodlq41jVK8qKo8iknZVetSOaW4B/rbbXMLMl3coxNga2jIs4MN2LRd+d9yu5gMzg0jjVJMCKfjj5Yc/eLzimPVyM3fFVJVGG3f7wbZA6JTGWSj6KCQTdUSQ977BI0FuxnS46Mz2UactKzxR3Kjqv9fi5hLuTxsasN7IvhnCMGwyopJez0PE9/WZmKABYtDkuk/KfzXBbPHzYMzI6o65V6KgIu5H+UuZT6wKil/Auo6jLyh5FedtEV3DU606e8006mvOneKnwtwM7G7WYGzhZP07V7HTY8/QsNZ4GSjHLlUbcGhOB/BbBtaZKawjauM/DN/k21BmDUL7rRO8GJCmZoYPOSCQZf8HoD50/HGa39hKSKg5vLhSob38be5Iakf64Nv0KeStd1HWiPubeQDyq7qf8MLai05NzqygJf58QpHkRYAmhiquyM8JoDO+UOypGlrEabi/L6VyWAFhg4hneOyh8XTzeQXhMa7sCLwYzvX0h5JBo0uLFKAPxd5bWgA3/u4JxcxPYP0E40ceF9jSlTv1ljrcmkAJ4n9yNE5x6yThGVNuYjKvsa8IBatsPyKVoHZUfmMWeKF6I3GfFa5gVBozPJ7nQ3PWdAu+n/01+boWursY8d1HF2BbM+f+2rhZOmEmjOYBLGePBdOhUKsmlAwimQ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199015)(83380400001)(38350700002)(38100700002)(4744005)(5660300002)(41300700001)(2906002)(8936002)(4326008)(86362001)(8676002)(52116002)(6506007)(6512007)(186003)(26005)(107886003)(6666004)(1076003)(316002)(2616005)(66946007)(66476007)(66556008)(478600001)(6486002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tp/JBY5jBjydYP4qTci3r2+E8ZQkIunJLvnn3fy60cKKIw9rfKP74RnYIBbN?=
 =?us-ascii?Q?PeLUdk5rCo9WBy7HWf170T8EpS9b7ACXpn/kDTBRXRQMXQhort4moiy1cxfI?=
 =?us-ascii?Q?WqkA8lXMMcS997GSEr2gWfETAL3U+ETz1+yWFCfMKML9E09p+N9NLR3wSXzk?=
 =?us-ascii?Q?rlmbsdmrFOc3Mkq0tz7gbuv0Sw8IajeKMi+Lxsb1Ngo60ubxDtpCMx42WFai?=
 =?us-ascii?Q?o1w5tPiL/aiFM9i2WFXm30nL0poRnY1VXXOO3fXjhh89k5QtQ9S0tTe8+X7i?=
 =?us-ascii?Q?kLZszm+kkojJ4wci6dvmfMt558ej2C8WEyrYDSUZVJSeL4mjznDa/AzlD2ZV?=
 =?us-ascii?Q?VSuNeCExkkkGYVBhTK9X47WaT5MxF5J/2L+FVKqlUmY1uUOZfvSXTMBqemZ6?=
 =?us-ascii?Q?0Ypi995OC3M2yYtS7kC9Tg31Vm/fvVIXcYuKR5MoIscYJ10BC9Isxh9172T4?=
 =?us-ascii?Q?jSNfSFN7E/EM+BREcpgfTnplkkdOPrsK3URH+BiME0L+bf5iZPCvYDNMJZfJ?=
 =?us-ascii?Q?1KkGne4rGtjNqKV/fI2iSL5yH1rpcTqxf7AbjFSSjOf2cV48vN2nhj7DsfbY?=
 =?us-ascii?Q?/bYpCD2c8kUkrLHKKK223W3qMJhNKuvVntcUat1a7+1s9lIOStOZZSacQQ0b?=
 =?us-ascii?Q?1Ml5hCJm4fz+eJ63Rh8KGLbFwJ9qZTBpC+5RDCMUraOqrkAqnpXyXvRl1Rlo?=
 =?us-ascii?Q?GpCs5EwztHCGLe4+SzKs77bS/qk6wfhH8h+gikqyLl3Y2tPYngZR7isVl/Zq?=
 =?us-ascii?Q?3lpb7B6De2j+lrzRroL83u5F+xSRmDaTGmo7qRv8FwUK4mTqEoJG8qVzqtsI?=
 =?us-ascii?Q?Q4DQcXTDyUhhnmeB8xNl+k/0JB05HU2fbCByhv/ALqt8pv9SDdkEctDUX74N?=
 =?us-ascii?Q?zhEu56PQd4UvW8Qy3qLYCn1t8aED4Q+hRIFrnGZKA9FjjeJFlrqtJO+DRhLC?=
 =?us-ascii?Q?Ev9V790GR31frBa0TLWqXOS/JJIEIb/QXmckz/8q1zBs5FL07tMgfxgRDufn?=
 =?us-ascii?Q?+XKA3zDYDkvD+yVSkfGOqLErQllmj5YqsMHH2LD/JHVe5VDPM6ouBsWmzQkz?=
 =?us-ascii?Q?+w5AJFd8g+nC1C+qeUq3HOeO8c+aNn10rgUorxMCQY14VwFg2OcBhEzllwQP?=
 =?us-ascii?Q?hFbJNbcyFTauwm3yybVeh65JqtsTcmE4ZH/UTDzg4ba9ZWNl3gLy4jt8yYwP?=
 =?us-ascii?Q?mdL9xaF1qlzgu0KqpSBiT11FM6E9KdBdLsd2cspRSJde7eJATZ/OqgIUYrS7?=
 =?us-ascii?Q?WTVmH0sSeBCDlQ996SXpTN65imAcNFywt+OntO3zqtMkpt51aSYjDpwqOOFn?=
 =?us-ascii?Q?l72NAFplOQih40rHwZ6fag18LPYfeDSpq6D8cHPh/mHTp/J/w8Kk9WPRkm5F?=
 =?us-ascii?Q?TjQ/zjTR7J97OVLYzPhlRHELXka+WqmEWsm+kgOkNCh6m9LrT84ylmlLPm9g?=
 =?us-ascii?Q?tVqTbaV00e7U2bDSFbvzTTTcXMvDYMo+KetEA5sCy5BvhL/HqkFZkYUIT9VG?=
 =?us-ascii?Q?G0/JgtAD19+yfY9hFzd3A0WJ+29IlqtqrBmcy27UTLPbFMerlKYN6gujlX7K?=
 =?us-ascii?Q?Zh67CBogTJ3W8k2wHIyv0lWMahp7BkkzLtSV3Rjn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d6fd88-fe49-4986-b863-08dad6d0da4b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 14:56:13.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA9u29/Hl9OvHXg5TKnDDwDc4JnsTpt+2kocUGEfp4pkbBFvTKPG2ijvoK1sQyiLEH33BHnAhRRgwnEOC2k/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like other data we count uses the number of bytes as the basic unit,
but discard uses the number of cmds as the statistical unit. In fact the
discard command contains the number of blocks, so let's change to the
number of bytes as the base unit.

Fixes: b0af6d491a6b ("f2fs: add app/fs io stat")

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9486ca49ecb1..bc262e17b279 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1181,7 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		atomic_inc(&dcc->issued_discard);
 
-		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
+		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);
 
 		lstart += len;
 		start += len;
-- 
2.25.1

