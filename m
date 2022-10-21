Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E0606D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUCLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJUCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:11:17 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE001EA573
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:11:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322d768ba7so1880037fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ASIrxtSBDsxk4HGQqbLDireIOxv7TbGHiig0CHntdSI=;
        b=d0RcTWc1MKBOhhT5dKEG1Usy/aOhsV4HKs+lZmjbd5YXaVGizlNl0Eie/W1sistU3G
         5sKn7isal7vO0hl/3+xRKCOlZ1eBybkH73NcCluO/7XBbtsmJ6Fw5Wjx2PKGV4IR35QH
         +YloN2juFf0i7OOlQFZH+/wfTO9SBo0yFEw6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASIrxtSBDsxk4HGQqbLDireIOxv7TbGHiig0CHntdSI=;
        b=gGYQOPS1rqX24sJZrS8/WFFnuFmWZZ1ogNOhaHpWKV2ra6qKW8REwaYxQCas7M0p5v
         O6eve22bM1j8wUTW8XwXz6z+i+JtBO2j/34dtnscGJfjzUETaSI3fAzAUsE+AamCgKc/
         aPIk6lHYmlf3emDdfj4buW1O414CXfANRZjXhWVg8och5nh5vt7bZrWIhpAIYR8xf9mZ
         U/TSxK3KV72iEXRGywyHgqUMBdBXVslUtr/tHoW/6przLSPAqNxKm98jr3cchsgq47a4
         /es8jws7eKhmPCPwF29cFAqyGI57Jm5WadjPmLYDmf+HsY7q4j6r3xSWtx7oTP22GVCB
         WmsQ==
X-Gm-Message-State: ACrzQf3MLcT2vZF6bN59pf7dFsE3bAsgCtyPB28IOxgSEI6Wj4b4nUlH
        eEZGwFvxu8YrRQUIbXX7EzznMYLLsGZPFA==
X-Google-Smtp-Source: AMsMyM4kDVhTvIsnY4/k0qs36HLHZKDjK9pcDAssrJPIStqRqHPbblDWqN+m9PK31V6oLZogRZQNBQ==
X-Received: by 2002:a05:6870:8a14:b0:132:5c65:1024 with SMTP id p20-20020a0568708a1400b001325c651024mr11618527oaq.291.1666318275666;
        Thu, 20 Oct 2022 19:11:15 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a056808020700b00354b0850fb6sm626699oie.33.2022.10.20.19.11.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 19:11:14 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso250563ooo.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:11:14 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr13522092ybu.101.1666318263133; Thu, 20
 Oct 2022 19:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net> <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Oct 2022 19:10:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
Message-ID: <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
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

On Thu, Oct 20, 2022 at 11:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 20, 2022 at 10:35:28AM -0700, Linus Torvalds wrote:
> > That said, I reacted to that cmpxchg loop:
> >
> >         } while (cmpxchg64(&pmdp->pmd, old.pmd, 0ULL) != old.pmd);
> >
> > is this series just so old (but rebased) that it doesn't use "try_cmpxchg64()"?
>
> Yep -- it's *that* old :-/ You're not in fact the first to point that
> out.
>
> I'll make time tomorrow to fix it up and respin and send out. This is as
> good a time as any to get rid of carrying these patches myself.

Hmm. Thinking some more about it, even if you do it as a
try_cmpxchg64() loop, it ends up being duplicated twice.

Maybe we should just bite the bullet, and say that we only support
x86-32 with 'cmpxchg8b' (ie Pentium and later).

Get rid of all the "emulate 64-bit atomics with cli/sti, knowing that
nobody has SMP on those CPU's anyway", and implement a generic x86-32
xchg() setup using that try_cmpxchg64 loop.

I think most (all?) distros already enable X86_PAE anyway, which makes
that X86_CMPXCHG64 be part of the base requirement.

Not that I'm convinced most distros even do 32-bit development anyway
these days.

(Of course, if we require X86_CMPXCHG64, we'll also hit some of the
odd clone CPU's that actually *do* support the instruction, but do not
report it in cpuid due to an odd old Windows NT bug. IOW, things like
the Cyrix and Transmeta CPU's did support the instruction, but had the
CX8 bit clear because otherwise NT wouldn't boot. We may or may not
get those cases right, but I doubt anybody really has any of those old
CPUs).

We got rid of i386 support back in 2012. Maybe it's time to get rid of
i486 support in 2022?

That way we could finally get rid of CONFIG_MATH_EMULATION too.

               Linus
