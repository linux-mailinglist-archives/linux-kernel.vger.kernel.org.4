Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B592C717D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjEaKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjEaKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:52:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD2018D;
        Wed, 31 May 2023 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685530332; x=1717066332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pqsDlEASPx4jz3KRXaNiRu4kbcAzzVERkAinCLaGt1U=;
  b=CTrWC3hVqcAA+TkQmY7VqaDckiLqcQ1EfLeocZAPnQzberRO3RtkkZfB
   d5ihaszvmp8yZXFNXlrrP0KotcF1YxMNhMP57zg49I6HniUJ28cWVfG6j
   1bzjB9X5L9sjF3ayDm61ZpyOOG5fXR2+Wi7bKhUVr3oM5y5M3WKl5KhPA
   LZ+KvLLTbWFBvoUP4ydYPbTDpk76YoTV6M7tnVq/WBr5D2fr0PDiWuZqB
   zIsZ2YkS196MbAS6ZrJWrD31B1OV8jNa9lmYGWQEDnp1mw1P/9u5fDnY3
   GVJC4H1b55pj+QsPkF/DGfCyrT6CniaupRNSpcMM/HhiQIwaj0YOV38Yf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420966029"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="420966029"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="736625041"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="736625041"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 03:52:10 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v6] usb: typec: intel_pmc_mux: Expose IOM port status to debugfs
Date:   Wed, 31 May 2023 16:20:50 +0530
Message-Id: <20230531105050.638250-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOM status has a crucial role during debugging to check the
current state of the type-C port.
There are ways to fetch the status, but all those require the
IOM port status offset, which could change with platform.

Make a debugfs directory for intel_pmc_mux and expose the status
under it per port basis.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

v6: Re-work the patch on usb-next

v5: Remove #ifdef macro for the dentry in struct pmc_usb

v4:
1. Maintain a root directory for PMC module and incorporate devices
under it
2. Add the debugfs module under '/sys/kernel/debug/usb'
3. Use the platform device 'pmc->dev' to assign the device's name

v3: Allocate the debugfs directory name for the platform device with
its ACPI dev name included

v2:
1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
2. Remove explicitly defined one-liner functions

 drivers/usb/typec/mux/intel_pmc_mux.c | 52 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index e049eadb591e..5e8edf3881c0 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,6 +15,8 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
+#include <linux/debugfs.h>
+#include <linux/usb.h>
 
 #include <asm/intel_scu_ipc.h>
 
@@ -143,8 +145,12 @@ struct pmc_usb {
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
+
+	struct dentry *dentry;
 };
 
+static struct dentry *pmc_mux_debugfs_root;
+
 static void update_port_status(struct pmc_usb_port *port)
 {
 	u8 port_num;
@@ -639,6 +645,29 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 	return 0;
 }
 
+static int port_iom_status_show(struct seq_file *s, void *unused)
+{
+	struct pmc_usb_port *port = s->private;
+
+	update_port_status(port);
+	seq_printf(s, "0x%08x\n", port->iom_status);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(port_iom_status);
+
+static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port)
+{
+	struct dentry *debugfs_dir;
+	char name[6];
+
+	snprintf(name, sizeof(name), "port%d", port->usb3_port - 1);
+
+	debugfs_dir = debugfs_create_dir(name, port->pmc->dentry);
+	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
+			    &port_iom_status_fops);
+}
+
 static int pmc_usb_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *fwnode = NULL;
@@ -674,6 +703,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pmc->dentry = debugfs_create_dir(dev_name(pmc->dev), pmc_mux_debugfs_root);
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -688,6 +719,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
 		}
+
+		pmc_mux_port_debugfs_init(&pmc->port[i]);
 	}
 
 	platform_set_drvdata(pdev, pmc);
@@ -703,6 +736,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_remove(pmc->dentry);
+
 	return ret;
 }
 
@@ -718,6 +753,8 @@ static void pmc_usb_remove(struct platform_device *pdev)
 	}
 
 	acpi_dev_put(pmc->iom_adev);
+
+	debugfs_remove(pmc->dentry);
 }
 
 static const struct acpi_device_id pmc_usb_acpi_ids[] = {
@@ -735,7 +772,20 @@ static struct platform_driver pmc_usb_driver = {
 	.remove_new = pmc_usb_remove,
 };
 
-module_platform_driver(pmc_usb_driver);
+static int __init pmc_usb_init(void)
+{
+	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", usb_debug_root);
+
+	return platform_driver_register(&pmc_usb_driver);
+}
+module_init(pmc_usb_init);
+
+static void __exit pmc_usb_exit(void)
+{
+	platform_driver_unregister(&pmc_usb_driver);
+	debugfs_remove(pmc_mux_debugfs_root);
+}
+module_exit(pmc_usb_exit);
 
 MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1

