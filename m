Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09864DB52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLOMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:38:39 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BE2EF73;
        Thu, 15 Dec 2022 04:38:25 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2592440737A4;
        Thu, 15 Dec 2022 12:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2592440737A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671107902;
        bh=1F14ng0uLHc/D7bnuLtuXVTUn3HgOEnB5AX6fPcjqBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZV5LPnFRRwOxLW9AgC7+BiUVkUyPiE5XGxWQI1ygUg2UA0XM2otaW7W/o4VWSzNt
         o52yfkqykKgst8Cxp/l3xrbB4k8RmuW1J3rsm8cl86lOkprezWF6Gp6Rx7mIrW/wcp
         qZCHZNDQvL2Pr/Brg7SJ3teeqsG4A8Mz8Gc8aFDg=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 04/26] x86/boot: Increase boot page table size
Date:   Thu, 15 Dec 2022 15:37:55 +0300
Message-Id: <71444a474b94ed69dbc4bc6b1592b10fad4e42a5.1671098103.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
References: <cover.1671098103.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous upper limit ignored pages implicitly mapped from #PF handler
by code accessing ACPI tables (boot/compressed/{acpi.c,efi.c}),
so theoretical upper limit is higher than it was set.

Using 4KB pages is desirable for better memory protection granularity.
Approximately twice as much memory is required for those.

Increase initial page table size to 64 4KB page tables.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/include/asm/boot.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..024d972c248e 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -41,22 +41,24 @@
 # define BOOT_STACK_SIZE	0x4000
 
 # define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
 /*
  * Assuming all cross the 512GB boundary:
  * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * (3+3)*2 pages for param and cmd_line
+ * (2+2+S)*2 pages for kernel and randomized kernel, where S is total number
+ *     of sections of kernel. Explanation: 2+2 are upper level page tables.
+ *     We can have only S unaligned parts of section: 1 at the end of the kernel
+ *     and (S-1) at the section borders. The start address of the kernel is
+ *     aligned, so an extra page table. There are at most S=6 sections in
+ *     vmlinux ELF image.
+ * 3 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
+ * Total is 36 pages.
+ *
+ * Some pages are also required for UEFI memory map and
+ * ACPI table mappings, so we need to add extra space.
+ * FIXME: Figure out exact amount of pages.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE		(64*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.37.4

