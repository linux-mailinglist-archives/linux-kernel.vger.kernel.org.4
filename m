Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048A0608CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJVLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJVLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5AC24FED2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n6LTTtrs2VOiP4go+HBPByerRRMgGVp88WeQbYfK2Q4=; b=HbtSiyIUOHWi6apk9vXdYVVWmK
        vmr+WGoRtpgnM82kFqQH7FHC3hu2E4FTE9p30Ciog6g8OsFTn0Wfwavl07bKJzhrNahPQSjAF+WBl
        w+1WR/zuZSPeDIeoGXD8fIJbNtGSiIjhrnKOhssKmovQKhVyKpGjxgl5KI3maVInzvEuJ03uE43Wc
        zEJXxiCNtIWxLmk2kRXt1ByH1wI3AiGGpY8fBeVQn4HFUObefQ8oJzn0RRBoyW+Vcs6/qbLit0faa
        XuOoyj7fVt7DRerw0vuWCxN6IvmqwMRSdEcXtEfdy40jxw9aB9mqYpZH9ID+Zi5qKwt3ZvsmVzCFO
        AY2i3+JQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzL-005XdC-Fs; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34C84300474;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1862128B8E50C; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022111403.531902164@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 00/13] Clean up pmd_get_atomic() and i386-PAE
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At long *long* last a respin of the patches that clean up pmd_get_atomic() and
i386-PAE. I'd nearly forgotten why I did this, but the old posting gave clue
that patch #7 was the whole purpose of me doing these patches.

Having carried these patches for at least 2 years, they recently hit a rebase
bump against the mg-lru patches, which is what prompted this repost.

Linus' comment about try_cmpxchg64() (and Uros before him) made me redo those
patches (see patch #10) which resulted in pxx_xchg64(). This in turn led to
killing off set_64bit().

The robot doesn't hate on these patches and they boot in kvm (because who still
has i386 hardware).

Patches also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/mm.pae

---
 arch/mips/Kconfig                           |   2 +-
 arch/sh/Kconfig                             |   2 +-
 arch/sh/include/asm/pgtable-3level.h        |  10 +-
 arch/um/include/asm/pgtable-3level.h        |   8 --
 arch/x86/Kconfig                            |   2 +-
 arch/x86/include/asm/cmpxchg_32.h           |  28 -----
 arch/x86/include/asm/cmpxchg_64.h           |   5 -
 arch/x86/include/asm/pgtable-3level.h       | 171 ++++++----------------------
 arch/x86/include/asm/pgtable-3level_types.h |   7 ++
 arch/x86/include/asm/pgtable_64_types.h     |   1 +
 arch/x86/include/asm/pgtable_types.h        |   4 +-
 drivers/iommu/intel/irq_remapping.c         |  10 +-
 include/linux/pgtable.h                     |  71 +++++++-----
 kernel/events/core.c                        |   2 +-
 mm/Kconfig                                  |   2 +-
 mm/gup.c                                    |   2 +-
 mm/hmm.c                                    |   3 +-
 mm/khugepaged.c                             |   2 +-
 mm/mapping_dirty_helpers.c                  |   2 +-
 mm/mprotect.c                               |   2 +-
 mm/userfaultfd.c                            |   2 +-
 mm/vmscan.c                                 |   5 +-
 22 files changed, 110 insertions(+), 233 deletions(-)

