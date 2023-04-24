Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E060A6EBAA4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDVRVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDVRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:21:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2D26A4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:21:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a92513abebso35508175ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1682184063; x=1684776063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FJOs3OgQ07yf3+hDEA2+RrfrAOFmryC2vewFSj4aMk=;
        b=i5c6LTZm+DFQOsjSlV5vYFo9nI52OylKAXxH7O0tMdmWwqKnu6lX2qw1KgaWKb9ZvG
         XD5Au8AThDtCMpejWWlEm6gzD7TwvzBQ92EnbDOeDHlIL0EdjCMZv8/gosyhtLUi+k74
         lzJoAdqfYOO/yT4hmApcyELG6RqMMZOrqXPCnMvbf+sX1koxp0Ll7V4CWL5R+mZJViQQ
         oPC/Gqpv5glO4afuO0dSo4QXmNcje28zyTIA8/kOrthrkno95bw0a2jlpVVm+YstTjsk
         RhvAiYOlxI284TLTDEU4rHt5w6rsIt1MT77XCfV6hqByKa2WTHtFRrVq+WYy05nlbJPd
         l2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682184063; x=1684776063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FJOs3OgQ07yf3+hDEA2+RrfrAOFmryC2vewFSj4aMk=;
        b=N860+kiPEI+cphCVRBP6zuHPQXtQxJmRE/60WG51vWoh+TnJQfKbV3d4XFVwL9rvyj
         Whe1Zf7nIJVrjB0fW+Yl03EjviLv+JiAQkRPU+XN3QJBthfeL9ryU2Srfq2b+ZfBQ32i
         2t/sc98DpBuyLwOnjfraIvhxpJdDVp8XpAIr/+oXeTqTQgfRkHoFni7fzS4nvUkiTzxL
         Gfn50bKtWPiAOYqxdb0P7GFh9pjm9zQ9jxKLxH+cljZPFn0bhcAWsZqABu8ld3P+ZbEh
         Y9skpw7fvL7AvgXDnApmaHguJmbotYpYdIJUqPV3QdgdUCm8HdiKzZ8gZKWxIgWegFWD
         +aFg==
X-Gm-Message-State: AAQBX9eqM8veeCGgeMuCEMOgUzfMCjluvL41b8YwhX+c4asEZHsWF+8y
        Ii16F8I11t0mvLszMfxxqG09jQBjYohv5o7zBwpmhQ==
X-Google-Smtp-Source: AKy350Y579tvoY0uJcbuZabP16QOmEMgZIlJc7xqwuiIupxztjZu9gHbTKYx+p++e92dKrA6Wy28tg==
X-Received: by 2002:a17:903:1c4:b0:1a2:9183:a49c with SMTP id e4-20020a17090301c400b001a29183a49cmr11059470plh.32.1682184063616;
        Sat, 22 Apr 2023 10:21:03 -0700 (PDT)
Received: from carnotaurus.. (c-73-252-184-87.hsd1.ca.comcast.net. [73.252.184.87])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b001a04ff0e2eesm4261673plk.58.2023.04.22.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 10:21:03 -0700 (PDT)
From:   Joe Stringer <joe@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com, john.fastabend@gmail.com
Subject: [PATCH bpf-next v5 2/2] docs/bpf: Add LRU internals description and graph
Date:   Sat, 22 Apr 2023 10:20:54 -0700
Message-Id: <20230422172054.3355436-2-joe@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230422172054.3355436-1-joe@isovalent.com>
References: <20230422172054.3355436-1-joe@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the bpf hashmap docs to include a brief description of the
internals of the LRU map type (setting appropriate API expectations),
including the original commit message from Martin and a variant on the
graph that I had presented during my Linux Plumbers Conference 2022 talk
on "Pressure feedback for LRU map types"[0].

The node names in the dot file correspond roughly to the functions where
the logic for those decisions or steps is defined, to help curious
developers to cross-reference and update this logic if the details of
the LRU implementation ever differ from this description.

[0]: https://lpc.events/event/16/contributions/1368/

Signed-off-by: Joe Stringer <joe@isovalent.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
v5: Fix warning for use of 'label' attribute
v4: Move UAPI descriptions outside of the internals section
    Fix function reference discrepancies in dot source
    Fix incorrect flag references (missing F_)
    Simplify logic at bottom of graph for map updates
    Add missing return codes to graph for failure cases
