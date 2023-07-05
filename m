Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7A7486CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGEOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjGEOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:49:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA551700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:49:30 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Eh2hO021200;
        Wed, 5 Jul 2023 14:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=WyaIkawPUgvUam9x7fxaH1KDyVHLZ56/mYgS6vFRDvY=;
 b=rL1KxvECs4gBlAraHVKti+fP17gqaJseIidr7e5WQbIjwqHL+5G5orBz1SUOSLVO3qJi
 g9NQkA1YVKK3IqZEHDjeJWoK/VrQoLc1wCNjseviI+bDz6pxBhjAys1kBQWXU6YF+m6Y
 vUrrOICmNwDrYgdLxX4VA8LKmfJtfqF62bZySMU0XA1RbqZF6LrYuWQB+lp4tFlPIscQ
 8Yo79+XZuAJ3lOqe0LCRH1pCWnEeZnM1g9zap9DUSNuplR8LfGIzDaddCgIkAPEKRcZT
 2QxmBPeEZDdr1CZ/ZkMPc1n3snfnMsRSL82rFOmXwOwkNO9Ewyv5asUOobP14KdoI7hK oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rna57rxke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:48:32 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365EhM9E024531;
        Wed, 5 Jul 2023 14:48:29 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rna57rxjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:48:29 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365CoN9k016498;
        Wed, 5 Jul 2023 14:48:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6fdh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:48:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365EmQWt35455680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:48:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B22A5805A;
        Wed,  5 Jul 2023 14:48:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B182B58051;
        Wed,  5 Jul 2023 14:48:14 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.47.143])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:48:14 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to fail
In-Reply-To: <8218ffdc-8be-54e5-0a8-83f5542af283@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <8218ffdc-8be-54e5-0a8-83f5542af283@google.com>
Date:   Wed, 05 Jul 2023 20:18:12 +0530
Message-ID: <87y1juxvmb.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GDmSVGrS8syCV2n7TgQ4YZtWM0lquLyc
X-Proofpoint-ORIG-GUID: 4X2trLtTkHXz7Z42SusOeEbcViwHSz6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=949 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hugh,

Sorry for not checking about this before. I am looking at a kernel
crash (BUG_ON()) on ppc64 with 4K page size. The reason we hit
BUG_ON() is beause we have pmd_same calling BUG_ON on 4K with hash
translation. We don't support THP with 4k page size and hash
translation.

Hugh Dickins <hughd@google.com> writes:

....

 +
> +pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
> +			     unsigned long addr, spinlock_t **ptlp)
> +{
> +	pmd_t pmdval;
> +	pte_t *pte;
> +
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (likely(pte))
> +		*ptlp = pte_lockptr(mm, &pmdval);
> +	return pte;
> +}
> +
> +pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> +			     unsigned long addr, spinlock_t **ptlp)
> +{
> +	spinlock_t *ptl;
> +	pmd_t pmdval;
> +	pte_t *pte;
> +again:
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (unlikely(!pte))
> +		return pte;
> +	ptl = pte_lockptr(mm, &pmdval);
> +	spin_lock(ptl);
> +	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> +		*ptlp = ptl;
> +		return pte;
> +	}
> +	pte_unmap_unlock(pte, ptl);
> +	goto again;
> +}

What is expected by that pmd_same check? We are holding pte lock
and not pmd lock. So contents of pmd can change.

-aneesh
