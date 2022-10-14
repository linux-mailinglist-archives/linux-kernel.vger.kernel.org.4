Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484C5FF664
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:30:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502361408D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:30:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h203so5033276iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MQmRtQd4Y17eTEgOLxItVutgn0mL2LxkpMiy4WqkuT4=;
        b=Dox+MWLElhSlYcloiGdbaN0HaBpQV27gSS2NUSu6jtmMVfYGrj2fyDbGgg17sPi4rH
         lsUqZDhkqwwuZLVZlvOFNKoteJQFuuJjVWlFVCYfILVAUPEibUKcIumNIBsiga+wo/i2
         8W64ktmmI1DN+ZsfCezcNv4AjGqIJVt/0rphSKdE9PyBxv8w9WgW40+311sazjyRZDqT
         gE4g70Fjd1IKTAwFtIaOSfgaOJPg/k8awcCTcO6Yv7FRym6RvE8s5PNt3Dc+qnOAmpSj
         u7R/9j1cQwgPwtG2y3ncvu0AUgx8bZhqzenjQbJ3M6kOEAu8rjaDcTYkf2l8/vOHT5PR
         Ej5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQmRtQd4Y17eTEgOLxItVutgn0mL2LxkpMiy4WqkuT4=;
        b=ThdFllYfnNAHQ+pBsFRThImnt4V1LNfMbn+W2kxTiIi0eA9/hnZFywpvot+n20MTts
         npVeCWp9rDQc3D78+fanplY9r9/yn4GUlUFcOVtp3nJi6EOuveu0bbB+A/g5cehr891i
         DM0Q8TUbE6Gb5sR4I3mCiKIO0IVAbOM7lDBxQKP2/P4rSQpBDA0Cus2rMDCdoC2JlzKc
         u6h+o1jDblhkjMGmtyonlvei0c+qceNJ75zOgc/+M7fUc/KUmYWSDphwAt9d1T0dkllt
         QMZsCTqt6z4v1SF9z/PFp19ezBUu20iJ/kbZP4XwbKNpi3dn2znnzpaTZXHXVVsDoyyP
         EeVA==
X-Gm-Message-State: ACrzQf01/EM3gQw82XLVvBYRrtNtc4j3mJERjKNVIudNRY6w5zVxy5Re
        bouA9aJ4MBz9pfO+8hrS4CAl8cwPScbXkhKznoRKk6p0hpE=
X-Google-Smtp-Source: AMsMyM6XrBpWcHeAi4uT7qeU6tHY8D0h/loFjr0mJb/JFD8Gh1ekWMvbaIUtZ732UIqbBxbBUg8Jq+VVKE0EiMs4JOA=
X-Received: by 2002:a05:6638:3a15:b0:363:ecaf:2a53 with SMTP id
 cn21-20020a0566383a1500b00363ecaf2a53mr44236jab.66.1665786633385; Fri, 14 Oct
 2022 15:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <20221014222346.n337tvkbyr33dsdx@box.shutemov.name>
In-Reply-To: <20221014222346.n337tvkbyr33dsdx@box.shutemov.name>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 15 Oct 2022 00:29:57 +0200
Message-ID: <CAG48ez1B11EFyssTi=4izy04_FBOP1qdYVhEomYRdDBXb3jHkA@mail.gmail.com>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
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

On Sat, Oct 15, 2022 at 12:23 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Fri, Oct 14, 2022 at 08:19:42PM +0200, Jann Horn wrote:
> > Hi!
> >
> > I haven't actually managed to reproduce this behavior, so maybe I'm
> > just misunderstanding how this works; but I think the
> > arch_tlbbatch_flush() path for batched TLB flushing in vmscan ought to
> > have some kind of integration with mm_tlb_flush_nested().
> >
> > I think that currently, the following race could happen:
> >
> > [initial situation: page P is mapped into a page table of task B, but
> > the page is not referenced, the PTE's A/D bits are clear]
> > A: vmscan begins
> > A: vmscan looks at P and P's PTEs, and concludes that P is not currently in use
> > B: reads from P through the PTE, setting the Accessed bit and creating
> > a TLB entry
> > A: vmscan enters try_to_unmap_one()
> > A: try_to_unmap_one() calls should_defer_flush(), which returns true
> > A: try_to_unmap_one() removes the PTE and queues a TLB flush
> > (arch_tlbbatch_add_mm())
> > A: try_to_unmap_one() returns, try_to_unmap() returns to shrink_folio_list()
> > B: calls munmap() on the VMA that mapped P
> > B: no PTEs are removed, so no TLB flush happens
> > B: munmap() returns
>
> I think here we will serialize against anon_vma/i_mmap lock in
> __do_munmap() -> unmap_region() -> free_pgtables() that A also holds.
>
> So I believe munmap() is safe, but MADV_DONTNEED (and its flavours) is not.

shrink_folio_list() is not in a context that is operating on a
specific MM; it is operating on a list of pages that might be mapped
into different processes all over the system.

So A has temporarily held those locks somewhere inside
try_to_unmap_one(), but it will drop them before it reaches the point
where it issues the batched TLB flush.
And this batched TLB flush potentially covers multiple MMs at once; it
is not targeted towards a specific MM, but towards all of the CPUs on
which any of the touched MMs might be active.
