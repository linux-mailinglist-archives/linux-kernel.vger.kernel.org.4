Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E676745AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGCLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGCLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:01:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97244C4;
        Mon,  3 Jul 2023 04:01:39 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363AkoTC001299;
        Mon, 3 Jul 2023 11:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ac8Q9yiUAFBzu8NvY5GoR+9T11nvifaSHGih/5vR0aU=;
 b=dtEoFKKJC4XIzvEIbBsFYcuLdbjB8uHqQnycboN1SAcnyWW6+BLaNRG+XZ2F7Dqtb4Ac
 T7m02H29BKN4vTOTeyTwrWgdveVKjR4kP/N+mkwZpRAks9yAHSymv9MBs6UA+bEdPh5f
 zv/V1kGivMJRJYQ5n36Wdd1cMMS8vVJYi75vawOGwsoZkRiDhIUZ8BHPx03NU0rGxBNL
 KVCjXaBGLH9M9qKCACNNiC6P69uC1QwEF+b3KHTIcAkkzmLUKiAcDcArwqardTigLDHO
 xzXgSoD5c12NqiBSxYT6D+WRilWroGHWw7gxEj905B295D6z0+ONnkR/MzUkS+AOkxXm Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkvvnr9f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 11:00:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363AwdEr005999;
        Mon, 3 Jul 2023 11:00:24 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkvvnr9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 11:00:24 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3634QOuq000970;
        Mon, 3 Jul 2023 11:00:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4rxgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 11:00:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363B0Gal10945172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 11:00:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B185720043;
        Mon,  3 Jul 2023 11:00:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90E3520040;
        Mon,  3 Jul 2023 11:00:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 11:00:15 +0000 (GMT)
Date:   Mon, 3 Jul 2023 13:00:13 +0200
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
Message-ID: <20230703130013.559217c9@p-imbrenda>
In-Reply-To: <7f6d399b-c47-1faa-f7f6-9932b9811f8c@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
        <20230630153852.31163592@p-imbrenda>
        <062b19-4cf1-261-a9bf-9cefd32382fc@google.com>
        <20230630182556.7727ef50@p-imbrenda>
        <7f6d399b-c47-1faa-f7f6-9932b9811f8c@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FBp9P7VH_rxoCQb-Z7tiY-Zije8r63Zy
X-Proofpoint-ORIG-GUID: nbVmQd8tIibtO-0ycn7DYgNX7-R6BFd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 12:22:43 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

[...]

> That's something I would have expected to be handled already via
> mmu_notifiers, rather than buried inside the page table freeing.
> 
> If s390 is the only architecture to go that way, and could instead do
> it via mmu_notifiers, then I think that will be more easily supported
> in the long term.

I am very well aware of that, and in fact I've been working on
exactly that for some time already. But it's a very complex minefield
and therefore I'm proceeding *very* carefully. It will take quite some
time before anything comes out.

> 
> But I'm writing from a position of very great ignorance: advising
> KVM on s390 is many dimensions away from what I'm capable of.

fair enough, but in this case it doesn't mean that you are not right :)

> 
> > 
> > the point here is: we need that only for page_table_free_rcu(); all
> > other users of page_table_free() cannot act on guest page tables  
> 
> I might be wrong, but I think that most users of page_table_free()
> are merely freeing a page table which had to be allocated up front,
> but was then found unnecessary (maybe a racing task already inserted
> one): page tables which were never exposed to actual use.

that was my impression as well

> > (because we don't allow THP for KVM guests). and that is why
> > page_table_free() does not do gmap_unlink() currently.  
> 
> But THP collapse does (or did before this series) use it to free a
> page table which had been exposed to use.  The fact that s390 does

that is also my understanding

> not allow THP for KVM guests makes page_table_free(), and this new
> pte_free_defer(), safe for that; but it feels dangerously coincidental.

not really; my guess is that we _intentionally_ did not do anything
there, because we knew we did not need it, knowing well that
we would need it once we would want to support THP for guests.
so not a coincidence, but a conscious decision based, I guess, on
touching as little code as needed.

> 
> It's easy to imagine a future change being made, which would stumble
> over this issue.  I have imagined that pte_free_defer() will be useful
> in future, in the freeing of empty page tables: but s390 may pose a
> problem there - though perhaps no more of a problem than additionally
> needing to pass a virtual address down the stack.

yeah it can always be fixed later if we need to

> 
> >   
> > >   
> > > > 
> > > > or will it be used instead of page_table_free?    
> > > 
> > > Not always; but yes, this case of removing a page table used
> > > page_table_free() before; but now, with the lighter locking, needs
> > > to keep the page table valid until the RCU grace period expires.  
> > 
> > so if I understand correctly your code will, sometimes, under some
> > circumstances, replace what page_table_free() does, but it will never
> > replace page_table_free_rcu()?
> > 
> > because in that case there would be no issues   
> 
> Yes, thanks for confirming: we have no issue here at present, but may
> do if use of pte_free_defer() is extended to other contexts in future.
> 
> Would it be appropriate to add a WARN_ON_ONCE around that
> > > > > +	if (mm_alloc_pgste(mm)) {  
> in pte_free_defer()?

that's actually not a bad idea. should never happen, but... that's the
whole point of a WARN_ON after all

> 
> I ask that somewhat rhetorically: that block disappears in the later
> version I was working on last night (and will return to shortly), in
> which pte_free_defer() just sets a bit and calls page_table_free().
> 
> But I'd like to understand the possibilities better: does mm_alloc_pgste()
> correspond 1:1 to KVM guest on s390, or does it cover several different
> possibilities of which KVM guest is one, or am I just confused to be
> thinking there's any relationship?

this is... historically complicated (because of course it is)

in theory any process can allocate PGSTEs by having the right bits in
the ELF header (that's how QEMU does it currently). And QEMU will have
PGSTEs allocated even if it does not actually start any guests.

Then we have the vm.allocate_pgste sysctl knob; once enabled, it will
cause all processes to have PGSTEs allocated. This is how we handled
PGSTEs before we switched to ELF header bits.

So in summary: in __practice__ yes, only QEMU will have PGSTEs. But in
theory anything is possible and allowed.

> 
> Thanks,
> Hugh
> 
> >   
> > >   
> > > > 
> > > > this is actually quite important for KVM on s390    
> > > 
> > > None of us are wanting to break KVM on s390: your guidance appreciated!
> > > 
> > > Thanks,
> > > Hugh  

