Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1093607CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJUQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiJUQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:50:37 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2227356C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:50:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n130so3856675oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4hKno/aL4Bg3771FP97RAk5vH0GViKpS0EoTFQiXAc=;
        b=QLOUBa61SZHZELYuNpmzZwTNuHX9WWmk2yK/KTPOBV/MohvWeTpdvKV+If+Gt00dLR
         HDpP7VpVW3lZbNB5dJ1RnNqyztGfGm1VPhetkX0w9W5qnsLXrfzEi66whylia5hRH4q3
         y/EzFsN0ohUolFYNwuS9CZuiefP2XPX9gNCzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4hKno/aL4Bg3771FP97RAk5vH0GViKpS0EoTFQiXAc=;
        b=RwkgUe2n0HsTpnKNVyR8dy9OHAILu1+6nRde67BHdOrQ6poo9u2Zsds2Cz48q4Vodf
         P84TMj6syJQ3jv48EC7YnCnTxr87logSi3bPU2MmN675azS4qAzC+PWs/2A/c5QWJIyn
         bHLXCdkZ++xGmn6GiVvCC4okWuJsyvLg+/x+ulfu0CYunMAgL1glArvKiVP+LJAL8ut0
         1gnZ0SnH6XPjAoMrtdfSvpouJOdw0grXcpVvSIQRWfW1prjp86m0GasRK/Yu0Lk9xjYO
         H4nECfyqLgpD01y39Ep6u/LWytZMGjjT91ucIFxQECrDPUEEWFJ8kL0MnuysljnlAaG7
         pRfw==
X-Gm-Message-State: ACrzQf2AJj4OghjS3RqsgvFnO8J+ND6wFrOChlOYuK5rnBHQjOR8LaCg
        LslmybrYkSzdF3qnWplMq8RXE0E1+FzxBA==
X-Google-Smtp-Source: AMsMyM5SudCtZEjb1KR5e8d+M8AwQQBGVgeULP6KueDyWiEmhViL9biVe45QZUMfvdYdZlrHAQZyAg==
X-Received: by 2002:aca:1a0a:0:b0:354:b28b:4079 with SMTP id a10-20020aca1a0a000000b00354b28b4079mr10922599oia.101.1666371031281;
        Fri, 21 Oct 2022 09:50:31 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id v5-20020a9d5a05000000b006619fe836f9sm1286704oth.55.2022.10.21.09.50.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 09:50:30 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id z11-20020a05683020cb00b00661a95cf920so2160747otq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:50:29 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:361:52e4:dec8 with SMTP id
 u130-20020a816088000000b0036152e4dec8mr17473482ywb.352.1666371017990; Fri, 21
 Oct 2022 09:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net> <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org>
In-Reply-To: <Y1IUMDJFScAMrCS5@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 09:50:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
Message-ID: <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Matthew Wilcox <willy@infradead.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 20, 2022 at 07:10:46PM -0700, Linus Torvalds wrote:
> >
> > We got rid of i386 support back in 2012. Maybe it's time to get rid of
> > i486 support in 2022?
>
> Arnd suggested removing i486 last year and got a bit of pushback.
> The most convincing to my mind was Maciej:

Hmm. Maciej added to the cc.

I suspect we can just say "oh, well, use LTS kernels".

> but you can see a few other responses indicating that people have
> shipped new 486-class hardware within the last few years (!)

Hmm.. I can only find references to PC104 boards with Bay Trail
(Pentium-class Atom core, iirc), and some possible FPGA
implementations through MISTer.

There's apparently also a Vortex86DX board too, and I don't know what
core that is based off, but judging from the fact that it has a
dual-core version, it had *better* support cmpxchg8b anyway, because
without that our 64-bit atomics aren't actually atomic.

(Trying to google around, it looks like the older Vortex86SX was a
486-class CPU and did indeed lack CX8)

Intel had some embedded cores (Quark) that were based on the i486
pipeline (as can be seen from the timings), but they actually reported
themselves as Pentium-class and supported all the classic (pre-MMX)
Pentium features.

So I *really* don't think i486 class hardware is relevant any more.
Yes, I'm sure it exists (Maciej being an example), but from a kernel
development standpoint I don't think they are really relevant.

At some point, people have them as museum pieces. They might as well
run museum kernels.

Moving up to requiring cmpxchg8b doesn't sound unreasonable to me.

            Linus
