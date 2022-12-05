Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E864301D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiLES0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiLESZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E99209B0;
        Mon,  5 Dec 2022 10:25:16 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyH5tp/Pq0gmC543I0DDyyPYCvch6CUj56MoZZQE83g=;
        b=24cXOhKLbfVFeQQ4dzJfH8HvvvTpeDYap+kExl/ArXc1Co3rjXokF9041XYPXjSwY01maZ
        hcWG2s1NND3XnrT4tDxJOGkdnVlkEhX6OTIwrqX8KkT75dZg9D3zz6K3fsXrBtV9ABA1dW
        8Mvy6hjWEH/CkD0f/hTzFUkZg8PJvQIHaiSTOzRM5Ggy4FtfQcKyTxojZ10QmmIug9Lfd7
        0c3od/y6U1cScLoEVzqI1FQMllt3quDz4ZGHF9u48yalN4isDJOOzopYtB0qyUKlBB9orX
        Zdbp51y8IN8ByB9h/fzVyBg8Av2At6D5FQaR69KlSS5hr4PWaEbA8mvEgkVquQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyH5tp/Pq0gmC543I0DDyyPYCvch6CUj56MoZZQE83g=;
        b=10xkrbbAjnL++YsanuZ1EY0gm3byEX7jxSekKHuwceiSO5SiK5G3i1F4W6jN8UVwbyW1Sg
        lybkZ9RzuT2FXzAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide msi_desc:: Msi_data
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.385036043@linutronix.de>
References: <20221124232326.385036043@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471316.4906.9836512628781296296.tip-bot2@tip-bot2>
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

Commit-ID:     2f70cc0b67c0d71abd5ffa4a8de33277308c2034
Gitweb:        https://git.kernel.org/tip/2f70cc0b67c0d71abd5ffa4a8de33277308c2034
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:03 +01:00

genirq/msi: Provide msi_desc:: Msi_data

The upcoming support for PCI/IMS requires to store some information related
to the message handling in the MSI descriptor, e.g. PASID or a pointer to a
queue.

Provide a generic storage struct which maps over the existing PCI specific
storage which means the size of struct msi_desc is not getting bigger.

This storage struct has two elements:

  1) msi_domain_cookie
  2) msi_instance_cookie

The domain cookie is going to be used to store domain specific information,
e.g. iobase pointer, data pointer.

The instance cookie is going to be handed in when allocating an interrupt
on an IMS domain so the irq chip callbacks of the IMS domain have the
necessary per vector information available. It also comes in handy when
cleaning up the platform MSI code for wire to MSI bridges which need to
hand down the type information to the underlying interrupt domain.

For the core code the cookies are opaque and meaningless. It just stores
the instance cookie during an allocation through the upcoming interfaces
for IMS and wire to MSI brigdes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.385036043@linutronix.de

---
 include/linux/msi.h     | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/msi_api.h | 17 +++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b5dda4b..dca3b80 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -125,6 +125,38 @@ struct pci_msi_desc {
 	};
 };
 
+/**
+ * union msi_domain_cookie - Opaque MSI domain specific data
+ * @value:	u64 value store
+ * @ptr:	Pointer to domain specific data
+ * @iobase:	Domain specific IOmem pointer
+ *
+ * The content of this data is implementation defined and used by the MSI
+ * domain to store domain specific information which is requried for
+ * interrupt chip callbacks.
+ */
+union msi_domain_cookie {
+	u64	value;
+	void	*ptr;
+	void	__iomem *iobase;
+};
+
+/**
+ * struct msi_desc_data - Generic MSI descriptor data
+ * @dcookie:	Cookie for MSI domain specific data which is required
+ *		for irq_chip callbacks
+ * @icookie:	Cookie for the MSI interrupt instance provided by
+ *		the usage site to the allocation function
+ *
+ * The content of this data is implementation defined, e.g. PCI/IMS
+ * implementations define the meaning of the data. The MSI core ignores
+ * this data completely.
+ */
+struct msi_desc_data {
+	union msi_domain_cookie		dcookie;
+	union msi_instance_cookie	icookie;
+};
+
 #define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
 
 /**
@@ -142,6 +174,7 @@ struct pci_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	PCI specific msi descriptor data
+ * @data:	Generic MSI descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -161,7 +194,10 @@ struct msi_desc {
 	void *write_msi_msg_data;
 
 	u16				msi_index;
-	struct pci_msi_desc		pci;
+	union {
+		struct pci_msi_desc	pci;
+		struct msi_desc_data	data;
+	};
 };
 
 /*
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
index 4cb7f4c..2e4456e 100644
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -19,6 +19,23 @@ enum msi_domain_ids {
 };
 
 /**
+ * union msi_instance_cookie - MSI instance cookie
+ * @value:	u64 value store
+ * @ptr:	Pointer to usage site specific data
+ *
+ * This cookie is handed to the IMS allocation function and stored in the
+ * MSI descriptor for the interrupt chip callbacks.
+ *
+ * The content of this cookie is MSI domain implementation defined.  For
+ * PCI/IMS implementations this could be a PASID or a pointer to queue
+ * memory.
+ */
+union msi_instance_cookie {
+	u64	value;
+	void	*ptr;
+};
+
+/**
  * msi_map - Mapping between MSI index and Linux interrupt number
  * @index:	The MSI index, e.g. slot in the MSI-X table or
  *		a software managed index if >= 0. If negative
