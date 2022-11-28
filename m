Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D663AC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiK1PSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiK1PSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:18:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFF2A45C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:18:14 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLTbt6PdBzHw7m;
        Mon, 28 Nov 2022 23:17:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 23:18:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 23:18:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <tglx@linutronix.de>, <kraig@google.com>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: [PATCH v2] genirq/irqdesc: fix WARNING in irq_sysfs_del()
Date:   Mon, 28 Nov 2022 23:16:12 +0800
Message-ID: <20221128151612.1786122-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the lots of WARNING report when doing fault injection test:

kernfs: can not remove 'chip_name', no directory
WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
Call Trace:
 <TASK>
 remove_files.isra.1+0x3f/0xb0
 sysfs_remove_group+0x68/0xe0
 sysfs_remove_groups+0x41/0x70
 __kobject_del+0x45/0xc0
 kobject_del+0x29/0x40
 free_desc+0x42/0x70
 irq_free_descs+0x5e/0x90

kernfs: can not remove 'hwirq', no directory
WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
Call Trace:
 <TASK>
 remove_files.isra.1+0x3f/0xb0
 sysfs_remove_group+0x68/0xe0
 sysfs_remove_groups+0x41/0x70
 __kobject_del+0x45/0xc0
 kobject_del+0x29/0x40
 free_desc+0x42/0x70
 irq_free_descs+0x5e/0x90

If irq_sysfs_add() fails in alloc_descs(), the directory of interrupt
informations is not added to sysfs, it causes the WARNINGs when removing
the information files. Add 'sysfs_added' field in struct irq_desc to
indicate if it is added, and check it before calling kobject_del() to
avoid these WARNINGs.

Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Don't use state_in_sysfs, introduce 'sysfs_added' to indicate if it is added.
---
 include/linux/irqdesc.h | 1 +
 kernel/irq/irqdesc.c    | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 844a8e30e6de..fec0f3946a34 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -97,6 +97,7 @@ struct irq_desc {
 #ifdef CONFIG_SPARSE_IRQ
 	struct rcu_head		rcu;
 	struct kobject		kobj;
+	bool			sysfs_added;
 #endif
 	struct mutex		request_mutex;
 	int			parent_irq;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a91f9001103c..9bf74d11bad5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -292,6 +292,8 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
 		 */
 		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
 			pr_warn("Failed to add kobject for irq %d\n", irq);
+		else
+			desc->sysfs_added = true;
 	}
 }
 
@@ -299,11 +301,12 @@ static void irq_sysfs_del(struct irq_desc *desc)
 {
 	/*
 	 * If irq_sysfs_init() has not yet been invoked (early boot), then
-	 * irq_kobj_base is NULL and the descriptor was never added.
+	 * irq_kobj_base is NULL or kobject_add() fails, the descriptor was
+	 * never added.
 	 * kobject_del() complains about a object with no parent, so make
 	 * it conditional.
 	 */
-	if (irq_kobj_base)
+	if (desc->sysfs_added)
 		kobject_del(&desc->kobj);
 }
 
-- 
2.25.1

