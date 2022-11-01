Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691EF614D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKAOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiKAOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:47:33 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32061BEA4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:47:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c18-20020a056830349200b0066c47e192f0so3890403otu.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U0N7ozCt0kZlTzY6CYBHyHIJtiElgQe1riQTfHPBxRc=;
        b=dKzJl18bSbxCTRRq8w0WTqkR4yU9D7jp0yz4Cf39o90Z1SnU7W6FJUD+jTuZWHJAzQ
         m2R7zw/iCZwVhGX1WHGYPT3wqNUZqjH/ne3bWEptMIFxD1wy0U3U034Mm9BjYqyvHMZH
         AB2pggCxkRrxwaF7p0rGeTu8cRbEIPv4KGc1mThjZx/vxBFHRokcXbnmKeFm0Zbl50q9
         8Nk9ni10vUICLVkJ4bgQQtP4xRPmpnEdYJCZwM38QWTFCpzhp3gg4RHqn2p4X/u00S6e
         bVRdXadx+prCw85rPPdNsEdCWOX2EKQ6bY8ZBwnYR2yxKBzB2+JpqLatmkS9biWpidXN
         1w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0N7ozCt0kZlTzY6CYBHyHIJtiElgQe1riQTfHPBxRc=;
        b=gb9SIOkd1J5EnDsV2+h1+HlrwWBnNuMZGWk0pUAQ7uz4I/NiCpjKn64d/OIEl6yBB1
         rzxQdtdG75c13CX2WZ5DCT/YpRlr3Y2+kUzbHC8I3g6ujpWo76LFkuj8OG5x7rfUyrq2
         p7aCmIYZDOW65D/PqLYn5W1c7lXKcQuk7JofSDujv+pO3PKrnaxtCt4FMk6YhLDcn5o8
         pOLDoqBgmPkQvZmI9Qa2CPLWfBOI7ampZ3+hRCy2nIlkgazm6p5YHCYJ8cRx1zNlylYD
         gQooTatcfsCVONPTMRpVuSluvZYPw9uCNTOTnTX5u/7Gwx+EPnYjppyPnyBPIKCc4yVT
         Mh9w==
X-Gm-Message-State: ACrzQf2KrvPgyUMkBTU1D6lmXRZyd1Ry45x4WO2Dwso/frfTKkIcPfES
        2VI4E2WonGWh0zQxNnMZ1PhknY/3ZfkxAWRwFEjwrQ==
X-Google-Smtp-Source: AMsMyM7oC3tV5LOfi8UpncM+SQzVhCVhopV83IM49dKkAr+mrJnfDrYGSRiNa7HctZM978njC57QH1JLhvQUrYeTbiU=
X-Received: by 2002:a9d:62d8:0:b0:66c:4f88:78ff with SMTP id
 z24-20020a9d62d8000000b0066c4f8878ffmr5825977otk.269.1667314051038; Tue, 01
 Nov 2022 07:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b83bf05ec699567@google.com>
In-Reply-To: <0000000000002b83bf05ec699567@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Nov 2022 07:47:19 -0700
Message-ID: <CACT4Y+bR1sg5dOmtnw8t2dsW3phq0EYpdTfQZXC9-Ota4XP0cQ@mail.gmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in corrupted
To:     syzbot <syzbot+4d9bcd45d5ca0a476cf7@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 07:31, syzbot
<syzbot+4d9bcd45d5ca0a476cf7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e9d267f752f8 Add linux-next specific files for 20221101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c8fdb6880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d67fcb6fc8245f
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9bcd45d5ca0a476cf7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a6c3145cf385/disk-e9d267f7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3f34d7fed0ff/vmlinux-e9d267f7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/279836b50e84/bzImage-e9d267f7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d9bcd45d5ca0a476cf7@syzkaller.appspotmail.com
>
> floppy0: no floppy controllers found
> work still pending
> BUG: unable to handle page fault for address: ffffed1018000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 23ffee067 P4D 23ffee067 PUD 13fff5067 PMD 0
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.0-rc3-next-20221101-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> Workqueue: events_unbound async_run_entry_fn

Besides the crash in bioset_exit() there is some issue with kallsyms

\/\/\/\/\/\/

> RIP: 0010:memset_orig-0x7/0xb0

It gives a negative offset from memset_orig. But that's memset_erms symbol:

$ nm -nS vmlinux-6fbda10e | grep ffffffff895869
ffffffff89586900 000000000000002f T __memset
ffffffff89586930 000000000000000f t memset_erms
ffffffff89586940 00000000000000ac t memset_orig
ffffffff895869f0 000000000000006e T num_digits

