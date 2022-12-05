Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9F6429D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLENtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLENtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:49:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9F11813
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:49:22 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQlJ02rFVzRpl4;
        Mon,  5 Dec 2022 21:48:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 21:49:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xialonglong1@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: add cond_resched() in swapin_walk_pmd_entry()
Date:   Mon, 5 Dec 2022 22:03:27 +0800
Message-ID: <20221205140327.72304-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle MADV_WILLNEED in madvise(), the soflockup may be occurred
in swapin_walk_pmd_entry() if swapin lots of memory on slow device,
add a cond_resched() into it to avoid the possible softlockup.

Fixes: 1998cc048901 ("mm: make madvise(MADV_WILLNEED) support swap file prefetch")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index b913ba6efc10..fea589d8a2fb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -226,6 +226,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 			put_page(page);
 	}
 	swap_read_unplug(splug);
+	cond_resched();
 
 	return 0;
 }
-- 
2.35.3

