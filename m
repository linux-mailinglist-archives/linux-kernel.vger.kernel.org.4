Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D65A6466DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLHCTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLHCTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:19:45 -0500
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [IPv6:2001:41d0:1004:224b::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD0716DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:19:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670465981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSszmN9yN6kL/If3FUicQlBPIM/TWwMp6cm84keStsE=;
        b=McDnxzI+sO7YBXmTXAqYqIu4KjUgkN3bguA1allYKj5IF9oelaD0nkCMpRHqxNrdaWhMJF
        Wuj0MSQ6cn5S6WPDxnqwDc++AyB2x3B4D8tnIMj9V+jn80uIeb3eCCJYk8mXEoSywwgE0d
        wLyVK+g/FC0KIfLJRZCBdQCsqjttpMM=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable v5 01/10] mm: add folio dtor and order setter
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y5DotA/pLbakONGl@monkey>
Date:   Thu, 8 Dec 2022 10:19:24 +0800
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F95112C-C1B3-4774-9E21-998CADEC38D4@linux.dev>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-2-sidhartha.kumar@oracle.com>
 <BAD34D59-187B-4BB3-B139-7983A8B62648@linux.dev> <Y5ALigw0kUO/B3z2@monkey>
 <4161AF1A-9508-4DF8-B756-FEB476EB32B5@linux.dev> <Y5DXivFOA+bO0IYQ@monkey>
 <b995eccf-5818-84ee-560e-20c00f9936b4@oracle.com>
 <d5755326-a71e-242b-5e1e-86fc897dc292@oracle.com> <Y5DotA/pLbakONGl@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 8, 2022, at 03:25, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 12/07/22 11:05, Sidhartha Kumar wrote:
>> On 12/7/22 10:49 AM, Sidhartha Kumar wrote:
>>> On 12/7/22 10:12 AM, Mike Kravetz wrote:
>>>> On 12/07/22 12:11, Muchun Song wrote:
>>>>>> On Dec 7, 2022, at 11:42, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>>>>>> On 12/07/22 11:34, Muchun Song wrote:
>>>>>=20
>>>>> Agree. It has confused me a lot. I suggest changing the code to =
the
>>>>> followings. The folio_test_large() check is still to avoid =
unexpected
>>>>> users for OOB.
>>>>>=20
>>>>> static inline void folio_set_compound_order(struct folio *folio,
>>>>>                         unsigned int order)
>>>>> {
>>>>>     VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>>     // or
>>>>>     // if (!folio_test_large(folio))
>>>>>     //     return;
>>>>>=20
>>>>>     folio->_folio_order =3D order;
>>>>> #ifdef CONFIG_64BIT
>>>>>     folio->_folio_nr_pages =3D order ? 1U << order : 0;
>>>>> #endif
>>>>> }
>>>>=20
>>>> I think the VM_BUG_ON_FOLIO is appropriate as it would at least =
flag
>>>> data corruption.
>>>>=20
>>> As Mike pointed out, my intention with supporting the 0 case was to
>>> cleanup the __destroy_compound_gigantic_page code by moving the =
ifdef
>>> CONFIG_64BIT lines to folio_set_compound_order(). I'll add the
>>> VM_BUG_ON_FOLIO line as well as a comment to make it clear it is not
>>> normally supported.
>>>=20
>>>> Thinking about this some more, it seems that hugetlb is the only =
caller
>>>> that abuses folio_set_compound_order (and previously =
set_compound_order)
>>>> by passing in a zero order.  Since it is unlikely that anyone knows =
of
>>>> this abuse, it might be good to add a comment to the routine to =
note
>>>> why it handles the zero case.  This might help prevent changes =
which
>>>> would potentially break hugetlb.
>>>=20
>>> +/*
>>> + * _folio_nr_pages and _folio_order are invalid for
>>> + * order-zero pages. An exception is hugetlb, which passes
>>> + * in a zero order in __destroy_compound_gigantic_page().
>>> + */
>>>  static inline void folio_set_compound_order(struct folio *folio,
>>>                 unsigned int order)
>>>  {
>>> +       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>> +
>>>         folio->_folio_order =3D order;
>>>  #ifdef CONFIG_64BIT
>>>         folio->_folio_nr_pages =3D order ? 1U << order : 0;
>>>=20
>>> Does this comment work?
>>>=20
>>>=20
>>=20
>> I will change the comment from referencing
>> __destory_compound_gigantic_page()
>> to __destroy_compound_gigantic_folio, although
>> __prep_compound_gigantic_folio() is another user of
>> folio_set_compound_order(folio, 0). Should the sentence just be "An
>> exception is hugetlb, which passes in a zero order"?
>=20
> How about a comment like this?
>=20
> /*
> * folio_set_compound_order is generally passed a non-zero order to
> * set up/create a large folio.  However, hugetlb code abuses this by
> * passing in zero when 'dissolving' a large folio.
> */

How about adding a new helper like "folio_dissolve_compound(struct folio =
*folio)"?
then it may be unnecessary to add a comment.

Thanks.

>=20
> My only concern is that someone may modify the routine such that it no
> longer works when passed zero order.  It is not likely as anyone =
should
> notice the special case for zero, and look for callers.
> --=20
> Mike Kravetz


