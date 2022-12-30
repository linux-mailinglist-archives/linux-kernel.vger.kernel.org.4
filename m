Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136F659A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiL3Qfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiL3Qfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:35:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6BBC96
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:35:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n12so9908004pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFKAe3UqnrNljCMSUHcNSF1AvM2jTjXkORLEDxJdO3o=;
        b=WpAS9ke74yPlpjfyekqS+Anxu42t+2jkQMLfbUKmUTOdbQnN5BWHSbH/rJUVd5/66+
         kFmDVsUn2VQMDxLheZLkVi3Va5kSg/dwefAenKVQfnIQU5MEvvDWa91PTAP0g3MbTBGR
         ypJRc+YgW6CbpkyaZrnPLcI+5AvSz/PbJoY7r64anVA5xAKAfk0jqZzwVy6fQRHF07WE
         gthfrJjC94607RoKs87mnJWca7OzM49QkQS6snnZOYlPlWXlQcCakFyVn/qFYWCd2lrq
         nNgQe2D/YRLmN8HcPbJBp9b/iHGHDN+x7i/WotiUF7exOcyOj7KliFlzwedf/65p7H9q
         61VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFKAe3UqnrNljCMSUHcNSF1AvM2jTjXkORLEDxJdO3o=;
        b=mY9RCRI159YfR7mUZhHuOh2uTz6j9ukNmfVWhVgtclSVLMQmt3UdOMvA1YpXfBZyL4
         q9/+bjWqRKNqEasYAIzYK1T99AH3aZTUYjmprvk8OBADasqOjXt1OfjB2uAsi+swZiWq
         QXubdbJ0TELY/uiBDUfCwWgvFLlNEs0gqVlpZ5q1Hjj9Q97Mmsr/8LQEc5vDbVUcb9l0
         IY94uRoSk3aSzOb8baepBJVPwSzJHRXPCa2zTw2SI9+DEmXm7Ldn1o8lnIH3k1fhotST
         OA61ubPEgxWZrQ1mYmlnuaQbTlfiDUVDIX+0yEUCgl5Fuy4ejKX5xqyrR+z4kR2NsiRs
         13fQ==
X-Gm-Message-State: AFqh2kpGlWTP305CK2B3nXNPQxmZYfZyZXmPIPc9Hj9r9odXD6HhLkUB
        OUdYKpZ2sw+oniOVmbb4N+4=
X-Google-Smtp-Source: AMrXdXu8zqN9KKdKXK/UOWo55CRiIsyS8HtZFYASfllmKmprfkrwx6QDaZf4EBY1KNCPXboUZ1qSCA==
X-Received: by 2002:a17:902:e34c:b0:185:441e:4cfa with SMTP id p12-20020a170902e34c00b00185441e4cfamr32226200plc.42.1672418145816;
        Fri, 30 Dec 2022 08:35:45 -0800 (PST)
Received: from localhost.localdomain ([116.58.254.173])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b00186748fe6ccsm15142536pll.214.2022.12.30.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:35:45 -0800 (PST)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mingo@redhat.com
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dmitrii.bundin.a@gmail.com, vbabka@suse.cz
Subject: [PATCH] scripts/gdb: add mm introspection utils
Date:   Fri, 30 Dec 2022 19:35:12 +0300
Message-Id: <20221230163512.23736-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
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
given virtual address. In addition to qemu's commands info tlb/info mem
it provides the complete information about the paging structure for an
arbitrary virtual address. It supports 4Kb/2MB/1GB and 5 level paging.

Here is an example output for 2MB success translation:

CR3:
    CR3 BINARY DATA: 0x10c1d2002
    NEXT ENTRY PHYSICALL ADDRESS: 0x10c1d2000
    ---
    PAGE LEVEL WRITE THROUGH(bit 3): False
    PAGE LEVEL CACHE DISABLED(bit 4): False
LEVEL 4:
    ENTRY ADDRESS: 0xffff88810c1d27f0
    PAGE ENTRY BINARY DATA: 0x8000000105dca067
    NEXT ENTRY PHYSICALL ADDRESS: 0x105dca000
    ---
    ENTRY PRESENT(bit 0):      True
    READ/WRITE ACCESS ALLOWED(bit 1): True
    USER ACCESS ALLOWED(bit 2): True
    PAGE LEVEL WRITE THROUGH(bit 3): False
    PAGE LEVEL CACHE DISABLED(bit 4): False
    ENTRY HAS BEEN ACCESSED(bit 5): True
    PAGE SIZE(bit 7): False
    RESTART TO ORDINARY(bit 11): False
    EXECUTE DISABLE(bit 63): True
LEVEL 3:
    ENTRY ADDRESS: 0xffff888105dca9d0
    PAGE ENTRY BINARY DATA: 0x105c87067
    NEXT ENTRY PHYSICALL ADDRESS: 0x105c87000
    ---
    ENTRY PRESENT(bit 0):      True
    READ/WRITE ACCESS ALLOWED(bit 1): True
    USER ACCESS ALLOWED(bit 2): True
    PAGE LEVEL WRITE THROUGH(bit 3): False
    PAGE LEVEL CACHE DISABLED(bit 4): False
    ENTRY HAS BEEN ACCESSED(bit 5): True
    PAGE SIZE(bit 7): False
    RESTART TO ORDINARY(bit 11): False
    EXECUTE DISABLE(bit 63): False
