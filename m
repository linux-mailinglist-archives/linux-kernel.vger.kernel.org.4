Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7DC694101
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBMJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBMJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F03A15C9C;
        Mon, 13 Feb 2023 01:25:06 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9733420C8B78;
        Mon, 13 Feb 2023 01:25:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9733420C8B78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676280305;
        bh=udNfQxhrzm6ZiBM4Ul0LOy1eV94C7n6f1u452pJAl34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhhhUctoqB4JMn3JG6BfJBXEkobt/MxJ3r46mCeKrkjvDCKU9SDmYnrU5nTa+w1Uq
         fxfwaSKKB1+8ApAP7pB6Zd0Y5Hf2OdMvxJ45VQXouqyCq5JsNnEXhK9pYYzL8G9t/1
         AGkn6giXzN3jSS9oV9AjbLIo7vXPBAfdxt17e6LY=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 8/8] crypto: ccp - Allow platform device to be psp master device
Date:   Mon, 13 Feb 2023 09:24:29 +0000
Message-Id: <20230213092429.1167812-9-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
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

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-dev.c      | 59 ++++++++++++++++++++++++++++++++
 drivers/crypto/ccp/sp-dev.h      |  4 +++
 drivers/crypto/ccp/sp-pci.c      | 48 --------------------------
 drivers/crypto/ccp/sp-platform.c |  6 ++++
 4 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 4c9f442b8a11..71461dfdfa4f 100644
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
index 792d6da7f0c0..f9be8aba0acf 100644
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
2.25.1

