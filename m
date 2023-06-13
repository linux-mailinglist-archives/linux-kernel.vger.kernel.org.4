Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221AA72DB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjFMHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbjFMHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:52:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2104.outbound.protection.outlook.com [40.107.117.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300113E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK7DAS3Nv5zVL4OO9rWRk15T7CvzbHZ0d523/UEbgN5LVikmrJe8XWbohpt+wXPRgBtMYYa0/upgv6aaMF55fLyAeT0k07AjL6IPpgauVUp91Nzs9GHZ/wqRDgDILAYJyj7uqXSwl1uzZzJmGrOKk7oG2umUowZDRVFjYokC/v+d9IGG6nEdmVhd7aK75FqfPCxxjjcS2FawQ59/AG5vki8YiIEitA/wyuSHoBBsZo1HKtESbMKdCzptBfuBXySqvQOghfpI+/LvCqw287YDH3iv6JxKdhDtd1BCfbBiaaUSJbEYYYnbE6UQyV201NVE05ztaCRcUCwU2BzJrFPHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+3RJUylxZ2BDv8qqONAc27GOdD9mtFjjjMhHozz6kY=;
 b=aFXnNGy3jqo588j6AxXjQLNpIWO2t175IpKlf1m3Dhw9kg4w6Fgxbd3NXUi8X+Vy2trndRtKUDapZ4kCQaWEfx5LI/3O9n4fWlggdNWJ4zlfg/KGMtUMUwqYhF1AoSOVNjCvaeiq3TweuUSSpvacQ4jvbk2SBUgdUUxpqKzOeRQrdLYdF96P2x06sfrN06bD6YWM0ugg3nwN3Ueu5033AwHSkS0NSlP0YKmNyQ+EWT+3NOHWtJzKB/a1yjba2o2nCYgDZHA8y1NtZn3W9w10Od65KTPS06Dqb7/FfP1Drf2ipJZsZzv8WPwknzmhMmQC2Uu3JqoVaKgeIOXwHqQEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+3RJUylxZ2BDv8qqONAc27GOdD9mtFjjjMhHozz6kY=;
 b=gtNwDCoGTj1Pq60w7frQAztr9femWGtf3Vx4pGuoSqAq7y5xRSzRM60m0xLysVjD6mot79RW8A3tqZNZgJ9jWIOFK0hUmVGrdA6ANGvm5jsrWO7lgBudMKGy+XI8g74jU0MFB3CpB50+JB5agz2oWKlgBCklIs6mphIgv4E7ZWynQMGQwZshetQTNCU6RED9hg/TeTqJjX1+qLHUxYLAxr4V4R0ypWLpR6sm/wyniWiZFWEaHs31q/49yPebe7s0fIVS3FH+p5+MxOkKsAhRz4yEhq4AfIqNUDrcvEVh6DoOjUkqENPnDq8JdXdb5RwhNJZPHw3attxYvFZdJ2QnXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6572.apcprd06.prod.outlook.com (2603:1096:101:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Tue, 13 Jun
 2023 07:52:12 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 07:52:12 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] f2fs: convert to use sbi directly
Date:   Tue, 13 Jun 2023 15:51:57 +0800
Message-Id: <20230613075157.41065-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613075157.41065-1-frank.li@vivo.com>
References: <20230613075157.41065-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ea1f3e-9040-4824-2906-08db6be318d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xdOIu/EUGY/IOflE+8i7kqofk6CiIv2OdayXMY9oRHExNDazhPprM4dBLH51vXLPG1C0UBJNIQeTRxKJsJT+TgcObYUGbTk5Yf8vGt0qU6Q2HI5zYK/WWCyUyBQ7LlcsZIM66VZ96f7zCtcCHylqpuw+lM1oVs9J5jvl+GbJ/iqByqj2JomvxIgIcHKzwIddYMtRZM/BIYaPDHMg7jsVN/c2+RSMANRIIpwAgqwoBnc7b6jPQD5Jh6aL9GiOJ4fr8wkLte4jhwUqED15s4PRNpLo5gbCwpBE5CRni0xfpcW7XHLjws4wo1DclWtXyK7d67JdvuCX0rJvKnmEyVNLtUVeRwKMXnqtqd0kNv53OJkMQsRkDERFwxvIomLWBTU5SW5QJPvjEbpvMM6QzHaN60vlXC+fSgSAixfBNAOutsqxxgXOVpbeSV0ovM9SJ5ILOmk0vwLVbyB5/MubI2k5Nkw8SgOvy8kLTnaZ2vcyr9XD9lGkikmhKolqtxdA4nxEKx6c+NUgcqtWwDi5zTs6ZB79A/vgeLRJNWu6e4wNeX2zlz+e6avhll6FiariucUxOQFtmoAd8Si+JtelkHDVCMAYiGAs4sV0gRl1OF1gxGpNB1pq+gsNlHp+U0C3c3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(186003)(52116002)(2906002)(6666004)(83380400001)(478600001)(1076003)(36756003)(6486002)(2616005)(38100700002)(86362001)(26005)(6506007)(38350700002)(6512007)(66476007)(66946007)(66556008)(5660300002)(110136005)(8936002)(4326008)(8676002)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARjeGxjwyEApYyIx5cIGpgHw/hxZrAYrkmqWqNdRJSGtb5aVoaqWUq9EwEIi?=
 =?us-ascii?Q?LyAoH55jBuOL1X2QUoeKqaAcpkUZdpgKu9lo78S9W+dRePzEXU7Fp4TCttkX?=
 =?us-ascii?Q?fKpfuCUjy0Mnoky80OPeyVKPKKFJuLjniIe3qKXoAyntKYGBKY2RXEbORWT3?=
 =?us-ascii?Q?OwVW4hVfWkxG9z/EIG4pjnNaM2xoD+oH0Cfxyb5otDd9R8rqUcN6ETJX1QiZ?=
 =?us-ascii?Q?WhRbpTni6k0gQYiAZvHHLzhu5xTyTWa2oPsGdSINQProYIlpC9XIErCsG+S1?=
 =?us-ascii?Q?I2PMJMfznXpK383FrAzuAfIJC7WhiV/36d2ZZatwItxOKiDZV5yCwnMJUg6L?=
 =?us-ascii?Q?8x9rDadrbdyVZxOrbhSwcq4Yy3j55v9rJ52yVuKNB1sPnjXnAvEvNMjUMRtg?=
 =?us-ascii?Q?MmTiBe3eCiL03Cm0P5umvsxjsSvQj2iRnMuxUgFNsX/YvWvR/3RuXTd0EwtG?=
 =?us-ascii?Q?mAkH3eBMxo0einA1PiKIJu5M8T+zGvC/8WJGRhuV0rcdQpJbEeVuf4KzA+Vh?=
 =?us-ascii?Q?HpVeL8XHRMIlTl/QPhGd2nRwlWX15SUBES1uzlzIhb3UsC4OhlHuxIhP5onP?=
 =?us-ascii?Q?LFobUFl3f+9x4B8OgiIX4syAGV6dVFSetKvnvs+jOC8TL+sMbhPD10Ik5vGN?=
 =?us-ascii?Q?EIOxASMBzQsifBVhH/nJXMFONPEyY8Um/U+WwlSvk7DStLvHhT3P7R43P8r4?=
 =?us-ascii?Q?iva0crHTRr0gmjkG+bPolSBtxXlAp1fe1LHAiUgxANAQ8omrJDJfutVxDMGU?=
 =?us-ascii?Q?dGD5VVmZ9sK4qhxc0xfZSB27DTGZom9a9lqoYA6lEJOpzRK5sAL6bnIuyt/W?=
 =?us-ascii?Q?vPEakwZu1MWHCEbK9Fz65Y6UaixJ2zpUruddSrdwtfNQPqraDZ1woEyjcGOb?=
 =?us-ascii?Q?4YqJShLmZ20Qi+RyuaHnSFEkA8xZzbVt+UzoivykQ43SXtgJHIhzD+bFvx68?=
 =?us-ascii?Q?z+Yi6yL9HkQh74YhTLuvi5HgsvNPswxaLn/EmXEWQxKsohkNNSmQy1dRkOlj?=
 =?us-ascii?Q?t73Voy0ONLI7m0+UO8PMv8eLpdAwPhpP7HdoFMAY/xw6+nixbbvU5fWLkMy/?=
 =?us-ascii?Q?QlytAmSmU0o1one2ceMjQ7d+uivBkClqnbKLv+tM4hd0Y5H1WOMROqQJVrbM?=
 =?us-ascii?Q?9deNrnVjnc1ZADD8undryqw3wt5pQ2qAffgOOuhOVOgwdCdPmcxwvqXZtwLn?=
 =?us-ascii?Q?enijWVe7qWtIOMgfF4u0TiG3RavF6CLbYi04BBrXB9uqWpk9z2SiDXu0FPaS?=
 =?us-ascii?Q?+wsmk8+xaTi6IYIPlFvVtqguvnePAdEg9Y6rh0g9rwy9TxTRQ1dFcoPqtOtr?=
 =?us-ascii?Q?vcVjdFe+DyPq3gjGDn9pvjhzdY6pdKs/jK3fjUTEUj5NFrTNjyKHLtCG+NRk?=
 =?us-ascii?Q?lWh8a9cQ0ODJp+dyx19beDWQSkIT84PmkIdRTk9MYHqy+VFR+uztS9EsNDGZ?=
 =?us-ascii?Q?fozK5hnrZLuTbY3iO/qpJK4MUSXSn6elN2dmOl2ApHg1hCX30luarHlxbBYv?=
 =?us-ascii?Q?z6xWFkAZo4YN7aJSFjxHgzeaFBsRO6MiY18vVrNCigd3WNDKFrYNVsZAfR48?=
 =?us-ascii?Q?hbHB+VfKVgjWHpEo9oJZTKUd4p1rbYp80Z5xOObh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea1f3e-9040-4824-2906-08db6be318d3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:52:12.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00cfRnIVlkJEqlmxArBE3p0LSycnt8O6NpYpkzFsUyIKEPk+kvb1Nt+wEVjEbpElzpf1D0MKO+JydzhbRt8j5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2FS_I_SB(inode) is redundant.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 41e7c2b80f31..f45d05c13ae5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3476,7 +3476,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	int ret;
 	int writecount;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
 	if (!f2fs_compressed_file(inode))
@@ -3489,7 +3489,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
@@ -3646,7 +3646,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	unsigned int reserved_blocks = 0;
 	int ret;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
 	if (!f2fs_compressed_file(inode))
@@ -3662,7 +3662,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
@@ -4056,7 +4056,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
@@ -4131,7 +4131,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
-- 
2.39.0

