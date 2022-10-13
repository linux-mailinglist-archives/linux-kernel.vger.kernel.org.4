Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28035FDC30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJMOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518844BA5D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665670470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CgdoHBqjiIu54Bh2pKl/m/OACsimqC4EZ1Br51DoPQ=;
        b=Kv6eziBvmbz41dogFbSnbAM8maIaiELbiE918VqvBtwFnix999SF0096iff9LP6laizwKL
        pekVHcp52FhNttXB48uuA9di3XqTd+cAqCi9Ng4DlcWWLqCy+5U12sHi0BIahm+CXMIxtd
        K4isqTZridtwRAGVKbfrAmKxvnN6BPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-Dm6mqwCFNvqD8S4vaYv4tA-1; Thu, 13 Oct 2022 09:53:01 -0400
X-MC-Unique: Dm6mqwCFNvqD8S4vaYv4tA-1
Received: by mail-wm1-f70.google.com with SMTP id q14-20020a7bce8e000000b003c6b7debf22so865564wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6CgdoHBqjiIu54Bh2pKl/m/OACsimqC4EZ1Br51DoPQ=;
        b=jWeBbd+Lk1sDBfBVdxDOTrcR1M9YUl6flXtTzOeNe7FaI4j0ofjnQJ/97Jk9/v85DP
         ZDbA2uU9SE47zk78/qO/5SCx6PGxMOJahRB93LI5dMEBYGBaXrYedoA5V5BuDFpDIsfw
         j2hoN6ZBW55b3MbkREZ8mOggh8G+q/taYdkA48odkzvM99RAHEnqzoM6A6pWZHZI50tg
         rP1mREzHGftVH7z3hF7YZyAJHjkGb8EXaOQd4L7ssK+7ZQU8XSXouv7Fm2Z/UqRVDsWM
         6mh9PXT5oS+w7cMzyijbDtDMKYnVGpFw3W/gtUP8LH0+QW9ZrOQc+fhjnM5rnT4r9baQ
         5IAw==
X-Gm-Message-State: ACrzQf0m60JV0QYfwV/O+yWXy/Nqjg1TSGHPyhnzMUfBiiU4GDW6dBXX
        udEDSMnKYRz4k7CyWW6TxeJUkjiUGSzW5NXySasxW7mCFEjSec+GQwNQ4xTpbuKj5xj4TtmVG8T
        m2d9yBK7oqvvIWDcbs4FwD3QA
X-Received: by 2002:a7b:cb8b:0:b0:3c5:9825:6f01 with SMTP id m11-20020a7bcb8b000000b003c598256f01mr6788439wmi.156.1665669180724;
        Thu, 13 Oct 2022 06:53:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63g07TR2PeauePQcxWx5DlyrDYFjZbmSyUboxQqqCe50kuZeVLsQAf1B5PkH1E0wWNSq1kBw==
X-Received: by 2002:a7b:cb8b:0:b0:3c5:9825:6f01 with SMTP id m11-20020a7bcb8b000000b003c598256f01mr6788421wmi.156.1665669180495;
        Thu, 13 Oct 2022 06:53:00 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id u3-20020a056000038300b00231910fa71asm2025152wrf.57.2022.10.13.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:52:59 -0700 (PDT)
Message-ID: <234e8b7e-1646-3bd0-1c3b-0936ddcb93bf@redhat.com>
Date:   Thu, 13 Oct 2022 14:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Cluster-devel] [syzbot] UBSAN: shift-out-of-bounds in
 gfs2_getbuf
Content-Language: en-US
To:     syzbot <syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com>
References: <000000000000b409e205eaea8714@google.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
From:   Andrew Price <anprice@redhat.com>
In-Reply-To: <000000000000b409e205eaea8714@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2022 14:31, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..

$ git describe --contains 493ffd6605b2
next-20221011~172

> git tree:       upstream

It would be useful to know the precise git tree.

> console output: https://syzkaller.appspot.com/x/log.txt?x=14620252880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=87a187973530ac822e3c
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com
> 
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/gfs2/meta_io.c:128:16

         shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
         index = blkno >> shift;             /* convert block to page */
         bufnum = blkno - (index << shift);  /* block buf index within 
page */

So likely fixed by commit 670f8ce56dd0632dc29a0322e188cc73ce3c6b92 
"gfs2: Check sb_bsize_shift after reading superblock" which has just 
been merged into mainline, but doesn't appear in next-20221011~172

Andy

> shift exponent 4294967293 is too large for 64-bit type 'u64' (aka 'unsigned long long')
> CPU: 0 PID: 10195 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:151 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
>   gfs2_getbuf+0x759/0x7d0 fs/gfs2/meta_io.c:128
>   gfs2_meta_read+0x153/0x910 fs/gfs2/meta_io.c:265
>   gfs2_meta_buffer+0x153/0x3a0 fs/gfs2/meta_io.c:491
>   gfs2_meta_inode_buffer fs/gfs2/meta_io.h:72 [inline]
>   gfs2_inode_refresh+0xab/0xe90 fs/gfs2/glops.c:472
>   gfs2_instantiate+0x15e/0x220 fs/gfs2/glock.c:515
>   gfs2_glock_holder_ready fs/gfs2/glock.c:1303 [inline]
>   gfs2_glock_wait+0x1d9/0x2a0 fs/gfs2/glock.c:1323
>   gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
>   gfs2_lookupi+0x40c/0x650 fs/gfs2/inode.c:306
>   gfs2_lookup_simple+0xec/0x170 fs/gfs2/inode.c:258
>   init_journal+0x19b/0x22c0 fs/gfs2/ops_fstype.c:739
>   init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:882
>   gfs2_fill_super+0x1ad8/0x2610 fs/gfs2/ops_fstype.c:1240
>   get_tree_bdev+0x400/0x620 fs/super.c:1323
>   gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1323
>   vfs_get_tree+0x88/0x270 fs/super.c:1530
>   do_new_mount+0x289/0xad0 fs/namespace.c:3040
>   do_mount fs/namespace.c:3383 [inline]
>   __do_sys_mount fs/namespace.c:3591 [inline]
>   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f0eed68cada
> Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0eee73cf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0eed68cada
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0eee73cfe0
> RBP: 00007f0eee73d020 R08: 00007f0eee73d020 R09: 0000000020000000
> R10: 0000000000000008 R11: 0000000000000202 R12: 0000000020000000
> R13: 0000000020000100 R14: 00007f0eee73cfe0 R15: 0000000020000080
>   </TASK>
> ================================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

