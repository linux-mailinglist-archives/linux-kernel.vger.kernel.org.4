Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5BF6875FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBBGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjBBGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:42:15 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E34B681B10;
        Wed,  1 Feb 2023 22:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BvKyp
        2ja7z1Byi5l1hcgXBba6esEBWVxVsKc6Dkv+1M=; b=AcIj/Cln7UmQY5v4pVYb4
        EFh/iTkAx8MbzCdm/AuaVzU9pC8DydP0Y+2QQYK3fqu5+9A/2EqEdVM7tc4qZ9e2
        fk/5+3Sq2s/4RtfclI1cXxyH0y1mhM8WqLf5gvIPrEeQmUTeyfrUIFBduWtVWq92
        PJkKK3Ju0ashZXfKDh2hKs=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wB3fXEWW9tjKt84Cg--.48881S2;
        Thu, 02 Feb 2023 14:41:26 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mst@redhat.com
Cc:     hackerzheng666@gmail.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer dereference in  virtscsi_rescan_hotunplug
Date:   Thu,  2 Feb 2023 14:41:24 +0800
Message-Id: <20230202064124.22277-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3fXEWW9tjKt84Cg--.48881S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5Cry8CrW7Gw4rGr4rZrb_yoW8uF45pr
        W5t34Yya1UGa1xWayFgFZxCr1Y9ws7Wry7tayYg39xWr45Wryxta1DJ347ZFy5XF95J3Z8
        AF40gF1j9ryDuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEiSdxUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzhoKU2I0XNJUsQAAsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no check about the return value of kmalloc in
virtscsi_rescan_hotunplug. Add the check to avoid use
of null pointer 'inq_result' in case of the failure
of kmalloc.

Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
v2:
- add kfree to avoid memory leak
---
 drivers/scsi/virtio_scsi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index d07d24c06b54..a66d8815d738 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -330,7 +330,7 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
 	scsi_device_put(sdev);
 }
 
-static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
+static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 {
 	struct scsi_device *sdev;
 	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
@@ -338,6 +338,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	int result, inquiry_len, inq_result_len = 256;
 	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
 
+	if (!inq_result) {
+		kfree(inq_result);
+		return -ENOMEM;
+	}
+
 	shost_for_each_device(sdev, shost) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
 
@@ -366,6 +371,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	}
 
 	kfree(inq_result);
+	return 0;
 }
 
 static void virtscsi_handle_event(struct work_struct *work)
@@ -374,12 +380,15 @@ static void virtscsi_handle_event(struct work_struct *work)
 		container_of(work, struct virtio_scsi_event_node, work);
 	struct virtio_scsi *vscsi = event_node->vscsi;
 	struct virtio_scsi_event *event = &event_node->event;
+	int ret = 0;
 
 	if (event->event &
 	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
 		event->event &= ~cpu_to_virtio32(vscsi->vdev,
 						   VIRTIO_SCSI_T_EVENTS_MISSED);
-		virtscsi_rescan_hotunplug(vscsi);
+		ret = virtscsi_rescan_hotunplug(vscsi);
+		if (ret)
+			return;
 		scsi_scan_host(virtio_scsi_host(vscsi->vdev));
 	}
 
-- 
2.25.1

