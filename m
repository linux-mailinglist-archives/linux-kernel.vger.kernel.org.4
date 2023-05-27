Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F067134C7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjE0Mg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjE0MgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:36:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE29124
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:35:52 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QT1Nz25QszqScm;
        Sat, 27 May 2023 20:31:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 4/6] kexec: improve the readability of crash_shrink_memory()
Date:   Sat, 27 May 2023 20:34:37 +0800
Message-ID: <20230527123439.772-5-thunder.leizhen@huawei.com>
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

The major adjustments are:
1. end = start + new_size.
   The 'end' here is not an accurate representation, because it is not the
   new end of crashk_res, but the start of ram_res, difference 1. So
   eliminate it and replace it with ram_res->start.
2. Use 'ram_res->start' and 'ram_res->end' as arguments to
   crash_free_reserved_phys_range() to indicate that the memory covered by
   'ram_res' is released from the crashk. And keep it close to
   insert_resource().
3. Replace 'if (start == end)' with 'if (!new_size)', clear indication that
   all crashk memory will be shrunken.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index bcc86a250ab3bf9..69fe92141b0b62d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1108,7 +1108,6 @@ ssize_t crash_get_memory_size(void)
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long start, end;
 	unsigned long old_size;
 	struct resource *ram_res;
 
@@ -1119,9 +1118,7 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
-	start = crashk_res.start;
-	end = crashk_res.end;
-	old_size = (end == 0) ? 0 : end - start + 1;
+	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
 	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
@@ -1134,22 +1131,20 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	end = start + new_size;
-	crash_free_reserved_phys_range(end, crashk_res.end);
-
-	ram_res->start = end;
+	ram_res->start = crashk_res.start + new_size;
 	ram_res->end = crashk_res.end;
 	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
 	ram_res->name = "System RAM";
 
-	if (start == end) {
+	if (!new_size) {
 		release_resource(&crashk_res);
 		crashk_res.start = 0;
 		crashk_res.end = 0;
 	} else {
-		crashk_res.end = end - 1;
+		crashk_res.end = ram_res->start - 1;
 	}
 
+	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
 	insert_resource(&iomem_resource, ram_res);
 
 unlock:
-- 
2.25.1

