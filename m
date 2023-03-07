Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FB6AD48E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCGCTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCGCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C369CEA;
        Mon,  6 Mar 2023 18:19:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08EB611C6;
        Tue,  7 Mar 2023 02:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD6C433EF;
        Tue,  7 Mar 2023 02:19:06 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ming Wang <wangming01@loongson.cn>
Subject: [PATCH] tools/perf: Add basic support for LoongArch
Date:   Tue,  7 Mar 2023 10:18:57 +0800
Message-Id: <20230307021857.1217951-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for LoongArch, which is very similar to the MIPS
version.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../loongarch/include/uapi/asm/perf_regs.h    | 40 +++++++++
 .../arch/loongarch/include/uapi/asm/unistd.h  |  9 ++
 tools/perf/Makefile.config                    |  7 ++
 tools/perf/arch/loongarch/Build               |  1 +
 tools/perf/arch/loongarch/Makefile            | 27 ++++++
 .../arch/loongarch/annotate/instructions.c    | 45 ++++++++++
 .../loongarch/entry/syscalls/mksyscalltbl     | 61 +++++++++++++
 .../arch/loongarch/include/dwarf-regs-table.h | 16 ++++
 tools/perf/arch/loongarch/include/perf_regs.h | 88 +++++++++++++++++++
 tools/perf/arch/loongarch/util/Build          |  4 +
 tools/perf/arch/loongarch/util/dwarf-regs.c   | 25 ++++++
 tools/perf/arch/loongarch/util/perf_regs.c    |  6 ++
 .../arch/loongarch/util/unwind-libunwind.c    | 82 +++++++++++++++++
 tools/perf/util/annotate.c                    |  8 ++
 tools/perf/util/dwarf-regs.c                  |  7 ++
 tools/perf/util/env.c                         |  2 +
 tools/perf/util/genelf.h                      |  3 +
 tools/perf/util/syscalltbl.c                  |  4 +
 18 files changed, 435 insertions(+)
 create mode 100644 tools/arch/loongarch/include/uapi/asm/perf_regs.h
 create mode 100644 tools/arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/loongarch/Build
 create mode 100644 tools/perf/arch/loongarch/Makefile
 create mode 100644 tools/perf/arch/loongarch/annotate/instructions.c
 create mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/loongarch/include/dwarf-regs-table.h
 create mode 100644 tools/perf/arch/loongarch/include/perf_regs.h
 create mode 100644 tools/perf/arch/loongarch/util/Build
 create mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
 create mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c

diff --git a/tools/arch/loongarch/include/uapi/asm/perf_regs.h b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..9943d418e01d
--- /dev/null
+++ b/tools/arch/loongarch/include/uapi/asm/perf_regs.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_LOONGARCH_PERF_REGS_H
+#define _ASM_LOONGARCH_PERF_REGS_H
+
+enum perf_event_loongarch_regs {
+	PERF_REG_LOONGARCH_PC,
+	PERF_REG_LOONGARCH_R1,
+	PERF_REG_LOONGARCH_R2,
+	PERF_REG_LOONGARCH_R3,
+	PERF_REG_LOONGARCH_R4,
+	PERF_REG_LOONGARCH_R5,
+	PERF_REG_LOONGARCH_R6,
+	PERF_REG_LOONGARCH_R7,
+	PERF_REG_LOONGARCH_R8,
+	PERF_REG_LOONGARCH_R9,
+	PERF_REG_LOONGARCH_R10,
+	PERF_REG_LOONGARCH_R11,
+	PERF_REG_LOONGARCH_R12,
+	PERF_REG_LOONGARCH_R13,
+	PERF_REG_LOONGARCH_R14,
+	PERF_REG_LOONGARCH_R15,
+	PERF_REG_LOONGARCH_R16,
+	PERF_REG_LOONGARCH_R17,
+	PERF_REG_LOONGARCH_R18,
+	PERF_REG_LOONGARCH_R19,
+	PERF_REG_LOONGARCH_R20,
+	PERF_REG_LOONGARCH_R21,
+	PERF_REG_LOONGARCH_R22,
+	PERF_REG_LOONGARCH_R23,
+	PERF_REG_LOONGARCH_R24,
+	PERF_REG_LOONGARCH_R25,
+	PERF_REG_LOONGARCH_R26,
+	PERF_REG_LOONGARCH_R27,
+	PERF_REG_LOONGARCH_R28,
+	PERF_REG_LOONGARCH_R29,
+	PERF_REG_LOONGARCH_R30,
+	PERF_REG_LOONGARCH_R31,
+	PERF_REG_LOONGARCH_MAX = PERF_REG_LOONGARCH_R31 + 1,
+};
+#endif /* _ASM_LOONGARCH_PERF_REGS_H */
diff --git a/tools/arch/loongarch/include/uapi/asm/unistd.h b/tools/arch/loongarch/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..0c743344e92d
--- /dev/null
+++ b/tools/arch/loongarch/include/uapi/asm/unistd.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
+
+#include <asm-generic/unistd.h>
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3519a0139026..89230ae68721 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -80,6 +80,13 @@ ifeq ($(SRCARCH),arm64)
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
+ifeq ($(SRCARCH),loongarch)
+  NO_PERF_REGS := 0
+  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
+  CFLAGS += -I$(OUTPUT)../arch/loongarch/include/uapi
+  LIBUNWIND_LIBS = -lunwind -lunwind-loongarch
+endif
+
 ifeq ($(SRCARCH),riscv)
   NO_PERF_REGS := 0
 endif
