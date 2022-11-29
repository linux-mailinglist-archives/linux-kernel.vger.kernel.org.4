Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9863CBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiK2X3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK2X3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:29:08 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D0E71194;
        Tue, 29 Nov 2022 15:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLNun627wrPKgUSxmnVojrt7G5p0JXW+9xp0s3HFLpLfP7Fbv7bx8pgLI5uA6YV0fwmhhbTfTNVYDWSCjWEPnYdi5LBhKCD89wZy6LCQPuPravWOU63TroLc5UgKdsLlXuDyFemwT3Jdv8n2FDVT+DeuoO9JWa7knUxcfqLu9jM2UvePVxyDQIro/wUqORBW0Ubbf7Mvp7kEv/JmZu80CutWd1uCeAkJ1IDNsEtQOKCOzVMJyYubd8fX41rncWBSycfvVCITsZN5xFmIN05vQrkQtnW3FcMFSVwB5FZumAYo3mLQ+GgK97b1WXY2Te3YuiygzwVAEvXt28vdMrQKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=DgypgLjXVohC1f1E0wJlXYg3O5XfklVy5CnpgKBRVenWLDT3jkD8jtxQ3Y665qiDAXHJcOg18v4N8jWgeQIi3pLtKZ2NsdDwbs7ZA3KvZUYYlroCLyFPpGyD1hZyyLP4Hu5bgV7MB6WinAwksBIyfRjbE0Yy1QencG03PsH4UI0Pj2z0nt7H6+qxMT8jfjlPUhgUZOcgJ/p/jP9nY1n8MbKEJe7nlDI9Xz39L3GjN2VRmvzRBQ/R404qAgYvVqB+E+tP0YrR5OLSFlHMMYnS0QYD+uqG2IqmkF4zbUjB8apT3rK/EkjXZQhShR4vMgUgCgKW23JHTiDmhsBeMVMHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=fFJAVBbx47knC/f83OuAp9YrmxDbv2JZF4gJWWAeh3kkxUN7SXjY29kHPkxxGuIQ2JrNiKMV1Ojrw1FDmIXCOTCgpEM7c7Uj+hIv9FBky5oR7UeEfOaJUKm25JU7Zs8dHPHK0wwgv32C6DHXTk5i4GOX/2K2IguQSkf3x6cs885LuNDXzSNisLVzfmvKkQ6ETJapYh45oo7SLceK4iEQYN+XQxfD9V3mvIoxyh7PVMIOSZ0O3Ks2ZrK7/btwgWbGYcGos9/jqCajJIWbKS/FYgbqWXRJZTEj3gE+PGxHKfli1KQWe6w9Q93orgSVewcetBHSfAzrjt2OuQO1rZ2A8g==
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:28:55 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::f3) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Tue, 29 Nov 2022 23:28:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:45 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:44 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 2/8] null_blk: code cleaup
Date:   Tue, 29 Nov 2022 15:28:07 -0800
Message-ID: <20221129232813.37968-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221129232813.37968-1-kch@nvidia.com>
References: <20221129232813.37968-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: ce26b894-e317-4ee0-49f2-08dad2617bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NriU3H0N5asmSq6q3UXFWtHOtqADJknRZGG65NNln1yCnaqcD3wkMIzdJyBW9m+umdpuMLcNT7KG4+BEmz/NDglJ46RwRnYKexB2orvGF+oMsXJf5KEEURSiBj82yqc6aiy8A4hpWhUSDcGyx/ur+HSZz1owa/DjfO+87XzKwpMmEftHFvoIjqnIMXG/83ymSqpxEO92ueqPAeO6DXmeM+y5eKt8ABfolQ7YGLvD8oBr81lb9sQIO8IMiQs2yH837WytTxziXrEF7FLgLWi5d+vouuQwpQ0yO/WffwjO25mr5UlQZ0Cd0C0AECae0oNI7jylp0mEHAGqkoIpuhd2BI75CaGjaEZ3xI3/w7LM5JfQU6DdKZv+k6elowDjGrKzesLJGxe6mHKRgZbQlMTDTtRfAEtC6v5kD751V8rguLpFnhYV4mP8rlUum1/3urUjjYBoxF719j+X2Qj/0n4DrhVHQ9fkZXVym9pcjxCNiS2wQKUNd33VYyeMkBxlMgJID/Mr9T+L6SF+aIyViiLrVGwDi0TYvNcsOxiosFplIFKBbLaHztCv8ULS9PVEdVxfbsBUHrH+74RPFTjXXpOhU+Kfgo6kvx8D/FKaUW444xoLP/ujf3pdVecLyB1hKumLrf1NJjWauArCka3Ll9HscSFqmGA1oRsGUnq5CvPHrabdTKp9nBXH5xJvh6Ze5YAtSQ0A7Hlw4yCawBNb6txfFw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(7636003)(186003)(356005)(4326008)(107886003)(26005)(8676002)(70206006)(1076003)(8936002)(41300700001)(2616005)(478600001)(70586007)(336012)(40460700003)(6666004)(7696005)(5660300002)(316002)(110136005)(36860700001)(82740400003)(426003)(2906002)(47076005)(83380400001)(16526019)(54906003)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:28:55.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26b894-e317-4ee0-49f2-08dad2617bac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce and use two new macros for calculating the page index from
given sector and index (offset) of the sector in the page.
The newly added macros makes code easy to read with meaningful name and
explanation comments attached to it.

