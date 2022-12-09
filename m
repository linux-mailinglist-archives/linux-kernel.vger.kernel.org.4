Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7081648727
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLIRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLIRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33D79C3D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AsC7j/7LavE+UD9fzkAsUw8/Cf1mr7P1I5T2HWHed7c=;
        b=SCKdhanNbL7zowH59rAApF9voEANVsLYPWtvFj3tWn/r9fUWPYx3bw689UVkRRiTqE6II4
        LBZvpD0E1Rpo+Owx0SP3WmZ+LVuK6jPeeHL/nsOur+2ZPV9wFxG4te7ixPCzgpdQAA3j7C
        7XVzbg0So2g50aOo9W8Bn76NBLCqhxI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-j38tn3gaPdmmCE5QebHoNg-1; Fri, 09 Dec 2022 12:01:10 -0500
X-MC-Unique: j38tn3gaPdmmCE5QebHoNg-1
Received: by mail-ot1-f71.google.com with SMTP id f8-20020a9d7b48000000b0066f2d64da41so2670626oto.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsC7j/7LavE+UD9fzkAsUw8/Cf1mr7P1I5T2HWHed7c=;
        b=IMmoQZ+WZxriJTJH1hnAg1SNMWtwQux5fwXIYyunqQVsWL4+dsh9sN6vi7GfB5LHyL
         pWEnzR4ASbFA1qnVCpP3Sf2KDLIuiC/ssOpVVlVFAJJAqGxsk2IX/TgbPXjOz7rDb/Gv
         6r8VdWKDeWaycDw4PVbllqsa6UDIjZSn1LwKGWXtfOsJFVRvH0FnZPwcgILxksiUML/m
         AUynNAN/Nrd/zD8iMx927JlIiaWxNd8U3JpCcMhr0r4w3+gwV5A4p8WaaTqfrKFHCRnL
         e0Lf0eKsRlua1UlLIm/HeQbSrk3cMnAa1py3NxILPMzDYcaMktjZFcbU3kTFkcHs+dTI
         cUpg==
X-Gm-Message-State: ANoB5pkUXN98oQcoeuO1vs5tDw3iO5Sc6EO9Bte1Oqv2/UYckYZ5AjsK
        b6DsJqOsqO3Tl4vohSosJAQfNuguq92HyOZz5aS2/P6DH7k2DX5IdV7vK0h9iMToEmiVHkZA1oA
        A6x3uGxeSgSfNn9nYMlELEMTj
X-Received: by 2002:a05:6870:54c6:b0:144:9231:293 with SMTP id g6-20020a05687054c600b0014492310293mr3350717oan.56.1670605264623;
        Fri, 09 Dec 2022 09:01:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4TMXZvjPUFOTcQ3rZH77G7sux840p8RR+u6SZHByef1YR2CEF9oIgjHW3k1s2G2QqaM1jxCw==
X-Received: by 2002:a05:6870:54c6:b0:144:9231:293 with SMTP id g6-20020a05687054c600b0014492310293mr3350678oan.56.1670605264257;
        Fri, 09 Dec 2022 09:01:04 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:02 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/9] mm/hugetlb: Make huge_pte_offset() thread-safe for pmd unshare
Date:   Fri,  9 Dec 2022 12:00:51 -0500
Message-Id: <20221209170100.973970-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on latest mm-unstable (dbccafc6e992).

This can be seen as a follow-up series to Mike's recent hugetlb vma lock
series for pmd unsharing, but majorly covering safe use of huge_pte_offset.

Changelog for v2->v3:
- Added a-bs and r-bs
- In walk_hugetlb_range() hooks, don't release vma lock for cond_resched()
- Applied quite a few John's comment suggestions in multiple patches
- Squashed patch 10 into patch 9

Old versions:

rfcv1:  https://lore.kernel.org/r/20221030212929.335473-1-peterx@redhat.com
rfcv2:  https://lore.kernel.org/r/20221118011025.2178986-1-peterx@redhat.com
v1:     https://lore.kernel.org/r/20221129193526.3588187-1-peterx@redhat.com
v2:     https://lore.kernel.org/r/20221207203034.650899-1-peterx@redhat.com

