Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B95F4E12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJEDSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJEDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:17:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB4C71BE3;
        Tue,  4 Oct 2022 20:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk/KaTaDNrwFV6hFXvavWXrLJW3cxgpL3ZFsIfuBEKfQOAI2BsAdDLEgpZCN5AQQGIEUkiCsSe5MLILPj8ZNhzmpjnvFN1s68vAYMoG7y5Pe/dN7pFC9TJjSPafEDSUWVCHnCPIA8eb++eZlzquIX9u7sae47HWQF6mZtCK6p6O8Ybl8TrXuBkrqvTUS8kmK/ZyQkhfGF31PzjD1z7Ycx0/XsM7H2XInY9p3FBFjxWYj/VIWgprI+EUffB0/DYsKeUe+ZYr634u/jqD1dZEy0fQeAzX/wWdec0Nf8bxMdE2sMF6xhvgvz812n7swTIiojTcDNeJpdVqdb6rwYLxQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+4DuxWT/CpfWrrdm39C/ZtzTKY8JSdhQLNAfF7DIG4=;
 b=Pd2IlxF1rXTPzcnRlTb6tW1xvELFWepmPQuDh6AX3E9Tzz+lmr/v4CYRuyFBykslKjCC4Gda2z3xe3XVYeZvi6k/wdT3jD2RkKdUQJYVgFYOYeqAXUv7QBt3SJNDth6wqlJNWKGfh6ACJl8hhl1mGcpIMh/WU1ht30oiGuuvj/ygywTZPIDZkzntT5mFrSgQZfotHNgQ7Ie3QAiTbMYxxr/AhM08B2zZzWX4eanLEYJuXfZEAvGVriPadN9leRQRS1ycNt9uoM665aLW9eQ/c6/X7yW+ijMnNsKek6X99ETIPQJNtxXVNsrXNriUnYcN7pkVVUdv/tw411GzsKhfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+4DuxWT/CpfWrrdm39C/ZtzTKY8JSdhQLNAfF7DIG4=;
 b=jxSPUz6mRg/heGTaXuE6vSn+mpgj/LREmyG5WYmRDGv8+PTh/7cz7J8xOV4xwDjSMKZVzUPx1nefIpmcbASHLsJj9oeBkg9RUFhic6UJqyatxIF8CKqO8xVVgbFEN69915qIvXHOxZyqQjSePCTmX5yvL0mUblQbQBJP/5wsKT5/KZ445wJWMkV3X/fBjObAyKh3qBJqVB3IyNc8W081hmTzC6/tdoNyMaxfSW+eXs/k2lrharNUSRkt///x6C+LkW770H2kuJZMzSN4TFhXBgLbYkZcqa4br8gkkeAUFhxBFwI59uFzAXEl2rrq2A10V4CAAHAQ0v+O4gJZ818L2w==
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 03:17:45 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::c5) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Wed, 5 Oct 2022 03:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:17:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:17:44 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:17:43 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 3/6] null_blk: code cleaup
Date:   Tue, 4 Oct 2022 20:16:58 -0700
Message-ID: <20221005031701.79077-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005031701.79077-1-kch@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9898b3-17b8-4f6c-cd34-08daa6802bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+7ZdbZtN4QKMgJ0d7RSTm6p9QXCVSGuy6L0X6XXXguRv1ZuqhOFC60VqYcB6WLpd9GPYzCJElnUda8PNcuVW9bOgmeT7jVY0rr9v4KVIBkXnR4Ehb6g5psKOP3OQnofl2kYuVeEHqLbZb1pAy4ORgVQAIH5HSDCEIBKYDLk0oW2WDG4rMYyJUz74JR5c0/R8gIk8r1PU48rvEQ+5JRyCTZYgBOdrNy1prDQv7zhvlHwYAs3NIVCKak2PU14psZYC33L5579z0Stz59nmPjo3U2KXUaIBfsLfgVfKP4FxJv9oMLs3ZpI++kkwOHg52ePKE3cLv7eVjfe4PE0GF4uFJEMgv3CzQyMqm4/YQrzgDGERCNFNuCDuR6tU/Ml45KmOYhlh9yP4my6lctkq/KY5p+L7zR6cQmat9HTZD2kIm5Wow+L5+kc2Yk0C/QEKVWC1s4+L/pxkfXZH3kez/mGUFMaBp1eIckGSUYGM4/Uqa8veob7MomnBim5OwZIqQ+r+AtaEcrjDoIUxd7qSW1Or6Nqtys99C5kTbHssQ5UTqsA/RQ3A6aNXEPmM9M/zIQi8vHcokqIXkq2BWEv+LPPd/XXZN5Y4TVE+JepducoQBLe9PrjEiQZ7dHHtnP5Vh4QJbPPSLn/3qIuZlMZwUDwEtb7YQmira8LZLGlhU99J9CTpggNCGgHfM/oNCvkPvkwo/utyAowUd/Y3iaqI8lwmQAe3dSURdp2ffsy1iEhE00ZVEOx1qDugySuTdUnzg1jSzxUIQx08MRjEQuqbSITOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(356005)(82740400003)(7636003)(478600001)(316002)(54906003)(110136005)(1076003)(6666004)(186003)(70586007)(41300700001)(70206006)(8676002)(4326008)(7696005)(5660300002)(26005)(40480700001)(7416002)(36756003)(336012)(8936002)(47076005)(2616005)(2906002)(16526019)(36860700001)(83380400001)(40460700003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:17:44.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9898b3-17b8-4f6c-cd34-08daa6802bf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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
index 2d592b4eb815..b82c2ffeb086 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -14,6 +14,11 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
+/* Gives page index for which this sector belongs to. */
+#define PAGE_IDX_FROM_SECT(sect)	(sect >> PAGE_SECTORS_SHIFT)
+/* Gives index (offset) of the sector within page. */
+#define SECT_IDX_IN_PAGE(sect)		((sect & SECTOR_MASK) << SECTOR_SHIFT)
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
+	offset = SECT_IDX_IN_PAGE(sect);
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
+		offset = SECT_IDX_IN_PAGE(sector);
 		t_page = null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
@@ -1159,7 +1164,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
 
-		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		offset = SECT_IDX_IN_PAGE(sector);
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-- 
2.29.0

