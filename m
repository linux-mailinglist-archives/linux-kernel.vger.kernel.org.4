Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9753658D10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL2NTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiL2NSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:18:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179510055
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLJFhQowTU00zPrX6I4E7X7Ls0saa2FtP4rOdmn6pu3UCUC8dMgA+W2Gkakq4+ABASkd655Airnib/Z479bh/SAPn7Y+DonNsIh25lzlvkvcOieCCYqNk99VT7mQMoBfgg8jMJvsAq5AaJVgNKqxWPuelV5JrPAdShWtsk6bcWXrNrvlwbHIHCPBwVHZ3ndTAS1BGVyjUi5TIocRgN/j5hikpClebAMEaJ7FDQ5zkpQMzxDG9JGmTEfwo0kRsgS7xCHpvBV65vbON03VWn2cORofmPWy2Y+867CXaz5mb2FF7VJ0kMYcXzgn4xXdSTqDGOJ6F9qDg4To8rgVUum4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLHFAf1XttxSt9ghXD68pSsg+bCXzuLXkWO0voWGoMY=;
 b=F/ZVquJm5yKEO8vyMUZFI4ilhgOGsj3b7y7JMgsH9wLx50QTYnLVeLOjfNKOmOWlGpPcB47t4TbsH+d/ZoggBPdA9X0kiLJ5BjZCkhd2QvmBnuejNAqXnhEM0pQl5txEM5xnKt0jvsljtT3fXArq5jevOV2az9xrRA82kRu3WVdYjTwkBLqCZGUZTWLfjiVUwegLM16Zs2FBXIh4FmqP6hvMeuN1tcpSobFti8fgxgCgJfWxSp+/zgWWezB13ZzFrN8k7CmPerCd6j2c7rf4XFtCF5XRqnNlzvFon1wHoSzXdOuOGrzEhqoO3toi1hGUyKkzTjtgXyFPM9LFVj6AQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLHFAf1XttxSt9ghXD68pSsg+bCXzuLXkWO0voWGoMY=;
 b=gBGfC89u4qFX1lzfgFpZqCPZBCcwplhDKjsmWlRVE/MxL2gpBR1aThc8myYXLYVyRq0fEPiAdztPRtAJ/CKS7eMm/1OdHIG7vcFNCJYmOZrbwZIoyKupG0qg6j72Cf57It8iNipPNjI/oNyp1CbKv4tou6wkUS4n0lkVwwsSITMEXz8wSyxORKGAl7r0lv9PwVv2SmWSu4JoFttYIGqm16Km+ES6xBwO33XPv1NjJ6MPJHIpyUgWwM7ZHj7DrjtLCm1pyU/tS/lz3PqhYDWBBzijzxuxn/ixaOiQrXdgWas38PrO4j70BiaaynSLszccjwmv6C/C2e2NtcmDRShAkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3904.apcprd06.prod.outlook.com (2603:1096:400:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 13:18:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80%5]) with mapi id 15.20.5944.018; Thu, 29 Dec 2022
 13:18:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: mark f2fs_init_compress_mempool w/ __init