diff --git a/tools/perf/arch/loongarch/Build b/tools/perf/arch/loongarch/Build
new file mode 100644
index 000000000000..e4e5f33c84d8
--- /dev/null
+++ b/tools/perf/arch/loongarch/Build
@@ -0,0 +1 @@
+perf-y += util/
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
new file mode 100644
index 000000000000..1229157b09e1
--- /dev/null
+++ b/tools/perf/arch/loongarch/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+ifndef NO_DWARF
+PERF_HAVE_DWARF_REGS := 1
+endif
+PERF_HAVE_JITDUMP := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/loongarch/include/generated/asm
+header := $(out)/syscalls_64.c
+incpath := $(srctree)/tools
+sysdef := $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
+sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, loongarch) $(RM) $(header)
+
+archheaders: $(header)
diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
new file mode 100644
index 000000000000..ab21bf122135
--- /dev/null
+++ b/tools/perf/arch/loongarch/annotate/instructions.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Perf annotate functions.
+ *
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+static
+struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	if (!strncmp(name, "beqz", 4) ||
+	    !strncmp(name, "bnez", 4) ||
+	    !strncmp(name, "beq", 3) ||
+	    !strncmp(name, "bne", 3) ||
+	    !strncmp(name, "blt", 3) ||
+	    !strncmp(name, "bge", 3) ||
+	    !strncmp(name, "bltu", 4) ||
+	    !strncmp(name, "bgeu", 4) ||
+	    !strncmp(name, "bl", 2))
+		ops = &call_ops;
+	else if (!strncmp(name, "jirl", 4))
+		ops = &ret_ops;
+	else if (name[0] == 'b')
+		ops = &jump_ops;
+	else
+		return NULL;
+
+	arch__associate_ins_ops(arch, name, ops);
+
+	return ops;
+}
+
+static
+int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	if (!arch->initialized) {
+		arch->associate_instruction_ops = loongarch__associate_ins_ops;
+		arch->initialized = true;
+		arch->objdump.comment_char = '#';
+	}
+
+	return 0;
+}
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
new file mode 100755
index 000000000000..c52156f7204d
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
@@ -0,0 +1,61 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate system call table for perf. Derived from
+# powerpc script.
+#
+# Author(s):  Ming Wang <wangming01@loongson.cn>
+# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
+# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+
+gcc=$1
+hostcc=$2
+incpath=$3
+input=$4
+
+if ! test -r $input; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table_from_c()
+{
+	local sc nr last_sc
+
+	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
+
+	{
+
+	cat <<-_EoHEADER
+		#include <stdio.h>
+		#include "$input"
+		int main(int argc, char *argv[])
+		{
+	_EoHEADER
+
+	while read sc nr; do
+		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", $nr);"
+		last_sc=$nr
+	done
+
+	printf "%s\n" "	printf(\"#define SYSCALLTBL_LOONGARCH_MAX_ID %d\\n\", $last_sc);"
+	printf "}\n"
+
+	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
+
+	$create_table_exe
+
+	rm -f $create_table_exe
+}
+
+create_table()
+{
+	echo "static const char *syscalltbl_loongarch[] = {"
+	create_table_from_c
+	echo "};"
+}
+
+$gcc -E -dM -x c  -I $incpath/include/uapi $input	       \
+	|sed -ne 's/^#define __NR_//p' \
+	|sort -t' ' -k2 -n \
+	|create_table
diff --git a/tools/perf/arch/loongarch/include/dwarf-regs-table.h b/tools/perf/arch/loongarch/include/dwarf-regs-table.h
new file mode 100644
index 000000000000..4b2291034668
--- /dev/null
+++ b/tools/perf/arch/loongarch/include/dwarf-regs-table.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * dwarf-regs-table.h : Mapping of DWARF debug register numbers into
+ * register names.
+ *
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#ifdef DEFINE_DWARF_REGSTR_TABLE
+static const char * const loongarch_regstr_tbl[] = {
+	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
+	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
+	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "%29",
+	"$30", "$31",
+};
+#endif
diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf/arch/loongarch/include/perf_regs.h
new file mode 100644
index 000000000000..82d531dcd90f
--- /dev/null
+++ b/tools/perf/arch/loongarch/include/perf_regs.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <asm/perf_regs.h>
+
+#define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
+#define PERF_REG_IP PERF_REG_LOONGARCH_PC
+#define PERF_REG_SP PERF_REG_LOONGARCH_R3
+
+#define PERF_REGS_MASK ((1ULL << PERF_REG_LOONGARCH_MAX) - 1)
+
+static inline const char *__perf_reg_name(int id)
+{
+	switch (id) {
+	case PERF_REG_LOONGARCH_PC:
+		return "PC";
+	case PERF_REG_LOONGARCH_R1:
+		return "$1";
+	case PERF_REG_LOONGARCH_R2:
+		return "$2";
+	case PERF_REG_LOONGARCH_R3:
+		return "$3";
+	case PERF_REG_LOONGARCH_R4:
+		return "$4";
+	case PERF_REG_LOONGARCH_R5:
+		return "$5";
+	case PERF_REG_LOONGARCH_R6:
+		return "$6";
+	case PERF_REG_LOONGARCH_R7:
+		return "$7";
+	case PERF_REG_LOONGARCH_R8:
+		return "$8";
+	case PERF_REG_LOONGARCH_R9:
+		return "$9";
+	case PERF_REG_LOONGARCH_R10:
+		return "$10";
+	case PERF_REG_LOONGARCH_R11:
+		return "$11";
+	case PERF_REG_LOONGARCH_R12:
+		return "$12";
+	case PERF_REG_LOONGARCH_R13:
+		return "$13";
+	case PERF_REG_LOONGARCH_R14:
+		return "$14";
+	case PERF_REG_LOONGARCH_R15:
+		return "$15";
+	case PERF_REG_LOONGARCH_R16:
+		return "$16";
+	case PERF_REG_LOONGARCH_R17:
+		return "$17";
+	case PERF_REG_LOONGARCH_R18:
+		return "$18";
+	case PERF_REG_LOONGARCH_R19:
+		return "$19";
+	case PERF_REG_LOONGARCH_R20:
+		return "$20";
+	case PERF_REG_LOONGARCH_R21:
+		return "$21";
+	case PERF_REG_LOONGARCH_R22:
+		return "$22";
+	case PERF_REG_LOONGARCH_R23:
+		return "$23";
+	case PERF_REG_LOONGARCH_R24:
+		return "$24";
+	case PERF_REG_LOONGARCH_R25:
+		return "$25";
+	case PERF_REG_LOONGARCH_R26:
+		return "$26";
+	case PERF_REG_LOONGARCH_R27:
+		return "$27";
+	case PERF_REG_LOONGARCH_R28:
+		return "$28";
+	case PERF_REG_LOONGARCH_R29:
+		return "$29";
+	case PERF_REG_LOONGARCH_R30:
+		return "$30";
+	case PERF_REG_LOONGARCH_R31:
+		return "$31";
+	default:
+		break;
+	}
+	return NULL;
+}
+
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
new file mode 100644
index 000000000000..fab48acf21c5
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/Build
@@ -0,0 +1,4 @@
+perf-y += perf_regs.o
+
+perf-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
new file mode 100644
index 000000000000..7db14897a384
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
+ *
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+
+#include <stdio.h>
+#include <dwarf-regs.h>
+
+static const char *loongarch_gpr_names[32] = {
+	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
+	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
+	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "$29",
+	"$30", "$31"
+};
+
+const char *get_arch_regstr(unsigned int n)
+{
+	n %= 32;
+	return loongarch_gpr_names[n];
+}
diff --git a/tools/perf/arch/loongarch/util/perf_regs.c b/tools/perf/arch/loongarch/util/perf_regs.c
new file mode 100644
index 000000000000..2833e101a7c6
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/perf_regs.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../util/perf_regs.h"
+
+const struct sample_reg sample_reg_masks[] = {
+	SMPL_REG_END
+};
diff --git a/tools/perf/arch/loongarch/util/unwind-libunwind.c b/tools/perf/arch/loongarch/util/unwind-libunwind.c
new file mode 100644
index 000000000000..f693167b86ef
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/unwind-libunwind.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <libunwind.h>
+#include "perf_regs.h"
+#include "../../util/unwind.h"
+#include "util/debug.h"
+
+int libunwind__arch_reg_id(int regnum)
+{
+	switch (regnum) {
+	case UNW_LOONGARCH64_R1:
+		return PERF_REG_LOONGARCH_R1;
+	case UNW_LOONGARCH64_R2:
+		return PERF_REG_LOONGARCH_R2;
+	case UNW_LOONGARCH64_R3:
+		return PERF_REG_LOONGARCH_R3;
+	case UNW_LOONGARCH64_R4:
+		return PERF_REG_LOONGARCH_R4;
+	case UNW_LOONGARCH64_R5:
+		return PERF_REG_LOONGARCH_R5;
+	case UNW_LOONGARCH64_R6:
+		return PERF_REG_LOONGARCH_R6;
+	case UNW_LOONGARCH64_R7:
+		return PERF_REG_LOONGARCH_R7;
+	case UNW_LOONGARCH64_R8:
+		return PERF_REG_LOONGARCH_R8;
+	case UNW_LOONGARCH64_R9:
+		return PERF_REG_LOONGARCH_R9;
+	case UNW_LOONGARCH64_R10:
+		return PERF_REG_LOONGARCH_R10;
+	case UNW_LOONGARCH64_R11:
+		return PERF_REG_LOONGARCH_R11;
+	case UNW_LOONGARCH64_R12:
+		return PERF_REG_LOONGARCH_R12;
+	case UNW_LOONGARCH64_R13:
+		return PERF_REG_LOONGARCH_R13;
+	case UNW_LOONGARCH64_R14:
+		return PERF_REG_LOONGARCH_R14;
+	case UNW_LOONGARCH64_R15:
+		return PERF_REG_LOONGARCH_R15;
+	case UNW_LOONGARCH64_R16:
+		return PERF_REG_LOONGARCH_R16;
+	case UNW_LOONGARCH64_R17:
+		return PERF_REG_LOONGARCH_R17;
+	case UNW_LOONGARCH64_R18:
+		return PERF_REG_LOONGARCH_R18;
+	case UNW_LOONGARCH64_R19:
+		return PERF_REG_LOONGARCH_R19;
+	case UNW_LOONGARCH64_R20:
+		return PERF_REG_LOONGARCH_R20;
+	case UNW_LOONGARCH64_R21:
+		return PERF_REG_LOONGARCH_R21;
+	case UNW_LOONGARCH64_R22:
+		return PERF_REG_LOONGARCH_R22;
+	case UNW_LOONGARCH64_R23:
+		return PERF_REG_LOONGARCH_R23;
+	case UNW_LOONGARCH64_R24:
+		return PERF_REG_LOONGARCH_R24;
+	case UNW_LOONGARCH64_R25:
+		return PERF_REG_LOONGARCH_R25;
+	case UNW_LOONGARCH64_R26:
+		return PERF_REG_LOONGARCH_R26;
+	case UNW_LOONGARCH64_R27:
+		return PERF_REG_LOONGARCH_R27;
+	case UNW_LOONGARCH64_R28:
+		return PERF_REG_LOONGARCH_R28;
+	case UNW_LOONGARCH64_R29:
+		return PERF_REG_LOONGARCH_R29;
+	case UNW_LOONGARCH64_R30:
+		return PERF_REG_LOONGARCH_R30;
+	case UNW_LOONGARCH64_R31:
+		return PERF_REG_LOONGARCH_R31;
+	case UNW_LOONGARCH64_PC:
+		return PERF_REG_LOONGARCH_PC;
+	default:
+		pr_err("unwind: invalid reg id %d\n", regnum);
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index db475e44f42f..0cc7710f32da 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -149,6 +149,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
 #include "arch/csky/annotate/instructions.c"
+#include "arch/loongarch/annotate/instructions.c"
 #include "arch/mips/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
@@ -211,6 +212,13 @@ static struct arch architectures[] = {
 			.comment_char = '#',
 		},
 	},
+	{
+		.name = "loongarch",
+		.init = loongarch__annotate_init,
+		.objdump = {
+			.comment_char = '#',
+		},
+	},
 };
 
 static void ins__delete(struct ins_operands *ops)
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 3fa4486742cd..69cfaa5953bf 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -14,6 +14,10 @@
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258 /* LoongArch */
+#endif
+
 /* Define const char * {arch}_register_tbl[] */
 #define DEFINE_DWARF_REGSTR_TABLE
 #include "../arch/x86/include/dwarf-regs-table.h"
@@ -25,6 +29,7 @@
 #include "../arch/sparc/include/dwarf-regs-table.h"
 #include "../arch/xtensa/include/dwarf-regs-table.h"
 #include "../arch/mips/include/dwarf-regs-table.h"
+#include "../arch/loongarch/include/dwarf-regs-table.h"
 
 #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
 
@@ -56,6 +61,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
 		return __get_dwarf_regstr(xtensa_regstr_tbl, n);
 	case EM_MIPS:
 		return __get_dwarf_regstr(mips_regstr_tbl, n);
+	case EM_LOONGARCH:
+		return __get_dwarf_regstr(loongarch_regstr_tbl, n);
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 	}
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 5b8cf6a421a4..0d5d40cb997b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -435,6 +435,8 @@ static const char *normalize_arch(char *arch)
 		return "mips";
 	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
 		return "sh";
+	if (!strncmp(arch, "loongarch", 9))
+		return "loongarch";
 
 	return arch;
 }
diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 6af062d1c452..5f18d20ea903 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
 #elif defined(__riscv) && __riscv_xlen == 64
 #define GEN_ELF_ARCH	EM_RISCV
 #define GEN_ELF_CLASS	ELFCLASS64
+#elif defined(__loongarch__)
+#define GEN_ELF_ARCH	EM_LOONGARCH
+#define GEN_ELF_CLASS	ELFCLASS64
 #else
 #error "unsupported architecture"
 #endif
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index a2e906858891..313eccef6cb4 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -38,6 +38,10 @@ static const char **syscalltbl_native = syscalltbl_arm64;
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
 static const char **syscalltbl_native = syscalltbl_mips_n64;
+#elif defined(__loongarch__)
+#include <asm/syscalls.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_loongarch;
 #endif
 
 struct syscall {
-- 
2.39.1

