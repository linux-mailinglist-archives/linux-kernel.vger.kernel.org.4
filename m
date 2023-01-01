Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E25B65AACA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjAARXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAARXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:23:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FF32739
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:23:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so26266730pjh.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cxRgFYpgfLTP9l0RQkzeXjzQEI+jL0LLrydYuT/I0A=;
        b=b9ghow2E4+CYWRqKsOPTUABZWoykahJqVIDKRS5DQlOG/wlvbgf2Sj1fWBt0q7ga15
         xBF95NKTAXV1Ow1OlklZJnVqs3Vp/5rYnmZ5xh+rciMSZZF2CvIGHAMmSU7D91oa6WE+
         GsUcf6cEVaZjY50/fhcrWthA+A0gzImGg/MTJdFktbtms07+wN3/caFve2A09BYML40p
         pBzE0da95SS7slh9q2zdGmMbVCt69tfbN28Axz/YusblhmnRXi7ocHWgIXyNhqvduzFo
         a4/cfRB3miORRvUUZ/zTFn9hJxSeXgaoHLO5uEqgP24S6wZs9XgrgiRQcCoBER+vgjbi
         jUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cxRgFYpgfLTP9l0RQkzeXjzQEI+jL0LLrydYuT/I0A=;
        b=2/aX8KuC+6qaW/s6Tx8GcS29hOUf3hicl0i2lXyTAhY5zHRjMWd4D2j6WqTspA2ulG
         g/TlPfLOf0z6oETehqxyqfaAgN5mttkH7SrAv/dj6uY4wraa3YOw3aG8D705a9vkWJAJ
         usBMZS1mUte/9+93+xvK9LbGHqUZXeAIwMJZmOUA0iLoKaDNb8wjm4K/KhzCvUR2otgH
         i7secE/ucgaRCMISnOFOuliRyX4qNdYpS/R1LP+kMzZ4lhVnYXlkMWe1poJu7TcqNs8j
         fuB6ZxkrFeMExAgI9APLRspNgzpyQbZwgOPn+aHjzjeApq6hzvRBT6LwAsyhvLbT0+Su
         EFnw==
X-Gm-Message-State: AFqh2kp4ZQIRWpHvGjWtUhDIUlQDS0aCp/xvQlJmGiF639wpCvHjfnOF
        9/2BbGnE44jY23VotjuMnv4=
X-Google-Smtp-Source: AMrXdXt+f74X4/tvY3qSFSJVCuqHctzza9U843xqCX4PvmKWE2XtI/QTq6ndinQ8JnN4yUh8ko8j5w==
X-Received: by 2002:a05:6a21:3a81:b0:af:767a:a7e1 with SMTP id zv1-20020a056a213a8100b000af767aa7e1mr71274085pzb.23.1672593808456;
        Sun, 01 Jan 2023 09:23:28 -0800 (PST)
Received: from localhost.localdomain ([116.58.254.36])
        by smtp.gmail.com with ESMTPSA id l186-20020a6325c3000000b004a1e160b431sm1278193pgl.68.2023.01.01.09.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:23:28 -0800 (PST)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, dmitrii.bundin.a@gmail.com,
        gregkh@linuxfoundation.org, jan.kiszka@siemens.com,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, vbabka@suse.cz,
        x86@kernel.org
Subject: [PATCH v3] scripts/gdb: add mm introspection utils
Date:   Sun,  1 Jan 2023 20:23:12 +0300
Message-Id: <20230101172312.21452-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Y7E7fEBm6p0Q2djI@kernel.org>
References: <Y7E7fEBm6p0Q2djI@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This command provides a way to traverse the entire page hierarchy by a
given virtual address on x86. In addition to qemu's commands info
tlb/info mem it provides the complete information about the paging
structure for an arbitrary virtual address. It supports 4KB/2MB/1GB and
5 level paging.

Here is an example output for 2MB success translation:

(gdb) translate-vm address
cr3:
    cr3 binary data                0x10a1f8004
    next entry physicall address   0x10a1f8000
    ---
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
level 4:
    entry address                  0xffff88810a1f87f0
    page entry binary data         0x8000000109042067
    next entry physicall address   0x109042000
    ---
    bit  0          entry present                  True
    bit  1          read/write access allowed      True
    bit  2          user access allowed            True
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
    bit  5          entry has been accessed        True
    bit  7          page size                      False
    bit  11         restart to ordinary            False
    bit  63         execute disable                True
