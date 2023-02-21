Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355B169EAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBUXFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBUXFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:05:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298912D15F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:05:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ee7so8370995edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZsFQFRh/x8I2QvXO1hro2DfASw3W5KMKerDwbWes7o=;
        b=nLBqs6dC+0UjumcFzovK225a4YbB2GqCqM4Hv8JBWaP1lrGBIf+cM5wmMtsgDfaCcv
         yf1ASW4BUPoL0xsqB748c2AQwqjBHhGlIrGRR2HTuOGRj+GYaXwbq5zKdDgoX2P6DegF
         7FzDqIEYJsil23cC6ZxSrlPVLO/+pxGKdBP4MQI7t2QEEZzzaAg7XcpdRq3FgXWBFgQs
         43eK4mUMHJquims+pxvD7BatpnFAmQnJH4AvjQS2dfqx5Qup19zt66fCKa82Vo48iapZ
         TENLEDMMOQXW5zXoR1o9I6BpQcenQL6NmTdCgk3Pw8txZd5OdPkeiIo0LrLVy+wMHpV2
         qt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZsFQFRh/x8I2QvXO1hro2DfASw3W5KMKerDwbWes7o=;
        b=gzoahQ3D2YQeRyh1sm+INJvSN4KKDidgd2WBT6O2mZIoj42nkUhsrJ6fQftyyNPC5D
         UTwXkqbdIEHkaO8L5/CKAX2vo100+f46kLubPGjrZ77ZTSrKX2lieNgwinsT+5tqh/5a
         8Ex/y6rl5nZVXenuufR8bXtho49zXYFK8RtVSFWdIPWtGzKxp5EEc4m/jlubLthtvm6I
         vEH2Cy/tM0IJFIP3m2f1IqJUTeRpDofR40IavQcTK6mmnWRmWBX4zQlsWtybZkTnj0bK
         b1FMY+7HlvKcQkF0IbDsDvS8Vt5WAxNLwpkP+Ce2AQdIR20QmMAd3adSSDiBVOxE1QEK
         hglQ==
X-Gm-Message-State: AO0yUKVmXd1qpSduNV+3yeFrrWUitdr0LYETpNGBbQ43DeoOR62yUUrR
        A4cdmZcAG6jr1ILAeViWDdINHl1DpMojAxplaO0WbVQM
X-Google-Smtp-Source: AK7set9S5cz4XsNHDiExlazlYJ0+nIqb5Yc4bwqEzJQyzlOZbNoiQsEGATKyMu27idt3m+jehSDglX5vArow+uO7unc=
X-Received: by 2002:a50:9f2d:0:b0:4ad:4c0:c4f9 with SMTP id
 b42-20020a509f2d000000b004ad04c0c4f9mr2665649edf.3.1677020746463; Tue, 21 Feb
 2023 15:05:46 -0800 (PST)
MIME-Version: 1.0
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
In-Reply-To: <Y/U8bQd15aUO97vS@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Feb 2023 15:05:33 -0800
Message-ID: <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
Subject: Re: What size anonymous folios should we allocate?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> In a sense this question is premature, because we don't have any code
> in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
> but let's pretend that code already exists and is just waiting for us
> to answer this policy question.
>
> I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
> option and 3. a sysfs tunable.  It is foolish to expect the distro
> packager or the sysadmin to be able to make such a decision.  The
> correct decision will depend upon the instantaneous workload of the
> entire machine and we'll want different answers for different VMAs.

Yeah, I agree those 3 options should be avoided. For some
architectures, there are a or multiple sweet size(s) benefiting from
hardware. For example, ARM64 contiguous PTE supports up to 16
consecutive 4K pages to form a 64K entry in TLB instead of 16 4K
entries. Some implementations may support intermediate sizes (for
example, 8K, 16K and 32K, but this may make the hardware design
harder), but some may not. AMD's coalesce PTE supports a different
size (128K if I remember correctly). So the multiple of the size
supported by hardware (64K or 128K) seems like the common ground from
maximizing hardware benefit point of view. Of course, nothing prevents
the kernel from allocating other orders.

