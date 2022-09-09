Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933605B3EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIISXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIISXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409457CB60
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2379620AC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC67AC433C1;
        Fri,  9 Sep 2022 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662747808;
        bh=H7JA/y/f137i4moCHPcmtccIRWO3ZibFgOB0aiuxoJU=;
        h=Date:From:To:Cc:Subject:From;
        b=aNDFvOUfAWI23skEb8soxtY3AI2YwZOdqsreykJlhm5dw6PCO+YN/kbQ+8gEXoJFv
         CsHUrbOIPQ2wY8fQp+pqbvyxy/j9M1akWG/nJi+lkU8QG5BCeIujNFa1itYoJcawhm
         BIFCLGp0HoXz/rb0ZTemp3l37eF2YI6QMRS2oK/E=
Date:   Fri, 9 Sep 2022 20:23:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.0-rc5
Message-ID: <YxuEnRoUlZPzjfL6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 789bba82f63c3e81dce426ba457fc7905b30ac6e:

  firmware_loader: Fix memory leak in firmware upload (2022-09-01 17:47:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc5

for you to fetch changes up to 5ac251c8a05ce074e5efac779debf82a15d870a3:

  arch_topology: Make cluster topology span at least SMT CPUs (2022-09-07 17:57:31 +0200)

----------------------------------------------------------------
Driver core fixes for 6.0-rc5

Here are some small driver core and debugfs fixes for 6.0-rc5.

Included in here are:
  - multiple attempts to get the arch_topology code to work properly on
    non-cluster SMT systems.  First attempt caused build breakages in
    linux-next and 0-day, second try worked.
  - debugfs fixes for a long-suffering memory leak.  The pattern of
    debugfs_remove(debugfs_lookup(...)) turns out to leak dentries, so
    add debugfs_lookup_and_remove() to fix this problem.  Also fix up
    the scheduler debug code that highlighted this problem.  Fixes for
    other subsystems will be trickling in over the next few months for
    this same issue once the debugfs function is merged.

All of these have been in linux-next since Wednesday with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (4):
      Revert "arch_topology: Make cluster topology span at least SMT CPUs"
      driver core: fix driver_set_override() issue with empty strings
      debugfs: add debugfs_lookup_and_remove()
      sched/debug: fix dentry leak in update_sched_domain_debugfs

Yicong Yang (2):
      arch_topology: Make cluster topology span at least SMT CPUs
      arch_topology: Make cluster topology span at least SMT CPUs

 drivers/base/arch_topology.c |  2 +-
 drivers/base/driver.c        |  6 ++++++
 fs/debugfs/inode.c           | 22 ++++++++++++++++++++++
 include/linux/debugfs.h      |  6 ++++++
 kernel/sched/debug.c         |  2 +-
 5 files changed, 36 insertions(+), 2 deletions(-)
