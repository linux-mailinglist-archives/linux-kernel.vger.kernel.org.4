Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC816D021D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC3KuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjC3Ktx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:49:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8D93C0;
        Thu, 30 Mar 2023 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680173356; x=1711709356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pg3OR5f2IuuZ6wVtG+jyKyGmKCMM/ZwdMBOOfAhqvnU=;
  b=jExnIkiNm1JhEinKnS9Fece3xk+R+DV6vHfNF6mt8g2/YLtaxv6+lBv5
   BUHxRRDDreHJ1jdHNgAyhp08MM6DGJA3RLeEI72ucXfuhYLa34u9A+88+
   dnagWW1nyiyqGv4UH/opxWV7LQl3u8dqP8UFvhyUDs29I88EiaPfObv6W
   8pKwdBybenMtpb99/dXaDm9+MrIqx4X/IUyrgelPLRaqIi+26V63FouML
   sfAZwEi6h/HHOUJmUAxZax8J5XVfblw83TVpeccqgIBf7rMScP0DXGtAI
   C6valaRQ1fhpbzCCG/OuRGe+jeCkoU4xGNQOWipqO6ZNhIiY5t3CmWS2g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="406097336"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="406097336"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014391203"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="1014391203"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:49:13 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] usb: typec: intel_pmc_mux: Expose IOM port status to debugfs
Date:   Thu, 30 Mar 2023 16:18:21 +0530
Message-Id: <20230330104821.773053-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/usb/typec/mux/intel_pmc_mux.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e4188a40ff..c99d20888f5d 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,6 +15,7 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
+#include <linux/debugfs.h>
 
 #include <asm/intel_scu_ipc.h>
 
@@ -145,6 +146,8 @@ struct pmc_usb {
 	u32 iom_port_status_offset;
 };
 
+static struct dentry *pmc_mux_debugfs_root;
+
 static void update_port_status(struct pmc_usb_port *port)
 {
 	u8 port_num;
@@ -639,6 +642,39 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
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
+	debugfs_dir = debugfs_create_dir(name, pmc_mux_debugfs_root);
+	debugfs_create_file("iom_status", 0400, debugfs_dir, port,
+			    &port_iom_status_fops);
+}
+
+static void pmc_mux_debugfs_init(void)
+{
+	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
+}
+
+static void pmc_mux_debugfs_exit(void)
+{
+	debugfs_remove_recursive(pmc_mux_debugfs_root);
+}
+
 static int pmc_usb_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *fwnode = NULL;
@@ -674,6 +710,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pmc_mux_debugfs_init();
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -688,6 +726,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
 		}
+
+		pmc_mux_port_debugfs_init(&pmc->port[i]);
 	}
 
 	platform_set_drvdata(pdev, pmc);
@@ -703,6 +743,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	pmc_mux_debugfs_exit();
+
 	return ret;
 }
 
@@ -719,6 +761,8 @@ static int pmc_usb_remove(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	pmc_mux_debugfs_exit();
+
 	return 0;
 }
 
-- 
2.34.1

