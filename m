Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63E7631B04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKUIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiKUIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:10:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12904165B2;
        Mon, 21 Nov 2022 00:10:35 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NG0Nm0qY6zFqT1;
        Mon, 21 Nov 2022 16:07:20 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:10:33 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 16:10:33 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <zhengyejian1@huawei.com>
Subject: [BUG] tracing: Possible data race on global variable 'trace_probe_log'
Date:   Mon, 21 Nov 2022 16:11:03 +0800
Message-ID: <20221121081103.3070449-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a possible data race bug in trace probe log when looking into the
code, I currently don't have a good solution but I'll be glad to fix it.

kprobe/uprobe/eprobe call below interfaces to print logs into 'error_log':
  trace_probe_log_init()
  trace_probe_log_clear()
  trace_probe_log_set_index()
  __trace_probe_log_err()

These interfaces access global variable 'trace_probe_log' without any
concurrency protection, then concurrently access 'trace_probe_log.argv' in
__trace_probe_log_err() may cause kernel oops [1] [2].

To solve this problem, we can add a mutex lock (see demo code below), but
it doesn't look so good to add such a big lock just for log print.

  diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
  index 36dff277de46..e6e8e6002546 100644
  --- a/kernel/trace/trace_probe.c
  +++ b/kernel/trace/trace_probe.c
  @@ -142,17 +142,22 @@ static const struct fetch_type *find_fetch_type(const char *type)

   static struct trace_probe_log trace_probe_log;

  +DEFINE_MUTEX(trace_probe_log_mutex);
  +
   void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
   {
  +       mutex_lock(&trace_probe_log_mutex);
          trace_probe_log.subsystem = subsystem;
          trace_probe_log.argc = argc;
          trace_probe_log.argv = argv;
          trace_probe_log.index = 0;
   }

   void trace_probe_log_clear(void)
   {
          memset(&trace_probe_log, 0, sizeof(trace_probe_log));
  +       mutex_unlock(&trace_probe_log_mutex);
   }

Another possible solution, we can define a stack varible to hold trace_probe_log
arguments in __trace_{k,u,e}probe_create() then pass it to every caller of
trace_probe_log_err(). But it may look a little ugly.

[1] Shell script to reproduce:
  # 'p4' is invalid command which make kernel run into trace_probe_log_err()
  cd /sys/kernel/debug/tracing
  while true; do
    echo 'p4:myprobe1 do_sys_openat2 dfd=%ax filename=%dx flags=%cx mode=+4($stack)' >> kprobe_events &
    echo 'p4:myprobe2 do_sys_openat2' >> kprobe_events &
    echo 'p4:myprobe3 do_sys_openat2 dfd=%ax filename=%dx' >> kprobe_events &
  done;

[2] Reproduction log:
general protection fault, probably for non-canonical address I
[  407.244517] CPU: 6 PID: 20830 Comm: xx.sh Tainted: G        W          6.1.0-rc6 #143
[  407.244517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4
[  407.244517] RIP: 0010:kfree+0x4b/0x110
[  407.244517] Code: 80 48 01 e8 0f 82 d8 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 37 70 3b 016
[  407.244517] RSP: 0018:ffff936442d4bde0 EFLAGS: 00000207
[  407.244517] RAX: 01b960a8019881c0 RBX: ffff89fa031068e8 RCX: 00000000000a6e86
[  407.244517] RDX: 0000760680000000 RSI: ffffffff9dfc056d RDI: 6e656c6966207861
[  407.244517] RBP: 6e656c6966207861 R08: 00000000ffffffea R09: 0000000000000000
[  407.244517] R10: ffff89fa060aa4e8 R11: ffffc91e44153d08 R12: 00000000ffffffea
[  407.244517] R13: ffffffff9d5a0240 R14: ffff89fa031f9000 R15: ffff89fa031f9000
[  407.244517] FS:  00007f9f34691740(0000) GS:ffff89fa3dc00000(0000) knlGS:0000000000000000
[  407.244517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.244517] CR2: 00007f9f3470a860 CR3: 0000000100b94000 CR4: 00000000000006e0
[  407.244517] Call Trace:
[  407.244517]  <TASK>
[  407.244517]  argv_free+0xd/0x20
[  407.244517]  ? print_kprobe_event+0x190/0x190
[  407.244517]  trace_probe_create+0x4f/0x90
[  407.244517]  create_or_delete_trace_kprobe+0x11/0x40
[  407.244517]  trace_parse_run_command+0xaa/0x130
[  407.244517]  vfs_write+0xc6/0x3c0
[  407.244517]  ? __do_sys_newfstat+0x57/0x60
[  407.244517]  ksys_write+0x5f/0xe0
[  407.244517]  do_syscall_64+0x3b/0x90
[  407.244517]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  407.244517] RIP: 0033:0x7f9f347a2077
[  407.244517] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 644
[  407.244517] RSP: 002b:00007ffd03965d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  407.244517] RAX: ffffffffffffffda RBX: 000000000000001b RCX: 00007f9f347a2077
[  407.244517] RDX: 000000000000001b RSI: 0000563d529db570 RDI: 0000000000000001
[  407.244517] RBP: 0000563d529db570 R08: 000000000000000a R09: 000000000000001a
[  407.244517] R10: 0000563d51deb017 R11: 0000000000000246 R12: 000000000000001b
[  407.244517] R13: 00007f9f348816a0 R14: 00007f9f3487d4a0 R15: 00007f9f3487c8a0
[  407.244517]  </TASK>
[  407.244517] Modules linked in:
[  407.265327] ---[ end trace 0000000000000000 ]---
[  407.267380] RIP: 0010:kfree+0x4b/0x110
[  407.268251] Code: 80 48 01 e8 0f 82 d8 00 00 00 48 c7 c2 00 00 00 80 48 2b 15 37 70 3b 016
[  407.269811] RSP: 0018:ffff936442d4bde0 EFLAGS: 00000207
[  407.270239] RAX: 01b960a8019881c0 RBX: ffff89fa031068e8 RCX: 00000000000a6e86
[  407.270885] RDX: 0000760680000000 RSI: ffffffff9dfc056d RDI: 6e656c6966207861
[  407.272507] RBP: 6e656c6966207861 R08: 00000000ffffffea R09: 0000000000000000
[  407.273110] R10: ffff89fa060aa4e8 R11: ffffc91e44153d08 R12: 00000000ffffffea
[  407.273773] R13: ffffffff9d5a0240 R14: ffff89fa031f9000 R15: ffff89fa031f9000
[  407.274161] FS:  00007f9f34691740(0000) GS:ffff89fa3dc00000(0000) knlGS:0000000000000000
[  407.274806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  407.275201] CR2: 00007f9f3470a860 CR3: 0000000100b94000 CR4: 00000000000006e0
[  407.276197] Kernel panic - not syncing: Fatal exception
[  407.276792] Kernel Offset: 0x1c400000 from 0xffffffff81000000 (relocation range: 0xffffff)
[  407.276792] ---[ end Kernel panic - not syncing: Fatal exception ]---

