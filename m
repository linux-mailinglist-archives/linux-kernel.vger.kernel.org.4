Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B296C21B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCTTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCTTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:40:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B17CE1E9D4;
        Mon, 20 Mar 2023 12:35:49 -0700 (PDT)
Received: from vm02.corp.microsoft.com (unknown [167.220.197.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7629A20FB405;
        Mon, 20 Mar 2023 12:20:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7629A20FB405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679340034;
        bh=N7X8cpFIpuK4qMY5rWG6YjlSHa36cQnB2pwTMJA8wzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VR8sJxLE8sZRLhaxkiAtc0w04A3OXdj9dLjpLvsbpCig/9VRR4CxLnzKPalpQyOCR
         fmMzzsUj0GGyht2eoewFahA3XRJMkopHgFbwU5GyTmTK5LpfvyjD+4fin+KC5X7jnB
         pLjFJUZqu4AF8X9sCCr3RvoHf77y8p0Hf5yULuF4=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 8/8] crypto: ccp - Allow platform device to be psp master device
Date:   Mon, 20 Mar 2023 19:19:56 +0000
Message-Id: <20230320191956.1354602-9-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the getters/setters to sp-dev.c, so that they can be accessed from
sp-pci.c and sp-platform.c. This makes it possible for the psp
platform_device to set the function pointers and be assigned the role of
master device by psp_dev_init().

While the case of a system having both a PCI and ACPI PSP is not
supported (and not known to occur in the wild), it makes sense to have a
single static global to assign to. Should such a system occur, the logic
in psp_set_master() is that the pci device is preferred.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-dev.c      | 58 ++++++++++++++++++++++++++++++++
 drivers/crypto/ccp/sp-dev.h      |  4 +++
 drivers/crypto/ccp/sp-pci.c      | 48 --------------------------
 drivers/crypto/ccp/sp-platform.c |  6 ++++
 4 files changed, 68 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 4c9f442b8a11..0ac1d0eba8bb 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -14,6 +14,8 @@
 #include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
@@ -39,6 +41,8 @@ static LIST_HEAD(sp_units);
 /* Ever-increasing value to produce unique unit numbers */
 static atomic_t sp_ordinal;
 
+static struct sp_device *sp_dev_master;
+
 static void sp_add_device(struct sp_device *sp)
 {
 	unsigned long flags;
@@ -250,6 +254,60 @@ struct sp_device *sp_get_psp_master_device(void)
 	return ret;
 }
 
+static bool sp_pci_is_master(struct sp_device *sp)
+{
+	struct device *dev_cur, *dev_new;
+	struct pci_dev *pdev_cur, *pdev_new;
+
+	dev_new = sp->dev;
+	dev_cur = sp_dev_master->dev;
+
+	pdev_new = to_pci_dev(dev_new);
+	pdev_cur = to_pci_dev(dev_cur);
+
+	if (pdev_new->bus->number < pdev_cur->bus->number)
+		return true;
+
+	if (PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn))
+		return true;
+
+	if (PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn))
+		return true;
+
+	return false;
+}
+
+void psp_set_master(struct sp_device *sp)
+{
+	struct device *dev_cur, *dev_new;
+
+	if (!sp_dev_master) {
+		sp_dev_master = sp;
+		return;
+	}
+
+	dev_new = sp->dev;
+	dev_cur = sp_dev_master->dev;
+
+	if (dev_is_pci(dev_new) && dev_is_pci(dev_cur) && sp_pci_is_master(sp))
+		sp_dev_master = sp;
+	if (dev_is_pci(dev_new) && dev_is_platform(dev_cur))
+		sp_dev_master = sp;
+}
+
+struct sp_device *psp_get_master(void)
+{
+	return sp_dev_master;
+}
+
+void psp_clear_master(struct sp_device *sp)
+{
+	if (sp == sp_dev_master) {
+		sp_dev_master = NULL;
+		dev_dbg(sp->dev, "Cleared sp_dev_master\n");
+	}
+}
+
 static int __init sp_mod_init(void)
 {
 #ifdef CONFIG_X86
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 20377e67f65d..c05f1fa82ff4 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -129,6 +129,10 @@ int sp_request_psp_irq(struct sp_device *sp, irq_handler_t handler,
 void sp_free_psp_irq(struct sp_device *sp, void *data);
 struct sp_device *sp_get_psp_master_device(void);
 
+void psp_set_master(struct sp_device *sp);
+struct sp_device *psp_get_master(void);
+void psp_clear_master(struct sp_device *sp);
+
 #ifdef CONFIG_CRYPTO_DEV_SP_CCP
 
 int ccp_dev_init(struct sp_device *sp);
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 084d052fddcc..af8f0f65c4b5 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -30,7 +30,6 @@ struct sp_pci {
 	int msix_count;
 	struct msix_entry msix_entry[MSIX_VECTORS];
 };
-static struct sp_device *sp_dev_master;
 
 #define attribute_show(name, def)						\
 static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
@@ -168,53 +167,6 @@ static void sp_free_irqs(struct sp_device *sp)
 	sp->psp_irq = 0;
 }
 
-static bool sp_pci_is_master(struct sp_device *sp)
-{
-	struct device *dev_cur, *dev_new;
-	struct pci_dev *pdev_cur, *pdev_new;
-
-	dev_new = sp->dev;
-	dev_cur = sp_dev_master->dev;
-
-	pdev_new = to_pci_dev(dev_new);
-	pdev_cur = to_pci_dev(dev_cur);
-
-	if (pdev_new->bus->number < pdev_cur->bus->number)
-		return true;
-
-	if (PCI_SLOT(pdev_new->devfn) < PCI_SLOT(pdev_cur->devfn))
-		return true;
-
-	if (PCI_FUNC(pdev_new->devfn) < PCI_FUNC(pdev_cur->devfn))
-		return true;
-
-	return false;
-}
-
-static void psp_set_master(struct sp_device *sp)
-{
-	if (!sp_dev_master) {
-		sp_dev_master = sp;
-		return;
-	}
-
-	if (sp_pci_is_master(sp))
-		sp_dev_master = sp;
-}
-
-static struct sp_device *psp_get_master(void)
-{
-	return sp_dev_master;
-}
-
-static void psp_clear_master(struct sp_device *sp)
-{
-	if (sp == sp_dev_master) {
-		sp_dev_master = NULL;
-		dev_dbg(sp->dev, "Cleared sp_dev_master\n");
-	}
-}
-
 static int sp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct sp_device *sp;
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index be8306c47196..e22d9fee0956 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -234,6 +234,12 @@ static int sp_platform_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, sp);
 
+	if (sp_platform->is_platform_device) {
+		sp->set_psp_master_device = psp_set_master;
+		sp->get_psp_master_device = psp_get_master;
+		sp->clear_psp_master_device = psp_clear_master;
+	}
+
 	ret = sp_init(sp);
 	if (ret)
 		goto e_err;
-- 
2.34.1

