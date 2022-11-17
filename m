Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4C62E4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiKQTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKQTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:01:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E87EC81
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B783B82177
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F29C433D6;
        Thu, 17 Nov 2022 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668711679;
        bh=J5e/2e2A0QN5e/QvG58jvwr/TirjLnTq6GC/R3sYRoU=;
        h=From:To:Cc:Subject:Date:From;
        b=iZTnGy1VC1myIEDI3AGe/Md20ChfqPmH9cCimtVx08ODlpvHuaKXSoM5K8oH+6rNM
         zU+P9sA0nuir3N14Ip4crIHh5hwgTMKGtRArIMl9mEn73adrtY5y4CR9e2/lBrAqPu
         V04yljRQtVtb/87LdUNXBnRGCB11TQnzsDG2zWA7VPn4dPWQpNQmW1MFh4hYCy7geV
         D94M+gMfdGmq7F/uK5zyZAVXbCELx6tf+PQ3UZwz2GZox9WNkikUXD0eKbX/uyiGfj
         DHwP+oNUo9fHoPIoZvvSiPPgSOG1SH27OGfmZgkIRUVqov/25wUVdO7ZW8nfsBcQb4
         Z6/SCRQBTnAdQ==
From:   Conor Dooley <conor@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] irqchip/sifive-plic: default to enabled
Date:   Thu, 17 Nov 2022 18:59:43 +0000
Message-Id: <20221117185942.3896559-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
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

From: Conor Dooley <conor.dooley@microchip.com>

The SiFive PLIC driver is used by all current implementations, including
those that do not have a SiFive PLIC. Default the driver to enabled,
with the intention of later removing the current "every SOC selects
this" situation in Kconfig.socs at the moment.

The speculative "potential others" in the description no longer makes
any sense, as the driver is always used. Update the Kconfig symbol's
description to reflect the driver's ubiquitous state.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Hey Marc,

I recall some discussion when this driver was extended to other PLICs a
few months ago:
https://lore.kernel.org/linux-riscv/20511a05f39408c8ffbcc98923c4abd2@kernel.org/

Perhaps I got the wrong impression, but it seemed to me that you intend
for future implementations to reuse this driver where possible?

I'd like to think, and surely will be proven wrong, that ~all future
plic implementations should be similar enough to fit that bill.
It's kinda on this basis that I figure switching this thing to default y
should be okay. It's already only buildable on RISC-V & every
implementation uses it, so no difference there.

Thanks,
Conor.
---
 drivers/irqchip/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..6f99919ba66c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -553,14 +553,15 @@ config RISCV_INTC
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
+	default y
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
-	   This enables support for the PLIC chip found in SiFive (and
-	   potentially other) RISC-V systems.  The PLIC controls devices
-	   interrupts and connects them to each core's local interrupt
-	   controller.  Aside from timer and software interrupts, all other
-	   interrupt sources are subordinate to the PLIC.
+	   This enables support for the PLIC chip found in SiFive & other
+	   RISC-V systems.  The PLIC controls devices interrupts and connects
+	   them to each core's local interrupt controller.  Aside from timer
+	   and software interrupts, all other interrupt sources are
+	   subordinate to the PLIC.
 
 	   If you don't know what to do here, say Y.
 
-- 
2.37.2

