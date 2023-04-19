Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040FA6E7A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjDSNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjDSNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:04:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD855FC7;
        Wed, 19 Apr 2023 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681909466; x=1713445466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BML7/b8TDUo80CIXFv+vU4FWN/NIrn3/77zbgYSC9CA=;
  b=HEUmeeXnec5AHuXIoFbbZf/nDLxpoecWy5bQRd9KlMvY2FqijfZV9sZl
   hLrfRrAymvwu3HexuHZjzDfNbZuzmRryvPpc1wmqSp4kTy4rJLpw3Xavr
   rVBC2CPxKAeEumcGkJkvQ/kHxU/OkAHCHOqepcSH617q3EM1L6thpg5Zm
   vY4627Jf6ZHvKU3FH5iKoxnQLu7HHKyGdNqrSyox1CVQtbaVXX2eMS4sM
   aawrLEdFUzfQiX96vnTsJnPIjFHlnzZY8FRhgxMh2t8hjoEf9m0YjgEE7
   ckkquR4uI4taEcA2pWKO6ccjCCY+oU2JRHU35XDwB/0Ufc3mR7WwSn0mx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431716461"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431716461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="641749474"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="641749474"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:04:25 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v3] usb: typec: intel_pmc_mux: Expose IOM port status to debugfs
Date:   Wed, 19 Apr 2023 18:33:45 +0530
Message-Id: <20230419130345.1689915-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---

v3: Allocate the debugfs directory name for the platform device with
its ACPI dev name included

v2:
1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
2. Remove explicitly defined one-liner functions

 drivers/usb/typec/mux/intel_pmc_mux.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e4188a40ff..2264b8dd5436 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,6 +15,7 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
+#include <linux/debugfs.h>
 
 #include <asm/intel_scu_ipc.h>
 
@@ -143,6 +144,10 @@ struct pmc_usb {
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
 	u32 iom_port_status_offset;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
 
 static void update_port_status(struct pmc_usb_port *port)
@@ -639,10 +644,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
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
 	struct pmc_usb *pmc;
+	char name[NAME_MAX];
 	int i = 0;
 	int ret;
 
@@ -674,6 +703,9 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	snprintf(name, NAME_MAX, "intel_pmc_mux-%s", pdev->name);
+	pmc->dentry = debugfs_create_dir(name, NULL);
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -688,6 +720,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
 		}
+
+		pmc_mux_port_debugfs_init(&pmc->port[i]);
 	}
 
 	platform_set_drvdata(pdev, pmc);
@@ -703,6 +737,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_remove(pmc->dentry);
+
 	return ret;
 }
 
@@ -719,6 +755,8 @@ static int pmc_usb_remove(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_remove(pmc->dentry);
+
 	return 0;
 }
 
-- 
2.34.1