ARM even supports contiguous PMD, but that would be too big to
allocate by buddy allocator.

>
> I'm open to applications having some kind of madvise() call they can
> use to specify hints, but I would prefer to handle memory efficiently
> for applications which do not.
>
> For pagecache memory, we use the per-fd readahead code; if readahead has
> been successful in the past we bump up the folio size until it reaches
> its maximum.  There is no equivalent for anonymous memory.

Yes, kernel can't tell it although the userspace may experience fewer
TLB misses. Anyway it is not an indicator that could be used by kernel
to make a decision.

>
> I'm working my way towards a solution that looks a little like this:
>
> A. We modify khugepaged to quadruple the folio size each time it scans.
>    At the moment, it always attempts to promote straight from order 0
>    to PMD size.  Instead, if it finds four adjacent order-0 folios,
>    it will allocate an order-2 folio to replace them.  Next time it
>    scans, it finds four order-2 folios and replaces them with a single
>    order-4 folio.  And so on, up to PMD order.

Actually I was thinking about the reverse, starting from the biggest
possible order, for example, 2M -> 1M -> ... 64K -> ... 4K. And the
page fault path should be able to use the same fallback order. But
excessive fallback tries may be harmful either.

>
> B. A further modification is that it will require three of the four
>    folios being combined to be on the active list.  If two (or more)
>    of the four folios are inactive, we should leave them alone; either
>    they will remain inactive and eventually be evicted, or they will be
>    activated and eligible for merging in a future pass of khugepaged.

If we use the fallback policy, we should be able to just leave it to
reclamation time. When checking reference we could tell what PTEs are
accessed, then split if there is significant internal fragmentation.

>
> C. We add a new wrinkle to the LRU handling code.  When our scan of the
>    active list examines a folio, we look to see how many of the PTEs
>    mapping the folio have been accessed.  If it is fewer than half, and
>    those half are all in either the first or last half of the folio, we
>    split it.  The active half stays on the active list and the inactive
>    half is moved to the inactive list.

With contiguous PTE, every PTE still maintains its own access bit (but
it is implementation defined, some implementations may just set access
bit once for one PTE in the contiguous region per arm arm IIUC). But
anyway this is definitely feasible.

>
> I feel that these three changes should allow us to iterate towards a
> solution for any given VMA that is close to optimal, and adapts to a
> changing workload with no intervention from a sysadmin, or even hint
> from a program.

Yes, I agree.

>
> There are three different circumstances where we currently allocate
> anonymous memory.  The first is for mmap(MAP_ANONYMOUS), the second is
> COW on a file-backed MAP_PRIVATE and the third is COW of a post-fork
> anonymous mapping.
>
> For the first option, the only hint we have is the size of the VMA.
> I'm tempted to suggest our initial guess at the right size folio to
> allocate should be scaled to that, although I don't have a clear idea
> about what the scale factor should be.
>
> For the second case, I want to strongly suggest that the size of the
> folio allocated by the page cache should be of no concern.  It is largely
> irrelevant to the application's usage pattern what size the page cache
> has chosen to cache the file.  I might start out very conservatively
> here with an order-0 allocation.
>
> For the third case, in contrast, the parent had already established
> an appropriate size folio to use for this VMA before calling fork().
> Whether it is the parent or the child causing the COW, it should probably
> inherit that choice and we should default to the same size folio that
> was already found.

Actually this is not what THP does now. The current THP behavior is to
split the PMD then fallback to order-0 page fault. For smaller orders,
we may consider allocating a large folio.

>
>
> I don't stay current with the research literature, so if someone wants
> to point me to a well-studied algorithm and let me know that I can stop
> thinking about this, that'd be great.  And if anyone wants to start
> working on implementing this, that'd also be great.
>
> P.S. I didn't want to interrupt the flow of the above description to
> note that allocation of any high-order folio can and will fail, so
> there will definitely be fallback points to order-0 folios, which will
> be no different from today.  Except that maybe we'll be able to iterate
> towards the correct folio size in the new khugepaged.
>
> P.P.S. I still consider myself a bit of a novice in the handling of
> anonymous memory, so don't be shy to let me know what I got wrong.
>
