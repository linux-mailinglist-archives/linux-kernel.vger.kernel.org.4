Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE25B4E91
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIKLuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiIKLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:50:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C81409D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:50:14 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j1so4818630qvv.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=o0NomSJrd+We+cA0E2POE4mJvtyH0veoDgu14xHBABY=;
        b=Pp9lyLfWT0KtFM0AeWo+3VXMLLCDOJ45kj5tKR8HN3LHR9KS/v1qQDYrN+CLFAEULv
         VVonzvH8r3D/posWDedCCZ1NJ+/yWwtlmZcmy2J8eMW0eO90VzaFlyZhxZjZ+yf6T/NV
         uopfI59iOR5oeDXyuJ8rQbjE1pq8h8zRnPcl8+AFO/GMJk3/JJCHl7AeaQsbZG94BK3p
         RAvl1WbB1e+ySRPsytspHPKfBv9dJfEpVAlh0Uwj6+DWyPNStXoG9L6buUdLLjQS3luR
         +YuXiBMwLKK+dqJlEkXQuIOP+GasUjOP6jIBb9Rryli6vEaI+KrzPceI40IU2TPIP+Ap
         93Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o0NomSJrd+We+cA0E2POE4mJvtyH0veoDgu14xHBABY=;
        b=BAVsisiwUTv9yaWeHsj/oQVXKDd0lLVvDtxXg/JgdQyEEF/RaVyGcKVpULhdJ+XgNM
         V6yoUrhH2fKOn/yW/FBTVtOVCG6uCXrXb6rO2oVviljIkH+Kl9pAeMJQFg9jl2zlbRD1
         Nfi5u0sVx/VcX0y3cUQbPnASU2FAS1K1p511tL6aBzKLZNCED6FKs8OEEobG0l8U48bZ
         K6hE6QTICkJrK+y4dYKhd+DPuePJHapK/iYgDg++VumAsW7vduC/7NpvDSyA6o8xMDoH
         n2nfgNU6TE07MbKOyteaygMHuThwlYayOtMjo/PdWgcEMtkH3PFHp+zj6VtLxV2pQ5BB
         kPJQ==
X-Gm-Message-State: ACgBeo0ljPKZMGcUYdL8QHw83R1PuE4Y8udEg2LuU7Hh+ltj5w3yK1BL
        ffI/VMT56+QSNGC70X9wzJeE3skIgNhFTfxAlvI=
X-Google-Smtp-Source: AA6agR7/UuRd30ILIGK8EmCGtvCb25BL9Ss3QDk7CaEG7fb7O+sQihMLNbeBbL+kICpDyLIToo3Lim2Bi4QJeilZOrA=
X-Received: by 2002:a05:6214:c48:b0:4ac:b18d:c101 with SMTP id
 r8-20020a0562140c4800b004acb18dc101mr849569qvj.107.1662897013746; Sun, 11 Sep
 2022 04:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 13:50:03 +0200
Message-ID: <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
Subject: Re: [PATCH mm v3 00/34] kasan: switch tag-based modes to stack ring
 from per-object metadata
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 11:05 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> This series makes the tag-based KASAN modes use a ring buffer for storing
> stack depot handles for alloc/free stack traces for slab objects instead
> of per-object metadata. This ring buffer is referred to as the stack ring.
>
> On each alloc/free of a slab object, the tagged address of the object and
> the current stack trace are recorded in the stack ring.
>
> On each bug report, if the accessed address belongs to a slab object, the
> stack ring is scanned for matching entries. The newest entries are used to
> print the alloc/free stack traces in the report: one entry for alloc and
> one for free.
>
> The advantages of this approach over storing stack trace handles in
> per-object metadata with the tag-based KASAN modes:
>
> - Allows to find relevant stack traces for use-after-free bugs without
>   using quarantine for freed memory. (Currently, if the object was
>   reallocated multiple times, the report contains the latest alloc/free
>   stack traces, not necessarily the ones relevant to the buggy allocation.)
> - Allows to better identify and mark use-after-free bugs, effectively
>   making the CONFIG_KASAN_TAGS_IDENTIFY functionality always-on.
> - Has fixed memory overhead.
>
> The disadvantage:
>
> - If the affected object was allocated/freed long before the bug happened
>   and the stack trace events were purged from the stack ring, the report
>   will have no stack traces.
>
> Discussion
> ==========
>
> The proposed implementation of the stack ring uses a single ring buffer for
> the whole kernel. This might lead to contention due to atomic accesses to
> the ring buffer index on multicore systems.
>
> At this point, it is unknown whether the performance impact from this
> contention would be significant compared to the slowdown introduced by
> collecting stack traces due to the planned changes to the latter part,
> see the section below.
>
> For now, the proposed implementation is deemed to be good enough, but this
> might need to be revisited once the stack collection becomes faster.
>
> A considered alternative is to keep a separate ring buffer for each CPU
> and then iterate over all of them when printing a bug report. This approach
> requires somehow figuring out which of the stack rings has the freshest
> stack traces for an object if multiple stack rings have them.
>
> Further plans
> =============
>
> This series is a part of an effort to make KASAN stack trace collection
> suitable for production. This requires stack trace collection to be fast
> and memory-bounded.
>
> The planned steps are:
>
> 1. Speed up stack trace collection (potentially, by using SCS;
>    patches on-hold until steps #2 and #3 are completed).
> 2. Keep stack trace handles in the stack ring (this series).
> 3. Add a memory-bounded mode to stack depot or provide an alternative
>    memory-bounded stack storage.
> 4. Potentially, implement stack trace collection sampling to minimize
>    the performance impact.
>
> Thanks!

Hi Andrew,

Could you consider picking up this series into mm?

Most of the patches have a Reviewed-by tag from Marco, and I've
addressed the last few comments he had in v3.

Thanks!
