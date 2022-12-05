Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E709643044
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLES12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiLESZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A0209A2;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHhj8qArRoE/GaCi87l68Q4zfw3Edt+BSTtfiTr/37I=;
        b=224ItIum4v5/1uWWHliNLW0BsOAcsnugLO06YdJliHzza5I+LVm3txORiBxsQyehMZxaJs
        X+pO7Dc6wN/q5fQBE63vHnR63EBlaGedFc1AGuvhEdqAlPUquilvsKqpYQluE0R8x8/J8X
        4CCi4pOT+f0cgCNoq07YbSkpQsqr1vANrM1JsY48lvaM7ZNKe9VVItU3KCstONYneJSFvh
        04r0bGn59WOp2tG/h3sdMLIT24QhuWJSD7irGX1G3w01VPC8BOZfwDon/PfQkq9NAd6kvJ
        8ErEXZkqwdCp1FwcHdZ8KaNuzgRZHPHDrodzszbyH9Njscvq6DbNCagD5DeqMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHhj8qArRoE/GaCi87l68Q4zfw3Edt+BSTtfiTr/37I=;
        b=4QPIAX9wduFPBOFgPqVFiYzh8iIhYquLhayycvQ30DGWVdHHZEhjdxX1DE3bNsCS8TJbrs
        VqRA82E9vJEicWBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Provide data structs for per device domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.442499757@linutronix.de>
References: <20221124232325.442499757@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471676.4906.14029318671604815488.tip-bot2@tip-bot2>
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

Commit-ID:     ebca4396ee18521e9e5d435a15e5d0ab2eb6b009
Gitweb:        https://git.kernel.org/tip/ebca4396ee18521e9e5d435a15e5d0ab2eb6b009
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:01 +01:00

genirq/msi: Provide data structs for per device domains

Provide struct msi_domain_template which contains a bundle of struct
irq_chip, struct msi_domain_ops and struct msi_domain_info and a name
field.

This template is used by MSI device domain implementations to provide the
domain specific functionality, feature bits etc.

When a MSI domain is created the template is duplicated in the core code
so that it can be modified per instance. That means templates can be
marked const at the MSI device domain code.

The template is a bundle to avoid several allocations and duplications
of the involved structures.

The name field is used to construct the final domain and chip name via:

    $PREFIX$NAME-$DEVNAME

where prefix is the optional prefix of the MSI parent domain, $NAME is the
provided name in template::chip and the device name so that the domain
is properly identified. On x86 this results for PCI/MSI in:

   PCI-MSI-0000:3d:00.1 or IR-PCI-MSIX-0000:3d:00.1

depending on the domain type and the availability of remapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.442499757@linutronix.de

---
 include/linux/msi.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9bf3cba..7fb8737 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -24,6 +24,7 @@
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
+#include <linux/irq.h>
 #include <linux/bits.h>
 
 #include <asm/msi.h>
@@ -74,7 +75,6 @@ struct msi_msg {
 
 extern int pci_msi_ignore_mask;
 /* Helper functions */
-struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
@@ -442,6 +442,20 @@ struct msi_domain_info {
 	void				*data;
 };
 
+/**
+ * struct msi_domain_template - Template for MSI device domains
+ * @name:	Storage for the resulting name. Filled in by the core.
+ * @chip:	Interrupt chip for this domain
+ * @ops:	MSI domain ops
+ * @info:	MSI domain info data
+ */
+struct msi_domain_template {
+	char			name[48];
+	struct irq_chip		chip;
+	struct msi_domain_ops	ops;
+	struct msi_domain_info	info;
+};
+
 /*
  * Flags for msi_domain_info
  *
