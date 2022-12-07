Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03B6458D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLGLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLGLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:21:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3F3F048
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:21:27 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRvwL41h5zRpjR;
        Wed,  7 Dec 2022 19:20:34 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 19:21:24 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <gautam.dawar@xilinx.com>,
        <elic@nvidia.com>, <sgarzare@redhat.com>
CC:     <wangrong68@huawei.com>, <lulu@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <sunnanyong@huawei.com>,
        <liushixin2@huawei.com>, <wangkefeng.wang@huawei.com>
Subject: [PATCH] vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove
Date:   Wed, 7 Dec 2022 20:08:13 +0800
Message-ID: <20221207120813.2837529-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Wang <wangrong68@huawei.com>

In vp_vdpa_remove(), the code kfree(&vp_vdpa_mgtdev->mgtdev.id_table) uses
a reference of pointer as the argument of kfree, which is the wrong pointer
and then may hit crash like this:

Unable to handle kernel paging request at virtual address 00ffff003363e30c
Internal error: Oops: 96000004 [#1] SMP
Call trace:
 rb_next+0x20/0x5c
 ext4_readdir+0x494/0x5c4 [ext4]
 iterate_dir+0x168/0x1b4
 __se_sys_getdents64+0x68/0x170
 __arm64_sys_getdents64+0x24/0x30
 el0_svc_common.constprop.0+0x7c/0x1bc
 do_el0_svc+0x2c/0x94
 el0_svc+0x20/0x30
 el0_sync_handler+0xb0/0xb4
 el0_sync+0x160/0x180
Code: 54000220 f9400441 b4000161 aa0103e0 (f9400821)
SMP: stopping secondary CPUs
Starting crashdump kernel...

Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
Signed-off-by: Rong Wang <wangrong68@huawei.com>
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0c4de3..8fe267ca3e76 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -647,7 +647,7 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
 	mdev = vp_vdpa_mgtdev->mdev;
 	vp_modern_remove(mdev);
 	vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
-	kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
+	kfree(vp_vdpa_mgtdev->mgtdev.id_table);
 	kfree(mdev);
 	kfree(vp_vdpa_mgtdev);
 }
-- 
2.25.1

