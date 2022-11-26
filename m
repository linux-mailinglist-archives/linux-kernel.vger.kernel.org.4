Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3C6394AA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKZI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 03:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKZI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:29:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2C2A251
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 00:29:12 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NK4d016XLz15MtS
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 16:28:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 16:29:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 26 Nov
 2022 16:29:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <tglx@linutronix.de>, <kraig@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] genirq/irqdesc: fix WARNING in irq_sysfs_del()
Date:   Sat, 26 Nov 2022 16:27:16 +0800
Message-ID: <20221126082716.438271-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
the information files. Fix this by adding check kobj.state_in_sysfs in
irq_sysfs_del().

Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a91f9001103c..e391f4195b87 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -303,7 +303,7 @@ static void irq_sysfs_del(struct irq_desc *desc)
 	 * kobject_del() complains about a object with no parent, so make
 	 * it conditional.
 	 */
-	if (irq_kobj_base)
+	if (irq_kobj_base && desc->kobj.state_in_sysfs)
 		kobject_del(&desc->kobj);
 }
 
-- 
2.25.1