level 3:
    entry address                  0xffff888109042e40
    page entry binary data         0x10ec93067
    next entry physicall address   0x10ec93000
    ---
    bit  0          entry present                  True
    bit  1          read/write access allowed      True
    bit  2          user access allowed            True
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
    bit  5          entry has been accessed        True
    bit  7          page size                      False
    bit  11         restart to ordinary            False
    bit  63         execute disable                False
level 2:
    entry address                  0xffff88810ec939a8
    page entry binary data         0x800000012b6008e7
    page size                      2MB
    page physicall address         0x12b600000
    ---
    bit  0          entry present                  True
    bit  1          read/write access allowed      True
    bit  2          user access allowed            True
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
    bit  5          entry has been accessed        True
    bit  6          page dirty                     True
    bit  7          page size                      True
    bit  8          global translation             False
    bit  11         restart to ordinary            True
    bit  12         pat                            False
    bits (59, 62)   protection key                 0
    bit  63         execute disable                True

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---

Changes in v2: https://lore.kernel.org/all/20221230163512.23736-1-dmitrii.bundin.a@gmail.com/
    - Fix commit message to mention x86 explicitly
    - Assign page_offset_base to a constant in case
      CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled

Changes in v3: https://lore.kernel.org/all/20221231171258.7907-1-dmitrii.bundin.a@gmail.com/
    - Make debug output lower case and column aligned

 scripts/gdb/linux/mm.py    | 223 +++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |   1 +
 2 files changed, 224 insertions(+)
 create mode 100644 scripts/gdb/linux/mm.py

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
new file mode 100644
index 000000000000..7bfe39f32b7c
--- /dev/null
+++ b/scripts/gdb/linux/mm.py
@@ -0,0 +1,223 @@
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  routines to introspect page table
+#
+# Authors:
+#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL version 2.
+#
+
+import gdb
+
+from linux import utils
+
+PHYSICAL_ADDRESS_MASK = gdb.parse_and_eval('0xfffffffffffff')
+
+
+def page_mask(level=1):
+    # 4KB
+    if level == 1:
+        return gdb.parse_and_eval('(u64) ~0xfff')
+    # 2MB
+    elif level == 2:
+        return gdb.parse_and_eval('(u64) ~0x1fffff')
+    # 1GB
+    elif level == 3:
+        return gdb.parse_and_eval('(u64) ~0x3fffffff')
+    else:
+        raise Exception(f'Unknown page level: {level}')
+
+
+#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
+POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
+def _page_offset_base():
+    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
+    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
+    return gdb.parse_and_eval(pob)
+
+
+def is_bit_defined_tupled(data, offset):
+    return offset, bool(data >> offset & 1)
+
+def content_tupled(data, bit_start, bit_end):
+    return (bit_start, bit_end), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
+
+def entry_va(level, phys_addr, translating_va):
+        def start_bit(level):
+            if level == 5:
+                return 48
+            elif level == 4:
+                return 39
+            elif level == 3:
+                return 30
+            elif level == 2:
+                return 21
+            elif level == 1:
+                return 12
+            else:
+                raise Exception(f'Unknown level {level}')
+
+        entry_offset =  ((translating_va >> start_bit(level)) & 511) * 8
+        entry_va = _page_offset_base() + phys_addr + entry_offset
+        return entry_va
+
+class Cr3():
+    def __init__(self, cr3, page_levels):
+        self.cr3 = cr3
+        self.page_levels = page_levels
+        self.page_level_write_through = is_bit_defined_tupled(cr3, 3)
+        self.page_level_cache_disabled = is_bit_defined_tupled(cr3, 4)
+        self.next_entry_physical_address = cr3 & PHYSICAL_ADDRESS_MASK & page_mask()
+
+    def next_entry(self, va):
+        next_level = self.page_levels
+        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
+
+    def mk_string(self):
+            return f"""\
+cr3:
+    {'cr3 binary data': <30} {hex(self.cr3)}
+    {'next entry physicall address': <30} {hex(self.next_entry_physical_address)}
+    ---
+    {'bit' : <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit' : <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+"""
+
+
+class PageHierarchyEntry():
+    def __init__(self, address, level):
+        data = int.from_bytes(
+            memoryview(gdb.selected_inferior().read_memory(address, 8)),
+            "little"
+        )
+        if level == 1:
+            self.is_page = True
+            self.entry_present = is_bit_defined_tupled(data, 0)
+            self.read_write = is_bit_defined_tupled(data, 1)
+            self.user_access_allowed = is_bit_defined_tupled(data, 2)
+            self.page_level_write_through = is_bit_defined_tupled(data, 3)
+            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
+            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
+            self.dirty = is_bit_defined_tupled(data, 6)
+            self.pat = is_bit_defined_tupled(data, 7)
+            self.global_translation = is_bit_defined_tupled(data, 8)
+            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level)
+            self.next_entry_physical_address = None
+            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
+            self.protection_key = content_tupled(data, 59, 62)
+            self.executed_disable = is_bit_defined_tupled(data, 63)
+        else:
+            page_size = is_bit_defined_tupled(data, 7)
+            page_size_bit = page_size[1]
+            self.is_page = page_size_bit
+            self.entry_present = is_bit_defined_tupled(data, 0)
+            self.read_write = is_bit_defined_tupled(data, 1)
+            self.user_access_allowed = is_bit_defined_tupled(data, 2)
+            self.page_level_write_through = is_bit_defined_tupled(data, 3)
+            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
+            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
+            self.page_size = page_size
+            self.dirty = is_bit_defined_tupled(
+                data, 6) if page_size_bit else None
+            self.global_translation = is_bit_defined_tupled(
+                data, 8) if page_size_bit else None
+            self.pat = is_bit_defined_tupled(
+                data, 12) if page_size_bit else None
+            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level) if page_size_bit else None
+            self.next_entry_physical_address = None if page_size_bit else data & PHYSICAL_ADDRESS_MASK & page_mask()
+            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
+            self.protection_key = content_tupled(data, 59, 62) if page_size_bit else None
+            self.executed_disable = is_bit_defined_tupled(data, 63)
+        self.address = address
+        self.page_entry_binary_data = data
+        self.page_hierarchy_level = level
+
+    def next_entry(self, va):
+        if self.is_page or not self.entry_present[1]:
+            return None
+
+        next_level = self.page_hierarchy_level - 1
+        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
+
+
+    def mk_string(self):
+        if not self.entry_present[1]:
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    ---
+    PAGE ENTRY IS NOT PRESENT!
+"""
+        elif self.is_page:
+            def page_size_line(ps_bit, ps, level):
+                return "" if level == 1 else f"{'bit': <3} {ps_bit: <5} {'page size': <30} {ps}"
+
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    {'page size': <30} {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
+    {'page physicall address': <30} {hex(self.page_physical_address)}
+    ---
+    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
+    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
+    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
+    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
+    {"" if self.page_hierarchy_level == 1 else f"{'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}"}
+    {'bit': <4} {self.dirty[0]: <10} {'page dirty': <30} {self.dirty[1]}
+    {'bit': <4} {self.global_translation[0]: <10} {'global translation': <30} {self.global_translation[1]}
+    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
+    {'bit': <4} {self.pat[0]: <10} {'pat': <30} {self.pat[1]}
+    {'bits': <4} {str(self.protection_key[0]): <10} {'protection key': <30} {self.protection_key[1]}
+    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
+"""
+        else:
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    {'next entry physicall address': <30} {hex(self.next_entry_physical_address)}
+    ---
+    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
+    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
+    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
+    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
+    {'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}
+    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
+    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
+"""
+
+
+class TranslateVM(gdb.Command):
+    """Prints the entire paging structure used to translate a given virtual address.
+
+Having an address space of the currently executed process translates the virtual address
+and prints detailed information of all paging structure levels used for the transaltion."""
+
+    def __init__(self):
+        super(TranslateVM, self).__init__('translate-vm', gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        if utils.is_target_arch("x86"):
+            vm_address = gdb.parse_and_eval(f'{arg}')
+            cr3_data = gdb.parse_and_eval('$cr3')
+            cr4 = gdb.parse_and_eval('$cr4')
+            page_levels = 5 if cr4 & (1 << 12) else 4
+            page_entry = Cr3(cr3_data, page_levels)
+            while page_entry:
+                gdb.write(page_entry.mk_string())
+                page_entry = page_entry.next_entry(vm_address)
+        else:
+            gdb.GdbError("Virtual address translation is not"
+                         "supported for this arch")
+
+
+
+TranslateVM()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4136dc2c59df..27bd7339bccc 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -37,3 +37,4 @@ else:
     import linux.clk
     import linux.genpd
     import linux.device
+    import linux.mm
-- 
2.17.1

