Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B3616D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKBTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKBTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C02C4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667416338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VER05fjf0NohBVPF35ToVp+oJ6fxGSpDkuoi/f3w0wA=;
        b=Q4aD3Klz4ZH5OqxOe4E0/PW+bFNMUnzfMW6yiMtFSUwJfwI9ypjil0mV5hiJy87YIYtm5s
        BWzq1YrKQSXWLV/qvJy0ikx8l8+mE7PZzq2WpYMg4/K2qQidBs1U0suOWklgFQ3U3615xR
        h5infTqPCo2PqsGEl1xfGkqn0eT2c6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-fHaa8UhcO6au98qUUN7h_g-1; Wed, 02 Nov 2022 15:12:15 -0400
X-MC-Unique: fHaa8UhcO6au98qUUN7h_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C84185A79C;
        Wed,  2 Nov 2022 19:12:14 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C136449BB60;
        Wed,  2 Nov 2022 19:12:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Chinner <david@fromorbit.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 0/6] mm/autonuma: replace savedwrite infrastructure
Date:   Wed,  2 Nov 2022 20:12:03 +0100
Message-Id: <20221102191209.289237-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on mm-unstable.

As discussed in my talk at LPC, we can reuse the same mechanism for
deciding whether to map a pte writable when upgrading permissions via
mprotect() -- e.g., PROT_READ -> PROT_READ|PROT_WRITE -- to replace the
savedwrite infrastructure used for NUMA hinting faults (e.g., PROT_NONE
-> PROT_READ|PROT_WRITE).

Instead of maintaining previous write permissions for a pte/pmd, we
re-determine if the pte/pmd can be writable. The big benefit is that we
have a common logic for deciding whether we can map a pte/pmd writable on
protection changes.

For private mappings, there should be no difference -- from
what I understand, that is what autonuma benchmarks care about.

I ran autonumabench on a system with 2 NUMA nodes, 96 GiB each via:
	perf stat --null --repeat 10
The numa01 benchmark is quite noisy in my environment and I failed to
reduce the noise so far.

numa01:
	mm-unstable:   146.88 +- 6.54 seconds time elapsed  ( +-  4.45% )
	mm-unstable++: 147.45 +- 13.39 seconds time elapsed  ( +-  9.08% )

numa02:
	mm-unstable:   16.0300 +- 0.0624 seconds time elapsed  ( +-  0.39% )
	mm-unstable++: 16.1281 +- 0.0945 seconds time elapsed  ( +-  0.59% )

It is worth noting that for shared writable mappings that require
writenotify, we will only avoid write faults if the pte/pmd is dirty
(inherited from the older mprotect logic). If we ever care about optimizing
that further, we'd need a different mechanism to identify whether the FS
still needs to get notified on the next write access.

In any case, such an optimiztion will then not be autonuma-specific,
but mprotect() permission upgrades would similarly benefit from it.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>

RFC -> v1:
* "mm/mprotect: allow clean exclusive anon pages to be writable"
 -> Move comment change to patch #2
* "mm/mprotect: minor can_change_pte_writable() cleanups"
 -> Adjust comments
* "mm/huge_memory: try avoiding write faults when changing PMD protection"
 -> Fix wrong check
* "selftests/vm: anon_cow: add mprotect() optimiation tests"
 -> Add basic tests for the mprotect() optimization


David Hildenbrand (5):
  mm/mprotect: minor can_change_pte_writable() cleanups
  mm/huge_memory: try avoiding write faults when changing PMD protection
  mm/autonuma: use can_change_(pte|pmd)_writable() to replace savedwrite
  mm: remove unused savedwrite infrastructure
  selftests/vm: anon_cow: add mprotect() optimization tests

Nadav Amit (1):
  mm/mprotect: allow clean exclusive anon pages to be writable

 arch/powerpc/include/asm/book3s/64/pgtable.h | 80 +-------------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  2 +-
 include/linux/mm.h                           |  2 +
 include/linux/pgtable.h                      | 24 ------
 mm/debug_vm_pgtable.c                        | 32 --------
 mm/huge_memory.c                             | 66 ++++++++++++----
 mm/ksm.c                                     |  9 +--
 mm/memory.c                                  | 19 ++++-
 mm/mprotect.c                                | 33 ++++----
 tools/testing/selftests/vm/anon_cow.c        | 49 +++++++++++-
 10 files changed, 145 insertions(+), 171 deletions(-)

-- 
2.38.1

