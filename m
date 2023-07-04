Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5E74673C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGDCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGDCTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:19:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F6E70
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:19:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401f4408955so491671cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 19:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688437174; x=1691029174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzYdNMzSEjup40eaGDHi1UPxNXPRVOvs9KVOLwuo1X8=;
        b=YanU/9JpsSoIkstsYmvxwLf4Pdrd+kjk57QT+7u5Km8QdoY++Cscminmi7dNUCmVJN
         c1G3jQvnhhGmGj6GBKL3J9UuiWTFpAuIBdQCUNHV8eANm7KXF5nleI3yNlE0UMNJ1U3w
         hQOevI/XzfvRrzk+cwiZFyS3PPi7jqp8dHQUA/t/rL3C3lc/l0qdTkVheV4XcSvOUa/L
         /czQv+Yv3g9dFGe+fpbAq7qs/T/djlm8M1wAZJrbsB4s/7DBBEfdugZHtKfHn47zi+/H
         +8vR+lzQbzx+3OhnEbp8lbmKcJTg4gzamTde+B7QAwvJ6nJqj9bI3xdYSwJIEqGtGv3/
         lyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688437174; x=1691029174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzYdNMzSEjup40eaGDHi1UPxNXPRVOvs9KVOLwuo1X8=;
        b=kpHH8DVWy3qIpVov/+Iwz9Bh86qT6ZWaqjkePeAnmM/DkITk2NMzdRLAO0khkkxAv/
         qQFTTjg6LmXqSKdM03Plr+61gDfOTUeD3+Z15OyuvzKsQdQEiZdAZWFt5+/s32o8I8nz
         4D+dcx279dpBJTCuvovWRHmf7HaCuib7tWpZAZxUNeKC0zD8CoS5zYkG+fBVJJ0T1Zxe
         6KIaBdtOcLL/e+4zRWd09ACELV8e0yKOBUx+4JgKhcpTVA7EDjcka2Pwj4w2xijgSqgx
         fCenwX6aN3fYscedd4T2/J4FRBvik+ni4gmjGDSxbzo99oASr+0IqOctdVP7fOXRoIBk
         HhrA==
X-Gm-Message-State: ABy/qLbTSbZG1LGoqpzjPI/ES83S0DOgPkelMyB/5G5DaBeEow+OB94N
        jbrdSSUBdmp+ejee2nML3kWLt4oAGRs9z/lufiowyQ==
X-Google-Smtp-Source: APBJJlEcKfiNUvWa1AnjxU4r099qbHgdzmXqztQhjJj0kS84wyNjwTaQIL1OAimmRQDFKSkNbkpe8WpSjpyxfUuWJkQ=
X-Received: by 2002:a05:622a:314:b0:3ef:302c:319e with SMTP id
 q20-20020a05622a031400b003ef302c319emr40179qtw.8.1688437174233; Mon, 03 Jul
 2023 19:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
In-Reply-To: <20230703135330.1865927-1-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 20:18:50 -0600
Message-ID: <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Hi All,
>
> This is v2 of a series to implement variable order, large folios for anon=
ymous
> memory. The objective of this is to improve performance by allocating lar=
ger
> chunks of memory during anonymous page faults. See [1] for background.

Thanks for the quick response!

> I've significantly reworked and simplified the patch set based on comment=
s from
> Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
> VARIABLE_THP, on Yu's advice.
>
> The last patch is for arm64 to explicitly override the default
> arch_wants_pte_order() and is intended as an example. If this series is a=
ccepted
> I suggest taking the first 4 patches through the mm tree and the arm64 ch=
ange
> could be handled through the arm64 tree separately. Neither has any build
> dependency on the other.
>
> The one area where I haven't followed Yu's advice is in the determination=
 of the
> size of folio to use. It was suggested that I have a single preferred lar=
ge
> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or =
there
> being existing overlapping populated PTEs, etc) then fallback immediately=
 to
> order-0. It turned out that this approach caused a performance regression=
 in the
> Speedometer benchmark.

I suppose it's regression against the v1, not the unpatched kernel.

> With my v1 patch, there were significant quantities of
> memory which could not be placed in the 64K bucket and were instead being
> allocated for the 32K and 16K buckets. With the proposed simplification, =
that
> memory ended up using the 4K bucket, so page faults increased by 2.75x co=
mpared
> to the v1 patch (although due to the 64K bucket, this number is still a b=
it
> lower than the baseline). So instead, I continue to calculate a folio ord=
er that
> is somewhere between the preferred order and 0. (See below for more detai=
ls).

I suppose the benchmark wasn't running under memory pressure, which is
uncommon for client devices. It could be easier the other way around:
using 32/16KB shows regression whereas order-0 shows better
performance under memory pressure.

I'm not sure we should use v1 as the baseline. Unpatched kernel sounds
more reasonable at this point. If 32/16KB is proven to be better in
most scenarios including under memory pressure, we can reintroduce
that policy. I highly doubt this is the case: we tried 16KB base page
size on client devices, and overall, the regressions outweighs the
benefits.

> The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes() ser=
ies
> [2], which is a hard dependency. I have a branch at [3].

It's not clear to me why [2] is a hard dependency.

It seems to me we are getting close and I was hoping we could get into
mm-unstable soon without depending on other series...
