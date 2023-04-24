Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25736EC748
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjDXHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDXHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:40:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0BBE65
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:40:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so10690e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682322015; x=1684914015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/4INAiEvkL/u4SkUH+rP897Ygm75rqLZWEjOieY3Sk=;
        b=GI+B9KLyC192d3zh+6AWwPGb0iKi8EeEovn5mp0zbmbCiBnLdD3awniUO2VvoqFmr3
         dumVOxIy13GHs/+yAsCbAcCgq1sqj2QF8kwfRLSgNEZfW2RQ+B+45TMB+jOqDq3h3GNA
         eu2thKPob7VJwiy8O7NV0L2DaMS7rFMZ8Jjv71wHEwCBAW7VZ/3XJHhp8HEqy/WOGJqQ
         up9YGgqfAIZwICgAUuHZ5H6X4PlEg5cxKGZny/3T9NU3Iz6TRQjWaqu9lnG+cZ0GAN4r
         Jrb0wq1DSVPpnAfejleuoaxfty5iuA/zU63hGR0ZWLaooZ0KE/TsnMAfIZ0iM6/VhGd2
         033w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322015; x=1684914015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/4INAiEvkL/u4SkUH+rP897Ygm75rqLZWEjOieY3Sk=;
        b=kstbS9AsTEPjtwvy+ATTclrSmWMB1aw7kIDxJJw5s2HUpuiyttjt/5/gkBfMMxKRd9
         rem5SaPhhn3sXzh9cBZAYNwNBf5CGkWV15RdGnRqSra15unRm9zi6323DcTWCDR6XNCN
         FRhs47J5mgnSk+6INWwqbzRtIQ60/3Zyno4+xSeVkNbQR6fMPF8qQGxuEjLv/gG+LGyE
         Clg7w76yz4tiWH61fzCQsxSL5B/E+XqLlf1mHDp0PtOH5ywjGkOVx5eBVx8XXTjCGNO0
         qt9V3Ag/8Y/2ME25e2msh+Kr29kG8AitJDK3FnfTbyCSRrV+Ivc81E1Pm69uyDyOFBkP
         P4uQ==
X-Gm-Message-State: AAQBX9eFRQ7XQT/4GGUUhCk49E5RZ5/mkilALaM//4v+bcpN/dmJegjo
        euJAtMUfoMLHPsMFwqY3AEmHO29u1Kob+1kkkVbbcg==
X-Google-Smtp-Source: AKy350bMbpgql9DEzPColxG4ITLZ5/uJ4hQDUoQddc35HJeGMhejawKhweoTCuJUHj7HqywaEtq2WRyi8zd6iULyV94=
X-Received: by 2002:a05:6512:3ca2:b0:4ed:b0bd:a96c with SMTP id
 h34-20020a0565123ca200b004edb0bda96cmr217656lfv.6.1682322015348; Mon, 24 Apr
 2023 00:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007470fe05fa0fd8ba@google.com>
In-Reply-To: <0000000000007470fe05fa0fd8ba@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:40:03 +0200
Message-ID: <CACT4Y+ZyBsAhdE3joUMQ+AtPukws3kDMirAKBqGg+VXgZKEpQQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] KCSAN: data-race in __filemap_add_folio /
 invalidate_bdev (3)
To:     syzbot <syzbot+8a416e3cb063d4787b0f@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 at 09:20, syzbot
<syzbot+8a416e3cb063d4787b0f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3e7bb4f24617 Merge tag '6.3-rc6-smb311-client-negcontext-f..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c2e6ebc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a416e3cb063d4787b0f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d1f21f86a5e7/disk-3e7bb4f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5769a034d50c/vmlinux-3e7bb4f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/82288ce4b761/bzImage-3e7bb4f2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8a416e3cb063d4787b0f@syzkaller.appspotmail.com

invalidate_bdev() looks at mapping->nrpages to decide to
invalidate/not-invalidate. If it's updated concurrently, can't
invalidate_bdev() falsely decide to not invalidate?


> ==================================================================
> BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev
>
> read-write to 0xffff8881023fec48 of 8 bytes by task 5672 on cpu 1:
>  __filemap_add_folio+0x38c/0x720 mm/filemap.c:904
>  filemap_add_folio+0x6f/0x150 mm/filemap.c:939
>  filemap_create_folio mm/filemap.c:2545 [inline]
>  filemap_get_pages+0x5d2/0xea0 mm/filemap.c:2605
>  filemap_read+0x223/0x680 mm/filemap.c:2693
>  blkdev_read_iter+0x2ca/0x370 block/fops.c:606
>  call_read_iter include/linux/fs.h:1845 [inline]
>  new_sync_read fs/read_write.c:389 [inline]
>  vfs_read+0x39a/0x560 fs/read_write.c:470
>  ksys_read+0xeb/0x1a0 fs/read_write.c:613
>  __do_sys_read fs/read_write.c:623 [inline]
>  __se_sys_read fs/read_write.c:621 [inline]
>  __x64_sys_read+0x42/0x50 fs/read_write.c:621
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff8881023fec48 of 8 bytes by task 3141 on cpu 0:
>  invalidate_bdev+0x35/0x80 block/bdev.c:84
>  bdev_disk_changed+0x102/0xbb0 block/partitions/core.c:668
>  __loop_clr_fd+0x2b9/0x3b0 drivers/block/loop.c:1189
>  loop_clr_fd drivers/block/loop.c:1257 [inline]
>  lo_ioctl+0xe9e/0x12f0 drivers/block/loop.c:1563
>  blkdev_ioctl+0x3a0/0x490 block/ioctl.c:615
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xc9/0x140 fs/ioctl.c:856
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x0000000000000000 -> 0x0000000000000001
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 3141 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00188-g3e7bb4f24617 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007470fe05fa0fd8ba%40google.com.
