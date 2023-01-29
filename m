Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A258167FCB7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 05:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjA2EHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 23:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2EG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 23:06:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96311CF5C
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 20:06:55 -0800 (PST)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P4Hl13WRHzRnvL;
        Sun, 29 Jan 2023 12:04:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 12:06:53 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next] memory tier: release the new_memtier in find_create_memory_tier()
Date:   Sun, 29 Jan 2023 04:06:51 +0000
Message-ID: <20230129040651.1329208-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_create_memory_tier(),  if failed to register device, then we should
release new_memtier from the tier list and put device instead of memtier.

Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 mm/memory-tiers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c734658c6242..e593e56e530b 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -211,8 +211,8 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 	ret = device_register(&new_memtier->dev);
 	if (ret) {
-		list_del(&memtier->list);
-		put_device(&memtier->dev);
+		list_del(&new_memtier->list);
+		put_device(&new_memtier->dev);
 		return ERR_PTR(ret);
 	}
 	memtier = new_memtier;
-- 
2.25.1

