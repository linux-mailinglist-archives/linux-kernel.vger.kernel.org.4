Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9078560BD63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJXW3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJXW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FECF16727B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EDBEB81212
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D5C433D6;
        Mon, 24 Oct 2022 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666644565;
        bh=eaYYbVIt8/+YtwkZbXmhWn+ifMSd+sXZYeDANgnL568=;
        h=From:To:Cc:Subject:Date:From;
        b=WIZ16QyG5Q6vwOmUWHJ7DZ3C93eYq1e4vlvqj2xhXEgil6Dse1Q01vZs3+J0urUO0
         knps5WXaFzvq5VfPiPkJh4e0peL20MAOXXa3m2AEl1KXKAiAcg/8qdI9mVIVW05DFb
         QgvfEpi7XmS/LClWDIGu1sLJtqCNlimdF/GzwpGibfjnf0Qbkjs9DA35HYpW1PB/GE
         ZxLXshRS4GUmu3j8ESWINLnfBZFicdUxQg7HkxjYJ/cFLzmqMvmoLrZVcTKnN5wptr
         Q7DjDGskKYHXg9aWmnsD/7LLYvJpxdvwzNk5SPhnaZ2+MaIjBL5n3uBv+jixPvZlmr
         1g2OnHsgaNSqw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/11] mm/damon: cleanup and refactoring code
Date:   Mon, 24 Oct 2022 20:49:08 +0000
Message-Id: <20221024204919.18524-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset cleans up and refactors a range of DAMON code including
the core, DAMON sysfs interface, and DAMON modules, for better
readability and convenient future feature implementations.

In detail, this patchset splits unnecessarily long and complex functions
in core into smaller functions (patches 1-4).  Then, it cleans up the
DAMON sysfs interface by using more type-safe code (patch 5) and
removing unnecessary function parameters (patch 6).  Further, it
refactor the code by distributing the code into multiple files (patches
7-9).  Last two patches (patches 10 and 11) deduplicates and remove
unnecessary header inclusion in DAMON modules (reclaim and lru_sort).

Note that this initially posted as a part of a feature implementation
RFC patchset[1], but separated into this patchset as the amount of the
change is not small compared to the feature implementation change
itself.

[1] https://lore.kernel.org/damon/20221019001317.104270-1-sj@kernel.org/

SeongJae Park (11):
  mm/damon/core: split out DAMOS-charged region skip logic into a new
    function
  mm/damon/core: split damos application logic into a new function
  mm/damon/core: split out scheme stat update logic into a new function
  mm/damon/core: split out scheme quota adjustment logic into a new
    function
  mm/damon/sysfs: use damon_addr_range for regions' start and end values
  mm/damon/sysfs: remove parameters of damon_sysfs_region_alloc()
  mm/damon/sysfs: move sysfs_lock to common module
  mm/damon/sysfs: move unsigned long range directory to common module
  mm/damon/sysfs: split out kdamond-independent schemes stats update
    logic into a new function
  mm/damon/modules: deduplicate init steps for DAMON context setup
  mm/damon/{reclaim,lru_sort}: remove unnecessarily included headers

 mm/damon/Makefile         |   6 +-
 mm/damon/core.c           | 262 +++++++++++++++++++++++---------------
 mm/damon/lru_sort.c       |  19 +--
 mm/damon/modules-common.c |  42 ++++++
 mm/damon/modules-common.h |   3 +
 mm/damon/reclaim.c        |  19 +--
 mm/damon/sysfs-common.c   | 107 ++++++++++++++++
 mm/damon/sysfs-common.h   |  24 ++++
 mm/damon/sysfs.c          | 172 +++++--------------------
 9 files changed, 374 insertions(+), 280 deletions(-)
 create mode 100644 mm/damon/modules-common.c
 create mode 100644 mm/damon/sysfs-common.c
 create mode 100644 mm/damon/sysfs-common.h

-- 
2.25.1

