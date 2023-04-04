Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655256D6F18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjDDVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjDDVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:40:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439113A8C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:40:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d22so20543078pgw.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680644457; x=1683236457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uI/gH0LMKbai4L61IiGPqFJHODV91CZPTMXmwpc7mMY=;
        b=LnAS1ymRSX5aBLEK+Lhj9KznTffnwsYgZM9oD3lb6kxqPLthbRl1y8Q6Sv4oBxn/24
         Tk9RypC31Mi6lZ1O69mg/saYQhYzNLduEKS8nZSBIES4Pqyj0OWGiBOdXTy5H9Y4tpJU
         E0CpzeaeTl9bEeGK21Ya+6cqoTWIv9Fd+di8qKPjdy6s9n/SUDwPkgV2HuMCiBcLblWB
         yriI8LvTaymMNdniaNlgBA5G9K4tYSNYViVxkqzJ37Py0o7pbHDoYotk1TkGUz1PfvrS
         xS9eS5+G6Wp0hzk5siRdhnE2yOxFMIYgoQH0Ol6G7sOygFvX7bwfQbgjr6VcHneoXIEe
         FzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644457; x=1683236457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI/gH0LMKbai4L61IiGPqFJHODV91CZPTMXmwpc7mMY=;
        b=1fmcza735CMNY4NjSjl4LYJezSg5YdXFM69EttOC4eFXFdSFh8/cnE9dh04YTcAyW2
         C9r1gqj5Mt9jU8TW0iibFL2/AdjjhOm+zOtEpDE15oef9uEzW/0CxeDRJdHUi7ZNHkAv
         NTQqfG/ayNMEt/YnfeCMbuoZqHWUhbAaxsrljwF5U9dxAvWKNdd23affKYN3A7QnbImp
         4xs7ooKXQDqZZEXXGrkFrCrPAmOniX4aReBh1aKPP6O1aWja4N3thHGtSX02CZDoz+Yk
         8qxc/5c2pXR70YgfGLOyinEhWdRX1YvSRkBg4t0vER/eUn/9a6Yf3zSzP26Ok3Zxi5OX
         K7sA==
X-Gm-Message-State: AAQBX9dlo8qiVCQU67NWcKptReOdqvNRDlFbBo3Y2b9Phg35vGQ8MVPP
        1k5JUF5e/maptnWQfYO/WsfWRURoXmtEuQ==
X-Google-Smtp-Source: AKy350a4rTlQBQV2N2dGgMAOTBP9r7aky8vlxDZEJ8dIfVeusftbE0ibCWjbpXT0feQ0Ovf2xetjYQ==
X-Received: by 2002:aa7:9edd:0:b0:625:4189:fcce with SMTP id r29-20020aa79edd000000b006254189fccemr3634782pfq.23.1680644457102;
        Tue, 04 Apr 2023 14:40:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b006260526cf0csm9216583pfa.116.2023.04.04.14.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:40:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        akpm@linux-foundation.org, kapil.hali@broadcom.com
Subject: [PATCH] scripts/gdb: add a Radix Tree Parser
Date:   Tue,  4 Apr 2023 14:40:49 -0700
Message-Id: <20230404214049.1016811-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham@linaro.org>

Linux makes use of the Radix Tree data structure to store pointers
indexed by integer values. This structure is utilised across many
structures in the kernel including the IRQ descriptor tables, and
several filesystems.

This module provides a method to lookup values from a structure given
its head node.

Usage:

The function lx_radix_tree_lookup, must be given a symbol of type struct
radix_tree_root, and an index into that tree.

The object returned is a generic integer value, and must be cast
correctly to the type based on the storage in the data structure.

For example, to print the irq descriptor in the sparse irq_desc_tree at
index 18, try the following:

(gdb) print (struct irq_desc)$lx_radix_tree_lookup(irq_desc_tree, 18)

