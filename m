Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F6713367
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjE0Iby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjE0Ibv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19C09F
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309C061D72
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16335C433EF;
        Sat, 27 May 2023 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685176308;
        bh=i3pTFDrPzwsrnLSzL0pZKhYseZGcNadKttXv3FyvibI=;
        h=Date:From:To:Cc:Subject:From;
        b=kdlteGeZWaIk8Fv2RmzUK2NasqKsxn8jOpg8aMeZJng9gvzuHFmbVEYc0Ou5m7fQv
         qhs1T6EN5HDV5roXn90x8wS3jFcMF/SnDNlUmtuUIdgao16O+zWDTZJP9rTtzkRBmM
         KdgBd5tZ3RMZSz91avss4+xOcdRLVm9+tJheIqHE=
Date:   Sat, 27 May 2023 09:31:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.4-rc4
Message-ID: <ZHG_8UO7R3mzhI4q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.4-rc4

for you to fetch changes up to d1d8875c8c13517f6fd1ff8d4d3e1ac366a17e07:

  binder: fix UAF of alloc->vma in race with munmap() (2023-05-20 17:56:23 +0100)

----------------------------------------------------------------
Char/Misc fixes for 6.4-rc4

Here are some small driver fixes for 6.4-rc4.  They are just two
different types:
  - binder fixes and reverts for reported problems and regressions in
    the binder "driver".
  - coresight driver fixes for reported problems.

All of these have been in linux-next for over a week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Carlos Llamas (5):
      binder: fix UAF caused by faulty buffer cleanup
      Revert "binder_alloc: add missing mmap_lock calls when using the VMA"
      Revert "android: binder: stop saving a pointer to the VMA"
      binder: add lockless binder_alloc_(set|get)_vma()
      binder: fix UAF of alloc->vma in race with munmap()

Dan Carpenter (1):
      coresight: Fix signedness bug in tmc_etr_buf_insert_barrier_packet()

Greg Kroah-Hartman (1):
      Merge tag 'coresight-fixes-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-linus

Ruidong Tian (1):
      coresight: perf: Release Coresight path when alloc trace id failed

 drivers/android/binder.c                         | 28 ++++++++---
 drivers/android/binder_alloc.c                   | 64 +++++++++++-------------
 drivers/android/binder_alloc.h                   |  4 +-
 drivers/android/binder_alloc_selftest.c          |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c  |  2 +-
 6 files changed, 55 insertions(+), 46 deletions(-)
