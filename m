Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A10637863
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKXMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKXMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C315132E;
        Thu, 24 Nov 2022 04:02:56 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kahsRHtayEqdmhARsEXDF6RBu6DXaA/SwKuAQAa7cl8=;
        b=lO72XljRwDZ1xu7Jcz3rHZaROcSHqCZOm0RuZZPdgAPJKxOV8bRaWOEkauIUpBNyDJ1cJR
        ldzF04dlW0KQd7cXURXXYtyyWatA0bM+0pVEEh5nKoBQ1hw7nmRSwnKY+MbXWGFz1T9WYG
        aefcZ8JTaw7hZ4YZkqHWi/m98npNM2TxSq/C8mwD0ZIVjiXxrmaWD70GtasI/W5nNSu5xt
        EBbTU0WzkHphQm2ZDxtLqnd14og6sWtT0xCGaw2ib2JvL+rrAEEoal0e9XN7Toelbh+Jk1
        jp4UenxDGYSU2vdPOqnLAHvpnWXITAK2a15t6fCG8AlQMGi+rr6q1L9YfOrN/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kahsRHtayEqdmhARsEXDF6RBu6DXaA/SwKuAQAa7cl8=;
        b=bDamBATxax6Zn6TvTth9Ydqk9QFpue/hTxTpgiaAqrUISW8hPWn/fJwC5XuiKrgjj23oFJ
        HNg3ZWI5jaYaP2Cw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable UPI topology discovery
 for Icelake Server
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-9-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-9-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137372.4906.12604606874999833404.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f680b6e6062ef3c944ffc966d685f067958fca33
Gitweb:        https://git.kernel.org/tip/f680b6e6062ef3c944ffc966d685f067958fca33
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:30 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:23 +01:00

perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server

UPI topology discovery relies on data from KTILP0 (offset 0x94) and
KTIPCSTS (offset 0x120) as well as on SKX but on Icelake Server these
registers reside under UBOX (Device ID 0x3450) bus.

This patch enables /sys/devices/uncore_upi_*/die* attributes on Icelake
Server.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-9-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 75 +++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6da5f69..d45f584 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -445,6 +445,7 @@
 #define ICX_UPI_PCI_PMON_CTR0			0x320
 #define ICX_UPI_PCI_PMON_BOX_CTL		0x318
 #define ICX_UPI_CTL_UMASK_EXT			0xffffff
+#define ICX_UBOX_DID				0x3450
 
 /* ICX M3UPI*/
 #define ICX_M3UPI_PCI_PMON_CTL0			0xd8
@@ -5594,6 +5595,76 @@ static const struct attribute_group icx_upi_uncore_format_group = {
 	.attrs = icx_upi_uncore_formats_attr,
 };
 
+#define ICX_UPI_REGS_ADDR_DEVICE_LINK0	0x02
+#define ICX_UPI_REGS_ADDR_FUNCTION	0x01
+
+static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, int dev_link0)
+{
+	struct pci_dev *ubox = NULL;
+	struct pci_dev *dev = NULL;
+	u32 nid, gid;
+	int i, idx, ret = -EPERM;
+	struct intel_uncore_topology *upi;
+	unsigned int devfn;
+
+	/* GIDNIDMAP method supports machines which have less than 8 sockets. */
+	if (uncore_max_dies() > 8)
+		goto err;
+
+	while ((ubox = pci_get_device(PCI_VENDOR_ID_INTEL, ubox_did, ubox))) {
+		ret = upi_nodeid_groupid(ubox, SKX_CPUNODEID, SKX_GIDNIDMAP, &nid, &gid);
+		if (ret) {
+			ret = pcibios_err_to_errno(ret);
+			break;
+		}
+
+		for (i = 0; i < 8; i++) {
+			if (nid != GIDNIDMAP(gid, i))
+				continue;
+			for (idx = 0; idx < type->num_boxes; idx++) {
+				upi = &type->topology[nid][idx];
+				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
+				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
+								  ubox->bus->number,
+								  devfn);
+				if (dev) {
+					ret = upi_fill_topology(dev, upi, idx);
+					if (ret)
+						goto err;
+				}
+			}
+		}
+	}
+err:
+	pci_dev_put(ubox);
+	pci_dev_put(dev);
+	return ret;
+}
+
+static int icx_upi_get_topology(struct intel_uncore_type *type)
+{
+	return discover_upi_topology(type, ICX_UBOX_DID, ICX_UPI_REGS_ADDR_DEVICE_LINK0);
+}
+
+static struct attribute_group icx_upi_mapping_group = {
+	.is_visible	= skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *icx_upi_attr_update[] = {
+	&icx_upi_mapping_group,
+	NULL
+};
+
+static int icx_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &icx_upi_mapping_group);
+}
+
+static void icx_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &icx_upi_mapping_group);
+}
+
 static struct intel_uncore_type icx_uncore_upi = {
 	.name		= "upi",
 	.num_counters   = 4,
@@ -5606,6 +5677,10 @@ static struct intel_uncore_type icx_uncore_upi = {
 	.box_ctl	= ICX_UPI_PCI_PMON_BOX_CTL,
 	.ops		= &skx_upi_uncore_pci_ops,
 	.format_group	= &icx_upi_uncore_format_group,
+	.attr_update	= icx_upi_attr_update,
+	.get_topology	= icx_upi_get_topology,
+	.set_mapping	= icx_upi_set_mapping,
+	.cleanup_mapping = icx_upi_cleanup_mapping,
 };
 
 static struct event_constraint icx_uncore_m3upi_constraints[] = {
