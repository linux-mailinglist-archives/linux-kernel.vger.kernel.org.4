Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1A6AF837
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCGWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCGWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:06:39 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68011AA72E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:38 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h3so14674911lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1678226796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDIutQ53mBRDsg+BgyD0r3uvxZK61WGjsYpZHOs9QVY=;
        b=fyh4dk+/XIG1eH0RHQnvJ45ZxvosScdoT6zZGl1PO6ZCnzKwtEtQ9jiibmT233dIkf
         mDJWAeZdG8tQJsEMwbd5s/tzG/pSNUVuYby4bSTi2e4d5WlYhPsVpAZ4d5sJ0fkgYXhI
         RT+1sLn9XeuEO0iedmMwnYFVXIPHH/xzh/58MY4hqRtvRHc9NgYp2S7PhJ1orAkgaB/S
         eYR4Xh49P+855+6/z8kF1pRlUi5dFt9kZ+J0c5ITYQQWefAlWrQ+kdcts0ahJnqEI+yC
         WpW7cGL3nOSyKxwImfMAkJ/TZwzmtQQAxiPA+ozvnkn3wp5YmsTnvBZThKDcmtxefdos
         7tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDIutQ53mBRDsg+BgyD0r3uvxZK61WGjsYpZHOs9QVY=;
        b=XsCD3a+gG0dG8nJrEdgS27mMNqnYz59p3+ewQl/HED2iBuUql+LC0u8OI3pHjRnAXf
         wvoQgxzls81QDnwdfvCiiYtlMr2a2VFu+8BmVwdCAYgak3Lu0QAoM2uMEshKtWC79yXO
         1dgH/zgl5/n7LmQLUGekIh55BBnHK1Vi39/OD8H9NMkaQxJNen/Gd8Dt4lxHsdPiptit
         UlQtKQDoJ47EZdespu3QB9+mxYpfl72ZnRfXbXBbYfZCDLxhMxD79T8MWcHF8GmZnxnX
         bpcq+xqHV2N9oQkli4j/dJHu2uvg6xiGM7g29oCUnRGC9lbO1XD0gm/HEQkxWUYovm+d
         wgaw==
X-Gm-Message-State: AO0yUKVTEToY6rVsMGhoihY1nJc2wQZvuhryICjA9xDJva4K0Uz1FXj8
        bY4lHATVp3wHfsIar2WwsDsjsvn+aakF0ai8EgA=
X-Google-Smtp-Source: AK7set+ElbRCbXgrI0tcj0afkaezzgMwa+Kd3FCi64LHBz1yQTPMQbv+1Sk9qmnjb6Fil64GRa/UWg==
X-Received: by 2002:a05:651c:14f:b0:295:a8e6:6b15 with SMTP id c15-20020a05651c014f00b00295a8e66b15mr3691915ljd.4.1678226796197;
        Tue, 07 Mar 2023 14:06:36 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e9d4d000000b00295965f7495sm2322996ljj.0.2023.03.07.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:06:34 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        upstream@semihalf.com, dtor@google.com, jgg@ziepe.ca,
        kevin.tian@intel.com, cohuck@redhat.com, abhsahu@nvidia.com,
        yishaih@nvidia.com, yi.l.liu@intel.com, kvm@vger.kernel.org,
        Dominik Behr <dbehr@chromium.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH] vfio/pci: Propagate ACPI notifications to the user-space
Date:   Tue,  7 Mar 2023 22:05:53 +0000
Message-Id: <20230307220553.631069-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Behr <dbehr@chromium.org>

Hitherto there was no support for propagating ACPI notifications to the
guest drivers. In order to provide such support, install a handler for
notifications on an ACPI device during vfio-pci device registration. The
handler role is to propagate such ACPI notifications to the user-space
via acpi netlink events, which allows VMM to receive and propagate them
further to the VMs.

Thanks to the above, the actual driver for the pass-through device,
which belongs to the guest, can receive and react to device specific
notifications.

Signed-off-by: Dominik Behr <dbehr@chromium.org>
Co-developed-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a5ab416cf476..92b8ed8d087c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/aperture.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
@@ -2120,10 +2121,20 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_release_dev);
 
+static void vfio_pci_core_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct vfio_pci_core_device *vdev = (struct vfio_pci_core_device *)data;
+	struct device *dev = &vdev->pdev->dev;
+
+	acpi_bus_generate_netlink_event("vfio_pci", dev_name(dev), event, 0);
+}
+
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 {
+	acpi_status status;
 	struct pci_dev *pdev = vdev->pdev;
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	int ret;
 
 	/* Drivers must set the vfio_pci_core_device to their drvdata */
@@ -2201,8 +2212,24 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	ret = vfio_register_group_dev(&vdev->vdev);
 	if (ret)
 		goto out_power;
+
+	if (!adev) {
+		pci_info(pdev, "No ACPI companion");
+		return 0;
+	}
+
+	status = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					vfio_pci_core_acpi_notify, (void *)vdev);
+
+	if (ACPI_FAILURE(status)) {
+		pci_err(pdev, "Failed to install notify handler");
+		goto out_group_register;
+	}
+
 	return 0;
 
+out_group_register:
+	vfio_unregister_group_dev(&vdev->vdev);
 out_power:
 	if (!disable_idle_d3)
 		pm_runtime_get_noresume(dev);
@@ -2216,6 +2243,12 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_register_device);
 
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&vdev->pdev->dev);
+
+	if (adev)
+		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					   vfio_pci_core_acpi_notify);
+
 	vfio_pci_core_sriov_configure(vdev, 0);
 
 	vfio_unregister_group_dev(&vdev->vdev);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

