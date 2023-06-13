Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50C72D74A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjFMCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:17:19 -0400
Received: from out-40.mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C410FA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:17:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686622633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17ugyNFhbrwEanCoHF7v9qrJ1jJmHx/jdN9D7BRY9oE=;
        b=m7DmPVEXGMkpf0bo+q5pbu5oDDKH189Z/XzRq7Dih/3Dx0SQfpjZXQWTSJWS3TkVoCDoXU
        +v02nL8NwADRue1ybe3/uGEqr48aSC+9ZD5XlLUCSo4eNSNQeoeI8A91KFFzRGT1sCbUPr
        MXmvlJA1v+AC/K7Zq4kbQC18O8E8+QA=
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Encapsulate PTE contents from non-arch code
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230612151545.3317766-1-ryan.roberts@arm.com>
Date:   Tue, 13 Jun 2023 10:16:26 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
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
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        damon@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <3ECE40AA-536E-4A2C-82BA-FE74AA6FB689@linux.dev>
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 12, 2023, at 23:15, Ryan Roberts <ryan.roberts@arm.com> wrote:
>=20
> Hi All,
>=20
> (Including wider audience this time since changes touch a fair few =
subsystems)
>=20
> This is the second half of v3 of a series to improve the encapsulation =
of pte
> entries by disallowing non-arch code from directly dereferencing pte_t =
pointers.
> Based on earlier feedback, I split the series in 2; the first part, =
fixes for
> existing bugs, was already posted at [3] and merged into mm-stable. =
This second
> part contains the conversion from direct dereferences to instead use
> ptep_get()/ptep_get_lockless().
>=20
> See the v1 cover letter at [1] for rationale for this work.
>=20
> Based on feedback at v2, I've removed the new ptep_deref() helper I =
originally
> added, and am now using the existing ptep_get() and =
ptep_get_lockless() helpers.

When I first saw the name of ptep_get()/ptep_get_lockless(), I thought
the pte seems like to be protected by the refcount mechanism (Why I have
this though? Because Qi Zheng has proposed a approach to free pte page =
tables
by using the refcount mechanism [1]). And your proposed name of =
ptep_deref()
is intuitive for me, so I have another thought, should we rename =
ptep_get()
to ptep_deref()? Just a thought from me, I'd like to hear if others =
object.

Thanks.

[1] =
https://lore.kernel.org/lkml/20211110105428.32458-7-zhengqi.arch@bytedance=
.com/=
