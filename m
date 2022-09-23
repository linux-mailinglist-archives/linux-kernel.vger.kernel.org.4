Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21E15E7E94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiIWPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiIWPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:38:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A114597D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:38:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y15so349372ilq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=IYqbNU1fZX4rzoxApDKFFKDnto7gL2nxgV8bIfOeFQo=;
        b=QgYgZ0SczN90S2LmGDoPyEcaSNhP800LDUhQmpMlD17ZLSVfdR/JKYP7ape2858og5
         BAh2C9isGH3RrUg6KckDzrm//AEYKZmRt3TqC2fidYCHaLUZO8jKYxh1rNbqacfFY1OZ
         ACkiBWfHHS/Rtg3tDNCLTMx01tk8+YJGwlWvdJ/R+SxzBGjOHIsKvGtiJ7r36aA8FxO7
         pWuXWUF3M2NtVqvOa5CWo3cO62pR4I92WbG4qnCklqGnL3d4QKKDm8HozZ/65W7zRRNv
         /4ws2MSB97r0rowNsVC34hrocLEqAxrnW/oHgVorGvjEa+JDc9e15SK++CbNu43R5Nm9
         ivRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=IYqbNU1fZX4rzoxApDKFFKDnto7gL2nxgV8bIfOeFQo=;
        b=DBB3HYr65iY8BgqkFx5jeCep/VNzIQkhVTK3cKFuMHBY1RcvvqdLCbDd9mSV2+WRN7
         WcPMeHMVLj1ywObN8a5cVDyx31Mjjtd4/9sUY9h+9NGg66TJlTePg8hNTRV8mLzojOJY
         +vcUG0Z6Ef8nO+vG9JBVpJyZVcbbiGYzIkkR88YD1LmxLCa8o9fie5XOQh4CRj3/TFBP
         005ALRnc0v63JPohqNgzLTzoyiCzufwmjHkmG06PqPa6/FR6wIaMHn5y//bNjpqsTRBa
         /NyY4svvCvnPlwWJUKosDr4qX4jIsIQnQtk2D12URVtA0qVyedoeqblEz7jeN/XdfUYw
         H1Iw==
X-Gm-Message-State: ACrzQf3JyUwvCD1/ZAf6RJcEECQ2tXKLW2w0br1lJcd38Y19cuBl+UPu
        nKfMHuY3JC3j4xgMP1+7i3llV50Rob6L613S1Lgpyw==
X-Google-Smtp-Source: AMsMyM4d/ic+EXhHlBsvB8fRatAdRHMpVHFKIEza947IkC134wotND2PFgIDPa+RKBjN0RImpPujGXCyVsPVVP4B8qg=
X-Received: by 2002:a05:6e02:1e06:b0:2f6:2666:e8ca with SMTP id
 g6-20020a056e021e0600b002f62666e8camr4229393ila.173.1663947528664; Fri, 23
 Sep 2022 08:38:48 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 23 Sep 2022 17:38:12 +0200
Message-ID: <CAG48ez2NQKVbv=yG_fq_jtZjf8Q=+Wy54FxcFrK_OujFg5BwSQ@mail.gmail.com>
Subject: some likely bugs in IOMMUv2 (in tlb_finish_mmu() nested flush and mremap())
To:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>, jean-philippe.brucker@arm.com
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I looked through some of the code related to IOMMUv2 (the thing where
the IOMMU walks the normal userspace page tables and TLB shootdowns
are replicated to the IOMMU through
mmu_notifier_ops::invalidate_range).

I think there's a bug in the interaction between tlb_finish_mmu() and
mmu_notifier_ops::invalidate_range: In the mm_tlb_flush_nested() case,
__tlb_reset_range() sets tlb->start and tlb->end *both* to ~0.
Afterwards, tlb_finish_mmu() calls
tlb_flush_mmu()->tlb_flush_mmu_tlbonly()->mmu_notifier_invalidate_range(),
which will pass those tlb->start and tlb->end values to
mmu_notifier_ops::invalidate_range callbacks. But those callbacks
don't know about this special case and then basically only flush
virtual address ~0, making the flush useless. (However, pretty much
every place that calls tlb_finish_mmu() first calls
mmu_notifier_invalidate_range_end() even though the appropriate thing
would probably be mmu_notifier_invalidate_range_only_end(); and I
think those two things probably cancel each other out?)

Also, from what I can tell, the mremap() code, in move_page_tables(),
only invokes mmu_notifier_ops::invalidate_range via the
mmu_notifier_invalidate_range_end() at the very end, long after TLB
flushes must have happened - sort of like the bug we had years ago
where mremap() was flushing the normal TLBs too late
(https://bugs.chromium.org/p/project-zero/issues/detail?id=1695).
