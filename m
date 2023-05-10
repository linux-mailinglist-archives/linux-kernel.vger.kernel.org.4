Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC996FDFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjEJOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbjEJOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:16:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E0784ED3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:15:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1B71063;
        Wed, 10 May 2023 07:16:41 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823D93F67D;
        Wed, 10 May 2023 07:15:56 -0700 (PDT)
Date:   Wed, 10 May 2023 15:15:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 30, 2023 at 09:19:17PM +0100, Lorenzo Stoakes wrote:
> We may still have inconsistent input parameters even if we choose not to
> merge and the vma_merge() invariant checks are useful for checking this
> with no production runtime cost (these are only relevant when
> CONFIG_DEBUG_VM is specified).
> 
> Therefore, perform these checks regardless of whether we merge.
> 
> This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> Correctly update prev when policy is equal on mbind") in the mbind logic
> was only picked up in the 6.2.y stable branch where these assertions are
> performed prior to determining mergeability.
> 
> Had this remained the same in mainline this issue may have been picked up
> faster, so moving forward let's always check them.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5522130ae606..13678edaa22c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		merge_next = true;
>  	}
>  
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);
> +

I'm seeing this fire a lot when fuzzing v6.4-rc1 on arm64 using Syzkaller.

The splat looks like:

| Syzkaller hit 'WARNING in vma_merge' bug.
|
| ------------[ cut here ]------------
| WARNING: CPU: 0 PID: 193 at mm/mmap.c:965 vma_merge+0x21c/0x1158 mm/mmap.c:965
| CPU: 0 PID: 193 Comm: syz-executor105 Not tainted 6.4.0-rc1-00001-g7d54d3135001 #1
| Hardware name: linux,dummy-virt (DT)
| pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : vma_merge+0x21c/0x1158 mm/mmap.c:965
| lr : vma_merge+0x21c/0x1158 mm/mmap.c:965
| sp : ffff800018ec7970
| x29: ffff800018ec7970 x28: 0000000020000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 1ffff000031d8f42 x24: ffff000010d58000
| x23: 0000000000000000 x22: ffff000017acc9b0 x21: 0000000020ffd000
| x20: 0000000020ffb000 x19: ffff000017acc8b8 x18: 0000000000000005
| x17: 0000000000000000 x16: 0000000000000000 x15: 1fffe00002f27494
| x14: 0000000000000000 x13: 000000009a8feb3a x12: ffff700002ddc77d
| x11: 1ffff00002ddc77c x10: ffff700002ddc77c x9 : dfff800000000000
| x8 : ffff800016ee3be3 x7 : 0000000000000000 x6 : 0000000000000000
| x5 : ffff000017939b00 x4 : ffff800010c4a000 x3 : ffff800008000000
| x2 : 0000000000000000 x1 : ffff000017939b00 x0 : 0000000000000000
| Call trace:
|  vma_merge+0x21c/0x1158 mm/mmap.c:965
|  userfaultfd_register fs/userfaultfd.c:1485 [inline]
|  userfaultfd_ioctl+0x378c/0x4240 fs/userfaultfd.c:2050
|  vfs_ioctl fs/ioctl.c:51 [inline]
|  __do_sys_ioctl fs/ioctl.c:870 [inline]
|  __se_sys_ioctl fs/ioctl.c:856 [inline]
|  __arm64_sys_ioctl+0x184/0x218 fs/ioctl.c:856
|  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
|  invoke_syscall+0x8c/0x2d8 arch/arm64/kernel/syscall.c:52
|  el0_svc_common.constprop.0+0xf4/0x300 arch/arm64/kernel/syscall.c:142
|  do_el0_svc+0x6c/0x180 arch/arm64/kernel/syscall.c:193
|  el0_svc+0x4c/0x110 arch/arm64/kernel/entry-common.c:637
|  el0t_64_sync_handler+0xf4/0x120 arch/arm64/kernel/entry-common.c:655
|  el0t_64_sync+0x190/0x198 arch/arm64/kernel/entry.S:591
| irq event stamp: 2212
| hardirqs last  enabled at (2211): [<ffff80000805d03c>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
| hardirqs last  enabled at (2211): [<ffff80000805d03c>] el0_svc_common.constprop.0+0xac/0x300 arch/arm64/kernel/syscall.c:107
| hardirqs last disabled at (2212): [<ffff80000e67c40c>] el1_dbg+0x24/0xa0 arch/arm64/kernel/entry-common.c:405
| softirqs last  enabled at (2190): [<ffff800008021718>] softirq_handle_end kernel/softirq.c:414 [inline]
| softirqs last  enabled at (2190): [<ffff800008021718>] __do_softirq+0x8e8/0xe50 kernel/softirq.c:600
| softirqs last disabled at (2183): [<ffff80000802ad9c>] ____do_softirq+0x1c/0x30 arch/arm64/kernel/irq.c:80
| ---[ end trace 0000000000000000 ]---

I can reproduce that reliably with the below:

| #include <linux/userfaultfd.h>
| #include <sys/ioctl.h>
| #include <sys/mman.h>
| #include <sys/syscall.h>
| #include <sys/types.h>
| #include <unistd.h>
|   
| int main(int argc, char *argv[])
| {
|         int uffd;
|         void *addr;
| 
|         struct uffdio_api uffdio_api;
|         struct uffdio_register uffdio_register;
| 
|         uffd = syscall(__NR_userfaultfd, 0x801ul);
| 
|         uffdio_api.api = UFFD_API;
|         uffdio_api.features = 0;
|         ioctl(uffd, UFFDIO_API, &uffdio_api);
| 
|         addr = mmap(NULL, 0x1000000ul, PROT_READ | PROT_WRITE,
|                     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
| 
|         uffdio_register.range.start = (unsigned long)addr + 0x10000;
|         uffdio_register.range.len = 0x2000;
|         uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
|         ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);
| 
|         return 0;
| }

... which is cleaned up from the orginial Syzkaller reproducer:

| Syzkaller reproducer:
| # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false UseTmpDir:false HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
| r0 = userfaultfd(0x801)
| r1 = dup(r0)
| ioctl$UFFDIO_API(r1, 0xc018aa3f, &(0x7f0000000000))
| ioctl$UFFDIO_REGISTER(r1, 0xc020aa00, &(0x7f00000001c0)={{&(0x7f0000ffb000/0x2000)=nil, 0x2000}, 0x1})
| 
| 
| C reproducer:
| // autogenerated by syzkaller (https://github.com/google/syzkaller)
| 
| #define _GNU_SOURCE 
| 
| #include <endian.h>
| #include <stdint.h>
| #include <stdio.h>
| #include <stdlib.h>
| #include <string.h>
| #include <sys/syscall.h>
| #include <sys/types.h>
| #include <unistd.h>
| 
| #ifndef __NR_dup
| #define __NR_dup 23
| #endif
| #ifndef __NR_ioctl
| #define __NR_ioctl 29
| #endif
| #ifndef __NR_mmap
| #define __NR_mmap 222
| #endif
| #ifndef __NR_userfaultfd
| #define __NR_userfaultfd 282
| #endif
| 
| uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};
| 
| int main(void)
| {
| 		syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
| 	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
| 	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
| 				intptr_t res = 0;
| 	res = syscall(__NR_userfaultfd, 0x801ul);
| 	if (res != -1)
| 		r[0] = res;
| 	res = syscall(__NR_dup, r[0]);
| 	if (res != -1)
| 		r[1] = res;
| *(uint64_t*)0x20000000 = 0xaa;
| *(uint64_t*)0x20000008 = 0;
| *(uint64_t*)0x20000010 = 0;
| 	syscall(__NR_ioctl, r[1], 0xc018aa3f, 0x20000000ul);
| *(uint64_t*)0x200001c0 = 0x20ffb000;
| *(uint64_t*)0x200001c8 = 0x2000;
| *(uint64_t*)0x200001d0 = 1;
| *(uint64_t*)0x200001d8 = 0;
| 	syscall(__NR_ioctl, r[1], 0xc020aa00, 0x200001c0ul);
| 	return 0;
| } 

Thanks,
Mark.
