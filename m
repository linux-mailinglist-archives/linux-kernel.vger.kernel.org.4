Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7865B8CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiINQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiINQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:22:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A17A529
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:22:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i19so11497504pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QqY6zjkG7tOexQ+JjAZx9uwGMUGEwBPtZu3WWvYMDno=;
        b=Js3JLJVwxW6aPUc2ShK4wv7Asbdt/viVK7yBFmCA7Vzi1h3NRWCV1b7+pyzu1ocgmi
         yaoBZI6v+7FFkWivhycjh6Cb8zBuStOeDQtVo12O6qXycIKRrH61iDc999xoQCKv4ZMp
         +j/KiKsQmDrhQvhvHcQUpu401lXswdiVtRewqoIWdWFmKCQaQL9nnQBeVMkcysPB2HQ3
         LJOPWpgPO92uKaXam6YL1J1OOEI19DYABLjUs+5xPv9mTMCXXkcb3yOs8jJ13/YoXxZy
         KykZzSLXXKPoffLpARaqo8eJAQtxyrqNSsJmC73ochewSEbMgANHABlEDIA7jllBFbgH
         KSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QqY6zjkG7tOexQ+JjAZx9uwGMUGEwBPtZu3WWvYMDno=;
        b=LNOq8bEzY4ZLId14SFLMoOP7jXzKtZvnflLi1cHli8PZO2JVlxTqsXrImkHWWq4TF3
         L+/QQ5GZkOVmcAhx2LSZHFT4ES95vTb0g2HdsxNjRB5slxNvvtc3I/VapH6DvQVRuaVV
         UhVyNz+O1f6mz6sgVEBHc13/SSzZcHLYqZW69BS2UD5C/8a+3/gXuPgcEbJVr6xdYvf4
         ucoNc8BwevKyNk+dCb7+Iq7O0XJSvC+RfL7OScEtvjWABOBAA8H8vv/wiiDn2f7R45du
         KPMnicF+KpCejpK46JBMgkz5WC3Jq+cvPor/6P37+0l5TZEOcesdoPjYXoBd6Xfwoggj
         jdDg==
X-Gm-Message-State: ACgBeo2adHJHTPvKTfx69rm+3RMhVJ7w5N4melAGZCbTgHKOzp3GtvcO
        EXTxfkT4rXtE36mOBey78m4=
X-Google-Smtp-Source: AA6agR4X81GW/E4KDjaiut+rqrYIpZEF2/pQBOVAZbFy5EboxvbT4KLIY1sfWf8sZQMQouCyKpsliQ==
X-Received: by 2002:a63:5244:0:b0:434:a3b1:bbe8 with SMTP id s4-20020a635244000000b00434a3b1bbe8mr33036980pgl.57.1663172543519;
        Wed, 14 Sep 2022 09:22:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id ik22-20020a170902ab1600b0016dc26c7d30sm5777187plb.164.2022.09.14.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:22:22 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     zokeefe@google.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH] mm: MADV_COLLAPSE: refetch vm_end after reacquiring mmap_lock
Date:   Wed, 14 Sep 2022 09:22:20 -0700
Message-Id: <20220914162220.787703-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzbot reported the below problem:

BUG: Bad page map in process syz-executor198  pte:8000000071c00227 pmd:74b30067
addr:0000000020563000 vm_flags:08100077 anon_vma:ffff8880547d2200 mapping:0000000000000000 index:20563
file:(null) fault:0x0 mmap:0x0 read_folio:0x0
CPU: 1 PID: 3614 Comm: syz-executor198 Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_bad_pte.cold+0x2a7/0x2d0 mm/memory.c:565
 vm_normal_page+0x10c/0x2a0 mm/memory.c:636
 hpage_collapse_scan_pmd+0x729/0x1da0 mm/khugepaged.c:1199
 madvise_collapse+0x481/0x910 mm/khugepaged.c:2433
 madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1062
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1236
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1415
 do_madvise mm/madvise.c:1428 [inline]
 __do_sys_madvise mm/madvise.c:1428 [inline]
 __se_sys_madvise mm/madvise.c:1426 [inline]
 __x64_sys_madvise+0x113/0x150 mm/madvise.c:1426
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f770ba87929
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f770ba18308 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f770bb0f3f8 RCX: 00007f770ba87929
RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007f770bb0f3f0 R08: 00007f770ba18700 R09: 0000000000000000
R10: 00007f770ba18700 R11: 0000000000000246 R12: 00007f770bb0f3fc
R13: 00007ffc2d8b62ef R14: 00007f770ba18400 R15: 0000000000022000

Basically the test program does the below conceptually:
1. mmap 0x2000000 - 0x21000000 as anonymous region
2. mmap io_uring SQ stuff at 0x20563000 with MAP_FIXED, io_uring_mmap()
   actually remaps the pages with special PTEs
3. call MADV_COLLAPSE for 0x20000000 - 0x21000000

It actually triggered the below race:

             CPU A                                          CPU B
mmap 0x20000000 - 0x21000000 as anon
                                           madvise_collapse is called on this area
                                             Retrieve start and end address from the vma (NEVER updated later!)
                                             Collapsed the first 2M area and dropped mmap_lock
Acquire mmap_lock
mmap io_uring file at 0x20563000
Release mmap_lock
                                             Reacquire mmap_lock
                                             revalidate vma pass since 0x20200000 + 0x200000 > 0x20563000
                                             scan the next 2M (0x20200000 - 0x20400000), but due to whatever reason it didn't release mmap_lock
                                             scan the 3rd 2M area (start from 0x20400000)
                                               get into the vma created by io_uring

The hend should be updated after MADV_COLLAPSE reacquire mmap_lock since
the vma may be shrunk.  We don't have to worry about shink from the
other direction since it could be caught by hugepage_vma_revalidate().  Either no valid
vma is found or the vma doesn't fit anymore.

Reported-by: syzbot+915f3e317adb0e85835f@syzkaller.appspotmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a3acd3e5e0f3..1860be232a26 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2592,6 +2592,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 				last_fail = result;
 				goto out_nolock;
 			}
+
+			hend = vma->vm_end & HPAGE_PMD_MASK;
 		}
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
-- 
2.26.3

