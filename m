Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42747447B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGAH2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAH22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:28:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418A136
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 00:28:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QtNy90p05ztQSD;
        Sat,  1 Jul 2023 15:25:37 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 1 Jul
 2023 15:28:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: memory-failure: fix potential page refcnt leak in memory_failure()
Date:   Sat, 1 Jul 2023 15:28:37 +0800
Message-ID: <20230701072837.1994253-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_ref_page() is not called to drop extra refcnt when comes from madvise
in the case pfn is valid but pgmap is NULL leading to page refcnt leak.

Fixes: 1e8aaedb182d ("mm,memory_failure: always pin the page in madvise_inject_error")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e245191e6b04..65e2d4c5b50d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2080,8 +2080,6 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 {
 	int rc = -ENXIO;
 
-	put_ref_page(pfn, flags);
-
 	/* device metadata space is not recoverable */
 	if (!pgmap_pfn_valid(pgmap, pfn))
 		goto out;
@@ -2157,6 +2155,7 @@ int memory_failure(unsigned long pfn, int flags)
 
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
+			put_ref_page(pfn, flags);
 			if (pgmap) {
 				res = memory_failure_dev_pagemap(pfn, flags,
 								 pgmap);
-- 
2.33.0

