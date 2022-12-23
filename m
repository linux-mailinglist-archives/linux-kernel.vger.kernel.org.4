Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BAD65527D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiLWP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiLWP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741A379DF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671810983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YFGL/G9+HUTWGCGBfqQK3zqTS7XYaxW9cVX6e4qh9go=;
        b=BPghOmBt6BCzzgdiguggCTwYVL8acGJQq0Gdc+NrdoC6rGhiQkOTJ43JR89uhffsFPPmaf
        LmGKHmEw0klkHt18gCGf1Y88rJre8L8CSzQ3m6uCdWmxxmoqDr/do8drvRq8Vvy937Q05m
        JBHdrr8vPR76qTDHnQd+ecWCF/C3rb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-pQynWuoHPRKtnTs5xa0qCQ-1; Fri, 23 Dec 2022 10:56:20 -0500
X-MC-Unique: pQynWuoHPRKtnTs5xa0qCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 219A3882827;
        Fri, 23 Dec 2022 15:56:20 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB6B440C2064;
        Fri, 23 Dec 2022 15:56:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v1 0/2] mm: uffd-wp + change_protection() cleanups
Date:   Fri, 23 Dec 2022 16:56:14 +0100
Message-Id: <20221223155616.297723-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on linus/master and [1]:
  "mm/userfaultfd: enable writenotify while userfaultfd-wp is enabled for a
   VMA"

Cleanup page protection handling in uffd-wp when calling
change_protection() and improve unprotecting uffd=wp in private mappings,
trying to set PTEs writable again if possible just like we do during
mprotect() when upgrading write permissions. Make the change_protection()
interface harder to get wrong :)

I consider both pages primarily cleanups, although patch #1 fixes a
corner case with uffd-wp and softdirty tracking for shmem. @Peter, please
let me know if we should flag patch #1 as pure cleanup -- I have no idea
how important softdirty tracking on shmem is.

Survives my simple test case + selftests/vm.

Last patch series before Christmas; happy holidays everyone!

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>

[1] https://lore.kernel.org/all/20221209080912.7968-1-david@redhat.com/T/#u

David Hildenbrand (2):
  mm/userfaultfd: rely on vma->vm_page_prot in uffd_wp_range()
  mm/mprotect: drop pgprot_t parameter from change_protection()

 include/linux/mm.h |  3 +--
 mm/mempolicy.c     |  3 +--
 mm/mprotect.c      | 14 +++++++++++---
 mm/userfaultfd.c   | 17 ++++++++++++-----
 4 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.38.1

