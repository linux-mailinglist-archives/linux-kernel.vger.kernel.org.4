Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62072288F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjFEOPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjFEOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308E10EF;
        Mon,  5 Jun 2023 07:14:43 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XALBQt2T10eow7gTU9dXEDATIELffe/oUXyAi3OyFRY=;
        b=szruDV4LC6CbHHbwV4g/9A1Yz+8vFXHuIYVRkEAusHEg1uGZZAEq0ZZI2I4tSJMb7fyx7H
        a9zPirSjlSVdhgHCAX/vP8fFfW5gT0FOu5ol3G93fwRbQL1wNs3B+h7/tnbttwPLw5Mtn1
        RAK/Wx60ak/SEPo9rRqMtrv9zrH+evztoPNLS9u/OfB27I4MCUq8OZa8y/mXzpztmn7qT1
        X8LJn92NHEQx90yXXURtqvU2yhSeyAEZu3FJ8nd8zL4dWUg2QiEDyupmVGIMFyKOXUSHz/
        UmYtRxc/wEP9Gn5IcsM4g9cdbBZa6UOrd8vKt8rjxMcp2OOmu//xDpr1Rhhoag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XALBQt2T10eow7gTU9dXEDATIELffe/oUXyAi3OyFRY=;
        b=BDM5uFeOz70J8MU0YGY0rkdBKflC8lcnSIGJwBA3RAB8F/Vizq1MrTyyRMNJXzJtR6xXph
        66oH5AAjiqOsF8Dw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Cache and use GPU node map
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515113537.1052146-6-muralimk@amd.com>
References: <20230515113537.1052146-6-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <168597448108.404.2973843984211504897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1b474896156b1b30e37dcd1f98e79875cf505090
Gitweb:        https://git.kernel.org/tip/1b474896156b1b30e37dcd1f98e79875cf505090
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:37 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:27:21 +02:00

EDAC/amd64: Cache and use GPU node map

AMD systems have historically provided an "AMD Node ID" that is a unique
identifier for each die in a multi-die package. This was associated with
a unique instance of the AMD Northbridge on a legacy system. And now it
is associated with a unique instance of the AMD Data Fabric on modern
systems. Each instance is referred to as a "Node"; this is an
AMD-specific term not to be confused with NUMA nodes.

The data fabric provides a number of interfaces accessible through a set
of functions in a single PCI device. There is one PCI device per Data
Fabric (AMD Node), and multi-die systems will see multiple such PCI
devices. The AMD Node ID matches a Node's position in the PCI hierarchy.
For example, the Node 0 is accessed using the first PCI device, Node 1
is accessed using the second, and so on. A logical CPU can find its AMD
Node ID using CPUID. Furthermore, the AMD Node ID is used within the
hardware fabric, so it is not purely a logical value.

Heterogeneous AMD systems, with a CPU Data Fabric connected to GPU data
fabrics, follow a similar convention. Each CPU and GPU die has a unique
AMD Node ID value, and each Node ID corresponds to PCI devices in
sequential order.

However, there are two caveats:
1) GPUs are not x86, and they don't have CPUID to read their AMD Node ID
like on CPUs. This means the value is more implicit and based on PCI
enumeration and hardware-specifics.
2) There is a gap in the hardware values for AMD Node IDs. Values 0-7
are for CPUs and values 8-15 are for GPUs.

For example, a system with one CPU die and two GPUs dies will have the
following values:
  CPU0 -> AMD Node 0
  GPU0 -> AMD Node 8
  GPU1 -> AMD Node 9

EDAC is the only subsystem where this has a practical effect. Memory
errors on AMD systems are commonly reported through MCA to a CPU on the
local AMD Node. The error information is passed along to EDAC where the
AMD EDAC modules use the AMD Node ID of reporting logical CPU to access
AMD Node information.

