Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB5647ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLIHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:55:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423E51C12
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D443961DC9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FF0C433F1;
        Fri,  9 Dec 2022 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670572525;
        bh=4nLQBcd8V0pueofOhtHaEJKIhLpE2Gc7g50/8xor77o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYTmQ/UOCCIBGrz5axni9cWPzMzpbmxGbLgghkZ1AnkMeTt/u/+1KFk9GLkRtIYnM
         oWMbzf3VfSjmHklp1Z0DYJok4+g7+IGg5y/vGWO+U/jKh4QrDIXXwQnHuR/1i8wc+D
         Es686IkaYTg0dC175moF6PsbxZvkp7L5zTe/ljvXC7IycbLRN5iMI0ZKYFGC9SCtjm
         886HZLA/szfVvQHGKg3+VzwI2IZ5fGUeFyGJhmZgJ3CanxkKyjxtxs6dzsobz3ZxLq
         5kxACdUNSCzRVvwGI587We/8+fPSAHlrXwPEKNduqLxngqUjnCuHA87kYlseW8qxS3
         c5wG9ZRPo8csw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, conor.Dooley@microchip.com, guoren@kernel.org,
        heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        crash-utility@redhat.com, Guo Ren <guoren@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH -next V6 1/2] riscv: kexec: EOI active and mask all interrupts in kexec crash path
Date:   Fri,  9 Dec 2022 02:55:12 -0500
Message-Id: <20221209075513.532249-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221209075513.532249-1-guoren@kernel.org>
References: <20221209075513.532249-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

If a crash happens on cpu3 and all interrupts are binding on cpu0, the
bad irq routing will cause the crash kernel can't receive any irq.
Because the crash kernel won't clean up PLIC harts' enable register.
This patch is similar to 'commit 9141a003a491 ("ARM: 7316/1: kexec: EOI
active and mask all interrupts in kexec crash path")'; arm64 and
PowerPC also have a similar mechanism.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/machine_kexec.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index ee79e6839b86..db41c676e5a2 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>	/* For unreachable() */
 #include <linux/cpu.h>		/* For cpu_down() */
 #include <linux/reboot.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 
 /*
  * kexec_image_info - Print received image details
@@ -154,6 +156,37 @@ void crash_smp_send_stop(void)
 	cpus_stopped = 1;
 }
 
+static void machine_kexec_mask_interrupts(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+		int ret;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		/*
+		 * First try to remove the active state. If this
+		 * fails, try to EOI the interrupt.
+		 */
+		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+
+		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
+		    chip->irq_eoi)
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}
+
 /*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
@@ -169,6 +202,8 @@ machine_crash_shutdown(struct pt_regs *regs)
 	crash_smp_send_stop();
 
 	crash_save_cpu(regs, smp_processor_id());
+	machine_kexec_mask_interrupts();
+
 	pr_info("Starting crashdump kernel...\n");
 }
 
-- 
2.36.1

