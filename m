Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508EC66B11F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 14:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjAONEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 08:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAONEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 08:04:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FA10AB5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OflZ+qPPmyu4/0ksKsMQFB1FTwiKPU7dLajlqvHnHXc=; b=nZVL/uED4tYGUG1ZzKICPtMhb+
        8ufwE71/TWHdWOk1X9kxIxRdb+016olcVgdsMfwWfMWF6hcXQT/E4fvZOaoVDok1h8LXYxBsAnObL
        PLrJhjWr6NgCYs/kmt55tEILTdd7pHMtnzsvsu5sk213bzF7qjaTbkLJqTWshgDwgr+9Vhd8zBIH5
        LeNeeTs8cNNfkehR+FzN9FmlGXZTdFWxDv97y4/eJCrs8YvGLKdgsNieSHCjZhBn5VuvIJTNZLe3m
        /okIw71SvyUzTfLZXAh4RwbJ/UfMMwdI2BZJVOi2ALtMLiMPEd3ncl6FD9RwrXpexWOWAr0fhdAR5
        6NWL5eUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pH2ge-007qS8-EQ; Sun, 15 Jan 2023 13:04:36 +0000
Date:   Sun, 15 Jan 2023 13:04:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8P55Ks8p8SL56VR@casper.infradead.org>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Oo3+9UmZ4ac8sW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Oo3+9UmZ4ac8sW@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 04:18:55PM +0900, Sergey Senozhatsky wrote:
> So this warning is move_to_new_folio() being called on un-isolated
> src folio. I had DEBUG_VM disabled so VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> did nothing, however after mops->migrate_page() it would trigger WARN_ON()
> because it evaluates folio_test_isolated(src) one more time:
> 
> [   59.500580] page:0000000097d97a42 refcount:2 mapcount:1665 mapping:0000000000000000 index:0xffffea00185ce940 pfn:0x113dc4
> [   59.503239] flags: 0x8000000000000001(locked|zone=2)
> [   59.505060] raw: 8000000000000001 ffffea00044f70c8 ffffc90000ba7c20 ffffffff81c22582
> [   59.507288] raw: ffffea00185ce940 ffff88809183fdb0 0000000200000680 0000000000000000

That is quite the messed-up page.  mapcount is positive, but higher than
refcount.  And not just a little bit; 1665 vs 2.  But mapping is NULL,
so it's not anon or file memory.  Makes me think it belongs to a driver
that's using ->mapcount for its own purposes.  It's not PageSlab.

Given that you're working on zsmalloc, I took a look and:

static inline void set_first_obj_offset(struct page *page, unsigned int offset)
{
        page->page_type = offset;
}

(page_type aliases with mapcount).  So I'm pretty sure this is a
zsmalloc page.  But mapping should point to zsmalloc_mops.  Not
really sure what's going on here.  Can you bisect?

> [   59.509622] page dumped because: VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> [   59.511845] ------------[ cut here ]------------
> [   59.513181] kernel BUG at mm/migrate.c:988!
> [   59.514821] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> 
> [   59.523018] RIP: 0010:move_to_new_folio+0x362/0x3b0
> [   59.524160] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b b8 f5 ff
> [   59.528349] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
> [   59.529551] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
> [   59.531186] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
> [   59.532790] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
> [   59.534392] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
> [   59.536026] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
> [   59.537646] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
> [   59.539484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.540785] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
> [   59.542412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   59.544030] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   59.545637] PKRU: 55555554
> [   59.546261] Call Trace:
> [   59.546833]  <TASK>
> [   59.547371]  ? lock_is_held_type+0xd9/0x130
> [   59.548331]  migrate_pages_batch+0x650/0xdc0
> [   59.549326]  ? move_freelist_tail+0xc0/0xc0
> [   59.550281]  ? isolate_freepages+0x290/0x290
> [   59.551289]  ? folio_flags.constprop.0+0x50/0x50
> [   59.552348]  migrate_pages+0x3fa/0x4d0
> [   59.553224]  ? isolate_freepages+0x290/0x290
> [   59.554214]  ? move_freelist_tail+0xc0/0xc0
> [   59.555173]  compact_zone+0x51b/0x6a0
> [   59.556031]  proactive_compact_node+0x8e/0xe0
> [   59.557033]  kcompactd+0x1c3/0x350
> [   59.557842]  ? swake_up_all+0xe0/0xe0
> [   59.558699]  ? kcompactd_do_work+0x260/0x260
> [   59.559703]  kthread+0xec/0x110
> [   59.560450]  ? kthread_complete_and_exit+0x20/0x20
> [   59.561582]  ret_from_fork+0x1f/0x30
> [   59.562427]  </TASK>
> [   59.562966] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
> [   59.564591] ---[ end trace 0000000000000000 ]---
> [   59.565661] RIP: 0010:move_to_new_folio+0x362/0x3b0
> [   59.566802] Code: ff ff e9 55 fd ff ff 48 89 df e8 69 d8 ff ff f0 80 60 02 fb 31 c0 e9 65 fd ff ff 48 c7 c6 00 f5 e9 81 48 89 df e8 be c0 f9 ff <0f> 0b 48 c7 c6 00 f5 e9 81 48 89 df e8 ad c0 f9 ff 0f 0b b8 f5 ff
> [   59.571048] RSP: 0018:ffffc90000ba7af8 EFLAGS: 00010246
> [   59.572257] RAX: 000000000000003f RBX: ffffea00044f7100 RCX: 0000000000000000
> [   59.573906] RDX: 0000000000000000 RSI: ffffffff81e8dcf1 RDI: 00000000ffffffff
> [   59.575544] RBP: ffffea00184f1140 R08: 00000000ffffbfff R09: 00000000ffffbfff
> [   59.577236] R10: ffff888621ca0000 R11: ffff888621ca0000 R12: 8000000000000001
> [   59.578893] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea00184f1140
> [   59.580593] FS:  0000000000000000(0000) GS:ffff888626a00000(0000) knlGS:0000000000000000
> [   59.582432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.583767] CR2: 00007ff7fbed8000 CR3: 0000000101a26001 CR4: 0000000000770ee0
> [   59.585437] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   59.587082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   59.588738] PKRU: 55555554
