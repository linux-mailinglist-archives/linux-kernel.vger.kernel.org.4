Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF722600D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJQK51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJQK5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:57:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71AD60C80
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:57:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y80so8696347iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXioRsxEdylyd8PKjLiUmjGLWdwECa7TLeF3cqoPLco=;
        b=KG/CPftva3LXucgcQd42L3ubKKBNKbwwOoCE4gzSJAJJj6m9csXyfnGnLkH3p1Ur8t
         g0ydFQG/jMJO7LhOwQ7m2at4PjZ5FJd90bP2y8OxGjzh6uMnoDqM+JVMlltuoUXMsmkG
         BaKLSV1DFet7lA5qbBPp7f238U3Sb5Q8mNkDoNJ2wek0XSdZXYa2bF4Nw1uQAB5KRvAd
         zMFtxTeivNMQEdBewilefChP5scva0JSD1ArwrXp0sZZzVxFJfM8A/Ai/C7r8aC3SRAd
         IVe9AaBnm0oh2JyeEIpN9z4/9BDF7cl6KJ9Sxtl5VJHZ2CBGlHiKTwtgQHQfQ4jYLFcM
         5nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXioRsxEdylyd8PKjLiUmjGLWdwECa7TLeF3cqoPLco=;
        b=jS9Qy+7BcfunmuMxUHLnNsiPr+pWfJN0eiVCJeMcGCVaePuajPTno2LSNY6nZdotHl
         4mH/si/6IMVQUa8ZhjVvOmv3hzyejfvAAj8UcoYpuBBnw5m8PJYzvsOIMSCujCrwtBap
         zdSqAQxjQNUhHRqxw9+4sQ9V98hfbj3Usxy12iJ3ICAL7425idyV/7Wm03oNWttH+AC4
         Sr73gqFFtb8nMjDb7Klu5T+209+jTJI4EI7MDKueHeIuUBBHLWctRQ1QvAghASvtDnT8
         Rp7dcb/FWwDl0ubPn5o6Z25/Bo4YBiuG67hl/20MVdAu4fjNtNXr2uX+RKsl+OD2S4RU
         GWvw==
X-Gm-Message-State: ACrzQf1k4/A/gRElgf7ziOlciKWfb0cXIMfMNFi4q7lspP1G6YuPqQ+9
        TKOAbSq9u2L9bZOwu/HbFR4PQN7SaWHSvhgs0jkJJw==
X-Google-Smtp-Source: AMsMyM5sPFWMuvIRREb1+SNenWsT5lcRPbd65yIRNRKTIi4DH11ch2J56aK/g9uMDE51ypJIL538e0UYU9CCsiw6/pY=
X-Received: by 2002:a6b:5d08:0:b0:6bb:f915:4a33 with SMTP id
 r8-20020a6b5d08000000b006bbf9154a33mr3960780iob.2.1666004233811; Mon, 17 Oct
 2022 03:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
In-Reply-To: <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 17 Oct 2022 12:56:37 +0200
Message-ID: <CAG48ez3bPLVA2tqoYUT_mKp3u_yUg5QXx7AmxASrTE=jxnNWJg@mail.gmail.com>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
To:     Nadav Amit <nadav.amit@gmail.com>
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

On Sat, Oct 15, 2022 at 5:51 AM Nadav Amit <nadav.amit@gmail.com> wrote:
> On Oct 14, 2022, at 9:19 PM, Jann Horn <jannh@google.com> wrote:
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
>
> Unless I am missing something, flush_tlb_batched_pending() is would be
> called and do the flushing at this point, no?

Ooooh! Thanks, I missed that.
