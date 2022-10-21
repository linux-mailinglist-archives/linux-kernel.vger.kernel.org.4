Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045F606D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJUCWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJUCWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:22:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCE1F813D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:22:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtp5s2PGmzmVHX;
        Fri, 21 Oct 2022 10:17:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:38 +0800
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
Subject: [PATCH 03/11] bus: fix possible memory leak in bus_register()
Date:   Fri, 21 Oct 2022 10:20:54 +0800
Message-ID: <20221021022102.2231464-4-yangyingliang@huawei.com>
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

Inject fault while loading module (e.g. edac_core.ko), kset_register()
may fail in bus_register(), if it fails, but the refcount of kobject is
not decreased to 0, the name allocated in kobject_set_name() is leaked.
To fix this by calling kset_put(), so that name can be freed in callback
function kobject_cleanup().

unreferenced object 0xffff888103bddb68 (size 8):
  comm "systemd-udevd", pid 341, jiffies 4294903262 (age 42.212s)
  hex dump (first 8 bytes):
    65 64 61 63 00 00 00 00                          edac....
  backtrace:
    [<000000009e31d566>] __kmalloc_track_caller+0x1ae/0x320
    [<00000000e4cfd8de>] kstrdup+0x3a/0x70
    [<000000003d0ec369>] kstrdup_const+0x68/0x80
    [<000000008e5c3b20>] kvasprintf_const+0x10b/0x190
    [<00000000b9a945aa>] kobject_set_name_vargs+0x56/0x150
    [<000000000df9278c>] kobject_set_name+0xab/0xe0
    [<00000000f51dc49f>] bus_register+0x132/0x350
    [<000000007d91c2e5>] subsys_register+0x23/0x220

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 7ca47e5b3c1f..301b5330f9d8 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -804,8 +804,10 @@ int bus_register(struct bus_type *bus)
 	priv->drivers_autoprobe = 1;
 
 	retval = kset_register(&priv->subsys);
-	if (retval)
+	if (retval) {
+		kset_put(&priv->subsys);
 		goto out;
+	}
 
 	retval = bus_create_file(bus, &bus_attr_uevent);
 	if (retval)
-- 
2.25.1

