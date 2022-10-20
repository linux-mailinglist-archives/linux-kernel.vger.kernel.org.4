Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B36065B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJTQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJTQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:22:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0E1D93D2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:22:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so667235eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TxtxAu3HzKJOS/6c27E4S3rw04egv6JsI38SpOYaGSE=;
        b=mYYLbYFgef+DfcZipKSWQgg2ORnWYU2samPCPRYz53S3OXTH8rOaJ2VASSaEzKzk5r
         +Su/a8KsNZbGa/cxfrWYHVfOGjE+P+6fjAVUyJJklPYT59tjMf/Uzbv/u/sWWKJ45I+0
         WsP5VlpOXRyAylk6kvQHWG0setmtM7IJRtDX5l4g44hEg2U4DoXqAv3ZieUZ8HBzC6dJ
         Slb8gfntZEztOZRjlkFbiS+eO5M5sqvaPOL3UpniJ3GBp3dXkUdeZKHygCNzBD/qDfA6
         A6uygv5pEpqZGKEp7j2LbDKWc8AD96cWdp/BwWobVgoKndvBWgUf0F8uwf+6n5ArsClN
         E7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxtxAu3HzKJOS/6c27E4S3rw04egv6JsI38SpOYaGSE=;
        b=UHNFN5RwH85MgiKkTQHYjABBQqM3E81zIa8AWsjmEkUXUd71ZyBxEbEq2Gv58VgGEg
         qFpdaKIrWLRaoh0Zf9YUe6gx9aztIZfMMG0XJh1MwWH2PQhxpPTR+mjhsqGoeeV+kb0g
         zdpYpLYqhn/nTJ9Usfvsz2UjW/aknZdqBwVMyE7M/o/HXKRFslz2bKsXIsIzh4znBIfx
         lBOMBxlV9JeiqDXSlzVagi2R31l4c0Nfe6f5qGxmaanGZtb0lRRo6Qa0r5ke7h3qJ9K0
         SkdhlE1BO89kCLh6oexJ6FuWvcagyRD2kA9VO/E/0jk09+KvzZq1sF9wXb5PaxLuBoyQ
         R4Ow==
X-Gm-Message-State: ACrzQf236Zh0Yixmf04QtZRoTCzaoNpX9MEkrUBlTfVexA5dvLyzTl3p
        nyPITJXEjHpiO41gabC1RCvWWb/JxveQ1ccKVwI=
X-Google-Smtp-Source: AMsMyM7kAVY3f+Lwq4dsFl+o2JiVKpXklxxL9D9zZO82MvsbMzfpd+rhFHHJNsBQ1aBmNFW29iQqP6xniX/X+89d6S0=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr11684246ejc.235.1666282913750; Thu, 20
 Oct 2022 09:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
 <8ef3a72d-8719-aeaf-1a03-9b7cb1a03cc4@suse.cz>
In-Reply-To: <8ef3a72d-8719-aeaf-1a03-9b7cb1a03cc4@suse.cz>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Fri, 21 Oct 2022 00:21:20 +0800
Message-ID: <CAO4mrffHdnG7fEkxcoEXEhqYN8HkcY9d1-NxRvHsqf0mQN6T1w@mail.gmail.com>
Subject: Re: kernel BUG in page_try_dup_anon_rmap
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Vlastimil,

Thank you for the reply. The bug persists in v6.0. Here is the
information. Luckily I got C reproducer this time.

HEAD commit: 4fe89d07 Linux v6.0
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/18oQROgRr2u8jzgV83i9xHmoCEXN7PQ8b/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1g5DwpvjI_-I3bBkYrLeoQTFFcSBw2bvY/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1ZMiiTqx0Qh-7A9ucb-0kq0civg_sXB7X/view?usp=sharing
kernel config: https://drive.google.com/file/d/1ZHRxVTXHL9mENdAPmQYS1DtgbflZ9XsD/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

