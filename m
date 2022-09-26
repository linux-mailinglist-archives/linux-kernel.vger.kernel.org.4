Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD46F5EAC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIZQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiIZQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:28:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA9710CA70
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:17:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ocprT-0006De-Tm; Mon, 26 Sep 2022 17:17:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        urezki@gmail.com, linux-kernel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>,
        Martin Zaharinov <micron10@gmail.com>
Subject: [PATCH v2 mm] mm: fix BUG splat with kvmalloc + GFP_ATOMIC
Date:   Mon, 26 Sep 2022 17:16:50 +0200
Message-Id: <20220926151650.15293-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zaharinov reports BUG with 5.19.10 kernel:
 kernel BUG at mm/vmalloc.c:2437!
 invalid opcode: 0000 [#1] SMP
 CPU: 28 PID: 0 Comm: swapper/28 Tainted: G        W  O      5.19.9 #1
 [..]
 RIP: 0010:__get_vm_area_node+0x120/0x130
  __vmalloc_node_range+0x96/0x1e0
  kvmalloc_node+0x92/0xb0
  bucket_table_alloc.isra.0+0x47/0x140
  rhashtable_try_insert+0x3a4/0x440
  rhashtable_insert_slow+0x1b/0x30
 [..]

bucket_table_alloc uses kvzalloc(GPF_ATOMIC).  If kmalloc fails, this now
falls through to vmalloc and hits code paths that assume GFP_KERNEL.

Reported-by: Martin Zaharinov <micron10@gmail.com>
Fixes: a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
Suggested-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/linux-mm/Yy3MS2uhSgjF47dy@pc636/T/#t
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 mm/util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index c9439c66d8cf..346e40177bc6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -619,6 +619,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
+	/* non-sleeping allocations are not supported by vmalloc */
+	if (!gfpflags_allow_blocking(flags))
+		return NULL;
+
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
-- 
2.35.1