This script previously existed under commit
e127a73d41ac471d7e3ba950cf128f42d6ee3448 ("scripts/gdb: add a Radix Tree
Parser") and was later reverted with
b447e02548a3304c47b78b5e2d75a4312a8f17e1i (Revert "scripts/gdb: add a
Radix Tree Parser").

This version expects the XArray based radix tree implementation and has
been verified using QEMU/x86 on Linux 6.3-rc5.

Signed-off-by: Kieran Bingham <kieran.bingham@linaro.org>
[florian: revive and update for xarray implementation]
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 scripts/gdb/linux/constants.py.in |  8 +++
 scripts/gdb/linux/radixtree.py    | 87 +++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |  1 +
 3 files changed, 96 insertions(+)
 create mode 100644 scripts/gdb/linux/radixtree.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 2efbec6b6b8d..6c886deb0b18 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -17,6 +17,7 @@
 #include <linux/hrtimer.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <linux/radix-tree.h>
 #include <linux/threads.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
@@ -68,6 +69,13 @@ LX_VALUE(NR_CPUS)
 /* linux/of_fdt.h> */
 LX_VALUE(OF_DT_HEADER)
 
+/* linux/radix-tree.h */
+LX_GDBPARSED(RADIX_TREE_ENTRY_MASK)
+LX_GDBPARSED(RADIX_TREE_INTERNAL_NODE)
+LX_GDBPARSED(RADIX_TREE_MAP_SIZE)
+LX_GDBPARSED(RADIX_TREE_MAP_SHIFT)
+LX_GDBPARSED(RADIX_TREE_MAP_MASK)
+
 /* Kernel Configs */
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
diff --git a/scripts/gdb/linux/radixtree.py b/scripts/gdb/linux/radixtree.py
new file mode 100644
index 000000000000..3ca2db7fbbac
--- /dev/null
+++ b/scripts/gdb/linux/radixtree.py
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+#  Radix Tree Parser
+#
+# Copyright (c) 2016 Linaro Ltd
+# Copyright (c) 2023 Broadcom
+#
+# Authors:
+#  Kieran Bingham <kieran.bingham@linaro.org>
+#  Florian Fainelli <f.fainelli@gmail.com>
+
+import gdb
+
+from linux import utils
+from linux import constants
+
+radix_tree_root_type = utils.CachedType("struct xarray")
+radix_tree_node_type = utils.CachedType("struct xa_node")
+
+def is_internal_node(node):
+    long_type = utils.get_long_type()
+    return ((node.cast(long_type) & constants.LX_RADIX_TREE_ENTRY_MASK) == constants.LX_RADIX_TREE_INTERNAL_NODE)
+
+def entry_to_node(node):
+    long_type = utils.get_long_type()
+    node_type = node.type
+    indirect_ptr = node.cast(long_type) & ~constants.LX_RADIX_TREE_INTERNAL_NODE
+    return indirect_ptr.cast(radix_tree_node_type.get_type().pointer())
+
+def node_maxindex(node):
+    return (constants.LX_RADIX_TREE_MAP_SIZE << node['shift']) - 1
+
+def lookup(root, index):
+    if root.type == radix_tree_root_type.get_type().pointer():
+        node = root.dereference()
+    elif root.type != radix_tree_root_type.get_type():
+        raise gdb.GdbError("must be {} not {}"
+                           .format(radix_tree_root_type.get_type(), root.type))
+
+    node = root['xa_head']
+    if node == 0:
+        return None
+
+    if not (is_internal_node(node)):
+        if (index > 0):
+            return None
+        return node
+
+    node = entry_to_node(node)
+    maxindex = node_maxindex(node)
+
+    if (index > maxindex):
+        return None
+
+    shift = node['shift'] + constants.LX_RADIX_TREE_MAP_SHIFT
+
+    while True:
+        offset = (index >> node['shift']) & constants.LX_RADIX_TREE_MAP_MASK
+        slot = node['slots'][offset]
+
+        node = slot.cast(node.type.pointer()).dereference()
+        if node == 0:
+            return None
+
+        shift -= constants.LX_RADIX_TREE_MAP_SHIFT
+        if (shift <= 0):
+            break
+
+    return node
+
+class LxRadixTree(gdb.Function):
+    """ Lookup and return a node from a RadixTree.
+
+$lx_radix_tree_lookup(root_node [, index]): Return the node at the given index.
+If index is omitted, the root node is dereference and returned."""
+
+    def __init__(self):
+        super(LxRadixTree, self).__init__("lx_radix_tree_lookup")
+
+    def invoke(self, root, index=0):
+        result = lookup(root, index)
+        if result is None:
+            raise gdb.GdbError("No entry in tree at index {}".format(index))
+
+        return result
+
+LxRadixTree()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 3a5b44cd6bfe..4a5056f2c247 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -38,3 +38,4 @@ else:
     import linux.genpd
     import linux.device
     import linux.mm
+    import linux.radixtree
-- 
2.34.1