Problem
=======

huge_pte_offset() is a major helper used by hugetlb code paths to walk a
hugetlb pgtable.  It's used mostly everywhere since that's needed even
before taking the pgtable lock.

huge_pte_offset() is always called with mmap lock held with either read or
write.  It was assumed to be safe but it's actually not.  One race
condition can easily trigger by: (1) firstly trigger pmd share on a memory
range, (2) do huge_pte_offset() on the range, then at the meantime, (3)
another thread unshare the pmd range, and the pgtable page is prone to lost
if the other shared process wants to free it completely (by either munmap
or exit mm).

The recent work from Mike on vma lock can resolve most of this already.
It's achieved by forbidden pmd unsharing during the lock being taken, so no
further risk of the pgtable page being freed.  It means if we can take the
vma lock around all huge_pte_offset() callers it'll be safe.

There're already a bunch of them that we did as per the latest mm-unstable,
but also quite a few others that we didn't for various reasons especially
on huge_pte_offset() usage.

One more thing to mention is that besides the vma lock, i_mmap_rwsem can
also be used to protect the pgtable page (along with its pgtable lock) from
being freed from under us.  IOW, huge_pte_offset() callers need to either
hold the vma lock or i_mmap_rwsem to safely walk the pgtables.

A reproducer of such problem, based on hugetlb GUP (NOTE: since the race is
very hard to trigger, one needs to apply another kernel delay patch too,
see below):

======8<=======
  #define _GNU_SOURCE
  #include <stdio.h>
  #include <stdlib.h>
  #include <errno.h>
  #include <unistd.h>
  #include <sys/mman.h>
  #include <fcntl.h>
  #include <linux/memfd.h>
  #include <assert.h>
  #include <pthread.h>

  #define  MSIZE  (1UL << 30)     /* 1GB */
  #define  PSIZE  (2UL << 20)     /* 2MB */

  #define  HOLD_SEC  (1)

  int pipefd[2];
  void *buf;

  void *do_map(int fd)
  {
      unsigned char *tmpbuf, *p;
      int ret;

      ret = posix_memalign((void **)&tmpbuf, MSIZE, MSIZE);
      if (ret) {
          perror("posix_memalign() failed");
          return NULL;
      }

      tmpbuf = mmap(tmpbuf, MSIZE, PROT_READ | PROT_WRITE,
                    MAP_SHARED | MAP_FIXED, fd, 0);
      if (tmpbuf == MAP_FAILED) {
          perror("mmap() failed");
          return NULL;
      }
      printf("mmap() -> %p\n", tmpbuf);

      for (p = tmpbuf; p < tmpbuf + MSIZE; p += PSIZE) {
          *p = 1;
      }

      return tmpbuf;
  }

  void do_unmap(void *buf)
  {
      munmap(buf, MSIZE);
  }

  void proc2(int fd)
  {
      unsigned char c;

      buf = do_map(fd);
      if (!buf)
          return;

      read(pipefd[0], &c, 1);
      /*
       * This frees the shared pgtable page, causing use-after-free in
       * proc1_thread1 when soft walking hugetlb pgtable.
       */
      do_unmap(buf);

      printf("Proc2 quitting\n");
  }

  void *proc1_thread1(void *data)
  {
      /*
       * Trigger follow-page on 1st 2m page.  Kernel hack patch needed to
       * withhold this procedure for easier reproduce.
       */
      madvise(buf, PSIZE, MADV_POPULATE_WRITE);
      printf("Proc1-thread1 quitting\n");
      return NULL;
  }

  void *proc1_thread2(void *data)
  {
      unsigned char c;

      /* Wait a while until proc1_thread1() start to wait */
      sleep(0.5);
      /* Trigger pmd unshare */
      madvise(buf, PSIZE, MADV_DONTNEED);
      /* Kick off proc2 to release the pgtable */
      write(pipefd[1], &c, 1);

      printf("Proc1-thread2 quitting\n");
      return NULL;
  }

  void proc1(int fd)
  {
      pthread_t tid1, tid2;
      int ret;

      buf = do_map(fd);
      if (!buf)
          return;

      ret = pthread_create(&tid1, NULL, proc1_thread1, NULL);
      assert(ret == 0);
      ret = pthread_create(&tid2, NULL, proc1_thread2, NULL);
      assert(ret == 0);

      /* Kick the child to share the PUD entry */
      pthread_join(tid1, NULL);
      pthread_join(tid2, NULL);

      do_unmap(buf);
  }

  int main(void)
  {
      int fd, ret;

      fd = memfd_create("test-huge", MFD_HUGETLB | MFD_HUGE_2MB);
      if (fd < 0) {
          perror("open failed");
          return -1;
      }

      ret = ftruncate(fd, MSIZE);
      if (ret) {
          perror("ftruncate() failed");
          return -1;
      }

      ret = pipe(pipefd);
      if (ret) {
          perror("pipe() failed");
          return -1;
      }

      if (fork()) {
          proc1(fd);
      } else {
          proc2(fd);
      }

      close(pipefd[0]);
      close(pipefd[1]);
      close(fd);

      return 0;
  }
