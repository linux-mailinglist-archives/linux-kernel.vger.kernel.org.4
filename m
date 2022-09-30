Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34C5F083E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiI3KHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiI3KHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:07:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBA1005F6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664532465; x=1696068465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tDWtMj2GvFVA4IHpATwIcizZYdM1TOn0Oc2oCI6pk6Y=;
  b=JSNXs0F6jjrxUlazyB9YB+g53jOiYYLt6a8HxIcEI2pdPZxDK+HH7guA
   AFn6i6Lij3LyVKKUIrovQ/A0Yc+zObhN5L2zuO2L0OnvPYzGJbxSdcK8j
   CJ09Vm6rlalJcw+wBa3UCNc/U2AzT3khlgg7bjsRbSQE+ic7JNT6iYYlq
   QzvQeXvDntIPFR/wa4hHjYl+w5PHf/kRuuEsD5E90rZNkGS3lbJkl1eG2
   Fe9vNRIfEtWY3VJM4oMkpuFeGoby/s8gTXzJDU/NOIOd+FwyAfnR2l31F
   p/PZMsD9wjvfwMzjCLuTSrjqC4SeTpqvDjbqEeqiZhJWDTKDc+ahzzZK7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303642343"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303642343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655905949"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655905949"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga001.jf.intel.com with ESMTP; 30 Sep 2022 03:07:41 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH -next] mm/slub: fix a slab missed to be freed problem  
Date:   Fri, 30 Sep 2022 18:07:30 +0800
Message-Id: <20220930100730.250248-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable kasan and kfence's in-kernel kunit test with slub_debug on,
it caught a problem (in linux-next tree):

 ------------[ cut here ]------------
 kmem_cache_destroy test: Slab cache still has objects when called from test_exit+0x1a/0x30
 WARNING: CPU: 3 PID: 240 at mm/slab_common.c:492 kmem_cache_destroy+0x16c/0x170
 Modules linked in:
 CPU: 3 PID: 240 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc7-next-20220929 #52
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:kmem_cache_destroy+0x16c/0x170
 Code: 41 5c 41 5d e9 a5 04 0b 00 c3 cc cc cc cc 48 8b 55 60 48 8b 4c 24 20 48 c7 c6 40 37 d2 82 48 c7 c7 e8 a0 33 83 e8 4e d7 14 01 <0f> 0b eb a7 41 56 41 89 d6 41 55 49 89 f5 41 54 49 89 fc 55 48 89
 RSP: 0000:ffff88800775fea0 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffffffff83bdec48 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 1ffff11000eebf9e RDI: ffffed1000eebfc6
 RBP: ffff88804362fa00 R08: ffffffff81182e58 R09: ffff88800775fbdf
 R10: ffffed1000eebf7b R11: 0000000000000001 R12: 000000008c800d00
 R13: ffff888005e78040 R14: 0000000000000000 R15: ffff888005cdfad0
 FS:  0000000000000000(0000) GS:ffff88807ed00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000000360e001 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  test_exit+0x1a/0x30
  kunit_try_run_case+0xad/0xc0
  kunit_generic_run_threadfn_adapter+0x26/0x50
  kthread+0x17b/0x1b0

It was biscted to commit c7323a5ad078 ("mm/slub: restrict sysfs
validation to debug caches and make it safe")

The problem is inside free_debug_processing(), in one path, the slab
on partial list is missed to be freed when partial list is full.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---

Hi reviewers,

Sorry for the late reporting, but it's curious that this problem didn't
show up in my earlier test (which caught some other problems).

 mm/slub.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5c3c31a154ba..4c037bd0b22b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2880,28 +2880,34 @@ static noinline void free_debug_processing(
 out:
 	if (checks_ok) {
 		void *prior = slab->freelist;
+		bool slab_need_discard = false;
 
 		/* Perform the actual freeing while we still hold the locks */
 		slab->inuse -= cnt;
 		set_freepointer(s, tail, prior);
 		slab->freelist = head;
 
-		/* Do we need to remove the slab from full or partial list? */
+		/*
+		 * If the slab is empty, and node's partial list is full,
+		 * it should be discarded anyway no matter it's on full or
+		 * partial list.
+		 */
+		if (slab->inuse == 0 && n->nr_partial >= s->min_partial) {
+			slab_need_discard = true;
+			slab_free = slab;
+		}
+
 		if (!prior) {
+			/* was on full list */
 			remove_full(s, n, slab);
-		} else if (slab->inuse == 0 &&
-			   n->nr_partial >= s->min_partial) {
+			if (!slab_need_discard) {
+				add_partial(n, slab, DEACTIVATE_TO_TAIL);
+				stat(s, FREE_ADD_PARTIAL);
+			}
+		} else if (slab_need_discard) {
 			remove_partial(n, slab);
 			stat(s, FREE_REMOVE_PARTIAL);
 		}
-
-		/* Do we need to discard the slab or add to partial list? */
-		if (slab->inuse == 0 && n->nr_partial >= s->min_partial) {
-			slab_free = slab;
-		} else if (!prior) {
-			add_partial(n, slab, DEACTIVATE_TO_TAIL);
-			stat(s, FREE_ADD_PARTIAL);
-		}
 	}
 
 	if (slab_free) {
-- 
2.34.1

