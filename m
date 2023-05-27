Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD67134C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjE0MgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjE0MgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:36:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279013A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:35:51 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QT1Qr2ln2zLpvQ;
        Sat, 27 May 2023 20:32:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 27 May 2023 20:35:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Date:   Sat, 27 May 2023 20:34:38 +0800
Message-ID: <20230527123439.772-6-thunder.leizhen@huawei.com>
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

No functional change, in preparation for the next patch so that it is
easier to review.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kexec_core.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 69fe92141b0b62d..e82bc6d6634136a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1105,11 +1105,37 @@ ssize_t crash_get_memory_size(void)
 	return size;
 }
 
+int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
+{
+	struct resource *ram_res;
+
+	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
+	if (!ram_res)
+		return -ENOMEM;
+
+	ram_res->start = old_res->start + new_size;
+	ram_res->end   = old_res->end;
+	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
+	ram_res->name  = "System RAM";
+
+	if (!new_size) {
+		release_resource(old_res);
+		old_res->start = 0;
+		old_res->end   = 0;
+	} else {
+		crashk_res.end = ram_res->start - 1;
+	}
+
+	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
+	insert_resource(&iomem_resource, ram_res);
+
+	return 0;
+}
+
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
 	unsigned long old_size;
-	struct resource *ram_res;
 
 	if (!kexec_trylock())
 		return -EBUSY;
@@ -1125,27 +1151,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
-	if (!ram_res) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	ram_res->start = crashk_res.start + new_size;
-	ram_res->end = crashk_res.end;
-	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
-	ram_res->name = "System RAM";
-
-	if (!new_size) {
-		release_resource(&crashk_res);
-		crashk_res.start = 0;
-		crashk_res.end = 0;
-	} else {
-		crashk_res.end = ram_res->start - 1;
-	}
-
-	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
-	insert_resource(&iomem_resource, ram_res);
+	ret = __crash_shrink_memory(&crashk_res, new_size);
 
 unlock:
 	kexec_unlock();
-- 
2.25.1

