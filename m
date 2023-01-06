Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415A6609AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjAFWtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAFWt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:49:27 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158C3C700
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1673045366; x=1704581366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b92wzO1QTXNY++unlUUm0NBNCNegMzW2zc+jnoKi2Lw=;
  b=qefOJXwhBpy0H+Vr7gCay7Wi5ZZIe62R2Fx0rmzQfc0/Zegy00Cjtg3i
   4PbEqjbxsDgGLBlghiPUTAcCj62PxaeBKIFa8XiPj4aXSY06r0h6WDDyO
   zu42WIpJL5vPfCtWVgVvzU3Uk1Vr5qN1YqAEKn+lIZpZTWnfGO7lxs1yQ
   I=;
X-IronPort-AV: E=Sophos;i="5.96,306,1665446400"; 
   d="scan'208";a="284196790"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 22:49:26 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id F3202412BE;
        Fri,  6 Jan 2023 22:49:24 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Fri, 6 Jan 2023 22:49:24 +0000
Received: from u9aa42af9e4c55a.ant.amazon.com (10.43.161.114) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Fri, 6 Jan 2023 22:49:23 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <hannes@cmpxchg.org>, <surenb@google.com>
CC:     <ebiggers@kernel.org>, <mengcc@amazon.com>,
        <linux-kernel@vger.kernel.org>
Subject: another use-after-free in ep_remove_wait_queue()
Date:   Fri, 6 Jan 2023 14:48:59 -0800
Message-ID: <20230106224859.4123476-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.161.114]
X-ClientProxiedBy: EX13D44UWC002.ant.amazon.com (10.43.162.169) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We found the following use-after-free with userspace code polling on
a pressure file in a non-root cgroup using epoll.

[   57.183661] BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x76/0x130
[   57.186662] Write of size 4 at addr ffff888114976428 by task a.out/2426

[   57.190551] CPU: 0 PID: 2426 Comm: a.out Not tainted 6.2.0-rc2+ #16
[   57.193384] Hardware name: Amazon EC2 c5a.large/, BIOS 1.0 10/16/2017
[   57.196272] Call Trace:
[   57.197565]  <TASK>
[   57.198714]  dump_stack_lvl+0x8f/0xc0
[   57.200494]  print_report+0x16c/0x4e0
[   57.202084]  ? _raw_spin_lock_irqsave+0x76/0x130
[   57.204077]  kasan_report+0xc3/0xf0
[   57.205587]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   57.207760]  ? _raw_spin_lock_irqsave+0x76/0x130
[   57.209685]  kasan_check_range+0x2d2/0x310
[   57.211477]  _raw_spin_lock_irqsave+0x76/0x130
[   57.213355]  remove_wait_queue+0x25/0x130
[   57.215102]  ep_free+0x12d/0x220
[   57.216506]  ep_eventpoll_release+0x3c/0x40
[   57.218254]  __fput+0x32b/0x700
[   57.221486]  task_work_run+0x1db/0x230
[   57.224885]  exit_to_user_mode_prepare+0xfd/0x100
[   57.228662]  syscall_exit_to_user_mode+0x20/0x40
[   57.232360]  do_syscall_64+0x52/0x90
[   57.235691]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   57.239572] RIP: 0033:0x7fadf96e1c44
[   57.242865] Code: 00 00 b8 ff ff ff ff eb 9c b8 ff ff ff ff eb 95 e8 01 e2 01 00 90 8b 05 2a ac 2c 00 48 63 ff 85 c0 75 11 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3a f3 c3 48 83 ec 18 48 89 7c 24 08 e8 e4 a0
[   57.255244] RSP: 002b:00007ffd1d1b7b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   57.261714] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fadf96e1c44
[   57.266293] RDX: 0000000000000000 RSI: 00007ffd1d1b7b60 RDI: 0000000000000004
[   57.270979] RBP: 00007ffd1d1b7bf0 R08: 00000000004007e0 R09: 00007fadf9a0f240
[   57.275856] R10: 00000000000006ba R11: 0000000000000246 R12: 00000000004005e0
[   57.280478] R13: 00007ffd1d1b7cd0 R14: 0000000000000000 R15: 0000000000000000
[   57.285059]  </TASK>