======8<=======

The kernel patch needed to present such a race so it'll trigger 100%:

======8<=======
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d97c9a2a15d..f8d99dad5004 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -38,6 +38,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/delay.h>

 #include <linux/io.h>
 #include <linux/hugetlb.h>
@@ -6290,6 +6291,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
                bool unshare = false;
                int absent;
                struct page *page;
+               unsigned long c = 0;

                /*
                 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -6309,6 +6311,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
                 */
                pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
                                      huge_page_size(h));
+
+               pr_info("%s: withhold 1 sec...\n", __func__);
+               for (c = 0; c < 100; c++) {
+                       udelay(10000);
+               }
+               pr_info("%s: withhold 1 sec...done\n", __func__);
+
                if (pte)
                        ptl = huge_pte_lock(h, mm, pte);
                absent = !pte || huge_pte_none(huge_ptep_get(pte));
======8<=======

It'll trigger use-after-free of the pgtable spinlock:

======8<=======
[   16.959907] follow_hugetlb_page: withhold 1 sec...
[   17.960315] follow_hugetlb_page: withhold 1 sec...done
[   17.960550] ------------[ cut here ]------------
[   17.960742] DEBUG_LOCKS_WARN_ON(1)
[   17.960756] WARNING: CPU: 3 PID: 542 at kernel/locking/lockdep.c:231 __lock_acquire+0x955/0x1fa0
[   17.961264] Modules linked in:
[   17.961394] CPU: 3 PID: 542 Comm: hugetlb-pmd-sha Not tainted 6.1.0-rc4-peterx+ #46
[   17.961704] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.962266] RIP: 0010:__lock_acquire+0x955/0x1fa0
[   17.962516] Code: c0 0f 84 5f fe ff ff 44 8b 1d 0f 9a 29 02 45 85 db 0f 85 4f fe ff ff 48 c7 c6 75 50 83 82 48 c7 c7 1b 4b 7d 82 e8 d3 22 d8 00 <0f> 0b 31 c0 4c 8b 54 24 08 4c 8b 04 24 e9
[   17.963494] RSP: 0018:ffffc90000e4fba8 EFLAGS: 00010096
[   17.963704] RAX: 0000000000000016 RBX: fffffffffd3925a8 RCX: 0000000000000000
[   17.963989] RDX: 0000000000000002 RSI: ffffffff82863ccf RDI: 00000000ffffffff
[   17.964276] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffc90000e4fa58
[   17.964557] R10: 0000000000000003 R11: ffffffff83162688 R12: 0000000000000000
[   17.964839] R13: 0000000000000001 R14: ffff888105eac748 R15: 0000000000000001
[   17.965123] FS:  00007f17c0a00640(0000) GS:ffff888277cc0000(0000) knlGS:0000000000000000
[   17.965443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.965672] CR2: 00007f17c09ffef8 CR3: 000000010c87a005 CR4: 0000000000770ee0
[   17.965956] PKRU: 55555554
[   17.966068] Call Trace:
[   17.966172]  <TASK>
[   17.966268]  ? tick_nohz_tick_stopped+0x12/0x30
[   17.966455]  lock_acquire+0xbf/0x2b0
[   17.966603]  ? follow_hugetlb_page.cold+0x75/0x5c4
[   17.966799]  ? _printk+0x48/0x4e
[   17.966934]  _raw_spin_lock+0x2f/0x40
[   17.967087]  ? follow_hugetlb_page.cold+0x75/0x5c4
[   17.967285]  follow_hugetlb_page.cold+0x75/0x5c4
[   17.967473]  __get_user_pages+0xbb/0x620
[   17.967635]  faultin_vma_page_range+0x9a/0x100
[   17.967817]  madvise_vma_behavior+0x3c0/0xbd0
[   17.967998]  ? mas_prev+0x11/0x290
[   17.968141]  ? find_vma_prev+0x5e/0xa0
[   17.968304]  ? madvise_vma_anon_name+0x70/0x70
[   17.968486]  madvise_walk_vmas+0xa9/0x120
[   17.968650]  do_madvise.part.0+0xfa/0x270
[   17.968813]  __x64_sys_madvise+0x5a/0x70
[   17.968974]  do_syscall_64+0x37/0x90
[   17.969123]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   17.969329] RIP: 0033:0x7f1840f0efdb
[   17.969477] Code: c3 66 0f 1f 44 00 00 48 8b 15 39 6e 0e 00 f7 d8 64 89 02 b8 ff ff ff ff eb bc 0f 1f 44 00 00 f3 0f 1e fa b8 1c 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 68
[   17.970205] RSP: 002b:00007f17c09ffe38 EFLAGS: 00000202 ORIG_RAX: 000000000000001c
[   17.970504] RAX: ffffffffffffffda RBX: 00007f17c0a00640 RCX: 00007f1840f0efdb
[   17.970786] RDX: 0000000000000017 RSI: 0000000000200000 RDI: 00007f1800000000
[   17.971068] RBP: 00007f17c09ffe50 R08: 0000000000000000 R09: 00007ffd3954164f
[   17.971353] R10: 00007f1840e10348 R11: 0000000000000202 R12: ffffffffffffff80
[   17.971709] R13: 0000000000000000 R14: 00007ffd39541550 R15: 00007f17c0200000
[   17.972083]  </TASK>
[   17.972199] irq event stamp: 2353
[   17.972372] hardirqs last  enabled at (2353): [<ffffffff8117fe4e>] __up_console_sem+0x5e/0x70
[   17.972869] hardirqs last disabled at (2352): [<ffffffff8117fe33>] __up_console_sem+0x43/0x70
[   17.973365] softirqs last  enabled at (2330): [<ffffffff810f763d>] __irq_exit_rcu+0xed/0x160
[   17.973857] softirqs last disabled at (2323): [<ffffffff810f763d>] __irq_exit_rcu+0xed/0x160
[   17.974341] ---[ end trace 0000000000000000 ]---
[   17.974614] BUG: kernel NULL pointer dereference, address: 00000000000000b8
[   17.975012] #PF: supervisor read access in kernel mode
[   17.975314] #PF: error_code(0x0000) - not-present page
[   17.975615] PGD 103f7b067 P4D 103f7b067 PUD 106cd7067 PMD 0
[   17.975943] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   17.976197] CPU: 3 PID: 542 Comm: hugetlb-pmd-sha Tainted: G        W          6.1.0-rc4-peterx+ #46
[   17.976712] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.977370] RIP: 0010:__lock_acquire+0x190/0x1fa0
[   17.977655] Code: 98 00 00 00 41 89 46 24 81 e2 ff 1f 00 00 48 0f a3 15 e4 ba dd 02 0f 83 ff 05 00 00 48 8d 04 52 48 c1 e0 06 48 05 c0 d2 f4 83 <44> 0f b6 a0 b8 00 00 00 41 0f b7 46 20 6f
[   17.979170] RSP: 0018:ffffc90000e4fba8 EFLAGS: 00010046
[   17.979787] RAX: 0000000000000000 RBX: fffffffffd3925a8 RCX: 0000000000000000
[   17.980838] RDX: 0000000000000002 RSI: ffffffff82863ccf RDI: 00000000ffffffff
[   17.982048] RBP: 0000000000000000 R08: ffff888105eac720 R09: ffffc90000e4fa58
[   17.982892] R10: ffff888105eab900 R11: ffffffff83162688 R12: 0000000000000000
[   17.983771] R13: 0000000000000001 R14: ffff888105eac748 R15: 0000000000000001
[   17.984815] FS:  00007f17c0a00640(0000) GS:ffff888277cc0000(0000) knlGS:0000000000000000
[   17.985924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.986265] CR2: 00000000000000b8 CR3: 000000010c87a005 CR4: 0000000000770ee0
[   17.986674] PKRU: 55555554
[   17.986832] Call Trace:
[   17.987012]  <TASK>
[   17.987266]  ? tick_nohz_tick_stopped+0x12/0x30
[   17.987770]  lock_acquire+0xbf/0x2b0
[   17.988118]  ? follow_hugetlb_page.cold+0x75/0x5c4
[   17.988575]  ? _printk+0x48/0x4e
[   17.988889]  _raw_spin_lock+0x2f/0x40
[   17.989243]  ? follow_hugetlb_page.cold+0x75/0x5c4
[   17.989687]  follow_hugetlb_page.cold+0x75/0x5c4
[   17.990119]  __get_user_pages+0xbb/0x620
[   17.990500]  faultin_vma_page_range+0x9a/0x100
[   17.990928]  madvise_vma_behavior+0x3c0/0xbd0
[   17.991354]  ? mas_prev+0x11/0x290
[   17.991678]  ? find_vma_prev+0x5e/0xa0
[   17.992024]  ? madvise_vma_anon_name+0x70/0x70
[   17.992421]  madvise_walk_vmas+0xa9/0x120
[   17.992793]  do_madvise.part.0+0xfa/0x270
[   17.993166]  __x64_sys_madvise+0x5a/0x70
[   17.993539]  do_syscall_64+0x37/0x90
[   17.993879]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
======8<=======

