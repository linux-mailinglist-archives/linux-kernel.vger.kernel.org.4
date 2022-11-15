Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CA62A23F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKOTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiKOTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:53:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DDC16584;
        Tue, 15 Nov 2022 11:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOwBIQM4t0rxEn9dguIhsgbbQpJqgXqe5JvvVd10p0V4sKDzevXTKxgrt9OnpwnVyDl6olDl2aubTfNQuv/H9B353YC8+OHQ002GW2fn/38z3AylUPOFTykDT8oDBIizFlv1ALPGjDTn5vAYAOftRODuINBAzyCXBF/SOkBB1ZjQCIYBze+1Nu7ndmbVI8U9uKoSnw7YRTeJRDQZhzsmmCp1W1HJoO09dfYL2riiu8keXxK/q53av3poVS8Fy+Qxj6VrsvdyHcABxgsf+rmyFID6xKO4SdzxIWlQ4lQOnG5gKEB+J1EXCgFBgRxbq9DH5y8T1VnNag8PfwftLIZ3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=dS37lmTSgvM6IRaI/QtncR09MCjiZjpeD33VZgRRZBZy/x4t+W2rUf4Gc5003ezNPp0y458MEuXVAIrqC5XEQtwcaBrxBm8+iZ7uA1eCKcltS5+uoLk/qQywcANqY9+CIhtG+uX67Hr5QACfscNEHd8QRdpJE7r44/C516LjRaLUOddHIDdLfSfXnFc1/EWudsO0zrvvvTjhhSCWXjzkX+lIIN2bbAZxxRelGvEDhFpJdBNkRRZssSrgmkXd+unSuJCNY65sKp+isxj0kUW/ldDR+79v/BPKGU4JKJ+eTQyFkfGjvx5fg7CR4/OUtfbTOsUAH8rrhzqd2/+VhJIu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=eEIuYbZGLuURw1VFQil5yx0Is50ULLS7XmSVyLdCe75YxAsc+jr5/DhQ18NdN9ITeGzlD5Q/bl3tjY/kMFFhw3pUbfHzIKEZJFtMfSvT0aBvM/DF9Nj5FGuK5jmCTgcB+PPmJhDXK2uA1PmziHw+ZvuZ6BKehNzh5sVmHiRqQN5mQSy9BRrn3ap2u0vCsStPuaQOAYbyL35q63Bxlano2aqMS5qShPUHidhzmjRyIRkxNY8f4fgZc3Mti+nSieBMbw7HRwmcp7TiAOJPKA330x/VavHlJDpE69YIDLnu5LDoJkl0Xm+k/0s7P8HC9qdvzlr8hPT2IkN30p/JKxM1mQ==
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:53:35 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ff) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:53:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:23 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:22 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 2/7] null_blk: code cleaup
Date:   Tue, 15 Nov 2022 11:52:48 -0800
Message-ID: <20221115195253.182484-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221115195253.182484-1-kch@nvidia.com>
References: <20221115195253.182484-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b16eb19-ea5f-4131-8e1c-08dac7431508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LBOvw6EYvFXVHLz3yKV4LnycvIDVJ5y9W5/gUDkimGq7jcxwzI1AgtEJi7IVzLre2kf5aJ+xw9DXgXQ29K7tm6s21RCGWXHhEFs8PNUElwhZpE3ZD5/wB3yHkY5CQ7vka6Z9VbXk9uLkgR0acV1nR5Qq+AzgffnCxYSoZlEyLoFQwHHcBscfqM2qAtxIg8dtFxRo0ODmfh3tkYvDfG3AQRg25o9q+i5TMcvDR7CwEUUBkiSEGPNLnc3Bk4Bx9aGuXp0Gz5xSbSAeq/gqBtMNRxAS9vE58f5BUwMF3FSpVq5aarBTfpcJ/yaFQj/WZmgUR5eLPTF6IaGjMU1F+A0YHHoOGHGxZc+KGoK8mV/vVqINff0575WFsixMIYjddcwjqbXA9ftK4igIImYBfjJ/zbkKlIr5pfwxFtmtOwuqaP1Tg2I2ePApQJrkzkYX3z/z62A4dq3ft5JqpR253tNS9/0SNhbENjs9W5UWuX40+FpIAlLhyKsra8JDxTkbVPxuMTlFs+i1lqhSMvb7PfqTQ71J9o6i4v/IBYdSHRbAXTX2lE3kbv/Qy+57sSckVSAmgCQSsOL9zYlpnY+e1lHF5se7c59MkFfq6MsRNUDH2phOFEYMf3J8hGNsAZxj1w77MYdh945XE0SjB3kP6G7/nJzGa9kO8PPqpKXw6txX/dJ63o0JZh+BzH6JIFb0SBjaS5A9UntNiOWWoTRQvOmOH2+Xnmtk6nIiDREKkygfiVNeQ5xUpQKQP/RyPr5q4M/Zvd5ARVy+onxBk/IbLRFgfLt28BVtSGS3MfHy7n5zLjgxEh5R7zWprh59hoYe5gi
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(54906003)(7416002)(8936002)(5660300002)(70206006)(8676002)(41300700001)(70586007)(4326008)(316002)(40480700001)(110136005)(36860700001)(478600001)(36756003)(6666004)(7696005)(26005)(356005)(16526019)(2616005)(2906002)(426003)(1076003)(7636003)(186003)(336012)(82310400005)(83380400001)(82740400003)(47076005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:53:35.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b16eb19-ea5f-4131-8e1c-08dac7431508
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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

