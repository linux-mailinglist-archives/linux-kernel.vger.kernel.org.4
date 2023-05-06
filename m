Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981B86F928B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjEFOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEFOnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:43:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C61A493
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd45oRosOZfQ0ZVMhJ/Lho+6KVHNawtFg4oN/80DSXjG90eaacQv5mjtFWPnDiBAkkvtMHy39K3B7xt7NqwMp4qUKRJRVUp9cbeRdmO77l9BbWdWlNrmpj5SpoGMwfZqlc7zaqEbbu1gMShoLiM+UNENBvn5330u1Ty3Mt+rVgFpw9+xnJV2I//g/KXq/SfV6U+Wy3NJnPci37PSONesx8odLonzBn2K988EqYj9EJeT4NoxfEDHqYw9KKFv3UP7w9Jxj8Ed8HkGy4oitQrdE5SxU2XFBz7PNOA91L7Y3w9mPdfc/fRrb6sj9Z6WhO3kqqNNWUc5mrzHktF2ZgqNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpoWxn71jA/aAQkUlkXtZGYGcn76uK454MB0svTztNU=;
 b=djfNdpEnJspWkLNhKRUykf36BH0cPhoVm48h3QlEHxnk11dQODg/XRxtf6LT1BUlwj1bds/7eVv1vHnZgWEOI9ohaSRPSU0zxnOB8z1cdevNowoK0nnOERy9vTrb1R0E+Sqp14KONwa/427290zwbtE9p7jxZ7qzOeeaJ9uX+H1wJQsX2Il5w1QYLJ1XBd0n8SI9wLwzT0Nb66Wrla/r1VQnWY+NYaUC6dU0nUoQ1wtrOt82Bt7yKzEMqQfd54ktaz1iKgF4BWBFR+fRS4zvVOwWmGIwitgZCN8tm/8WkYWMsDPPI5PW7Jhi7KK1T77E+f/ttCDqAmT2K94Gm9IfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpoWxn71jA/aAQkUlkXtZGYGcn76uK454MB0svTztNU=;
 b=MskJ44mHo3yl/BVLZVa5zx7eTi5qE7FBZatb0Q0RsIzgxX1rQ1uaP7N/cikiAGhxSvYtWo+sjeXmVFM5b1rgoOTgYnaApxhOSTyZHSsYPYp2ZggbYLcLA4MgIiDfCqywgutRX3SqP1Ni8vc11UiJI1HaTN9R8h+DCjutQ11A6N7IRED/ifN+rs+IAF9G7LZyKpg94LEHx6g5Z5Ma1MMQWDDu2LmewoMxqSr4hdyNBfhFCyoa+F9dSrZpx3Lm2h0UBqkcOOr9LVuG6LMtfsUXGRj6vY4CUjPoJOTyijDSUL8XkYB8pkeCEcs7VYXmTB/RPJV1UclYxWianlljq7Q1+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5818.apcprd06.prod.outlook.com (2603:1096:301:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 14:43:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 14:43:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/2] f2fs: move the conditional statement after holding the inode lock in f2fs_move_file_range()
