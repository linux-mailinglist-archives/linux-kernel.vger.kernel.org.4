Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D657429DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjF2PqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjF2PqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:46:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49C2D4E;
        Thu, 29 Jun 2023 08:46:05 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TFgVbP002416;
        Thu, 29 Jun 2023 15:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=REuMPbpiXxOOqmGePcLnL26GHPmbfQCfjSdqDhRBqJY=;
 b=bBsonv926PlkwA6TzSXylOVMuJXDwWfuyrEkJE0fL24hbL9rxscF1torf4uob6L380nl
 EN/LXEt4fNbjl2yidJVXJTvhQidne2ZnzGeMHDOAgLWmtb2rlL7qKDoE4y7btLoqIQHj
 smS6gwrB9gLr3wn+NAKmsGLc6E17BCS2CQIZZN63znuo1iFnfqbFbVh699uy2gTC7u3D
 2GhuajLs4GF0c4NHnhJD7djNyCWqBzLx/Lq+nAxgfwg+sADTmQGSyvwxQIQC27A/4WD+
 hNG9LlOmVVSkSylZySjLEToKd686gqogibwmB+n+4Ht392oQ+RognSPVb93J74qqtsJO 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhcu5070r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:44:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TFgaDS002862;
        Thu, 29 Jun 2023 15:44:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhcu505gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:44:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35TDgsNe000301;
        Thu, 29 Jun 2023 15:44:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr452jy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:44:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TFi1CT20382400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 15:44:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE522004F;
        Thu, 29 Jun 2023 15:44:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087EF20040;
        Thu, 29 Jun 2023 15:43:58 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.52.248])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 29 Jun 2023 15:43:57 +0000 (GMT)
Date:   Thu, 29 Jun 2023 17:43:55 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables
 sharing page
Message-ID: <20230629174355.222ebed0@thinkpad-T15>
In-Reply-To: <ZJ2OK29zPB76i0Ga@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
        <20230628211624.531cdc58@thinkpad-T15>
        <ZJ2OK29zPB76i0Ga@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OW0O7AqzJVgwJLiz07Yw91wbyFNWLd8a
X-Proofpoint-GUID: rDaQf77dkZisi0rgCzgj53DrRyw-QNEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 15:59:07 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> On Wed, Jun 28, 2023 at 09:16:24PM +0200, Gerald Schaefer wrote:
> > On Tue, 20 Jun 2023 00:51:19 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:  
> 
> Hi Gerald, Hugh!
> 
> ...
> > @@ -407,6 +445,88 @@ void __tlb_remove_table(void *_table)
> >  	__free_page(page);
> >  }
> >  
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static void pte_free_now0(struct rcu_head *head);
> > +static void pte_free_now1(struct rcu_head *head);  
> 
> What about pte_free_lower() / pte_free_upper()?

I actually like the 0/1 better, I always get confused what exactly we
mean with "lower / upper" in our code and comments. Is it the first
or second half? With 0/1 it is immediately clear to me.

> 
> ...
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	unsigned int bit, mask;
> > +	struct page *page;
> > +
> > +	page = virt_to_page(pgtable);
> > +	if (mm_alloc_pgste(mm)) {
> > +		/*
> > +		 * TODO: Do we need gmap_unlink(mm, pgtable, addr), like in
> > +		 * page_table_free_rcu()?
> > +		 * If yes -> need addr parameter here, like in pte_free_tlb().
> > +		 */
> > +		call_rcu(&page->rcu_head, pte_free_pgste);
> > +		return;
> > +}
> > +	bit = ((unsigned long)pgtable & ~PAGE_MASK) / (PTRS_PER_PTE * sizeof(pte_t));
> > +
> > +	spin_lock_bh(&mm->context.lock);
> > +	mask = atomic_xor_bits(&page->_refcount, 0x15U << (bit + 24));  
> 
> This  makes the bit logic increasingly complicated to me.

I think it is well in line with existing code in page_table_free[_rcu].
Only instead of doing xor with 0x11U, it does xor with 0x15U to also
switch on the H bit while at it.

> 
> What if instead we set the rule "one bit at a time only"?
> That means an atomic group bit flip is only allowed between
> pairs of bits, namely:
> 
> bit flip	initiated from
> -----------	----------------------------------------
> P      <- A	page_table_free(), page_table_free_rcu()
>      H <- A	pte_free_defer()
> P <- H		pte_free_half()
> 
> In the current model P bit could be on together with H
> bit simultaneously. That actually brings in equation
> nothing.

P bit has to be set at the latest when __tlb_remove_table() gets
called, because there it is checked / cleared. It might be possible
to not set it in pte_free_defer() already, but only later in
pte_free_half() RCU callback, before calling __tlb_remove_table().
But that would not be in line any more with existing code, where it
is already set before scheduling the RCU callback.

Therefore, I would rather stick to the current approach, unless
you see some bug in it.

> 
> Besides, this check in page_table_alloc() (while still
> correct) makes one (well, me) wonder "what about HH bits?":
> 
> 	mask = (mask | (mask >> 4)) & 0x03U;
> 	if (mask != 0x03U) {
> 		...
> 	}

Without adding fragments back to the list, it is not necessary
to check any H bits page_table_alloc(), or so I hope. Actually,
I like that aspect most, i.e. we have as little impact on current
code as possible.

And H bits are only relevant for preventing double use of rcu_head,
which is what they were designed for, and only the new code has
to care about them.
