Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809166BA3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCNXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCNXym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4F305E2;
        Tue, 14 Mar 2023 16:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65824B81C23;
        Tue, 14 Mar 2023 23:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5838C433EF;
        Tue, 14 Mar 2023 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678838077;
        bh=lBwRexoyOMDFHO7r/TQkAasPKx3xAzJwYeAYcLKUWYU=;
        h=Date:From:To:Cc:Subject:From;
        b=EtSPjD/p02rlFFCjM+3NwtQXFytMqqa5nT20nEqAi1J/jlN8q1UNKuTctESXlOD63
         0RIHEBWKgcmLzFAKzO/7GY1Vbs6NvkTKjix9D8WUhz/GfVlhGJe3WdJSCAecYh5dXl
         WekwDDaSvWkyhmW9hvQUgZtTBneee2e/7ulEsF40=
Date:   Tue, 14 Mar 2023 16:54:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.3-rc1
Message-Id: <20230314165437.a2d992731a970582fe36aaba@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of MM and non-MM fixups, thanks.


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-14-16-51

for you to fetch changes up to dd52a61da0dd8bab8b90e808f0e5ad507b61ad6d:

  mm/damon/paddr: fix folio_nr_pages() after folio_put() in damon_pa_mark_accessed_or_deactivate() (2023-03-07 17:04:55 -0800)

----------------------------------------------------------------
Eleven hotfixes.  Four of these are cc:stable and the remainder address
post-6.2 issues or aren't considered suitable for backporting.  Seven of
these fixes are for MM.

----------------------------------------------------------------
Alexandre Ghiti (1):
      .mailmap: add Alexandre Ghiti personal email address

David Hildenbrand (1):
      mm/userfaultfd: propagate uffd-wp bit when PTE-mapping the huge zeropage

Huang Ying (3):
      migrate_pages: fix deadlock in batched migration
      migrate_pages: move split folios processing out of migrate_pages_batch()
      migrate_pages: try migrate in batch asynchronously firstly

James Houghton (1):
      mm: teach mincore_hugetlb about pte markers

Jan Kara via Ocfs2-devel (1):
      ocfs2: fix data corruption after failed write

Jarkko Sakkinen (1):
      mailmap: updates for Jarkko Sakkinen

Konrad Dybcio (1):
      mailmap: correct Dikshita Agarwal's Qualcomm email address

SeongJae Park (2):
      mm/damon/paddr: fix folio_size() call after folio_put() in damon_pa_young()
      mm/damon/paddr: fix folio_nr_pages() after folio_put() in damon_pa_mark_accessed_or_deactivate()

 .mailmap         |   4 +-
 fs/ocfs2/aops.c  |  19 +++++-
 mm/damon/paddr.c |   5 +-
 mm/huge_memory.c |   6 +-
 mm/migrate.c     | 185 ++++++++++++++++++++++++++++---------------------------
 mm/mincore.c     |   2 +-
 6 files changed, 122 insertions(+), 99 deletions(-)

