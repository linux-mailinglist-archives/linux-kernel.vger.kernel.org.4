Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5768768C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBBHmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBBHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:42:32 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B64FF8418C;
        Wed,  1 Feb 2023 23:42:30 -0800 (PST)
Received: from x64host.home (unknown [47.187.213.40])
        by linux.microsoft.com (Postfix) with ESMTPSA id B245320B74FB;
        Wed,  1 Feb 2023 23:42:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B245320B74FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675323750;
        bh=hqr6+5sz0cEVD673vwUEknaY+FCv/C1YhbsmJe+cR/0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=roO/AeTxRHwHYtYjzzyXJBFrDp08ZJ8xwGcGGk8Y7SS+sN8edGCP3nR/B/3vki4H8
         HCKmcS1m5TH2JsjqVZgdXejdT0C6CAkHMSF8E3LX5NhOGI8+zHSpAVc3PXx+l//fcx
         +aXVFCRNKCUM/RL3FHrcSwtvtM5rdYsbeUn2Lnf4=
From:   madvenka@linux.microsoft.com
To:     jpoimboe@redhat.com, peterz@infradead.org, chenzhongjin@huawei.com,
        mark.rutland@arm.com, broonie@kernel.org, nobuta.keiya@fujitsu.com,
        sjitindarsingh@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        jamorris@linux.microsoft.com, linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com
Subject: [RFC PATCH v3 05/22] objtool: Reorganize ORC types
Date:   Thu,  2 Feb 2023 01:40:19 -0600
Message-Id: <20230202074036.507249-6-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202074036.507249-1-madvenka@linux.microsoft.com>
References: <0337266cf19f4c98388e3f6d09f590d9de258dc7>
 <20230202074036.507249-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

The ORC code needs to be reorganized into arch-specific and generic parts
so that architectures other than X86 can use the generic parts.

orc_types.h contains the following ORC definitions shared between objtool
and the kernel:

	- ORC register definitions which are arch-specific.
	- orc_entry structure which is generic.

Move orc_entry into a new file include/linux/orc_entry.h. Also, the field
names bp_reg and bp_offset in struct orc_entry are x86-specific. Change
them to fp_reg and fp_offset. FP stands for frame pointer.

Currently, the type field in orc_entry is only 2 bits. For other
architectures, we will need more. So, expand this to 3 bits.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/x86/include/asm/orc_types.h       | 37 +++++-------------------
 include/linux/orc_entry.h              | 39 ++++++++++++++++++++++++++
 tools/arch/x86/include/asm/orc_types.h | 37 +++++-------------------
 tools/include/linux/orc_entry.h        | 39 ++++++++++++++++++++++++++
 tools/objtool/orc_gen.c                |  4 +--
 tools/objtool/sync-check.sh            |  1 +
 6 files changed, 95 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/orc_entry.h
 create mode 100644 tools/include/linux/orc_entry.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 5a2baf28a1dc..851c9fb9f695 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -8,6 +8,13 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/orc_entry.h>
+
+/*
+ * For x86, use the appripriate name for the frame pointer in orc_entry.
+ */
+#define bp_offset	fp_offset
+#define bp_reg		fp_reg
 
 /*
  * The ORC_REG_* registers are base registers which are used to find other
@@ -39,34 +46,4 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
-#ifndef __ASSEMBLY__
-#include <asm/byteorder.h>
-
-/*
- * This struct is more or less a vastly simplified version of the DWARF Call
- * Frame Information standard.  It contains only the necessary parts of DWARF
- * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
- * unwinder how to find the previous SP and BP (and sometimes entry regs) on
- * the stack for a given code address.  Each instance of the struct corresponds
- * to one or more code locations.
- */
-struct orc_entry {
-	s16		sp_offset;
-	s16		bp_offset;
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	sp_reg:4;
-	unsigned	bp_reg:4;
-	unsigned	type:2;
-	unsigned	end:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	bp_reg:4;
-	unsigned	sp_reg:4;
-	unsigned	unused:5;
-	unsigned	end:1;
-	unsigned	type:2;
-#endif
-} __packed;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ORC_TYPES_H */
diff --git a/include/linux/orc_entry.h b/include/linux/orc_entry.h
new file mode 100644
index 000000000000..3d49e3b9dabe
--- /dev/null
+++ b/include/linux/orc_entry.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ORC_ENTRY_H
+#define _ORC_ENTRY_H
+
+#ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		fp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	unsigned	sp_reg:4;
+	unsigned	fp_reg:4;
+	unsigned	type:3;
+	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	fp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:4;
+	unsigned	end:1;
+	unsigned	type:3;
+#endif
+} __packed;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_ENTRY_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 5a2baf28a1dc..851c9fb9f695 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -8,6 +8,13 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/orc_entry.h>
+
+/*
+ * For x86, use the appripriate name for the frame pointer in orc_entry.
+ */
+#define bp_offset	fp_offset
+#define bp_reg		fp_reg
 
 /*
  * The ORC_REG_* registers are base registers which are used to find other
@@ -39,34 +46,4 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
-#ifndef __ASSEMBLY__
-#include <asm/byteorder.h>
-
-/*
- * This struct is more or less a vastly simplified version of the DWARF Call
- * Frame Information standard.  It contains only the necessary parts of DWARF
- * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
- * unwinder how to find the previous SP and BP (and sometimes entry regs) on
- * the stack for a given code address.  Each instance of the struct corresponds
- * to one or more code locations.
- */
-struct orc_entry {
-	s16		sp_offset;
-	s16		bp_offset;
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	unsigned	sp_reg:4;
-	unsigned	bp_reg:4;
-	unsigned	type:2;
-	unsigned	end:1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	unsigned	bp_reg:4;
-	unsigned	sp_reg:4;
-	unsigned	unused:5;
-	unsigned	end:1;
-	unsigned	type:2;
-#endif
-} __packed;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ORC_TYPES_H */
diff --git a/tools/include/linux/orc_entry.h b/tools/include/linux/orc_entry.h
new file mode 100644
index 000000000000..3d49e3b9dabe
--- /dev/null
+++ b/tools/include/linux/orc_entry.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ORC_ENTRY_H
+#define _ORC_ENTRY_H
+
+#ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		fp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	unsigned	sp_reg:4;
+	unsigned	fp_reg:4;
+	unsigned	type:3;
+	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	fp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:4;
+	unsigned	end:1;
+	unsigned	type:3;
+#endif
+} __packed;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_ENTRY_H */
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dd3c64af9db2..68c317daadbf 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -98,7 +98,7 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
 	orc->sp_offset = bswap_if_needed(orc->sp_offset);
-	orc->bp_offset = bswap_if_needed(orc->bp_offset);
+	orc->fp_offset = bswap_if_needed(orc->fp_offset);
 
 	/* populate reloc for ip */
 	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
@@ -149,7 +149,7 @@ int orc_create(struct objtool_file *file)
 
 	struct orc_entry null = {
 		.sp_reg  = ORC_REG_UNDEFINED,
-		.bp_reg  = ORC_REG_UNDEFINED,
+		.fp_reg  = ORC_REG_UNDEFINED,
 		.type    = UNWIND_HINT_TYPE_CALL,
 	};
 
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index ee49b4e9e72c..ef1acb064605 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -18,6 +18,7 @@ arch/x86/include/asm/unwind_hints.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
+include/linux/orc_entry.h
 "
 
 SYNC_CHECK_FILES='
-- 
2.25.1