Date:   Thu, 29 Dec 2022 21:18:28 +0800
Message-Id: <20221229131828.59116-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3904:EE_
X-MS-Office365-Filtering-Correlation-Id: abd11bd2-8955-435d-a88a-08dae99f3256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYOSCOSbkioYauzwW/R0igx4oQ6luQiMyOeB3omJ5Z1swlr6hFbQvZLyXIie4dKie/jESoweuqqXQ2taOErPiCPGA4rqqOVzsE0E8F/c/cMlSrKYkryp6FKs9V+rADC62FMmtfLRLdcFkAUWa4OU3Yd2xaRZxolvqqnv0TfKsDksZjtwU6RaFQvYAf55qyOnqjBeGNhfLQ19WVA9gZt+4gqpMdtUw6OAPCMNcC2kCZGUS4La50G647bszNUgzZWZrILE4qGYvGaGjicgbk70mAhTrJjnJNs6PoD0G5Zx5keSTX41BKZOIU+gFfw1xNZE/WN3KOuphYaLZVfJK91ksEnpxw1yufbxMRYd16zggP5siS0F+HMGJiJyKlUTbJNBn6kLTo9hEOc6uog+h9YJpFppSTIGMBibogle3jhvVaw4EuddLPJwiXVaFgF6j7VqeLUKBiW+ih5ATR1HbarlsYdN4h4G/+WJ5BobcTyHy/au5BLNwJRvXI8KpnYp7gfS68mnySlK5WjNiRAJZ73MfLcsUo5jlz4Az1PU/ozEje2wiUOtN5sX+i8V/b7FseTVAt6uc5peiOOKZUVkQkrFjCmZ483dDt/9Poo8UHrHi0N4L+I0yCK1vyZeaOQSu99+LDFt8lg6cf/9RVImJAg+OEivBGhjw56S02NBxfM0fu05aJ5PJ3vkqOctVI/tYhbM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(451199015)(66946007)(66556008)(66476007)(5660300002)(8936002)(8676002)(41300700001)(52116002)(36756003)(6486002)(478600001)(4326008)(107886003)(316002)(6666004)(2906002)(6512007)(6506007)(1076003)(2616005)(26005)(186003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txvsJ/k7NK5hvDt1ml17BVw+AGpY0A7Lrc1ffsyLLFrsUuckecFYJP49cJN7?=
 =?us-ascii?Q?Hf2NIRG8rh580X4f0L5XEeEqCh+RN/QlS33jEYGAiUlVDm7s7NtMDkInn8ff?=
 =?us-ascii?Q?923ftQIPaXn4RaODxtte7b7amkfmB0QadNi84RJwHUh2hcN7kG5AEgJVXYxp?=
 =?us-ascii?Q?XRq0pfrjfmr/nUEl+CAALPKKqu7jpZcSP8Fmg43T1Qhb1aAH9uPcNWnxjdsT?=
 =?us-ascii?Q?WD1XUjA4E6guDqgXoCAahJj4TBtM3Rr9ZhBtrJ7kHXUexZ0JIDYa4JtQ8pma?=
 =?us-ascii?Q?LwIpS/QT0yWAaZ28312CAw+3Wuju0n5TYAiRZF8uHNdjJ0kwoxsX35mKAau9?=
 =?us-ascii?Q?PPSNRNqN4LPX5wYOKcWwRpU2icrJYkppJxAad8m+XjpzRdfOiJEwMV0e2bN5?=
 =?us-ascii?Q?GLfhbAfn4hytS7gGynBPAue8zI10wLfB/p0/JWdXebSN39K7hSb6JUi2jOWL?=
 =?us-ascii?Q?qMPXnT5y1fafXVooG3nMcd7fKSwVBOOseRnXzz/Kcy58x+QazfYAQ1awApQJ?=
 =?us-ascii?Q?Rke2CZsC2Hzgtt0IOEZ+aXFd/luAPXcrAmkAx1IG/lamawiIS150WtqO2SvF?=
 =?us-ascii?Q?GR3L6k5bCcVhcD6R9Ui16IMm5+P9HbrLd4fnxeK/9t9kCtxH7G/lsGf8epAb?=
 =?us-ascii?Q?1y4eulONAfgo5G492sNnGrcuxOXCim548nluTlvd+ijd/lhIc0JHdgguEZjE?=
 =?us-ascii?Q?eN4OvFGIhYVhjmw2RSQtZtm9UXjOJz28omYlLNEmuvaOH3koTei6Vnh/9x72?=
 =?us-ascii?Q?5tOmZMQpMq6mYmBh3gIAHtfkM8E9qj06hfUF1UeEE1mx/TUjb4KBlGfuJk6h?=
 =?us-ascii?Q?MFFuCeR2GisD0SXBqtK1aBS149W6C9SshiWb6yGVZT6IWczjaDDsAI+JZAbk?=
 =?us-ascii?Q?94vAyiOc+frljD2vZZQox8l/ImAxJyY/A3kLYj+v/jApq5bHgrE+BOXlDmlo?=
 =?us-ascii?Q?o0cS1fgVD2+wRBj7nkknkAsD+QadUEdO/mgEm2+DA5QIm7nfuULhpvaFHBIS?=
 =?us-ascii?Q?AtE1hUkXxRljYG1L8J17DKw73CuOYsYTXd5FEmCSm4GqWbK2mN+PtQ3to0rC?=
 =?us-ascii?Q?u0KxmfjKlGmPHQeJZCHMvZhqeMs3qXkh6AaTyTk+xUMsGriIg40+VEx+/dch?=
 =?us-ascii?Q?G0NrAPWK2Wln+zk6Y9ZEN6d4vw/0e4tVUIbnSws9+YKnMzThutSRf7NOqtrv?=
 =?us-ascii?Q?G0MrLCmvwVYOm73dTjyXn1sTczDv00mhcHLL59IS45WPA9WgzjVfmXCYC8ym?=
 =?us-ascii?Q?GN7/hGRlNF9IV1OTTF5Suc5CbCRemjYuI5b8+pYFTnQ8dxIiGEVA94QrEBwi?=
 =?us-ascii?Q?0cS5v0pMY7uuSQksSEzwyozTapKb4Xhh5iNaAl48xEe16GTQdawKF/YNLpPa?=
 =?us-ascii?Q?XM7uu4rFmQbqZojOvD+GUvXHuf8gPtb7aFkwgKDmWpkQy2GpnuNdPTTMUx3b?=
 =?us-ascii?Q?vfte1dk4qWx1rOcl31boOLSmm7rTjq4Cqeby1tCxLv1nwN1sYD93nTsOMpui?=
 =?us-ascii?Q?PSloxT3y68mTA/i/qNBvpgghtKVzHKuV9ij3G6DG3lFNdVg/PINxBUdFBZy7?=
 =?us-ascii?Q?pugZFXzcltnjWDHpHnFyso22VClHXtvcOxkXczwx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd11bd2-8955-435d-a88a-08dae99f3256
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 13:18:38.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPko4YJEak2E72dm7bml0UB2HQi87/nsf6pDEpzvUCLcUZ9HZ0u+mxLy0Hs26KGjYUiYv4wHOdJedOw4FZRAww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_init_compress_mempool() only initializes the memory pool during
the f2fs module init phase. Let's mark it as __init like any other
function.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/f2fs.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2532f369cb10..c2cedff18827 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -564,7 +564,7 @@ module_param(num_compress_pages, uint, 0444);
 MODULE_PARM_DESC(num_compress_pages,
 		"Number of intermediate compress pages to preallocate");
 
-int f2fs_init_compress_mempool(void)
+int __init f2fs_init_compress_mempool(void)
 {
 	compress_page_pool = mempool_create_page_pool(num_compress_pages, 0);
 	return compress_page_pool ? 0 : -ENOMEM;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..7367b0521f77 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4259,7 +4259,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
-int f2fs_init_compress_mempool(void);
+int __init f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
 void f2fs_end_read_compressed_page(struct page *page, bool failed,
@@ -4328,7 +4328,7 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
 	WARN_ON_ONCE(1);
 	return ERR_PTR(-EINVAL);
 }
-static inline int f2fs_init_compress_mempool(void) { return 0; }
+static inline int __init f2fs_init_compress_mempool(void) { return 0; }
 static inline void f2fs_destroy_compress_mempool(void) { }
 static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic,
 				bool in_task) { }
-- 
2.25.1

