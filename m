Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6863762C685
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiKPRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiKPRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:40:09 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EAE59866
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:40:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id v8so12112458qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eyCPyeJMcrVYxUOOMaoDJ2LNfvpxquoWrFx7efPrDZ8=;
        b=N7b62XhQzExJQ19iSSJdV9S1Sl+OMEc7fdQOBKMVt/0KOmv6HJZXkiOqukaKHgr+US
         EL6H/4lI7B/ZV3U+OkaunNG7bK/1YX2WVP1ep35JambbT2mPJC+54u5N6F5V7inevpSI
         /jtHd/t83esoNYpfH/yuF1F8IkFliNzivdUWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyCPyeJMcrVYxUOOMaoDJ2LNfvpxquoWrFx7efPrDZ8=;
        b=rl5R5djwZrScXrA9HEXz1SBbPBfFJFh72sKmrE9Aipg9dovkK1/4cg4MY0vMcRbOkZ
         y1V0uE/XOzIfuxlGIOfCO3hxBh2PzepOw0MMlQKiu+sB/hYXScOcWU0YwZImajoQLqOZ
         QO1LD2Y42O8LNG/irm0kggUYR72XDc3m2kPBxydjGtP/cacnHqxVQD8nrMMahPZ3vrlc
         j6BobRE6nOij1qb3XBEfUB1ZvMbXNzBvJ+8Dr0CDstV2Tk+3zd0EGFM4Misw70p6l+oN
         u5fmzbzglb9iUsXCmcyzIdyyOXHKWq3Aw99qHo1sFXqve/lXxziWJK6454xzQMcHUaLT
         m3Tw==
X-Gm-Message-State: ANoB5pmQA1Su1CAKKkEPSwUAr9RQEk4P7GT0KlswefCCFAqeeVFDh6+N
        UKzb+ikwlC5DXUlBb9ZTa0Xvo+XPHjlDzQ==
X-Google-Smtp-Source: AA0mqf4Z6pFoRoUSPZCDe5y9EkXymjwQFNgXyLDPMLGReHlUfQaGiyuI3Bh5Wr225gAOCeN4Ydag1A==
X-Received: by 2002:a05:620a:e0c:b0:6ee:6845:ced with SMTP id y12-20020a05620a0e0c00b006ee68450cedmr19976653qkm.530.1668620407442;
        Wed, 16 Nov 2022 09:40:07 -0800 (PST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id q45-20020a05620a2a6d00b006ee7923c187sm10642282qkp.42.2022.11.16.09.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:40:06 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id j6so12351563qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:40:06 -0800 (PST)
X-Received: by 2002:ad4:4347:0:b0:4bb:a80f:3f43 with SMTP id
 q7-20020ad44347000000b004bba80f3f43mr21868972qvs.43.1668620405914; Wed, 16
 Nov 2022 09:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org> <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
 <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com> <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Nov 2022 09:39:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRu33083QOSES=MUO-SBfLHjV2Zwq7OxorL+wXwHNw6Q@mail.gmail.com>
Message-ID: <CAHk-=wgRu33083QOSES=MUO-SBfLHjV2Zwq7OxorL+wXwHNw6Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has
 been flushed
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:48 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> Which actually brings a question whether CONFIG_MMU_GATHER_NO_GATHER
> mode could be beneficial for UP?

No, the NO_GATHER case wouldn't work for UP in general, because once
we drop the page table lock, even on UP we end up possibly
re-scheduling due to preemption (and even without actual kernel
preemption, we have that explicit "cond_resched()" there).

And if we schedule to another thread that shares the same VM, that
other thread will continue to use the existing TLB entries.

And if those TLB entries then point to pages that were already free'd...

So the NO_GATHER case requires that you flush the TLB early even on
UP, although the requirements are a _bit_ less strict than on SMP.

And TLB flushes are not necessarily cheap, even on UP.

Now, we could possibly optimize this to the point where it *would* be
quite possible - instead of actually flushing the TLB, just set the
bit to "flush on next thread switch". So I think the UP case *could*
be made to be non-gathering.

But I don't think anybody cares about - or tests - UP enough for it to
make sense to worry about it.

           Linus
