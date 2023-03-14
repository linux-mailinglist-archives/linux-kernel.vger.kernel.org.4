Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9E6B8FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCNKXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCNKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:22:43 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841B93D7;
        Tue, 14 Mar 2023 03:22:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 431324076B3C;
        Tue, 14 Mar 2023 10:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 431324076B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788841;
        bh=cFWBUuzFVvbMswZ9kJ4Z4Ih3xSnlu+Hxv2+4lFZbnHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5rFFQU+Q7LukU1VZJbrAiymnkGlmrNvnMb+ciFh+N/qDexZb2DcC1Ldo7d4lQ048
         g9suTTvlVA9H/oHRN8L/QLkjQsnPM42oafXHw8YLa7QXUWeWZ2lB6WgkhY39S5ARr1
         0hFa3eTdXJLcB2gJA/jvNPJMgeShOklNZnFU+dNs=
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
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 04/27] x86/boot: Increase boot page table size
Date:   Tue, 14 Mar 2023 13:13:31 +0300
Message-Id: <92dcca146e54c6d2093be399261bb5c38d37c9be.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/include/asm/boot.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..88836067f88c 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -41,22 +41,26 @@
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
+ * Some number of page tables is also required for the ACPI and UEFI table
+ * mappings, so we round up 36 to 64. Since ACPI tables are generally getting
+ * allocated in a few contiguous regions of memory, they are very unlikely to be
+ * spread out enough to require more than 28 extra page tables and this
+ * would work fine in all more or less sane environments.
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
2.39.2

