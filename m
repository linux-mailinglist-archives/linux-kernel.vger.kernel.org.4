Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3D66290B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjAIOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjAIOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:51:23 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE832180;
        Mon,  9 Jan 2023 06:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbnnXR/MBAdNCly/STVR9eQ7xwKtsQpwXFU8U1fcVbqn5Qy3mEfIVwFgmcqhdDZsyPnlRn1Z83NMFqMF0copPTtX8hmKv+u52izcNbolgLmi2v6dVtMaKgZSguFdMAn29gZUY7ZSNnRUCwF0NSaGMppvflquylWHs7bYqqlT9OFRKVhAwv/CyI3Zi2fABkjJMKW778bKXHFlA4STmAomR/icmOp3YvLkpGe/R2m9CAj/PtQFBMuCs4wDKnluEOkCra9K7TNASStgHWtEMHBZqf0oLPApEZlRc0OhLojjVmtf40Q8j+aMc8BW00CfTxkxy+sfqvl2PK6/znc0hCgWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbdZuSp73u/h7tOKBD3doKfJsV6a4vr5Yt0pui6hGgU=;
 b=LPSo8rJikAk8eDcNTGFKt/oRD+Un4srt+un6RZQGxQLaKMjUQEQKneZChsZIDVPeXAhUiFsg3XeITyPpCdGt2leWuOERdbrF63/9zMg0WXy1q1OS+DmttFW3ehYIrnqCqR3NJrutlghhQGyukl8lIAuTL2l0kJCqtLQdUpMJg/impLGewkkFlM8sAqq8yrpBHr2GkHrK9E9KnShnKsrL7IhsiZ1ETfdivNEeYBiTEHPYj3Kx+MqlsCVP5pVq6BC11ZOzAGktoZ3afrR/Jllgtc66ePnWnNITPWiQtV+pmrejzJy7GjYm3kgmthGlxfTGFNqd39d+3Az39GjOsvr06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbdZuSp73u/h7tOKBD3doKfJsV6a4vr5Yt0pui6hGgU=;
 b=sh78pmE9c35LFn6TV10c3kNu3w33E1PA3AIRD9WMuROrVSLrp6inqI9vF2qyXeEPudikhk+tFyeEVYX4Gt5MxpXJz5tytjvSDXVcHmaB4TuF22wQh3ZvB/JtyookcdjFU5sRgwCNoADFiBcLy6/fAD4FYcyECYp461paPfC4qL3TKeNA9pqWUMI8Hca6J4i0LVm3ROkdvFuIKK62f9KDfLYGhvyoKnDSs8Ynh9iFLoBQSizOq/175WOv4r5QW/V8c3Zn0xUUsAbW9aB8MsaqNAU9mdctUtmEPp4WFeNxb43gBFb6V2vI/nlCcq693FxKkL0Hn6fSJxKp3CrY/Urhhw==
Received: from BN8PR15CA0068.namprd15.prod.outlook.com (2603:10b6:408:80::45)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:48:08 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::51) by BN8PR15CA0068.outlook.office365.com
 (2603:10b6:408:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 14:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 14:48:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 06:47:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 06:47:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 9 Jan 2023 06:47:56 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <jgg@nvidia.com>, <axboe@kernel.dk>,
        <logang@deltatee.com>
CC:     <hch@lst.de>, <alex.williamson@redhat.com>, <yishaih@nvidia.com>,
        <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Date:   Mon, 9 Jan 2023 16:47:01 +0200
Message-ID: <20230109144701.83021-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c011757-627f-4d61-a566-08daf25085aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6GZHzmUOv47X0B/zH3IjwQhaYzgYpxC9PFiq+vxqAyYAgIEaeuuc0VOPOP8Kas5hjLjTywzy4KM8txEqyjqfhB3r5OwPhMJk3kiwAyTTPpDZb3RKAA2vJ+9jPFeaIr0q/ERqkYEr6yuxV/1Ht1ECNEU7yJicu+uPuhRSkcq+FJnbb9IP6b9l0FE66+vzef3ClN1sjv+mXgu+REiQ/O/NCWmUtsDNSx7Ch0EGRUZNCQDD9x1lLi1G5YzcrdGgzXyUt5P2Ox7gdBsxlBqsBjTZE9jHpJYCTcfx8lhi8V9dieLARkVcKG2riJpYXCPkHVlThMZ+w20RKVTGb9EodynyzLctMdW84IjWBNwCoFspxkswcyhKSYK686vfHBC2iv4nzTQ9C8DoT0JRwTRZgGqJtsjP7L0eoWSP7+PCk8+pTytnWhQjTFUpJHPgR8txJQycGTLQL2NcxlV/pG4M42i4trlePHxLvqS5PAVzNUdXN8comt5cNz3nvL9h8SM3ZQRMd7XbKslr+ZLpFQV8hiB5uL9jXgI5A+3Oss3nemGXnaazc9AyEWMgeI0Zbmojc9XHToCxZooWgy3UvcDPUCKVaULGoFTI7nN0OyIY5ZoDmt+FQ5lT8BrNqAsyjmTDztWI4WMl+/GF3qqwXPZMqkw+qSmKJGA0t4G1JYQN6yF+R1Cq8KjFi+dgig3sph8pex69NpjS3acdhx+sIOUapYRBJ6b3DWacO6vHjVKgfIS6xo=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(1076003)(316002)(5660300002)(40480700001)(26005)(7696005)(186003)(478600001)(2616005)(40460700003)(426003)(47076005)(41300700001)(110136005)(70206006)(336012)(54906003)(4326008)(8676002)(70586007)(82310400005)(8936002)(83380400001)(86362001)(36756003)(6666004)(107886003)(36860700001)(82740400003)(356005)(2906002)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:48:07.8174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c011757-627f-4d61-a566-08daf25085aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last_pg is wrong, it is actually the first page of the last
scatterlist element. To get the last page of the last scatterlist
element we have to add prv->length. So it is checking mergability
against the wrong page, Further, a SG element is not guaranteed to end
on a page boundary, so we have to check the sub page location also for
merge eligibility.

Fix the above by checking physical contiguity, compute the actual last
page and then call pages_are_mergable().

Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 lib/scatterlist.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index f72aa50c6654..2377917893e7 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -470,22 +470,29 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		return -EOPNOTSUPP;
 
 	if (sgt_append->prv) {
+		unsigned long paddr =
+			(page_to_pfn(sg_page(sgt_append->prv)) * PAGE_SIZE +
+			 sgt_append->prv->offset + sgt_append->prv->length) /
+			PAGE_SIZE;
+
 		if (WARN_ON(offset))
 			return -EINVAL;
 
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
-		last_pg = sg_page(sgt_append->prv);
-		while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
-			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
-				break;
-			sgt_append->prv->length += PAGE_SIZE;
-			last_pg = pages[0];
-			pages++;
-			n_pages--;
+		if (page_to_pfn(pages[0]) == paddr) {
+			last_pg = pfn_to_page(paddr - PAGE_SIZE);
+			while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
+				if (sgt_append->prv->length + PAGE_SIZE > max_segment)
+					break;
+				sgt_append->prv->length += PAGE_SIZE;
+				last_pg = pages[0];
+				pages++;
+				n_pages--;
+			}
+			if (!n_pages)
+				goto out;
 		}
-		if (!n_pages)
-			goto out;
 	}
 
 	/* compute number of contiguous chunks */
-- 
2.18.1

