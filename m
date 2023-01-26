Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C867C160
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAZANf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAZANe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:13:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C6E2FCC6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:13:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D159616B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B5C433D2;
        Thu, 26 Jan 2023 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674692011;
        bh=g0C73GKmjpMXW9dJYrRm/0TuGOb0XD/jqP5+uC2/nv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zqZAELU+KfADET3Y9HwHnDI5EZM5TP+HUlNSUQjdtSSWT6h59WvFWBh8J4oii56C4
         FqtisJzMwvxxVX4x0/nd4OC4KJBqjgyTAWhpLTQACID9tFNjCDzLcLW2hN9bQ7/hIj
         06kTXbfZW0Rw9tVOus+IQ0b3mUy487Nx5vMIDTsA=
Date:   Wed, 25 Jan 2023 16:13:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: kernel BUG in page_add_anon_rmap
Message-Id: <20230125161330.eeef53faa3f35809c64fae8d@linux-foundation.org>
In-Reply-To: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 23:59:16 +0000 Sanan Hasanov <sanan.hasanov@Knights.ucf=
.edu> wrote:

> Good day, dear maintainers,
>=20
> We found a bug using a modified kernel configuration file used by syzbot.
>=20
> We enhanced the coverage of the configuration file using our tool, klocal=
izer.
>=20
> Kernel Branch:=A06.2.0-rc5-next-20230124
> Kernel config:=A0https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZV=
Pce-GiJQK/view?usp=3Dsharing
> Reproducer:=A0https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi6J-fmu=
kRx-BM/view?usp=3Dsharing

Helpful.

>=20
> Thank you!
>=20
> Best regards,
> Sanan Hasanov
>=20
> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8000
> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL)=
)) << (0)))))
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:1248!

I assume this is recent?

Matthew and Liam were in here recently.

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-2023012=
4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e=
8 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73=
 c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261
>  rmap_walk_anon+0x23a/0x5b0 mm/rmap.c:2433
>  rmap_walk+0x96/0xd0 mm/rmap.c:2509
>  remove_migration_ptes mm/migrate.c:294 [inline]
>  migrate_folio_move mm/migrate.c:1307 [inline]
>  migrate_pages_batch+0x15f8/0x3910 mm/migrate.c:1809
>  migrate_pages+0x1b56/0x22e0 mm/migrate.c:1961
>  do_mbind mm/mempolicy.c:1329 [inline]
>  kernel_mbind+0x4c0/0x790 mm/mempolicy.c:1476
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f717788edcd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7178989bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f71779bc050 RCX: 00007f717788edcd
> RDX: 0000000000000004 RSI: 0000000000001000 RDI: 0000000020002000
> RBP: 00007f71778fc59c R08: 00000000000007ff R09: 0000000000000002
> R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd2c012f6f R14: 00007ffd2c013110 R15: 00007f7178989d80
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e=
8 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73=
 c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
