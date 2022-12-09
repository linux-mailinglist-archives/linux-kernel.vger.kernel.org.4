Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516FB6483C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiLIO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLIO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:28:19 -0500
Received: from out-143.mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3A23BD4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:28:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670596095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5PBJXFzAfljLL5GpFuCZtP5a/X5elUo4Ca2Dzwt22Y=;
        b=mnihHuRTQhvfXW58YLWebiCzuZVttBgCe0CuYAQ4KmPqSErVy/jvpK2M6SeT+oXEFJX2EW
        mbOTmMwzSNghV5XF4WLLO/vNPbZXBlsMlDHPzCh5Dun9J9GqOQCFbbiP9wRUHhn1yHV19v
        BegeO8C3lX7mUD+A7xTP1A7YTstX6rI=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
Date:   Fri, 9 Dec 2022 22:27:38 +0800
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, tsahu@linux.ibm.com,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00222280-DBDD-49A3-92A5-05112359AE30@linux.dev>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
 <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
 <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
 <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2022, at 06:39, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> On 12/8/22 14:33, Sidhartha Kumar wrote:
>> On 12/8/22 2:14 PM, John Hubbard wrote:
>>> On 12/8/22 14:12, Sidhartha Kumar wrote:
>>>> On 12/8/22 2:01 PM, John Hubbard wrote:
>>>>> On 12/8/22 13:58, Sidhartha Kumar wrote:
>>>>>> Thanks John, Mike, Matthew, and Muchun for the feedback.
>>>>>>=20
>>>>>> To summarize this discussion and outline the next version of this =
patch, the changes I'll make include:
>>>>>>=20
>>>>>> 1) change the name of folio_set_compound_order() to =
folio_set_order()
>>>>>> 2) change the placement of this function from mm.h to =
mm/internal.h
>>>>>> 3) folio_set_order() will set both _folio_order and =
_folio_nr_pages and handle the zero order case correctly.
>>>>>> 4) remove the comment about hugetlb's specific use for zero =
orders
>>>>>> 5) improve the style of folio_set_order() by removing ifdefs from =
inside the function to doing
>>>>>>=20
>>>>>> #ifdef CONFIG_64BIT
>>>>>>   static inline void folio_set_order(struct folio *folio,
>>>>>>                   unsigned int order)
>>>>>>   {
>>>>>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>>=20
>>>>> Sounds good, except for this part: why is a function named
>>>>> folio_set_order() BUG-ing on a non-large folio? The naming
>>>>> is still wrong, perhaps?
>>>>>=20
>>>>=20
>>>> This is because the _folio_nr_pages and _folio_order fields are =
part of the first tail page in the folio. folio_test_large returns if =
the folio is larger than one page which would be required for setting =
the fields.
>>>=20
>>> OK, but then as I said, the name is wrong. One can either:
>>>=20
>>> a) handle the non-large case, or
>>>=20
>>> b) rename the function to indicate that it only works on large =
folios.
>>>=20
>> Discussed here[1], the BUG_ON line seemed more appropriate over
>> if (!folio_test_large(folio))
>>     return;
>> as the misuse would not be silent. I think I would be against =
renaming the function as I don't see any large folio specific function =
names for other accessors of tail page fields. Would both the BUG_ON and =
return on non-large folio be included then?
>=20
> Actually, if you want the "misuse to not be silent", today's =
guidelines
> would point more toward WARN and return, instead of BUG, btw.

=46rom you advise, I think we can remove VM_BUG_ON and handle non-zero
order page, something like:

static inline void folio_set_order(struct folio *folio,
		                   unsigned int order)
{
	if (!folio_test_large(folio)) {
		WARN_ON(order);
		return;
	}

	folio->_folio_order =3D order;
#ifdef CONFIG_64BIT
	folio->_folio_nr_pages =3D order ? 1U << order : 0;
#endif
}

In this case,

  1) we can handle both non-zero and zero (folio_order() works as well
     for this case) order page.
  2) it can prevent OOB for non-large folio and warn unexpected users.
  3) Do not BUG.
  4) No need to rename folio_set_order.

What do you think?

Thanks.

>=20
> I don't think that a survey of existing names is really the final word =
on what
> to name this. Names should be accurate, even if other names are less =
so. How
> about something like:
>=20
>    large_folio_set_order()
>=20
> ?
>=20
>> [1]: =
https://lore.kernel.org/linux-mm/20221129225039.82257-1-sidhartha.kumar@or=
acle.com/T/#m98cf80bb21ae533b7385f2e363c602e2c9e2802d
>>>=20
>>> thanks,
>=20
> thanks,
> --=20
> John Hubbard
> NVIDIA


