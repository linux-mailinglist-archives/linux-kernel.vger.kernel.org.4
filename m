Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786761F284
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiKGMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKGMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:07:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE41AD90
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:07:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z26so10426273pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlKkLNf+f0GZZEhCvr+/rnAvAoLWlo++kdBWW8O41G4=;
        b=P+pfmruj4cF/8d1NQcxAWxRPf1uKpe54sG4uyZHDg4J9JOzWFy0SI92FRS5lbsRDi9
         evSKpeAtGjvV3tPvfWsFzkpppH3Qufk4d8NpO44huMsB7a4C7lwHz9fy844Xsx1xB4yX
         vkzWsarfog5WkNCwQ7i2vPXJ9rVIxRwCZn1Rfu2Nm880Rpc4MSBZMajPiAm6EtSkdV7j
         tvsr3uuAfnSKCNd4eHQBa3jNK30tiUHtBSW0HEK2reuIAkZ0VnUgqdEQKWEUYIcQFo89
         hI+oatuHL+zDB2bB8LuX1nZnxWrFdWALYvYrqMu+ifEVo2/PYNBzHpXBdit0N3B1G7n8
         Rh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlKkLNf+f0GZZEhCvr+/rnAvAoLWlo++kdBWW8O41G4=;
        b=HRWk5JvktmL5jZ+4l1nh5mZveMeohEC/ktm6ZP4t2se64oiss9Ld0unsMgrXdXSlxc
         q7g7e5jhdHJgElzC6WIMmEVOIiBqwW4lqSAUn35ngLxGuIfpjKRbBPvH8blnX0O16CHy
         L0dsMxRa5hfVUaU7u0GCOpPmsuBhG5WN9lNUDLIQ6t0Z/bZlVJvaAEIqxRctpBKmefvi
         dzHeFKCpto+7a3CrSji03xj0KmQgCJi4d9/+bgFhEgH3v179YTPzsittS0I2eyxSz7ap
         1bjRCAo/UApLYabBTY80SH8iZphqLMRAdXQRyTZXjNgSavj6xdttvJkPil+2SUun0bhY
         1gog==
X-Gm-Message-State: ACrzQf3jNHhi35oRFcamAQOTPnFTSbbxJ7TNzTm9bylZ0engrrPpzNfx
        COn26kV7f5n7/LpmTB+51AqunA==
X-Google-Smtp-Source: AMsMyM4CzyeKsWEBK/mMuMLvUOEQVHYtpzVuIMV3800m3qtdV6sw7LGGSO7FP1hcYgmlLYiNGdcqJA==
X-Received: by 2002:a65:53c6:0:b0:46f:cbcb:7402 with SMTP id z6-20020a6553c6000000b0046fcbcb7402mr33594950pgr.366.1667822864988;
        Mon, 07 Nov 2022 04:07:44 -0800 (PST)
Received: from [10.254.17.120] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id i8-20020aa796e8000000b0056281da3bcbsm4462613pfq.149.2022.11.07.04.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:07:44 -0800 (PST)
Message-ID: <6c55a625-51f7-f27f-fc8f-c43a407e3aae@bytedance.com>
Date:   Mon, 7 Nov 2022 20:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [syzbot] WARNING in kernfs_find_and_get_node_by_id
Content-Language: en-US
To:     syzbot <syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <0000000000002473fd05eca7540a@google.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <0000000000002473fd05eca7540a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/5 00:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=101fe196880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf66e68f5f882c1074
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aa1051880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a863a6880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ea126f52b953/disk-f2f32f8a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/815b36048854/vmlinux-f2f32f8a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b7d04bb936fd/bzImage-f2f32f8a.xz
> 
> The issue was bisected to:
> 
> commit c25491747b21536bd56dccb82a109754bbc8d52c
> Author: Tejun Heo <tj@kernel.org>
> Date:   Sun Aug 28 05:04:37 2022 +0000
> 
>     kernfs: Add KERNFS_REMOVING flags
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106731ee880000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126731ee880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146731ee880000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
> Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3608 at fs/kernfs/dir.c:36 kernfs_find_and_get_node_by_id+0x1f0/0x270 fs/kernfs/dir.c:708

Looks like kernfs_find_and_get_node_by_id() didn't hold kernfs_rwsem before
call into kernfs_active(kn), so lockdep_assert_held() report this warning.

Since kernfs_find_and_get_node_by_id() doesn't need to get active count of kn,
should we just change back to previous conditions here?


diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6acd9c3d4cff..08f0f1570cd7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -705,7 +705,13 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
                        goto err_unlock;
        }

-       if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
+       /*
+        * ACTIVATED is protected with kernfs_mutex but it was clear when
+        * @kn was added to idr and we just wanna see it set.  No need to
+        * grab kernfs_mutex.
+        */
+       if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
+                    !atomic_inc_not_zero(&kn->count)))
                goto err_unlock;

        spin_unlock(&kernfs_idr_lock);


> Modules linked in:
> CPU: 1 PID: 3608 Comm: syz-executor714 Not tainted 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:kernfs_active fs/kernfs/dir.c:36 [inline]
> RIP: 0010:kernfs_find_and_get_node_by_id+0x1f0/0x270 fs/kernfs/dir.c:708
> Code: e8 25 fc 29 08 4c 89 f0 5b 41 5c 41 5e 41 5f 5d c3 e8 94 c9 74 ff e9 35 ff ff ff e8 8a c9 74 ff e9 2b ff ff ff e8 80 c9 74 ff <0f> 0b e9 2c ff ff ff 48 c7 c1 d4 e8 0d 8e 80 e1 07 80 c1 03 38 c1
> RSP: 0018:ffffc90003cdfb58 EFLAGS: 00010293
> RAX: ffffffff821316a0 RBX: 0000000000000000 RCX: ffff88802937d7c0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff821315ab R09: fffff5200079bf5c
> R10: fffff5200079bf5d R11: 1ffff9200079bf5c R12: dffffc0000000000
> R13: 0000000000000002 R14: ffff8881400f4570 R15: 0000000000000005
> FS:  00005555572ef300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 000000007806e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
>  kernfs_fh_to_dentry+0x129/0x1d0 fs/kernfs/mount.c:128
>  exportfs_decode_fh_raw+0x115/0x600 fs/exportfs/expfs.c:435
>  exportfs_decode_fh+0x38/0x70 fs/exportfs/expfs.c:575
>  do_handle_to_path fs/fhandle.c:152 [inline]
>  handle_to_path fs/fhandle.c:207 [inline]
>  do_handle_open+0x485/0x950 fs/fhandle.c:223
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f3991d2bbe9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff8481e4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3991d2bbe9
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
> RBP: 00007f3991cefd90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3991cefe20
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
