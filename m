Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7468F088
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBHOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjBHOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:15:34 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D613A84F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:15:33 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id h2-20020a92c262000000b00313b8b647ceso8159687ild.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kAGReMvwanUgY4TaX3gVX0tZleHkXwtai5BIf8RbZs=;
        b=wWoeMErlqfdojZTBE/iVrvH6pl+M8RVwHaqaC+9NZbCkt4Jp1eZBSQ+riUu6TG9S5l
         gbr600TcF2oENiMkutV6oey6N+JrJOfj4hAGH1V/yeBpbKe0P7uAn/6Sx7TvX13IWYBb
         sc5Y3TckE+1hpIH2/WFITVHJxa8+ZzRB3Gm2y852BEqiTPG73yPXM3nAG9+Zd26jU2t9
         A3qJioEQHgobIoCCxvzqJKuYtC+MM2y4fk057Z8Iq4OGNRstCDNXf07yhCaMUPvKBYmG
         lscqQrEUSKEkc5zk4RAwFkUGREzp9evQT6SfYYMloi5HDpnDejAlxXKuAOUbSabyHF+B
         8IqA==
X-Gm-Message-State: AO0yUKXlBaniNJ9hwJOePan125c4oVZjvN3z2by0cS3wT+AK6G0Ddcrs
        DVUy7DjQZBvxl+ex3wpAJwpmf9PQjt35jcTZCvcUBEI82SSm
X-Google-Smtp-Source: AK7set+ZUF292Sp8ig7e03Uv69pL5+dVglEqnOL501DwOGuXJcPBW/n3vlv6aVYl/hc0rrLzDb4PTMJD7XW4aypwci8nd9Qa1sEl
MIME-Version: 1.0
X-Received: by 2002:a02:a509:0:b0:3a6:969:8cce with SMTP id
 e9-20020a02a509000000b003a609698ccemr4399782jam.17.1675865732740; Wed, 08 Feb
 2023 06:15:32 -0800 (PST)
Date:   Wed, 08 Feb 2023 06:15:32 -0800
In-Reply-To: <20230208132556.1881-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0fb2605f430e5ee@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=11593, q=32 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10501 (4294957866-4294947365), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g11593 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28680 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0x245a/0x5a60 kernel/sched/core.c:6619
 schedule+0xde/0x1a0 kernel/sched/core.c:6695
 schedule_timeout+0x14e/0x2b0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x190/0x910 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x23a/0x360 kernel/rcu/tree.c:1808
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 5807 Comm: syz-executor.3 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:copy_page_from_iter_atomic+0xabb/0x1180 lib/iov_iter.c:821
Code: c1 ea 03 80 3c 02 00 0f 85 c8 05 00 00 31 c0 45 8b 66 08 4c 89 74 24 30 49 bd 00 00 00 00 00 fc ff df 49 89 c6 e8 95 b9 6c fd <48> 8d 7d 0c 48 89 f8 48 c1 e8 03 42 0f b6 14 28 48 89 f8 83 e0 07
RSP: 0018:ffffc90005ff7448 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000020 RCX: 0000000000000000
RDX: ffff888021211d40 RSI: ffffffff8417b10b RDI: 0000000000000001
RBP: ffff88802b8abe00 R08: 0000000000000001 R09: 0000000000000002
R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000020
FS:  00007f37e0a3e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37dfd15829 CR3: 000000007d1dd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_perform_write+0x2ca/0x570 mm/filemap.c:3778
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bf/0x1710 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:1851 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x14d/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f37dfc8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f37e0a3e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f37dfdabf80 RCX: 00007f37dfc8c0c9
RDX: 00000000200001c0 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f37dfce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000200a198 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc507f411f R14: 00007f37e0a3e300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e5f41f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d62847480000

