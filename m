Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9274255D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjF2MGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjF2MF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:05:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5735AF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=PqLg8rAp2ECwt8
        uzRvRRgzi1vbVpdg/PUE+HMKUbCGA=; b=kpCXlx4GiLSUJuHUwZCGw8XjAxrVmD
        78tpwwmMEWQ0tyq2psZouoIpzB5XMll0WKNG4LZqjGsJS1oBNO1G/YloaK76St0i
        6KTpsb7Ba1btJkbsT/gB20TPM2oHAaAYb2i8Xr7u6LE14b42SW0njsBxnvaihtRC
        o+SkQlSL/0pIPbvTb/N0jgxs2h1xsxl2ct6OaHIgdN8w9EU9bishvmTdyD84HBy0
        Bl5thzE2aawSwOvgRyzoab/+bBtv7bnJ3tW0WTiYh7TBtk39uJHgWrTRh4U8FRLa
        tfDA/WsH3bV1dGwy8p80MWdp4kJRHcywS+0Nvs/6A0HGH2xDBkENWAYg==
Received: (qmail 3752080 invoked from network); 29 Jun 2023 14:05:49 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2023 14:05:49 +0200
X-UD-Smtp-Session: l3s3148p1@TgA1hUP/wszBVfKA
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        weiping zhang <zhangweiping@didichuxing.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-mmio: don't break lifecycle of vm_dev
Date:   Thu, 29 Jun 2023 14:05:26 +0200
Message-Id: <20230629120526.7184-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_dev has a separate lifecycle because it has a 'struct device'
embedded. Thus, having a release callback for it is correct.

Allocating the vm_dev struct with devres totally breaks this protection,
though. Instead of waiting for the vm_dev release callback, the memory
is freed when the platform_device is removed. Resulting in a
use-after-free when finally the callback is to be called.

To easily see the problem, compile the kernel with
CONFIG_DEBUG_KOBJECT_RELEASE and unbind with sysfs.

The fix is easy, don't use devres in this case.

Found during my research about object lifetime problems.

Fixes: 7eb781b1bbb7 ("virtio_mmio: add cleanup for virtio_mmio_probe")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/virtio/virtio_mmio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index a46a4a29e929..97760f611295 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -607,9 +607,8 @@ static void virtio_mmio_release_dev(struct device *_d)
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	struct platform_device *pdev = vm_dev->pdev;
 
-	devm_kfree(&pdev->dev, vm_dev);
+	kfree(vm_dev);
 }
 
 /* Platform device */
@@ -620,7 +619,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	unsigned long magic;
 	int rc;
 
-	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
+	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
 
-- 
2.35.1

