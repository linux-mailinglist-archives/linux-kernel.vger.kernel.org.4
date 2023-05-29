Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE9714593
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjE2HfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjE2HfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:35:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D4A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:35:20 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3XPKqHvCt7PLm3XPKqcUIc; Mon, 29 May 2023 09:35:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685345713;
        bh=2bdE5rxx0WNW70pykzA3LEgDROeECRTKYNJpXeGJheA=;
        h=From:To:Cc:Subject:Date;
        b=Cd9iq3K/CU8lcBda2pvGwM8YS8As0QUQU9FdZ5ldnukC40VE3f0SzxYU5LOuKwGvx
         hVP5ReGttXo7LC71uSjjMO38DQ6S8N0zcoirt+/GPGacR2L55UAJYZGnuk5GeS3h77
         Z7avrHlEZM8W2qmTeHLY3QqK7p+3atNl1ixZyxJsbUzLDjs2qysoL+ORkAXyeRAwkb
         +GIMo6vGGsKR/MzzlL7LPO2nj+nN7g5+5Mlm9sVNXKmnbS2lFZ97+nreUdSlPno89j
         sCp40vhU8/yCOin6MujsXWCujiGjP5o70epm/YUmfQI0sPSr6yr/CCFKpD0LR7g95Q
         PRifGMxA9exbg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 09:35:13 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: virtio_scsi: Remove a useless function call
Date:   Mon, 29 May 2023 09:35:08 +0200
Message-Id: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'inq_result' is known to be NULL. There is no point calling kfree().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/virtio_scsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 58498da9869a..bd5633667d01 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -338,10 +338,8 @@ static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
 	int result, inquiry_len, inq_result_len = 256;
 	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
 
-	if (!inq_result) {
-		kfree(inq_result);
+	if (!inq_result)
 		return -ENOMEM;
-	}
 
 	shost_for_each_device(sdev, shost) {
 		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
-- 
2.34.1