Resolution
==========

This patchset protects all the huge_pte_offset() callers to also take the
vma lock properly.

Patch Layout
============

Patch 1-2:         cleanup, or dependency of the follow up patches
Patch 3:           before fixing, document huge_pte_offset() on lock required
Patch 4-8:         each patch resolves one possible race condition
Patch 9:           introduce hugetlb_walk() to replace huge_pte_offset()
Patch 10:          document why page_vma_mapped_walk() is safe

Tests
=====

The series is verified with the above reproducer so the race cannot
trigger anymore.  It also passes all hugetlb kselftests.

Comments welcomed, thanks.

Peter Xu (9):
  mm/hugetlb: Let vma_offset_start() to return start
  mm/hugetlb: Don't wait for migration entry during follow page
  mm/hugetlb: Document huge_pte_offset usage
  mm/hugetlb: Move swap entry handling into vma lock when faulted
  mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
  mm/hugetlb: Make hugetlb_follow_page_mask() safe to pmd unshare
  mm/hugetlb: Make follow_hugetlb_page() safe to pmd unshare
  mm/hugetlb: Make walk_hugetlb_range() safe to pmd unshare
  mm/hugetlb: Introduce hugetlb_walk()

 fs/hugetlbfs/inode.c     | 28 ++++++------
 fs/userfaultfd.c         | 26 ++++++++----
 include/linux/hugetlb.h  | 71 +++++++++++++++++++++++++++++++
 include/linux/pagewalk.h | 11 ++++-
 include/linux/swapops.h  |  6 ++-
 mm/hmm.c                 | 15 ++++++-
 mm/hugetlb.c             | 92 +++++++++++++++++-----------------------
 mm/migrate.c             | 25 +++++++++--
 mm/page_vma_mapped.c     |  9 ++--
 mm/pagewalk.c            |  6 +--
 10 files changed, 200 insertions(+), 89 deletions(-)

-- 
2.37.3

