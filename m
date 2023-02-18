Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC631698E98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBPIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBPIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:22:40 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5759D36447;
        Thu, 16 Feb 2023 00:22:39 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 657381A00A89;
        Thu, 16 Feb 2023 16:23:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J7ndbD2t2LUH; Thu, 16 Feb 2023 16:23:13 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7ACD41A00856;
        Thu, 16 Feb 2023 16:23:13 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] scsi: virtio_scsi: Modify the kmalloc allocation flag
Date:   Sat, 18 Feb 2023 08:53:56 +0800
Message-Id: <20230218005356.3932-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inq_result pointer must be allocated successfully; otherwise,
subsequent function execution may crash.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index d07d24c06b54..3252f4b42261 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -336,7 +336,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
 	unsigned char scsi_cmd[MAX_COMMAND_SIZE];
 	int result, inquiry_len, inq_result_len = 256;
-	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
+	char *inq_result = kmalloc(inq_result_len, __GFP_NOFAIL);
 
 	shost_for_each_device(sdev, shost) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
-- 
2.18.2

