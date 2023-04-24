Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A06ED188
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDXPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDXPhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC413E5E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:37:50 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OFaI8X000941;
        Mon, 24 Apr 2023 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=HdggoQsHxwYoIKSgaW8mjgzyiJ7jKhJof5hERdguU8Q=;
 b=ON6gp/artNflu0D6S+eFqhgQqrcRJqPc2CTxYn/PQUY4TbUFFdFenuEnN7qeFpMU7n4D
 DCgs2PPwzmpBVr7J8X1GKBE5G6dwW6i1426CU9kqFJMtiyujCaPMzuJlcVj/4fLyNF6z
 bpI5qmjA0/XY3+Dtyg40EF2MhBvea6DwzbGgBXaYt+5HU2TMyloCAr+fIRTWXiCUYLAI
 gHrQqVz1zeQafDRHgSB/+nJ7YI1r3JZ7e6MCdGMhwEIGkM/2DbxYo8Cqig7WwsIBzplg
 84rNI3l7/+EZgdiEiBUvWZM6e4BU0eFoN6fIpl2E2LQ0UhRn/MqtB62JRPlbXVdYCqdp JQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47d5c1u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:36:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ODxXJ6014897;
        Mon, 24 Apr 2023 15:31:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3q477710fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:31:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OFVUqR37028176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 15:31:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F7A20043;
        Mon, 24 Apr 2023 15:31:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD58120040;
        Mon, 24 Apr 2023 15:31:25 +0000 (GMT)
Received: from tarunpc (unknown [9.43.70.159])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Apr 2023 15:31:25 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
In-Reply-To: <ZDmzyag88pO1Kdk8@casper.infradead.org>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
 <ZDmzyag88pO1Kdk8@casper.infradead.org>
Date:   Mon, 24 Apr 2023 21:01:21 +0530
Message-ID: <877cu15mba.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a_eVeiLGKeWZ_lcJSOZMPKnEumvBOeK-
X-Proofpoint-GUID: a_eVeiLGKeWZ_lcJSOZMPKnEumvBOeK-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=679
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mathew,

I am not sure If I was clear about my intention behind the patch.
Here, I attempt to answer it again. Please lemme know if you agree.

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Apr 15, 2023 at 01:18:32AM +0530, Tarun Sahu wrote:
>> folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
>> folio does not have any tail page to set order.
>
> I think you're missing the point of how folio_set_order() is used.
> When splitting a large folio, we need to zero out the folio_nr_pages
> in the tail, so it does have a tail page, and that tail page needs to
> be zeroed.  We even assert that there is a tail page:
>
>         if (WARN_ON_ONCE(!folio_test_large(folio)))
>                 return;
>
> Or maybe you need to explain yourself better.
>

In the upstream, I don't see folio_set_order(folio, 0) being called in
splitting path. IIUC, we had to zero out _folio_nr_pages during freeing
gigantic folio as described by Commit ba9c1201beaa
			 ("mm/hugetlb: clear compound_nr before freeing gigantic pages").

I agree that folio_set_order(folio, 0) is called with folio having
tail pages. But I meant only that, in general, it is just confusing to
have setting the folio order to 0.

With this patch, I would like to draw attention to the point that there
is no need to call folio_set_order(folio, 0) anymore to zero out
_folio_order and _folio_nr_pages.

In past, it was needed because page->mapping used to overlap with
_folio_nr_pages and _folio_order. So if these fields were left
uncleared during freeing gigantic hugepages, they were causing
"BUG: bad page state" due to non-zero page->mapping. Now, After
Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
CMA") page->mapping has explicitly been cleared out for tail pages.
Also, _folio_order and _folio_nr_pages no longer overlaps with page->mapping.

         struct page {
         ...
                        struct address_space * mapping;  /*    24     8 */
         ...
         }

         struct folio {
         ...
              union {
                 struct {
                        long unsigned int _flags_1;      /*    64     8 */
                        long unsigned int _head_1;       /*    72     8 */
                        unsigned char _folio_dtor;       /*    80     1 */
                        unsigned char _folio_order;      /*    81     1 */

                        /* XXX 2 bytes hole, try to pack */

                        atomic_t   _entire_mapcount;     /*    84     4 */
                        atomic_t   _nr_pages_mapped;     /*    88     4 */
                        atomic_t   _pincount;            /*    92     4 */
                        unsigned int _folio_nr_pages;    /*    96     4 */
                 };                                       /*    64    40 */
                struct page        __page_1 __attribute__((__aligned__(8))); /*    64    64 */
             }
         ...
         }

