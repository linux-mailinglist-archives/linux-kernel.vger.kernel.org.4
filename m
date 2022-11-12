Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F0626832
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiKLIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:52:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA452F38D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:52:28 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N8TpR1k7NzHtt6;
        Sat, 12 Nov 2022 16:51:59 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 16:52:26 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 16:52:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] genirq/irqdesc: hide illegible sysfs warning of kobject_del()
Date:   Sat, 12 Nov 2022 17:39:39 +0800
Message-ID: <20221112093939.616270-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If irq_sysfs_add() failed, system will report a warning but don't call
kobject_put() to release the descriptor. Then in irq_sysfs_del(), we
continue to call kobject_del(). In such situation, kobject_del() will
complains about a object with no parent like this:

 kernfs: can not remove 'actions', no directory
 WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
[...]
 Call Trace:
  <TASK>
  remove_files.isra.0+0x3f/0xb0
  sysfs_remove_group+0x68/0xe0
  sysfs_remove_groups+0x41/0x70
  __kobject_del+0x45/0xc0
  kobject_del+0x2a/0x40
  free_desc+0x44/0x70
  irq_free_descs+0x5d/0x90
[...]

Use kobj->state_in_sysfs to check whether kobject is added succeed. And
if not, we should not call kobject_del().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 kernel/irq/irqdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a91f9001103c..a820d96210d4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -300,10 +300,11 @@ static void irq_sysfs_del(struct irq_desc *desc)
 	/*
 	 * If irq_sysfs_init() has not yet been invoked (early boot), then
 	 * irq_kobj_base is NULL and the descriptor was never added.
+	 * And the descriptor may be added failed.
 	 * kobject_del() complains about a object with no parent, so make
 	 * it conditional.
 	 */
-	if (irq_kobj_base)
+	if (irq_kobj_base && desc->kobj.parent)
 		kobject_del(&desc->kobj);
 }
 
-- 
2.25.1

