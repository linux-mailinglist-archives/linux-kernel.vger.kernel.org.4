Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D586672D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjALNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjALNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:04:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F14914A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jXccVwgifgiakCw/v67piF8vEizpd5h16zGTQvi/fvU=; b=MSxnYOCZ8hb5TPk/0o84Qhqm7L
        Z4HvzLvRZspGbNQPqF9JJYGc/gkTeVKCHBurzZS7fbocmO5DGws9xPHaGDjQ59x/k7Q84gjTp8TbF
        YqDxPPXuihepR9ViWBc7+5acQktkF9593Y6ln+sBv1Izrnb0rJKwherpwK7En3HthkjRyYbwwbIwH
        Wz165BHtOXxpSYHHjvmdHaa/GhRs7HO4UnuKixm8qqEMwD006XkXbqaND4NJ+1JnBlGtD1/J2GWfd
        kGILdm6DGyoBG74/EUoz9LFMpWkyF4AS3CizB92YZ/6ylNw1uCE4Gnw9JrLttbEU/twCrVu7ii2iI
        3AkDGJew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFxGT-0054RI-A8; Thu, 12 Jan 2023 13:05:05 +0000
Date:   Thu, 12 Jan 2023 13:05:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+fa6f2ee9039b87ef86c4@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [tmpfs?] kernel BUG in folio_flags
Message-ID: <Y8AFgZEEjnUIaCbf@casper.infradead.org>
References: <000000000000d9ae1305f20e89bd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d9ae1305f20e89bd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:25:39AM -0800, syzbot wrote:
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:317!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 10782 Comm: syz-executor.1 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:folio_flags.constprop.0+0x122/0x150 include/linux/page-flags.h:317
> Code: 52 ff ff ff e8 ff f2 cd ff 48 8d 43 ff 49 39 c4 0f 84 40 ff ff ff e8 ed f2 cd ff 48 c7 c6 40 0b 57 8a 4c 89 e7 e8 2e e4 05 00 <0f> 0b e8 57 c2 1b 00 e9 fe fe ff ff e8 4d c2 1b 00 eb a9 4c 89 e7
> RSP: 0018:ffffc90005437b00 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90014e22000
> RDX: 0000000000040000 RSI: ffffffff81b3ca02 RDI: 0000000000000000
> RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000b28100
> R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffffd400016502c
> FS:  00007f1e422fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005642ce910130 CR3: 000000001cef4000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  folio_test_head include/linux/page-flags.h:780 [inline]
>  folio_test_large include/linux/page-flags.h:801 [inline]
>  folio_nr_pages include/linux/mm.h:1735 [inline]
>  compound_nr include/linux/mm.h:1747 [inline]
>  zero_user_segments.constprop.0+0x262/0x350 include/linux/highmem.h:288
>  shmem_write_end+0x684/0x780 mm/shmem.c:2600

Oh, good one.  shmem isn't actually doing anything wrong here, but
it'll be nice to fix it.  (net -10 lines)

What's happening is that shmem is deliberately calling
zero_user_segments() on a tail page.  zero_user_segments() calls
compound_nr() which used to return 1 when called on a tail page but now
trips this assert.  I didn't intend this change of behaviour, so
let's start by fixing that.

Andrew, this is a fix for "mm: Reimplement compound_nr()".  I'll send
the shmem change separately since it's not a bug fix.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57d702fc8677..78f751f3ba5b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1741,10 +1741,22 @@ static inline long folio_nr_pages(struct folio *folio)
 #endif
 }
 
-/* Returns the number of pages in this potentially compound page. */
+/*
+ * compound_nr() returns the number of pages in this potentially compound
+ * page.  compound_nr() can be called on a tail page, and is defined to
+ * return 1 in that case.
+ */
 static inline unsigned long compound_nr(struct page *page)
 {
-	return folio_nr_pages((struct folio *)page);
+	struct folio *folio = (struct folio *)page;
+
+	if (!test_bit(PG_head, &folio->flags))
+		return 1;
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << folio->_folio_order;
+#endif
 }
 
 /**
@@ -1753,8 +1765,7 @@ static inline unsigned long compound_nr(struct page *page)
  */
 static inline int thp_nr_pages(struct page *page)
 {
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_nr(page);
+	return folio_nr_pages((struct folio *)page);
 }
 
 /**
