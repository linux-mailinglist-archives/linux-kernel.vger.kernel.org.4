Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0057134C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjE0Mga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjE0MgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:36:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C06194
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:35:53 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1Qr6x5XzLpvb;
        Sat, 27 May 2023 20:32:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 6/6] kexec: enable kexec_crash_size to support two crash kernel regions
Date:   Sat, 27 May 2023 20:34:39 +0800
Message-ID: <20230527123439.772-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230527123439.772-1-thunder.leizhen@huawei.com>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
to support two crash kernel regions. Since crashk_res manages the memory
with high address and crashk_low_res manages the memory with low address,
crashk_low_res is shrunken only when all crashk_res is shrunken. And
because when there is only one crash kernel region, crashk_res is always
used. Therefore, if all crashk_res is shrunken and crashk_low_res still
exists, swap them.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e82bc6d6634136a..c1d50f6566300d9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1091,6 +1091,11 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 	}
 }
 
+static inline resource_size_t crash_resource_size(const struct resource *res)
+{
+	return !res->end ? 0 : resource_size(res);
+}
+
 ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
@@ -1098,8 +1103,8 @@ ssize_t crash_get_memory_size(void)
 	if (!kexec_trylock())
 		return -EBUSY;
 
-	if (crashk_res.end != crashk_res.start)
-		size = resource_size(&crashk_res);
+	size += crash_resource_size(&crashk_res);
+	size += crash_resource_size(&crashk_low_res);
 
 	kexec_unlock();
 	return size;
@@ -1135,7 +1140,7 @@ int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long old_size;
+	unsigned long old_size, low_size;
 
 	if (!kexec_trylock())
 		return -EBUSY;
@@ -1144,14 +1149,42 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
-	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
+
+	low_size = crash_resource_size(&crashk_low_res);
+	old_size = crash_resource_size(&crashk_res) + low_size;
 	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
 	}
 
-	ret = __crash_shrink_memory(&crashk_res, new_size);
+	/*
+	 * (low_size > new_size) implies that low_size is greater than zero.
+	 * This also means that if low_size is zero, the else branch is taken.
+	 *
+	 * If low_size is greater than 0, (low_size > new_size) indicates that
+	 * crashk_low_res also needs to be shrunken. Otherwise, only crashk_res
+	 * needs to be shrunken.
+	 */
+	if (low_size > new_size) {
+		ret = __crash_shrink_memory(&crashk_res, 0);
+		if (ret)
+			goto unlock;
+
+		ret = __crash_shrink_memory(&crashk_low_res, new_size);
+	} else {
+		ret = __crash_shrink_memory(&crashk_res, new_size - low_size);
+	}
+
+	/* Swap crashk_res and crashk_low_res if needed */
+	if (!crashk_res.end && crashk_low_res.end) {
+		crashk_res.start = crashk_low_res.start;
+		crashk_res.end   = crashk_low_res.end;
+		release_resource(&crashk_low_res);
+		crashk_low_res.start = 0;
+		crashk_low_res.end   = 0;
+		insert_resource(&iomem_resource, &crashk_res);
+	}
 
 unlock:
 	kexec_unlock();
-- 
2.25.1

