Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA49643053
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiLES23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEA2124A;
        Mon,  5 Dec 2022 10:25:21 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiTByw1Orxq+AsvJlVZrlf8m5TEOn18a/SBeqPXSEw0=;
        b=TBX+EEnQaUlh4bA3PttdDN8hN6+U6symYFZ0hDXUbtO+2NT+ZDHCE4qawa56Au4GFI4Mog
        KMlGRouf8BmP/jH9hZ0sYs+L3Gtxhk+1vWHQtz0Gy7dpoNhu8tx77bLFRJgxSrOxigdqNY
        HJRTlMhXGV8iA9g4tp67TiddwoWvjFaBzpYMu+fw1ugcUYOVt5wP2AsqrkwpiHO4vH3t3Y
        YvBgBXuuD622uUEMJCzzvMyCIJAXD7/LWcwc9x2PXaJi3Khb3+RLeKRw7mlgkPr7SjEd5s
        qFrTIU6QrqJcnoPxIo961IE7iOagGfy0BadSYI6GJk8Guoc8b7+e2ZWfkGu6Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiTByw1Orxq+AsvJlVZrlf8m5TEOn18a/SBeqPXSEw0=;
        b=R1GPAj4NxKgZUt/lZorF2Z5MvUl9+K4CzOW2Xfp79c1WEuTca/YLjVk2IF/I6VsAoudhGm
        4vR+M6/5iLL0LGAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make descriptor allocation device domain aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.163043028@linutronix.de>
References: <20221124230314.163043028@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471945.4906.11342802513280962827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fc8ab388325ddfd848d00f3a3383b4304594546a
Gitweb:        https://git.kernel.org/tip/fc8ab388325ddfd848d00f3a3383b4304594546a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Make descriptor allocation device domain aware

Change the descriptor allocation and insertion functions to take a domain
id to prepare for the upcoming multi MSI domain per device support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.163043028@linutronix.de

---
 include/linux/msi.h | 16 +++++++++++++++-
 kernel/irq/msi.c    | 20 ++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index f8ba85a..35e9d00 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -286,7 +286,21 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 }
 #endif
 
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc);
+/**
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the
+ *			 default irqdomain and insert it at @init_desc->msi_index
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static inline int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
+}
+
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 33b8a6c..e75b07f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -39,7 +39,7 @@ static inline int msi_sysfs_create_group(struct device *dev);
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
-					const struct irq_affinity_desc *affinity)
+				       const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 
@@ -64,9 +64,10 @@ static void msi_free_desc(struct msi_desc *desc)
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
+static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc,
+			   unsigned int domid, unsigned int index)
 {
-	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
+	struct xarray *xa = &md->__domains[domid].store;
 	int ret;
 
 	desc->msi_index = index;
@@ -77,15 +78,17 @@ static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, un
 }
 
 /**
- * msi_insert_msi_desc - Allocate and initialize a MSI descriptor and
- *			 insert it at @init_desc->msi_index
+ * msi_domain_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *				insert it at @init_desc->msi_index
  *
  * @dev:	Pointer to the device for which the descriptor is allocated
+ * @domid:	The id of the interrupt domain to which the desriptor is added
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
 
@@ -97,7 +100,8 @@ int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
 
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
-	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
+
+	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
 }
 
 /**
@@ -120,7 +124,7 @@ static int msi_add_simple_msi_descs(struct device *dev, unsigned int index, unsi
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, idx);
+		ret = msi_insert_desc(dev->msi.data, desc, MSI_DEFAULT_DOMAIN, idx);
 		if (ret)
 			goto fail;
 	}
