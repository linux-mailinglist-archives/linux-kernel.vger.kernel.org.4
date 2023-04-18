Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB186E5D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDRJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRJUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:20:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358C7D9B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:20:29 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I8UfdO021034;
        Tue, 18 Apr 2023 09:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=f8X+nCi+Oqu2ZlXCnEULmNZCSP6X8mECebtez0mWJ/E=;
 b=k9pFMRp1WIA/DaEigMvHzOmOgLmn8SWZLQ7qRKDELawUap/owWF3WoVsznAPYDMiofEw
 GYv/gLz9CwJuvZpBnn1eaIccw5hZzO3q3r9To46Iblcr2ZYb2T5fMVS+m8pU0p9pz6WF
 /HuECBlWoZrfgsLksol4Z8yLT45S648WL+KsIqr7BoOiqL23Njqj++39gsMhscKhEwLv
 9NLDapKXahJhCmGD0Uh0EpYYf6K3jPvkaoSIQxji4jRoSVpD1t3idQTnn2hdG7miYFEc
 w9ikMSgZvYT1JvJIKutrVXlEFI69UTJmvSracFZSws0/nechXuDPKqkbUAILcY2/eVDk rw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1nwrd11a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:20:17 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33I3k5Gf007036;
        Tue, 18 Apr 2023 09:20:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pykj6hjnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:20:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33I9KB4L37618090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:20:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 624C820043;
        Tue, 18 Apr 2023 09:20:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925F02004D;
        Tue, 18 Apr 2023 09:20:09 +0000 (GMT)
Received: from tarunpc (unknown [9.124.31.73])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 09:20:09 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
In-Reply-To: <832d2b34-d18d-dbc3-1836-2d3e3381afcc@oracle.com>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
 <832d2b34-d18d-dbc3-1836-2d3e3381afcc@oracle.com>
Date:   Tue, 18 Apr 2023 14:50:07 +0530
Message-ID: <875y9ta6ns.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o3ziwvP1IGURvM5ujzr4Z8M2a0PLjF80
X-Proofpoint-GUID: o3ziwvP1IGURvM5ujzr4Z8M2a0PLjF80
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,

Thanks for your inputs, please find my comments inline

> On 4/14/23 12:48 PM, Tarun Sahu wrote:
>> folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
>> folio does not have any tail page to set order. folio->_folio_nr_pages is
>> set to 0 for order 0 in folio_set_order. It is required because
>
> In the previous discussion of this function, Mike mentioned having 
> folio_set_order() be used for non-zero orders and adding a 
> folio_clear_order() that is used to set order to 0. This could be done 
> to reduce confusion.
>
Yes, I agree, I replied to Mathew reply to this thread, Lemme know your
thought on this. In this patch, I proposed that there won't be need of
folio_clear_order if folio_set_order(folio, 0) is not needed with minor
changes in code path.

>> _folio_nr_pages overlapped with page->mapping and leaving it non zero
>> caused "bad page" error while freeing gigantic hugepages. This was fixed in
>> Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
>> pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
>> pages to CMA") now explicitly clear page->mapping and hence we won't see
>> the bad page error even if _folio_nr_pages remains unset. Also the order 0
>> folios are not supposed to call folio_set_order, So now we can get rid of
>> folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
>> 
>> The patch also moves _folio_set_head and folio_set_order calls in
>> __prep_compound_gigantic_folio() such that we avoid clearing them in the
>> error path.
>> 
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
>>   mm/hugetlb.c  | 9 +++------
>>   mm/internal.h | 8 ++------
>>   2 files changed, 5 insertions(+), 12 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f16b25b1a6b9..e2540269c1dc 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>   			set_page_refcounted(p);
>>   	}
>>   
>> -	folio_set_order(folio, 0);
>>   	__folio_clear_head(folio);
>>   }
>>   
>> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>   	struct page *p;
>>   
>>   	__folio_clear_reserved(folio);
>> -	__folio_set_head(folio);
>> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
>> -	folio_set_order(folio, order);
>>   	for (i = 0; i < nr_pages; i++) {
>>   		p = folio_page(folio, i);
>>   
>> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>   		if (i != 0)
>>   			set_compound_head(p, &folio->page);
>>   	}
>
> calling set_compound_head() for the tail page before the folio has the 
> head flag set could seem misleading. At this point order is not set as 
> well so it is not clear that the folio is a compound page folio.
>
Yeah, I agree, But they are part of same call. I can avoid moving
__folio_set_head. And I think, It wont mislead if I avoid moving
__folio_set_head. Below function has the similar path.

void prep_compound_page(struct page *page, unsigned int order)
{
	int i;
	int nr_pages = 1 << order;

	__SetPageHead(page);
	for (i = 1; i < nr_pages; i++)
		prep_compound_tail(page, i);

	prep_compound_head(page, order);
}

Lemme know you thoughts.


~Tarun

>> +	__folio_set_head(folio);
>> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
>> +	folio_set_order(folio, order);
>>   	atomic_set(&folio->_entire_mapcount, -1);
>>   	atomic_set(&folio->_nr_pages_mapped, 0);
>>   	atomic_set(&folio->_pincount, 0);
>> @@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>   		p = folio_page(folio, j);
>>   		__ClearPageReserved(p);
>>   	}
>> -	folio_set_order(folio, 0);
>> -	__folio_clear_head(folio);
>>   	return false;
>>   }
>>   
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 18cda26b8a92..0d96a3bc1d58 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
>>    */
>>   static inline void folio_set_order(struct folio *folio, unsigned int order)
>>   {
>> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
>> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>>   		return;
>>   
>>   	folio->_folio_order = order;
>>   #ifdef CONFIG_64BIT
>> -	/*
>> -	 * When hugetlb dissolves a folio, we need to clear the tail
>> -	 * page, rather than setting nr_pages to 1.
>> -	 */
>> -	folio->_folio_nr_pages = order ? 1U << order : 0;
>> +	folio->_folio_nr_pages = 1U << order;
>>   #endif
>>   }
>>   
