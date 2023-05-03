Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57126F6208
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjECXYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjECXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F5E6E95;
        Wed,  3 May 2023 16:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D912B63087;
        Wed,  3 May 2023 23:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15299C433D2;
        Wed,  3 May 2023 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683156273;
        bh=K/V49M3fmE/XvwR5aK0MwXvOUFLt3IEPIoOXeueUAaI=;
        h=Date:From:To:Cc:Subject:From;
        b=DW840XOa6I3ye8EshwGBjplHXxwKsJePC3WoAmIKihibCbjv1u7fzw+mdo9QziNaP
         nhc5rq+aIvQij5gIAFohvYQPOitK2nctlbE5plLG5ZltVHJbgZKMNeSKrN578tcMfw
         WlzLhg1ns2eBsVONzHC98jlNQB/ccJ7ub/9cZR84=
Date:   Wed, 3 May 2023 16:24:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] final MM updates for 6.4-rc1
Message-Id: <20230503162432.24a580b6c1a7fd465ed6bc2d@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this small batch or MM updates, thanks.


The following changes since commit 22b8cc3e78f5448b4c5df00303817a9137cd663f:

  Merge tag 'x86_mm_for_6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-04-28 09:43:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-05-03-16-22

for you to fetch changes up to 245f0922689364b21163af4937a05ea0ba576fae:

  mm: hwpoison: coredump: support recovery from dump_user_range() (2023-05-02 17:21:50 -0700)

----------------------------------------------------------------
- Some DAMON cleanups from Kefeng Wang

- Some KSM work from David Hildenbrand, to make the PR_SET_MEMORY_MERGE
  ioctl's behavior more similar to KSM's behavior.

----------------------------------------------------------------
Baolin Wang (1):
      mm/page_alloc: add some comments to explain the possible hole in __pageblock_pfn_to_page()

David Hildenbrand (3):
      mm/ksm: unmerge and clear VM_MERGEABLE when setting PR_SET_MEMORY_MERGE=0
      selftests/ksm: ksm_functional_tests: add prctl unmerge test
      mm/ksm: move disabling KSM from s390/gmap code to KSM code

Kefeng Wang (4):
      mm/damon/paddr: minor refactor of damon_pa_pageout()
      mm/damon/paddr: minor refactor of damon_pa_mark_accessed_or_deactivate()
      mm/damon/paddr: fix missing folio_sz update in damon_pa_young()
      mm: hwpoison: coredump: support recovery from dump_user_range()

 arch/s390/mm/gmap.c                               | 20 +------
 fs/coredump.c                                     |  1 +
 include/linux/ksm.h                               |  7 +++
 include/linux/uio.h                               | 16 ++++++
 kernel/sys.c                                      | 12 +---
 lib/iov_iter.c                                    | 17 +++++-
 mm/damon/paddr.c                                  | 26 ++++-----
 mm/ksm.c                                          | 70 +++++++++++++++++++++++
 mm/page_alloc.c                                   |  9 +++
 tools/testing/selftests/mm/ksm_functional_tests.c | 46 +++++++++++++--
 10 files changed, 172 insertions(+), 52 deletions(-)

