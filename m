Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39546C0900
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCTCr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCTCrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:47:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6A20692
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:47:46 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PfzbY3Q4Fz17MKr;
        Mon, 20 Mar 2023 10:44:41 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:47:44 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>, <david@redhat.com>
Subject: [PATCH v4 1/4] mm/mlock: return EINVAL if len overflows for mlock/munlock
Date:   Mon, 20 Mar 2023 10:47:36 +0800
Message-ID: <20230320024739.224850-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320024739.224850-1-mawupeng1@huawei.com>
References: <20230320024739.224850-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 617469fce96d..eb68476da497 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -568,6 +568,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	unsigned long locked;
 	unsigned long lock_limit;
 	int error = -ENOMEM;
+	size_t old_len = len;
 
 	start = untagged_addr(start);
 
@@ -577,6 +578,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
+	if (old_len != 0 && len == 0)
+		return -EINVAL;
+
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
 	locked = len >> PAGE_SHIFT;
@@ -631,12 +635,16 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
+	size_t old_len = len;
 
 	start = untagged_addr(start);
 
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
+	if (old_len != 0 && len == 0)
+		return -EINVAL;
+
 	if (mmap_write_lock_killable(current->mm))
 		return -EINTR;
 	ret = apply_vma_lock_flags(start, len, 0);
-- 
2.25.1

