Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1258F5B5749
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiILJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiILJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:39:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A2FB1D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:39:44 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 198so6777465ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/locK1nMU2wTDSjtK8T7mBpx0lWcB3ffdE7tyuNnsYs=;
        b=pThsu5An0/jrF8fEvIK3vLpJIylUeCqjtoaIipVkF5wKRk2gnbm0SWZvK0hB+8ZPny
         3e4ujceiZzHQXHcHaBhonlrQhIspiuLFa8OgJRds3lu6rJBhrq2anAXXmzP6w/4YuFsY
         cQ2kmTBFwj21sJxnir219xicAXrvcHCLC4eHoFgdGMM4SbW2cSJE1m7ZuN+mveJYldcB
         aOthGIsSEMcRv+ho/WdsJIj0wZVYGFLlNZfQZvZ/0QCo+0ym/oLE5MW3gSFi7WlC5UmL
         E8RpTmqSmauBiZP26OfZdvcAPqATsKjULON4soiC6m+P8bz1ncatWVESM7chQ0rHwQQy
         sFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/locK1nMU2wTDSjtK8T7mBpx0lWcB3ffdE7tyuNnsYs=;
        b=s5lMxFRiWsk55YoARRUo4pG6uYB9YoD8qEcCWFBuIfXIyEehmky09006fc1ACkAPnp
         coLCLhvOLlZqFbeyNKqnKE8XanJ7UVwPuc6g0gP4o/+R6hklnEoNulWPhszkk8aDmHEm
         n/UFsOnwNFbF3ULl7iOhiyOdBch8ouPltcrWT0KZumAvNjO5OCfh1GWBvHriwNAp3zwO
         cRttAuRiXfTFO8nIiZcJmrpaYB3NEHukrt/IvRZCG4K7J8HrANQV7O+d4n/+wLpF1zzZ
         GcZTeiNZddhWSJWRPl9mhpH2/Ju8irWBvJM/sXtzL/k7O51A30eK0Txji3czHIArw0GK
         nHcA==
X-Gm-Message-State: ACgBeo3gzZB1ZZ0rTnAAhqP0HwkjOzOMWKv75bgMhzOViw7OCL0dHIt+
        lJ/S3IfrJEygmzOv3YpYgJHn35JwL/rxJ8wdKoSrLCJnO+0=
X-Google-Smtp-Source: AA6agR5ftx8aP1X1AogNJFtAI0hydnVUXmuHTwE6kQ+Vk8DHhTQ+/7JavoIx33IUmDGMTfaI7SPYh5thF91WCBNYhms=
X-Received: by 2002:a25:1e86:0:b0:68d:549a:e4c2 with SMTP id
 e128-20020a251e86000000b0068d549ae4c2mr20782284ybe.93.1662975583465; Mon, 12
 Sep 2022 02:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662411799.git.andreyknvl@google.com> <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
In-Reply-To: <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Sep 2022 11:39:07 +0200
Message-ID: <CANpmjNM3RqQpvxvZ4+J9DYvMjcZwWjwEGakQb8U4DL+Eu=6K5A@mail.gmail.com>
Subject: Re: [PATCH mm v3 00/34] kasan: switch tag-based modes to stack ring
 from per-object metadata
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sept 2022 at 13:50, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Sep 5, 2022 at 11:05 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > This series makes the tag-based KASAN modes use a ring buffer for storing
> > stack depot handles for alloc/free stack traces for slab objects instead
> > of per-object metadata. This ring buffer is referred to as the stack ring.
> >
> > On each alloc/free of a slab object, the tagged address of the object and
> > the current stack trace are recorded in the stack ring.
> >
> > On each bug report, if the accessed address belongs to a slab object, the
> > stack ring is scanned for matching entries. The newest entries are used to
> > print the alloc/free stack traces in the report: one entry for alloc and
> > one for free.
> >
> > The advantages of this approach over storing stack trace handles in
> > per-object metadata with the tag-based KASAN modes:
> >
> > - Allows to find relevant stack traces for use-after-free bugs without
> >   using quarantine for freed memory. (Currently, if the object was
> >   reallocated multiple times, the report contains the latest alloc/free
> >   stack traces, not necessarily the ones relevant to the buggy allocation.)
> > - Allows to better identify and mark use-after-free bugs, effectively
> >   making the CONFIG_KASAN_TAGS_IDENTIFY functionality always-on.
> > - Has fixed memory overhead.
> >
> > The disadvantage:
> >
> > - If the affected object was allocated/freed long before the bug happened
> >   and the stack trace events were purged from the stack ring, the report
> >   will have no stack traces.
> >
> > Discussion
> > ==========
> >
> > The proposed implementation of the stack ring uses a single ring buffer for
> > the whole kernel. This might lead to contention due to atomic accesses to
> > the ring buffer index on multicore systems.
> >
> > At this point, it is unknown whether the performance impact from this
> > contention would be significant compared to the slowdown introduced by
> > collecting stack traces due to the planned changes to the latter part,
> > see the section below.
> >
> > For now, the proposed implementation is deemed to be good enough, but this
> > might need to be revisited once the stack collection becomes faster.
> >
> > A considered alternative is to keep a separate ring buffer for each CPU
> > and then iterate over all of them when printing a bug report. This approach
> > requires somehow figuring out which of the stack rings has the freshest
> > stack traces for an object if multiple stack rings have them.
> >
> > Further plans
> > =============
> >
> > This series is a part of an effort to make KASAN stack trace collection
> > suitable for production. This requires stack trace collection to be fast
> > and memory-bounded.
> >
> > The planned steps are:
> >
> > 1. Speed up stack trace collection (potentially, by using SCS;
> >    patches on-hold until steps #2 and #3 are completed).
> > 2. Keep stack trace handles in the stack ring (this series).
> > 3. Add a memory-bounded mode to stack depot or provide an alternative
> >    memory-bounded stack storage.
> > 4. Potentially, implement stack trace collection sampling to minimize
> >    the performance impact.
> >
> > Thanks!
>
> Hi Andrew,
>
> Could you consider picking up this series into mm?
>
> Most of the patches have a Reviewed-by tag from Marco, and I've
> addressed the last few comments he had in v3.
>
> Thanks!

I see them in -next, so they've been picked up?

FWIW, my concerns have been addressed, so for patches that don't yet
have my Reviewed:


Acked-by: Marco Elver <elver@google.com>
