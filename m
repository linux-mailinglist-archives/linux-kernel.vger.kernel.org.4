Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261B45F9EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJJM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:26:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B35FDC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:26:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot12so24576069ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c/qCEUHcouq0FaTY7tiJJ7EzeWgMgJZLiWCNx8Pj+xA=;
        b=k8Vb0P+C0XHDCcK8+X0+/hhG6gSq6EFM9+EMc2YkN5iyayB+k2h3M/QRGFKKSLzMmU
         QtMymbmNe9qVk+JnXXb0GRoSDtSCC14SVCsBV3Ok3rjOgWQ2aX9ChBB62RvGt0W5HwHJ
         pPlzp54qxRAJqkDy4ZRfeVyWylOUgxxn5FQpS8ZJSSFM/BR+6e9NZzVsQGaoZw0Dyh/W
         4S8iegQPoJs1RnEI3HU2ibYqqkJA2se1ZLxMLkxexY4OSZDpq19icgHNg8R0WnPpUipw
         cuqLQH4ipiOQgdXSzz8M6X4Mb1c8B5c8fV7LpTljBGUtVIYfBvuxJubr13bFjTl5YQTq
         CTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/qCEUHcouq0FaTY7tiJJ7EzeWgMgJZLiWCNx8Pj+xA=;
        b=JGn3bdUYno6vR0uPFsfgm5mMUFRIm2bAN4P82fTenC34p+eIpr/Z9v2+g40qARr3UV
         Sut35ZkZrbBAtcMGyvgNxxDqSzn89rnnSNfgoHZ5xgL6fFtwVagt4uxviHQAD7lZNnN4
         08eJMFVQfarkQMhLyMAGuckHE+kfEBF1Y2HdATV9gFpPLZOJE1f7lzekh7fKra1GhToz
         KviMvJrDCKbpCpPChg9sdJ6QABirmXCQhgx2EO7ie4MhzRqlGC5Ghsb+36dqhr5RoFg2
         vV+uXQeokuTFqLA631jNjVTyFinDFfhvPqD2BcTwtplFX27UINelldn8nt+QTw4aHmBf
         1o/g==
X-Gm-Message-State: ACrzQf12mdQQhUgYUth1zdc+2tPAuZvga4bKoEFXsWqn3eoxhas6xBZW
        6jpmBSDWpF0sA7uwn9MxppdY0TRDdHNjOyxp3mApH5+i
X-Google-Smtp-Source: AMsMyM6igYC90Ar5/khol3vGPqUZ8mW3BIV/VyroSmM2xwF+WbzrX9KlQdE6pex09qabZX5zjbvf5PxM8TdDjx81cZc=
X-Received: by 2002:a17:907:75ed:b0:78d:97ed:2894 with SMTP id
 jz13-20020a17090775ed00b0078d97ed2894mr8699909ejc.739.1665404792616; Mon, 10
 Oct 2022 05:26:32 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 20:25:58 +0800
Message-ID: <CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com>
Subject: kernel BUG in page_try_dup_anon_rmap
To:     Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz,
        hughd@google.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
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

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 03c765b0e3b4 Linux 5.19-rc4
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/16ht-2pDp_nU_nXhobMfHaQraVt4qfzBK/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNGU17X6Ui1NDLE4XCRu3I6f9lzhCBcH/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

kernel BUG at include/linux/mm.h:1585!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 20332 Comm: syz-executor Not tainted 5.19.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 copy_hugetlb_page_range+0xc9d/0x1cc0
 copy_page_range+0x424/0x1b40
 dup_mmap+0xa72/0xf80
 dup_mm+0x8c/0x310
 copy_process+0x2b3b/0x60d0
 kernel_clone+0x21a/0x7d0
 __do_sys_fork+0x9e/0xf0
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fa373695c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa374805c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000039
RAX: ffffffffffffffda RBX: 00007fa3737bc0a0 RCX: 00007fa373695c4d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fa37370ed80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa3737bc0a0
R13: 00007ffc0a3c127f R14: 00007ffc0a3c1420 R15: 00007fa374805dc0
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:page_try_dup_anon_rmap+0x927/0x1120
Code: e6 ff 0f 00 00 31 ff e8 87 75 b2 ff 4c 89 e0 48 25 ff 0f 00 00
0f 84 0e 01 00 00 e8 c3 70 b2 ff e9 43 03 00 00 e8 b9 70 b2 ff <0f> 0b
e8 b2 70 b2 ff 4c 89 e7 48 c7 c6 80 96 9e 8a e8 03 91 ee ff
RSP: 0018:ffffc900088e7368 EFLAGS: 00010287
RAX: ffffffff81d29967 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900084b9000 RSI: 00000000000023c4 RDI: 00000000000023c5
RBP: ffff88802e3a0670 R08: ffffffff81d29420 R09: fffff9400011d001
R10: fffff9400011d001 R11: 0000000000000000 R12: ffffea00008e8000
R13: dffffc0000000000 R14: ffff88802e3a0670 R15: 1ffff11005c740ce
FS:  00007fa374806700(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3737b8000 CR3: 000000002f26f000 CR4: 0000000000750ef0
DR0: 0000000020000080 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554

Best,
Wei
