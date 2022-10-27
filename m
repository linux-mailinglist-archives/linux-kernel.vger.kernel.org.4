Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816360F0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiJ0HI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiJ0HIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:08:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12815200F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2PK2CcB6XE27IhF1KIVx3VDxBzlt6BtNKHFrbWiKaXU=; b=Q3vJ0Ym6DiUw65O0d6LOwaKcZs
        isOPaNOc1ZoZuICDKd0z9TdyXZ/tx+pscIx/xmw6UznSin07bfxqPDtD/V7LzdEzM0v/U8YlkkAEm
        PPlCwpACwIXUuDXo8JYYcGq8alNOYGZ0VHyi4HQATPDqaYbPmo9dEcKZCqW+gv56N4Zg0hcGB5sZb
        08N9Iz9a2HV0yFlr64TKeouvrMZ0wu7ZfZ7Nd1fklGTSJ+qH8zrZX+HKh6X/tHvrelVzcM1PsAigL
        scYiEUrd4g5jNSXF9B5CWaae22d0JwPX1nqHBSyPlQVd6AOF80CiCjwMh62onLC8klYLLcp+64O11
        mFVUejxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onx0C-006nOn-14; Thu, 27 Oct 2022 07:08:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BEB4300411;
        Thu, 27 Oct 2022 09:08:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34D392012BEF9; Thu, 27 Oct 2022 09:08:31 +0200 (CEST)
Date:   Thu, 27 Oct 2022 09:08:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 06:45:16PM +0200, Jann Horn wrote:

> >  #endif /* _LINUX_MM_H */
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f88c351aecd4..9bb63b3fbee1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1440,6 +1440,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                         tlb_remove_tlb_entry(tlb, pte, addr);
> >                         zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> >                                                       ptent);
> > +
> > +                       if (!force_flush && !tlb->fullmm && details &&
> > +                           details->zap_flags & ZAP_FLAG_FORCE_FLUSH)
> > +                               force_flush = 1;
> > +
> 
> Hmm... I guess that might work, assuming that there is no other
> codepath we might race with that first turns the present PTE into a
> non-present PTE but keeps the flush queued for later. At least
> codepaths that use the tlb_batched infrastructure are unproblematic...

So I thought the general rule was that if you modify a PTE and have not
unmapped things -- IOW, there's actual concurrency possible on the
thing, then the TLB invalidate needs to happen under pte_lock, since
that is what controls concurrency at the pte level.

As it stands MADV_DONTNEED seems to blatatly violate that general rule.

Then again; I could've missed something and the rules changed?
