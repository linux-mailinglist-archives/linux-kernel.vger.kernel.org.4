Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487206004F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJQBvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJQBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:50:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445F63BC61
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:50:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrKZx5V4ZzVjDm;
        Mon, 17 Oct 2022 09:46:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:50:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 09:50:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: [PATCH] bus: fix possible memory leak in bus_register()
Date:   Mon, 17 Oct 2022 09:49:57 +0800
Message-ID: <20221017014957.156645-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kset_register() fails, the refcount of kobject is not 0, the name allocated
in kobject_set_name() is leaked. To fix this by calling kset_put(), so that it
will be freed in callback function kobject_cleanup().

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