$ objdump --disassemble=memset_erms vmlinux-6fbda10e
ffffffff89586930 <memset_erms>:
ffffffff89586930: 49 89 f9              mov    %rdi,%r9
ffffffff89586933: 40 88 f0              mov    %sil,%al
ffffffff89586936: 48 89 d1              mov    %rdx,%rcx
ffffffff89586939: f3 aa                rep stos %al,%es:(%rdi)
ffffffff8958693b: 4c 89 c8              mov    %r9,%rax
ffffffff8958693e: c3                    ret


> Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> RSP: 0000:ffffc90000107a48 EFLAGS: 00010287
> RAX: dffffc0000000000 RBX: ffff88801cd34100 RCX: fffff11014430738
> RDX: fffff11028a89f18 RSI: 0000000000000000 RDI: ffffed1018000000
> RBP: ffff88814544f8c0 R08: 0000000000000005 R09: ffffed10039a6820
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81a702a0
> R13: ffff88814544f8c0 R14: 0000000000000007 R15: ffff88801cd34100
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffed1018000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kasan_unpoison mm/kasan/shadow.c:138 [inline]
>  kasan_unpoison+0x40/0x70 mm/kasan/shadow.c:115
>  kasan_unpoison_range include/linux/kasan.h:112 [inline]
>  kasan_unpoison_element mm/mempool.c:115 [inline]
>  remove_element mm/mempool.c:134 [inline]
>  mempool_exit+0x1c4/0x320 mm/mempool.c:153
>  bioset_exit+0x2d3/0x640 block/bio.c:1655
>  disk_release+0x143/0x480 block/genhd.c:1169
>  device_release+0x9f/0x240 drivers/base/core.c:2330
>  kobject_cleanup lib/kobject.c:673 [inline]
>  kobject_release lib/kobject.c:704 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1be/0x4c0 lib/kobject.c:721
>  put_device+0x1b/0x30 drivers/base/core.c:3624
>  blk_mark_disk_dead-0xf/0x60
>  do_floppy_init drivers/block/floppy.c:4756 [inline]
>  floppy_async_init+0x2169/0x21ca drivers/block/floppy.c:4765
>  async_run_entry_fn+0x98/0x530 kernel/async.c:127
>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>  worker_thread+0x665/0x1080 kernel/workqueue.c:2436
>  kthread+0x2e4/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> Modules linked in:
> CR2: ffffed1018000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:memset_orig-0x7/0xb0
> Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> RSP: 0000:ffffc90000107a48 EFLAGS: 00010287
> RAX: dffffc0000000000 RBX: ffff88801cd34100 RCX: fffff11014430738
> RDX: fffff11028a89f18 RSI: 0000000000000000 RDI: ffffed1018000000
> RBP: ffff88814544f8c0 R08: 0000000000000005 R09: ffffed10039a6820
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81a702a0
> R13: ffff88814544f8c0 R14: 0000000000000007 R15: ffff88801cd34100
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffed1018000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   c1 e9 03                shr    $0x3,%ecx
>    3:   40 0f b6 f6             movzbl %sil,%esi
>    7:   48 b8 01 01 01 01 01    movabs $0x101010101010101,%rax
>    e:   01 01 01
>   11:   48 0f af c6             imul   %rsi,%rax
>   15:   f3 48 ab                rep stos %rax,%es:(%rdi)
>   18:   89 d1                   mov    %edx,%ecx
>   1a:   f3 aa                   rep stos %al,%es:(%rdi)
>   1c:   4c 89 c8                mov    %r9,%rax
>   1f:   c3                      retq
>   20:   90                      nop
>   21:   49 89 f9                mov    %rdi,%r9
>   24:   40 88 f0                mov    %sil,%al
>   27:   48 89 d1                mov    %rdx,%rcx
> * 2a:   f3 aa                   rep stos %al,%es:(%rdi) <-- trapping instruction
>   2c:   4c 89 c8                mov    %r9,%rax
>   2f:   c3                      retq
>   30:   90                      nop
>   31:   49 89 fa                mov    %rdi,%r10
>   34:   40 0f b6 ce             movzbl %sil,%ecx
>   38:   48                      rex.W
>   39:   b8 01 01 01 01          mov    $0x1010101,%eax
>   3e:   01 01                   add    %eax,(%rcx)
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002b83bf05ec699567%40google.com.
