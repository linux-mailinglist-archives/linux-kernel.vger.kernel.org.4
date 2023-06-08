Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2B727C22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjFHKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjFHKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:03:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385BE26BA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:03:41 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589lT5t016495;
        Thu, 8 Jun 2023 10:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=NMCDrIEjeqQt3g9jyHRz2b+33HhyRjMpvM6Mnx4gPM8=;
 b=H5RltpcI/VGIjF2tualunxEnzkhE20Qt+p9NRvNML5rhi5DB49zGjTLgAW7S0ga8H9qz
 FlAqYKEWq+Y2rTKloTHH/UgUFw0bGDTZdDRvR5zx2PVZcoukSfYkQnuv9YZEPsjAEz+d
 9YmGxjq4cNMSTLqJJWF3MVhbSauaLD+mJ8a2yrSyQuldftSeaT2fQAU1vDHLHzE/zjqs
 oiMZEqaMwEtUi9wfxS/6on4tdArpiOohh8GGnZgffNwh0hK2gLxK5R2QVE/mdylz7YE8
 n/E6pvJN0cUgr77xu82HuOovscJpQARlIU6KTTAl5KwA3lHoc4uXKotQv+0o7EXrvGbW hA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3cnt0a0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:03:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mo1vp031959;
        Thu, 8 Jun 2023 10:03:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r2a78s6nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:03:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 358A3JrY43451080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 10:03:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E624320040;
        Thu,  8 Jun 2023 10:03:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A837D20043;
        Thu,  8 Jun 2023 10:03:16 +0000 (GMT)
Received: from tarunpc (unknown [9.199.157.25])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Jun 2023 10:03:16 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0
 in folio_set_order
In-Reply-To: <20230606155853.GA4150@monkey>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
 <20230606155853.GA4150@monkey>
Date:   Thu, 08 Jun 2023 15:33:14 +0530
Message-ID: <873532jmot.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87w6SABi58B6ofwgrTDDN8oy51g7oihs
X-Proofpoint-ORIG-GUID: 87w6SABi58B6ofwgrTDDN8oy51g7oihs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Please find my comments inline.

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 06/06/23 10:32, Tarun Sahu wrote:
>>                                        
>> Hi Mike,              
>>     
>> Thanks for your inputs.                          
>> I wanted to know if you find it okay, Can I send it again adding your Reviewed-by?
>
> Hi Tarun,
>
> Just a few more comments/questions.
>
> On 05/15/23 22:38, Tarun Sahu wrote:
>> folio_set_order(folio, 0) is used in kernel at two places
>> __destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
>> Currently, It is called to clear out the folio->_folio_nr_pages and
>> folio->_folio_order.
>> 
>> For __destroy_compound_gigantic_folio:
>> In past, folio_set_order(folio, 0) was needed because page->mapping used
>> to overlap with _folio_nr_pages and _folio_order. So if these fields were
>> left uncleared during freeing gigantic hugepages, they were causing
>> "BUG: bad page state" due to non-zero page->mapping. Now, After
>> Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
>> CMA") page->mapping has explicitly been cleared out for tail pages. Also,
>> _folio_order and _folio_nr_pages no longer overlaps with page->mapping.
>
> I believe the same logic/reasoning as above also applies to
> __prep_compound_gigantic_folio.
> Why?
> In __prep_compound_gigantic_folio we only call folio_set_order(folio, 0)
> in the case of error.  If __prep_compound_gigantic_folio fails, the caller
> will then call free_gigantic_folio() on the "gigantic page".  However, it is
> not really a gigantic  at this point in time, and we are simply calling
> cma_release() or free_contig_range().
> The end result is that I do not believe the existing call to
> folio_set_order(folio, 0) in __prep_compound_gigantic_folio is actually
> required.  ???
No, there is a difference. IIUC, __destroy_compound_gigantic_folio
explicitly reset page->mapping for each page of compound page which
makes sure, even if in future some fields of struct page/folio overlaps
with page->mapping, it won't cause `BUG: bad page state` error. But If we
just remove folio_set_order(folio, 0) from __prep_compound_gigantic_folio
without moving folio_set_order(folio, order), this will cause extra
maintenance overhead to track if page->_folio_order overlaps with
page->mapping everytime struct page fields are changed. As in case of
overlapping page->mapping will be non-zero. IMHO, To avoid it,
moving the folio_set_order(folio, order) after all error checks are
done on tail pages. So, _folio_order is either set on success and not
set in case of error. (which is the original proposal). But for
folio_set_head, I agree the way you suggested below.

