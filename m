Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FAD67FD2D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjA2GvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2GvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:51:09 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19DDD222CA
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6uU3j
        oumwcYBcrqjjyAlKZujZbS6wTE38W4riMu4ql8=; b=fA8ERx8rPzhplQswwnABe
        e20o2orl92hPcZOEd511wENbbnbhTaKkgVLWYrzMmKbS5VQN6FKZlN9N2rpbd71C
        lbLyNq/wwFkSBQCVcUGNzm4/36age2s8M+hGoair2zuWZoLA0JwMvCUK/H6Txd3Z
        R3gPr94FtPyx5PZo2UqBZg=
Received: from whoami-VirtualBox.. (unknown [223.104.39.183])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDn6bkWF9ZjinBACA--.17232S2;
        Sun, 29 Jan 2023 14:49:59 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     palmer@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        yuzhao@google.com, conor.dooley@microchip.com,
        ajones@ventanamicro.com, guoren@kernel.org, tongtiangen@huawei.com,
        anup@brainfault.org
Cc:     akpm@linux-foundation.org, falcon@tinylab.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v1] riscv: support arch_has_hw_pte_young()
Date:   Sun, 29 Jan 2023 14:49:56 +0800
Message-Id: <20230129064956.143664-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn6bkWF9ZjinBACA--.17232S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyxWFy7Gr43AryUKr1fCrg_yoW8ZrWkpF
        s8CrnYkFWftF9akFW3Z3srCr1rJ3ZYgay3Kry0k34UXrsrArWSvwsxKwn3Xry8JFWxXrWf
        CrZa9F1Duw17Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_cT9UUUUU=
X-Originating-IP: [223.104.39.183]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiVhMGeFqzwK5hhwADsZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_has_hw_pte_young() is false for riscv by default. If it's
false, page table walk is almost skipped for MGLRU reclaim. And it
will also cause useless step in __wp_page_copy_user().

RISC-V Privileged Book says that riscv have two schemes to manage A
and D bit.

So add a config for selecting, the default is true. For simple
implementation riscv CPU which just generate page fault, unselect it.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/Kconfig               | 10 ++++++++++
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..17c82885549c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -180,6 +180,16 @@ config PAGE_OFFSET
 	default 0x80000000 if 64BIT && !MMU
 	default 0xff60000000000000 if 64BIT
 
+config ARCH_HAS_HARDWARE_PTE_YOUNG
+	bool "Hardware Set PTE Access Bit"
+	default y
+	help
+	  Select if hardware set A bit when PTE is accessed. The default is
+	  'Y', because most RISC-V CPU hardware can manage A and D bit.
+	  But RISC-V may have simple implementation that do not support
+	  hardware set A bit but only generate page fault, for that case just
+	  unselect it.
+
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4eba9a98d0e3..1db54ab4e1ba 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -532,6 +532,13 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	 */
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
+#ifdef CONFIG_ARCH_HAS_HARDWARE_PTE_YOUNG
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(void)
+{
+	return true;
+}
+#endif
 
 #define pgprot_noncached pgprot_noncached
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
-- 
2.30.2

