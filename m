Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E367FC73
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjA2Cuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjA2Cuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:50:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154AF1B575
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:50:42 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P4G5N519fzfZ4C;
        Sun, 29 Jan 2023 10:50:32 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 10:50:38 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <stefanha@redhat.com>, <sgarzare@redhat.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <eperezma@redhat.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [PATCH v3 1/2] vdpa: support specify the pgprot of vq notification area
Date:   Sun, 29 Jan 2023 10:50:33 +0800
Message-ID: <20230129025034.2000-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20230129025034.2000-1-longpeng2@huawei.com>
References: <20230129025034.2000-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Adds get_vq_notification_pgprot operation to vdpa_config_ops to support
specify the pgprot of vq norification area. It's an optional operation,
the vdpa framework will treat the pgprot of vq notification area as
noncached as default as usual.
---
 drivers/vhost/vdpa.c | 4 +++-
 include/linux/vdpa.h | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..036fe88425c8 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1263,7 +1263,9 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	notify = ops->get_vq_notification(vdpa, index);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_page_prot = ops->get_vq_notification_pgprot ?
+		ops->get_vq_notification_pgprot(vdpa, index, vma->vm_page_prot) :
+		pgprot_noncached(vma->vm_page_prot);
 	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
 			    PFN_DOWN(notify.addr), PAGE_SIZE,
 			    vma->vm_page_prot))
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..07fcf5e6abc8 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -169,6 +169,12 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the notifcation area
+ * @get_vq_notification_pgprot:	Get the pgprot of the vq's notification area (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				@prot: original page protection value of the
+ *				       notification area
+ *				Returns pgprot_t: the pgprot of the notification area
  * @get_vq_irq:			Get the irq number of a virtqueue (optional,
  *				but must implemented if require vq irq offloading)
  *				@vdev: vdpa device
@@ -305,6 +311,9 @@ struct vdpa_config_ops {
 				   struct netlink_ext_ack *extack);
 	struct vdpa_notification_area
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
+	pgprot_t (*get_vq_notification_pgprot)(struct vdpa_device *vdev,
+					       u16 idx,
+					       pgprot_t prot);
 	/* vq irq is not expected to be changed once DRIVER_OK is set */
 	int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
 
-- 
2.23.0

