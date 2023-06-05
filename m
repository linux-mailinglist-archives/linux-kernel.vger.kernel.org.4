Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F272276B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjFENas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFENaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:30:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F9B6CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:30:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 846C5D75;
        Mon,  5 Jun 2023 06:31:28 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C152D3F663;
        Mon,  5 Jun 2023 06:30:41 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        linux@armlinux.org.uk, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: etm4x: Match all ETM4 instances based on DEVARCH and DEVTYPE
Date:   Mon,  5 Jun 2023 14:30:30 +0100
Message-Id: <20230605133031.1827626-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding the PIDs forever to the list for the new CPUs, let us detect
a component to be ETMv4 based on the CoreSight CID, DEVTYPE=PE_TRACE and
DEVARCH=ETMv4. This is already done for some of the ETMs. We can extend the PID
matching to match the PIDR2:JEDEC, BIT[3], which must be 1 (RA0) always.

Link: https://lkml.kernel.org/r/20230317030501.1811905-1-anshuman.khandual@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: frowand.list@gmail.com
Cc: linux@armlinux.org.uk
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          |  5 +++++
 drivers/hwtracing/coresight/coresight-priv.h  | 19 +++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 4c15fae534f3..8a2e24d5686a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2260,6 +2260,11 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
 	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
 	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
+	/*
+	 * Match all PIDs with ETM4 DEVARCH. No need for adding any of the new
+	 * CPUs to the list here.
+	 */
+	CS_AMBA_MATCH_ALL_UCI(uci_id_etm4),
 	{},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 595ce5862056..72ec36c9232c 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -193,12 +193,27 @@ extern void coresight_remove_cti_ops(void);
 	}
 
 /* coresight AMBA ID, full UCI structure: id table entry. */
-#define CS_AMBA_UCI_ID(pid, uci_ptr)		\
+#define __CS_AMBA_UCI_ID(pid, m, uci_ptr)	\
 	{					\
 		.id	= pid,			\
-		.mask	= 0x000fffff,		\
+		.mask	= m,			\
 		.data	= (void *)uci_ptr	\
 	}
+#define CS_AMBA_UCI_ID(pid, uci)	__CS_AMBA_UCI_ID(pid, 0x000fffff, uci)
+/*
+ * PIDR2[JEDEC], BIT(3) must be 1 (Read As One) to indicate that rest of the
+ * PIDR1, PIDR2 DES_* fields follow JEDEC encoding for the designer. Use that
+ * as a match value for blanket matching all devices in the given CoreSight
+ * device type and architecture.
+ */
+#define PIDR2_JEDEC			BIT(3)
+#define PID_PIDR2_JEDEC			(PIDR2_JEDEC << 16)
+/*
+ * Match all PIDs in a given CoreSight device type and architecture, defined
+ * by the uci.
+ */
+#define CS_AMBA_MATCH_ALL_UCI(uci)					\
+	__CS_AMBA_UCI_ID(PID_PIDR2_JEDEC, PID_PIDR2_JEDEC, uci)
 
 /* extract the data value from a UCI structure given amba_id pointer. */
 static inline void *coresight_get_uci_data(const struct amba_id *id)
-- 
2.34.1

