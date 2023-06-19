Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705CD735585
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFSLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjFSLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:12:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928391;
        Mon, 19 Jun 2023 04:12:06 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687173123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNJEUYNaGO3ndcxsqEx3+fRdKWTSJ0HsE326eSb9jdQ=;
        b=IQGhwOSi4DtjxNYzq42oDElp3x+Au/Koo2kIDPkgm3CmbagNgZBjVJ8ZuZS1SKfjrMxIse
        m2Ki1imnxMBaviunDBNQeb77X2nAqhTHYLJ/v1H0gJ18d42MUwr+R5/jgxkRu5kdrYwbZD
        UtLIkxpOBz6ZgnlvQWRfbRiTXd/1BDcjUnAvRrwKUDPUoHCplk1TGLw2ZEgcXzOmHMvjhq
        tzxuBU9HsWi03nIe+PAp+BC0c1AclIS+x1Y6C3dDM33QTigC/FLYzkxP1NAAyiI2foJLIF
        nYl00IT4oKSx8d2NkjbIVrmw3/aRyV3FiH0ekBEWsJBl8nynG/uNZeR05hZGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687173123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNJEUYNaGO3ndcxsqEx3+fRdKWTSJ0HsE326eSb9jdQ=;
        b=3snc5LE2YXLbyZIQFrPN55H+M4yEUnNRSfpkoFalBRlaUk+iP9DAsxEW+n9nv0zo3BxYXL
        Po2LY8W+POKa9VBw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Cache and use GPU node map
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230610210930.174074-1-trix@redhat.com ]>
References: <20230610210930.174074-1-trix@redhat.com ]>
MIME-Version: 1.0
Message-ID: <168717312215.404.10267458336828769262.tip-bot2@tip-bot2>
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

Commit-ID:     4251566ebc1cf95ae26a1e5a24cdac1ac25e942f
Gitweb:        https://git.kernel.org/tip/4251566ebc1cf95ae26a1e5a24cdac1ac25e942f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:37 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jun 2023 13:01:44 +02:00

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

  [ bp: Squash a fix making gpu_node_map static as reported by
        Tom Rix <trix@redhat.com>.
    Link: https://lore.kernel.org/r/20230610210930.174074-1-trix@redhat.com ]

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
index 28155b0..c52834d 100644
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
+static struct local_node_map {
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
