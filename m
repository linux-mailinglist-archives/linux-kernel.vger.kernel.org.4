Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E05E7DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiIWPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiIWPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E195135725
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A21761762
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCEFC433D6;
        Fri, 23 Sep 2022 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663945935;
        bh=8HQqkjCT/CBLdxTGClWGWuYiNggCIhcx9ODEVPDpiQw=;
        h=Date:From:To:Cc:Subject:From;
        b=ry/dzY9AVEH/AgGYDuNIzSxJNnh8tpSLzOkznUOG9AtCraDtsQSt+wR8uLd0uyTWY
         irdEhSukRmpiP7KB3a5y8p1j0+E5LWb8djFYimbUh+27NQlmgzr/TprWeKLxC6hKtU
         2LPF7ozfSVvk4ukRisAIR+3zjIAPMIP0fsS7ywqM=
Date:   Fri, 23 Sep 2022 17:12:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.0-rc7
Message-ID: <Yy3MxlD/kXT2SreI@kroah.com>
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

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc7

for you to fetch changes up to d7f06bdd6ee87fbefa05af5f57361d85e7715b11:

  drivers/base: Fix unsigned comparison to -1 in CPUMAP_FILE_MAX_BYTES (2022-09-22 13:13:12 +0200)

----------------------------------------------------------------
Driver core fixes for 6.0-rc7

Here are two tiny driver core fixes for 6.0-rc7 that resolve some
oft-reported problems.

The first is a revert of the "fw_devlink.strict=1" default option that
we keep trying to enable, but we keep finding platforms that this just
breaks everything on.  So again, we need it reverted and hopefully it
can be worked on in future releases.

The second is a sysfs file-size bugfix that resolves an issue that many
people are starting to hit as the fix it is fixing also was backported
to stable kernels.  The util-linux developers are starting to get
bugreports about sysfs files that contain no data because of this
problem, and this fix which has been in linux-next in the bitfield tree
for a long time, resolves it.  I'm submitting it here as it needs to be
merged for 6.0-final, not for 6.1-rc1.

Both of these have been in linux-next with no reported issues, only
reports were that these fixed problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "driver core: Set fw_devlink.strict=1 by default"

Phil Auld (1):
      drivers/base: Fix unsigned comparison to -1 in CPUMAP_FILE_MAX_BYTES

 drivers/base/core.c     | 2 +-
 include/linux/cpumask.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
