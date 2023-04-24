Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02516ED197
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjDXPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDXPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:41:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ECE1FC8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:41:23 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OFc7BU006466;
        Mon, 24 Apr 2023 15:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=U0CtoThiXz2wxMy2XF0vQyYLjU+i6XI3Wmus8K9U950=;
 b=D3LbjG/boL5qxTiGXgHaiGjIXItHIxTMmJmzDgs1RTwY8nP3cAxXgo+C9O+Ba+hRHery
 vMIh/uyDI4TyiyMzMdvA0CEn8zAPaa/to6NTnxWiudLn2Ktj+IKpekGefxuhPvuR1gvE
 XYDqJI1yOVjBMYbhnFyU+dQT/94qhP3dt+4/wgNGFrPhMTEdVPGdWb73FxBuh8vsoLbt
 JNw+WFQwvCKuGS9XFot42fMKadlMLHn0jhw3zUADj6PT8gY8rBZg3UTaZrFzNGTIMN6a
 oofFZARGBEZp/rkg4wcVWqFwYAuGhiWrYmcm0W+2TWk7yR975mo7k92Qof3Vg5O//phw 3Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q44shbt6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:40:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ODwbvJ013941;
        Mon, 24 Apr 2023 15:40:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3q477710j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:40:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OFeVUQ38076960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 15:40:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0A392004E;
        Mon, 24 Apr 2023 15:40:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FD1920043;
        Mon, 24 Apr 2023 15:40:27 +0000 (GMT)
Received: from tarunpc (unknown [9.43.70.159])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Apr 2023 15:40:27 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, aneesh.kumar@linux.ibm.com,
        sidhartha.kumar@oracle.com, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
In-Reply-To: <20230418185608.GA4907@monkey>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
 <ZDmzyag88pO1Kdk8@casper.infradead.org> <20230418185608.GA4907@monkey>
Date:   Mon, 24 Apr 2023 21:10:23 +0530
Message-ID: <87354p5lw8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RNBNXkbhs_OfGn5MUcNJ73E3u2q0944m
X-Proofpoint-ORIG-GUID: RNBNXkbhs_OfGn5MUcNJ73E3u2q0944m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304240140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike,


Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 04/14/23 21:12, Matthew Wilcox wrote:
>> On Sat, Apr 15, 2023 at 01:18:32AM +0530, Tarun Sahu wrote:
>> > folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
>> > folio does not have any tail page to set order.
>> 
>> I think you're missing the point of how folio_set_order() is used.
>> When splitting a large folio, we need to zero out the folio_nr_pages
>> in the tail, so it does have a tail page, and that tail page needs to
>> be zeroed.  We even assert that there is a tail page:
>> 
>>         if (WARN_ON_ONCE(!folio_test_large(folio)))
>>                 return;
>> 
>> Or maybe you need to explain yourself better.
>> 
>> > folio->_folio_nr_pages is
>> > set to 0 for order 0 in folio_set_order. It is required because
>> > _folio_nr_pages overlapped with page->mapping and leaving it non zero
>> > caused "bad page" error while freeing gigantic hugepages. This was fixed in
>> > Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
>> > pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
>> > pages to CMA") now explicitly clear page->mapping and hence we won't see
>> > the bad page error even if _folio_nr_pages remains unset. Also the order 0
>> > folios are not supposed to call folio_set_order, So now we can get rid of
>> > folio_set_order(folio, 0) from hugetlb code path to clear the confusion.
>> 
>> ... this is all very confusing.
>> 
>> > The patch also moves _folio_set_head and folio_set_order calls in
>> > __prep_compound_gigantic_folio() such that we avoid clearing them in the
>> > error path.
>> 
>> But don't we need those bits set while we operate on the folio to set it
>> up?  It makes me nervous if we don't have those bits set because we can
>> end up with speculative references that point to a head page while that
>> page is not marked as a head page.  It may not be a problem, but I want
>> to see some air-tight analysis of that.
>
> I am fairly certain we are 'safe'.  Here is code before setting up the
> pointer to the head page.
>
> 		 * In the case of demote, the ref count will be zero.
> 		 */
> 		if (!demote) {
> 			if (!page_ref_freeze(p, 1)) {
> 				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> 				goto out_error;
> 			}
> 		} else {
> 			VM_BUG_ON_PAGE(page_count(p), p);
> 		}
> 		if (i != 0)
> 			set_compound_head(p, &folio->page);
>
> So, before setting the pointer to head page ref count will be zero.
>
> I 'think' it would actually be better to move the calls to _folio_set_head and
> folio_set_order in __prep_compound_gigantic_folio() as suggested here.  Why?
> In the current code, the ref count on the 'head page' is still 1 (or more)
> while those calls are made.  So, someone could take a speculative ref on the
> page BEFORE the tail pages are set up.
>

Thanks, for confirming the correctness of moving these calls. Also I
didn't look at it this way while moving them. Thanks for the comment.
I will update the commit msg and send the v2.

~Tarun

> TBH, I do not have much of an opinion about potential confusion surrounding
> folio_set_compound_order(folio, 0).  IIUC, hugetlb gigantic page setup is the
> only place outside the page allocation code that sets up compound pages/large
> folios.  So, it is going to be a bit 'special'.  As mentioned,  when this was
> originally discussed I suggested folio_clear_order().  I would be happy with
> either.


> -- 
> Mike Kravetz
