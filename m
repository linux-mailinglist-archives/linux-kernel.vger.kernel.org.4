Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598A75FBF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJLCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJLCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB127C1A6;
        Tue, 11 Oct 2022 19:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D94B818D2;
        Wed, 12 Oct 2022 02:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DABC433C1;
        Wed, 12 Oct 2022 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665540643;
        bh=RJsPlD+R+lbcrAiq/JGCorFaBDIETxw6ZRCUMKK2D/g=;
        h=Date:From:To:Cc:Subject:From;
        b=RSQ4TKEhIIBdzsEySkvEKV8CbvvjhpXZAj/USs9eYnFPLwesnPwCq2GVbPY7ZJTxl
         IxhyoHHufeFuVLwlxcmh4oDvmTqAOTsNh6K/PlWzi9gCbWEf5pf/PUu8tMYEPg+Bmk
         kKb1y4K8fIZoE1XMcD7NxaGPmw6I8F91sGIA96Po=
Date:   Tue, 11 Oct 2022 19:10:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.1-rc1
Message-Id: <20221011191042.ff46a7531fb68d05da1d2530@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this small series of fixups.

The following changes since commit 1c8e2349f2d033f634d046063b704b2ca6c46972:

  damon/sysfs: fix possible memleak on damon_sysfs_add_target (2022-09-30 18:46:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-10-11

for you to fetch changes up to d0d51a97063db4704a5ef6bc978dddab1636a306:

  nilfs2: fix leak of nilfs_root in case of writer thread creation failure (2022-10-11 19:05:45 -0700)

----------------------------------------------------------------
Five hotfixes - three for nilfs2, two for MM.  For are cc:stable, one is
not.

----------------------------------------------------------------
Baolin Wang (1):
      mm/hugetlb: fix races when looking up a CONT-PTE/PMD size hugetlb page

Ryusuke Konishi (3):
      nilfs2: fix use-after-free bug of struct nilfs_root
      nilfs2: fix NULL pointer dereference at nilfs_bmap_lookup_at_level()
      nilfs2: fix leak of nilfs_root in case of writer thread creation failure

SeongJae Park (1):
      mm/damon/core: initialize damon_target->list in damon_new_target()

 fs/nilfs2/inode.c       | 19 ++++++++++++++++++-
 fs/nilfs2/segment.c     |  7 +++----
 include/linux/hugetlb.h |  8 ++++----
 mm/damon/core.c         |  1 +
 mm/gup.c                | 14 +++++++++++++-
 mm/hugetlb.c            | 27 +++++++++++++--------------
 6 files changed, 52 insertions(+), 24 deletions(-)

