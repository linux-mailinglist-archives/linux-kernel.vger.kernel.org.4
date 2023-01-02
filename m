Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118265AE11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjABIYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjABIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:24:28 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD62268
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:24:26 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3028OPsK023452;
        Mon, 2 Jan 2023 17:24:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 02 Jan 2023 17:24:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3028OODh023449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jan 2023 17:24:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Jan 2023 17:24:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzkaller-bugs@googlegroups.com
References: <00000000000060d41f05f139aa44@google.com>
 <20230102005409.3474-1-hdanton@sina.com>
 <CAHk-=wim+_xutuWdeykqM34EQxbE3As7+91L5uEVLUCXbUL1CA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wim+_xutuWdeykqM34EQxbE3As7+91L5uEVLUCXbUL1CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/02 10:40, Linus Torvalds wrote:
> So I think that we have:
> 
>  - ntfs_truncate()  gets the ni_lock (fs/ntfs3/file.c:393)
> 
>  - it then - while holding that lock - calls (on line 395):
> 
>       truncate_setsize ->
>          truncate_pagecache ->
>             truncate_inode_pages ->
>                truncate_inode_pages_range ->
>                   folio_lock
> 
> but that deadlocks on another process that wants to read that page,
> and that needs ni_lock to do so.
> 
> So yes, it does look like a ntfs3 deadlock involving ni_lock.

Yes, I think you are right. My patch confirmed that other threads are not
holding ni_lock lock, which means that this is a deadlock between
PG_locked bit and ni_lock lock.

filemap_update_page() calls filemap_read_folio() after calling
folio_trylock(). Since folio_trylock() sets PG_locked bit,

 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
 ntfs_get_block_vbo+0x374/0xd20 fs/ntfs3/inode.c:573
 do_mpage_readpage+0x98b/0x1bb0 fs/mpage.c:208
 mpage_read_folio+0x103/0x1d0 fs/mpage.c:379
 filemap_read_folio+0x1ba/0x7f0 mm/filemap.c:2426
 filemap_update_page+0x3ca/0x550 mm/filemap.c:2511
 filemap_get_pages+0x8d8/0x1110 mm/filemap.c:2624
 filemap_read+0x3e7/0xee0 mm/filemap.c:2694

is trying to take ni_lock after setting PG_locked bit.

On the other hand, folio_lock() waits until PG_locked bit is cleared,
but unfortunately ntfs3_setattr() already took ni_lock before calling
folio_lock().

 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
 folio_lock include/linux/pagemap.h:938 [inline]
 truncate_inode_pages_range+0xc8d/0x1650 mm/truncate.c:421
 truncate_inode_pages mm/truncate.c:448 [inline]
 truncate_pagecache mm/truncate.c:743 [inline]
 truncate_setsize+0xcb/0xf0 mm/truncate.c:768
 ntfs_truncate fs/ntfs3/file.c:395 [inline]
 ntfs3_setattr+0x5a5/0xca0 fs/ntfs3/file.c:696

Since no lockdep annotation is used for e.g. PG_locked bit, this deadlock
cannot be detected by lockdep...

