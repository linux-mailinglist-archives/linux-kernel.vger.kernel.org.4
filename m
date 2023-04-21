Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B016B6EAD74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjDUOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjDUOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:52:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310111710
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:52:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so7095e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682088746; x=1684680746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yx2zF1Vv+quQ8XthUhL5gxaw3YApklUY0OznVHk0AoM=;
        b=Nn7UZDlE8AIJXW83tuIeohHXALz4FRk6p1P2dMpDR647zw/FGwW4KczHtEJjQZsBVl
         JjYC5EfvBdG4MC2j0Uokg7PH7sFwzhqMGrNn1GWU38QNOowZyJwwUrJj3eQoF0nh851b
         pOzOiZlNyblDJMI4Ml+lZ30+klCvFF9n+mS97E57+JrlU6a9JfwvZJhl1uWMJKO7Buur
         T6xG6Fy5T8kNxlTWAKbxYpF87deMhOQGuywLejmTuC8q0KbuY7dZGKVInglKJSAq6evn
         lkLO/sdwx8z9+b0u17/bC2fO5etsC3V8pLTIMjWrylKOXj5oIK4kiqv0Y7MXYxY3LbFt
         3zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088746; x=1684680746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx2zF1Vv+quQ8XthUhL5gxaw3YApklUY0OznVHk0AoM=;
        b=QJBtz3nPwj5MxG5wSQrt1v0ZrWvWS3K3PZpbLVwAKZWRHrpDW8V0zYaelS8Gmrj5/7
         MH4CIYPy05zGLBISMXbcWYJyKoQmbCJjf9/3u46r36cqrY3NlJPIO/DRFhBaQucVSKoe
         b5EfwizW7L3eylAZEeAEKBn3fP/TWQXAd5t2fT+zWM55LuX2sSCoDHWP7PHIDbQA/eSd
         VKtUIZRn7E/6WDuqgdk0rCcUDdn1utGSBjMrrhUoBMf+3SRKOICX1MZL32MleRRYCHxw
         bPnIzjD+pxt2m4fhm5+yvAv8OkfQSgIzcMFTU9GMWR7Geq3xN2rWYJ24QTTtknS7kjPa
         F0Vg==
X-Gm-Message-State: AAQBX9c5ee7Vj133mk48tugNTGSWfq87L2UC1OSel9YRcQw/6lPHQYjz
        2JDKW5+5qtbf+S7JKcZQUah4jqg6d2uu6t0BuN6gEQ==
X-Google-Smtp-Source: AKy350ZKj6vZd/NS14fOGUq2SbbOCrrPmiZsdZ8cnu9Y2sBqb1zWQO32UZS1G80gZaxjd0Gpm0VmRzx8EdgJzy9B9Q0=
X-Received: by 2002:a05:6512:3092:b0:4ed:b0bd:a96c with SMTP id
 z18-20020a056512309200b004edb0bda96cmr190682lfd.6.1682088746201; Fri, 21 Apr
 2023 07:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000050327205f9d993b2@google.com>
In-Reply-To: <00000000000050327205f9d993b2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 16:52:13 +0200
Message-ID: <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KCSAN: data-race in random_recv_done /
 virtio_read (3)
To:     syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        olivia@selenic.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 16:36, syzbot
<syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2faac9a98f01 Merge tag 'keys-fixes-20230321' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1113f21cc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3eb0bb0ae89a5345
> dashboard link: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/571c9c5a3db2/disk-2faac9a9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a051e3d7c495/vmlinux-2faac9a9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ff5ec0d6e37d/bzImage-2faac9a9.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com

Here this:

size = min_t(unsigned int, size, vi->data_avail);
memcpy(buf, vi->data + vi->data_idx, size);
vi->data_idx += size;
vi->data_avail -= size;

runs concurrently with:

if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
    return;
vi->data_idx = 0;

I did not fully grasp how/where vi->data is populated, but it looks
like it can lead to use of uninit/stale random data, or even to out of
bounds access, say if vi->data_avail is already updated, but
vi->data_idx is not yet reset to 0. Then concurrent reading will read
not where it's supposed to read.



