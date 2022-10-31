Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93C86139FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiJaP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJaP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40411833
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667229934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I0sj0FfT7pFyQZ8RINQyH9lTKMjGLK5Ms5n++8SYAkw=;
        b=cXoDCHMq12842LbCC6CCkxpmxoa1G7Wl43ANDTpDBiSMd9jOSFi5k2maxBXduWdYocMYML
        8EU1ov4Gp/vFil9kS+hwdE+y1cYym2L5+CX8hUEJpWSDMSt0JI4XPTJ68yWeAhTIqw739E
        TArTYSxWNOq5Ov1twGGvdKm5W9FnjXs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-DQLF5aPTPTOv6DL5bMJe5w-1; Mon, 31 Oct 2022 11:25:32 -0400
X-MC-Unique: DQLF5aPTPTOv6DL5bMJe5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BFEF3826A43;
        Mon, 31 Oct 2022 15:25:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6802FD48;
        Mon, 31 Oct 2022 15:25:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb mappings
Date:   Mon, 31 Oct 2022 16:25:24 +0100
Message-Id: <20221031152524.173644-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb does not support fake write-faults (write faults without write
permissions). However, we are currently able to trigger a FAULT_FLAG_WRITE
fault on a VMA without VM_WRITE.

If we'd ever want to support FOLL_FORCE|FOLL_WRITE, we'd have to teach
hugetlb to:

(1) Leave the page mapped R/O after the fake write-fault, like
    maybe_mkwrite() does.
(2) Allow writing to an exclusive anon page that's mapped R/O when
    FOLL_FORCE is set, like can_follow_write_pte(). E.g.,
    __follow_hugetlb_must_fault() needs adjustment.

For now, it's not clear if that added complexity is really required.
History tolds us that FOLL_FORCE is dangerous and that we better
limit its use to a bare minimum.

--------------------------------------------------------------------------
  #include <stdio.h>
  #include <stdlib.h>
  #include <fcntl.h>
  #include <unistd.h>
  #include <errno.h>
  #include <stdint.h>
  #include <sys/mman.h>
  #include <linux/mman.h>

  int main(int argc, char **argv)
  {
          char *map;
          int mem_fd;

          map = mmap(NULL, 2 * 1024 * 1024u, PROT_READ,
                     MAP_PRIVATE|MAP_ANON|MAP_HUGETLB|MAP_HUGE_2MB, -1, 0);
          if (map == MAP_FAILED) {
                  fprintf(stderr, "mmap() failed: %d\n", errno);
                  return 1;
          }

          mem_fd = open("/proc/self/mem", O_RDWR);
          if (mem_fd < 0) {
                  fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
                  return 1;
          }

          if (pwrite(mem_fd, "0", 1, (uintptr_t) map) == 1) {
                  fprintf(stderr, "write() succeeded, which is unexpected\n");
                  return 1;
          }

          printf("write() failed as expected: %d\n", errno);
          return 0;
  }
--------------------------------------------------------------------------

Fortunately, we have a sanity check in hugetlb_wp() in place ever since
commit 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared
mappings"), that bails out instead of silently mapping a page writable in
a !PROT_WRITE VMA.

Consequently, above reproducer triggers a warning, similar to the one
reported by szsbot:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3612 at mm/hugetlb.c:5313 hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
Modules linked in:
CPU: 1 PID: 3612 Comm: syz-executor250 Not tainted 6.1.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:hugetlb_wp+0x20a/0x1af0 mm/hugetlb.c:5313
Code: ea 03 80 3c 02 00 0f 85 31 14 00 00 49 8b 5f 20 31 ff 48 89 dd 83 e5 02 48 89 ee e8 70 ab b7 ff 48 85 ed 75 5b e8 76 ae b7 ff <0f> 0b 41 bd 40 00 00 00 e8 69 ae b7 ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc90003caf620 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000008640070 RCX: 0000000000000000
RDX: ffff88807b963a80 RSI: ffffffff81c4ed2a RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07e R12: ffff888023805800
R13: 0000000000000000 R14: ffffffff91217f38 R15: ffff88801d4b0360
FS:  0000555555bba300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff7a47a1b8 CR3: 000000002378d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hugetlb_no_page mm/hugetlb.c:5755 [inline]
 hugetlb_fault+0x19cc/0x2060 mm/hugetlb.c:5874
 follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6301
 __get_user_pages+0x2cb/0xf10 mm/gup.c:1202
 __get_user_pages_locked mm/gup.c:1434 [inline]
 __get_user_pages_remote+0x18f/0x830 mm/gup.c:2187
 get_user_pages_remote+0x84/0xc0 mm/gup.c:2260
 __access_remote_vm+0x287/0x6b0 mm/memory.c:5517
 ptrace_access_vm+0x181/0x1d0 kernel/ptrace.c:61
 generic_ptrace_pokedata kernel/ptrace.c:1323 [inline]
 ptrace_request+0xb46/0x10c0 kernel/ptrace.c:1046
 arch_ptrace+0x36/0x510 arch/x86/kernel/ptrace.c:828
 __do_sys_ptrace kernel/ptrace.c:1296 [inline]
 __se_sys_ptrace kernel/ptrace.c:1269 [inline]
 __x64_sys_ptrace+0x178/0x2a0 kernel/ptrace.c:1269
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...]

So let's silence that warning by teaching GUP code that FOLL_FORCE -- so far
-- does not apply to hugetlb.

Note that FOLL_FORCE for read-access seems to be working as expected.
The assumption is that this has been broken forever, only ever since
above commit, we actually detect the wrong handling and WARN_ON_ONCE().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Signed-off-by: David Hildenbrand <david@redhat.com>
---

I assume this has been broken at least since 2014, when mm/gup.c came to
life. I failed to come up with a suitable Fixes tag quickly.

---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 5182abaaecde..381a8a12916e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -944,6 +944,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
+			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
+			if (is_vm_hugetlb_page(vma))
+				return -EFAULT;
 			/*
 			 * We used to let the write,force case do COW in a
 			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
-- 
2.38.1

