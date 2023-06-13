Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA69E72DCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbjFMInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbjFMIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:43:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168B11BC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:43:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8C41FB;
        Tue, 13 Jun 2023 01:44:10 -0700 (PDT)
Received: from [10.57.74.148] (unknown [10.57.74.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5C33F71E;
        Tue, 13 Jun 2023 01:43:20 -0700 (PDT)
Message-ID: <6b328080-ca6e-a2b1-4644-a29b62d6ac6e@arm.com>
Date:   Tue, 13 Jun 2023 09:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/3] Encapsulate PTE contents from non-arch code
To:     Andrew Morton <akpm@linux-foundation.org>
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
 <20230612131656.2ba4f95865f27e6b3b984936@linux-foundation.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230612131656.2ba4f95865f27e6b3b984936@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for taking the patches!

On 12/06/2023 21:16, Andrew Morton wrote:
> On Mon, 12 Jun 2023 16:15:42 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Hi All,
>>
>> (Including wider audience this time since changes touch a fair few subsystems)
>>
>> This is the second half of v3 of a series to improve the encapsulation of pte
>> entries by disallowing non-arch code from directly dereferencing pte_t pointers.
> 
> That's basically all we have here for [0/N] cover letter content.  I
> stole some words from the [3/3] changelog, so we now have:
> 
> : A series to improve the encapsulation of pte entries by disallowing
> : non-arch code from directly dereferencing pte_t pointers.
> : 
> : This means that by default, the accesses change from a C dereference to a
> : READ_ONCE().  This is technically the correct thing to do since where
> : pgtables are modified by HW (for access/dirty) they are volatile and
> : therefore we should always ensure READ_ONCE() semantics.
> : 
> : But more importantly, by always using the helper, it can be overridden by
> : the architecture to fully encapsulate the contents of the pte.  Arch code
> : is deliberately not converted, as the arch code knows best.  It is
> : intended that arch code (arm64) will override the default with its own
> : implementation that can (e.g.) hide certain bits from the core code, or
> : determine young/dirty status by mixing in state from another source.

I'm not sure I've understood what you are saying here? Is there some expectation
for the content of the cover letter for mm patches, which I'm not aware of? If
you can point me to some docs I'll make sure I'm conformant in future.

> 
> 
>> Based on earlier feedback, I split the series in 2; the first part, fixes for
>> existing bugs, was already posted at [3] and merged into mm-stable. This second
>> part contains the conversion from direct dereferences to instead use
>> ptep_get()/ptep_get_lockless().
>>
>> See the v1 cover letter at [1] for rationale for this work.
>>
>> Based on feedback at v2, I've removed the new ptep_deref() helper I originally
>> added, and am now using the existing ptep_get() and ptep_get_lockless() helpers.
>> Testing on Ampere Altra (arm64) showed no difference in performance when using
>> ptep_deref() (*pte) vs ptep_get() (READ_ONCE(*pte)).
>>
>> Patches are based on mm-unstable (49e038b1919e) and a branch is available at [4]
>> (Let me know if this is the wrong branch to target - I'm still not familiar with
>> the details of the mm- dev process!). Note that Hugh Dickins's "mm: allow
>> pte_offset_map[_lock]() to fail" (now in mm-unstable) patch set caused a number
>> of conflicts which I've resolved. But due to that, you won't be able to apply
>> these patches on top of Linus's tree. I have an alternate branch on top of
>> v6.4-rc6 at [5].
> 
> Yep, that's all great, thanks.
> 
> 
> Is there some clever trick we can do to prevent new open-coded derefs
> of pte_t* from being introduced?

I've been thinking about this myself but don't have a good answer at the moment.
I used 2 techniques to find them all, but neither are fullproof so required hand
editing:

1) global find/replace of "pte_t *" to "pte_handle_t ", and define pte_handle_t
as void *. Then the compiler will throw an error for an attempted dereference.
This obbiously only checks code that is actually being compiled, and it doesn't
prevent anyone from declaring a pte_t* and directly dereferencing in future.

2) Using the coccinelle script. This worked pretty well, but finds a few places
where the pte_t pointer is not pointing to a page table, but a variable on the
stack, and there it is legitimate to dereference (we don't want to use
ptep_get()/ptep_set_at() there). And also flags up lots of arch code that needs
to be ignored.

There are coccinelle scripts kept in scripts/coccinelle that apprarently get run
semi-regularly [1]. So could submit something there, but would need to add
support for excluding the arch directory and for marking known false-positives,
neither of which I think are currently available. Does anyone know better?

> 
> I suppose we could convert pte_t to a single-member struct to force a
> compile error.  That struct will get passed by value to ptep_get() so
> that's OK.  But this isn't viable unless/until all architectures are
> converted :(

It already is defined that way for arm64 at least:

  typedef struct { pteval_t pte; } pte_t;

But I'm not sure how that helps? You can still legally deref it in C.

> 
> Or we rely upon Ryan to grep the tree occasionally ;)

This is my least favourite option ;-) But it wouldn't be the end of the world in
the short term. Once I achieve the full objective of using arm64's contpte
capability, open coded derefs will manifest as bugs (at least for cases where
the accuracy of the access/dirty bits matter), which will certainly make sure
they get fixed.

Thanks,
Ryan

