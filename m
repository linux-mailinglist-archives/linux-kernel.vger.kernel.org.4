Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93118600BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJQJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJQJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:57:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196150070
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:57:12 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrXNN51ZZzVjWm;
        Mon, 17 Oct 2022 17:52:36 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:57:10 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:57:10 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linmq006@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] firmware: dmi-sysfs: Fix null-ptr-deref in dmi_sysfs_register_handle
Date:   Mon, 17 Oct 2022 17:53:42 +0800
Message-ID: <20221017095342.2567-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported a null-ptr-deref error:

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 1373 Comm: modprobe
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
RIP: 0010:dmi_sysfs_entry_release
...
Call Trace:
 <TASK>
 kobject_put
 dmi_sysfs_register_handle (drivers/firmware/dmi-sysfs.c:540) dmi_sysfs
 dmi_decode_table (drivers/firmware/dmi_scan.c:133)
 dmi_walk (drivers/firmware/dmi_scan.c:1115)
 dmi_sysfs_init (drivers/firmware/dmi-sysfs.c:149) dmi_sysfs
 do_one_initcall (init/main.c:1296)
 ...
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x4000000 from 0xffffffff81000000
---[ end Kernel panic - not syncing: Fatal exception ]---

It is because previous patch added kobject_put() to release the memory
which will call  dmi_sysfs_entry_release() and list_del().

However, list_add_tail(entry->list) is called after the error block,
so the list_head is uninitialized and cannot be deleted.

Because entry is allocated by kzalloc() so the list.prev is NULL in
the error path. Check it in dmi_sysfs_entry_release() to avoid
deleting uninitialized list_head.

Fixes: 660ba678f999 ("firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle")

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/firmware/dmi-sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 66727ad3361b..f8815eeed00c 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -557,9 +557,12 @@ static void dmi_sysfs_entry_release(struct kobject *kobj)
 {
 	struct dmi_sysfs_entry *entry = to_entry(kobj);
 
-	spin_lock(&entry_list_lock);
-	list_del(&entry->list);
-	spin_unlock(&entry_list_lock);
+	if (entry->list.prev != NULL) {
+		spin_lock(&entry_list_lock);
+		list_del(&entry->list);
+		spin_unlock(&entry_list_lock);
+	}
+
 	kfree(entry);
 }
 
-- 
2.17.1

