Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2466A15A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjAMSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAMR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:59:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5AD801CB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:53:03 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x40so77789lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kpI3wsia9jNstgN1KGZNDnOvPtvN+cUlLTsJxJz3yKQ=;
        b=C9cWyHZjPh3VlIBoZpcsJ1O/ZZ+bSCip9zANJsvy0eseAoks6u09F7kfnjnhBx4k4O
         smPwHBBqPybEtD4SJ0e0WvyEae/nlTq5oY3mMrwKBTyhLWrk4E+KnvJd2KoR2ioKE6S4
         YFqTIKwt20G0c0O93toN1y/A0gJdzQ78Zx+/E03/0Grd2VndHMpjlHFr6o7gP6gw5bUp
         Ac0mmkFO42SLQJIHNQK9X4PeCukp7ePyBv03evWBDZm1150XQZJlXWlNUwvWZIrBErvq
         Heh3CrbXqA8v+N8oVV4Fh2jM69RRH4aOO+KQQKvHW2WgamrJSrNLjAxLFDf6CbT7bDUK
         bSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpI3wsia9jNstgN1KGZNDnOvPtvN+cUlLTsJxJz3yKQ=;
        b=tYRihOsjjcEtvMHQSyFoSV12ogCWOcc/BJ45oEdp0nmC19fdAeN4sz0weZBo3hq8MU
         cvTXG5pVd22dTs2slxLv6NSoiZb1nga1EeAXoNr+evi7VDNJX21oR+UXAfOT/GTr9vJm
         d/OtK+R43/bpJDAxDODPS8fJbAm42CBxYJoFVc2aDW1j6nGVCTDQLmITTDJO22spQFKm
         ZqxLcMoQBqOD5YeDwVOA7fG/oJoeCVcC2XM+Zw6hQevW79uOb0Ldf3eDXYgl8ra40Mv5
         wEXXLOF4xwvYBHUBBzaSx9T4QSDrohqRkMj2q5RgfyDK/TSrdUJIC0WxbZ5rh8z7l7ty
         0rSw==
X-Gm-Message-State: AFqh2kqhZxAqQHt4OhiAHGFC4RJUKYltv3RxBVnesMeV7sSiYZvUMhNm
        +vAYLJIzhdw8Vy4WJ+9Jv+c=
X-Google-Smtp-Source: AMrXdXuwD1jYwOSbrGDKPRc0UDqRTN16n+PEO3UDt8KDsg4LwuX3dH9GJfDyHuJTX400wBwvv0Yzcg==
X-Received: by 2002:a05:6512:3106:b0:4b5:b06d:4300 with SMTP id n6-20020a056512310600b004b5b06d4300mr276619lfb.29.1673632381489;
        Fri, 13 Jan 2023 09:53:01 -0800 (PST)
Received: from localhost.localdomain ([77.223.97.133])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b004cc86bc8f22sm2465034lfs.90.2023.01.13.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:53:01 -0800 (PST)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitrii.bundin.a@gmail.com,
        jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        rppt@kernel.org, vbabka@suse.cz, x86@kernel.org
Subject: [PATCH v5] scripts/gdb: add mm introspection utils
Date:   Fri, 13 Jan 2023 20:51:51 +0300
Message-Id: <20230113175151.22278-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Y8Bqg3vbQK53EtlH@kroah.com>
References: <Y8Bqg3vbQK53EtlH@kroah.com>
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
    cr3 binary data                0x1085be003
    next entry physicall address   0x1085be000
    ---
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
level 4:
    entry address                  0xffff8881085be7f8
    page entry binary data         0x800000010ac83067
    next entry physicall address   0x10ac83000
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
    entry address                  0xffff88810ac83a48
    page entry binary data         0x101af7067
    next entry physicall address   0x101af7000
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
    entry address                  0xffff888101af7368
    page entry binary data         0x80000001634008e7
    page size                      2MB
    page physicall address         0x163400000
    ---
    bit  0          entry present                  True
    bit  1          read/write access allowed      True
    bit  2          user access allowed            True
    bit  3          page level write through       False
    bit  4          page level cache disabled      False
    bit  5          entry has been accessed        True
    bit  7          page size                      True
    bit  6          page dirty                     True
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

Changes in v4: https://lore.kernel.org/all/20230101172312.21452-1-dmitrii.bundin.a@gmail.com/
    - Added currently supported archs in the command help
    - Remove excessive newline

Changes in v5: https://lore.kernel.org/all/20230102171014.31408-1-dmitrii.bundin.a@gmail.com/
    - Added SPDX line

 scripts/gdb/linux/mm.py    | 222 +++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |   1 +
 2 files changed, 223 insertions(+)
 create mode 100644 scripts/gdb/linux/mm.py

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
new file mode 100644
index 000000000000..7456893ffa9c
--- /dev/null
+++ b/scripts/gdb/linux/mm.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  routines to introspect page table
+#
+# Authors:
+#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
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
+and prints detailed information of all paging structure levels used for the transaltion.
+Currently supported arch: x86"""
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
+TranslateVM()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 3e8d3669f0ce..3a5b44cd6bfe 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -37,3 +37,4 @@ else:
     import linux.clk
     import linux.genpd
     import linux.device
+    import linux.mm
-- 
2.17.1

