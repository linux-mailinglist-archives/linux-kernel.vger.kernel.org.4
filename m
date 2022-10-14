Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281EE5FF389
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJNSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJNSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:20:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F232D93
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:20:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d14so2948983ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRrLIOmcMN6dxNUCyEtTWc83pVv8BngJLKL099x7jQ0=;
        b=CM1KudZ8ldL0cjM/0tzdsATxKwcOAqtoIJ+e5963ilVoRUTzCZe3X4olG0lO5gt6fn
         wLVdC2HMaXGL3DTX0vvPCWlzi5wRQqssXGSZ735mX/d9WkUxIJjoqoSZ9fF6vmRdBDGU
         JqUhIeNLn8+P7GOhD7AB5cu+CaThVVIQjV0J22mgJ3p4S75R0J+L8KRquTaxT9YeML21
         mi8KgTuAEJmIMb/3rr/Ms1+FQq+4/c3r+2L5aVLp4GRqDrOvC0/n4qgd6RMacBmFh9sO
         KDq+GwXx4VsH6kgyUMklo6VsVcP+HVATpazb9pkE2RTXvhY5yq7BnvUd9mcUU6f0YhSY
         pM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRrLIOmcMN6dxNUCyEtTWc83pVv8BngJLKL099x7jQ0=;
        b=yaEP8TvXnsTMCRs2eBY6si58R7/47h1t9rJqbvG9j8TXUtt1VWXORnRbP0TNOOb/de
         QGTcNkmKr3eMJkILtdWksAMmh6kw0EqYDfPl9bzLA5XWZ0s/z7qvJPrZ8DDj/HOE/0Lj
         9NRkCWxS1Xc24FOmlev0ac/ZsZRkcqaSFwwrSt5KaUmnpk4BZm7bjo65i/hIoRVe9csv
         aRaQhgBq4JOKe/6VKVlCaWzBN4l8n+ovxUL9Uu0/algInSBFNSP6DxkIWVZokicKEHUi
         TaGOEerTt+y1wJM5tcOnpaFvj5cJ070au1HaYofkmF1C0940LaEWJkOMziExtXRGMBUC
         j23w==
X-Gm-Message-State: ACrzQf2SlDcPf56mkpyBK3OTxbyqeGQrkCDAlGYlrrNrmg9Zhdefr7jk
        qtuNy+MXX4Bj17BxjC2PqdOl4KD4tfphWuDawluyNw==
X-Google-Smtp-Source: AMsMyM5eyMnjdOkPngOEqZ+qQ0ly+6FZRJmp2O649v4CBBVUThfGi+74rqhUc7jQkDntxbpAQ2fjjrqwFsDJ+DXTaag=
X-Received: by 2002:a05:6e02:930:b0:2f9:9d1b:2525 with SMTP id
 o16-20020a056e02093000b002f99d1b2525mr3000381ilt.173.1665771618748; Fri, 14
 Oct 2022 11:20:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Oct 2022 20:19:42 +0200
Message-ID: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
Subject: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
To:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
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

Hi!

I haven't actually managed to reproduce this behavior, so maybe I'm
just misunderstanding how this works; but I think the
arch_tlbbatch_flush() path for batched TLB flushing in vmscan ought to
have some kind of integration with mm_tlb_flush_nested().

I think that currently, the following race could happen:

[initial situation: page P is mapped into a page table of task B, but
the page is not referenced, the PTE's A/D bits are clear]
A: vmscan begins
A: vmscan looks at P and P's PTEs, and concludes that P is not currently in use
B: reads from P through the PTE, setting the Accessed bit and creating
a TLB entry
A: vmscan enters try_to_unmap_one()
A: try_to_unmap_one() calls should_defer_flush(), which returns true
A: try_to_unmap_one() removes the PTE and queues a TLB flush
(arch_tlbbatch_add_mm())
A: try_to_unmap_one() returns, try_to_unmap() returns to shrink_folio_list()
B: calls munmap() on the VMA that mapped P
B: no PTEs are removed, so no TLB flush happens
B: munmap() returns
[at this point, the TLB entry still exists]
B: calls mmap(), which reuses the same area that was just unmapped
B: tries to access the newly created VMA, but instead the access goes
through the stale TLB entry
A: shrink_folio_list() calls try_to_unmap_flush(), which removes the
stale TLB entry

The effect would be that after process B removes a mapping with
munmap() and creates a new mapping in its place, it would still see
data from the old mapping when trying to access the new mapping.

Am I missing something that protects against this scenario?

munmap() uses the mmu_gather infrastructure, which tries to protect
against this kind of correctness bug with multiple racing TLB
invalidations in tlb_finish_mmu() by blowing away the whole TLB
whenever one TLB invalidation ends while another is still in progress
(tested with mm_tlb_flush_nested(tlb->mm)). But mmu_gather doesn't
seem to be aware of TLB flushes that are batched up in the
arch_tlbbatch_flush() infrastructure, so that doesn't help here.

I think it might be necessary to add a new global counter of pending
arch_tlbbatch_flush() flushes, and query that in
mm_tlb_flush_nested(), or something like that.