While at it adjust the code in the null_free_sector() to return early
to get rid of the extra identation.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 37 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2d592b4eb815..fa47fab279c3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -14,6 +14,11 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
+/* Gives page index for which this sector belongs to. */
+#define PAGE_IDX_FROM_SECT(sect)	(sect >> PAGE_SECTORS_SHIFT)
+/* Gives index (offset) of the sector within page. */
+#define SECT_OFFSET_IN_PAGE(sect)		((sect & SECTOR_MASK) << SECTOR_SHIFT)
+
 #define FREE_BATCH		16
 
 #define TICKS_PER_SEC		50ULL
@@ -860,20 +865,20 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	struct radix_tree_root *root;
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = PAGE_IDX_FROM_SECT(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	t_page = radix_tree_lookup(root, idx);
-	if (t_page) {
-		__clear_bit(sector_bit, t_page->bitmap);
-
-		if (null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(root, idx, t_page);
-			WARN_ON(ret != t_page);
-			null_free_page(ret);
-			if (is_cache)
-				nullb->dev->curr_cache -= PAGE_SIZE;
-		}
+	if (!t_page)
+		return;
+	__clear_bit(sector_bit, t_page->bitmap);
+
+	if (null_page_empty(t_page)) {
+		ret = radix_tree_delete_item(root, idx, t_page);
+		WARN_ON(ret != t_page);
+		null_free_page(ret);
+		if (is_cache)
+			nullb->dev->curr_cache -= PAGE_SIZE;
 	}
 }
 
@@ -885,11 +890,11 @@ static void null_zero_sector(struct nullb_device *d, sector_t sect,
 	unsigned int offset;
 	void *dest;
 
-	t_page = radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
+	t_page = radix_tree_lookup(root, PAGE_IDX_FROM_SECT(sect));
 	if (!t_page)
 		return;
 
-	offset = (sect & SECTOR_MASK) << SECTOR_SHIFT;
+	offset = SECT_OFFSET_IN_PAGE(sect);
 	dest = kmap_atomic(t_page->page);
 	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
 	kunmap_atomic(dest);
@@ -949,7 +954,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	struct nullb_page *t_page;
 	struct radix_tree_root *root;
 
-	idx = sector >> PAGE_SECTORS_SHIFT;
+	idx = PAGE_IDX_FROM_SECT(sector);
 	sector_bit = (sector & SECTOR_MASK);
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
@@ -1125,7 +1130,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		if (null_cache_active(nullb) && !is_fua)
 			null_make_cache_space(nullb, PAGE_SIZE);
 
-		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset = SECT_OFFSET_IN_PAGE(sector);
 		t_page = null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
@@ -1159,7 +1164,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
 
-		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset = SECT_OFFSET_IN_PAGE(sector);
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-- 
2.29.0

