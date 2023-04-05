Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62956D7A62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbjDEKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjDEKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:52:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60ED8;
        Wed,  5 Apr 2023 03:52:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kq3so34008848plb.13;
        Wed, 05 Apr 2023 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680691970;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyZL4BMGnlQcpUW+1AtbAH7ZK7yLm3loW0kemOn3s2Q=;
        b=I+GKYM1ucjAMACk3J1W9G8wRmj1vsYla+LCsnAs81/hC4b8xl4Pt+BpDSc8lziTvQ5
         ccmaRNzlCVZMxE5K2fAQqQBITVuI44pK4WtjDz6fPUX47D79+ONaIdZ+xNPqU+bdbppb
         L+KLvrz0jXnR8B9gVCNLmMAlY8ESrimFfB+N26EKm6PCxvcQVJVvzCqWf1Ql5h0PWGAO
         z2S7efsMA+1lZ1LOp8oSZdRzX1jhaAad88MJkqYqmylUGlGpic+S+YM22TGAfEWqWW9Y
         jRuzUedk+n5tNtCvAybU53WrBQlR6By2WY7MwXggRnful3YAlcWIUEQGiSHM2Mf54zLA
         bN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691970;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyZL4BMGnlQcpUW+1AtbAH7ZK7yLm3loW0kemOn3s2Q=;
        b=61cGzLvVICKWz11ORww5zoYegAnNCgPRpdJmMvm/SLJaNRMTGaNCeVrwUcO5AmaySh
         14mn3XfHZAo4fUrELf9/vMgvaXwk1IR/bXxeQKsfUTIcy336OCjhQw17bqt+IT/65MRz
         izud55a8T5aFIKW02tM4HEYnNLyuXyeUuoqbrYZ/rmYgJ8B/qgpkls9Raf5u3iDBbkSp
         OMVLM/wqtBT0zLAJm/lOJFeGPhUPl8PuOpRUVR6UTqfjGpuP2C2SWabmxTTnmSIAWyaH
         Zy4jq3zcM2CyI0SJGEd9F8lslH5OxO3p/7bHooapLrWnCNdkXz/D5YBTXsuLrmNN6U+M
         Ahbw==
X-Gm-Message-State: AAQBX9c2HBuAYRVEc6EbxZ1ks8amP5pA6BFuKcJjGVplUjHQd2UhhJUH
        JPxDCvPq99ne/kWV4QfulGiewG73tuamOQ==
X-Google-Smtp-Source: AKy350byL6x7NMUoTF7F7xGRaI6G2uSNn6vXt451+x5q2pw4YjQbWLimjhgD6A0tSUY9QTuGosG9BQ==
X-Received: by 2002:a05:6a20:c515:b0:cc:606a:4330 with SMTP id gm21-20020a056a20c51500b000cc606a4330mr4804528pzb.55.1680691969655;
        Wed, 05 Apr 2023 03:52:49 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b005897f5436c0sm10396942pfm.118.2023.04.05.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:52:49 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:52:45 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: kernel BUG in find_lock_entries
Message-ID: <ZC1S_f9nworAQpm_@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed an issue "kernel BUG in find_lock_entries". This was
observed a few months ago.

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.

Detailed crash information is attached below.

Best regards,
Dae R. Jeong

-----
- Kernel version:
6.0-rc7

- Crash report:
------------[ cut here ]------------
kernel BUG at mm/filemap.c:2112!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18497 Comm: syz-executor.0 Not tainted 6.0.0-rc7-00167-g92162e4a9862 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:find_lock_entries+0xa93/0xaa0 mm/filemap.c:2111
Code: 4c 89 ef 48 c7 c6 c0 2a bc 8b e8 b8 ce 0e 00 0f 0b e8 71 99 a8 09 e8 4c 04 d3 ff 4c 89 ef 48 c7 c6 a0 1e bc 8b e8 9d ce 0e 00 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffffc90009e0f9c0 EFLAGS: 00010246
RAX: 9de53b58cea03600 RBX: ffffea0000664dc0 RCX: 0000000000040000
RDX: ffffc90011e81000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc90009e0faf0 R08: ffffffff81e3af0a R09: ffffed1026b84f14
R10: ffffed1026b84f14 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffea0000664dc0 R14: 00fff00000020015 R15: ffffc90009e0fa40
FS:  00007fa68d5be700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056481d8d7317 CR3: 0000000018571000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 truncate_inode_pages_range+0x195/0x1120 mm/truncate.c:364
 kill_bdev block/bdev.c:75 [inline]
 set_blocksize+0x348/0x3c0 block/bdev.c:151
 blkdev_bszset+0x202/0x2a0 block/ioctl.c:459
 blkdev_ioctl+0x225/0x810 block/ioctl.c:597
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x110/0x180 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4725fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa68d5bdbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000057bf80 RCX: 00000000004725fd
RDX: 0000000020000080 RSI: 0000000040081271 RDI: 0000000000000005
RBP: 00000000f477909a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000057cbd8
R13: 000000000057bf8c R14: 00007ffddba46f90 R15: 00007fa68d5bdd80
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_lock_entries+0xa93/0xaa0 mm/filemap.c:2111
Code: 4c 89 ef 48 c7 c6 c0 2a bc 8b e8 b8 ce 0e 00 0f 0b e8 71 99 a8 09 e8 4c 04 d3 ff 4c 89 ef 48 c7 c6 a0 1e bc 8b e8 9d ce 0e 00 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffffc90009e0f9c0 EFLAGS: 00010246
RAX: 9de53b58cea03600 RBX: ffffea0000664dc0 RCX: 0000000000040000
RDX: ffffc90011e81000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc90009e0faf0 R08: ffffffff81e3af0a R09: ffffed1026b84f14
R10: ffffed1026b84f14 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffea0000664dc0 R14: 00fff00000020015 R15: ffffc90009e0fa40
FS:  00007fa68d5be700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056481d8d7317 CR3: 0000000018571000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
