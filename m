Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28820606DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJUCYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJUCXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:23:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE5204ACB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:23:19 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtp6h5RF0zVhyp;
        Fri, 21 Oct 2022 10:18:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:41 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-erofs@lists.ozlabs.org>, <ocfs2-devel@oss.oracle.com>,
        <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <somlo@cmu.edu>,
        <mst@redhat.com>, <jaegeuk@kernel.org>, <chao@kernel.org>,
        <hsiangkao@linux.alibaba.com>, <huangjianan@oppo.com>,
        <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>, <akpm@linux-foundation.org>,
        <alexander.deucher@amd.com>, <luben.tuikov@amd.com>,
        <richard@nod.at>, <liushixin2@huawei.com>
Subject: [PATCH 05/11] class: fix possible memory leak in __class_register()
Date:   Fri, 21 Oct 2022 10:20:56 +0800
Message-ID: <20221021022102.2231464-6-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021022102.2231464-1-yangyingliang@huawei.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject fault while loading module (e.g. pktcdvd.ko), kset_register() may
fail in __class_register(), if it fails, but the refcount of kobject is
not decreased to 0, the name allocated in kobject_set_name() is leaked.
To fix this by calling kfree_const().

unreferenced object 0xffff888102fa8190 (size 8):
  comm "modprobe", pid 502, jiffies 4294906074 (age 49.296s)
  hex dump (first 8 bytes):
    70 6b 74 63 64 76 64 00                          pktcdvd.
  backtrace:
    [<00000000e7c7703d>] __kmalloc_track_caller+0x1ae/0x320
    [<000000005e4d70bc>] kstrdup+0x3a/0x70
    [<00000000c2e5e85a>] kstrdup_const+0x68/0x80
    [<000000000049a8c7>] kvasprintf_const+0x10b/0x190
    [<0000000029123163>] kobject_set_name_vargs+0x56/0x150
    [<00000000747219c9>] kobject_set_name+0xab/0xe0
    [<0000000005f1ea4e>] __class_register+0x15c/0x49a

If class_add_groups() fails, it need delete kobject and free its name,
besides, subsys_private also need be freed.

unreferenced object 0xffff888037274000 (size 1024):
  comm "modprobe", pid 502, jiffies 4294906074 (age 49.296s)
  hex dump (first 32 bytes):
    00 40 27 37 80 88 ff ff 00 40 27 37 80 88 ff ff  .@'7.....@'7....
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace:
    [<00000000151f9600>] kmem_cache_alloc_trace+0x17c/0x2f0
    [<00000000ecf3dd95>] __class_register+0x86/0x49a

It can not call kset_put() or kset_unregister() in error path, because
the 'cls' will be freed in callback function class_release() and it also
freed in error path, it will cause double free.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/class.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 64f7b9a0970f..87de0a04ee9b 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -187,11 +187,17 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 
 	error = kset_register(&cp->subsys);
 	if (error) {
+		kfree_const(cp->subsys.kobj.name);
 		kfree(cp);
 		return error;
 	}
 	error = class_add_groups(class_get(cls), cls->class_groups);
 	class_put(cls);
+	if (error) {
+		kobject_del(&cp->subsys.kobj);
+		kfree_const(cp->subsys.kobj.name);
+		kfree(cp);
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(__class_register);
-- 
2.25.1

