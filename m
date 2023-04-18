Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115706E5D45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDRJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDRJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:25:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59EC59EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:25:22 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7x92F008070;
        Tue, 18 Apr 2023 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=dxXSOYwDVg0GGmhGZrxhOVhMqHWEDZQlcp2LmqCJUO8=;
 b=afHN5VrzD7FTWcNGmguPRcs0827WbpfAy/JSIBfBjEqwxZLMsy7HPDmfGT4VlAtVqBu/
 atOEOQlZaJxS0ue1Gtwe/tQzWAo8fo13tSYOOOoK+ACzl7qycBceV4tchxm5AenfMnU/
 zqufwUvEw+QCa0PjqZi5DLHrfHA90ZvSYWrvtnECbEO410x96TsFLOFTzuK1b5897qpA
 /Si3esnAe4z57NQ0PPN2uD0T5egCavx8gE7YIPKOSLfvSGpgDm3ZPnGTjHLvV//6NTZa
 nUrXqfUzBqRSj4vsDIu++z6NnuF2eWvRx77qLefAAE3aw3OHUuFdKw15VTFgePLn0yDg 9w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1n9rpe66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:25:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I4m3tD019595;
        Tue, 18 Apr 2023 09:25:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pykj69jy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:25:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I9P5LF36242156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:25:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4695F2004B;
        Tue, 18 Apr 2023 09:25:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77BEB20040;
        Tue, 18 Apr 2023 09:25:03 +0000 (GMT)
Received: from tarunpc (unknown [9.124.31.73])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 09:25:03 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
In-Reply-To: <875y9ta6ns.fsf@linux.ibm.com>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
 <832d2b34-d18d-dbc3-1836-2d3e3381afcc@oracle.com>
 <875y9ta6ns.fsf@linux.ibm.com>
Date:   Tue, 18 Apr 2023 14:55:01 +0530
Message-ID: <87354xa6fm.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C7QTN32Afbkp6eCc0Nt9FtIU_vZtkdWw
X-Proofpoint-GUID: C7QTN32Afbkp6eCc0Nt9FtIU_vZtkdWw
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Hi Sidhartha,
>
> Thanks for your inputs, please find my comments inline
>
>> On 4/14/23 12:48 PM, Tarun Sahu wrote:
>>> folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
>>> folio does not have any tail page to set order. folio->_folio_nr_pages is
>>> set to 0 for order 0 in folio_set_order. It is required because
>>
>> In the previous discussion of this function, Mike mentioned having 
>> folio_set_order() be used for non-zero orders and adding a 
>> folio_clear_order() that is used to set order to 0. This could be done 
>> to reduce confusion.
>>
> Yes, I agree, I replied to Mathew reply to this thread, Lemme know your
> thought on this. In this patch, I proposed that there won't be need of
> folio_clear_order if folio_set_order(folio, 0) is not needed with minor
> changes in code path.
>
>>> _folio_nr_pages overlapped with page->mapping and leaving it non zero
>>> caused "bad page" error while freeing gigantic hugepages. This was fixed in
>>> Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
>>> pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
>>> pages to CMA") now explicitly clear page->mapping and hence we won't see
>>> the bad page error even if _folio_nr_pages remains unset. Also the order 0
>>> folios are not supposed to call folio_set_order, So now we can get rid of
>>> folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
>>> 
>>> The patch also moves _folio_set_head and folio_set_order calls in
>>> __prep_compound_gigantic_folio() such that we avoid clearing them in the
>>> error path.
>>> 
>>> Testing: I have run LTP tests, which all passes. and also I have written
>>> the test in LTP which tests the bug caused by compound_nr and page->mapping
>>> overlapping.
>>> 
>>> https://lore.kernel.org/all/20230413090753.883953-1-tsahu@linux.ibm.com/
>>> 
>>> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
>>> on newer kernel and, also with this patch it passes.
>>> 
>>> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>>> ---
>>>   mm/hugetlb.c  | 9 +++------
>>>   mm/internal.h | 8 ++------
>>>   2 files changed, 5 insertions(+), 12 deletions(-)
>>> 
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index f16b25b1a6b9..e2540269c1dc 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>>   			set_page_refcounted(p);
>>>   	}
>>>   
>>> -	folio_set_order(folio, 0);
>>>   	__folio_clear_head(folio);
>>>   }
>>>   
>>> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>>   	struct page *p;
>>>   
>>>   	__folio_clear_reserved(folio);
>>> -	__folio_set_head(folio);
>>> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
>>> -	folio_set_order(folio, order);
>>>   	for (i = 0; i < nr_pages; i++) {
>>>   		p = folio_page(folio, i);
>>>   
>>> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>>   		if (i != 0)
>>>   			set_compound_head(p, &folio->page);
>>>   	}
>>
>> calling set_compound_head() for the tail page before the folio has the 
>> head flag set could seem misleading. At this point order is not set as 
>> well so it is not clear that the folio is a compound page folio.
>>
> Yeah, I agree, But they are part of same call. I can avoid moving
> __folio_set_head. And I think, It wont mislead if I avoid moving
> __folio_set_head. Below function has the similar path.

Apologies, Here, I mixed the sentences, I want to say
It won't mislead if we avoid moving __folio_set_head, but move only
folio_set_order. Below function does the same.
>
> void prep_compound_page(struct page *page, unsigned int order)
> {
> 	int i;
> 	int nr_pages = 1 << order;
>
> 	__SetPageHead(page);
> 	for (i = 1; i < nr_pages; i++)
> 		prep_compound_tail(page, i);
>
> 	prep_compound_head(page, order);
> }
>
> Lemme know you thoughts.
>
>
> ~Tarun
>
>>> +	__folio_set_head(folio);
>>> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
>>> +	folio_set_order(folio, order);
>>>   	atomic_set(&folio->_entire_mapcount, -1);
>>>   	atomic_set(&folio->_nr_pages_mapped, 0);
>>>   	atomic_set(&folio->_pincount, 0);
>>> @@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>>   		p = folio_page(folio, j);
>>>   		__ClearPageReserved(p);
>>>   	}
>>> -	folio_set_order(folio, 0);
>>> -	__folio_clear_head(folio);
>>>   	return false;
>>>   }
>>>   
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 18cda26b8a92..0d96a3bc1d58 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
>>>    */
>>>   static inline void folio_set_order(struct folio *folio, unsigned int order)
>>>   {
>>> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
>>> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>>>   		return;
>>>   
>>>   	folio->_folio_order = order;
>>>   #ifdef CONFIG_64BIT
>>> -	/*
>>> -	 * When hugetlb dissolves a folio, we need to clear the tail
>>> -	 * page, rather than setting nr_pages to 1.
>>> -	 */
>>> -	folio->_folio_nr_pages = order ? 1U << order : 0;
>>> +	folio->_folio_nr_pages = 1U << order;
>>>   #endif
>>>   }
>>>   
