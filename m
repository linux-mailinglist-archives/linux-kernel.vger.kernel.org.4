Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF75FB08E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJKKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3549D8A1D5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9CA961163
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21731C433D6;
        Tue, 11 Oct 2022 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665484684;
        bh=qQxzs9+WhhINB/xESPKt75oMF6IfPfDkJnmpR3udCxY=;
        h=Date:From:To:Cc:Subject:From;
        b=Gj+u3l/p8HrR8foOtNaQerpWinZW8glFVdAy8fvxab2X0w14KpgyQewuSPWaVbX17
         NB0x7cFYBa5d63YJ0pu7fS9n4lpyjC1PPiRpETaa/pIzS7YylxW4Srb/tH+pO2gjh3
         n6mIvx3kfw26gFtFuSngrkzNGhErAdQl1TVqq932GtfK2MdTW+L1bfGcfszz8F9g9+
         uE8vLGCjvw3eJrEvxS71tz4Wjl59MknSna9QqZAjwMtUEI7yx/qSbWH5dDFNDCOfuh
         xhgb36AkakADWCrkjloW5f2/gxPAyvBnrUB7tmXbBIbnbD58vIgHnojgX70GhikcFH
         cDhwFeCPWA7gg==
Date:   Tue, 11 Oct 2022 13:37:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock updates for v6.1
Message-ID: <Y0VHfYkFUqYwVAru@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock for-next

for you to fetch changes up to 3e4519b7afc2f9d99f9303468ee0b23f88399c8d:

  memblock tests: add generic NUMA tests for memblock_alloc_try_nid* (2022-09-18 10:30:20 +0300)

----------------------------------------------------------------
memblock: test suite improvements

* Added verification that memblock allocations zero the allocated memory
* Added more test cases for memblock_add(), memblock_remove(),
  memblock_reserve() and memblock_free()
* Added tests for memblock_*_raw() family
* Added tests for NUMA-aware allocations in memblock_alloc_try_nid() and
  memblock_alloc_try_nid_raw()

----------------------------------------------------------------
Rebecca Mckeever (16):
      memblock tests: add command line help option
      memblock tests: update reference to obsolete build option in comments
      memblock tests: update tests to check if memblock_alloc zeroed memory
      memblock tests: update zeroed memory check for memblock_alloc_* tests
      memblock tests: add labels to verbose output for generic alloc tests
      memblock tests: add additional tests for basic api and memblock_alloc
      memblock tests: update alloc_api to test memblock_alloc_raw
      memblock tests: update alloc_nid_api to test memblock_alloc_try_nid_raw
      memblock tests: add tests for memblock_*bottom_up functions
      memblock tests: add tests for memblock_trim_memory
      memblock tests: remove 'cleared' from comment blocks
      memblock_tests: move variable declarations to single block
      memblock tests: add simulation of physical memory with multiple NUMA nodes
      memblock tests: add top-down NUMA tests for memblock_alloc_try_nid*
      memblock tests: add bottom-up NUMA tests for memblock_alloc_try_nid*
      memblock tests: add generic NUMA tests for memblock_alloc_try_nid*

 tools/testing/memblock/scripts/Makefile.include  |    2 +-
 tools/testing/memblock/tests/alloc_api.c         |  223 ++-
 tools/testing/memblock/tests/alloc_helpers_api.c |   52 +-
 tools/testing/memblock/tests/alloc_nid_api.c     | 1814 +++++++++++++++++++---
 tools/testing/memblock/tests/alloc_nid_api.h     |   16 +
 tools/testing/memblock/tests/basic_api.c         |  767 +++++++++
 tools/testing/memblock/tests/common.c            |   42 +-
 tools/testing/memblock/tests/common.h            |   86 +-
 8 files changed, 2664 insertions(+), 338 deletions(-)
-- 
Sincerely yours,
Mike.
