Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8277443CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjF3VUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF3VUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1F2686
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so22955477b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160001; x=1690752001;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9gcN3gNFu1WTtBUtpC0M4aYh2b9oslK18bWcyLDHdo=;
        b=oNIgkcP+Rm1zkUVn4t5u68ESvpgQIXbrcYw29/gRzdkE5UaATbVPes4z0XxKc6K6/p
         Jw15ZeO2phUHjjdXkz/Fm6vKj6Kxg45Foww+zGK4uOAGQqqs1BrsHBYIMr41Xjj7veyP
         /7nxOF0o6KW7tDm6OUT6bmkpjra0/KYvwtRBjY/lE/5NTj9I0EuMyZRtDufv8j+YeJo4
         BurycZxKQ3Kva49nwAun+2C6w+cBong6Laauu/NCOZuov5J3VnHB+mmdeOgOOJr4/dpD
         PbfVskXqe6CffLh9wmpPLX7R5GUurnXto1SNVVdCYTODhlgKHpIMPgLptoHhfPs82CSh
         M/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160001; x=1690752001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9gcN3gNFu1WTtBUtpC0M4aYh2b9oslK18bWcyLDHdo=;
        b=Cdop/hFdGQoiRJTpo7OdVVAlDfJH3TXvbS3BYeJBvxvhLcSs9BqSp7zVuegP0FQ+Aj
         pPcP3EOxR1/OUJShZm6AROWUXn9aF9+rWYizvTW94hrN4W5LMxOGGv36RQotUlMjy9jp
         X+QE9TG5XyFzCgm/3THD1WJhjUMcNuhoxVVMwal4gChysh1K6Wxj9vaSv+1rkB3nGHoM
         gMwvLyVbjF+NU2c/QlsrrteTlu5GIxWl+5+unJZ5rJ1F5crO2o0emkQESALPuoLTKWkL
         DS3cUku81Y+MIWr9w/QDTxmEMIW9+iXOn7URZzaQUTbkAWL+fStAqN4yWEtk8pN2WlDp
         X/Ig==
X-Gm-Message-State: ABy/qLYWiwANXnxlMyIR9KUY7Omtc+ZRtDAP6zFAHAalXvBNvcboAOPw
        8U2BxNrKoEmnNeo8q6PlyUoOaum0RkE=
X-Google-Smtp-Source: APBJJlFxz+5qjMtbjV4jvSAgVZ7fFk8uY3skGFQMChHy9vo8oYp4UdiT1As/B8NsDi05V0mv39s2UQ7kX1g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a81:bd01:0:b0:56c:e585:8b17 with SMTP id
 b1-20020a81bd01000000b0056ce5858b17mr27432ywi.5.1688160001126; Fri, 30 Jun
 2023 14:20:01 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:51 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-1-surenb@google.com>
Subject: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When per-VMA locks were introduced in [1] several types of page faults
would still fall back to mmap_lock to keep the patchset simple. Among them
are swap and userfault pages. The main reason for skipping those cases was
the fact that mmap_lock could be dropped while handling these faults and
that required additional logic to be implemented.
Implement the mechanism to allow per-VMA locks to be dropped for these
cases.
First, change handle_mm_fault to drop per-VMA locks when returning
VM_FAULT_RETRY or VM_FAULT_COMPLETED to be consistent with the way
mmap_lock is handled. Then change folio_lock_or_retry to accept vm_fault
and return vm_fault_t which simplifies later patches. Finally allow swap
and uffd page faults to be handled under per-VMA locks by dropping per-VMA
and retrying, the same way it's done under mmap_lock.
Naturally, once VMA lock is dropped that VMA should be assumed unstable
and can't be used.

Changes since v6 posted at [2]
- 4/6 replaced the ternary operation in folio_lock_or_retry,
per Matthew Wilcox
- 4/6 changed return code description for __folio_lock_or_retry
per Matthew Wilcox

Note: patch 3/6 will cause a trivial merge conflict in arch/arm64/mm/fault.c
when applied over mm-unstable branch due to a patch from ARM64 tree [3]
which is missing in mm-unstable.

[1] https://lore.kernel.org/all/20230227173632.3292573-1-surenb@google.com/
[2] https://lore.kernel.org/all/20230630020436.1066016-1-surenb@google.com/
[3] https://lore.kernel.org/all/20230524131305.2808-1-jszhang@kernel.org/

Suren Baghdasaryan (6):
  swap: remove remnants of polling from read_swap_cache_async
  mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
  mm: drop per-VMA lock when returning VM_FAULT_RETRY or
    VM_FAULT_COMPLETED
  mm: change folio_lock_or_retry to use vm_fault directly
  mm: handle swap page faults under per-VMA lock
  mm: handle userfaults under VMA lock

 arch/arm64/mm/fault.c    |  3 ++-
 arch/powerpc/mm/fault.c  |  3 ++-
 arch/s390/mm/fault.c     |  3 ++-
 arch/x86/mm/fault.c      |  3 ++-
 fs/userfaultfd.c         | 34 ++++++++++++----------------
 include/linux/mm.h       | 37 ++++++++++++++++++++++++++++++
 include/linux/mm_types.h |  3 ++-
 include/linux/pagemap.h  | 11 +++++----
 mm/filemap.c             | 37 +++++++++++++++---------------
 mm/madvise.c             |  4 ++--
 mm/memory.c              | 49 ++++++++++++++++++++++------------------
 mm/swap.h                |  1 -
 mm/swap_state.c          | 12 ++++------
 13 files changed, 120 insertions(+), 80 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

