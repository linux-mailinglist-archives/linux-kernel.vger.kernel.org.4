Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83289687602
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBBGo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:44:25 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B7D79C9B;
        Wed,  1 Feb 2023 22:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6hzHM
        L8zJZo5EjDWZpassjEzpK+oxlFSmZP2G2l+x5s=; b=V/oxsXM0Iqsc6Q01CvuNZ
        HZiDqNC1VadNjuJ3haAV5r/WLZlxZlw8lUr13A4UaldYeVRvZcpXF/ImXKJwIHBN
        M0G+5LMQPuXh7M+2IKFqrPd640PpMS2ibVLWwHsBMyyMWcwvkQ0Z0htRAR2XaV8C
        N27qJhsoapquVDEwywWKJo=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wB3ePTuV9tjNPomCg--.47862S2;
        Thu, 02 Feb 2023 14:27:58 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] scsi: virtio_scsi: Fix poential NULL pointer dereference in virtscsi_rescan_hotunplug
Date:   Thu,  2 Feb 2023 14:27:56 +0800
Message-Id: <20230202062756.21130-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3ePTuV9tjNPomCg--.47862S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5Cry8CrW7Gw4rGw1UGFg_yoW8ZF4kpr
        WYy34jyw45Ga1xWayFgFZxCw1Y9ws7Wry7tayYg3y5WF45WryIqa1DJ34UZFW5XF95J3Z8
        Aa10gF1j9ryDuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEL0eDUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBugQKU1+GuBlNgQAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/scsi/virtio_scsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index d07d24c06b54..f198e281b1d3 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -330,13 +330,16 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
 	scsi_device_put(sdev);
 }
 
-static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
+static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 {
 	struct scsi_device *sdev;
 	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int result, inquiry_len, inq_result_len = 256;
 	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
+
+	if (!inq_result)
+		return -ENOMEM;
 
 	shost_for_each_device(sdev, shost) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
@@ -366,6 +369,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	}
 
 	kfree(inq_result);
+	return 0;
 }
 
 static void virtscsi_handle_event(struct work_struct *work)
@@ -374,12 +378,15 @@ static void virtscsi_handle_event(struct work_struct *work)
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

