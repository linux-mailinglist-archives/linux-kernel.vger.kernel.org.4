Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD45E72B59E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjFLDCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjFLDB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:01:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6371FE47
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi8ouJTf2MQiqXpofTRTTLVLVXGl5wPQfflWzYzIRha8o9e6xTT3D4fiq/KezJZYVXYA7yXUt3TZBTP+PF2ma+oaUQ4IMe+LndnJa/pRI2Etk6aR0vnl0keeglGejvYDxMLzKQ/V0Egt6N8hTvYe3kjOmgGqnBmR/KJo+x8fGQti0Gp8RpyX/ZWFX7g+D7S+9t+iK3hkOEhOQNYCpvRTWgsmwl3nyZYW0sIkTWYulzrGRhaKEM2+wMKkDkxBK1NIk7gGRLtwlFbKCdnuVB/BwLFEhYaj2WLNLbuvaaPHPOAY6MjtqrRFyi78kZpdhqiv3I9otQrvZc3lGY/xdlc12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG92vvId03jcIqR+clv2OcovvvNDrykZIFGmMQSR81A=;
 b=TOX9WPIE6RsL/kiJJV6Y8kqrmQ7mqepThM+3IfaTmOfrZsmDfqUA1o2gqQYIzeXUQS38sjYX3Rl6fxEgoO8o1U3ZfngrH49WyREmmA0XU/FHV4t5OHYZTiB63+iTXG3PSQZCyNo6+2SkN+xfUVQuYnKD1JFRKcY/RMJ8sOQogEzu+BO03gC2RbCEVQFApY7EGmPfDIZ9ZsTxAbZppStifl9YyuAEYvj9wmJZQzsiSiaUVQNW6Vz/soPwtjjG560o0gwVaYJna9oz6OTH/ATXlvywvOqMqcfubnrZONCZRYbkQsplDc42Lo6VaLt0X+vcwQJv8fz7K71q+JQDBvkX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG92vvId03jcIqR+clv2OcovvvNDrykZIFGmMQSR81A=;
 b=BVe3vZ4VN3WYpIMIpoupjVwHcyWuye7e6lYu5JxaboFWs6sKcJs0IwM57oPncXYdclQzQ9vXN7tNz/blVB05ZDR2YIekwqZmG785oAyGTg3VVGAbgxu2ayNFoBV3WMtnu1YRQbo9dv87GOl9WLwc1/bdiERAAO1L40GLVuleeIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 KL1PR02MB6259.apcprd02.prod.outlook.com (2603:1096:820:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21; Mon, 12 Jun 2023 03:01:47 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%6]) with mapi id 15.20.6500.020; Mon, 12 Jun 2023
 03:01:47 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v4 4/6] f2fs: add f2fs_ioc_get_compress_blocks
