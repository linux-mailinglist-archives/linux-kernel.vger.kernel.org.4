Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250563890A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKYLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKYLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:47:51 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805712094
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhA9n2Hxj7ZXGyhx5VubZHuNyyrrU0dpmRHTYi8Ohc44nDYFmbfh4z2mvCA0o8pFuqY1tnzw8YDhzzoUNMT+ZXrubzl3Tj+1x6hLYVFtejTMhtUZumBbYIbJFM3CPIVj2hLJmBLK3QaExdyCXJ1wH4kaHdAlDd/JLdiAyES6NOKVAyAb9aPdMnQFvUXeyi50S52dogI/T28KUkdonNllUY0xwk2faNqRSUTNcrZwrXAGl8oMzabwLeVFTMwMgCwIGari9FVZsbiGNhiFzb/217vyuiQ4RetXTF0habuiZCGDdMnIgKkRRAcqA1njQCUz4eKZ2I6z90Q48rHq2E6sEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eiszt9hyXn7CsrRNh1OM+4nwZgju70TEK5klDj8wAGU=;
 b=myJjY0F/2o0tM7BfmlHD4UXr7hGHrlJwaiEuLdq2D5DynjyGSDh8d+5kNt4rDXomm32955PCcPAWc9N14V8N87/Omm/W2rdc4ElYmh/HUYwbj7SQ1Jl67Rg+MScQpbS5jGbPc+IJP4wtDliEOL8JncafbCjsu37DZdoqYiMNlu6yjDtpIdz7bqWLmEcVvgZsBvQ8Jm7o2rTv3WVxPkduFVcIyxnx3D5/EsovZXxfpl6caNkD/4BmCcSOAM8zeaj41fhK9fL6HSs/+MH/+TFfbidc022ZNuI64FXN0bsOB3DexgZQYAFlyQmwFwJmH13KxpjYahDaE02w9R7yLn6Y5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eiszt9hyXn7CsrRNh1OM+4nwZgju70TEK5klDj8wAGU=;
 b=oNg1Zt9vFlSpNt82w/pTFqnP+73Yot+AkFh6rbLD7KgEgCMkhYDcVOV31g3ihyax5dOxfY4W5S0Zx+q7sX0rT69AZc67XQvfNii/cNh52ieQJhV1cMkK0Q0Z/4vwaw0ZavruEkZphXRg9d6QUOkvnBzlOmdtfGvK7wU32GsRGGeRAo0SFESFc9zi2LbbVZBcGI/Mp1eNPG2wGHCsutVKWbq03lKP1kOao9GE7xCc8Nn2MzNjPkafXERctpOrqzZBNtsTy8A9mV6HYFW1yhVwgGW2kimeuA970lP8DHaB37O5fxozzbcmQSA5WBFvalJ5af+cp4JCEp1JMO6DXx/oYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4249.apcprd06.prod.outlook.com (2603:1096:4:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 11:47:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%8]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 11:47:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: do some cleanup for f2fs module init
