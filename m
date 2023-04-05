Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437BA6D8A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDEW1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDEW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:27:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280A5599
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:27:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ml21so13528076pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680733672; x=1683325672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7n6ZHU9DswArvev3x3C5JunnjxxD0aP7VI6Us40Ktk=;
        b=IWLa/I9qckCVEpjSeRFOEHN3bDuEOcMWL0Fp32HmEnEmQzHeo19JAhz7MbxzdCus5t
         qvLryGjiewAdkxX3E7399GnWNA6apQoqPuCG+9EeRHH9S0v2oYGbD/i5FLSt/lXUPVqw
         XStacpS6uYlCb5tEnocPapXGCR26RGqFRUiDXjzR6+YfVSI0uOfOchhMtDde2hBUfcGV
         snuIgKG3e6z/sZIjB+Ww09bm+aEDN01aWH9ngC8V2d4hU1Ylv6BeVkQqAei8cfm11o5J
         GyS2lBMMU8QK212e7QPz63J1QEvn1ONAC2CMyZxZZbNlj+Tzk9l8WqFGp78P1psxIcGE
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680733672; x=1683325672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7n6ZHU9DswArvev3x3C5JunnjxxD0aP7VI6Us40Ktk=;
        b=SOTpMasCFey2c+rWaKiXSW+4qj8u04jnuJAs3qlzcLiIku3zisyyjp0HnwRbSIkcUQ
         VqQmDR/5ktl3v4cA4SYq2woQNyc2wX4pj+3LJkvIP7Ued4MtAv/6zuCo8chAeyU6FECT
         ktV7GSFWJLjBJl7EpiX7PSMUjhsh4C0uNU4qqBGEYu5ZNH1XGWse+WoF2CzAEwxKULqL
         kTWi1NVJc4VvoCoTbS2EHC2b3eoNzYpCeBo2sEhNrK6WmDD8cOBCxzD4tQLR6u9Uag/F
         GCFYIShjtqkq0/zsdrsD5jK22X9QxCJsF+HTovcgFUooBaEme96p5QsW3lFL5nM8uIKh
         GO1g==
X-Gm-Message-State: AAQBX9cHsSCH5v4vmzVdj1IJXORMamJyE0BXzOwOQYcRKdErsTONEkBc
        bPx/c41ggYG77qgslK6Mr+Y2+Z9X5RMCDA==
X-Google-Smtp-Source: AKy350aW/XxRu2aHlmOxqyRBXU+NVVb4rYchkTGdm26FJ9DX6Cq+sHVZ3Mg5L79EC64kerClGYVKfg==
X-Received: by 2002:a17:902:d505:b0:1a1:b172:5428 with SMTP id b5-20020a170902d50500b001a1b1725428mr9894065plg.18.1680733671932;
        Wed, 05 Apr 2023 15:27:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709027b8200b0019ab3308554sm31508pll.85.2023.04.05.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:27:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        akpm@linux-foundation.org, kapil.hali@broadcom.com
Subject: [PATCH v2] scripts/gdb: add a Radix Tree Parser
Date:   Wed,  5 Apr 2023 15:27:43 -0700
Message-Id: <20230405222743.1191674-1-f.fainelli@gmail.com>
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
Changes in v2:

- guarded against a NULL node in the while loop

 scripts/gdb/linux/constants.py.in |  8 +++
 scripts/gdb/linux/radixtree.py    | 90 +++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |  1 +
 3 files changed, 99 insertions(+)
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
index 000000000000..074543ac763d
--- /dev/null
+++ b/scripts/gdb/linux/radixtree.py
@@ -0,0 +1,90 @@
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
+        if slot == 0:
+            return None
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

