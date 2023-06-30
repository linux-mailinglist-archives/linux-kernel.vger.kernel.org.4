Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5528B743CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjF3NkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjF3NkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:40:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEC1FE8;
        Fri, 30 Jun 2023 06:40:05 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UDXtkF024475;
        Fri, 30 Jun 2023 13:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=MILFYyEh0bzy33IA0yZToAfVYRzb2Mhl3gp0isRO4pM=;
 b=WWpOuUBll0GcMgF6UkEAPv1U/0AELyMv08YfNFH5QWoGlgD30nDBbxmr3vbfSbir1zDF
 v1n3VFiHTI2iKdl0ajnyVN8bMun8YmP3twJ0zeA20CJqamSbFHDi0WTEGFk62XbzPkt+
 3sQv6xziupU8flvhfEio8DJeUkwPyzL/3LA2kAIq72vI2CbDVcUIXbqzP5IohDPsH4/K
 nxBzmnoEp2WjhyoNKxCZ0dgzhxUGvSu0SNRrFBSAmnnreNuicuHYPiLqqUjRWB61jY4q
 YJ78SFBrwbAkYFxbT96VF4dSAcOaIN/gb7fOJsJGxvv6qHAnXFv+w90Oi5zo4zs12bA4 wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj01vr5v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:39:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDXvp4024557;
        Fri, 30 Jun 2023 13:39:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj01vr5rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:39:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4eiGQ004048;
        Fri, 30 Jun 2023 13:38:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr45463d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:38:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35UDctix16253646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 13:38:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6250B2004F;
        Fri, 30 Jun 2023 13:38:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C36332004E;
        Fri, 30 Jun 2023 13:38:53 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jun 2023 13:38:53 +0000 (GMT)
Date:   Fri, 30 Jun 2023 15:38:52 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables
 sharing page
Message-ID: <20230630153852.31163592@p-imbrenda>
In-Reply-To: <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EBLZMsFsdvv19REZEqy1DFVn4Lc2XsWt
X-Proofpoint-GUID: t0PdQmyDLcbJVGOB3mJ29fow46RM-DV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 00:51:19 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

[...]

> @@ -407,6 +429,77 @@ void __tlb_remove_table(void *_table)
>  	__free_page(page);
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void pte_free_now0(struct rcu_head *head);
> +static void pte_free_now1(struct rcu_head *head);
> +
> +static void pte_free_pgste(struct rcu_head *head)
> +{
> +	unsigned long *table;
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	table = (unsigned long *)page_to_virt(page);
> +	table = (unsigned long *)((unsigned long)table | 0x03U);
> +	__tlb_remove_table(table);
> +}
> +
> +static void pte_free_half(struct rcu_head *head, unsigned int bit)
> +{
> +	unsigned long *table;
> +	struct page *page;
> +	unsigned int mask;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	mask = atomic_xor_bits(&page->_refcount, 0x04U << (bit + 24));
> +
> +	table = (unsigned long *)page_to_virt(page);
> +	table += bit * PTRS_PER_PTE;
> +	table = (unsigned long *)((unsigned long)table | (0x01U << bit));
> +	__tlb_remove_table(table);
> +
> +	/* If pte_free_defer() of the other half came in, queue it now */
> +	if (mask & 0x0CU)
> +		call_rcu(&page->rcu_head, bit ? pte_free_now0 : pte_free_now1);
> +}
> +
> +static void pte_free_now0(struct rcu_head *head)
> +{
> +	pte_free_half(head, 0);
> +}
> +
> +static void pte_free_now1(struct rcu_head *head)
> +{
> +	pte_free_half(head, 1);
> +}
> +
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	unsigned int bit, mask;
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	if (mm_alloc_pgste(mm)) {
> +		call_rcu(&page->rcu_head, pte_free_pgste);

so is this now going to be used to free page tables
instead of page_table_free_rcu?

or will it be used instead of page_table_free?

this is actually quite important for KVM on s390

> +		return;
> +	}
> +	bit = ((unsigned long)pgtable & ~PAGE_MASK) /
> +			(PTRS_PER_PTE * sizeof(pte_t));
> +
> +	spin_lock_bh(&mm_pgtable_list_lock);
> +	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));
> +	mask >>= 24;
> +	/* Other half not allocated? Other half not already pending free? */
> +	if ((mask & 0x03U) == 0x00U && (mask & 0x30U) != 0x30U)
> +		list_del(&page->lru);
> +	spin_unlock_bh(&mm_pgtable_list_lock);
> +
> +	/* Do not relink on rcu_head if other half already linked on rcu_head */
> +	if ((mask & 0x0CU) != 0x0CU)
> +		call_rcu(&page->rcu_head, bit ? pte_free_now1 : pte_free_now0);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  /*
>   * Base infrastructure required to generate basic asces, region, segment,
>   * and page tables that do not make use of enhanced features like EDAT1.
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..1667a1bdb8a8 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -146,7 +146,7 @@ struct page {
>  			pgtable_t pmd_huge_pte; /* protected by page->ptl */
>  			unsigned long _pt_pad_2;	/* mapping */
>  			union {
> -				struct mm_struct *pt_mm; /* x86 pgds only */
> +				struct mm_struct *pt_mm; /* x86 pgd, s390 */
>  				atomic_t pt_frag_refcount; /* powerpc */
>  			};
>  #if ALLOC_SPLIT_PTLOCKS

