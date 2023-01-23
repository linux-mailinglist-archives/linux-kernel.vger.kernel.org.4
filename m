Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F7678230
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjAWQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjAWQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:51:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF102BF08;
        Mon, 23 Jan 2023 08:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0D460F9B;
        Mon, 23 Jan 2023 16:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE21C433D2;
        Mon, 23 Jan 2023 16:51:10 +0000 (UTC)
Date:   Mon, 23 Jan 2023 11:51:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com
Subject: Re: [PATCH 0/8] tracing: introducing eventfs
Message-ID: <20230123115108.7dab91f3@gandalf.local.home>
In-Reply-To: <1674407228-49109-9-git-send-email-akaher@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
        <1674407228-49109-9-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2023 22:37:08 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Events Tracing infrastructure contains lot of files, directories
> (internally in terms of inodes, dentries). And ends up by consuming
> memory in MBs. We can have multiple events of Events Tracing, which
> further requires more memory.
> 
> Instead of creating inodes/dentries, eventfs could keep meta-data and
> skip the creation of inodes/dentries. As and when require, eventfs will
> create the inodes/dentries only for required files/directories.
> Also eventfs would delete the inodes/dentries once no more requires
> but preserve the meta data.
> 
> Tracing events took ~9MB, with this approach it took ~4.5MB
> for ~10K files/dir.
> 
> [PATCH 1/8]: Introducing struct tracefs_inode
> [PATCH 2/8]: Adding eventfs-dir-add functions
> [PATCH 3/8]: Adding eventfs-file-add function
> [PATCH 4/8]: Adding eventfs-file-directory-remove function
> [PATCH 5/8]: Adding functions to create-eventfs-files
> [PATCH 6/8]: Adding eventfs lookup, read, open functions
> [PATCH 7/8]: Creating tracefs_inode_cache
> [PATCH 8/8]: Moving tracing events to eventfs

Hi Ajay,

Thanks a lot for sending these out.

Note, something went wrong with your threading, as all the patches should
be a reply to this one, but instead, they all (including this email) are a
reply to patch 1 ??

Also, for v2, can you address all the kernel test robot issues as well as
what Dan Carpenter wrote. There's also a couple of whitespace issues.

Finally, when I run the ftrace selftests that are in the kernel repository:

 # cd linux.git
 # cd tools/testing/selftests/ftrace
 # ./ftracetests

It crashes with a NULL kernel dereference:

[ 1021.844973] general protection fault, probably for non-canonical address 0x626f7270747365a6: 0000 [#1] PREEMPT SMP PTI
[ 1021.848900] CPU: 2 PID: 1160 Comm: ftracetest Not tainted 6.2.0-rc3-test-00014-g1a351602422d #152
[ 1021.852384] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 1021.855716] RIP: 0010:dcache_dir_open_wrapper+0x6b/0x1b0
[ 1021.857700] Code: 75 28 e9 f7 00 00 00 48 8b 7b 10 48 85 ff 74 09 48 83 c7 58 e8 36 ad 0c 00 48 8b 43 18 48 8d 58 e8 49 39 c4 0f 84 d4 00 00 00 <80> 7b 4a 00 75 d7 c6 43 4a 01 48 8b 45 30 48 8d b8 a0 00 00 00 e8
[ 1021.864170] RSP: 0018:ffffa68b40f0fcb0 EFLAGS: 00010296
[ 1021.866133] RAX: 626f727074736574 RBX: 626f72707473655c RCX: ffff9c6bc08cb000
[ 1021.868797] RDX: ffffffff89058dc0 RSI: ffff9c6bc09f6f00 RDI: ffff9c6bceef2810
[ 1021.871389] RBP: ffff9c6bcee223c0 R08: ffffffff8a3b2da0 R09: ffff9c6bceef2810
[ 1021.873953] R10: 0000000000000007 R11: 0000000000000002 R12: ffff9c6bc3664980
[ 1021.876669] R13: ffff9c6bc09f6f00 R14: ffff9c6bceef2810 R15: ffff9c6bc09f6f00
[ 1021.880350] FS:  00007f58e39ba740(0000) GS:ffff9c6d37c80000(0000) knlGS:0000000000000000
[ 1021.883289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1021.885401] CR2: 000055a0c1465000 CR3: 000000010f5a8003 CR4: 0000000000170ee0
[ 1021.888117] Call Trace:
[ 1021.889227]  <TASK>
[ 1021.890216]  ? __pfx_dcache_dir_open_wrapper+0x10/0x10
[ 1021.892088]  do_dentry_open+0x1e5/0x410
[ 1021.893501]  path_openat+0xd7f/0x1220
[ 1021.894863]  ? asm_exc_page_fault+0x22/0x30
[ 1021.896325]  ? trace_hardirqs_on+0x2a/0xe0
[ 1021.897715]  do_filp_open+0xaf/0x160
[ 1021.898972]  do_sys_openat2+0xaf/0x170
[ 1021.900211]  __x64_sys_openat+0x6a/0xa0
[ 1021.901451]  do_syscall_64+0x3a/0x90
[ 1021.902636]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1021.904145] RIP: 0033:0x7f58e3ab9e41
[ 1021.905255] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
[ 1021.910033] RSP: 002b:00007ffdfae49b40 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[ 1021.913838] RAX: ffffffffffffffda RBX: 000055a0c145bfb1 RCX: 00007f58e3ab9e41
[ 1021.915613] RDX: 0000000000090800 RSI: 000055a0c1463380 RDI: 00000000ffffff9c
[ 1021.917358] RBP: 000055a0c146338f R08: 0000000000000001 R09: 000000000000000f
[ 1021.919110] R10: 0000000000000000 R11: 0000000000000287 R12: 000055a0c1463380
[ 1021.920864] R13: 000055a0c145bfb1 R14: 0000000000000000 R15: 000055a0c145bfb2
[ 1021.922613]  </TASK>
[ 1021.923331] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock ip_tables
[ 1021.925741] Dumping ftrace buffer:
[ 1021.926709]    (ftrace buffer empty)
[ 1021.927754] ---[ end trace 0000000000000000 ]---
[ 1021.928993] RIP: 0010:dcache_dir_open_wrapper+0x6b/0x1b0

Could you see what happened there?

Thanks!

-- Steve
