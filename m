Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB54D606DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJUCXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJUCWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:22:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D66230AAD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:22:50 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpCM5YgKzHv3Y;
        Fri, 21 Oct 2022 10:22:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:39 +0800
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
Subject: [PATCH 04/11] kobject: fix possible memory leak in kset_create_and_add()
Date:   Fri, 21 Oct 2022 10:20:55 +0800
Message-ID: <20221021022102.2231464-5-yangyingliang@huawei.com>
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

Inject fault while loading module (e.g. qemu_fw_cfg.ko), kset_register()
may fail in kset_create_and_add(), if it fails, but the refcount of kobject
is not decreased to 0, the name allocated in kset_create() is leaked. To fix
this by calling kset_put(), so that name can be freed in callback function
kobject_cleanup() and kset can be freed in kset_release().

unreferenced object 0xffff888103cc8c08 (size 8):
  comm "modprobe", pid 508, jiffies 4294915182 (age 120.020s)
  hex dump (first 8 bytes):
    62 79 5f 6e 61 6d 65 00                          by_name.
  backtrace:
    [<00000000572f97f9>] __kmalloc_track_caller+0x1ae/0x320
    [<00000000a167a5cc>] kstrdup+0x3a/0x70
    [<000000001cd0d05e>] kstrdup_const+0x68/0x80
    [<00000000b9101e6d>] kvasprintf_const+0x10b/0x190
    [<0000000088f2b8df>] kobject_set_name_vargs+0x56/0x150
    [<000000003f8aca68>] kobject_set_name+0xab/0xe0
    [<00000000249f7816>] kset_create_and_add+0x72/0x200

Fixes: b727c702896f ("kset: add kset_create_and_add function")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 6da04353d974..e77f37200876 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -985,7 +985,7 @@ struct kset *kset_create_and_add(const char *name,
 		return NULL;
 	error = kset_register(kset);
 	if (error) {
-		kfree(kset);
+		kset_put(kset);
 		return NULL;
 	}
 	return kset;
-- 
2.25.1

