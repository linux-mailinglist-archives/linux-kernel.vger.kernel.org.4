Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6981171095B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbjEYJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjEYJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:58:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A4DCE47
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:58:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272621042;
        Thu, 25 May 2023 02:59:13 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2BEB3F762;
        Thu, 25 May 2023 02:58:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        james.clark@arm.com, anshuman.khandual@arm.com,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        linux@armlinux.org.uk
Subject: [RFC PATCH] coresight: etm4x: Match all ETM4 instances based on DEVARCH and DEVTYPE
Date:   Thu, 25 May 2023 10:58:07 +0100
Message-Id: <20230525095807.1379811-1-suzuki.poulose@arm.com>
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

All,

This is an RFC patch to allow all ETM4 instances to be detected via AMBA driver
without having to add the PIDs to the list. The AMBA driver already supports
checking the DEVTYPE and DEVARCH registers for CoreSight components. This patch
adds a pid,mask value that is bound to match all PIDs (with PIDR2.JEDEC field
mandated to be RA0).

With this patch, we wouldn't need to add the PIDs for newer CPUs to be able to
use them. An entry in the device tree is all we need. The only side effect of
this patch is :
    If a DT description exists for an ETM and the CPU ETM has an erratum, the
    driver may still probe it and use it. But then the DT shouldn't have
    described it in the first place.

Thoughts?

Suzuki

---8>---

coresight: etm4x: Match all ETM4 instances based on DEVARCH

Instead of adding the PIDs forever to the list for the new CPUs, let us detect
a component to be ETMv4 based on the CoreSight CID, DEVTYPE=PE_TRACE and
DEVARCH=ETMv4. This is already done for some of the ETMs. We can extend the PID
matching to match the PIDR2:JEDEC, BIT[3], which must be 1 (RA0) always.

Link: https://lkml.kernel.org/r/20230317030501.1811905-1-anshuman.khandual@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: frowand.list@gmail.com
Cc: linux@armlinux.org.uk
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