So, folio_set_order(folio, 0) can be removed from freeing gigantic
folio path (__destroy_compound_gigantic_folio).

Another place, where folio_set_order(folio, 0) is called inside
__prep_compound_gigantic_folio during error path. Here,
folio_set_order(folio, 0) can also be removed if we move
folio_set_order(folio, order) after for loop. Also, Mike confirmed that
it is safe to move the call.

~Tarun

>> folio->_folio_nr_pages is
>> set to 0 for order 0 in folio_set_order. It is required because
>> _folio_nr_pages overlapped with page->mapping and leaving it non zero
>> caused "bad page" error while freeing gigantic hugepages. This was fixed in
>> Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
>> pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
>> pages to CMA") now explicitly clear page->mapping and hence we won't see
>> the bad page error even if _folio_nr_pages remains unset. Also the order 0
>> folios are not supposed to call folio_set_order, So now we can get rid of
>> folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
>
> ... this is all very confusing.
>
>> The patch also moves _folio_set_head and folio_set_order calls in
>> __prep_compound_gigantic_folio() such that we avoid clearing them in the
>> error path.
>
> But don't we need those bits set while we operate on the folio to set it
> up?  It makes me nervous if we don't have those bits set because we can
> end up with speculative references that point to a head page while that
> page is not marked as a head page.  It may not be a problem, but I want
> to see some air-tight analysis of that.
>
>> Testing: I have run LTP tests, which all passes. and also I have written
>> the test in LTP which tests the bug caused by compound_nr and page->mapping
>> overlapping.
>> 
>> https://lore.kernel.org/all/20230413090753.883953-1-tsahu@linux.ibm.com/
>> 
>> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
>> on newer kernel and, also with this patch it passes.
>> 
>> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>> ---
>>  mm/hugetlb.c  | 9 +++------
>>  mm/internal.h | 8 ++------
>>  2 files changed, 5 insertions(+), 12 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f16b25b1a6b9..e2540269c1dc 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>  			set_page_refcounted(p);
>>  	}
>>  
>> -	folio_set_order(folio, 0);
>>  	__folio_clear_head(folio);
>>  }
>>  
>> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>  	struct page *p;
>>  
>>  	__folio_clear_reserved(folio);
>> -	__folio_set_head(folio);
>> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
>> -	folio_set_order(folio, order);
>>  	for (i = 0; i < nr_pages; i++) {
>>  		p = folio_page(folio, i);
>>  
>> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>  		if (i != 0)
>>  			set_compound_head(p, &folio->page);
>>  	}
>> +	__folio_set_head(folio);
>> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
>> +	folio_set_order(folio, order);
>>  	atomic_set(&folio->_entire_mapcount, -1);
>>  	atomic_set(&folio->_nr_pages_mapped, 0);
>>  	atomic_set(&folio->_pincount, 0);
>> @@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>  		p = folio_page(folio, j);
>>  		__ClearPageReserved(p);
>>  	}
>> -	folio_set_order(folio, 0);
>> -	__folio_clear_head(folio);
>>  	return false;
>>  }
>>  
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 18cda26b8a92..0d96a3bc1d58 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
>>   */
>>  static inline void folio_set_order(struct folio *folio, unsigned int order)
>>  {
>> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
>> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>>  		return;
>>  
>>  	folio->_folio_order = order;
>>  #ifdef CONFIG_64BIT
>> -	/*
>> -	 * When hugetlb dissolves a folio, we need to clear the tail
>> -	 * page, rather than setting nr_pages to 1.
>> -	 */
>> -	folio->_folio_nr_pages = order ? 1U << order : 0;
>> +	folio->_folio_nr_pages = 1U << order;
>>  #endif
>>  }
>>  
>> -- 
>> 2.31.1
>> 
