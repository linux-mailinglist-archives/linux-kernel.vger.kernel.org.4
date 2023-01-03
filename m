Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2865C43A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbjACQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbjACQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:50:09 -0500
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8845C2704
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:50:04 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id 7066F349418
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=oS8RA6WWRgMrhZNBIrhAGHUoPBQYXxENtI7VrbIf0c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m3yTj+nA9FMbJ4byTI7teodsIsVXld/h7kWH5KxYBYZcBR/J6VwVERds17pETCF4U
         /4HQH3n4XfWJcozxyyL3W4JtDxLxBOs2r8QEJki5f2jg+3+qlg3gtRRBlCntQxFoE9
         u0l0QwFYyfEWMDulK4ZVRPE5i5HNbIYdB3znGkNw=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 3EBC13494AC; Tue,  3 Jan
 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id 61AB53494A9; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3138F27E03F4; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 1025927E0404; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 6psBKYatXqwL; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id C80C627E03F6; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <14ee7.63b45b71.5eaf7.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1025927E0404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=vbHsl+8qn/W4f7mvPTnPQmdSUZvmGI0wIPRoGi+8cTc=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=bhWF/Tb+yk+OTP1BRLFIbZ35TYow6U979lnu4GpG3bUsdjOe5DYLEf/ZwzMZWpEYX
 jlG1oCUnmRSJIob+PORVuvxz+BBkOXbZfEw1MU4DjNFYEt/wSEpFfNn/830yfLLYAB
 Xz0u+vClGZNIxIXCtS0GV2o3zfhP7y7b2g1H0f9o=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
Subject: [RFC PATCH 20/25] kvx: gdb: add kvx related gdb helpers
Date:   Tue,  3 Jan 2023 17:43:54 +0100
Message-ID: <20230103164359.24347-21-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kvx related gdb helpers:
* lx-kvx-tlb-access
* lx-kvx-tlb-decode
* lx-kvx-page-table-walk
* lx-kvx-virt-to-phys

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Kieran Bingham <kbingham@kernel.org>
CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 scripts/gdb/arch/Makefile               |  11 ++
 scripts/gdb/arch/__init__.py            |   1 +
 scripts/gdb/arch/kvx/Makefile           |  25 +++
 scripts/gdb/arch/kvx/__init__.py        |   1 +
 scripts/gdb/arch/kvx/constants.py.in    |  74 +++++++++
 scripts/gdb/arch/kvx/mmu.py             | 199 +++++++++++++++++++++++
 scripts/gdb/arch/kvx/page_table_walk.py | 207 ++++++++++++++++++++++++
 7 files changed, 518 insertions(+)
 create mode 100644 scripts/gdb/arch/Makefile
 create mode 100644 scripts/gdb/arch/__init__.py
 create mode 100644 scripts/gdb/arch/kvx/Makefile
 create mode 100644 scripts/gdb/arch/kvx/__init__.py
 create mode 100644 scripts/gdb/arch/kvx/constants.py.in
 create mode 100644 scripts/gdb/arch/kvx/mmu.py
 create mode 100644 scripts/gdb/arch/kvx/page_table_walk.py

