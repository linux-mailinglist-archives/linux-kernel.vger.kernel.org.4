Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F56E1145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDMPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDMPhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:37:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8010F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEopUxHnE/SGgTuN/amksYgSFVjw44WD6ZZ4RYjMUkKESU3tWbm+uUZR3joRrX/lgdxDlC27TiIItETDrSKIcIPmK9xn7mgTglJh34BJluvybYGVZLguKTrDCjz5TmXSL8fnoWhzAwcSC8waPSGnBD5YRAmTnpr+Dfn2YPuzyn5do9QZgBOlkyKzdbtP6f0+DZRYrlYMLcGC2YVAipLGJrzWo6fAHGq/oI4CObTQyEOQzZ2wvkSx25l+3mqzS0q2dekxqZV98cKu2vbZTVXyxY4TjetQMrWThPiSYwYEnq/hiojFqUw+4hsBSDti16Neb1JTutsnTWW27f9DoPk7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ocsd/IN8GNMvve5CUvo167Wvq3ubhozqn9frtxv+5h8=;
 b=nSpNFmee7ZEZlo8YbmkGK2KsgBvbyX5t0YKLd964kDF0sb1eNB2jdaZOnnUbZNhUB/Tg5/UZ9L87soOndaLB8SmH0hls5XD4ZfMHYl0OLlfjZVfL3JNfifQYe6jkujgYfkbGziUPW4sdH6/SKAjv/duMxlGQTaO07i7lox5FBGbPjaQe/ddmIoQNckUhGXazYrNl3z3t3D6b5f62IYCsDUVUpb5eF+B/TUQJHXVoGRrtWlk7MTRT+MG0vjwTGOgiLuo4zgY9FrswRJ4jpWrYHkimy2/4iKjlZfaOfNPEG+LTdQZ6ak8xIW+Ecrhzugg8zqw0+zeyLqkSICjrkgQ7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ocsd/IN8GNMvve5CUvo167Wvq3ubhozqn9frtxv+5h8=;
 b=HXfeYrvp/EsB4d0cnOLcNXQVvlCPBvDSbX/BPWXb38PCdUi+oTv88D2+g0jFj4upZc2rtlyvZLdGHRBBvfk/d5YNtf+XFu2Dd5rRyHB1O6mtLyvlT4KGfboOcY3oRgV0XQ7/ppPzj9fePliCzMV4KzZaeGWnSWH2mJ5U8IzxYro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA0PR21MB1931.namprd21.prod.outlook.com (2603:10b6:806:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6; Thu, 13 Apr
 2023 15:37:47 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6319.006; Thu, 13 Apr 2023
 15:37:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com,
        petr.tesarik.ext@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] swiotlb: Fix debugfs reporting of reserved memory pools
