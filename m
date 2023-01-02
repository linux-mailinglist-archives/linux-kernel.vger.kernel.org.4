Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804BF65B6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjABTFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjABTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:05:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A382AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:05:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e21so9585674pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EKRJQffX4Q2GU/cYCvZE68D484wrxP9lYTVgY7yap7g=;
        b=QDUJtrnwEeJUW8MAuyZ97d3xxWTSeHLM0KUL9jiGpE5qCjS3hQ5pSmBrXQussL+dqf
         cahzBacA4pw+IO33VyszoFXYiz/oGUpmYZA3IE2pA1T52T/Q5Kb7otZpoze8yCHH23R0
         KLu5QOMG/3FIMIexSrvage/lS3YMvRNM6cK2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKRJQffX4Q2GU/cYCvZE68D484wrxP9lYTVgY7yap7g=;
        b=rd/URbdxhZjvjh5Ew+M+SMwzTA43n8ijGhQEiyt0sCa0P80sScPYC/M9ZJ6HYvE82b
         sTYkBRh6gXL/3i6XxN9lrXvDaQyfQEm6HLBY2IlBLiVJQ7rd4HP+VeZMHX+aPnUwtTLj
         ogb7cEEXzCE96/e6IyVCFwObhMBzheh0fQ7wIzL5EyrnLBvb8U2VlDv/Gbv4hieRAyms
         +h51S3bGwoEz9VZfeCBtYHy2M0ICRDEXMVxVJh1e77vAlYNanv7yXFMVj+wxRmtn4lam
         FoYZcIN5+sW70IvUH6/qoSSBR3uAQX0KsLfvfnLZIxcGCYXr++/rcHMV5dtKIlYqEwo6
         1FDA==
X-Gm-Message-State: AFqh2krV/Yig/tVsImyIyU4jW8t3xXkSc53EDOkR6yo8j/rO07Z1JPUO
        I/lIeA1PjpLNvQZiFC7x39iHEVajHtLH5Sxk
X-Google-Smtp-Source: AMrXdXs7dPsl5QPzdy+AtrQuU2eruTgu51G5GKCZkwd4AkH8zQbqwlJRc63Z5doc3pfwcIW61Q0orA==
X-Received: by 2002:a62:79c9:0:b0:581:3e4e:a08f with SMTP id u192-20020a6279c9000000b005813e4ea08fmr29958147pfc.11.1672686347812;
        Mon, 02 Jan 2023 11:05:47 -0800 (PST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79563000000b005818d4284aasm10073882pfq.160.2023.01.02.11.05.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 11:05:47 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id jn22so30302196plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 11:05:47 -0800 (PST)
X-Received: by 2002:a05:6214:568c:b0:531:7593:f551 with SMTP id
 lm12-20020a056214568c00b005317593f551mr1532254qvb.89.1672686336079; Mon, 02
 Jan 2023 11:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com> <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box> <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
 <4cf29f7a1a0041da818ac7ef598d142e@AcuMS.aculab.com>
In-Reply-To: <4cf29f7a1a0041da818ac7ef598d142e@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jan 2023 11:05:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh9zNsFX0gSfMBfJBxOOTztsZ6NZc5pvzCikB1Gz8B3A@mail.gmail.com>
Message-ID: <CAHk-=wgh9zNsFX0gSfMBfJBxOOTztsZ6NZc5pvzCikB1Gz8B3A@mail.gmail.com>
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     David Laight <David.Laight@aculab.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jan 2, 2023 at 5:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> > It would just turn all kernel addresses into all ones, which is then
> > guaranteed to fault. So no need for any conditional that never
> > triggers in real life anyway.
>
> Are byte loads guaranteed to fault?

Yeah, we don't map the highest address on x86-64. And we don't want to
in the future either, because of how our error pointers work (ie if
somebody misses an "IS_ERR()" check and uses an error pointer as a
pointer, we want that to fault, rather than do random things).

It's not a hard requirement architecturally (either hardware or
software), and iirc on 32-bit we used to use the last virtual page for
something, so maybe I'm missing some odd use on 64-bit too, but
accessing the top-of-virtual address space on x86-64 should always
cause a clear fault afaik.

A byte access would always be a page fault, while a wrapping access
might trigger a GP fault first (probably not - on 32-bit it would be a
segment size violation, on 64-bit we've left those bad old days behind
and I don't think wrapping matters either)

> Presumably the fault handler already has the code to untag addresses.

More importantly, the fault handler isn't in any critical path. By the
time you've taken a page fault, the extra instructions to mask off any
bits are entirely irrelevant.

> It has to be said that I don't really see why tagging addresses is a
> significant benefit unless the hardware checks than the PTE/TLB is
> also set with the correct tag.

You can certainly pair it with hardware support for checking the tag,
but even without it, it can be a useful acceleration for doing
software pointer tag checking without having to always add the extra
code (and extra register pressure) to mask things off manually to
dereference it.

And traditionally, in various virtual machine environments, it's been
used for hiding information about what the pointer _points_ to,
without having to use up extra memory for some kind of type lookup.
Old old LISP being the traditional case (not because of some "top byte
ignore" flag, but simply because the address space was smaller than
the word size). People did the same on the original m68k - and for the
exact same reason.

Of course, on m68k it was a horrible mistake that people still
remember ("You're telling me 24 bits wasn't enough after all?") but
it's a new day, and 64 bits is a _lot)_ more than 32 bits.

The new world order of "56 bits is actually enough" is likely to
remain true in a lot of environments for the foreseeable future - the
people who already disagree tend to special, either because they want
to use the virtual address bits for *other* things (ie sparse address
spaces etc) or because they are doing globally addressable memory on
truly large machines.

A lot of "normal" use scenarios will be fundamentally limited by
physics to "56 bits is a *lot*", and using high pointer address bits
is unquestionably a good thing.

So enforcing some hardware tag check is not always what you want,
because while that is useful for *one* particular use case (ie the
ARM64 MTE extension, and hw-tagged KASAN), and that may be the only
particular use in some scenarios, other environments might use the top
bits for other pointer information.

            Linus
