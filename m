Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2774C635
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjGIPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjGIPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A06171F;
        Sun,  9 Jul 2023 08:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D0860C4A;
        Sun,  9 Jul 2023 15:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C30CC433CB;
        Sun,  9 Jul 2023 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915762;
        bh=8IWUj6y3H6Ha2yGWyqLs1YGPvD5wgjSl19LTfDQUppo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qj/jSfs1iDEAkWOMLxWt/Ru3fcZSc7l526qJX9N12eLtIIxqdQ3qwd3X8c1W/4ynk
         EnldhwAWmMorIF2+xNQ9SaoTQw6MSZ46DODo111FVoUQfod1BRDQgEau9hTCbu7b30
         AB4mMWDb7quH7vu95+oT7vqTH0uIkVkgu3PkJOhNm37qvt1GTnZNxlEfS2b3zrk9TD
         ljFGmeejp3WEiAp771AqVHyeeqYBJeP7KYXqpjG4gUOFejv0Nv4+COqfpc61ZF3BEm
         nIUfoxciXxxCqUInpg8BB0FGvWmrJxc7POutg3uCbxp5SvVTEUDo+ytJc1YtW8Vd/V
         Dxr3AJe9jxlug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, martin.lau@linux.dev,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/7] bpf: Address KCSAN report on bpf_lru_list
Date:   Sun,  9 Jul 2023 11:15:51 -0400
Message-Id: <20230709151555.513910-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151555.513910-1-sashal@kernel.org>
References: <20230709151555.513910-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit ee9fd0ac3017c4313be91a220a9ac4c99dde7ad4 ]

KCSAN reported a data-race when accessing node->ref.
Although node->ref does not have to be accurate,
take this chance to use a more common READ_ONCE() and WRITE_ONCE()
pattern instead of data_race().

There is an existing bpf_lru_node_is_ref() and bpf_lru_node_set_ref().
This patch also adds bpf_lru_node_clear_ref() to do the
WRITE_ONCE(node->ref, 0) also.

==================================================================
BUG: KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_update_elem

write to 0xffff888137038deb of 1 bytes by task 11240 on cpu 1:
__bpf_lru_node_move kernel/bpf/bpf_lru_list.c:113 [inline]
__bpf_lru_list_rotate_active kernel/bpf/bpf_lru_list.c:149 [inline]
__bpf_lru_list_rotate+0x1bf/0x750 kernel/bpf/bpf_lru_list.c:240
bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:329 [inline]
bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
bpf_lru_pop_free+0x638/0xe20 kernel/bpf/bpf_lru_list.c:499
prealloc_lru_pop kernel/bpf/hashtab.c:290 [inline]
__htab_lru_percpu_map_update_elem+0xe7/0x820 kernel/bpf/hashtab.c:1316
bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
__sys_bpf+0x338/0x810
__do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888137038deb of 1 bytes by task 11241 on cpu 0:
bpf_lru_node_set_ref kernel/bpf/bpf_lru_list.h:70 [inline]
__htab_lru_percpu_map_update_elem+0x2f1/0x820 kernel/bpf/hashtab.c:1332
bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
__sys_bpf+0x338/0x810
__do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11241 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00136-g6a66fdd29ea1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================

Reported-by: syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20230511043748.1384166-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_lru_list.c | 21 +++++++++++++--------
 kernel/bpf/bpf_lru_list.h |  7 ++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index d99e89f113c43..3dabdd137d102 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -41,7 +41,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -89,7 +94,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -110,7 +115,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -353,7 +358,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -419,7 +424,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -522,7 +527,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -568,7 +573,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -594,7 +599,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 6b12f06ee18c3..9c12ee453c616 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -63,11 +63,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
-- 
2.39.2

