Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C78643050
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLES2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLESZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963121241;
        Mon,  5 Dec 2022 10:25:20 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VCbDHYC0h1HWeZB0XwNXjwos9hg169UHx/EpKhTW+4=;
        b=3PGZ/AvmhlZETjXqshn/ivUf94iSlG3kkDBTPe6Gv5e1aYNs3OxWZSoNk6Gs6e8qeQ2ph1
        IqiFurhEO6srCApqhxygJJGCnBrSs+FlwXOmryoD2i0CdNd3RfOjv8tlf2qhEKwcZe67dQ
        GqUzhA3tsm+m0QkQHknN5Uz8I7+g5Ru5kQcni1gn6fDWYmXUCdxXtGoSDD0mmmOZ/jnnMr
        Q/SonhB3FhQ8W727BA5c9VAqB75d7ZnnxHlGlqsSpytHWUkNRQkPdrnodB/BWAlreAg/nZ
        G+jNCwXl0WpEbN3usbp2SoxZPxXw8D4FhWGQMcTMd9ft2ngMhTAwOuVw701XGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VCbDHYC0h1HWeZB0XwNXjwos9hg169UHx/EpKhTW+4=;
        b=31O4NjlKvnodpevImFgcqYxCVRn7cfW6dcx6ZZahWDQfYfDSfMKCeg524zDo5uqAULuB2L
        ItQtmzSVGcInjYBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Make descriptor freeing domain aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.220788011@linutronix.de>
References: <20221124230314.220788011@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471925.4906.18383633902587163861.tip-bot2@tip-bot2>
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

Commit-ID:     377712c5a45f6de40bffef5ddc31b39cd86cf23f
Gitweb:        https://git.kernel.org/tip/377712c5a45f6de40bffef5ddc31b39cd86cf23f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:59 +01:00

genirq/msi: Make descriptor freeing domain aware

Change the descriptor free functions to take a domain id to prepare for the
upcoming multi MSI domain per device support.

To avoid changing and extending the interfaces over and over use an core
internal control struct and hand the pointer through the various functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.220788011@linutronix.de

---
 include/linux/msi.h | 19 ++++++++++++--
 kernel/irq/msi.c    | 58 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 35e9d00..23172d6 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -301,10 +301,25 @@ static inline int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_
 	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
 }
 
-void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last);
 
 /**
- * msi_free_msi_descs - Free MSI descriptors of a device
+ * msi_free_msi_descs_range - Free a range of MSI descriptors of a device
+ *			      in the default irqdomain
+ *
+ * @dev:	Device for which to free the descriptors
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
+ */
+static inline void msi_free_msi_descs_range(struct device *dev, unsigned int first,
+					    unsigned int last)
+{
+	msi_domain_free_msi_descs_range(dev, MSI_DEFAULT_DOMAIN, first, last);
+}
+
+/**
+ * msi_free_msi_descs - Free all MSI descriptors of a device in the default irqdomain
  * @dev:	Device to free the descriptors
  */
 static inline void msi_free_msi_descs(struct device *dev)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e75b07f..33ababf 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,6 +19,18 @@
 
 #include "internals.h"
 
+/**
+ * struct msi_ctrl - MSI internal management control structure
+ * @domid:	ID of the domain on which management operations should be done
+ * @first:	First (hardware) slot index to operate on
+ * @last:	Last (hardware) slot index to operate on
+ */
+struct msi_ctrl {
+	unsigned int			domid;
+	unsigned int			first;
+	unsigned int			last;
+};
+
 /* Invalid Xarray index which is outside of any searchable range */
 #define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
 /* The maximum domain size */
@@ -151,22 +163,29 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 	return false;
 }
 
-/**
- * msi_free_msi_descs_range - Free MSI descriptors of a device
- * @dev:		Device to free the descriptors
- * @first_index:	Index to start freeing from
- * @last_index:		Last index to be freed
- */
-void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
-			      unsigned int last_index)
+static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
+{
+	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
+			 ctrl->first > ctrl->last ||
+			 ctrl->first > MSI_MAX_INDEX ||
+			 ctrl->last > MSI_MAX_INDEX))
+		return false;
+	return true;
+}
+
+static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
 {
-	struct xarray *xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
+	struct xarray *xa;
 	unsigned long idx;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	xa_for_each_range(xa, idx, desc, first_index, last_index) {
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	xa = &dev->msi.data->__domains[ctrl->domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		xa_erase(xa, idx);
 
 		/* Leak the descriptor when it is still referenced */
@@ -176,6 +195,25 @@ void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
 	}
 }
 
+/**
+ * msi_domain_free_msi_descs_range - Free a range of MSI descriptors of a device in an irqdomain
+ * @dev:	Device for which to free the descriptors
+ * @domid:	Id of the domain to operate on
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
+ */
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+	};
+
+	msi_domain_free_descs(dev, &ctrl);
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;
