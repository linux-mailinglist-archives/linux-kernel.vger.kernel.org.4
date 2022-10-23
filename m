Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32386095A4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJWSga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJWSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:36:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5834C74B85
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:36:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y67so8893560oiy.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFwZa2BSHLpJ/lHsM1/KFIQbs54rf/ACzYwP1+4ugaw=;
        b=ITvi3rBPRo+s4zvDf4M4WyGOffaL0RJJNGqOZQuErWkjAEPNfnRmZ4B3ffcQdmzvMp
         WMf6Xbdnhk06ww0KbNPn18ZNGaQKwWK7VGEfphxAytN6Uiiy83nDtpGOHdzkA6UAtpg/
         807/T6zRKYGlv2Lw3Vx2FQfKIAMWBz1+NxzXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFwZa2BSHLpJ/lHsM1/KFIQbs54rf/ACzYwP1+4ugaw=;
        b=tFKOlvst2Ez4/Vqi8+a+QlHF/S4JU3CMDdSr1n/ljtfKG9xO6aAZIKbfXzCbeHvdHH
         b8nY92jg2fkra06FG4GtgHy7nXen2hF6h7/O+y+Ofv/SnQKMkqOI/z1Pdz6DAPp+uyPf
         tsvBeaUU0gV+nPQr8BrtD/I8MLw0SzbFGd5FMfMAkjmhYgz07CcPnj1lpK8+Zys062tJ
         e9VU0iLmJRXPr2OSbecVkPBj8pAFfBOcHldCjdlO+E3DrziM/hkEZtu+CKGQnGJBRnlZ
         UldKBwz3z+4qSWyDpRCFTBNB21kO3MsuEMELFKdEhaaZ38lUyJp5R/8d0dysmgiTiPRL
         kzxw==
X-Gm-Message-State: ACrzQf2yzr8hFQaS/XW8DydmpxblzVTA2b+chJtPx+YBBjZO6CmqCZcX
        9R5rmj0SxwMGt5qYiCcQSUFMr8FnsbHYvQ==
X-Google-Smtp-Source: AMsMyM6WEX0/Kyd/tdRxqfl5aLVJAOI7y2075qz8aDYA6nfQxXyor/oqlK3kyP5B5ODYEdOLBp4eCQ==
X-Received: by 2002:a05:6808:3097:b0:355:347e:2df6 with SMTP id bl23-20020a056808309700b00355347e2df6mr19200999oib.44.1666550183972;
        Sun, 23 Oct 2022 11:36:23 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id g186-20020aca39c3000000b0035493cbd9absm3315780oia.21.2022.10.23.11.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 11:36:22 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id r11-20020a4aa2cb000000b004806f49e27eso1145443ool.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 11:36:21 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr7845582ywr.58.1666550170598; Sun, 23 Oct
 2022 11:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net> <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org> <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
 <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 11:35:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
Message-ID: <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Sun, Oct 23, 2022 at 10:55 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  Given the presence of generic atomics we can emulate CMPXCHG8B easily
> LL/SC-style using a spinlock with XCHG even on SMP let alone UP.

We already do that (admittedly badly - it's not SMP safe, but
486-class SMP machines have never been supported even if they
technically did exist), see

  arch/x86/lib/cmpxchg8b_emu.S
  arch/x86/lib/atomic64_386_32.S

for some pretty disgusting code.

But it's all the other infrastructure to support this that is just an
unnecessary weight. Grep for CONFIG_X86_CMPXCHG64 and X86_FEATURE_CX8.

We already have increasingly bad coverage testing for x86-32 - and
your example of MIPS really doesn't strengthen your argument all that
much, because MIPS has never been very widely used in the first place,
and doesn't affect any mainline development.

The odd features and CPU selection really do not help.

Honestly, I wouldn't mind upgrading the minimum requirements to at
least M586TSC - leaving some of those early "fake Pentium" clones
behind too. Because 'rdtsc' is probably an even worse issue than
CMPXCHG8B.

In fact, I don't understand how current kernels work on an i486 at
all, since it looks like

  exit_to_user_mode_prepare ->
    arch_exit_to_user_mode_prepare

ends up having an unconditional 'rdtsc' instruction in it.

I'm guessing that you don't have RANDOMIZE_KSTACK_OFFSET enabled?

In other words, our non-Pentium support is ACTIVELY BUGGY AND BROKEN right now.

This is not some theoretical issue, but very much a "look, ma, this
has never been tested, and cannot actually work" issue, that nobody
has ever noticed because nobody really cares.

It took me a couple of minutes of "let's go hunting" to find that
thing, and it's just an example of how broken our current support is.
That RANDOMIZE_KSTACK_OFFSET code *compiles* just fine. It just
doesn't actually work.

That's the kind of maintenance burden we simply shouldn't have - no
developer actually cares (correctly), nobody really tests that
situation (also correctly - it's old and irrelevant hardware), but it
also means that code just randomly doesn't actually work.

                      Linus
