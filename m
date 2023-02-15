Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9C6972A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBOAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjBOAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:24:49 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7272D14D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:24:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id d2-20020a056e02050200b0031567bedb09so1193590ils.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 16:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ro3IO5v8s0ZmI31rZ+/7uZhdNatRdqyjN3Q7MJ9bUDE=;
        b=vFUsl+xPctC5nWBbFuk5S09NaZmJRgyH5OqjdhofImYMlekVS9hzJsaTntkuKxk39H
         z+Pgdv72GMLb53ei9GCGzJ/s98WxIRtSwlGO23NzP5Iy7QJ6eC+/nAWQaLhsFNimELvW
         NWmh7Nd7D7+iOlc4bwG0nFDc9xyaY7JiyM48t/pmRzhZuUM0jrwbiSQplKxkd3UJMzZP
         iSXj5p3hwku+vhVfWX4e2Mu1jBJAlv6NG15tBitTjmpQc5hK+SfxpdnGf7tAGIZdsQJ7
         Y1Nhp06267yMcFrnXEwS9KpEBz9+B3ex6XUgupao8/5qr7CxsHuy27WZygTBSMINJeEE
         rFyA==
X-Gm-Message-State: AO0yUKVfqydJV0Ax8Yo724sGwaba4VFfVnDZSx9HVELXMrpYzMj3Xckm
        BfRFgXy84EwiwiEF5w3eEMiYNoMIxHfUL144p+6S2EHGccM4
X-Google-Smtp-Source: AK7set9GCZdZeaKJmAxT+CSMD13tyiuHxwB3Hc3iPf09iLvoaW1NcFzTRdcnemPgGm6esp4cjSIC+H2OUftu5ThHdq5ub64KHvku
MIME-Version: 1.0
X-Received: by 2002:a92:bd10:0:b0:314:1b0:1cfd with SMTP id
 c16-20020a92bd10000000b0031401b01cfdmr183923ile.0.1676420684954; Tue, 14 Feb
 2023 16:24:44 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:24:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bc5be05f4b21b7b@google.com>
Subject: [syzbot] riscv/fixes boot error: INFO: rcu detected stall in corrupted
From:   syzbot <syzbot+42670398d6ddb118138f@syzkaller.appspotmail.com>
To:     aou@eecs.berkeley.edu, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mgorman@suse.de, mingo@redhat.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    950b879b7f02 riscv: Fixup race condition on PG_dcache_clea..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=137aaec0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3cd714c8e9a6e01
dashboard link: https://syzkaller.appspot.com/bug?extid=42670398d6ddb118138f
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42670398d6ddb118138f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (1 GPs behind) idle=36ec/1/0x4000000000000000 softirq=6589/6590 fqs=9960
	(detected by 1, t=30504 jiffies, g=14713, q=4 ncpus=2)
Task dump for CPU 0:
task:cmp             state:R  running task     stack:0     pid:2746  ppid:2744   flags:0x00000008
Call Trace:
[<ffffffff834348b8>] context_switch kernel/sched/core.c:5244 [inline]
[<ffffffff834348b8>] __schedule+0x624/0x1254 kernel/sched/core.c:6555
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (1 GPs behind) idle=36ec/1/0x4000000000000000 softirq=6589/6590 fqs=28261
	(detected by 1, t=122009 jiffies, g=14713, q=4 ncpus=2)
Task dump for CPU 0:
task:cmp             state:R  running task     stack:0     pid:2746  ppid:2744   flags:0x00000008
Call Trace:
[<ffffffff834348b8>] context_switch kernel/sched/core.c:5244 [inline]
[<ffffffff834348b8>] __schedule+0x624/0x1254 kernel/sched/core.c:6555


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