v3: Use standard table syntax
    Replace inline commit message with reference to commit
    Fix incorrect Y/N label for common LRU check
    Rename some dotfile variables to reduce confusion between cases
    Minor wording touchups
v2: Fix issue that caused initial email submission to fail
---
 Documentation/bpf/map_hash.rst            |  42 ++++++
 Documentation/bpf/map_lru_hash_update.dot | 172 ++++++++++++++++++++++
 2 files changed, 214 insertions(+)
 create mode 100644 Documentation/bpf/map_lru_hash_update.dot

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index 1314dfc5e7e1..d2343952f2cb 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 .. Copyright (C) 2022 Red Hat, Inc.
+.. Copyright (C) 2022-2023 Isovalent, Inc.
 
 ===============================================
 BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
@@ -215,3 +216,44 @@ Userspace walking the map elements from the map declared above:
                     cur_key = &next_key;
             }
     }
+
+Internals
+=========
+
+This section of the document is targeted at Linux developers and describes
+aspects of the map implementations that are not considered stable ABI. The
+following details are subject to change in future versions of the kernel.
+
+``BPF_MAP_TYPE_LRU_HASH`` and variants
+--------------------------------------
+
+Updating elements in LRU maps may trigger eviction behaviour when the capacity
+of the map is reached. There are various steps that the update algorithm
+attempts in order to enforce the LRU property which have increasing impacts on
+other CPUs involved in the following operation attempts:
+
+- Attempt to use CPU-local state to batch operations
+- Attempt to fetch free nodes from global lists
+- Attempt to pull any node from a global list and remove it from the hashmap
+- Attempt to pull any node from any CPU's list and remove it from the hashmap
+
+This algorithm is described visually in the following diagram. See the
+description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanation of
+the corresponding operations:
+
+.. kernel-figure::  map_lru_hash_update.dot
+   :alt:    Diagram outlining the LRU eviction steps taken during map update.
+
+   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
+   variants. See the dot file source for kernel function name code references.
+
+Map updates start from the oval in the top right "begin ``bpf_map_update()``"
+and progress through the graph towards the bottom where the result may be
+either a successful update or a failure with various error codes. The key in
+the top right provides indicators for which locks may be involved in specific
+operations. This is intended as a visual hint for reasoning about how map
+contention may impact update operations, though the map type and flags may
+impact the actual contention on those locks, based on the logic described in
+the table above. For instance, if the map is created with type
+``BPF_MAP_TYPE_LRU_PERCPU_HASH`` and flags ``BPF_F_NO_COMMON_LRU`` then all map
+properties would be per-cpu.
diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
new file mode 100644
index 000000000000..a0fee349d29c
--- /dev/null
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022-2023 Isovalent, Inc.
+digraph {
+  node [colorscheme=accent4,style=filled] # Apply colorscheme to all nodes
+  graph [splines=ortho, nodesep=1]
+
+  subgraph cluster_key {
+    label = "Key\n(locks held during operation)";
+    rankdir = TB;
+
+    remote_lock [shape=rectangle,fillcolor=4,label="remote CPU LRU lock"]
+    hash_lock [shape=rectangle,fillcolor=3,label="hashtab lock"]
+    lru_lock [shape=rectangle,fillcolor=2,label="LRU lock"]
+    local_lock [shape=rectangle,fillcolor=1,label="local CPU LRU lock"]
+    no_lock [shape=rectangle,label="no locks held"]
+  }
+
+  begin [shape=oval,label="begin\nbpf_map_update()"]
+
+  // Nodes below with an 'fn_' prefix are roughly labeled by the C function
+  // names that initiate the corresponding logic in kernel/bpf/bpf_lru_list.c.
+  // Number suffixes and errno suffixes handle subsections of the corresponding
+  // logic in the function as of the writing of this dot.
+
+  // cf. __local_list_pop_free() / bpf_percpu_lru_pop_free()
+  local_freelist_check [shape=diamond,fillcolor=1,
+    label="Local freelist\nnode available?"];
+  use_local_node [shape=rectangle,
+    label="Use node owned\nby this CPU"]
+
+  // cf. bpf_lru_pop_free()
+  common_lru_check [shape=diamond,
+    label="Map created with\ncommon LRU?\n(!BPF_F_NO_COMMON_LRU)"];
+
+  fn_bpf_lru_list_pop_free_to_local [shape=rectangle,fillcolor=2,
+    label="Flush local pending,
+    Rotate Global list, move
+    LOCAL_FREE_TARGET
+    from global -> local"]
+  // Also corresponds to:
+  // fn__local_list_flush()
+  // fn_bpf_lru_list_rotate()
+  fn___bpf_lru_node_move_to_free[shape=diamond,fillcolor=2,
+    label="Able to free\nLOCAL_FREE_TARGET\nnodes?"]
+
+  fn___bpf_lru_list_shrink_inactive [shape=rectangle,fillcolor=3,
+    label="Shrink inactive list
+      up to remaining
+      LOCAL_FREE_TARGET
+      (global LRU -> local)"]
+  fn___bpf_lru_list_shrink [shape=diamond,fillcolor=2,
+    label="> 0 entries in\nlocal free list?"]
+  fn___bpf_lru_list_shrink2 [shape=rectangle,fillcolor=2,
+    label="Steal one node from
+      inactive, or if empty,
+      from active global list"]
+  fn___bpf_lru_list_shrink3 [shape=rectangle,fillcolor=3,
+    label="Try to remove\nnode from hashtab"]
+
+  local_freelist_check2 [shape=diamond,label="Htab removal\nsuccessful?"]
+  common_lru_check2 [shape=diamond,
+    label="Map created with\ncommon LRU?\n(!BPF_F_NO_COMMON_LRU)"];
+
+  subgraph cluster_remote_lock {
+    label = "Iterate through CPUs\n(start from current)";
+    style = dashed;
+    rankdir=LR;
+
+    local_freelist_check5 [shape=diamond,fillcolor=4,
+      label="Steal a node from\nper-cpu freelist?"]
+    local_freelist_check6 [shape=rectangle,fillcolor=4,
+      label="Steal a node from
+        (1) Unreferenced pending, or
+        (2) Any pending node"]
+    local_freelist_check7 [shape=rectangle,fillcolor=3,
+      label="Try to remove\nnode from hashtab"]
+    fn_htab_lru_map_update_elem [shape=diamond,
+      label="Stole node\nfrom remote\nCPU?"]
+    fn_htab_lru_map_update_elem2 [shape=diamond,label="Iterated\nall CPUs?"]
+    // Also corresponds to:
+    // use_local_node()
+    // fn__local_list_pop_pending()
+  }
+
+  fn_bpf_lru_list_pop_free_to_local2 [shape=rectangle,
+    label="Use node that was\nnot recently referenced"]
+  local_freelist_check4 [shape=rectangle,
+    label="Use node that was\nactively referenced\nin global list"]
+  fn_htab_lru_map_update_elem_ENOMEM [shape=oval,label="return -ENOMEM"]
+  fn_htab_lru_map_update_elem3 [shape=rectangle,
+    label="Use node that was\nactively referenced\nin (another?) CPU's cache"]
+  fn_htab_lru_map_update_elem4 [shape=rectangle,fillcolor=3,
+    label="Update hashmap\nwith new element"]
+  fn_htab_lru_map_update_elem5 [shape=oval,label="return 0"]
+  fn_htab_lru_map_update_elem_EBUSY [shape=oval,label="return -EBUSY"]
+  fn_htab_lru_map_update_elem_EEXIST [shape=oval,label="return -EEXIST"]
+  fn_htab_lru_map_update_elem_ENOENT [shape=oval,label="return -ENOENT"]
+
+  begin -> local_freelist_check
+  local_freelist_check -> use_local_node [xlabel="Y"]
+  local_freelist_check -> common_lru_check [xlabel="N"]
+  common_lru_check -> fn_bpf_lru_list_pop_free_to_local [xlabel="Y"]
+  common_lru_check -> fn___bpf_lru_list_shrink_inactive [xlabel="N"]
+  fn_bpf_lru_list_pop_free_to_local -> fn___bpf_lru_node_move_to_free
+  fn___bpf_lru_node_move_to_free ->
+    fn_bpf_lru_list_pop_free_to_local2 [xlabel="Y"]
+  fn___bpf_lru_node_move_to_free ->
+    fn___bpf_lru_list_shrink_inactive [xlabel="N"]
+  fn___bpf_lru_list_shrink_inactive -> fn___bpf_lru_list_shrink
+  fn___bpf_lru_list_shrink -> fn_bpf_lru_list_pop_free_to_local2 [xlabel = "Y"]
+  fn___bpf_lru_list_shrink -> fn___bpf_lru_list_shrink2 [xlabel="N"]
+  fn___bpf_lru_list_shrink2 -> fn___bpf_lru_list_shrink3
+  fn___bpf_lru_list_shrink3 -> local_freelist_check2
+  local_freelist_check2 -> local_freelist_check4 [xlabel = "Y"]
+  local_freelist_check2 -> common_lru_check2 [xlabel = "N"]
+  common_lru_check2 -> local_freelist_check5 [xlabel = "Y"]
+  common_lru_check2 -> fn_htab_lru_map_update_elem_ENOMEM [xlabel = "N"]
+  local_freelist_check5 -> fn_htab_lru_map_update_elem [xlabel = "Y"]
+  local_freelist_check5 -> local_freelist_check6 [xlabel = "N"]
+  local_freelist_check6 -> local_freelist_check7
+  local_freelist_check7 -> fn_htab_lru_map_update_elem
+
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem3 [xlabel = "Y"]
+  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem2  [xlabel = "N"]
+  fn_htab_lru_map_update_elem2 ->
+    fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
+  fn_htab_lru_map_update_elem2 -> local_freelist_check5 [xlabel = "N"]
+  fn_htab_lru_map_update_elem3 -> fn_htab_lru_map_update_elem4
+
+  use_local_node -> fn_htab_lru_map_update_elem4
+  fn_bpf_lru_list_pop_free_to_local2 -> fn_htab_lru_map_update_elem4
+  local_freelist_check4 -> fn_htab_lru_map_update_elem4
+
+  fn_htab_lru_map_update_elem4 -> fn_htab_lru_map_update_elem5 [headlabel="Success"]
+  fn_htab_lru_map_update_elem4 ->
+    fn_htab_lru_map_update_elem_EBUSY [xlabel="Hashtab lock failed"]
+  fn_htab_lru_map_update_elem4 ->
+    fn_htab_lru_map_update_elem_EEXIST [xlabel="BPF_EXIST set and\nkey already exists"]
+  fn_htab_lru_map_update_elem4 ->
+    fn_htab_lru_map_update_elem_ENOENT [headlabel="BPF_NOEXIST set\nand no such entry"]
+
+  // Create invisible pad nodes to line up various nodes
+  pad0 [style=invis]
+  pad1 [style=invis]
+  pad2 [style=invis]
+  pad3 [style=invis]
+  pad4 [style=invis]
+
+  // Line up the key with the top of the graph
+  no_lock -> local_lock [style=invis]
+  local_lock -> lru_lock [style=invis]
+  lru_lock -> hash_lock [style=invis]
+  hash_lock -> remote_lock [style=invis]
+  remote_lock -> local_freelist_check5 [style=invis]
+  remote_lock -> fn___bpf_lru_list_shrink [style=invis]
+
+  // Line up return code nodes at the bottom of the graph
+  fn_htab_lru_map_update_elem -> pad0 [style=invis]
+  pad0 -> pad1 [style=invis]
+  pad1 -> pad2 [style=invis]
+  //pad2-> fn_htab_lru_map_update_elem_ENOMEM [style=invis]
+  fn_htab_lru_map_update_elem4 -> pad3 [style=invis]
+  pad3 -> fn_htab_lru_map_update_elem5  [style=invis]
+  pad3 -> fn_htab_lru_map_update_elem_EBUSY  [style=invis]
+  pad3 -> fn_htab_lru_map_update_elem_EEXIST  [style=invis]
+  pad3 -> fn_htab_lru_map_update_elem_ENOENT  [style=invis]
+
+  // Reduce diagram width by forcing some nodes to appear above others
+  local_freelist_check4 -> fn_htab_lru_map_update_elem3 [style=invis]
+  common_lru_check2 -> pad4 [style=invis]
+  pad4 -> local_freelist_check5 [style=invis]
+}
-- 
2.34.1

