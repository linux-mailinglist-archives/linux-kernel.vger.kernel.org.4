Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3166BD61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjAPL7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjAPL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:59:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FF196BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:59:00 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NwVrb20pZzJrvS;
        Mon, 16 Jan 2023 19:57:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:58:57 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2 4/4] mm/msync: return ENOMEM if len overflows for msync
Date:   Mon, 16 Jan 2023 19:58:13 +0800
Message-ID: <20230116115813.2956935-5-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116115813.2956935-1-mawupeng1@huawei.com>
References: <20230116115813.2956935-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Return -ENOMEM if len overflows for msync.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/msync.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index ac4c9bfea2e7..8ac227ec38af 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -36,6 +36,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	struct vm_area_struct *vma;
 	int unmapped_error = 0;
 	int error = -EINVAL;
+	size_t old_len = len;
 
 	start = untagged_addr(start);
 
@@ -48,7 +49,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	error = -ENOMEM;
 	len = (len + ~PAGE_MASK) & PAGE_MASK;
 	end = start + len;
-	if (end < start)
+	if (end < start || (old_len != 0 && len == 0))
 		goto out;
 	error = 0;
 	if (end == start)
-- 
2.25.1

