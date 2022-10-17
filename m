Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C93601CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJQW6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJQW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:58:12 -0400
Received: from p3plwbeout21-04.prod.phx3.secureserver.net (p3plsmtp21-04-2.prod.phx3.secureserver.net [68.178.252.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19280BC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:58:05 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id kZ3boy1NPS0zGkZ3coqyOA; Mon, 17 Oct 2022 15:58:04 -0700
X-CMAE-Analysis: v=2.4 cv=KsCIZUaN c=1 sm=1 tr=0 ts=634dddfc
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=Qawa6l4ZSaYA:10 a=ID6ng7r3AAAA:8 a=6wdf3w9dTLvKnbReFksA:9
 a=AkheI1RvQwOzcTXhi5f4:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kZ3boy1NPS0zG
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okZ3a-0001cw-PK; Mon, 17 Oct 2022 23:58:03 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     nixiaoming@huawei.com
Cc:     chenjianguo3@huawei.com, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, wangle6@huawei.com, yi.zhang@huawei.com,
        zhongjubin@huawei.com
Subject: Re [PATCH v5 1/2] squashfs: add the mount parameter theads=<single|multi|percpu>
Date:   Mon, 17 Oct 2022 22:58:44 +0100
Message-Id: <20221017215844.16940-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930091406.50869-2-nixiaoming@huawei.com>
References: <20220930091406.50869-2-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfEIrZvuNCo6uP/HGAhZrCSd7YmCEMs/i5Yu2dAt+kJW8kbmG4d471BwJXph0ybiW18wRodVQy9JmUc2YuLvbYKCOQI1F2VXyLEcG+gWMHkXgTvAv8o7l
 nuvShQJU8EcaHcETdZLsd0BggfdiyHQ4QYwUXAbPbs9ij6+g0SDLxcdP2E3S32YLTrVpHHa+N2Rj6t+P6J5XG3G5gWU9SZ7PiW4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2022 17:14:05 +0800 Xiaoming Ni wrote:
>Squashfs supports three decompression concurrency modes:
>	Single-thread mode: concurrent reads are blocked and the memory
>		overhead is small.
>	Multi-thread mode/percpu mode: reduces concurrent read blocking but
>		increases memory overhead.
>

You have made another mistake in fixing this patch.

Previously, I asked you to fix patch lines (appearing in V3) which caused
a build error.

These lines were:

@@ -446,6 +487,13 @@ static int squashfs_init_fs_context(struct fs_context *fc)
 	if (!opts)
 		return -ENOMEM;
 
+#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
+	opts->thread_ops = &squashfs_decompressor_single;
+#elif CONFIG_SQUASHFS_DECOMP_MULTI
+	opts->thread_ops = &squashfs_decompressor_multi;
+#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
+	opts->thread_ops = &squashfs_decompressor_percpu;
+#endif
 	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;

I expected you to replace the

+#elif CONFIG_SQUASHFS_DECOMP_MULTI

line with

+#elif defined(CONFIG_SQUASHFS_DECOMP_MULTI)

and the

+#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU

line with

+#elif defined(CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU)

If you had done that then the patch set would finally have been OK.

Instead you did this in this patch ...

> 
>@@ -446,6 +487,9 @@ static int squashfs_init_fs_context(struct fs_context *fc)
> 	if (!opts)
> 		return -ENOMEM;
> 
>+#ifdef CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT
>+	opts->thread_ops = &squashfs_decompressor_single;
>+#endif
> 	fc->fs_private = opts;
> 	fc->ops = &squashfs_context_ops;
> 	return 0;

You have removed the build error by removing the offending lines.

But, you have rather obviously left opt->thread_ops unassigned
if CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set.

Given the following configuration

CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3

You will get the following kernel oops with this patch applied.

root@logopolis:~# mount -t squashfs /dev/sdb /mnt
BUG: kernel NULL pointer dereference, address: 0000000000000018
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 8000000004db0067 P4D 8000000004db0067 PUD 5bf0067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 3 PID: 1482 Comm: mount Not tainted 6.0.0+ #38
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
RIP: 0010:squashfs_fill_super+0x2d5/0x700
Code: e0 c9 02 82 e8 2c d0 ff ff 48 89 43 10 48 89 c7 48 85 c0 0f 84 10 03 00 00 8b 93 98 00 00 00 48 8b 83 c0 00 00 00 89 54 24 04 <48> 8b 40 18 e8 12 51 b8 00 8b 54 24 04 48 c7 c7 86 fb 21 82 89 c6
RSP: 0018:ffffc900024e7de0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88800611b300 RCX: 00000000000003db
RDX: 0000000000100000 RSI: 0000000000000cc0 RDI: ffff888004411600
RBP: ffff888004689000 R08: ffff888004411900 R09: 0000000000000000
R10: ffff88800440f450 R11: 0000000000024298 R12: ffff888004ea9540
R13: 000002c12876123d R14: ffff8880044115a0 R15: 00000000000000c0
FS:  00007f99343ea840(0000) GS:ffff88807dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 00000000046ea000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 ? squashfs_init_fs_context+0x40/0x40
 get_tree_bdev+0x16a/0x260
 vfs_get_tree+0x20/0xb0
 path_mount+0x2d3/0xa70
 __x64_sys_mount+0x194/0x1f0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9933621d8a
Code: 48 8b 0d 01 c1 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ce c0 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd3d78d138 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd3d78d260 RCX: 00007f9933621d8a
RDX: 00000000006191e0 RSI: 00000000006191c0 RDI: 00000000006191a0
RBP: 00000000c0ed0000 R08: 0000000000000000 R09: 0000000000619300
R10: ffffffffc0ed0000 R11: 0000000000000202 R12: 00000000006191c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000018
---[ end trace 0000000000000000 ]---
RIP: 0010:squashfs_fill_super+0x2d5/0x700
Code: e0 c9 02 82 e8 2c d0 ff ff 48 89 43 10 48 89 c7 48 85 c0 0f 84 10 03 00 00 8b 93 98 00 00 00 48 8b 83 c0 00 00 00 89 54 24 04 <48> 8b 40 18 e8 12 51 b8 00 8b 54 24 04 48 c7 c7 86 fb 21 82 89 c6
RSP: 0018:ffffc900024e7de0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88800611b300 RCX: 00000000000003db
RDX: 0000000000100000 RSI: 0000000000000cc0 RDI: ffff888004411600
RBP: ffff888004689000 R08: ffff888004411900 R09: 0000000000000000
R10: ffff88800440f450 R11: 0000000000024298 R12: ffff888004ea9540
R13: 000002c12876123d R14: ffff8880044115a0 R15: 00000000000000c0
FS:  00007f99343ea840(0000) GS:ffff88807dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 00000000046ea000 CR4: 00000000000006e0
Killed

I do not understand why you have not fixed the patch as I have asked,
and instead repeatedly sent patches which are obviously broken.

Cheers

Phillip
