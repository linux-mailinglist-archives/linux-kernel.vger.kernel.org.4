Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C68634CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiKWBPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiKWBPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:15:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE0E2B53
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:14:20 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH36g6vcYzmW6X;
        Wed, 23 Nov 2022 09:13:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 09:14:18 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <ming.lei@canonical.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH] driver core: fix resource leak in device_add()
Date:   Wed, 23 Nov 2022 09:20:42 +0800
Message-ID: <20221123012042.335252-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling kobject_add() failed in device_add(), it will call
cleanup_glue_dir() to free resource. But in kobject_add(),
dev->kobj.parent has been set to NULL. This will cause resource leak.

The process is as follows:
device_add()
	get_device_parent()
		class_dir_create_and_add()
			kobject_add()		//kobject_get()
	...
	dev->kobj.parent = kobj;
	...
	kobject_add()		//failed, but set dev->kobj.parent = NULL
	...
	glue_dir = get_glue_dir(dev)	//glue_dir = NULL, and goto
					//"Error" label
	...
	cleanup_glue_dir()	//becaues glue_dir is NULL, not call
				//kobject_put()

The preceding problem may cause insmod mac80211_hwsim.ko to failed.
sysfs: cannot create duplicate filename '/devices/virtual/mac80211_hwsim'
Call Trace:
<TASK>
dump_stack_lvl+0x8e/0xd1
sysfs_warn_dup.cold+0x1c/0x29
sysfs_create_dir_ns+0x224/0x280
kobject_add_internal+0x2aa/0x880
kobject_add+0x135/0x1a0
get_device_parent+0x3d7/0x590
device_add+0x2aa/0x1cb0
device_create_groups_vargs+0x1eb/0x260
device_create+0xdc/0x110
mac80211_hwsim_new_radio+0x31e/0x4790 [mac80211_hwsim]
init_mac80211_hwsim+0x48d/0x1000 [mac80211_hwsim]
do_one_initcall+0x10f/0x630
do_init_module+0x19f/0x5e0
load_module+0x64b7/0x6eb0
__do_sys_finit_module+0x140/0x200
do_syscall_64+0x35/0x80
entry_SYSCALL_64_after_hwframe+0x46/0xb0
</TASK>
kobject_add_internal failed for mac80211_hwsim with -EEXIST, don't try to
register things with the same name in the same directory.

Fixes: cebf8fd16900 ("driver core: fix race between creating/querying glue dir and its cleanup")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..1a7e74840dad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3451,7 +3451,7 @@ int device_add(struct device *dev)
 	/* we require the name to be set before, and pass NULL */
 	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
 	if (error) {
-		glue_dir = get_glue_dir(dev);
+		glue_dir = kobj;
 		goto Error;
 	}
 
-- 
2.17.1

