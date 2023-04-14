Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61D6E1DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDNITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjDNITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:19:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590330C4;
        Fri, 14 Apr 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460382; x=1712996382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z135BJM0WTm/8JKwrFBhTuBcWJHalDnImuqqKXx6vwU=;
  b=MjZXY82xsjru8rokraaQ3JdoSfQDTaQsIY5CsCpHyt90ewAc8hEyCc1J
   ymBUYayfkX5ffBALzCdd1QIh/onvCYRIWnf/9AnJ5Msxi85eMvCUz6mSK
   ekybyyXDL6+jUCcRmLrb5G1B1XLRhwfvorw5OtRaaswYwyuCyObOia3nO
   r0dyIiSDX5Amw4nz1KX/+ALeNmG9wuy+CjJnhzeD3h3N45KZdd6rAdIfD
   TdbD0Rr38OAfzMdGEfCw8hPULT76XJyP3z9uuxUIZriyo66lPHpAYvBAd
   n/euGLaBTwvEAY41KWsxu/ZnSOmr+OJ4NS/prEdVWL4laxDCRfGyWbXKY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="343171472"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="343171472"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="754376594"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="754376594"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:19:40 -0700
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH v2] usb: typec: intel_pmc_mux: Expose IOM port status to debugfs
Date:   Fri, 14 Apr 2023 13:49:10 +0530
Message-Id: <20230414081910.1336405-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
---

v2:
1. Remove static declaration of the debugfs root for 'intel_pmc_mux'
2. Remove explicitly defined one-liner functions

 drivers/usb/typec/mux/intel_pmc_mux.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e4188a40ff..1d43b111781e 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -15,6 +15,7 @@
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
+#include <linux/debugfs.h>
 
 #include <asm/intel_scu_ipc.h>
 
@@ -639,9 +640,34 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
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
+static void pmc_mux_port_debugfs_init(struct pmc_usb_port *port,
+				      struct dentry *pmc_mux_debugfs_root)
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
 static int pmc_usb_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *fwnode = NULL;
+	struct dentry *pmc_mux_debugfs_root;
 	struct pmc_usb *pmc;
 	int i = 0;
 	int ret;
@@ -674,6 +700,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pmc_mux_debugfs_root = debugfs_create_dir("intel_pmc_mux", NULL);
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -688,6 +716,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 			fwnode_handle_put(fwnode);
 			goto err_remove_ports;
 		}
+
+		pmc_mux_port_debugfs_init(&pmc->port[i], pmc_mux_debugfs_root);
 	}
 
 	platform_set_drvdata(pdev, pmc);
@@ -703,6 +733,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_lookup_and_remove("intel_pmc_mux", NULL);
+
 	return ret;
 }
 
@@ -719,6 +751,8 @@ static int pmc_usb_remove(struct platform_device *pdev)
 
 	acpi_dev_put(pmc->iom_adev);
 
+	debugfs_lookup_and_remove("intel_pmc_mux", NULL);
+
 	return 0;
 }
 
-- 
2.34.1

