Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D5072D054
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjFLURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFLURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF710CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3D1620F0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E2C433D2;
        Mon, 12 Jun 2023 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686601019;
        bh=8YwIQ32/ViY707FKKgvZp3YPJFrRZ0aMF4dQkzNJeeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AvnloMMfQhyspWTCXbJI1zH2gVyj95+f4+W4RGfmmaNXGhaPd8jHRwHw0Qm3Hrjhr
         0KW0YJ2+03iBgS4RJ/y9BmopWmjpF2nTfpBvGg6frcCf09oU0NfTSdWhQ83Tf+iWA5
         TOaCwaJX+ZTwKgd5PeSmQeuGsXO7qxaGwalFpJKw=
Date:   Mon, 12 Jun 2023 13:16:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: Re: [PATCH v3 0/3] Encapsulate PTE contents from non-arch code
Message-Id: <20230612131656.2ba4f95865f27e6b3b984936@linux-foundation.org>
In-Reply-To: <20230612151545.3317766-1-ryan.roberts@arm.com>
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 16:15:42 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi All,
> 
> (Including wider audience this time since changes touch a fair few subsystems)
> 
> This is the second half of v3 of a series to improve the encapsulation of pte
> entries by disallowing non-arch code from directly dereferencing pte_t pointers.

That's basically all we have here for [0/N] cover letter content.  I
stole some words from the [3/3] changelog, so we now have:

: A series to improve the encapsulation of pte entries by disallowing
: non-arch code from directly dereferencing pte_t pointers.
: 
: This means that by default, the accesses change from a C dereference to a
: READ_ONCE().  This is technically the correct thing to do since where
: pgtables are modified by HW (for access/dirty) they are volatile and
: therefore we should always ensure READ_ONCE() semantics.
: 
: But more importantly, by always using the helper, it can be overridden by
: the architecture to fully encapsulate the contents of the pte.  Arch code
: is deliberately not converted, as the arch code knows best.  It is
: intended that arch code (arm64) will override the default with its own
: implementation that can (e.g.) hide certain bits from the core code, or
: determine young/dirty status by mixing in state from another source.


> Based on earlier feedback, I split the series in 2; the first part, fixes for
> existing bugs, was already posted at [3] and merged into mm-stable. This second
> part contains the conversion from direct dereferences to instead use
> ptep_get()/ptep_get_lockless().
> 
> See the v1 cover letter at [1] for rationale for this work.
> 
> Based on feedback at v2, I've removed the new ptep_deref() helper I originally
> added, and am now using the existing ptep_get() and ptep_get_lockless() helpers.
> Testing on Ampere Altra (arm64) showed no difference in performance when using
> ptep_deref() (*pte) vs ptep_get() (READ_ONCE(*pte)).
> 
> Patches are based on mm-unstable (49e038b1919e) and a branch is available at [4]
> (Let me know if this is the wrong branch to target - I'm still not familiar with
> the details of the mm- dev process!). Note that Hugh Dickins's "mm: allow
> pte_offset_map[_lock]() to fail" (now in mm-unstable) patch set caused a number
> of conflicts which I've resolved. But due to that, you won't be able to apply
> these patches on top of Linus's tree. I have an alternate branch on top of
> v6.4-rc6 at [5].

Yep, that's all great, thanks.


Is there some clever trick we can do to prevent new open-coded derefs
of pte_t* from being introduced?

I suppose we could convert pte_t to a single-member struct to force a
compile error.  That struct will get passed by value to ptep_get() so
that's OK.  But this isn't viable unless/until all architectures are
converted :(

Or we rely upon Ryan to grep the tree occasionally ;)
