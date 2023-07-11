Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9A74E518
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGKDFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGKDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:04:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EACC10EF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:03:45 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R0Qfk6hSjz1FDn8;
        Tue, 11 Jul 2023 11:03:10 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 11:03:43 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <guohanjun@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>, <thunder.leizhen@huawei.com>,
        <zhangzekun11@huawei.com>
Subject: [PATCH -next 1/2] iommu/iova: Add check for cpu_rcache in free_iova_rcaches
Date:   Tue, 11 Jul 2023 10:54:51 +0800
Message-ID: <20230711025452.35475-2-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711025452.35475-1-zhangzekun11@huawei.com>
References: <20230711025452.35475-1-zhangzekun11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_iova_rcaches() needs to check if cpu_rcache->loaded and
cpu_rcache->prev is NULL before freeing them. Because
iova_domain_init_rcaches() may fail to alloc magazine for
cpu_rcache->loaded and cpu_rcache->prev, but they will be freed
for all cpus.

Fixes: 32e92d9f6f87 ("iommu/iova: Separate out rcache init")
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/iommu/iova.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 10b964600948..3c784a28e9ed 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -746,8 +746,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
 
 			spin_lock_init(&cpu_rcache->lock);
 			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
+			if (!cpu_rcache->loaded) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
-			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
+			if (!cpu_rcache->prev) {
 				ret = -ENOMEM;
 				goto out_err;
 			}
@@ -903,7 +907,11 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 			break;
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+			if (!cpu_rcache->loaded)
+				break;
 			iova_magazine_free(cpu_rcache->loaded);
+			if (!cpu_rcache->prev)
+				break;
 			iova_magazine_free(cpu_rcache->prev);
 		}
 		free_percpu(rcache->cpu_rcaches);
-- 
2.17.1

