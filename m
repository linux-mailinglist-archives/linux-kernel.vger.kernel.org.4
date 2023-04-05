Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339186D7273
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjDEC1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjDEC1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:27:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7626AD;
        Tue,  4 Apr 2023 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=liwfgRAmKok6/KSZncO+fQ8xOc+1qIirOvQozJbmQE8=; b=4BmqmFWLry1SHUJ0Tq5b7pp92/
        feseonXDmF3CWCJJacVakhyupfia8MqOB/G11JJDU0m6r+ttpBtfyureiWgDEOZ5IlHPzOSqtn5Ic
        M3tUevN407qt5DsaER/bqP4Ys/NfkBMmn5FxJLa2COKVDrM9LxO38rNJEPArux++t3y9zb3vzKPYl
        kykHR0/z0lMkZDVbZrNjDgI6ReCPxSXLocqTyrhX43Uqdcy93IWtlwejhfyWRgoIv1ikwcCNaWtUI
        FBzRL9GvDH4XJ0L+dahhBVs778M0834muN7f/xPaOYV+1h8KJJe1MFKdz3C5xqfRvV6C1pVJA9o21
        CAJZ9pVA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjsrb-003A03-1M;
        Wed, 05 Apr 2023 02:27:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: [PATCH v2 0/6] module: avoid userspace pressure on unwanted allocations
Date:   Tue,  4 Apr 2023 19:26:56 -0700
Message-Id: <20230405022702.753323-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 series follows up on the first iteration of these patches [0].
They have the following changes made:

  o Rolled in fix for an kmemleak issue reported by Jim Cromie
  o Dropped from this series all the semaphore & and simplifications
    on kmod.c as that should just be sent as a separate bike-shedding
    opporunity patch series and it does not in any way address the
    the unwanted allocations.
  o The rest of the feedback was just from Greg KH and I've addressed
    all his feedback. I decided to do away with the debug.c as a
    separate file and leave the #ifdef CONFIG_MODULE_DEBUG eyesore
    at the end of main.c. I guess it's not so bad there.
  o *Tons* of fixes and enhancements to my counters, including tons
    of documentation to help ensure we don't loose track of some of
    the tribal knowledge and so to help ensure we have references to
    what our accounting looks like. Those large wasted virtual memory
    allocations on a simple qemu idle boring boot are simply rediculous, I
    am quite baffled we had not spotted this before, and so it all reveals
    we have quite a bit of optimizations left to do to make loading modules
    an even more smoother experience at bootup.

If you'd like a tree this is on my 20230404-module-alloc-opts branch based
on modules-next [1].

[0] https://lkml.kernel.org/r/20230329053149.3976378-1-mcgrof@kernel.org
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230404-module-alloc-opts

Luis Chamberlain (6):
  module: fix kmemleak annotations for non init ELF sections
  module: move finished_loading()
  module: extract patient module check into helper
  module: avoid allocation if module is already present and ready
  debugfs: add debugfs_create_atomic64_t for atomic64_t
  module: add debug stats to help identify memory pressure

 Documentation/core-api/kernel-api.rst |  22 +-
 fs/debugfs/file.c                     |  36 +++
 include/linux/debugfs.h               |   2 +
 kernel/module/Kconfig                 |  37 +++
 kernel/module/Makefile                |   1 +
 kernel/module/decompress.c            |   4 +
 kernel/module/internal.h              |  74 +++++
 kernel/module/main.c                  | 198 ++++++++----
 kernel/module/stats.c                 | 428 ++++++++++++++++++++++++++
 kernel/module/tracking.c              |   7 +-
 10 files changed, 742 insertions(+), 67 deletions(-)
 create mode 100644 kernel/module/stats.c

-- 
2.39.2

