Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DA657FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiL1QIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiL1QHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735E119027
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7346156E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F7C433EF;
        Wed, 28 Dec 2022 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243653;
        bh=nRJwBEWvFJN+dy8euaBYjUka6CoykZ68avfIUWfpFVU=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5U/GZTurmrg7YNyxSsRNVVjVdjWhk8EgRA9F+jI4c/Sx/OPoEYD1BEwEWc7zhLoJ
         JxI1wM/gKSD0Eqr0Q6RkD/uUGFrIcd3orv74sJ+5qmWbBWnKfAILz6E6we1cx58GAn
         EJqPdRPKnGzTMk4kUBh9fxHGWNtSMYOa/2asVH11LfqmTXEUwJGpaT4WIs5Pi06Ktq
         3wJ6i0W5czzbCFSyZPpCvL46r4AUCFmUewCNvSlGaDkZbK4D0M9Dh2spihswU6Y/Ov
         vwxDFplYbYHj/fX5tKpSTNXSe0ilIhlZYwMu24IsOr9frZK6dtj31ZRWEApamTcBcS
         7FFb71sSc4x8Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/9] habanalabs: add uapi to flush inbound HBM transactions
Date:   Wed, 28 Dec 2022 18:07:15 +0200
Message-Id: <20221228160723.387-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When doing p2p with a NIC device, the NIC needs to make sure all the
writes to the HBM (through the PCI bar of the Gaudi device) were
flushed.

It can be done by either the NIC or the host reading through the PCI
bar.

To support the host side, we supply a simple uapi to perform this flush
through the driver, because the user can't create such a transaction
by itself (the PCI bar isn't exposed to normal users).

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 23 ++++++++++++++++++-
 drivers/accel/habanalabs/common/habanalabs.h  |  6 ++++-
 drivers/accel/habanalabs/gaudi/gaudi.c        |  2 ++
 drivers/accel/habanalabs/gaudi2/gaudi2.c      |  2 ++
 .../include/gaudi/asic_reg/gaudi_regs.h       |  2 ++
 include/uapi/drm/habanalabs_accel.h           |  8 +++++++
 6 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index f6ee10334235..bb9584d72c32 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -13,7 +13,8 @@
 
 #define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
 			HL_CS_FLAGS_COLLECTIVE_WAIT | HL_CS_FLAGS_RESERVE_SIGNALS_ONLY | \
-			HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY | HL_CS_FLAGS_ENGINE_CORE_COMMAND)
+			HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY | HL_CS_FLAGS_ENGINE_CORE_COMMAND | \
+			HL_CS_FLAGS_FLUSH_PCI_HBW_WRITES)
 
 
 #define MAX_TS_ITER_NUM 10
@@ -1295,6 +1296,8 @@ static enum hl_cs_type hl_cs_get_cs_type(u32 cs_type_flags)
 		return CS_UNRESERVE_SIGNALS;
 	else if (cs_type_flags & HL_CS_FLAGS_ENGINE_CORE_COMMAND)
 		return CS_TYPE_ENGINE_CORE;
+	else if (cs_type_flags & HL_CS_FLAGS_FLUSH_PCI_HBW_WRITES)
+		return CS_TYPE_FLUSH_PCI_HBW_WRITES;
 	else
 		return CS_TYPE_DEFAULT;
 }
@@ -2443,6 +2446,21 @@ static int cs_ioctl_engine_cores(struct hl_fpriv *hpriv, u64 engine_cores,
 	return rc;
 }
 
+static int cs_ioctl_flush_pci_hbw_writes(struct hl_fpriv *hpriv)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	if (!prop->hbw_flush_reg) {
+		dev_dbg(hdev->dev, "HBW flush is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	RREG32(prop->hbw_flush_reg);
+
+	return 0;
+}
+
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cs_args *args = data;
@@ -2499,6 +2517,9 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		rc = cs_ioctl_engine_cores(hpriv, args->in.engine_cores,
 				args->in.num_engine_cores, args->in.core_command);
 		break;
+	case CS_TYPE_FLUSH_PCI_HBW_WRITES:
+		rc = cs_ioctl_flush_pci_hbw_writes(hpriv);
+		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
 						args->in.cs_flags,
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 7b6f10033ee9..95bbc00c6262 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -375,7 +375,8 @@ enum hl_cs_type {
 	CS_TYPE_COLLECTIVE_WAIT,
 	CS_RESERVE_SIGNALS,
 	CS_UNRESERVE_SIGNALS,
-	CS_TYPE_ENGINE_CORE
+	CS_TYPE_ENGINE_CORE,
+	CS_TYPE_FLUSH_PCI_HBW_WRITES,
 };
 
 /*
@@ -644,6 +645,8 @@ struct hl_hints_range {
  *                                      (i.e. the DRAM supports multiple page sizes), otherwise
  *                                      it will shall  be equal to dram_page_size.
  * @num_engine_cores: number of engine cpu cores
+ * @hbw_flush_reg: register to read to generate HBW flush. value of 0 means HBW flush is
+ *                 not supported.
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -764,6 +767,7 @@ struct asic_fixed_properties {
 	u32				xbar_edge_enabled_mask;
 	u32				device_mem_alloc_default_page_size;
 	u32				num_engine_cores;
+	u32				hbw_flush_reg;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 1b701a87c6fe..13f9e6c0cd90 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -701,6 +701,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->dma_mask = 48;
 
+	prop->hbw_flush_reg = mmPCIE_WRAP_RR_ELBI_RD_SEC_REG_CTRL;
+
 	return 0;
 }
 
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 7df1a68dd403..4529a64d49b6 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2071,6 +2071,8 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 
 	prop->dma_mask = 64;
 
+	prop->hbw_flush_reg = mmPCIE_WRAP_SPECIAL_GLBL_SPARE_0;
+
 	return 0;
 }
 
diff --git a/drivers/accel/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/accel/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index 1a6576666794..23ee8691db46 100644
--- a/drivers/accel/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/accel/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -320,4 +320,6 @@
 #define mmPSOC_TPC_PLL_NR                                            0xC73100
 #define mmIF_W_PLL_NR                                                0x488100
 
+#define mmPCIE_WRAP_RR_ELBI_RD_SEC_REG_CTRL                          0xC01208
+
 #endif /* ASIC_REG_GAUDI_REGS_H_ */
diff --git a/include/uapi/drm/habanalabs_accel.h b/include/uapi/drm/habanalabs_accel.h
index 90e628779264..331567ec9e79 100644
--- a/include/uapi/drm/habanalabs_accel.h
+++ b/include/uapi/drm/habanalabs_accel.h
@@ -1478,6 +1478,14 @@ struct hl_cs_chunk {
  */
 #define HL_CS_FLAGS_ENGINE_CORE_COMMAND		0x4000
 
+/*
+ * The flush HBW PCI writes is merged into the existing CS ioctls.
+ * Used to flush all HBW PCI writes.
+ * This is a blocking operation and for this reason the user shall not use
+ * the return sequence number (which will be invalid anyway)
+ */
+#define HL_CS_FLAGS_FLUSH_PCI_HBW_WRITES	0x8000
+
 #define HL_CS_STATUS_SUCCESS		0
 
 #define HL_MAX_JOBS_PER_CS		512
-- 
2.34.1