Date:   Fri, 25 Nov 2022 19:47:36 +0800
Message-Id: <20221125114736.19423-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dc13cd-2996-46e0-f157-08dacedade23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Lh7sBcPqNVK5dw3DL9882mZWh8zjhpfGyzDZD8utDvSBVjXpcZS3O1T0yxl+tUgVBLmjBXklDo4SfpTZUK8nqBDmZTB6utV7zu5xRz3ySp649ADO7bVe1YrEA2LkNGyC40r9sKYKLVGExbeV4AyTuE8fTcSjsPIa4KcF2SvvBOQh9CD+9eDnlgbclfsNPXxQaCt7FHVEkvPGBgBmliQ1hk4qgBRjCip1G+AdSsLMRox1DsyFKSjnVnK+pXYoILkQyn+Ii06jWqyYgZqomNS1CdaPsl3a7eI3rVUooCRALNznyqYL1UMhV+v0kw7ejY0/3f8D217LLudIUFIW+iFEw2gJXN/Ybr+hvoYIYX0q3Sv6K1/K3ahABZ/HjqtL5PARe07xT97BFhW0gvQrIRwxw0SmLcyG7zl4NlHKVqZxDzmyJk6yN+oBIMPxaOdynZb6UEasJqzzHlje83+E5JD9TzBPFgCIOudm694fm0nnS7junFNSp5OMPa399DX32NWbnG2+4hP3AmeNBbjze1Ot3umzF+K+kt/AEPqaZCDV+IMoxLd4FkzlRDVCnJ7nd0bkOGYoAG1WoxKEomtXoFgzQXPQFQd58lhkV1150a7vMbvL5wOg9jLjRiI/gcp0+NBKcnvTCtAIkDpYBwYJOM0SX/fh4brq0VidNDIskYxjdngoMFV3XuZzVaCaVj10h1F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(6506007)(6486002)(36756003)(6666004)(107886003)(41300700001)(186003)(8936002)(83380400001)(2906002)(5660300002)(2616005)(1076003)(66946007)(316002)(66556008)(66476007)(26005)(52116002)(6512007)(86362001)(8676002)(4326008)(478600001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvSi98p6QcWznvBxWIeNROUzfXU+3GkZxfbJpf/H2CRnf4LfjoTjA1vuI1Ah?=
 =?us-ascii?Q?N19R01nPhmea8V69KkO/CVX1bgOyM3vTV0tLoaviDS1HhOGCYWzqVblMOSWT?=
 =?us-ascii?Q?lO47ubHJKqAG3CqH7Uz0+UyCow6Cs1F5AgUh/STb6RI5+RGFQtbBZvhUTBKt?=
 =?us-ascii?Q?EKaDu26F+yzaYiImXhoiQL5b52ELcQbQdSCyJXrd+0HyCPdcworMRody9MeV?=
 =?us-ascii?Q?NWAzbaqQGAxX0aRv8D95Tq79eprEKVDEvno1e3tsg4GvDw6nAnbsAKqWLvNu?=
 =?us-ascii?Q?HabOGV0xMAJZefLWx23PWdgYAd5yPNd8g67kA6hnxMbN3TRdaei/XbKRGqtO?=
 =?us-ascii?Q?BM/zy8XE3Zo4UTbw4US967IkdyGcvQCiOnVCmYiIV9Q7QIKVYC/gseOFOe0g?=
 =?us-ascii?Q?uKDVAtXPiU+c6aX7U4Wmuoaiam0yIAiXCVIFZGKqC8uGg3WNBtjfr57ht473?=
 =?us-ascii?Q?3Goh0lJvDB/h5FEbpQY+1X5qjuyMDBEgqOrcqCdeogAvkibMTh/7nZyvG7gZ?=
 =?us-ascii?Q?yBejmowK/KCCAegPBVZwPIwKo14EqXhybSutSD08vAfYEmua8XPrwLRt7Yk0?=
 =?us-ascii?Q?wN1+GHlMb2YQ8kp11uf9wRioUljBV94pBnK4rkN4v/HSGSly1cUg6HsQDvyL?=
 =?us-ascii?Q?gzOPNZO7uc8kr9Hw2wfOTRWpSHetQkIemOBuUpoQhNaaFs9ZNNgnXX9Fl+0U?=
 =?us-ascii?Q?s2gu6r25PHxYc1xaimWZQ6MATK2EhGwZxr8D8e9w1bsbEgrblFKjNnK9FI8z?=
 =?us-ascii?Q?14oDNKolLy0o7X+AFzvUX5rRv1YvNR7IpssHPfQ0PJnroPeYGRsbe0spTch0?=
 =?us-ascii?Q?8XICuHikR+i07ztLLijEeMVbl/OJWa6n4vZb5h+MzzQer96P5WpOe1TLSiGL?=
 =?us-ascii?Q?Caq1Opr9+MpzrPoT5+Ls961OnAwIPSwd6Li4qOSjss58RRyOnfgB7EV+ruPy?=
 =?us-ascii?Q?WrHU1wwPUjriTzJdU99biHA11toodn+lBNI5KlZO96i+5/ot2jqAbBjVkls4?=
 =?us-ascii?Q?wjsbIcV7tg0K8GYYbwKjNy6skbCHpoEWvUXVgCZnEoNU/PDzIjHGQWlGUfRk?=
 =?us-ascii?Q?xKqxLkSUcfA6g/W5t6jN7mejkfCZaw0f0cLU+r6y4uv0lu2wUroUCjK227x7?=
 =?us-ascii?Q?ZAuqy8hrnvWx744gLz9mHgtmwGXULqAfHAbKWrVvCFgt8mIVTTXSh0/aHp5M?=
 =?us-ascii?Q?BnAJv54Qt3Lfxj9T+o9QCLYm/ArjfXUgjzfMcRhimDMnPhUu03iJjay8os1p?=
 =?us-ascii?Q?+lh93/jShpLseoTJv0qa26qSJP0dGFVrrgxbA3+CaIAWvBEHEW6IrZMsrsQA?=
 =?us-ascii?Q?6rslZC46Lwl6xQVNmKTVIUIJEB1K1JMTtTySkLTRFCoCk8DgLa0jq7rdvztj?=
 =?us-ascii?Q?3QdzK23agwaLQUAD1HE9VhZG2R8vpOJxbLa2SgdM32s3CYTF5dRkhFRWeUHr?=
 =?us-ascii?Q?oATAa8eCU8+EOFCqLI9KPPdZnd/M8QigVRIh6xXBZsla/wuQTtmVSBzN5gy9?=
 =?us-ascii?Q?JQLxlkvaUiKqdtvDhNS+ShavRyMk0wsPdwZofV56XOEPK27KjcRi/5g/4LlR?=
 =?us-ascii?Q?iEIMt5JE1Norjvba/Zh/LzMAnH5YwiTEkhXLhR4Q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dc13cd-2996-46e0-f157-08dacedade23
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 11:47:45.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4U3GmShtPM8AGdOLehLavoBqGJh//We8XvauGAVu5ag3+2rFnvE5M4uM7RmbDrkGS8MNwnegwWEQftGlSK1EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just for cleanup, no functional changes.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/compress.c | 46 ++++++----------------------------------------
 fs/f2fs/data.c     | 14 ++++----------
 fs/f2fs/gc.c       |  4 +---
 fs/f2fs/recovery.c |  4 +---
 fs/f2fs/super.c    |  8 ++------
 5 files changed, 14 insertions(+), 62 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d315c2de136f..f920ba8e0e85 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -567,10 +567,7 @@ MODULE_PARM_DESC(num_compress_pages,
 int f2fs_init_compress_mempool(void)
 {
 	compress_page_pool = mempool_create_page_pool(num_compress_pages, 0);
-	if (!compress_page_pool)
-		return -ENOMEM;
-
-	return 0;
+	return compress_page_pool ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_compress_mempool(void)
@@ -1983,9 +1980,7 @@ int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 
 	sbi->page_array_slab = f2fs_kmem_cache_create(slab_name,
 					sbi->page_array_slab_size);
-	if (!sbi->page_array_slab)
-		return -ENOMEM;
-	return 0;
+	return sbi->page_array_slab ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
@@ -1993,53 +1988,24 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi)
 	kmem_cache_destroy(sbi->page_array_slab);
 }
 
-static int __init f2fs_init_cic_cache(void)
+int __init f2fs_init_compress_cache(void)
 {
 	cic_entry_slab = f2fs_kmem_cache_create("f2fs_cic_entry",
 					sizeof(struct compress_io_ctx));
 	if (!cic_entry_slab)
 		return -ENOMEM;
-	return 0;
-}
-
-static void f2fs_destroy_cic_cache(void)
-{
-	kmem_cache_destroy(cic_entry_slab);
-}
-
-static int __init f2fs_init_dic_cache(void)
-{
 	dic_entry_slab = f2fs_kmem_cache_create("f2fs_dic_entry",
 					sizeof(struct decompress_io_ctx));
 	if (!dic_entry_slab)
-		return -ENOMEM;
-	return 0;
-}
-
-static void f2fs_destroy_dic_cache(void)
-{
-	kmem_cache_destroy(dic_entry_slab);
-}
-
-int __init f2fs_init_compress_cache(void)
-{
-	int err;
-
-	err = f2fs_init_cic_cache();
-	if (err)
-		goto out;
-	err = f2fs_init_dic_cache();
-	if (err)
 		goto free_cic;
 	return 0;
 free_cic:
-	f2fs_destroy_cic_cache();
-out:
+	kmem_cache_destroy(cic_entry_slab);
 	return -ENOMEM;
 }
 
 void f2fs_destroy_compress_cache(void)
 {
-	f2fs_destroy_dic_cache();
-	f2fs_destroy_cic_cache();
+	kmem_cache_destroy(dic_entry_slab);
+	kmem_cache_destroy(cic_entry_slab);
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 560fa80590e9..35c19248b1e2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -39,10 +39,8 @@ static struct bio_set f2fs_bioset;
 
 int __init f2fs_init_bioset(void)
 {
-	if (bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
-					0, BIOSET_NEED_BVECS))
-		return -ENOMEM;
-	return 0;
+	return bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
+					0, BIOSET_NEED_BVECS);
 }
 
 void f2fs_destroy_bioset(void)
