Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA06C2B84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCUHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCUHkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D83B64B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:40:42 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pgk325l0PznYR6;
        Tue, 21 Mar 2023 15:37:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 15:40:40 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v5 1/4] mm/mlock: return EINVAL if len overflows for mlock/munlock
Date:   Tue, 21 Mar 2023 15:40:32 +0800
Message-ID: <20230321074035.1526157-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321074035.1526157-1-mawupeng1@huawei.com>
References: <20230321074035.1526157-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
The return value of mlock is zero. But nothing will be locked since the
len in do_mlock overflows to zero due to the following code in mlock:

  len = PAGE_ALIGN(len + (offset_in_page(start)));

The same problem happens in munlock.

Add new check and return -EINVAL to fix this overflowing scenarios since
they are absolutely wrong.

Return 0 early to avoid burn a bunch of cpu cycles if len == 0.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mlock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 617469fce96d..247ce396bb16 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -479,8 +479,6 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 	end = start + len;
 	if (end < start)
 		return -EINVAL;
-	if (end == start)
-		return 0;
 	vma = vma_iter_load(&vmi);
 	if (!vma)
 		return -ENOMEM;
@@ -574,7 +572,13 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (!can_do_mlock())
 		return -EPERM;
 
+	if (!len)
+		return 0;
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
+	if (!len)
+		return -EINVAL;
+
 	start &= PAGE_MASK;
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
@@ -634,7 +638,13 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 
 	start = untagged_addr(start);
 
+	if (!len)
+		return 0;
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
+	if (!len)
+		return -EINVAL;
+
 	start &= PAGE_MASK;
 
 	if (mmap_write_lock_killable(current->mm))
-- 
2.25.1

