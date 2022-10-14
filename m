Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A35FE7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJNEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJNEUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CD917651A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665721249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HnSURpZm+VRo/jWoSn4Tgay2ffXUBOQESxlPLKKSxGM=;
        b=RcSLPPj9uiXffeHi+HgP6gQOCBpiU3EqGZqRnISWELClcFRUnG89CuDWhehTkXKca1FFpQ
        CFBgJVpk9vf+irIrc9kz33p05NPivndklXGgP7+SIzTOkta4AbQ03bw4CubBfQVdRFUPVj
        dhXN/0qh2wukbYvel9pDVtF5CV+Bnvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-h_Ui7k8wPmmjl_qv7bpchw-1; Fri, 14 Oct 2022 00:20:46 -0400
X-MC-Unique: h_Ui7k8wPmmjl_qv7bpchw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30B34185A794;
        Fri, 14 Oct 2022 04:20:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-249.pek2.redhat.com [10.72.12.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED081121320;
        Fri, 14 Oct 2022 04:20:39 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, vkuznets@redhat.com, liuwe@microsoft.com,
        kkashanjat@microsoft.com, cohuck@redhat.com, otubo@redhat.com,
        andavis@redhat.com, aadam@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH] virtio: document virtio hardening status and TODO
Date:   Fri, 14 Oct 2022 12:20:37 +0800
Message-Id: <20221014042037.23639-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch summarizes the status of hardening and TODO of hardening
virtio core and drivers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/security/virtio/core.rst

diff --git a/Documentation/security/virtio/core.rst b/Documentation/security/virtio/core.rst
new file mode 100644
index 000000000000..b8baa104d7c8
--- /dev/null
+++ b/Documentation/security/virtio/core.rst
@@ -0,0 +1,49 @@
+================
+Virtio hardening
+================
+
+The virtio core and drivers should not trust the devices. This means
+all kinds of input from the device must be validated before being
+used. This document summarizes the current status and TODO for this
+validation/hardening efforts.
+
+
+Status
+======
+
+The virtio core and drivers has done some basic hardening:
+
+* Config callback hardening: The core makes sure the config interrupt
+  callbacks are enabled after the driver is ready and disable before
+  the driver is removed.
+
+* Descriptor ring hardening: The metadata of a descriptor were copied
+  and stored in a driver private memory that can not be accessed by the
+  device. The eliminates the device triggerable behaviours through the
+  descriptor ring.
+
+* Device configuration space validation: Some of the virtio drivers
+  validates the fields of device configuration space before try to use
+  them.
+
+
+TODO
+====
+
+* Input buffer length validation: The virtio core needs to validate
+  the input buffer length validation before passing them to individual
+  virtio drivers.
+
+* Virtqueue callback hardening: The virtio core (or with the help of
+  the drivers) should guarantee that the virtqueue callbacks should not
+  be triggered before the driver is ready or after the driver is
+  removed.
+
+* Transport specific data validation: The virtio transport driver should
+  validate the virtio transport specific data provided by the device
+  before trying to use them in the probing.
+
+* Device specific validation: Driver should validate the device specific
+  metadata before being used by a specific subsystem.
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 673b9f9b8d8a..b33cc5c751c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21516,6 +21516,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/ABI/testing/sysfs-class-vduse
 F:	Documentation/devicetree/bindings/virtio/
+F:	Documentation/security/virtio/core.rst
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
 F:	drivers/net/virtio_net.c
-- 
2.25.1