> ==================================================================
> BUG: KCSAN: data-race in random_recv_done / virtio_read
>
> read to 0xffff8881019054ec of 4 bytes by task 14079 on cpu 0:
>  copy_data drivers/char/hw_random/virtio-rng.c:70 [inline]
>  virtio_read+0xc3/0x3f0 drivers/char/hw_random/virtio-rng.c:92
>  rng_get_data drivers/char/hw_random/core.c:197 [inline]
>  rng_dev_read+0x1a7/0x5e0 drivers/char/hw_random/core.c:234
>  vfs_read+0x192/0x560 fs/read_write.c:468
>  ksys_read+0xeb/0x1a0 fs/read_write.c:613
>  __do_sys_read fs/read_write.c:623 [inline]
>  __se_sys_read fs/read_write.c:621 [inline]
>  __x64_sys_read+0x42/0x50 fs/read_write.c:621
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> write to 0xffff8881019054ec of 4 bytes by interrupt on cpu 1:
>  random_recv_done+0x62/0x90 drivers/char/hw_random/virtio-rng.c:45
>  vring_interrupt+0x150/0x170 drivers/virtio/virtio_ring.c:2491
>  __handle_irq_event_percpu+0x91/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>  handle_edge_irq+0x17f/0x5a0 kernel/irq/chip.c:819
>  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
>  handle_irq arch/x86/kernel/irq.c:231 [inline]
>  __common_interrupt+0x64/0x100 arch/x86/kernel/irq.c:250
>  common_interrupt+0x49/0xc0 arch/x86/kernel/irq.c:240
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
>
> value changed: 0x00000000 -> 0x00000040
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 14077 Comm: syz-executor.2 Not tainted 6.3.0-rc3-syzkaller-00016-g2faac9a98f01 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> ==================================================================
> ==================================================================
> BUG: KCSAN: data-race in detach_buf_split / virtqueue_add
>
> read to 0xffff888101a76950 of 4 bytes by task 14131 on cpu 0:
>  virtqueue_add_split drivers/virtio/virtio_ring.c:553 [inline]
>  virtqueue_add+0x4b9/0x2130 drivers/virtio/virtio_ring.c:2117
>  virtqueue_add_inbuf+0x53/0x80 drivers/virtio/virtio_ring.c:2196
>  request_entropy drivers/char/hw_random/virtio-rng.c:61 [inline]
>  copy_data drivers/char/hw_random/virtio-rng.c:74 [inline]
>  virtio_read+0x1c5/0x3f0 drivers/char/hw_random/virtio-rng.c:92
>  rng_get_data drivers/char/hw_random/core.c:197 [inline]
>  rng_dev_read+0x1a7/0x5e0 drivers/char/hw_random/core.c:234
>  vfs_read+0x192/0x560 fs/read_write.c:468
>  ksys_read+0xeb/0x1a0 fs/read_write.c:613
>  __do_sys_read fs/read_write.c:623 [inline]
>  __se_sys_read fs/read_write.c:621 [inline]
>  __x64_sys_read+0x42/0x50 fs/read_write.c:621
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read-write to 0xffff888101a76950 of 4 bytes by interrupt on cpu 1:
>  detach_buf_split+0x2fc/0x570 drivers/virtio/virtio_ring.c:757
>  virtqueue_get_buf_ctx_split drivers/virtio/virtio_ring.c:835 [inline]
>  virtqueue_get_buf_ctx+0x3c8/0x5c0 drivers/virtio/virtio_ring.c:2311
>  virtqueue_get_buf+0x1f/0x30 drivers/virtio/virtio_ring.c:2317
>  random_recv_done+0x4c/0x90 drivers/char/hw_random/virtio-rng.c:42
>  vring_interrupt+0x150/0x170 drivers/virtio/virtio_ring.c:2491
>  __handle_irq_event_percpu+0x91/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>  handle_edge_irq+0x17f/0x5a0 kernel/irq/chip.c:819
>  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
>  handle_irq arch/x86/kernel/irq.c:231 [inline]
>  __common_interrupt+0x64/0x100 arch/x86/kernel/irq.c:250
>  common_interrupt+0x9e/0xc0 arch/x86/kernel/irq.c:240
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
>  xas_find+0x10a/0x3f0
>  find_get_entry mm/filemap.c:2008 [inline]
>  filemap_get_folios+0xa4/0x3f0 mm/filemap.c:2174
>  mpage_map_and_submit_buffers fs/ext4/inode.c:2358 [inline]
>  mpage_map_and_submit_extent fs/ext4/inode.c:2513 [inline]
>  ext4_do_writepages+0x1017/0x2140 fs/ext4/inode.c:2876
>  ext4_writepages+0x127/0x250 fs/ext4/inode.c:2964
>  do_writepages+0x1c5/0x340 mm/page-writeback.c:2551
>  filemap_fdatawrite_wbc+0xdb/0xf0 mm/filemap.c:390
>  __filemap_fdatawrite_range mm/filemap.c:423 [inline]
>  __filemap_fdatawrite mm/filemap.c:429 [inline]
>  filemap_flush+0x95/0xc0 mm/filemap.c:456
>  ext4_alloc_da_blocks+0x50/0x130 fs/ext4/inode.c:3218
>  ext4_release_file+0x5f/0x1c0 fs/ext4/file.c:158
>  __fput+0x245/0x570 fs/file_table.c:321
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0x600/0x1710 kernel/exit.c:869
>  do_group_exit+0x101/0x150 kernel/exit.c:1019
>  get_signal+0xea9/0xfe0 kernel/signal.c:2859
>  arch_do_signal_or_restart+0x89/0x2b0 arch/x86/kernel/signal.c:306
>  exit_to_user_mode_loop+0x6d/0xe0 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
>  irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:309
>  irqentry_exit+0x12/0x40 kernel/entry/common.c:412
>  exc_general_protection+0x339/0x4c0 arch/x86/kernel/traps.c:728
>  asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
>
> value changed: 0x00000001 -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 14098 Comm: syz-executor.1 Not tainted 6.3.0-rc3-syzkaller-00016-g2faac9a98f01 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
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