Date:   Sat,  6 May 2023 22:42:56 +0800
Message-Id: <20230506144257.9611-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d597bf-4da3-44d9-3a18-08db4e4035cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5zvXKl/HxnbwCnVItRJjppNNtHA07BSo6RsjWrTwwfiQZybpjUGUG9811ubqbWld/l4mnH1fXqWVwtfwQYFGRdJMoOa0VJBVTGi0VBcr/r7CCmyD6JI16CftSKxdsP6UtB/vG13sRykegbdRnf2UVW96USbPB/Xk8EvCkG3Ht5Ix9ruKdfP9eI3wJVsaHGFjItlPv/c01+5fJ10zr/WZ9c5rvs3TIpsRNaK6faN0NbStze/5Gk0A0ZB476J/k5XszmlXdIewF0bIyMZBLy+KhDcDVPTN1OUK0mxe1Su41kLSYFAS/lIyUmwmGZ3qSFt7gmsWTcOrO6vYVIRc2aPfMYdP+ChnTo+6KGyk3QMLfRSu6JnvTaI36jv6MceOx0FagQtQjVzVP0pyjDOxKAeKpZCyL7V4elZxEfTgOBei/AFQD7R/+cMWWj2osHoEfY8WB2Z+cmHHsEIRViaAewEkWizToLk8/FiYePL+wL65qWhjIrGCjRoxBj0FvrCYRoQNwOdkU3+6MhGk+B4zJjhgXov4BwCkSpOMjJ5z7kkXe7Njd1kYL84brQBBQbXTdKmIYinqRFqEjs6yZU4BpT8k2rRFxsUZC4VHenTaUbrTLHMTNs6Y6aHUBSlYWVPY+X4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(8936002)(41300700001)(8676002)(5660300002)(2906002)(54906003)(66476007)(66946007)(66556008)(4326008)(316002)(478600001)(6486002)(52116002)(6666004)(83380400001)(6506007)(6512007)(1076003)(26005)(36756003)(86362001)(2616005)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyMcQyF0Y7oOS8ZLZw3G8YXHoeWvOAvrZRys5v7wigPS+tU53GHNUYK0Vitg?=
 =?us-ascii?Q?xYiat1BeQt/DZSFqSF+I565W11f8ZZG7wkdh/Ldsqv8/YDxx1vlC29tMZiBm?=
 =?us-ascii?Q?MptnCr4p9CmPlCvdSlwbxxUyOxJQmKVtfZUUwvZZcK7l5dIYy9nk/deWcSef?=
 =?us-ascii?Q?nJRJKk7SzgCOFZarXSTc0psmjlg7sd5PqL7iAHcT8tmo2Zfdb2iUeY5hzO1Y?=
 =?us-ascii?Q?iJrMpEqMMMboQ2Uah5OlLWCs8WOqh0VmDf0Ke/wOX9ZaLw06nkXVblWbMTbg?=
 =?us-ascii?Q?sa/pU+w3bGV7ZU6Z/2YNi/uZK2ueKd/cRTnCYG6EzpNVa8+kq4bl9S7JNPZL?=
 =?us-ascii?Q?M4GwNih31Lsnb1qV+/Bb5nc8rTnhoL40o9RE4ipVqtQzvh4YJRjlzIk6EoXb?=
 =?us-ascii?Q?fpYrV0ytYMYPUDEHW6rF/mmzDNFEPFAxWMJT0swbNT4+GIMOl4RhQeZraBJP?=
 =?us-ascii?Q?daW6OHtApe0kbh0wyvZE6PRdxi70vODeTwkB6yWTI/lqfRHJwQjUdR/+ldUM?=
 =?us-ascii?Q?Sw6kKRqQC2z0wRF8ADP3e9dJgfcGobMZM3KoZqlfBV5WjHFX5RosvRwVdSFw?=
 =?us-ascii?Q?5qGdsC/0gBD+DKrATpD1s0fyYyrWHg4ijcM665TlzOGz6PjsMnnP6TtnEu8L?=
 =?us-ascii?Q?AjAF2U/6FW00NXaizVjfJiNmBV0zjvZHUNCyahrdA2xCegY9tXW4qpqCNDhA?=
 =?us-ascii?Q?f/OwDfdopBoFVKVM9fAKX9Ab+a8ZL5o0yDBdg79b6eMU0vDsI7UgEL+EarIL?=
 =?us-ascii?Q?OrAcMZrgI1D9hoTh8urHT04xcuOniRu1BQIkqu+Wy/wWKMVOyze67ivLSGaT?=
 =?us-ascii?Q?kC3TuyoImtNmcObCwqYziYicBHy++olYvJgW75G/kbdfd4fHf4ZtcxEjRFL8?=
 =?us-ascii?Q?3LRnsk0tWGDccv7o4rb05HiAn4L/IicXYB/tS3LtxC9xJGvVjD73QKoxIcTZ?=
 =?us-ascii?Q?lTki7uqdixHU9AKM69K1cck+bFmeHY7vc39v/D785Kg+OclnZg0YsrIGqnCr?=
 =?us-ascii?Q?P1AAvnfwCaSzOkLQOGjMYLb5pb/iap7ZJdwDKwghfQj7NoEgqMDf51AnJtS9?=
 =?us-ascii?Q?wEF3zDRg7jLt6LpPFtFi/7ivZORvWcSCfbNZ7LHqQHm8adMUOG9w5w8Yt+8m?=
 =?us-ascii?Q?dP9XqCouXVUjvBbUXQDr8wmypUUHxKB74hmFBAa32/HayrJiix/3X8/510Yn?=
 =?us-ascii?Q?aNm/RubheEbtRm3kTjxlpUAl+MUucgE1ukNNZola2dfqGNp2QgWydCsomO1f?=
 =?us-ascii?Q?Gh3j/V47Ld5WWhLq2shizFH2y+enAYjn1FPy7hU1H+vGcbKhXqkzMoPQIhtn?=
 =?us-ascii?Q?iLIqVIcFV9DrkRnwW1LWq0KgjqXF1eLF+avYvjt1FNb0EyRRBSoMpd/XebYO?=
 =?us-ascii?Q?SqcX3xWF0CFeTt/LXkWGT24tZr0JWb2fDG+PGJAc0z2Pq3PFl3/cbk3dSuAL?=
 =?us-ascii?Q?hUwW3sx50AJ1TDzd6pbkIgNHCamG1oljcZauOxerChKAPSv+T9ZNSLZwHk6k?=
 =?us-ascii?Q?2B51Y2GrjVhbos5H0ZMG3AgnfSw8aulf2bLywoScjbGkgP/dWYwzgy0aKPhV?=
 =?us-ascii?Q?fRe3RcQ5D+3irfjUchwLMX1k0UReQjcb7Bcl6XzF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d597bf-4da3-44d9-3a18-08db4e4035cb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 14:43:09.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwGmdlMcSiWieaLbNUEWzhZMFK3XCniHbcFQMUXIWyeu6cOorUd8Bt+IlOqaBaMTV1jkjBCtEPwNG19HW/nR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For judging the inode flag state, the inode lock must be held.
BTW, add compressd file check and to avoid 'if' nesting.

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-add unlock
 fs/f2fs/file.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 78aa8cff4b41..42a9b683118c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2790,9 +2790,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
 		return -EINVAL;
 
-	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
-		return -EOPNOTSUPP;
-
 	if (pos_out < 0 || pos_in < 0)
 		return -EINVAL;
 
@@ -2804,10 +2801,19 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	inode_lock(src);
-	if (src != dst) {
+	if (src != dst && !inode_trylock(dst)) {
 		ret = -EBUSY;
-		if (!inode_trylock(dst))
-			goto out;
+		goto out;
+	}
+
+	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
 	}
 
 	ret = -EINVAL;
-- 
2.39.0

