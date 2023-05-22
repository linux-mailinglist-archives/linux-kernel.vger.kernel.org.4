Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5470B5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjEVHHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjEVHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:07:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE07D132;
        Mon, 22 May 2023 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684739086; x=1716275086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MJMdLtpSZ8OOaP7IC28AeQPnd3yuhxNo98W2UU557ok=;
  b=nhtlQGjTSqzCCEtrjSsEpcfD0uOz2VO7Lm9EoL52T/TQHR7SMNmrjiX6
   xKrQe8xjyCqFlAd8CfKSMP9oORetP5SOs8hWYv8GzvSFxhr0O2aIaW5dQ
   7Zhl7HTCVgUDFL9uL0s//NV1S8XHgthFcHr+YLUcSu/AT1an8cVPHiM54
   kujqOpRtS3dNi2RTHpWCLY1CC4k0nXVGddGOTKdciXf/w4bRakZxmFovg
   rSIUymPKwTCn59XmhNmbOO+aQ+1QQav+lAJ4WT9UaoR21QG3MNOQdpvSi
   mtAOFhvm1Gzg9e39ICscaCtWn98otKM33vmt8BwArm1eYHchqr4cwqx29
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337435998"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="337435998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="768404484"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="768404484"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:04:44 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v4] usb: typec: intel_pmc_mux: Expose IOM port status to debugfs
Date:   Mon, 22 May 2023 12:33:43 +0530
Message-Id: <20230522070343.3675581-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/usb/typec/mux/intel_pmc_mux.c | 54 ++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e4188a40ff..f400094c76f2 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,6 +15,8 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
+#include <linux/debugfs.h>
+#include <linux/usb.h>
 
 #include <asm/intel_scu_ipc.h>
 
@@ -143,8 +145,14 @@ struct pmc_usb {
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
 
+static struct dentry *pmc_mux_debugfs_root;
+
 static void update_port_status(struct pmc_usb_port *port)
 {
 	u8 port_num;
@@ -639,6 +647,29 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
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
@@ -674,6 +705,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pmc->dentry = debugfs_create_dir(dev_name(pmc->dev), pmc_mux_debugfs_root);
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -688,6 +721,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
 		}
+
+		pmc_mux_port_debugfs_init(&pmc->port[i]);
 	}
 
 	platform_set_drvdata(pdev, pmc);
@@ -703,6 +738,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_remove(pmc->dentry);
+
 	return ret;
 }
 
@@ -719,6 +756,8 @@ static int pmc_usb_remove(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_remove(pmc->dentry);
+
 	return 0;
 }
 
@@ -737,7 +776,20 @@ static struct platform_driver pmc_usb_driver = {
 	.remove = pmc_usb_remove,
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

