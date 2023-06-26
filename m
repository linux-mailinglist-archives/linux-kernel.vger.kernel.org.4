Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319F973DFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFZM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFZM5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:57:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C2A0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GxYPusAHHmA57+FfzyNNkDuavK6OclY5W645TKe3VLE=; b=lbdKzqqMVEueG40pBLztLfTT8R
        ZcwUDBqDGaQWkNxnawFEYKve9MGWuxcNyq+SrEblm6lPp7aRhkhvHxpyyu4LNa/reKcOUwz3A8sMt
        NWQJe8dobHLHxq78nTHPpncYYJBq16bm3KVK/RCp8u7FAf09TQBIk78DyCLe3J+IOLHLDnj+GOXm6
        Y1Ok3g7LKA7+zcqMoLmRLXMvChtqzqW1u++gQ43occneutLnnthLqEib6xgyXmSon9Si9BjRp3CBY
        1qhJKNf63witmolLtlD6s3eV59yXEq7BoY0oTf/qpsrXTzzM8p+NyRgvmvpabJcpR2gAiiK8p/DJ1
        Qu5tatHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qDlma-003zRs-00;
        Mon, 26 Jun 2023 12:57:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A380A300561;
        Mon, 26 Jun 2023 14:57:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8010420BC62B5; Mon, 26 Jun 2023 14:57:26 +0200 (CEST)
Date:   Mon, 26 Jun 2023 14:57:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: [GIT PULL] Scope-based Resource Management for 6.5
Message-ID: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the SBRM infrastructure so that people can start
building upon it. Specifically Greg also wants to start using this soon.

Once this lands, I'll start to trickle in the conversions I've done for
the next release.

Thanks!

---

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git tags/core_guards_for_6.5_rc1

for you to fetch changes up to b5ec6fd286dfa466f64cb0e56ed768092d0342ae:

  kbuild: Drop -Wdeclaration-after-statement (2023-06-26 11:14:19 +0200)

----------------------------------------------------------------
Scope-based Resource Management infrastructure

These are the first few patches in the Scope-based Resource Management
series that introduce the infrastructure but not any conversions as of
yet.

Adding the infrastructure now allows multiple people to start using them.

Of note is that Sparse will need some work since it doesn't yet
understand this attribute and might have decl-after-stmt issues -- but I
think that's being worked on.

----------------------------------------------------------------
Peter Zijlstra (4):
      dmaengine: ioat: Free up __cleanup() name
      apparmor: Free up __cleanup() name
      locking: Introduce __cleanup() based infrastructure
      kbuild: Drop -Wdeclaration-after-statement

 Makefile                            |   6 +-
 arch/arm64/kernel/vdso32/Makefile   |   2 -
 drivers/dma/ioat/dma.c              |  12 +--
 include/linux/cleanup.h             | 171 ++++++++++++++++++++++++++++++++++++
 include/linux/compiler-clang.h      |   9 ++
 include/linux/compiler_attributes.h |   6 ++
 include/linux/device.h              |   7 ++
 include/linux/file.h                |   6 ++
 include/linux/irqflags.h            |   7 ++
 include/linux/mutex.h               |   4 +
 include/linux/percpu.h              |   4 +
 include/linux/preempt.h             |   5 ++
 include/linux/rcupdate.h            |   3 +
 include/linux/rwsem.h               |   8 ++
 include/linux/sched/task.h          |   2 +
 include/linux/slab.h                |   3 +
 include/linux/spinlock.h            |  31 +++++++
 include/linux/srcu.h                |   5 ++
 scripts/checkpatch.pl               |   2 +-
 security/apparmor/include/lib.h     |   6 +-
 20 files changed, 282 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/cleanup.h