kernel BUG at include/linux/mm.h:1529!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6605 Comm: syz-executor919 Not tainted 6.0.0 #35
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:page_needs_cow_for_dma include/linux/mm.h:1529 [inline]
RIP: 0010:page_try_dup_anon_rmap+0x703/0xc40 include/linux/rmap.h:253
Code: 31 ff e8 30 d6 b4 ff 4c 89 e0 48 25 ff 0f 00 00 0f 84 39 01 00
00 e8 6c d1 b4 ff 4c 8b 74 24 08 e9 b4 fa ff ff e8 5d d1 b4 ff <0f> 0b
4c 89 e7 be 08 00 00 00 e8 9e a0 05 00 4c 89 e0 48 c1 e8 03
RSP: 0018:ffffc900051ef270 EFLAGS: 00010293
RAX: ffffffff81d247c3 RBX: 0000000000000000 RCX: ffff888044b22440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff11003f580ef R08: ffffffff81d243d0 R09: fffff940000fe001
R10: fffff940000fe001 R11: 0000000000000000 R12: ffffea00007f0000
R13: dffffc0000000000 R14: 1ffffd40000fe001 R15: ffff88801fac0778
FS:  00005555564ba940(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200002c0 CR3: 0000000014ad2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 copy_hugetlb_page_range+0xc86/0x1eb0 mm/hugetlb.c:4846
 copy_page_range+0x424/0x1b40 mm/memory.c:1288
 dup_mmap+0xa72/0xf80 kernel/fork.c:699
 dup_mm+0x8c/0x310 kernel/fork.c:1525
 copy_mm kernel/fork.c:1577 [inline]
 copy_process+0x2b92/0x6130 kernel/fork.c:2254
 kernel_clone+0x21a/0x7d0 kernel/fork.c:2671
 __do_sys_clone3 kernel/fork.c:2963 [inline]
 __se_sys_clone3+0x357/0x400 kernel/fork.c:2947
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efee9f6102d
Code: 28 c3 e8 66 2a 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff00b0558 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007ffff00b0568 RCX: 00007efee9f6102d
RDX: 00007efee9f6102d RSI: 0000000000000058 RDI: 00000000200002c0
RBP: 00007ffff00b0560 R08: 00007ffff00b0560 R09: 00007efee9f19460
R10: 00007ffff00b0560 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:page_needs_cow_for_dma include/linux/mm.h:1529 [inline]
RIP: 0010:page_try_dup_anon_rmap+0x703/0xc40 include/linux/rmap.h:253
Code: 31 ff e8 30 d6 b4 ff 4c 89 e0 48 25 ff 0f 00 00 0f 84 39 01 00
00 e8 6c d1 b4 ff 4c 8b 74 24 08 e9 b4 fa ff ff e8 5d d1 b4 ff <0f> 0b
4c 89 e7 be 08 00 00 00 e8 9e a0 05 00 4c 89 e0 48 c1 e8 03
RSP: 0018:ffffc900051ef270 EFLAGS: 00010293
RAX: ffffffff81d247c3 RBX: 0000000000000000 RCX: ffff888044b22440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff11003f580ef R08: ffffffff81d243d0 R09: fffff940000fe001
R10: fffff940000fe001 R11: 0000000000000000 R12: ffffea00007f0000
R13: dffffc0000000000 R14: 1ffffd40000fe001 R15: ffff88801fac0778
FS:  00005555564ba940(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200002c0 CR3: 0000000014ad2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

Best,
Wei

On Fri, 14 Oct 2022 at 15:54, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/10/22 14:25, Wei Chen wrote:
> > Dear Linux Developer,
> >
> > Recently when using our tool to fuzz kernel, the following crash was triggered:
> >
> > HEAD commit: 03c765b0e3b4 Linux 5.19-rc4
>
> That's a rather odd version to report against, now that there's v6.0 final?
> (not to mention 5.19 final, months ago) Or is v5.19-rc4 just the first
> affected tag and the bug persists until v6.0?
>
> > git tree: upstream
> > compiler: clang 12.0.0
> > console output:
> > https://drive.google.com/file/d/16ht-2pDp_nU_nXhobMfHaQraVt4qfzBK/view?usp=sharing
> > kernel config: https://drive.google.com/file/d/1lNGU17X6Ui1NDLE4XCRu3I6f9lzhCBcH/view?usp=sharing
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: Wei Chen <harperchen1110@gmail.com>
> >
> > kernel BUG at include/linux/mm.h:1585!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 20332 Comm: syz-executor Not tainted 5.19.0-rc4 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> > Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> > 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> > e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> > RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> > RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> > RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> > RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> > R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> > R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> > FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> > DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  copy_hugetlb_page_range+0xc9d/0x1cc0
> >  copy_page_range+0x424/0x1b40
> >  dup_mmap+0xa72/0xf80
> >  dup_mm+0x8c/0x310
> >  copy_process+0x2b3b/0x60d0
> >  kernel_clone+0x21a/0x7d0
> >  __do_sys_fork+0x9e/0xf0
> >  do_syscall_64+0x3d/0x90
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7fa373695c4d
> > Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fa374805c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000039
> > RAX: ffffffffffffffda RBX: 00007fa3737bc0a0 RCX: 00007fa373695c4d
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00007fa37370ed80 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3737bc0a0
> > R13: 00007ffc0a3c127f R14: 00007ffc0a3c1420 R15: 00007fa374805dc0
> >  </TASK>
> > Modules linked in:
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
> > Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
> > 0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
> > e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
> > RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
> > RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
> > RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
> > RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
> > R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
> > R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
> > FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
> > DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> >
> > Best,
> > Wei
>