LEVEL 2:
    ENTRY ADDRESS: 0xffff888105c87698
    PAGE ENTRY BINARY DATA: 0x80000001622008e7
    PAGE SIZE: 2MB
    PAGE PHYSICALL ADDRESS: 0x162200000
    ---
    ENTRY PRESENT(bit 0):      True
    READ/WRITE ACCESS ALLOWED(bit 1): True
    USER ACCESS ALLOWED(bit 2): True
    PAGE LEVEL WRITE THROUGH(bit 3): False
    PAGE LEVEL CACHE DISABLED(bit 4): False
    ENTRY HAS BEEN ACCESSED(bit 5): True
    PAGE DIRTY(bit 6): True
    PAGE SIZE(bit 7): True
    GLOBAL TRANSLATION(bit 8): False
    RESTART TO ORDINARY(bit 11): True
    PAT(bit 12): False
    PROTECTION KEY(bits (62, 59)): 0
    EXECUTE DISABLE(bit 63): True

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 scripts/gdb/linux/mm.py    | 220 +++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |   1 +
 2 files changed, 221 insertions(+)
 create mode 100644 scripts/gdb/linux/mm.py

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
new file mode 100644
index 000000000000..c6f04e74edbd
--- /dev/null
+++ b/scripts/gdb/linux/mm.py
@@ -0,0 +1,220 @@
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  routines to introspect virtual memory
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
+def _page_offset_base():
+    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
+    pob = pob_symbol.name if pob_symbol else '0xffff888000000000'
+    return gdb.parse_and_eval(pob)
+
+
+def is_bit_defined_tupled(data, offset):
+    return offset, bool(data >> offset & 1)
+
+def content_tupled(data, bit_start, bit_end):
+    return (bit_end, bit_start), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
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
+CR3:
+    CR3 BINARY DATA: {hex(self.cr3)}
+    NEXT ENTRY PHYSICALL ADDRESS: {hex(self.next_entry_physical_address)}
+    ---
+    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
+    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
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
+LEVEL {self.page_hierarchy_level}:
+    ENTRY ADDRESS: {hex(self.address)}
+    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
+    ---
+    PAGE ENTRY IS NOT PRESENT!
+"""
+        elif self.is_page:
+            return f"""\
+LEVEL {self.page_hierarchy_level}:
+    ENTRY ADDRESS: {hex(self.address)}
+    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
+    PAGE SIZE: {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
+    PAGE PHYSICALL ADDRESS: {hex(self.page_physical_address)}
+    ---
+    ENTRY PRESENT(bit {self.entry_present[0]}):      {self.entry_present[1]}
+    READ/WRITE ACCESS ALLOWED(bit {self.read_write[0]}): {self.read_write[1]}
+    USER ACCESS ALLOWED(bit {self.user_access_allowed[0]}): {self.user_access_allowed[1]}
+    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
+    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
+    ENTRY HAS BEEN ACCESSED(bit {self.entry_was_accessed[0]}): {self.entry_was_accessed[1]}
+    PAGE DIRTY(bit {self.dirty[0]}): {self.dirty[1]}
+    """ + \
+    ("" if self.page_hierarchy_level == 1 else f"""PAGE SIZE(bit {self.page_size[0]}): {self.page_size[1]}
+    """) + \
+    f"""GLOBAL TRANSLATION(bit {self.global_translation[0]}): {self.global_translation[1]}
+    RESTART TO ORDINARY(bit {self.hlat_restart_with_ordinary[0]}): {self.hlat_restart_with_ordinary[1]}
+    PAT(bit {self.pat[0]}): {self.pat[1]}
+    PROTECTION KEY(bits {self.protection_key[0]}): {self.protection_key[1]}
+    EXECUTE DISABLE(bit {self.executed_disable[0]}): {self.executed_disable[1]}
+"""
+        else:
+            return f"""\
+LEVEL {self.page_hierarchy_level}:
+    ENTRY ADDRESS: {hex(self.address)}
+    PAGE ENTRY BINARY DATA: {hex(self.page_entry_binary_data)}
+    NEXT ENTRY PHYSICALL ADDRESS: {hex(self.next_entry_physical_address)}
+    ---
+    ENTRY PRESENT(bit {self.entry_present[0]}):      {self.entry_present[1]}
+    READ/WRITE ACCESS ALLOWED(bit {self.read_write[0]}): {self.read_write[1]}
+    USER ACCESS ALLOWED(bit {self.user_access_allowed[0]}): {self.user_access_allowed[1]}
+    PAGE LEVEL WRITE THROUGH(bit {self.page_level_write_through[0]}): {self.page_level_write_through[1]}
+    PAGE LEVEL CACHE DISABLED(bit {self.page_level_cache_disabled[0]}): {self.page_level_cache_disabled[1]}
+    ENTRY HAS BEEN ACCESSED(bit {self.entry_was_accessed[0]}): {self.entry_was_accessed[1]}
+    PAGE SIZE(bit {self.page_size[0]}): {self.page_size[1]}
+    RESTART TO ORDINARY(bit {self.hlat_restart_with_ordinary[0]}): {self.hlat_restart_with_ordinary[1]}
+    EXECUTE DISABLE(bit {self.executed_disable[0]}): {self.executed_disable[1]}
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

