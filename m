Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4156E5966
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDRG1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:27:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6455B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:26:32 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q0v3L71zVzSsW8;
        Tue, 18 Apr 2023 14:22:22 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 14:26:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] iommu/iova: Optimize iova_magazine_alloc()
Date:   Tue, 18 Apr 2023 14:25:18 +0800
Message-ID: <20230418062518.852-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the member 'size' needs to be initialized to 0. Clearing the array
pfns[], which is about 1 KiB in size, not only wastes time, but also
causes cache pollution.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index fe452ce466429a7..c970b9a2819d7bb 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -647,7 +647,13 @@ struct iova_rcache {
 
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
-	return kzalloc(sizeof(struct iova_magazine), flags);
+	struct iova_magazine *mag;
+
+	mag = kmalloc(sizeof(struct iova_magazine), flags);
+	if (mag)
+		mag->size = 0;
+
+	return mag;
 }
 
 static void iova_magazine_free(struct iova_magazine *mag)
-- 
2.25.1

