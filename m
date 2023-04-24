Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281696E953A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDTNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDTNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:00:35 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4340C6;
        Thu, 20 Apr 2023 06:00:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 65C3F41D91;
        Thu, 20 Apr 2023 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681995632;
        bh=bSDqyUQmDXJf+AsjkLS1M/z8VFy5Mn2It7eZMkd0OPE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p7H5vlhDlTiPjwhzZY91SmcaoJ9lPbMMCGWBV8Uyejhok0CVyMZhTZ1QvVSCKuYDa
         jk4Zcw/LCmIR+ETVYCe2f+MbxddgOHpGpbLevxVR7TC98oMr/AmAHvi0P2qpMmiPUq
         Lnn72GIR6eGx0bqn4DsRXasFHU9eLkcn4cmbQajr2LRLubF8MP5h4bZlnORRbEW72F
         2zwJfNv48/aIfKW7dSNxfxv29xZzdZiREhFTTCZr8EeJG2aKTmXN3XiMzGjA9xzhYZ
         3UnnMnUx8zGeUjI6rDRuDz+b2PgKQubozVla4YqXGl/+URDgWywNQISNKeFWWNpqXb
         jPxMpvhfz1bBg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] PCI/AER: Factor out interrupt toggling into helpers
Date:   Thu, 20 Apr 2023 20:59:38 +0800
Message-Id: <20230420125941.333675-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420125941.333675-1-kai.heng.feng@canonical.com>
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many places that enable and disable AER interrput, so move
them into helpers.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Correct subject.

v2:
 - New patch.

 drivers/pci/pcie/aer.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..1420e1f27105 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1227,6 +1227,28 @@ static irqreturn_t aer_irq(int irq, void *context)
 	return IRQ_WAKE_THREAD;
 }
 
+static void aer_enable_irq(struct pci_dev *pdev)
+{
+	int aer = pdev->aer_cap;
+	u32 reg32;
+
+	/* Enable Root Port's interrupt in response to error messages */
+	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+}
+
+static void aer_disable_irq(struct pci_dev *pdev)
+{
+	int aer = pdev->aer_cap;
+	u32 reg32;
+
+	/* Disable Root's interrupt in response to error messages */
+	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+}
+
 /**
  * aer_enable_rootport - enable Root Port's interrupts when receiving messages
  * @rpc: pointer to a Root Port data structure
@@ -1256,10 +1278,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
 
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	aer_enable_irq(pdev);
 }
 
 /**
@@ -1274,10 +1293,7 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	int aer = pdev->aer_cap;
 	u32 reg32;
 
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	aer_disable_irq(pdev);
 
 	/* Clear Root's error status reg */
 	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
@@ -1372,12 +1388,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	 */
 	aer = root ? root->aer_cap : 0;
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
-		/* Disable Root's interrupt in response to error messages */
-		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
-	}
+	if ((host->native_aer || pcie_ports_native) && aer)
+		aer_disable_irq(root);
 
 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
 		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
@@ -1396,10 +1408,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
 
-		/* Enable Root Port's interrupt in response to error messages */
-		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		aer_enable_irq(root);
 	}
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
-- 
2.34.1