diff --git a/scripts/gdb/arch/Makefile b/scripts/gdb/arch/Makefile
new file mode 100644
index 000000000000..25e59accb884
--- /dev/null
+++ b/scripts/gdb/arch/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y := kvx
+
+always-y := gdb-scripts
+
+SRCTREE := $(abspath $(srctree))
+
+$(obj)/gdb-scripts:
+ifdef building_out_of_srctree
+	$(Q)ln -fsn $(SRCTREE)/$(obj)/*.py $(objtree)/$(obj)
+endif
diff --git a/scripts/gdb/arch/__init__.py b/scripts/gdb/arch/__init__.py
new file mode 100644
index 000000000000..4680fb176337
--- /dev/null
+++ b/scripts/gdb/arch/__init__.py
@@ -0,0 +1 @@
+# nothing to do for the initialization of this package
diff --git a/scripts/gdb/arch/kvx/Makefile b/scripts/gdb/arch/kvx/Makefile
new file mode 100644
index 000000000000..124755087510
--- /dev/null
+++ b/scripts/gdb/arch/kvx/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifdef building_out_of_srctree
+
+symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
+
+quiet_cmd_symlink = SYMLINK $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
+
+extra-y += $(symlinks)
+$(addprefix $(obj)/, $(symlinks)): FORCE
+	$(call if_changed,symlink)
+
+endif
+
+quiet_cmd_gen_constants_py = GEN     $@
+      cmd_gen_constants_py = \
+	$(CPP) -E -x c -P $(c_flags) $< > $@ ;\
+	sed -i '1,/<!-- end-c-headers -->/d;' $@
+
+extra-y += constants.py
+$(obj)/constants.py: $(src)/constants.py.in FORCE
+	$(call if_changed_dep,gen_constants_py)
+
+clean-files := *.pyc *.pyo
diff --git a/scripts/gdb/arch/kvx/__init__.py b/scripts/gdb/arch/kvx/__init__.py
new file mode 100644
index 000000000000..4680fb176337
--- /dev/null
+++ b/scripts/gdb/arch/kvx/__init__.py
@@ -0,0 +1 @@
+# nothing to do for the initialization of this package
diff --git a/scripts/gdb/arch/kvx/constants.py.in b/scripts/gdb/arch/kvx/constants.py.in
new file mode 100644
index 000000000000..861f630c3a79
--- /dev/null
+++ b/scripts/gdb/arch/kvx/constants.py.in
@@ -0,0 +1,74 @@
+/*
+ * gdb helper commands and functions for Linux kernel debugging
+ *
+ *  Kernel constants derived from include files.
+ *
+ * Copyright (c) 2016 Linaro Ltd
+ *
+ * Authors:
+ *  Kieran Bingham <kieran.bingham@linaro.org>
+ *
+ * This work is licensed under the terms of the GNU GPL version 2.
+ *
+ */
+
+#include <asm/tlb_defs.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/pgtable.h>
+
+#define LX_VALUE(x) LX_##x = x
+
+/* The build system will take care of deleting everything above this marker */
+<!-- end-c-headers -->
+
+LX_VALUE(TLB_ES_INVALID)
+LX_VALUE(TLB_ES_PRESENT)
+LX_VALUE(TLB_ES_MODIFIED)
+LX_VALUE(TLB_ES_A_MODIFIED)
+
+LX_VALUE(TLB_CP_D_U)
+LX_VALUE(TLB_CP_U_U)
+LX_VALUE(TLB_CP_W_C)
+LX_VALUE(TLB_CP_U_C)
+
+LX_VALUE(TLB_PA_NA_NA)
+LX_VALUE(TLB_PA_NA_R)
+LX_VALUE(TLB_PA_NA_RW)
+LX_VALUE(TLB_PA_NA_RX)
+LX_VALUE(TLB_PA_NA_RWX)
+LX_VALUE(TLB_PA_R_R)
+LX_VALUE(TLB_PA_R_RW)
+LX_VALUE(TLB_PA_R_RX)
+LX_VALUE(TLB_PA_R_RWX)
+LX_VALUE(TLB_PA_RW_RW)
+LX_VALUE(TLB_PA_RW_RWX)
+LX_VALUE(TLB_PA_RX_RX)
+LX_VALUE(TLB_PA_RX_RWX)
+LX_VALUE(TLB_PA_RWX_RWX)
+
+LX_VALUE(TLB_PS_4K)
+LX_VALUE(TLB_PS_64K)
+LX_VALUE(TLB_PS_2M)
+LX_VALUE(TLB_PS_512M)
+
+LX_VALUE(TLB_G_GLOBAL)
+LX_VALUE(TLB_G_USE_ASN)
+
+#ifdef CONFIG_KVX_DEBUG_TLB_ACCESS_BITS
+LX_VALUE(CONFIG_KVX_DEBUG_TLB_ACCESS_BITS)
+#endif
+LX_VALUE(KVX_TLB_ACCESS_READ)
+LX_VALUE(KVX_TLB_ACCESS_WRITE)
+LX_VALUE(KVX_TLB_ACCESS_PROBE)
+
+/* asm/page.h */
+LX_VALUE(PAGE_SHIFT)
+
+/* asm/pgtable.h */
+LX_VALUE(PGDIR_BITS)
+LX_VALUE(PMD_BITS)
+LX_VALUE(PTE_BITS)
+LX_VALUE(_PAGE_HUGE)
+
+LX_VALUE(PA_TO_VA_OFFSET)
diff --git a/scripts/gdb/arch/kvx/mmu.py b/scripts/gdb/arch/kvx/mmu.py
new file mode 100644
index 000000000000..0f2f2523a207
--- /dev/null
+++ b/scripts/gdb/arch/kvx/mmu.py
@@ -0,0 +1,199 @@
+import gdb
+import re
+import ctypes
+from arch.kvx import constants
+from linux import cpus
+
+ps_value = {
+    constants.LX_TLB_PS_4K: '4K',
+    constants.LX_TLB_PS_64K: '64K',
+    constants.LX_TLB_PS_2M: '2M',
+    constants.LX_TLB_PS_512M: '512M',
+}
+
+ps_shift = {
+    constants.LX_TLB_PS_4K: 12,
+    constants.LX_TLB_PS_64K: 16,
+    constants.LX_TLB_PS_2M: 21,
+    constants.LX_TLB_PS_512M: 29,
+}
+
+g_value = {
+    constants.LX_TLB_G_USE_ASN: 'Use ASN',
+    constants.LX_TLB_G_GLOBAL: 'Global',
+}
+
+es_value = {
+    constants.LX_TLB_ES_INVALID: 'Invalid',
+    constants.LX_TLB_ES_PRESENT: 'Present',
+    constants.LX_TLB_ES_MODIFIED: 'Modified',
+    constants.LX_TLB_ES_A_MODIFIED: 'A-Modified',
+}
+
+cp_value = {
+    constants.LX_TLB_CP_D_U: 'Device/Uncached',
+    constants.LX_TLB_CP_U_U: 'Uncached/Uncached',
+    constants.LX_TLB_CP_W_C: 'WriteThrough/Cached',
+    constants.LX_TLB_CP_U_C: 'Unchached/Cached',
+}
+
+pa_value = {
+    constants.LX_TLB_PA_NA_NA: 'NA_NA',
+    constants.LX_TLB_PA_NA_R: 'NA_R',
+    constants.LX_TLB_PA_NA_RW: 'NA_RW',
+    constants.LX_TLB_PA_NA_RX: 'NA_RX',
+    constants.LX_TLB_PA_NA_RWX: 'NA_RWX',
+    constants.LX_TLB_PA_R_R: 'R_R',
+    constants.LX_TLB_PA_R_RW: 'R_RW',
+    constants.LX_TLB_PA_R_RX: 'R_RX',
+    constants.LX_TLB_PA_R_RWX: 'R_RWX',
+    constants.LX_TLB_PA_RW_RW: 'RW_RW',
+    constants.LX_TLB_PA_RW_RWX: 'RW_RWX',
+    constants.LX_TLB_PA_RX_RX: 'RX_RX',
+    constants.LX_TLB_PA_RX_RWX: 'RX_RWX',
+    constants.LX_TLB_PA_RWX_RWX: 'RWX_RWX',
+}
+
+access_type = {
+    constants.LX_KVX_TLB_ACCESS_READ: "READ",
+    constants.LX_KVX_TLB_ACCESS_WRITE: "WRITE",
+    constants.LX_KVX_TLB_ACCESS_PROBE: "PROBE",
+}
+
+def tlb_access_get_idx(idx):
+    return idx & ((1 << constants.LX_CONFIG_KVX_DEBUG_TLB_ACCESS_BITS) - 1)
+
+def computed_set(tel, teh):
+    # For a page of size 2^n (with n >= 12), the index of the set is
+    # determined by the value of the bit slice comprising bits n to n+5 of
+    # the virtual address corresponding to the start of the page
+    page_size = int(tel.cast(gdb.lookup_type("struct tlb_entry_low"))['ps'])
+    teh_val = long(teh.cast(gdb.lookup_type("uint64_t")))
+    return (teh_val >> ps_shift[page_size]) & ((1 << 5) -1)
+
+def tlb_access_objdump(obj, name):
+    gdb.write("  {}\t|".format(name))
+    for f in obj.type.fields():
+        try:
+            val = int(obj[f.name])
+            gdb.write('\t{}:0x{:x}'.format(f.name, val))
+        except:
+            gdb.write('\t{}:{}'.format(f.name, obj[f.name]))
+
+    gdb.write("\n")
+
+# This return the tuple (type, mmc, tel, teh)
+def tlb_access_get_val(cpu, idx):
+    var_ptr = gdb.parse_and_eval("&kvx_tlb_access_rb")
+    return (
+            cpus.per_cpu(var_ptr, cpu)[idx]['type'],
+            cpus.per_cpu(var_ptr, cpu)[idx]['mmc'],
+            cpus.per_cpu(var_ptr, cpu)[idx]['entry']['tel'],
+            cpus.per_cpu(var_ptr, cpu)[idx]['entry']['teh']
+            )
+
+class TLBaccess(gdb.Command):
+    """Dump the last commands exectued when accessing the TLB. The number of
+    commands to dump is passed as the first argument and the CPU is given
+    as the second argument. By default the number of entries dump is 10 and
+    CPU is 0.
+    """
+
+    def __init__(self):
+        super(TLBaccess, self).__init__("lx-kvx-tlb-access", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+
+        dump = 10
+        cpu = 0
+        argv = gdb.string_to_argv(arg)
+
+        try:
+            constants.LX_CONFIG_KVX_DEBUG_TLB_ACCESS_BITS
+        except AttributeError:
+            gdb.write("Kernel was not compiled with KVX_DEBUG_TLB_ACCESS_BITS.\n")
+            gdb.write("This is required to get information about access to TLB.\n")
+            return
+
+        return
+
+        if (len(argv) >= 1):
+            try:
+                dump = int(argv[0])
+            except:
+                gdb.write("WARNING: dump given as argument is not an integer, 10 is used\n")
+
+        if (len(argv) >= 2):
+            try:
+                cpu = int(argv[1])
+            except:
+                gdb.write("WARNING: cpu given as argument is not an integer, 0 is used\n")
+
+        # access_idx is the next id that will be written. There is no value at
+        # this index.
+        try:
+            var_ptr = gdb.parse_and_eval("&kvx_tlb_access_idx")
+            access_idx = int(cpus.per_cpu(var_ptr, cpu))
+        except:
+            gdb.write("Failed to get current index for the buffer. Abort\n")
+            return
+
+        for i in range(0, dump):
+            current_idx = access_idx - i
+
+            # When idx 0 is reach we need to check if we wrapped or not. If we
+            # wrapped then there is no more operations logged.
+            if (current_idx == 0) and (current_idx == tlb_access_get_idx(current_idx)):
+                gdb.write("no more operations occurred in TLB for cpu {}\n".format(cpu))
+                break
+
+            real_idx = tlb_access_get_idx(current_idx - 1)
+
+            e_type, e_mmc, e_tel, e_teh = tlb_access_get_val(cpu, real_idx)
+            access_type_str = access_type.get(int(e_type), "UNKNOWN")
+
+            gdb.write('CPU: {} \n'.format(cpu))
+            if (access_type_str == "WRITE"):
+                gdb.write("  TYPE\t|\tWRITE - computed set {}\n".format(computed_set(e_tel, e_teh)))
+            else:
+                gdb.write("  TYPE\t|\t{}\n".format(access_type_str))
+
+            mmc = e_mmc.cast(gdb.lookup_type("struct mmc_t"))
+            tlb_access_objdump(mmc, "MMC")
+
+            tel = e_tel.cast(gdb.lookup_type("struct tlb_entry_low"))
+            tlb_access_objdump(tel, "TEL")
+
+            teh = e_teh.cast(gdb.lookup_type("struct tlb_entry_high"))
+            tlb_access_objdump(teh, "TEH")
+
+            gdb.write('\n')
+
+TLBaccess()
+
+class LxDecodetlb(gdb.Command):
+    """Decode $tel and $teh values
+    """
+
+    def __init__(self):
+        super(LxDecodetlb, self).__init__("lx-kvx-tlb-decode", gdb.COMMAND_DATA)
+
+    def invoke(self, argument, from_tty):
+        tel_val = gdb.parse_and_eval("$tel")
+        gdb.write('tel:\n\tes:\t{es}\n\tcp:\t{cp}\n\tpa:\t{pa}\n\tps:\t{ps}\n\tfn:\t0x{fn:016x}\n'.format(
+                              es=es_value[int(tel_val["es"])],
+                              cp=cp_value[int(tel_val["cp"])],
+                              pa=pa_value[int(tel_val["pa"])],
+                              ps=ps_value[int(tel_val["ps"])],
+                              fn=int(tel_val["fn"]))
+                          )
+
+        teh_val = gdb.parse_and_eval("$teh")
+        gdb.write('teh:\n\tasn:\t{asn}\n\tg:\t{g}\n\tvs:\t{vs}\n\tpn:\t0x{pn:016x}\n'.format(
+                              asn=teh_val["asn"],
+                              g=g_value[int(teh_val["g"])],
+                              vs=teh_val["vs"],
+                              pn=int(teh_val["pn"]))
+                          )
+
+LxDecodetlb()
diff --git a/scripts/gdb/arch/kvx/page_table_walk.py b/scripts/gdb/arch/kvx/page_table_walk.py
new file mode 100644
index 000000000000..c2f4a21907d1
--- /dev/null
+++ b/scripts/gdb/arch/kvx/page_table_walk.py
@@ -0,0 +1,207 @@
+import gdb
+import re
+import ctypes
+from arch.kvx import constants
+#
+# PTE format:
+#  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+#  | 63..23  | 22..13 | 12 | 11..10 | 9 | 8 | 7 | 6 | 5 | 4 | 3..2 | 1 | 0 |
+#  +---------+--------+----+--------+---+---+---+---+---+---+------+---+---+
+#      PFN     Unused   S    PageSZ   H   G   X   W   R   D    CP    A   P
+
+class pte_bits(ctypes.LittleEndianStructure):
+    _fields_ = [
+            ("P", ctypes.c_uint8, 1),
+            ("A", ctypes.c_uint8, 1),
+            ("CP", ctypes.c_uint8, 2),
+            ("D", ctypes.c_uint8, 1),
+            ("R", ctypes.c_uint8, 1),
+            ("W", ctypes.c_uint8, 1),
+            ("X", ctypes.c_uint8, 1),
+            ("G", ctypes.c_uint8, 1),
+            ("H", ctypes.c_uint8, 1),
+            ("PageSZ", ctypes.c_uint8, 2),
+            ("S", ctypes.c_uint8, 1),
+            ("Unused", ctypes.c_uint16, 10),
+            ("PFN", ctypes.c_uint64, 41),
+        ]
+
+class Pte(ctypes.Union):
+    _fields_ = [("bf", pte_bits),
+                ("value", ctypes.c_uint64)]
+
+    def __init__(self, pteValue):
+        self.value = pteValue
+
+    def phys_addr(self):
+        return self.bf.PFN << constants.LX_PAGE_SHIFT
+
+    def __str__(self):
+        pte_str = "PFN: 0x{:016x}, ".format(self.phys_addr())
+        pte_str += "PS: " + page_sz_str[self.bf.PageSZ] + ", bits: "
+        ignore_fields = ["PFN", "Unused", "PageSZ"]
+
+        for field in reversed(self.bf._fields_):
+            if field[0] in ignore_fields:
+                continue
+
+            if long(getattr(self.bf, field[0])) != 0:
+                pte_str += field[0] + " "
+
+        return pte_str
+
+SIGN_EXT_BITS = 64 - constants.LX_PAGE_SHIFT - constants.LX_PTE_BITS - constants.LX_PMD_BITS - constants.LX_PGDIR_BITS
+
+class virt_addr_bits(ctypes.LittleEndianStructure):
+    _fields_ = [
+            ("page_off", ctypes.c_uint64, constants.LX_PAGE_SHIFT),
+            ("pte_idx", ctypes.c_uint64, constants.LX_PTE_BITS),
+            ("pmd_idx", ctypes.c_uint64, constants.LX_PMD_BITS),
+            ("pgd_idx", ctypes.c_uint64, constants.LX_PGDIR_BITS),
+            ("sign_extension", ctypes.c_uint64, SIGN_EXT_BITS),
+        ]
+
+class VirtAddr(ctypes.Union):
+    _fields_ = [("bf", virt_addr_bits),
+                ("value", ctypes.c_uint64)]
+
+    def __init__(self, virtAddr):
+        self.value = virtAddr
+
+PGD_ENTRIES = 1 << constants.LX_PGDIR_BITS
+PMD_ENTRIES = 1 << constants.LX_PMD_BITS
+PTE_ENTRIES = 1 << constants.LX_PTE_BITS
+
+page_sz_str = {
+    constants.LX_TLB_PS_4K : "4 Ko",
+    constants.LX_TLB_PS_64K: "64 Ko",
+    constants.LX_TLB_PS_2M: "2 Mo",
+    constants.LX_TLB_PS_512M: "512 Mo"
+}
+
+unsigned_long_ptr = gdb.lookup_type('unsigned long').pointer()
+
+def unsigned_long(gdb_val):
+    """Convert a unsigned long gdb.Value to a displayable python value
+    """
+    return long(gdb_val) & 0xFFFFFFFFFFFFFFFF
+
+def do_lookup(base, size=512):
+    """Lookup a page table and return an array of pair with index:entry_value
+    """
+    base_ptr = base.cast(unsigned_long_ptr)
+
+    res = []
+
+    for entry in range(size):
+        entry_val = base_ptr.dereference()
+        base_ptr += 1
+        if entry_val != 0:
+            res.append((entry, entry_val))
+
+    return res
+
+def phys_to_virt(virt):
+    return virt + constants.LX_PA_TO_VA_OFFSET
+
+class LxPageTableWalk(gdb.Command):
+    """Looks for entries in the page table. The base address of the PGD is
+       the argument.
+    """
+
+    def __init__(self):
+        super(LxPageTableWalk, self).__init__("lx-kvx-page-table-walk", gdb.COMMAND_DATA)
+
+    def invoke(self, argument, from_tty):
+        argv = gdb.string_to_argv(argument)
+
+        if (len(argv) == 1):
+            pgd = argv[0]
+        else:
+            pgd = "$lx_current().active_mm.pgd"
+
+        val = gdb.parse_and_eval(pgd)
+        pgd = unsigned_long(val..cast(unsigned_long_ptr))
+
+        print "> Looking for PGD base 0x{:016x}\n".format(pgd)
+
+        for pgd_pair in do_lookup(val, PGD_ENTRIES):
+            gdb.write("[{}] -> Entry[0x{:016x}]\n".format(
+                    pgd_pair[0], unsigned_long(pgd_pair[1])))
+            gdb.write("\t> Looking for PMD base 0x{:016x}\n".format(unsigned_long(pgd_pair[1])))
+            for pmd_pair in do_lookup(phys_to_virt(pgd_pair[1]), PMD_ENTRIES):
+                gdb.write("\t[{}] -> Entry[0x{:016x}]\n".format(
+                        pmd_pair[0], unsigned_long(pmd_pair[1])))
+                # Check if the PMD value read is a huge page or a pointer to a
+                # PTE base.
+                if (unsigned_long(pmd_pair[1]) & constants.LX__PAGE_HUGE):
+                    gdb.write("\t\t> Huge PTE: ")
+                    gdb.write(str(Pte(pmd_pair[1])) + "\n")
+                else:
+                    gdb.write("\t\t> Looking for PTE base 0x{:016x}\n".format(unsigned_long(pmd_pair[1])))
+                    for pte_pair in do_lookup(phys_to_virt(pmd_pair[1]), PTE_ENTRIES):
+                        gdb.write("\t\t[{}] -> PTE [0x{:016x}]\n".format(
+                                pte_pair[0], unsigned_long(pte_pair[1])))
+                        gdb.write("\t\t" + str(Pte(pte_pair[1]))+ "\n")
+
+LxPageTableWalk()
+
+ps_shift = {
+    constants.LX_TLB_PS_4K: 12,
+    constants.LX_TLB_PS_64K: 16,
+    constants.LX_TLB_PS_2M: 21,
+    constants.LX_TLB_PS_512M: 29,
+}
+
+def mask_addr(addr, shift):
+    return addr & ((1 << shift) - 1)
+
+def lookup_entry(base, idx):
+    entry_addr = base.cast(unsigned_long_ptr) + idx
+    res_addr = entry_addr.dereference()
+    if res_addr == 0:
+        raise
+
+    return res_addr
+
+class LxVirtToPhys(gdb.Command):
+    """Translate a virtual address to a physical one by walking the page table
+    """
+
+    def __init__(self):
+        super(LxVirtToPhys, self).__init__("lx-kvx-virt-to-phys", gdb.COMMAND_DATA)
+
+    def invoke(self, argument, from_tty):
+        argv = gdb.string_to_argv(argument)
+
+        if (len(argv) == 0):
+            gdb.write("Missing arguments for command: <virt_addr> [<pgd_addr>]\n")
+            return
+
+        addr = gdb.parse_and_eval(argv[0])
+        if (len(argv) == 2):
+            pgd = argv[1]
+        else:
+            pgd = "$lx_current().active_mm.pgd"
+
+        pgd = gdb.parse_and_eval(pgd)
+
+        addr = unsigned_long(addr.cast(unsigned_long_ptr))
+        gdb.write("Trying to find phys_address for 0x{:016x} \n".format(addr))
+
+        virt_split = VirtAddr(addr)
+
+        try:
+            pmd_addr = lookup_entry(pgd, virt_split.bf.pgd_idx)
+            pte_addr = lookup_entry(phys_to_virt(pmd_addr), virt_split.bf.pmd_idx)
+            pte_value = lookup_entry(phys_to_virt(pte_addr), virt_split.bf.pte_idx)
+        except:
+            raise gdb.GdbError("No page table entry for address 0x{:016x}".format(addr))
+
+        pte_val = Pte(pte_value)
+        gdb.write(str(pte_val)+ "\n")
+
+        low_addr_bits = mask_addr(addr, ps_shift[pte_val.bf.PageSZ])
+        gdb.write("Physical address: 0x{:016x}\n".format(pte_val.phys_addr() + low_addr_bits))
+
+LxVirtToPhys()
-- 
2.37.2





