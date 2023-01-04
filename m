Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0065DC49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbjADSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjADSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:39:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4617406
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51CD3617E1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CE2C433EF;
        Wed,  4 Jan 2023 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672857583;
        bh=8ga8ySSJ1fC4ktF45D7o9yH4mmlkK2JDpm4yXrP3Nks=;
        h=Date:From:To:Cc:Subject:From;
        b=hhK5e4kSZ/5JDbyvvR3xoEcxNFV+AqX1zjFRbK+nnpwy8KFEs5ZaVm/NSL/xIpd27
         i2Y2rbWBwphzy0PA6WzcGE80YTNvk5J29EId7bhe8acNaDYusjRsKkJhocMNVJLDx0
         dcj5kxqJJDysDCMkecf3+l1/m6OwYHpMBs5zebdy9p+V74QvvBZUv2b5wd7bAEZSNb
         PyviPIbhNo+2JPnP16UNteYK2FT/jtCzfFiQ52qTBm9U1UnjOfOfK3ZmKVQpgQq6pE
         cQJqUG2S9uJtk7HWhVsoWC+FP590p2n1gQS1L8TH5MO4B+dKhi/1Jqd8iMsuVfZy4z
         pSpNz2aIFnZLA==
Date:   Wed, 4 Jan 2023 10:39:41 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs fix for 6.2-rc3
Message-ID: <Y7XH7fSoURcqoUQW@google.com>
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

Could you please consider this pull request?

Thanks,

The following changes since commit 69b41ac87e4a664de78a395ff97166f0b2943210:

  Merge tag 'for-6.2-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2023-01-02 11:06:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.2-rc3

for you to fetch changes up to df9d44b645b83fffccfb4e28c1f93376585fdec8:

  f2fs: let's avoid panic if extent_tree is not created (2023-01-03 08:59:06 -0800)

----------------------------------------------------------------
f2fs-fix-6.2-rc3

This series fixes the below three bugs introduced in 6.2-rc1.

- fix a null pointer dereference in f2fs_issue_flush, which occurs by the
combination of mount/remount options.

- fix a bug in per-block age-based extent_cache newly introduced in 6.2-rc1,
which reported a wrong age information in extent_cache.

- fix a kernel panic if extent_tree was not created, which was caught by a
wrong BUG_ON.

----------------------------------------------------------------
Chao Yu (1):
      f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()

Jaegeuk Kim (4):
      f2fs: initialize extent_cache parameter
      f2fs: don't mix to use union values in extent_info
      f2fs: should use a temp extent_info for lookup
      f2fs: let's avoid panic if extent_tree is not created

 fs/f2fs/data.c         |  2 +-
 fs/f2fs/extent_cache.c | 34 ++++++++++++++++++----------------
 fs/f2fs/file.c         |  2 +-
 fs/f2fs/segment.c      | 13 +++++--------
 4 files changed, 25 insertions(+), 26 deletions(-)