WDYT?

>
> If my reasoning above is correct, then we could just have one patch to
> remove the folio_set_order(folio, 0) calls and remove special casing for
> order 0 in folio_set_order.
>
> However, I still believe your restructuring of __prep_compound_gigantic_folio,
> is of value.  I do not believe there is an issue as questioned by Matthew.  My
> reasoning has been stated previously.  We could make changes like the following
> to retain the same order of operations in __prep_compound_gigantic_folio and
> totally avoid Matthew's question.  Totally untested.
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea24718db4af..a54fee663cb1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1950,10 +1950,8 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	int nr_pages = 1 << order;
>  	struct page *p;
>  
> -	__folio_clear_reserved(folio);
> -	__folio_set_head(folio);
>  	/* we rely on prep_new_hugetlb_folio to set the destructor */
> -	folio_set_order(folio, order);
> +
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -1969,7 +1967,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		 * on the head page when they need know if put_page() is needed
>  		 * after get_user_pages().
>  		 */
> -		if (i != 0)	/* head page cleared above */
> +		if (i != 0)	/* head page cleared below */
>  			__ClearPageReserved(p);
>  		/*
>  		 * Subtle and very unlikely
> @@ -1996,8 +1994,14 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		} else {
>  			VM_BUG_ON_PAGE(page_count(p), p);
>  		}
> -		if (i != 0)
> +
> +		if (i == 0) {
> +			__folio_clear_reserved(folio);
> +			__folio_set_head(folio);
> +			folio_set_order(folio, order);
With folio_set_head, I agree to this, But does not feel good with
folio_set_order as per my above reasoning. WDYT?

> +		} else {
>  			set_compound_head(p, &folio->page);
> +		}
>  	}
>  	atomic_set(&folio->_entire_mapcount, -1);
>  	atomic_set(&folio->_nr_pages_mapped, 0);
> @@ -2017,7 +2021,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		p = folio_page(folio, j);
>  		__ClearPageReserved(p);
>  	}
> -	folio_set_order(folio, 0);
>  	__folio_clear_head(folio);
>  	return false;
>  }
>
>
>> 
>> struct page {
>> ...
>>    struct address_space * mapping;  /* 24     8 */
>> ...
>> }
>> 
>> struct folio {
>> ...
>>     union {
>>         struct {
>>         	long unsigned int _flags_1;      /* 64    8 */
>>         	long unsigned int _head_1;       /* 72    8 */
>>         	unsigned char _folio_dtor;       /* 80    1 */
>>         	unsigned char _folio_order;      /* 81    1 */
>> 
>>         	/* XXX 2 bytes hole, try to pack */
>> 
>>         	atomic_t   _entire_mapcount;     /* 84    4 */
>>         	atomic_t   _nr_pages_mapped;     /* 88    4 */
>>         	atomic_t   _pincount;            /* 92    4 */
>>         	unsigned int _folio_nr_pages;    /* 96    4 */
>>         };                                       /* 64   40 */
>>         struct page __page_1 __attribute__((__aligned__(8))); /* 64   64 */
>>     }
>> ...
>> }
>
> I do not think the copy of page/folio definitions adds much value to the
> commit message.
Yeah, Will remove it.
>
> -- 
> Mike Kravetz
