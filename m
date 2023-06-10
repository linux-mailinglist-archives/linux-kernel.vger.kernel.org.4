Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D172A982
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjFJGus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFJGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 02:50:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E43A96
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 23:50:44 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35A6m0OW026791;
        Sat, 10 Jun 2023 06:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=9KgI/yR+aq24mmtwuyPThyCJd707Xtg4oppDr5emJrk=;
 b=qSpiITNSiCrg8oF8shIgfl5I73JO24kAnnyInJQ9LO49LoApYhh4cYTSExAPN4boQ/Gh
 juUF5IKYiOSYZ44gBkCJ81fAsC14NuXMbROZn2mRPBIFsiVsHCMn0SAlvX15GL91PCU/
 HxrNxK+aiOJ5ULYopYVdPAV+XMloXHHzlmm+q9TLZxpZ5g9HcaGIWKNvGEMnAZapblJ8
 GMsULKsob/sMF+Upnif1Ty3xcQqP1pMW0Yx2LRT4a+0g51QkPl6sEMGYV2zCoUG22X/t
 2MqZ7fba6Ec90GoTOcxHcQ6kdEqo5OiHYdzKYH1fcSdps40oCjPkBwbQv8LPi/hVkV2Y ZQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r4m7h81qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jun 2023 06:50:29 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35A6edlc009424;
        Sat, 10 Jun 2023 06:50:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r4gt4r2xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jun 2023 06:50:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35A6oN1a59572534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jun 2023 06:50:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B75D720043;
        Sat, 10 Jun 2023 06:50:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F18A320040;
        Sat, 10 Jun 2023 06:50:21 +0000 (GMT)
Received: from tarunpc (unknown [9.43.84.45])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Jun 2023 06:50:21 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        sidhartha.kumar@oracle.com, gerald.schaefer@linux.ibm.com,
        linux-kernel@vger.kernel.org, jaypatel@linux.ibm.com
Subject: Re: [PATCH v3] mm/folio: Avoid special handling for order value 0
 in folio_set_order
In-Reply-To: <20230609112944.fc08936beb29a18f7bfb5ae3@linux-foundation.org>
References: <20230609162907.111756-1-tsahu@linux.ibm.com>
 <20230609112944.fc08936beb29a18f7bfb5ae3@linux-foundation.org>
Date:   Sat, 10 Jun 2023 12:20:20 +0530
Message-ID: <87ilbverpv.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n7mibCUA91808dtpVYJZBlKzMX6dDCmA
X-Proofpoint-ORIG-GUID: n7mibCUA91808dtpVYJZBlKzMX6dDCmA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-10_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=952 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306100054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

TLDR: It is not bug fix, it is just cleanup.

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri,  9 Jun 2023 21:59:07 +0530 Tarun Sahu <tsahu@linux.ibm.com> wrote:
>
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
>> 
>> So, folio_set_order(folio, 0) can be removed from freeing gigantic
>> folio path (__destroy_compound_gigantic_folio).
>
> The above appears to be a code cleanup only?
yes,
>
>> Another place, folio_set_order(folio, 0) is called inside
>> __prep_compound_gigantic_folio during error path. Here,
>> folio_set_order(folio, 0) can also be removed if we move
>> folio_set_order(folio, order) after for loop.
>> 
>> The patch also moves _folio_set_head call in __prep_compound_gigantic_folio()
>> such that we avoid clearing them in the error path.
>
> And the above also sounds like a code cleanup.
yes
>
>> Also, as Mike pointed out:
>> "It would actually be better to move the calls _folio_set_head and
>> folio_set_order in __prep_compound_gigantic_folio() as suggested here. Why?
>> In the current code, the ref count on the 'head page' is still 1 (or more)
>> while those calls are made. So, someone could take a speculative ref on the
>> page BEFORE the tail pages are set up."
>> 
>> This way, folio_set_order(folio, 0) is no more needed. And it will also
>> helps removing the confusion of folio order being set to 0 (as _folio_order
>> field is part of first tail page).
>> 
>> Testing: I have run LTP tests, which all passes. and also I have written
>> the test in LTP which tests the bug caused by compound_nr and page->mapping
>> overlapping.
>
> What bug?  Please describe the end-user visible effects of any bug.
>
> And if a bug is indeed fixed, please let's try to identify a Fixes:
> target and let's decide whether a -stable backport is needed.
>
> Thanks.
>
No bug fixed here,
The above cleanup modifies the code which touches the code path
that a past patch had added to resolve the bug. The above test
just check if the resolution is not affected.

>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
>> 
>> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
>> on newer kernel and, also with this patch it passes.
>> 
