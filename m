Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120D760593C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJTICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJTICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:02:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360F108253
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:02:15 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtKnV1Bh3zHv9V;
        Thu, 20 Oct 2022 16:02:06 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 16:01:44 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 16:01:44 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH] firmware: edd: fix possible memory leak in edd_device_register()
Date:   Thu, 20 Oct 2022 16:00:56 +0800
Message-ID: <20221020080056.1050369-1-yangyingliang@huawei.com>
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

Inject fault while loading module, kobject_init_and_add() may fail
in edd_device_register(), if it fails, kobject_put() need be called
to properly clean up the memory associated with the object, or the
name of kobject is leaked.

unreferenced object 0xffff8e7d40d15820 (size 16):
  comm "swapper/0", pid 1, jiffies 4294669397 (age 47.978s)
  hex dump (first 16 bytes):
    69 6e 74 31 33 5f 64 65 76 38 30 00 7d 8e ff ff  int13_dev80.}...
  backtrace:
    [<000000009c36832f>] __kmem_cache_alloc_node+0x1e9/0x360
    [<00000000c952bd6c>] __kmalloc_node_track_caller+0x44/0x1a0
    [<000000007573fbea>] kvasprintf+0x67/0xd0
    [<00000000b2800ea6>] kobject_set_name_vargs+0x1e/0x90
    [<000000002d7bc789>] kobject_init_and_add+0x5d/0xa0
    [<000000002569fea1>] edd_init+0x170/0x2ad

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/firmware/edd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 5cc238916551..ae39119ea403 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -708,6 +708,8 @@ edd_device_register(struct edd_device *edev, int i)
 	if (!error) {
 		edd_populate_dir(edev);
 		kobject_uevent(&edev->kobj, KOBJ_ADD);
+	} else {
+		kobject_put(&edev->kobj);
 	}
 	return error;
 }
@@ -747,10 +749,8 @@ edd_init(void)
 		}
 
 		rc = edd_device_register(edev, i);
-		if (rc) {
-			kfree(edev);
+		if (rc)
 			goto out;
-		}
 		edd_devices[i] = edev;
 	}
 
-- 
2.25.1