[   57.290402] Allocated by task 2426:
[   57.293705]  kasan_set_track+0x3d/0x60
[   57.297102]  __kasan_kmalloc+0x85/0x90
[   57.300491]  psi_trigger_create+0x155/0x850
[   57.304040]  pressure_write+0x200/0x510
[   57.307508]  cgroup_file_write+0x1de/0x3e0
[   57.310949]  kernfs_fop_write_iter+0x27d/0x380
[   57.314601]  vfs_write+0x7d7/0xaa0
[   57.317891]  ksys_write+0xd7/0x1a0
[   57.321152]  do_syscall_64+0x43/0x90
[   57.324496]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[   57.330887] Freed by task 2429:
[   57.334053]  kasan_set_track+0x3d/0x60
[   57.337448]  kasan_save_free_info+0x27/0x40
[   57.340977]  ____kasan_slab_free+0x11d/0x170
[   57.344570]  slab_free_freelist_hook+0x87/0x150
[   57.348236]  __kmem_cache_free+0xcb/0x180
[   57.351710]  psi_trigger_destroy+0x458/0x550
[   57.355274]  cgroup_file_release+0x96/0x110
[   57.358779]  kernfs_drain_open_files+0x238/0x420
[   57.362519]  kernfs_drain+0x191/0x2a0
[   57.365901]  __kernfs_remove+0x3a6/0x600
[   57.369363]  kernfs_remove_by_name_ns+0xc2/0x120
[   57.373073]  cgroup_addrm_files+0x90f/0xcf0
[   57.376610]  cgroup_destroy_locked+0x48a/0x730
[   57.380260]  cgroup_rmdir+0x2b/0x130
[   57.383650]  kernfs_iop_rmdir+0x17a/0x230
[   57.387201]  vfs_rmdir+0x196/0x410
[   57.390442]  do_rmdir+0x1c7/0x3f0
[   57.393651]  __x64_sys_rmdir+0x45/0x50
[   57.397000]  do_syscall_64+0x43/0x90
[   57.400340]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

[   57.406689] The buggy address belongs to the object at ffff888114976400
                which belongs to the cache kmalloc-128 of size 128
[   57.414907] The buggy address is located 40 bytes inside of
                128-byte region [ffff888114976400, ffff888114976480)

[   57.425474] The buggy address belongs to the physical page:
[   57.429541] page:000000008c5ecb31 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x114976
[   57.436725] flags: 0x2fffff80000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[   57.441235] raw: 002fffff80000200 ffff8881000418c0 dead000000000100 dead000000000122
[   57.447793] raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
[   57.454274] page dumped because: kasan: bad access detected

[   57.460990] Memory state around the buggy address:
[   57.464744]  ffff888114976300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   57.471126]  ffff888114976380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   57.477447] >ffff888114976400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   57.483833]                                   ^
[   57.487541]  ffff888114976480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   57.493976]  ffff888114976500: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 fc fc

Here is the simple repro.

#include <fcntl.h>
#include <sys/epoll.h>
#include <unistd.h>

int main(void)
{
	const char trigger_str[] = "some 100000 1000000";
	int fd, epfd;
	struct epoll_event event;
	struct epoll_event events[1];

	fd = open("/cgroup2/test/cpu.pressure", O_RDWR);
	write(fd, trigger_str, sizeof(trigger_str));
	epfd = epoll_create(1);
	event.events = EPOLLPRI | EPOLLET;
	event.data.fd = fd;
	epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &event);
	epoll_wait(epfd, events, 1, -1); /* returns after rmdir */
	sleep(5);
	close(epfd);
	close(fd);

	return 0;
}

# mkdir /cgroup2
# mount -t cgroup2 none /cgroup2
# mkdir /cgroup2/test
# ./a.out &
# rmdir /cgroup2/test

Looks like calling wake_up_pollfree() in psi_trigger_destroy() can properly
clear the queue and then avoid this use-after-free, but POLLFREE wasn't
considered enough there for the past similar issue[1]. While
wake_up_pollfree() could *also* be called in psi_trigger_destroy(), it may
be awkward and there can be more appropriate solution. It would be great if
experts could have a look.

[1] https://lkml.org/lkml/2021/11/16/264


Regards,
Munehisa
