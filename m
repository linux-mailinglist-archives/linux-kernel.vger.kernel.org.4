Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9934C640AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiLBQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiLBQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:28:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FAE0ED;
        Fri,  2 Dec 2022 08:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB7EBB82149;
        Fri,  2 Dec 2022 16:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1367CC43470;
        Fri,  2 Dec 2022 16:27:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="K2mu/d0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669998453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=efvuuNTBLR4HLAxHYiJEHInfh40yYXX9WEzTI0HmGLg=;
        b=K2mu/d0hu0fuzeoZKXgWBK7i9x1nguVwSTDZXFuEa3J7bt0HjPrQQ9z0Xwa1mFBqiNMNvZ
        dmtf6N02mK4Q9NAL9afNBybBlywue7fSRDHHInpB8fOVOct1LuB2lxQ5gzsu8zpbNFgJ/J
        JqygsfBkKumNEQHAEK4/CX3G3WXIWe8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 228e8cf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Dec 2022 16:27:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH] mm: do not BUG_ON missing brk mapping, because userspace can unmap it
Date:   Fri,  2 Dec 2022 17:27:24 +0100
Message-Id: <20221202162724.2009-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following program will trigger the BUG_ON that this patch removes,
because the user can munmap() mm->brk:

  #include <sys/syscall.h>
  #include <sys/mman.h>
  #include <assert.h>
  #include <unistd.h>

  static void *brk_now(void)
  {
    return (void *)syscall(SYS_brk, 0);
  }

  static void brk_set(void *b)
  {
    assert(syscall(SYS_brk, b) != -1);
  }

  int main(int argc, char *argv[])
  {
    void *b = brk_now();
    brk_set(b + 4096);
    assert(munmap(b - 4096, 4096 * 2) == 0);
    brk_set(b);
    return 0;
  }

Compile that with musl, since glibc actually uses brk(), and then
execute it, and it'll hit this splat:

  kernel BUG at mm/mmap.c:229!
  invalid opcode: 0000 [#1] PREEMPT SMP
  CPU: 12 PID: 1379 Comm: a.out Tainted: G S   U             6.1.0-rc7+ #419
  RIP: 0010:__do_sys_brk+0x2fc/0x340
  Code: 00 00 4c 89 ef e8 04 d3 fe ff eb 9a be 01 00 00 00 4c 89 ff e8 35 e0 fe ff e9 6e ff ff ff 4d 89 a7 20>
  RSP: 0018:ffff888140bc7eb0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 00000000007e7000 RCX: ffff8881020fe000
  RDX: ffff8881020fe001 RSI: ffff8881955c9b00 RDI: ffff8881955c9b08
  RBP: 0000000000000000 R08: ffff8881955c9b00 R09: 00007ffc77844000
  R10: 0000000000000000 R11: 0000000000000001 R12: 00000000007e8000
  R13: 00000000007e8000 R14: 00000000007e7000 R15: ffff8881020fe000
  FS:  0000000000604298(0000) GS:ffff88901f700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000603fe0 CR3: 000000015ba9a005 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   do_syscall_64+0x2b/0x50
   entry_SYSCALL_64_after_hwframe+0x46/0xb0
  RIP: 0033:0x400678
  Code: 10 4c 8d 41 08 4c 89 44 24 10 4c 8b 01 8b 4c 24 08 83 f9 2f 77 0a 4c 8d 4c 24 20 4c 01 c9 eb 05 48 8b>
  RSP: 002b:00007ffc77863890 EFLAGS: 00000212 ORIG_RAX: 000000000000000c
  RAX: ffffffffffffffda RBX: 000000000040031b RCX: 0000000000400678
  RDX: 00000000004006a1 RSI: 00000000007e6000 RDI: 00000000007e7000
  RBP: 00007ffc77863900 R08: 0000000000000000 R09: 00000000007e6000
  R10: 00007ffc77863930 R11: 0000000000000212 R12: 00007ffc77863978
  R13: 00007ffc77863988 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

Instead, just error out if the original mapping has been removed.

Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c3c5c1d6103d..f5a37fe9a19e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -226,8 +226,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		/* Search one past newbrk */
 		mas_set(&mas, newbrk);
 		brkvma = mas_find(&mas, oldbrk);
-		BUG_ON(brkvma == NULL);
-		if (brkvma->vm_start >= oldbrk)
+		if (!brkvma || brkvma->vm_start >= oldbrk)
 			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
 		 * mm->brk must be protected by write mmap_lock.
-- 
2.38.1

