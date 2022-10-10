Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9495FA287
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJJRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJJROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11DF5AB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665422085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rQRSSqgQ4c9BjxvZpkARxVYPlmmPTB3aVJCaeF1YLPM=;
        b=RPTEgPwDdjOQ940pCCrQm36grgq8HymtbrGUmwPoVSd9GCkTDNZA1VX3T2cOjbpq4durNl
        UC4ArzbJ7PXkiBqAo/JAl08mLPHI3MN9DGVyAUv10CvM4JQJd+lVKnM+44iZTJjvfJ6QSc
        7kVhAHFQk680T6X5T/foe6jVxwWPivk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-WYBvDsrjOk-_4ksh-P4sKA-1; Mon, 10 Oct 2022 13:14:44 -0400
X-MC-Unique: WYBvDsrjOk-_4ksh-P4sKA-1
Received: by mail-wm1-f70.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso464394wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQRSSqgQ4c9BjxvZpkARxVYPlmmPTB3aVJCaeF1YLPM=;
        b=aRiMk9xuuFzMEHRTqzTvn+xNz0DkJsm3fPwM2IQXLUhtgQKC1TCyrrarWr00PhNvmZ
         BDlxD7eFIeQP2d7QwJh6lCp2SYnRYTvpMaSDmjIl6rJ/EJ1/FU0LWdUL40VNNI0S3n8S
         Ud4M/y1Zsx5zk/GjNNhjNRbpR8jHyTj0OqZV2uD6++RBPHHhcTzLglfO5DmnWGLBw7XZ
         2iW6y630FQ2zoJwAjjzKwdmRttExM0xXLjCvcDxTWC1J5udo8lCGHR3IjhSFcUjqsGcT
         ArWFGbJOewXTjUKv2Bg/a77+EnfePu5vJns3DLe9Av6SlAGeEPCy2SA6y6O/iwZE1bAd
         XXVg==
X-Gm-Message-State: ACrzQf134ZAGzM8rjyAer5zE8zTfG5cBZv38j2FFF68RBo656YPgqlvv
        4xyyQhcPhw2zj3UB/bUS7060T6YxwahQcxvtcRbWEFyFxP6otFAsn74A1he2X2h3tRLmdyBSIBW
        u0txATGWJxfXTFqtPBNda5EeMhYPDwC5UZU+J0qTVX33/fuUJ1owZFt9rf9QN45B8a+S3zA==
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr10451671wrf.141.1665422083135;
        Mon, 10 Oct 2022 10:14:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OG547EaOYrk728y3uGdJpoAMAokCkwc5CJTaBezE7u5ah4gC7pKsQ+IjfdVwbM924lROjWg==
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr10451646wrf.141.1665422082835;
        Mon, 10 Oct 2022 10:14:42 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0022afcc11f65sm9238215wre.47.2022.10.10.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:14:42 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:14:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 resend] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220811094542.268519-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.

NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
not really what a driver is supposed to be doing. These are transport
enable/disable callbacks from the BT core towards the driver. It maps to
a device being enabled/disabled by something like bluetoothd for
example. So if disabled, users expect that no resources/queues are in
use.  It does work with all other transports like USB, SDIO, UART etc.
There should be no buffer used if the device is powered off. We also
don’t have any USB URBs in-flight if the transport is not active.

The way to implement a proper fix would be using vq reset if supported,
or even using a full device reset.

The cost of the hack is a single skb wasted on an unused bt device.

NB2: with this fix in place driver still suffers from a race condition
if an interrupt triggers while device is being reset.  To fix, in the
virtbt_close() callback we should deactivate all interrupts.  To be
fixed.

squashed fixup: bluetooth: virtio_bt: fix an error code in probe()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20220811080943.198245-1-mst@redhat.com>
---

resending due to v3 having been dropped
changes from v2:
	tkeaked commit log to make lines shorter
changes from v1:
	fixed error handling

 drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..f6d699fed139 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 
 static int virtbt_open(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
 
+static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
+{
 	if (virtbt_add_inbuf(vbt) < 0)
 		return -EIO;
 
@@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_close(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
+
+static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
+{
 	int i;
 
 	cancel_work_sync(&vbt->rx);
@@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	err = virtbt_open_vdev(vbt);
+	if (err)
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	virtio_reset_device(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

