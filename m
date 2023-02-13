Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5770694FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBMSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBMSqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:46:05 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCD1CAE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=Q6NDNCAExfdin4BhFpoWPBS2rhX6zAj95MmLZivEfLU=; b=c4+AqcfiU/U/E7vRXJ+zX+IM44
        ixiIMtAsgrQ+zdyN6JQDHKET2r1k/qFZNhhuepdVjedMtiCFyEcbBKagm8jJBJ2KIV4H1VYybXPx6
        Sbbcr9aEqgwDpwmG0L7MNzGPbE7my+PV/ahRi94Vqw8kEmdrKfWl6IyYVqKFvfpMxFPVMvgPmhCiH
        Qu1scjq0Q/JIqg6J1qHhxfUuY9zQbnFi5i9eV+0qF1uZ6+DD+Dq58RpNz/Gdl7eb8May0gf6dtmTk
        E7jlZTawhJf5ul8DrKojEBe5fp79Jma1ABGVv1cN81lxQYQDiP+12GDBM1OEuoLDTP+ZXc+F6mNw0
        ngNGdhjJbfZdzgwxuxNqLrAi36MkKxNrHikJfGXhg1t2KVdg95AQimENgjapC4W5GMMQhDWSekodK
        hWML1xq5VL09J1G0cdgND69qJm/MP62WujVv8EY+PgZSBBuO9GBSDyh4cYtUoOi3lpVf+43YPTrUH
        yD1R9vYS7tpn2vCfkU/gu5qA7Kfm8wBOelr/Um8pldAqzwbi+hxaFpnwsFlpvkU6ZFZyH/fSBJh8I
        FMhDa65UQox/pFsVvrdRPAG9CG+2MmypjvN//+aiSBhKcm+BLL6jhoAmDw2CJ2QsZafVTNCVG5wQe
        2kKLLBUjdvEaz930afJdXHpRGPiaR45zL6VYRUgbU=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever on signals
Date:   Mon, 13 Feb 2023 19:45:34 +0100
Message-ID: <2973654.udxrvWzM6v@silver>
In-Reply-To: <4256068.OCvV93pMlr@silver>
References: <20230211075023.137253-1-asmadeus@codewreck.org> <4256068.OCvV93pMlr@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 13, 2023 7:26:54 PM CET Christian Schoenebeck wrote:
> On Saturday, February 11, 2023 8:50:18 AM CET Dominique Martinet wrote:
> > I've been working on async RPCs for a while and never had time to debug
> > the last issues this had, but by limiting the async clunks to failures
> > the impact is drastically smaller and I've not been able to reproduce
> > any more bug so far.
> > 
> > This will require some more testing and I'm tempted to say this is not
> > worth rushing this into the merge window next week-ish; the new problem
> > Jens reported with task_work isn't really new and I'd rather get this
> > right than rush new bugs in given the sour experience I've had with this
> > patch series... Hopefully it'll get in this time.
> > With that in mind I plan to take the patches in to my -next branch after
> > the merge window, so this has time to get reviewed first.
> > 
> > I'd like to measure impact on performance as well, but really spent way
> > more time on this than I already have, so that'll have to wait a bit.
> 
> I have not observed performance degradation, nor any (new) errors. So for
> this entire series:
> 
> Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Sorry, strike that. :-/

When unmounting the 9p file system it would fail (hang/timeout) to kill 9p
processes:

