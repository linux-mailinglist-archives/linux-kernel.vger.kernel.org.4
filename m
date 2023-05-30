Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD520715747
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjE3Hn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjE3HnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB5F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:44 -0700 (PDT)
Date:   Tue, 30 May 2023 07:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685432485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ixP4CVYH6zlT8g7ecseKopPCbgJjKEnMEfTqTW1tdRo=;
        b=NgLHFIWSPY7rsWf3Mb7TGVirOycJ4HL2j/IeGZ16zV99XvSOYsDyJ9u5muGifVIgPQNjRH
        1AdsG7u+9QPC3n5Mmj2x3lLiC+GWBrmYxVufxmzCQHq6qweJb81Oulj73G++Pc5PxK+B5X
        h5BegP8uAHORq0OdB2nuMLu4+vzCtIyWvqlFd6purCjRZbc3/3ivZBj3cklxVLLX1TnaOR
        /xJo0ZeWiYSCzIkLTXn1ZjUe7VacV0OoOc18R7FwDTLSc09erbFh8GSjjg66ITzytqd0Uv
        tykdJfQ0uKgHnVjjoPTenhMA7cS8z9fx8lXJiUaPC+2YtfVU5ZmrJl8pffqm+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685432485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ixP4CVYH6zlT8g7ecseKopPCbgJjKEnMEfTqTW1tdRo=;
        b=PN12hr/BHHHhOQABqLIP/wSkW7fNabXrkuuJRowuz9/11es12kbj2seHSufLVkge5qcTAB
        nU17Sv3oOX264OBg==
From:   "irqchip-bot for zhengyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Work around affinity
 issues on ASR8601
Cc:     zhengyan <zhengyan@asrmicro.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <168543248396.404.4176287253865665424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b4d81fab1ed0b302c71a869e5b93d81dfbfd3175
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b4d81fab1ed0b302c71a869e5b93d81dfbfd3175
Author:        zhengyan <zhengyan@asrmicro.com>
AuthorDate:    Mon, 22 May 2023 19:06:43 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 29 May 2023 21:19:34 +01:00

irqchip/gic-v3: Work around affinity issues on ASR8601

The ASR8601 SoC combines ARMv8.2 CPUs from ARM with a GIC-500,
also from ARM. However, the two are incompatible as the former
expose an affinity in the form of (cluster, core, thread),
while the latter can only deal with (cluster, core). If nothing
is done, the GIC simply cannot route interrupts to the CPUs.

Implement a workaround that shifts the affinity down by a level,
ensuring the delivery of interrupts despite the implementation
mismatch.

Signed-off-by: zhengyan <zhengyan@asrmicro.com>
[maz: rewrote commit message, reimplemented the workaround
 in a manageable way]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 drivers/irqchip/irq-gic-v3.c           | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 9e311bc..d6430ad 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -214,3 +214,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+
++----------------+-----------------+-----------------+-----------------------------+
+| ASR            | ASR8601         | #8601001        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 50455bc..0c6c1af 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -40,6 +40,7 @@
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 #define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
+#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 3)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -661,6 +662,11 @@ static u64 gic_cpu_to_affinity(int cpu)
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 aff;
 
+	/* ASR8601 needs to have its affinities shifted down... */
+	if (unlikely(gic_data.flags & FLAGS_WORKAROUND_ASR_ERRATUM_8601001))
+		mpidr = (MPIDR_AFFINITY_LEVEL(mpidr, 1)	|
+			 (MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8));
+
 	aff = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8  |
@@ -1801,6 +1807,15 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_asr8601(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_ASR_ERRATUM_8601001;
+
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1808,6 +1823,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.init	= gic_enable_quirk_msm8996,
 	},
 	{
+		.desc	= "GICv3: ASR erratum 8601001",
+		.compatible = "asr,asr8601-gic-v3",
+		.init	= gic_enable_quirk_asr8601,
+	},
+	{
 		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
 		.property = "mediatek,broken-save-restore-fw",
 		.init	= gic_enable_quirk_mtk_gicr,
