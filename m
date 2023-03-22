Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B786E6C418C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCVEZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCVEZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:25:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FC2597B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:25:20 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32M4PHDa005049;
        Wed, 22 Mar 2023 13:25:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 22 Mar 2023 13:25:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32M4PHtS005046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Mar 2023 13:25:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3912432e-bdf7-323a-03c6-46bb1e288b54@I-love.SAKURA.ne.jp>
Date:   Wed, 22 Mar 2023 13:25:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [syzbot] [dri?] BUG: sleeping function called from invalid
 context in _vm_unmap_aliases
Content-Language: en-US
To:     syzbot <syzbot+a9a2bb6afe9eb31efc56@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
References: <0000000000006dc0c105f76c0a72@google.com>
Cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000006dc0c105f76c0a72@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c53e98934f93 ("mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock")
is broken. We can't take mutex (a sleeping lock) inside RCU read section (an atomic context).


@@ -2183,7 +2184,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)

                rcu_read_lock();
                list_for_each_entry_rcu(vb, &vbq->free, free_list) {
-                       spin_lock(&vb->lock);
+                       mutex_lock(&vb->lock);
                        if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
                                unsigned long va_start = vb->va->va_start;
                                unsigned long s, e;
@@ -2196,7 +2197,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)

                                flush = 1;
                        }
-                       spin_unlock(&vb->lock);
+                       mutex_unlock(&vb->lock);
                }
                rcu_read_unlock();
        }

#syz set subsystems: mm

On 2023/03/22 2:04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f3594f0204b7 Add linux-next specific files for 20230321
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=161552eec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f22105589e896af1
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9a2bb6afe9eb31efc56
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0b755145006a/disk-f3594f02.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fca26e328a81/vmlinux-f3594f02.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/39744d7d289f/bzImage-f3594f02.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a9a2bb6afe9eb31efc56@syzkaller.appspotmail.com
> 

