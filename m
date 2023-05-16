Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1E7704EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjEPNJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjEPNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:09:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BBE5A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:09:37 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GD8soS007201;
        Tue, 16 May 2023 13:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=nxzlSFyM1UfLWBpMcq3UIm35aq+DbuE26Lnn/akAZ+I=;
 b=nW7C0Bg4E1f/rxu6QWAzs8Zyyf+NOTjzz6ZVecIAT439ZQoCQIGytyYXmqVu+xn6bSqQ
 jTuUeF18T8dwd8m1ACLpLT8H5wDP5wIxA3uKNGdpdZD4dCDQohQ4tNSv2XGsPAsKJqzY
 LBrp5WUYLJHLmX0J0wcUKEMJg0fk+NAnD2YKPqNr8VwPS8AlgaeHCb0c9MmWmO4czlfl
 o/oTX6Tdq9cmluqUYxs5WhxebvZ/mhCVjlHATtfiy41L3ehI6YWmC0ykQUlufmdIdMMw
 Tf5IuyGHjNcW7NMW5zLnvUwssu9tU4GVIInxElVL/tfZajB+IDPHkOTEMKmvihzbiRC6 nw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm9akafr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:09:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1c0nk027917;
        Tue, 16 May 2023 13:09:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sn5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:09:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GD9FAk9437940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 13:09:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B7BC20049;
        Tue, 16 May 2023 13:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45F2D20043;
        Tue, 16 May 2023 13:09:13 +0000 (GMT)
Received: from tarunpc (unknown [9.199.157.25])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 16 May 2023 13:09:12 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0
 in folio_set_order
In-Reply-To: <ZGJo4UhdyakGFwP7@casper.infradead.org>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
 <ZGJo4UhdyakGFwP7@casper.infradead.org>
Date:   Tue, 16 May 2023 18:39:11 +0530
Message-ID: <87fs7wqv7s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBal4JNQ1_zjIOHk7A1PNZgOgWx31HNL
X-Proofpoint-ORIG-GUID: aBal4JNQ1_zjIOHk7A1PNZgOgWx31HNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, May 15, 2023 at 10:38:09PM +0530, Tarun Sahu wrote:
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
>
> This makes me nervous, as I said before.  This means that
> compound_head(tail) can temporarily point to a page which is not marked
> as a head page.  That's different from prep_compound_page().  You need to
> come up with some good argumentation for why this is safe, and no amount
> of testing you do can replace it -- any race in this area will be subtle.

IIUC, I am certain that it is safe to move these calls and agree with what
Mike said. Here is my reasoning:

When we get pages from CMA allocator for gigantic folio, page refcount
for each pages is 1.
page_cache_get_speculative (now folio_try_get_rcu) can take reference to
any of these pages before prep_compound_gigantic_folio explicitly freeze
refcount of these pages. With this race condition there are 2 possible situation.

...
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
...

1. In the current code, before freezing refcount of nth (hence, n+th)
tail page, folio_try_get_rcu might try to take nth tail page reference,
so refcount will be increased of the nth tail page not the head page
(as compound head is not yet set for nth tail page). and once this
happens, nth iteration of loop will cause error and
prep_compound_gigantic_folio will fail.

So, setting the PG_head at the starting of for-loop or at the end won't
have any difference to this flow.

2. If reference for the head page is taken by folio_try_get_rcu before
freezing it, prep_compound_gigantic_page will fail, but before PG_head
and folio_order of head page is cleared in error path, the caller of
folio_try_get_rcu path will find that this page is head page and might
try to operate on its tail pages while these tail pages are invalid.

Hence, It will be safer if we call __folio_set_head and folio_set_order
after freezing the tail page refcount.

~Tarun
