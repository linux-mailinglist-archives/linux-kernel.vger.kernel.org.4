Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96326CEC34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjC2Oxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjC2Oxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:53:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8A10F9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:53:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y20so20616657lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101623; x=1682693623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEfOw359GRtKE8JCHIM8Osck0I4+SZuJBzUhnN6nlo8=;
        b=XjLsCsvn2a3ktcgvoxrI3m6Hds0ImD4++hcwbtY5mAvMFbIWA1qd/u9qZrBYzOUF/9
         q6a1SeSR4o2oggFekN91HgYcXltH9kFil7hJPOgM7O0Q+f0FEYLjtaJH7E32blYe+SPp
         aizgMdw/+R/V1Dn3RZZSWl947luOD2oEDYbM+ETcn97+ILXUsu+RHoDgjNfT4OfpNx/v
         wwXjOxPbzvLokpL57HHdji8y8Gk7A4NnbHmwV/xw6fXV7wGB0RTz4UU2eNtqMgnCdwDA
         HsBGknsOSkR0xQTcxN0Txg+FL1aRhenfL42rKtq1BsmHtadmhBiklX4RIlPf40Yo4Qw4
         G19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101623; x=1682693623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEfOw359GRtKE8JCHIM8Osck0I4+SZuJBzUhnN6nlo8=;
        b=Tp42lizuR8Bc/iEDXPRTISmNQHFW1scaqzBnuQK3cC3agvn7h+ynr+W6AZc6EpzleQ
         TXMoGSx99YLzBr4DV2azHJfinwa7ovIZysC4+vEG0AO7bk5RQQ7daqk2nDJrLAr8Il+P
         m3zgzsZAcFBoi4rXAJF+7bYqE5WOr1PvPaWW+GTNUQJXThn2ZF0x7Gz1ScNprklZyaGx
         tl1371yh2mKMvCv5bUeojjY8NdVflyGBChYcdDOCOGYrbo2IvBn67+5BZNcWxU0aFgWN
         IxJ+eDjrOjge8qJz/5arMD1ef6oQWvXAIqMReGUNUxKrESoKxWTBvVouX8rxI+TXJ7Yy
         MN4A==
X-Gm-Message-State: AAQBX9cIYPcYqzr9M1eb6/QvmKH5PV/ZNoT6kSYqlVlVBJt+bxhWL/dt
        Ly+621C/WUG41oi9z4M5oyo=
X-Google-Smtp-Source: AKy350YdsUKflXAEBl1vJ9VDW1DfapsI013xZTK3XHhLffq3SlUJND31lkuQM3vbpQwCIOiQ/dDjJA==
X-Received: by 2002:ac2:5989:0:b0:4dd:a025:d87 with SMTP id w9-20020ac25989000000b004dda0250d87mr4805726lfn.0.1680101622641;
        Wed, 29 Mar 2023 07:53:42 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004eb0c51780bsm1619723lff.29.2023.03.29.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:53:42 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, himadrispandya@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Subject: [PATCH] mm: khugepaged: Fix kernel BUG in hpage_collapse_scan_file
Date:   Wed, 29 Mar 2023 18:53:30 +0400
Message-Id: <20230329145330.23191-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

kernel BUG at mm/khugepaged.c:1823!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkaller-13154-g857f1268a591 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 85 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
 madvise_vma_behavior mm/madvise.c:1086 [inline]
 madvise_walk_vmas mm/madvise.c:1260 [inline]
 do_madvise+0x9e5/0x4680 mm/madvise.c:1439
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The 'xas_store' call during page cache scanning can potentially
translate 'xas' into the error state (with the reproducer provided
by the syzkaller the error code is -ENOMEM). However, there are no
further checks after the 'xas_store', and the next call of 'xas_next'
at the start of the scanning cycle doesn't increase the xa_index,
and the issue occurs.

This patch will add the xarray state error checking after the
'xas_store' and the corresponding result error code.

Tested via syzbot.

Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 92e6f56a932d..4d9850d9ea7f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -55,6 +55,7 @@ enum scan_result {
 	SCAN_CGROUP_CHARGE_FAIL,
 	SCAN_TRUNCATED,
 	SCAN_PAGE_HAS_PRIVATE,
+	SCAN_STORE_FAILED,
 };
 
 #define CREATE_TRACE_POINTS
@@ -1840,6 +1841,15 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					goto xa_locked;
 				}
 				xas_store(&xas, hpage);
+				if (xas_error(&xas)) {
+					/* revert shmem_charge performed
+					 * in the previous condition
+					 */
+					mapping->nrpages--;
+					shmem_uncharge(mapping->host, 1);
+					result = SCAN_STORE_FAILED;
+					goto xa_locked;
+				}
 				nr_none++;
 				continue;
 			}
-- 
2.34.1

