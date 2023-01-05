Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0F65E9D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjAELYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjAELY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:24:28 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF45004E;
        Thu,  5 Jan 2023 03:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXKqI55WNQGHmzniYQzUvSJDC95P06FgdJSVUh2iWggjBe9Efs9nyHStWUgWTEG1/E2b4k5wJ2auPHytbctSONr7qKHgbT747DizcAE2Ou5FciRKuKd1gbY1+Vk+TOiyRVELOwoA5owIZS6F8B0GLMEt7jhgWpPoZm5NOTLb95Zimb6Hgs63NEqsHoQ6MKHQ22M5HYPuv2RV5UsD62B9G2cJ1SEPIzYKiiCJbuON2sjpj599NK9f7V9rIJzL+p3tasOxa9IOlkoBdN713QXchvtzG/N6dbfuzgRvDDmjWie0Yw7btR3jtt2hjJNVeDhmDwBlXvYukbBE/Ktb0mD66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqPgrqJktFQfKCa/fdLsKbrL6eEIFBw4Qj1JjX29ibs=;
 b=edm11sIBddlWBB9gUDvEj0j9jHH8IqanBKlpd+VyUcZaqTFIjJ33Vb0Olfdgqp6s9sJZXzbaOpbCQ2voUaalfQBiynpUxvUDwP6JP9JYz8hBK8Koew0cwy/+z2nF6iRQ0pt/uwOvoF+ZFKmd74uWDWyvQr/v5YgN7b4tfqkm5ivQDZ7l0qFvILUdw9wcW5qS+whYfJrx2hh1TB3KNkZ1YyZrlvKIA7+d9toD8nr+eCdPIz2ZeAAoXrqGWY9RuCsoBTLe+r4iqAPmBFec5OHguQn6xeyJtnKw6eehmC+j0qaxT6dY1R5pF6mn/EcD+tt07wPdzHIisNYJr48AagKa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqPgrqJktFQfKCa/fdLsKbrL6eEIFBw4Qj1JjX29ibs=;
 b=Ihjy22/R0y8CYQfvVkwtWs9rfU6HvP3202AuTwD0lmbhOZN9Acy2dND2LayNdqj8dJLsFqZclzZ+/bDwoDCN5hZT3OSkPmo7JaMgGLd4WgMpFi00xJVk108qfZpCPuV3XP3ucyeCIoyIY21QND2+hoYNe1/toEIO42EO0z/UyL5hTerB5vDT7/8Kqhjhb1w4R3P5FLEYxHvK9oEEC4imDgNfTS7KYi+9ggpF4JOVSHnkRAqq24H0mhzn8RDmgkaWRtAncpPlP7jrkhIfRQMVdcuJEvoFdWspNv6cbpWdVyhNKKgTMs4p041M98UOYVn4Ig3MXaNUNVEflk9e0dgqRg==
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 11:24:14 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f5) by DM6PR07CA0111.outlook.office365.com
 (2603:10b6:5:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 11:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 11:24:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 03:24:06 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 03:24:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Thu, 5 Jan
 2023 03:24:02 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <axboe@kernel.dk>, <logang@deltatee.com>
CC:     <hch@lst.de>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <yishaih@nvidia.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the last SG properly
Date:   Thu, 5 Jan 2023 13:23:39 +0200
Message-ID: <20230105112339.107969-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a527436-25ef-4546-7e18-08daef0f6018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tkg0pdRPeJ1c3hXBS6KRk54+MJx9aZvTQtMjniZh5a86BEuDeUGvlzS6Z0iFpNuPEN22jVL5pRy5JDyhq72zqqx5gLstw5Dj+EFPZ8EfrAxUwsyGk0wCk8FNgKpsRp/qpR94EfIV6HsP6XFbV21ThRfA57OYtwxJ1WO1eLnF8TCFwa3cx/teYWpJdVI2ltCNloSFrxupK0TN6e+WJ8OfSWcWINZOs9N75+jDel8YXiIsrPEAm9S1WV4yrpfXdpAzycNAgSFGjRCHwQv4M6p1TdmfkMxwBttusgnKglDq+7JugAvs+Dcv2zx38pECt7YRmDZV3duk6NHg8KpvAvHPp5J6wXVUqEXYvrsN+LoMpxYLbVn/DoUaXUp1p15yYergNV9+MJGcSewflYeJwD/VcLS6wrqjN2Yu0qjXUfFNvdNGe7ICUtRy6cn13Ck36FlPTI4xZqXF7RGdozs93Zx81px1YpZMEbAYDdnYeIRb0/eS7f9UN6lagzIiiBV+gUQd2Hq3gQUIR0I/QxdzqEeRCzdNA9uKmQWKq2FjsuA96WlhrabeJxywxt7D2VuvkgwrnLtWb43e5qzxhjCzxKoVmmFw+/QcSrP1Lc0G84XpRF3xlxaJVd5iYr9sRuNBBOoz3OgDOvm6d4Ybu4AHVeqOCMuJeET6+YsFPmkbU5/PlOOKe2+/1dhq1eZ20vsg1+LWqmg5FhuKn589mDsWMf6bshmQZfSxOnzKHqnOnPkDH0E=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(2616005)(1076003)(47076005)(83380400001)(36860700001)(426003)(86362001)(40480700001)(40460700003)(82310400005)(356005)(7636003)(82740400003)(36756003)(336012)(316002)(110136005)(54906003)(70206006)(41300700001)(4326008)(5660300002)(70586007)(8676002)(186003)(8936002)(26005)(2906002)(107886003)(6666004)(7696005)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 11:24:14.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a527436-25ef-4546-7e18-08daef0f6018
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
in its 'sgt_append->prv' flow to check whether it can merge contiguous
pages into the last SG, it passes the page arguments in the wrong order.

The first parameter should be the next candidate page to be merged to
the last page and not the opposite.

The current code leads to a corrupted SG which resulted in OOPs and
unexpected errors when non-contiguous pages are merged wrongly.

Fix to pass the page parameters in the right order.

Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a0ad2a7959b5..f72aa50c6654 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -476,7 +476,7 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
 		last_pg = sg_page(sgt_append->prv);
-		while (n_pages && pages_are_mergeable(last_pg, pages[0])) {
+		while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
 			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
 				break;
 			sgt_append->prv->length += PAGE_SIZE;
-- 
2.18.1

