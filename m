Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959B6E5CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDRJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:04:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8776EAF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:04:16 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7x40q007940;
        Tue, 18 Apr 2023 09:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=cLUCbO9BN7YPrI7AZKdF/UR6kAj/itrU2X4bzRJqNNI=;
 b=fCbz+Lwd7cXZICqI1rajG1j0UsH2VFJyhsLZ83f16peiDfYQxnLutUjh1xDLdaF5nqsl
 9XnwYmyC3k8OAsZGHixZMMZ7SxbZeCHJqQsa4VBonpSniR9ezHajvtIXmn8vfJMHiwRm
 +7JN+NcTSSsBj+F+Clm/YBhMk85sIojPL0pnxx69aOU/8w6lX1jYPMYhy/j0QcRcHuoB
 Qx++amRRoCWNHw/owVLl4OApU/fSnvGdMONF7o9hhCL76FAHBfAbjcv1wyAkRZiVPRxF
 fnnJ8fzCkYKbmZVDNY8ZE2WSL/mbLlKyGaeWpJ+dYnpbDatOo2/iI6QXn6+A6ELgFbco SA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1n9rnt87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:03:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I2L3KY025128;
        Tue, 18 Apr 2023 09:03:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pykj69jpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:03:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I93qsp20775580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:03:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0FAB2004B;
        Tue, 18 Apr 2023 09:03:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2463920043;
        Tue, 18 Apr 2023 09:03:50 +0000 (GMT)
Received: from tarunpc (unknown [9.124.31.73])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 09:03:49 +0000 (GMT)
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
Date:   Tue, 18 Apr 2023 14:33:48 +0530
Message-ID: <878repa7ez.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ELLHBN8sDFOaa1JiZ3Jbf1T9IGsI7flI
X-Proofpoint-GUID: ELLHBN8sDFOaa1JiZ3Jbf1T9IGsI7flI
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

Matthew Wilcox <willy@infradead.org> writes:

Hi Mathew,
Thanks for reviewing. please find my comments inline.

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

Yes, I understand, folio_set_order(order, 0) is called to clear out
tail pages folio_order/folio_nr_pages. With this patch, I am trying
to convey two things:-
 1. It is not necessary to clear out these field if page->mapping is
 being explicitly updated. I explain this below [EXP].

 2. folio_set_order(order, 0) now currently being used to clear
 folio_order and folio_nr_pages which is ok. But looking at
 folio_set_order(folio, 0) is confusing as setting order 0 implies that
 only 1 page in folio. and folio_order and folio_nr_pages are part of
 first tail page. IIRC, there was a discussion to use folio_clear_order
 to avoid such confusion. But if above point 1 deemed to be correct, there
 will not be any need of this too.

**[EXP]**
IIUC, during splitting, page->mapping is updated
explicitly for tail pages. There is no code path I see, where
folio_set_order(order, 0) or set_compound_order(head, 0) is called
except below two places.

  1. __destroy_compound_gigantic_folio
       Here, in past there was a problem when struct page used to have
       compound_nr field which used to overlap with page->mapping. So
       while freeing, it was necessary to explicitly clear out
       compound_nr. Which was taken care by Commit ba9c1201beaa
       ("mm/hugetlb: clear compound_nr before freeing gigantic pages").

       But after, Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
       pages to CMA"), page->mapping has explicitly been cleared out for
       all tail pages.

           	for (i = 1; i < nr_pages; i++) {
            		p = folio_page(folio, i);
                p->mapping = NULL;    <======== (Here)
                clear_compound_head(p);
                if (!demote)
                   set_page_refcounted(p);
                }
            folio_set_order(folio, 0); <== this line can be removed.

   2. __prep_compound_gigantic_folio
        Here, folio_set_order(folio, 0) is called in error path only.
        which can be avoided if we call folio_set_order(folio, order)
        after the for loop.
        I am new to memory allocators. But as far as I could understood by
        looking at past discussion around this function [1][2], During RCU
        grace period there could be a race condition causing ref count
        inflation. But IIUC, that doesn't have any dependency on newly
        allocated gigantic page except that the ref count might be taken
        by folio_ref_try_add_rcu for the same page/s which will cause
        prep_compound_gigantic_folio to fail. So IMHO, it will be ok to
        move __folio_set_head and folio_set_order after the for loop.
        Here, Just for reference, below I copy pasted the *for loop*,
        from before, I am moving these two calls to after this.

	for (i = 0; i < nr_pages; i++) {
		p = folio_page(folio, i);

		if (i != 0)	/* head page cleared above */
			__ClearPageReserved(p);
		if (!demote) {
			if (!page_ref_freeze(p, 1)) {
				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
				goto out_error;
			}
		} else {
			VM_BUG_ON_PAGE(page_count(p), p);
		}
		if (i != 0)
			set_compound_head(p, &folio->page);
	}

I also tested it with triggering demotion of gigantic hugepages to PMD
hugepages.

$ echo 5 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
$ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
5
$ cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
0
$ echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
$ cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
512

I am quite new to field. Please correct me if I understood it
differently than it is. Also if I didn't consider other code path
for its consideration.

[1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/
[2] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com/T/#u

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

Sorry, for this. Lemme know if above explanation [EXP] is clear.

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
