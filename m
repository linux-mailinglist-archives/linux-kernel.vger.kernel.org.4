Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F22702602
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbjEOH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjEOH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:26:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6EA1A5
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:26:33 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QKW5x31KLz18LW7;
        Mon, 15 May 2023 15:22:13 +0800 (CST)
Received: from huawei.com (10.136.117.208) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 15:26:30 +0800
From:   Qiumiao Zhang <zhangqiumiao1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <andriy.shevchenko@linux.intel.com>, <fengtao40@huawei.com>,
        <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanan@huawei.com>, <ilpo.jarvinen@linux.intel.com>,
        <zhangqiumiao1@huawei.com>
Subject: Re: Re: KASAN: soft lockup in paste_selection
Date:   Mon, 15 May 2023 15:26:29 +0800
Message-ID: <20230515072629.1938-1-zhangqiumiao1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <2023051248-captivity-primary-b3c6@gregkh>
References: <2023051248-captivity-primary-b3c6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.136.117.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:33:26AM +0000, gregkh wrote:
>> Hello,
>> 
>> We found the following issue using syzkaller on Linux v5.10.0.
> 
> 5.10.0 is very old and obsolete and over 20 thousand patches old.
> Please, if you are testing LTS kernels, use the latest one.
> 
>> A similar issue was found in function `paste_selection` before and I 
>> believe they are the same.
>> (https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/)
>> 
>> Unfortunately, no one seems to be paying attention to this issue.
> 
> Do you have a proposed patch for this fix now that you have a way to reproduce this?  Do you see this in real situations or only in > fault-injection systems running syzbot?
> 
> And can you reproduce this on 6.4-rc1?  Do you have a reproducer?
> 
> thanks,
> 
> greg k-h

I see this issue only in fault-injection systems running syzbot. And I can reproduce this on 6.4-rc1.
HEAD commit:    ac9a78681b92 Linux 6.4-rc1
git tree:       upstream
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3bc25b00000

I am trying to analyze this issue, but I don't have any suggestions at the moment.

The brief report is below:
========================================================
INFO: task kworker/u16:5:67 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:5   state:D stack:0     pid:67    ppid:2      flags:0x00004000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 ? update_load_avg+0x7e/0x740
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? _raw_spin_unlock+0xe/0x30
 flush_to_ldisc+0x2a/0x190
 process_one_work+0x1e5/0x3f0
 worker_thread+0x4d/0x2f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>
INFO: task a.out:8707 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8707  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8713 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8713  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8842 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8842  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8843 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8843  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8851 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8851  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8858 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8858  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8861 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8861  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8868 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8868  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
INFO: task a.out:8997 blocked for more than 122 seconds.
      Not tainted 6.4.0-rc1 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:a.out           state:D stack:0     pid:8997  ppid:1      flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x281/0x840
 schedule+0x5e/0xd0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x357/0x6a0
 ? prb_read_valid+0x1b/0x30
 paste_selection+0x97/0x1d0
 ? __pfx_default_wake_function+0x10/0x10
 tty_ioctl+0x2cd/0x750
 __x64_sys_ioctl+0x8f/0xc0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f670550677d
RSP: 002b:00007f67057dedf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f67057df640 RCX: 00007f670550677d
RDX: 00000000200000c0 RSI: 000000000000541c RDI: 0000000000000003
RBP: 00007f67057dee20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67057df640
R13: 0000000000000000 R14: 00007f670548b170 R15: 00007ffc74714c40
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

With Best Regards,

Qiumiao Zhang