@@ -4090,9 +4088,7 @@ int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi)
 	sbi->post_read_wq = alloc_workqueue("f2fs_post_read_wq",
 						 WQ_UNBOUND | WQ_HIGHPRI,
 						 num_online_cpus());
-	if (!sbi->post_read_wq)
-		return -ENOMEM;
-	return 0;
+	return sbi->post_read_wq ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi)
@@ -4105,9 +4101,7 @@ int __init f2fs_init_bio_entry_cache(void)
 {
 	bio_entry_slab = f2fs_kmem_cache_create("f2fs_bio_entry_slab",
 			sizeof(struct bio_entry));
-	if (!bio_entry_slab)
-		return -ENOMEM;
-	return 0;
+	return bio_entry_slab ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_bio_entry_cache(void)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0f967b1e98f2..4b0d2fa3a769 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1903,9 +1903,7 @@ int __init f2fs_create_garbage_collection_cache(void)
 {
 	victim_entry_slab = f2fs_kmem_cache_create("f2fs_victim_entry",
 					sizeof(struct victim_entry));
-	if (!victim_entry_slab)
-		return -ENOMEM;
-	return 0;
+	return victim_entry_slab ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_garbage_collection_cache(void)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index dea95b48b647..77fd453949b1 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -923,9 +923,7 @@ int __init f2fs_create_recovery_cache(void)
 {
 	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
 					sizeof(struct fsync_inode_entry));
-	if (!fsync_entry_slab)
-		return -ENOMEM;
-	return 0;
+	return fsync_entry_slab ? 0 : -ENOMEM;
 }
 
 void f2fs_destroy_recovery_cache(void)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31435c8645c8..1d56cba495a5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -288,9 +288,7 @@ static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
 							F2FS_NAME_LEN);
-	if (!f2fs_cf_name_slab)
-		return -ENOMEM;
-	return 0;
+	return f2fs_cf_name_slab ? 0 : -ENOMEM;
 }
 
 static void f2fs_destroy_casefold_cache(void)
@@ -4646,9 +4644,7 @@ static int __init init_inodecache(void)
 	f2fs_inode_cachep = kmem_cache_create("f2fs_inode_cache",
 			sizeof(struct f2fs_inode_info), 0,
 			SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT, NULL);
-	if (!f2fs_inode_cachep)
-		return -ENOMEM;
-	return 0;
+	return f2fs_inode_cachep ? 0 : -ENOMEM;
 }
 
 static void destroy_inodecache(void)
-- 
2.25.1

