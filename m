Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CB5F5F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJFDTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJFDT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:19:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4B8982D;
        Wed,  5 Oct 2022 20:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etBXGZsJV679jCUsi+6pjDI24KPrGA9oejauZF8uqAjthwPc9ald5ZBCu37QtF/5UUjs4N0F5Nuq5LydOad8RyiMSTK013R/y6sbWebS5VcB+T0AFigwDyPW2I4ZV7S7wKel0BIZSgZITvcgyu420kISDExdcWNTD3kIhGDrHaNPygICWUgLm5k0s2il1iCaMIOu/4aOTo7Ey6AmsQu6jfmlWK1ZRWs6XABHSOTnXBbTChO0M42v4W6+YuKoFW9iGlGMVVpLfUp3dwLA/VL4+3n7qCCn8ddDRDQQRL2v6Y4Pdv8DhvVvqvo5KXMgxd5hshE637glbom8hmHzIgHxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=XVyLsk84eGTqdOdiC1UUS/H84WIRS+MqGvB2+r5zWjU2y61XjOJzej3zoUfYdUunO8r+RW9KLCcm43TVPNqX1nz4cc2HrQDS684/Cwib4344twk9+RubK9lWlBJrLodZSa9EC8z2s+dHPK3WrHlzzjBw9Jwi0ks5Gx2WWGK1/LcHbcpTVLLsjkjwNOypW3DCPZYLu76Tf92d2WdQ+1iYDzIN421aQJ7AAl2cc4SSg/Mkryju7foGbU4RjYfs6QroDrO9uJqlabrp5TbPNcS4m9B+9qi6a1Oj8C4DTJGeyRTflCSrkphZONl/6J0Rpc741Bzeq3n29PuKjqVEqANTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e11AYUnWIO4AX5Cfxa7Oob/PndRG79OvGGQMCbBVEgg=;
 b=noGm/MbXpfSzCynLd/Hwki/FzOMzw2tIpl5sEyuM2KLHid4GZ92Yjv5T3o/6GTxZO11fARgoDy6I509Pc1apHdF9d+dm2v3tTkkoVDSL7jHgb8XrIGFrtuFWjtYGps6D6NeAAidF9OmR45IfH5mqhNJU3cnkvnyzAM96ZoXj9e3NipT9bTiDQSh2SI+eMK/Qu+t6SgBMribELKqRq7uKZt3902tpeMJxreih4dlsS9d7GOhC3lNuzwsrrccnv/YWxro5ChICgvcPcYTa+bDcOBsrcSbIR5jbv9zLC5TYXhineGSFnVncTSPj2GapMqN3uIFFATDM3lfX5Lvb5fPVUA==
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Thu, 6 Oct 2022 03:19:06 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::15) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30 via Frontend
 Transport; Thu, 6 Oct 2022 03:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:19:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:19:03 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:19:02 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 2/7] null_blk: code cleaup
Date:   Wed, 5 Oct 2022 20:18:24 -0700
Message-ID: <20221006031829.37741-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221006031829.37741-1-kch@nvidia.com>
References: <20221006031829.37741-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf70fff-fef2-435a-0212-08daa74986c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MynncS2b+uM4c4QhVvfzADl0qgsC2EJ2oksyKaUcWoPf3B6kGqNt8N4DPoxTqgC7gy+P84Ew7mV4hAKJM2O49M8F57IiH8XX4Ny3NEvPCiLGE0KwL5dKQ6rk+kdPsgkPNQW5nJF9xBBBA8LpT9f+0SKSUWvIaUyRKX5hwmne5rllfRq45v3RIeYjTXpb0d78JsS0YEh1vesL+ad3G1v81hgJnDQ91cdpDAMwy8li1TJJQGIiAjyg5CRTw7WewKo6A5v2RC2fQvEtUGzA0FG6juP8G/4x1YyTwLmcYb2a9Rr7eRpeFP1wWxbdmJEsMdEB1Bs0kiqzdWKRn6DDymMD0oR+awkWZVN0oOIoeqQx/gbUNu5sKgjz8T5nFCnp9qJ6lRV8T88EwONilI/YZ5Na3wFS+iGgMKfl4PjbwTZ0wKifTw9mHW4j8hlHazhBfDcNdmpdBM9b7Rb+V7QSP/kJpHn2yFV2Bne+kJDkfbBbGkgqY9H1y5+bhBGW+Mpsr7Y4m8fh/a3Evus/UAxNZU24ohtV3JbuO7TCijfFMaD81INWRbVim1K21askOt2bubVJB3z47/X2T7HAU9zXYXq6n+5pQuKp7BkqDwRKtDnO3rRVg9sfvrkmrr5n/5oqL7JiOh5MSyaCe7mw8MFzQuTlvgPUD+5lh+PlgRCv3UqN3gP+B6OT90WTxKybuSDjFCL2ehKhRdGqyxttnWEKKa0gQ0mR++R53ZNaC6P6r+pIXnfMqZRQ1PkSCSb8OJRRuYt0DemDJ2taqUMXixvGutIZuw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(26005)(82740400003)(8676002)(40480700001)(7416002)(7696005)(5660300002)(41300700001)(4326008)(7636003)(40460700003)(36756003)(70586007)(70206006)(54906003)(1076003)(110136005)(83380400001)(2906002)(8936002)(478600001)(316002)(2616005)(6666004)(186003)(47076005)(82310400005)(16526019)(36860700001)(356005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:19:06.0227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf70fff-fef2-435a-0212-08daa74986c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