...
[  OK  ] Reached target Unmount All Filesystems.
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create System Users.
[  OK  ] Stopped Remount Root and Kernel File Systems.
[  OK  ] Reached target Shutdown.
[  OK  ] Reached target Final Step.
[  OK  ] Finished Power-Off.
[  OK  ] Reached target Power-Off.
[  323.019620] systemd-shutdown[1]: Syncing filesystems and block devices.
[  353.023371] systemd-shutdown[1]: Syncing filesystems and block devices - timed out, issuing SIGKILL to PID 10124.
[  353.028633] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
[  363.033509] systemd-shutdown[1]: Waiting for process: (sd-sync), systemd-journal
[  443.037702] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  443.045199] systemd-shutdown[1]: Sending SIGKILL to PID 237 (systemd-journal).
[  443.046891] systemd-shutdown[1]: Sending SIGKILL to PID 10124 ((sd-sync)).
[  453.048972] systemd-shutdown[1]: Waiting for process: (sd-sync), systemd-journal
[  484.756639] INFO: task systemd-journal:237 blocked for more than 120 seconds.
[  484.761954]       Tainted: G            E      6.2.0-rc6+ #62
[  484.762940] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  484.764377] task:systemd-journal state:D stack:0     pid:237   ppid:1      flags:0x00004004
[  484.765820] Call Trace:
[  484.766299]  <TASK>
[  484.766667] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  484.767314] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  484.767901] io_schedule (kernel/sched/core.c:8843 kernel/sched/core.c:8869) 
[  484.768486] folio_wait_bit_common (mm/filemap.c:1289) 
[  484.769240] ? find_get_pages_range_tag (mm/filemap.c:2341) 
[  484.770103] ? __pfx_wake_page_function (mm/filemap.c:1079) 
[  484.770987] folio_wait_writeback (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:518 mm/page-writeback.c:3146) 
[  484.771773] __filemap_fdatawait_range (./include/linux/page-flags.h:251 (discriminator 3) ./include/linux/page-flags.h:473 (discriminator 3) mm/filemap.c:522 (discriminator 3)) 
[  484.772630] ? filemap_fdatawrite_wbc (mm/filemap.c:391) 
[  484.773447] ? __filemap_fdatawrite_range (mm/filemap.c:422) 
[  484.774350] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:665) 
[  484.775173] v9fs_vfs_setattr_dotl (./include/linux/pagemap.h:60 fs/9p/vfs_inode_dotl.c:586) 9p
[  484.775997] notify_change (fs/attr.c:486) 
[  484.776657] ? __vfs_getxattr (fs/xattr.c:425) 
[  484.777316] ? do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  484.777928] do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  484.778515] do_sys_ftruncate (fs/open.c:193) 
[  484.779192] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  484.779790] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  484.780643] RIP: 0033:0x7fb8c0f6bb77
[  484.781256] RSP: 002b:00007ffe74e6a5e8 EFLAGS: 00000206 ORIG_RAX: 000000000000004d
[  484.782526] RAX: ffffffffffffffda RBX: 00007ffe74e6a630 RCX: 00007fb8c0f6bb77
[  484.783700] RDX: 0000561d6c28b0b0 RSI: 0000000001000000 RDI: 0000000000000014
[  484.784905] RBP: 0000561d6c294bd0 R08: 0000000000000001 R09: 0000561d6c294c54
[  484.786129] R10: 0000000000000010 R11: 0000000000000206 R12: 00007ffe74e6a628
[  484.787323] R13: 0000561d6c284670 R14: 0000000000000703 R15: 0000000000000000
[  484.788619]  </TASK>
[  484.789152] INFO: task (sd-sync):10124 blocked for more than 120 seconds.
[  484.790622]       Tainted: G            E      6.2.0-rc6+ #62
[  484.791660] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  484.793009] task:(sd-sync)       state:D stack:0     pid:10124 ppid:1      flags:0x00000004
[  484.794431] Call Trace:
[  484.794889]  <TASK>
[  484.795312] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  484.795937] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  484.796751] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  484.797313] wb_wait_for_completion (fs/fs-writeback.c:192 fs/fs-writeback.c:189) 
[  484.798042] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418) 
[  484.798997] sync_inodes_sb (fs/fs-writeback.c:369 (discriminator 3) fs/fs-writeback.c:2726 (discriminator 3)) 
[  484.799644] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  484.800486] iterate_supers (fs/super.c:725) 
[  484.801184] ksys_sync (fs/sync.c:103) 
[  484.801754] __do_sys_sync (fs/sync.c:115) 
[  484.802372] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  484.802975] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  484.803868] RIP: 0033:0x7f41734a1447
[  484.804496] RSP: 002b:00007ffc7f4de6a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  484.805892] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f41734a1447
[  484.807216] RDX: 00000000ffffffff RSI: 00000000ffffffff RDI: 0000000000000003
[  484.808464] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  484.809701] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc7f4dff2b
[  484.810857] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  484.812090]  </TASK>
[  533.055563] systemd-shutdown[1]: Unmounting file systems.
[  533.059617] [10125]: Remounting '/' read-only in with options 'loose,access=client,msize=512000,trans=virtio'.
[  605.587527] INFO: task systemd-journal:237 blocked for more than 241 seconds.
[  605.592716]       Tainted: G            E      6.2.0-rc6+ #62
[  605.593674] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.594956] task:systemd-journal state:D stack:0     pid:237   ppid:1      flags:0x00004004
[  605.596415] Call Trace:
[  605.596884]  <TASK>
[  605.597274] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  605.597875] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  605.598424] io_schedule (kernel/sched/core.c:8843 kernel/sched/core.c:8869) 
[  605.599034] folio_wait_bit_common (mm/filemap.c:1289) 
[  605.599830] ? find_get_pages_range_tag (mm/filemap.c:2341) 
[  605.600750] ? __pfx_wake_page_function (mm/filemap.c:1079) 
[  605.601607] folio_wait_writeback (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:518 mm/page-writeback.c:3146) 
[  605.602314] __filemap_fdatawait_range (./include/linux/page-flags.h:251 (discriminator 3) ./include/linux/page-flags.h:473 (discriminator 3) mm/filemap.c:522 (discriminator 3)) 
[  605.603217] ? filemap_fdatawrite_wbc (mm/filemap.c:391) 
[  605.604060] ? __filemap_fdatawrite_range (mm/filemap.c:422) 
[  605.604877] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:665) 
[  605.605737] v9fs_vfs_setattr_dotl (./include/linux/pagemap.h:60 fs/9p/vfs_inode_dotl.c:586) 9p
[  605.606560] notify_change (fs/attr.c:486) 
[  605.607206] ? __vfs_getxattr (fs/xattr.c:425) 
[  605.607871] ? do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  605.608510] do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  605.609118] do_sys_ftruncate (fs/open.c:193) 
[  605.609867] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  605.610506] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  605.611401] RIP: 0033:0x7fb8c0f6bb77
[  605.612038] RSP: 002b:00007ffe74e6a5e8 EFLAGS: 00000206 ORIG_RAX: 000000000000004d
[  605.613280] RAX: ffffffffffffffda RBX: 00007ffe74e6a630 RCX: 00007fb8c0f6bb77
[  605.614449] RDX: 0000561d6c28b0b0 RSI: 0000000001000000 RDI: 0000000000000014
[  605.615763] RBP: 0000561d6c294bd0 R08: 0000000000000001 R09: 0000561d6c294c54
[  605.616952] R10: 0000000000000010 R11: 0000000000000206 R12: 00007ffe74e6a628
[  605.618206] R13: 0000561d6c284670 R14: 0000000000000703 R15: 0000000000000000
[  605.619547]  </TASK>
[  605.619939] INFO: task (sd-sync):10124 blocked for more than 241 seconds.
[  605.621187]       Tainted: G            E      6.2.0-rc6+ #62
[  605.622229] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  605.623518] task:(sd-sync)       state:D stack:0     pid:10124 ppid:1      flags:0x00000004
[  605.624907] Call Trace:
[  605.625340]  <TASK>
[  605.625758] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  605.626397] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  605.627263] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  605.627802] wb_wait_for_completion (fs/fs-writeback.c:192 fs/fs-writeback.c:189) 
[  605.628530] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418) 
[  605.629380] sync_inodes_sb (fs/fs-writeback.c:369 (discriminator 3) fs/fs-writeback.c:2726 (discriminator 3)) 
[  605.630014] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  605.630789] iterate_supers (fs/super.c:725) 
[  605.631428] ksys_sync (fs/sync.c:103) 
[  605.631999] __do_sys_sync (fs/sync.c:115) 
[  605.632669] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  605.633293] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  605.634188] RIP: 0033:0x7f41734a1447
[  605.634870] RSP: 002b:00007ffc7f4de6a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  605.636181] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f41734a1447
[  605.637444] RDX: 00000000ffffffff RSI: 00000000ffffffff RDI: 0000000000000003
[  605.638750] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  605.640032] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc7f4dff2b
[  605.641313] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  605.642465]  </TASK>
[  623.059026] systemd-shutdown[1]: Remounting '/' timed out, issuing SIGKILL to PID 10125.
[  623.064583] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
[  623.066046] systemd-shutdown[1]: Deactivating swaps.
[  623.067274] systemd-shutdown[1]: All swaps deactivated.
[  623.068436] systemd-shutdown[1]: Detaching loop devices.
[  623.070645] systemd-shutdown[1]: All loop devices detached.
[  623.071918] systemd-shutdown[1]: Stopping MD devices.
[  623.073602] systemd-shutdown[1]: All MD devices stopped.
[  623.074785] systemd-shutdown[1]: Detaching DM devices.
[  623.076416] systemd-shutdown[1]: All DM devices detached.
[  623.077981] systemd-shutdown[1]: Unmounting file systems.
[  623.080197] [10126]: Remounting '/' read-only in with options 'loose,access=client,msize=512000,trans=virtio'.
[  713.079672] systemd-shutdown[1]: Remounting '/' timed out, issuing SIGKILL to PID 10126.
[  713.085323] systemd-shutdown[1]: Not all file systems unmounted, 1 left.
[  713.086770] systemd-shutdown[1]: Cannot finalize remaining file systems, continuing.
[  713.092483] systemd-shutdown[1]: Failed to finalize file systems, ignoring.
[  713.094816] systemd-shutdown[1]: Syncing filesystems and block devices.
[  726.418246] INFO: task systemd-journal:237 blocked for more than 362 seconds.
[  726.423366]       Tainted: G            E      6.2.0-rc6+ #62
[  726.424320] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.425672] task:systemd-journal state:D stack:0     pid:237   ppid:1      flags:0x00004004
[  726.427132] Call Trace:
[  726.427583]  <TASK>
[  726.427968] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  726.428586] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  726.429145] io_schedule (kernel/sched/core.c:8843 kernel/sched/core.c:8869) 
[  726.429753] folio_wait_bit_common (mm/filemap.c:1289) 
[  726.430562] ? find_get_pages_range_tag (mm/filemap.c:2341) 
[  726.431427] ? __pfx_wake_page_function (mm/filemap.c:1079) 
[  726.432254] folio_wait_writeback (./arch/x86/include/asm/bitops.h:207 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flags.h:518 mm/page-writeback.c:3146) 
[  726.432987] __filemap_fdatawait_range (./include/linux/page-flags.h:251 (discriminator 3) ./include/linux/page-flags.h:473 (discriminator 3) mm/filemap.c:522 (discriminator 3)) 
[  726.433815] ? filemap_fdatawrite_wbc (mm/filemap.c:391) 
[  726.434625] ? __filemap_fdatawrite_range (mm/filemap.c:422) 
[  726.435470] filemap_write_and_wait_range (mm/filemap.c:685 mm/filemap.c:665) 
[  726.436313] v9fs_vfs_setattr_dotl (./include/linux/pagemap.h:60 fs/9p/vfs_inode_dotl.c:586) 9p
[  726.437168] notify_change (fs/attr.c:486) 
[  726.437791] ? __vfs_getxattr (fs/xattr.c:425) 
[  726.438483] ? do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  726.439120] do_truncate (./include/linux/fs.h:761 fs/open.c:66) 
[  726.439723] do_sys_ftruncate (fs/open.c:193) 
[  726.440407] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  726.441051] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  726.441882] RIP: 0033:0x7fb8c0f6bb77
[  726.442517] RSP: 002b:00007ffe74e6a5e8 EFLAGS: 00000206 ORIG_RAX: 000000000000004d
[  726.443826] RAX: ffffffffffffffda RBX: 00007ffe74e6a630 RCX: 00007fb8c0f6bb77
[  726.445068] RDX: 0000561d6c28b0b0 RSI: 0000000001000000 RDI: 0000000000000014
[  726.446318] RBP: 0000561d6c294bd0 R08: 0000000000000001 R09: 0000561d6c294c54
[  726.447541] R10: 0000000000000010 R11: 0000000000000206 R12: 00007ffe74e6a628
[  726.448776] R13: 0000561d6c284670 R14: 0000000000000703 R15: 0000000000000000
[  726.449968]  </TASK>
[  726.450373] INFO: task (sd-sync):10124 blocked for more than 362 seconds.
[  726.451534]       Tainted: G            E      6.2.0-rc6+ #62
[  726.452537] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.453896] task:(sd-sync)       state:D stack:0     pid:10124 ppid:1      flags:0x00000004
[  726.455307] Call Trace:
[  726.455747]  <TASK>
[  726.456132] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  726.456756] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  726.457584] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  726.458157] wb_wait_for_completion (fs/fs-writeback.c:192 fs/fs-writeback.c:189) 
[  726.458932] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:418) 
[  726.459847] sync_inodes_sb (fs/fs-writeback.c:369 (discriminator 3) fs/fs-writeback.c:2726 (discriminator 3)) 
[  726.460513] ? __pfx_sync_inodes_one_sb (fs/sync.c:75) 
[  726.461340] iterate_supers (fs/super.c:725) 
[  726.462001] ksys_sync (fs/sync.c:103) 
[  726.462567] __do_sys_sync (fs/sync.c:115) 
[  726.463188] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  726.463825] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  726.464683] RIP: 0033:0x7f41734a1447
[  726.465256] RSP: 002b:00007ffc7f4de6a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
[  726.466581] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f41734a1447
[  726.467795] RDX: 00000000ffffffff RSI: 00000000ffffffff RDI: 0000000000000003
[  726.469025] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  726.470273] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc7f4dff2b
[  726.471510] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  726.472746]  </TASK>
[  726.473147] INFO: task (sd-remount):10125 blocked for more than 120 seconds.
[  726.474313]       Tainted: G            E      6.2.0-rc6+ #62
[  726.475318] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  726.476664] task:(sd-remount)    state:D stack:0     pid:10125 ppid:1      flags:0x00000004
[  726.478116] Call Trace:
[  726.478523]  <TASK>
[  726.478884] __schedule (kernel/sched/core.c:5293 kernel/sched/core.c:6606) 
[  726.479479] ? memcg_slab_post_alloc_hook (./include/linux/percpu-refcount.h:174 ./include/linux/percpu-refcount.h:332 ./include/linux/percpu-refcount.h:351 ./include/linux/memcontrol.h:794 mm/slab.h:553) 
[  726.480340] schedule (kernel/sched/core.c:6683 (discriminator 1)) 
[  726.480851] rwsem_down_write_slowpath (kernel/locking/rwsem.c:1192) 
[  726.481668] ? alloc_fs_context (fs/fs_context.c:291) 
[  726.482390] path_mount (fs/namespace.c:2806 fs/namespace.c:3467) 
[  726.483011] __x64_sys_mount (fs/namespace.c:3489 fs/namespace.c:3697 fs/namespace.c:3674 fs/namespace.c:3674) 
[  726.483698] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  726.484326] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  726.485191] RIP: 0033:0x7f41734ab62a
[  726.485764] RSP: 002b:00007ffc7f4de7c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  726.487081] RAX: ffffffffffffffda RBX: 000055c5c844aa10 RCX: 00007f41734ab62a
[  726.488247] RDX: 0000000000000000 RSI: 000055c5c844aa50 RDI: 0000000000000000
[  726.489475] RBP: 0000000000000000 R08: 000055c5c844a9d0 R09: 000055c5c844a9d0
[  726.490718] R10: 00000000003000a1 R11: 0000000000000246 R12: 00007ffc7f4de900
[  726.491900] R13: 0000000000000000 R14: 00007ffc7f4de848 R15: 0000000000000000
[  726.493003]  </TASK>
[  743.099066] systemd-shutdown[1]: Syncing filesystems and block devices - timed out, issuing SIGKILL to PID 10129.
[  743.104366] systemd-shutdown[1]: Powering off.
[  743.213283] ACPI: PM: Preparing to enter system sleep state S5
[  743.214425] reboot: Power down