Date:   Mon, 12 Jun 2023 11:01:19 +0800
Message-Id: <20230612030121.2393541-5-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612030121.2393541-1-shengyong@oppo.com>
References: <20230612030121.2393541-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|KL1PR02MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0beee5-9e97-4c5c-f3ce-08db6af15c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1FR4hsGilKeqS8eUBauInsZCQyAPOUBukCX/sbthAhl3783utJaPBV7B7g7Yxs0VxkkXMaL5C0GhCegy3ZsD4LNv7zD6gTAA6DjlrqN9Cd4q/euUG2ALq5XBqIGenC/PGT57zCYSBcAx3SMmNP9D4V0sUTZTHp2SCzHeoXUiKBrEQw6UFj//LcwWcNHAjrG49zS1j0ptsVmw1BLWg9AZzV9eabbkKBTyQmoKM0hvNGxdN7qEgWQ/K9P+dNWoJNg7m2ZqqOAnJQ7EQojdM9sww+mrSy9/Izte+WPQWl5rsM/8kcPDawZALPgYdS0xNfCIMVMSRPR7nfLMBZd4XP9GdM833cH8n4cbKi8JoLCu5PjzDRTISfgAqpb/B/pwWuMKuUeUeY5A1F7HEfPY5dSr96nuZeAGGRYg+OWS2zVl1f3AZzVas4VVvcXtAi/LD40bIqNdWf1YD1BmnOeRvcXBiQejS9sbiSmpjnIYhm3D16pzsK4+LzUGce5t928+N5I6wMEBVey3Pnl7l1CGo/fPUolYH+CWaGKK0mQt3yX4cwdexG+XB/AFBu7ED4GL5jyrK70TPVs3MwB8SME8R2J7pFeVT9e08HfpzJU39IcYgkzqdV3FM9dVGZi+SwFFBSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66476007)(66556008)(8936002)(5660300002)(8676002)(36756003)(66946007)(4326008)(478600001)(6666004)(41300700001)(52116002)(6486002)(316002)(38100700002)(38350700002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(107886003)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGaSLtmoQwSpPOwmZZIAp2yQGBQcbybmbdbb1x30Z10K6RgEokG/ngB/r60c?=
 =?us-ascii?Q?2orGuBQjQAPWZGl3/9FM2wSnxq2676x+k2meMnvAgEaMbR/v3KkvyDOE3llm?=
 =?us-ascii?Q?AMrYbZvADcID9rvcUVZDGCishDtlm/1SNNFvvuLNQNtUIhowRXXzgZgtmPMu?=
 =?us-ascii?Q?QzjBsHeSBu7PP/t3e6XNQ2NPwHwwYepsCS9OJrj7qoEgxT2Xyw7ud89N0a3O?=
 =?us-ascii?Q?2I9frcYPXrw928kX+gjkn+YrTxjWmP7LWFpX4gtDKjy2Z7S8Af2+219USGaS?=
 =?us-ascii?Q?JSQ5FYoGlPOHz7pUL8812VlcKJgnJ6uENEutUrXuZCAaJdCluZRGI3QnzyrL?=
 =?us-ascii?Q?UcXbKiktqGnwoss5ZlWS+D56vWxkB4SnE7ml7+e/36qSJsNtcHL1TL8oUVuE?=
 =?us-ascii?Q?5CewzPyjpS6ArNbjppLXyLLEh1DKhdK2dzpuXhLh2TRfg7RGctXMUNqiUGy3?=
 =?us-ascii?Q?XARHKAPIk5XTg5zMuPI0WrGFSO9wIrCZN3bSDSc/GehvSEppSWZCpkPr+mDR?=
 =?us-ascii?Q?9IYQsQT9TlZYSi37Pc3n5DnJ0xtAN9K71loQKOG+NkynFT6MAT2eX83EiYnJ?=
 =?us-ascii?Q?+NQEkz9qv5fmgvGnFCfHuyre3GywhuUO7JDdQyWOHCk/r2LL7FE05toT7crS?=
 =?us-ascii?Q?abjURmBaP+RXlaJigbrSn8x7Z4fhlqHTErMgFwcl1g+EUrgfFsP+H/iQw8SZ?=
 =?us-ascii?Q?hPBOXgoS/vtfoDFLEJWFPXZ34gH+yQ6h7RErNzEApXX7h+lJOeiiDODqXNAc?=
 =?us-ascii?Q?zfhzzav0/z0tMCTc9QDYGNwE8mMwNEeTuKrGCCfbS3nl7lLAoTJuvbL+vGI4?=
 =?us-ascii?Q?WPkMT9m5tUKgXm3nXN3PfFdVUbzkgWsf/I6g4pD1RqCKz3mxHDkNMnQSrtU3?=
 =?us-ascii?Q?/9RSI1NlixKU777Idjtl0yAIDFosrEy1afJmAIeA4lSDRp1ZL8d2t8k7TT1u?=
 =?us-ascii?Q?E2NVv+VnDyq9Ll4Y0YKJ2tVzxgppnIeSvZaNUOR6sJ5813eDb5GFX4qxvVUc?=
 =?us-ascii?Q?2cp2paqq8+jbeX7OYiQ3hYtZ3SLV5ir9eh8pBZOTuROIuJrers5ZQHAcsOAT?=
 =?us-ascii?Q?aAYPygBgiDj3aox45g9SvRSgRqSaYDSjTGEycsgNdmYpHXL5ady4Qb+nG8uH?=
 =?us-ascii?Q?Q//sS7dRcrRiUfkL8nSBN9bcvs4lsu5toeudzBGL1JMSaX/1wRcqM0F4V9Dj?=
 =?us-ascii?Q?0bjRxG9w8fsiQYZ36zZp3B4Tqf3wbhiAW8P0K7XBfdux3BTvAbA+5I/mk4GT?=
 =?us-ascii?Q?qM/gPb7BGGPav+4aQQD0hbRgbgEVYXJmvbAWCEldR2/9KxwK3E7tDx+Zr1i6?=
 =?us-ascii?Q?if1/C+lSmgVsx8dB24obEXsNFp60Oz7CCsv8/ftfmR+tFtDwrrDjGz74lcy6?=
 =?us-ascii?Q?OTDJHOPlk5OOjY3hDH3NQVlKCUYdscwVrF0ZZjjPRzz3+sqnKypLsUBSOhbx?=
 =?us-ascii?Q?2TiStN1r9WZGryvcq0axKDOL8zWm+9ZynhCHDIX55t+yIk+1ivdEZ7vpO8uV?=
 =?us-ascii?Q?qE06wnTrGTiOmqB+MySr8w9cMyTYg9SfWeqWB6q/4kkQBoto+QNKoOIHdkEh?=
 =?us-ascii?Q?anltCA1O2OrV/25S7oQyT4w/x9O7kucb3FGCTOAn?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0beee5-9e97-4c5c-f3ce-08db6af15c9d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:01:47.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3Ta3GdLTDfWVSK7YexMSkibW90bqrc4XfgUJPKI1gpMltrhVMxjl1M7zld3gPkkL2MGG+3rfS0B28+5LytBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds f2fs_ioc_get_compress_blocks() to provide a common
f2fs_get_compress_blocks().

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/file.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 23c68ee946e58..f8aa842b5d233 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3376,18 +3376,29 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
 	return err;
 }
 
-static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
+static int f2fs_get_compress_blocks(struct inode *inode, __u64 *blocks)
 {
-	struct inode *inode = file_inode(filp);
-	__u64 blocks;
-
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
 
 	if (!f2fs_compressed_file(inode))
 		return -EINVAL;
 
-	blocks = atomic_read(&F2FS_I(inode)->i_compr_blocks);
+	*blocks = atomic_read(&F2FS_I(inode)->i_compr_blocks);
+
+	return 0;
+}
+
+static int f2fs_ioc_get_compress_blocks(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	__u64 blocks;
+	int ret;
+
+	ret = f2fs_get_compress_blocks(inode, &blocks);
+	if (ret < 0)
+		return ret;
+
 	return put_user(blocks, (u64 __user *)arg);
 }
 
@@ -4239,7 +4250,7 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case FS_IOC_SETFSLABEL:
 		return f2fs_ioc_setfslabel(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
-		return f2fs_get_compress_blocks(filp, arg);
+		return f2fs_ioc_get_compress_blocks(filp, arg);
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
-- 
2.40.1

