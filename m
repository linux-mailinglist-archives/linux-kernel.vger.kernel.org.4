Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9265AD39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjABF2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjABF2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:28:14 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D81034
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:28:11 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3025S9vP091847;
        Mon, 2 Jan 2023 14:28:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 02 Jan 2023 14:28:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3025RkdM091776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jan 2023 14:28:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <339a74c5-b2d5-1f89-180c-a9d93461ae02@I-love.SAKURA.ne.jp>
Date:   Mon, 2 Jan 2023 14:27:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
To:     Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>
References: <20230102005409.3474-1-hdanton@sina.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230102005409.3474-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/02 9:54, Hillf Danton wrote:
> Even though folio lock is printed in the call trace of syz-executor394/5222
> 
>    folio_lock include/linux/pagemap.h:938 [inline]
> 
> no lockdep radar exists for it in the sake of lock, which makes it harder
> than expected or impossible to find the cause of task hung reported.

Two sets of same pattern.


 #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
 #1: ffff888073930ca0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_update_page+0x72/0x550 mm/filemap.c:2478
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

 #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
 #1: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

 #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888073930b00 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: do_truncate+0x205/0x300 fs/open.c:63
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x596/0xca0 fs/ntfs3/file.c:696



 #0: ffff888021b06460 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
 #1: ffff888075aec7a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_update_page+0x72/0x550 mm/filemap.c:2478
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

 #0: ffff888018eead18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
 #1: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

 #0: ffff888021b06460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888075aec600 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: do_truncate+0x205/0x300 fs/open.c:63
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x596/0xca0 fs/ntfs3/file.c:696


But no hint for syz-executor394/8253.

>> 4 locks held by syz-executor394/8253:

I'd like to know what does 8253 is doing with what locks held.

https://lkml.kernel.org/r/c8893402-d1b2-9fad-3aad-d130c5f5923b@I-love.SAKURA.ne.jp
should help, but still no response from Peter nor Ingo.

Since this patch has an Ack from Waiman Long, may I send this patch to linux.git via my tree?