Date:   Thu, 13 Apr 2023 08:37:30 -0700
Message-Id: <1681400250-2032-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SA0PR21MB1931:EE_
X-MS-Office365-Filtering-Correlation-Id: 84daeb2a-f8e0-4030-204e-08db3c350806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdKnkBmsuhioj+lvpEBSPFW5uMHLlZ13hKKIUVqjb3s/fPBkr4elq9SFuFRItcb3gKx7uLXqv5M6C8RvzZKAwfSE8f/OIEFVsB3Fc8lsFu6Qlwu9JdDWJqbDP/mvAm1CLFHTSz8Y5o08Sn/mi0UffxmoLDcpd93rp2fudNFOZyDqYLL3h0jkVA6UwSu8Ktv1eZlTyqqEVj7+Gh6SpRyzsENiNl8qIc7FsYKTg4YOI4wW0LkAAcXDboPyiijKolFdlU+frAbFm6IkiiaR/c1ECEh6lAOoiUABQYUIk9gJgrGoGtc7+YA9FQHWHBtPPpq3OLX3IuS0GNG0zb9Ywp/0psJpNYbE3mbQ9l2Q2mNaedPViEBtzjvNL+2+ZeqQlo5jw5Wg9jSi6Rkgd+i+Bt9MYhkkDyOCMSS1oRSPtM+APk+Dbk7GeAYO+2E+/y0rouDqnzHuEr15KRb1ucJrL1lXMmmPwN0k996zHiV4WfkV0DcaBaZjdBA3JYWTPFhBAv/+TSGc4cFq30LxYQrVJlTPYJCiRNGdxxThhcbz8raajwTmuxNMhV73nbbdFuGmUuGQ/yzAhW6+OcIgJgASo5xyNsNLjDSbwi0uP0V9rCl7+wTq9kLeUH4um0XuwwxF/DFlF2teISUynGhYuigc/ctHdq0a8kOXXcmpYzsmfJ4eSVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(26005)(6512007)(6506007)(186003)(107886003)(10290500003)(478600001)(316002)(786003)(36756003)(6486002)(52116002)(5660300002)(8936002)(2906002)(82960400001)(4326008)(8676002)(82950400001)(86362001)(66476007)(66556008)(66946007)(38350700002)(38100700002)(41300700001)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWUEKSJWsdnAYrlLQs7FzkFjTQaEHozdzZ80siunm0Hx5MHtW51sUmrXnFz3?=
 =?us-ascii?Q?yL4avra9uku6IDXIwp38gksWLLJS15tdtdiRrIN+JwP8QFrxDzFFe9HGh7eL?=
 =?us-ascii?Q?7Ah02kFMwCec4XLSQ1/KdcOMVHfmu2CyCwXpzCj6E9vB8kNY4HiCWr/TuXcE?=
 =?us-ascii?Q?UY0azGPQNCf91wdmR2xBWQNtR87Imvo3uPxDJG2oKIq7bJR2dESXnEaPDB6k?=
 =?us-ascii?Q?Hm+FKboLM9t7pwkNqp1a/J0fI4vzUROBIJyu9VlDOcb71aNkuP0pfCFePFXi?=
 =?us-ascii?Q?VxbHLHRIg4qzUqmq6QRZxS/FGrrUt1LB3ep9c136JEMHXiQ/lj3r5AUlgnAi?=
 =?us-ascii?Q?EKeeT7xUJxNBZvBp+4fSM4pLHUIb2XDixV2EqU5j6oqis12r6HCBzkKZFo+S?=
 =?us-ascii?Q?oKZtZm2ZcLAcP4xwCzeWbOsxrzWHNwuzbnYntYQfDZZNhc+asACWbsqr7NcZ?=
 =?us-ascii?Q?arkoUgm1y5FUnUOiJlbPq68IXTPwlyInTlzBJ5ojqYc0rt87BVu3ls7nvbYT?=
 =?us-ascii?Q?u+cdq4I3u24ygnyBtP6l0QjzThLzZg1l2sylZydAghIhPpAhd29Bt9/jPSwK?=
 =?us-ascii?Q?Tyl2IpHyW8qyACFH8N0aEujB3qjyrSRpo6eewMhBa0CLgEF3I+j9Zk+QJkg9?=
 =?us-ascii?Q?a7I8iSqUwgATY1jz/jcqJ3cuSzO8UhBikY4RKldxc+4jcR3nyIUEEwn6XxGm?=
 =?us-ascii?Q?P21+9QkGMbRatk5IOJCoTVW9RqzBzHgZ3fDkhmLIiEgX96YxdBkyN/vE62XF?=
 =?us-ascii?Q?15JPmaPJqPuzDjfgWMC6OQjLaqPxNen5qT2SZjSOx7GbAn2v0GLN3eK1nX+k?=
 =?us-ascii?Q?OvKKPfEBKlFFUaCgZIRJXxGHjx17fvV339eJf0k3WnpG11d7aRe+TNupR42R?=
 =?us-ascii?Q?qwtilQH4wKUAEL8bi6mi0V7rxzQ03xnw73QD44SblguNliVX65adGVoaZHRy?=
 =?us-ascii?Q?3w5uDSAPMUfh5+H1PGqW49uPPiQaqFfHj7d3nGuyon1oQyn9sqYV5oBdX9Y4?=
 =?us-ascii?Q?f9viw5muZ36AlIRcRUcA5kTfjd1uiukExrpD9V4uY8WOdYkGquVKdYzhwT5b?=
 =?us-ascii?Q?Gws2VF7FxGtG0ysv+mGpptUAjEhGglHOVFSZmXVpggCmvzUANmc5qhkZNvza?=
 =?us-ascii?Q?CPlSx6Nnyunt0N+qnfh7MGI7qS4leYr4cPutRJHNK2Cf/LaLyxIEeQM0y+wU?=
 =?us-ascii?Q?nZAKr6rWNhyYF++NVsaf4igNKozba7tAkbOlSIQd0uYXnRqfr2IvXagz1hwg?=
 =?us-ascii?Q?yJkmebP5n5CKTi98N/QulgVPsqlCfeCrZyR9rkcEV3HJQTBKxf9RU2bUdqKD?=
 =?us-ascii?Q?jswENhs9ImoB7smz4971Z1yXai17fMZ6s0OD38XaC/tyt/yZDTouDupwAj3E?=
 =?us-ascii?Q?hoOm+CEY2M778UMWDGGaChTSpgM3tCVFvlaVt8HC4FJ5n+MSMoBbrTLqwC38?=
 =?us-ascii?Q?RtIJxtAGiH+bCgmVsuiWvpnxzvUVf0Gyr+f9n0VXupugkYzfkgfSHijQQRq7?=
 =?us-ascii?Q?tr+2vNE7HuB5bSYSqKmWSQmFIrQ2eQDrRJKl1yxgw5ps6aFR03ReR82/u0p1?=
 =?us-ascii?Q?yzPmRM6eRro9MCW4fWEYoOa1cjpAujjPQN+jR7IVi9P5YIPmDMz0hm55T/tc?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84daeb2a-f8e0-4030-204e-08db3c350806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:37:47.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81SHjuFhSlYtyj0oivzKZWoTMokb54C/MVYUOUgg0StHwL7rZLBNSNIupbJEwq+4AO+K+80hzTjcngl9RJ/gYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For io_tlb_nslabs, the debugfs code reports the correct value for a
specific reserved memory pool.  But for io_tlb_used, the value reported
is always for the default pool, not the specific reserved pool. Fix this.

Fixes: 5c850d31880e ("swiotlb: fix passing local variable to debugfs_create_ulong()")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---

I don't have a way to test this directly with OF reserved memory, but I
cobbled together a hack to call rmem_swiotlb_device_init() multiple times
for different size reserved pools. I verified that reserved pool debugfs entries
are created as expected and that the value of io_tlb_used is *not* the value
from the default pool.

 kernel/dma/swiotlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dac42a2..db43de82 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -930,7 +930,9 @@ bool is_swiotlb_active(struct device *dev)
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val = mem_used(&io_tlb_default_mem);
+	struct io_tlb_mem *mem = data;
+
+	*val = mem_used(mem);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
@@ -943,7 +945,7 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
+	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
 			&fops_io_tlb_used);
 }
 
-- 
1.8.3.1

