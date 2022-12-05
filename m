Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A26421F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiLEDli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiLEDl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:41:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F210DF1B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 19:41:25 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQTpW2XpjzRpl3;
        Mon,  5 Dec 2022 11:40:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 11:41:22 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>, <clameter@sgi.com>
Subject: [PATCH 1/4] mm/mlock: return EINVAL for illegal user memory range in mlock
Date:   Mon, 5 Dec 2022 11:41:05 +0800
Message-ID: <20221205034108.3365182-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205034108.3365182-1-mawupeng1@huawei.com>
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Since TASK_SIZE is the maximum user space address. The start or len of
mlock shouldn't be bigger than this. Function access_ok can be used to
check this issue, so return -EINVAL if bigger.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/mlock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..b9422a62a4cf 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -575,6 +575,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (!can_do_mlock())
 		return -EPERM;
 
+	if (unlikely(!access_ok((void __user *)start, len)))
+		return -EINVAL;
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
@@ -635,6 +638,9 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 
 	start = untagged_addr(start);
 
+	if (unlikely(!access_ok((void __user *)start, len)))
+		return -EINVAL;
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
-- 
2.25.1

