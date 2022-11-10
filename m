Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56FA623B20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKJFIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJFIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:08:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A12C123
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:08:05 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N78wh3jVHzmV7B;
        Thu, 10 Nov 2022 13:07:48 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 13:08:02 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>,
        <eperezma@redhat.com>, <gautam.dawar@xilinx.com>,
        <elic@nvidia.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2] vdpa_sim: fix possible memory leak in vdpasim_net_init() and vdpasim_blk_init()
Date:   Thu, 10 Nov 2022 13:04:46 +0800
Message-ID: <20221110050446.3932031-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject fault while probing module, if device_register() fails in
vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
not decreased to 0, the name allocated in dev_set_name() is leaked.
Fix this by calling put_device(), so that name can be freed in
callback function kobject_cleanup().

(vdpa_sim_net)
unreferenced object 0xffff88807eebc370 (size 16):
  comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
  hex dump (first 16 bytes):
    76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
  backtrace:
    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
    [<ffffffff81731d53>] kstrdup+0x33/0x60
    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
    [<ffffffffa0270013>] 0xffffffffa0270013
    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

(vdpa_sim_blk)
unreferenced object 0xffff8881070c1250 (size 16):
  comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
  hex dump (first 16 bytes):
    76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
  backtrace:
    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
    [<ffffffff81731d53>] kstrdup+0x33/0x60
    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
    [<ffffffffa0220013>] 0xffffffffa0220013
    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
v2:
- add fault inject message
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1baf76..f745926237a8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -427,8 +427,10 @@ static int __init vdpasim_blk_init(void)
 	int ret;
 
 	ret = device_register(&vdpasim_blk_mgmtdev);
-	if (ret)
+	if (ret) {
+		put_device(&vdpasim_blk_mgmtdev);
 		return ret;
+	}
 
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..11f5a121df24 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -305,8 +305,10 @@ static int __init vdpasim_net_init(void)
 	int ret;
 
 	ret = device_register(&vdpasim_net_mgmtdev);
-	if (ret)
+	if (ret) {
+		put_device(&vdpasim_net_mgmtdev);
 		return ret;
+	}
 
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
-- 
2.25.1

