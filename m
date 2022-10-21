Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B0606D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJUCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJUCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:22:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09657226580
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:22:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mtp5w3XNvz1P7D4;
        Fri, 21 Oct 2022 10:17:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:41 +0800
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
Subject: [PATCH 06/11] firmware: qemu_fw_cfg: fix possible memory leak in fw_cfg_build_symlink()
Date:   Fri, 21 Oct 2022 10:20:57 +0800
Message-ID: <20221021022102.2231464-7-yangyingliang@huawei.com>
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

Inject fault while loading module, kset_register() may fail, if
it fails, but the refcount of kobject is not decreased to 0, the
name allocated in kobject_set_name() is leaked. To fix this by
calling kset_put(), so that name can be freed in callback function
kobject_cleanup() and 'subdir' is freed in kset_release().

unreferenced object 0xffff88810ad69050 (size 8):
  comm "swapper/0", pid 1, jiffies 4294677178 (age 38.812s)
  hex dump (first 8 bytes):
    65 74 63 00 81 88 ff ff                          etc.....
  backtrace:
    [<00000000a80c7bf1>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000003f0167c7>] kstrdup+0x3a/0x70
    [<0000000049336709>] kstrdup_const+0x41/0x60
    [<00000000175616e4>] kvasprintf_const+0xf5/0x180
    [<000000004bcc30f7>] kobject_set_name_vargs+0x56/0x150
    [<000000004b0251bd>] kobject_set_name+0xab/0xe0
    [<00000000700151fb>] fw_cfg_sysfs_probe+0xa5b/0x1320

Fixes: 246c46ebaeae ("firmware: create directory hierarchy for sysfs fw_cfg entries")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..d036e69cabbb 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -544,7 +544,7 @@ static int fw_cfg_build_symlink(struct kset *dir,
 			}
 			ret = kset_register(subdir);
 			if (ret) {
-				kfree(subdir);
+				kset_put(subdir);
 				break;
 			}
 
-- 
2.25.1