However, memory errors from a GPU die will be reported to the CPU die.
Therefore, the logical CPU's AMD Node ID can't be used since it won't
match the AMD Node ID of the GPU die. The AMD Node ID of the GPU die is
provided as part of the MCA information, and the value will match the
hardware enumeration (e.g. 8-15).

Handle this situation by discovering GPU dies the same way as CPU dies
in the AMD NB code. But do a "node id" fixup in AMD64 EDAC where it's
needed.

The GPU data fabrics provide a register with the base AMD Node ID for
their local "type", i.e. GPU data fabric. This value is the same for all
fabrics of the same type in a system.

Read and cache the base AMD Node ID from one of the GPU devices during
module initialization. Use this to fixup the "node id" when reporting
memory errors at runtime.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-6-muralimk@amd.com
---
 drivers/edac/amd64_edac.c | 76 ++++++++++++++++++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  1 +-
 2 files changed, 77 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 28155b0..ef3e50f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -975,6 +975,74 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/*
+ * See AMD PPR DF::LclNodeTypeMap
+ *
+ * This register gives information for nodes of the same type within a system.
+ *
+ * Reading this register from a GPU node will tell how many GPU nodes are in the
+ * system and what the lowest AMD Node ID value is for the GPU nodes. Use this
+ * info to fixup the Linux logical "Node ID" value set in the AMD NB code and EDAC.
+ */
+struct local_node_map {
+	u16 node_count;
+	u16 base_node_id;
+} gpu_node_map;
+
+#define PCI_DEVICE_ID_AMD_MI200_DF_F1		0x14d1
+#define REG_LOCAL_NODE_TYPE_MAP			0x144
+
+/* Local Node Type Map (LNTM) fields */
+#define LNTM_NODE_COUNT				GENMASK(27, 16)
+#define LNTM_BASE_NODE_ID			GENMASK(11, 0)
+
+static int gpu_get_node_map(void)
+{
+	struct pci_dev *pdev;
+	int ret;
+	u32 tmp;
+
+	/*
+	 * Node ID 0 is reserved for CPUs.
+	 * Therefore, a non-zero Node ID means we've already cached the values.
+	 */
+	if (gpu_node_map.base_node_id)
+		return 0;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F1, NULL);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
+	if (ret)
+		goto out;
+
+	gpu_node_map.node_count = FIELD_GET(LNTM_NODE_COUNT, tmp);
+	gpu_node_map.base_node_id = FIELD_GET(LNTM_BASE_NODE_ID, tmp);
+
+out:
+	pci_dev_put(pdev);
+	return ret;
+}
+
+static int fixup_node_id(int node_id, struct mce *m)
+{
+	/* MCA_IPID[InstanceIdHi] give the AMD Node ID for the bank. */
+	u8 nid = (m->ipid >> 44) & 0xF;
+
+	if (smca_get_bank_type(m->extcpu, m->bank) != SMCA_UMC_V2)
+		return node_id;
+
+	/* Nodes below the GPU base node are CPU nodes and don't need a fixup. */
+	if (nid < gpu_node_map.base_node_id)
+		return node_id;
+
+	/* Convert the hardware-provided AMD Node ID to a Linux logical one. */
+	return nid - gpu_node_map.base_node_id + 1;
+}
+
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
@@ -3001,6 +3069,8 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct err_info err;
 	u64 sys_addr;
 
+	node_id = fixup_node_id(node_id, m);
+
 	mci = edac_mc_find(node_id);
 	if (!mci)
 		return;
@@ -3888,6 +3958,12 @@ static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
 
 static int gpu_hw_info_get(struct amd64_pvt *pvt)
 {
+	int ret;
+
+	ret = gpu_get_node_map();
+	if (ret)
+		return ret;
+
 	pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 	if (!pvt->umc)
 		return -ENOMEM;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index e84fe0d..a9d6290 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mmzone.h>
 #include <linux/edac.h>
+#include <linux/bitfield.h>
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include "edac_module.h"
