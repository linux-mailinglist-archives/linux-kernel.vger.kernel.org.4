Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798A073A9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjFVUuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjFVUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC7199D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687466958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=71euS97JqDaYftzvmNJahHa0ohhMOQyQZdTI3d5Cdjk=;
        b=gsrZM0fbVir4NwRPoPAPMHm+i14GVFarOciLu8LHgAeuqLu4malNQMAKPidnEy6Klevrsp
        LycGxBDH27sXQaPYiidVnwJqWaMYYwIMU8jJbtmudBBIihU8ko7/7IKiqeAfC55wB5enhg
        r8r2+ZyOoqZd1WERrJOTG8QO8fwGhwI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-sHV2WgY9PIi-WFyhF7pZrg-1; Thu, 22 Jun 2023 16:49:15 -0400
X-MC-Unique: sHV2WgY9PIi-WFyhF7pZrg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B5EC2807D8B;
        Thu, 22 Jun 2023 20:49:04 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54FE1422B0;
        Thu, 22 Jun 2023 20:49:02 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        xuanzhuo@linux.alibaba.com
Cc:     gregkh@linuxfoundation.org, sheng.zhao@bytedance.com,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2] vduse: fix NULL pointer dereference
Date:   Thu, 22 Jun 2023 22:48:51 +0200
Message-ID: <20230622204851.318125-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vduse_vdpa_set_vq_affinity callback can be called
with NULL value as cpu_mask when deleting the vduse
device.

This patch resets virtqueue's IRQ affinity mask value
to set all CPUs instead of dereferencing NULL cpu_mask.

[ 4760.952149] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 4760.959110] #PF: supervisor read access in kernel mode
[ 4760.964247] #PF: error_code(0x0000) - not-present page
[ 4760.969385] PGD 0 P4D 0
[ 4760.971927] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4760.976112] CPU: 13 PID: 2346 Comm: vdpa Not tainted 6.4.0-rc6+ #4
[ 4760.982291] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 2.8.1 06/26/2020
[ 4760.989769] RIP: 0010:memcpy_orig+0xc5/0x130
[ 4760.994049] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 17 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
[ 4761.012793] RSP: 0018:ffffb1d565abb830 EFLAGS: 00010246
[ 4761.018020] RAX: ffff9f4bf6b27898 RBX: ffff9f4be23969c0 RCX: ffff9f4bcadf6400
[ 4761.025152] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff9f4bf6b27898
[ 4761.032286] RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000000
[ 4761.039416] R10: 0000000000000000 R11: 0000000000000600 R12: 0000000000000000
[ 4761.046549] R13: 0000000000000000 R14: 0000000000000080 R15: ffffb1d565abbb10
[ 4761.053680] FS:  00007f64c2ec2740(0000) GS:ffff9f635f980000(0000) knlGS:0000000000000000
[ 4761.061765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4761.067513] CR2: 0000000000000000 CR3: 0000001875270006 CR4: 00000000007706e0
[ 4761.074645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4761.081775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4761.088909] PKRU: 55555554
[ 4761.091620] Call Trace:
[ 4761.094074]  <TASK>
[ 4761.096180]  ? __die+0x1f/0x70
[ 4761.099238]  ? page_fault_oops+0x171/0x4f0
[ 4761.103340]  ? exc_page_fault+0x7b/0x180
[ 4761.107265]  ? asm_exc_page_fault+0x22/0x30
[ 4761.111460]  ? memcpy_orig+0xc5/0x130
[ 4761.115126]  vduse_vdpa_set_vq_affinity+0x3e/0x50 [vduse]
[ 4761.120533]  virtnet_clean_affinity.part.0+0x3d/0x90 [virtio_net]
[ 4761.126635]  remove_vq_common+0x1a4/0x250 [virtio_net]
[ 4761.131781]  virtnet_remove+0x5d/0x70 [virtio_net]
[ 4761.136580]  virtio_dev_remove+0x3a/0x90
[ 4761.140509]  device_release_driver_internal+0x19b/0x200
[ 4761.145742]  bus_remove_device+0xc2/0x130
[ 4761.149755]  device_del+0x158/0x3e0
[ 4761.153245]  ? kernfs_find_ns+0x35/0xc0
[ 4761.157086]  device_unregister+0x13/0x60
[ 4761.161010]  unregister_virtio_device+0x11/0x20
[ 4761.165543]  device_release_driver_internal+0x19b/0x200
[ 4761.170770]  bus_remove_device+0xc2/0x130
[ 4761.174782]  device_del+0x158/0x3e0
[ 4761.178276]  ? __pfx_vdpa_name_match+0x10/0x10 [vdpa]
[ 4761.183336]  device_unregister+0x13/0x60
[ 4761.187260]  vdpa_nl_cmd_dev_del_set_doit+0x63/0xe0 [vdpa]

Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
Cc: xieyongji@bytedance.com

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5f5c21674fdc..0d84e6a9c3cc 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -726,7 +726,11 @@ static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	if (cpu_mask)
+		cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	else
+		cpumask_setall(&dev->vqs[idx]->irq_affinity);
+
 	return 0;
 }
 
-- 
2.41.0

