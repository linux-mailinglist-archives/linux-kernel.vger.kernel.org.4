Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB66DBA32
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDHKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDHKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F3C142
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:48:05 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xhd8ABxVEwvLP+guUEK66SFARzUlg4lJcNAVxFrqFBw=;
        b=vDAykfFMSHcckvr3tFSMn5GGVamUKYXbgx6fsL+NFfpmsUEsjJZCRa/9ZdMNo890SgzDQ3
        sD0nA17120U2JMhZTOQjRkyVCYPVGh9tmLRqMJDY756WQuZFdHvOK6E7WcJNbJZfzA8917
        do5a5iTvnvSAmFpQcrY/Msk5XnrUgooPgMWtPWb4o06qwQD7zrtXQ7VSqEYBJjhm4n1Rvv
        iNy7qGBFjCSLOuAD2BEfIMxqPq2wdT0xlpXt9Ykxg1sH5W/etThEgiCJ2IBuA2u8pKxd9a
        tGsGv+K+aZH65EpWq1uGx/c6TKUfemQ3YqVsmxlplIcidPhLNaOUCzisb+siPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xhd8ABxVEwvLP+guUEK66SFARzUlg4lJcNAVxFrqFBw=;
        b=I+KmgS0VYZgVT4fJ93d2/8JvBaGS4CEKZHJgt1gIi9esg6UssRX3eRpewISuWg0P1bkPuc
        AFEOQqR9J1gxxcAg==
From:   "irqchip-bot for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] RISC-V: Use IPIs for remote icache flush
 when possible
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230328035223.1480939-7-apatel@ventanamicro.com>
References: <20230328035223.1480939-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Message-ID: <168095071696.404.7766479024018397126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6279228432352f43f43f5e760771151605bf6d82
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6279228432352f43f43f5e760771151605bf6d82
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Tue, 28 Mar 2023 09:22:22 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 11:26:24 +01:00

RISC-V: Use IPIs for remote icache flush when possible

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote icache flushe directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote icache flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230328035223.1480939-7-apatel@ventanamicro.com
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index fcd6145..20cec5e 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -19,7 +19,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -67,7 +67,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
