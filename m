Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F240743FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjF3Q10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjF3Q1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:27:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10C3A9B;
        Fri, 30 Jun 2023 09:27:22 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UGGhGg032422;
        Fri, 30 Jun 2023 16:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5FleP/0R2I7M2ntcJjERxzq9JuYOAoAyKjmikS2wBhs=;
 b=rfJRDjaZJEmkfL3bAbOBfQgWWuV8fu4M4tJ60QgQix7BNqhCbdDa0fe4ogQDW2D0rhik
 WZFSh31VTe2dd7zFvMHKxG8NjyG3/mWCsRT1NXjIHQvQHnNlmreeNv4kJSHIJCm3/3cY
 8Vo/gAsNL9CsVvHpA8vJRL3ec/c0OClfPpaT/H/wliIlFpB+pKNBdZpCsR1Qrs3tbal4
 7d0rN+mrAqlZlfZyoi1wzQXr023CgKAdYBD22hdZ2NbPDWJ/V0kCq3Mtq78VI3Dqy9+g
 O2ZyQjIgWrj1sU0NRnKHUUlc8tPezuNGTeemTtA37ErNfK/9zqnLWTWZQoNSZFFDrx8/ 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj2e387t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 16:26:07 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UGH63B001290;
        Fri, 30 Jun 2023 16:26:06 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj2e387rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 16:26:05 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UFkuwi000452;
        Fri, 30 Jun 2023 16:26:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr453513-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 16:26:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35UGPxmU43516216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:25:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9A4120043;
        Fri, 30 Jun 2023 16:25:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC6F20040;
        Fri, 30 Jun 2023 16:25:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jun 2023 16:25:57 +0000 (GMT)
Date:   Fri, 30 Jun 2023 18:25:56 +0200
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
Message-ID: <20230630182556.7727ef50@p-imbrenda>
In-Reply-To: <062b19-4cf1-261-a9bf-9cefd32382fc@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
        <20230630153852.31163592@p-imbrenda>
        <062b19-4cf1-261-a9bf-9cefd32382fc@google.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NGGI7X7RNOwVeaZnozOHUb2n61vBAppx
X-Proofpoint-ORIG-GUID: ZwpwS0v6kbksCuiFRJdCAInx0_OzLG0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 08:28:54 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Fri, 30 Jun 2023, Claudio Imbrenda wrote:
> > On Tue, 20 Jun 2023 00:51:19 -0700 (PDT)
> > Hugh Dickins <hughd@google.com> wrote:
> > 
> > [...]
> >   
> > > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > > +{
> > > +	unsigned int bit, mask;
> > > +	struct page *page;
> > > +
> > > +	page = virt_to_page(pgtable);
> > > +	if (mm_alloc_pgste(mm)) {
> > > +		call_rcu(&page->rcu_head, pte_free_pgste);  
> > 
> > so is this now going to be used to free page tables
> > instead of page_table_free_rcu?  
> 
> No.
> 
> All pte_free_defer() is being used for (in this series; and any future
> use beyond this series will have to undertake its own evaluations) is
> for the case of removing an empty page table, which used to map a group
> of PTE mappings of a file, in order to make way for one PMD mapping of
> the huge page which those scattered pages have now been gathered into.
> 
> You're worried by that mm_alloc_pgste() block: it's something I didn't

actually no, but thanks for bringing it up :D

> have at all in my first draft, then I thought that perhaps the pgste
> case might be able to come this way, so it seemed stupid to leave out
> the handling for it.
> 
> I hope that you're implying that should be dead code here?  Perhaps,
> that the pgste case corresponds to the case in s390 where THPs are
> absolutely forbidden?  That would be good news for us.
> 
> Gerald, in his version of this block, added a comment asking:
> 	/*
> 	 * TODO: Do we need gmap_unlink(mm, pgtable, addr), like in
> 	 * page_table_free_rcu()?
> 	 * If yes -> need addr parameter here, like in pte_free_tlb().
> 	 */
> Do you have the answer to that?  Neither of us could work it out.

this is the thing I'm worried about; removing a page table that was
used to map a guest will leave dangling pointers in the gmap that will
cause memory corruption (I actually ran into that problem myself for
another patchseries).

gmap_unlink() is needed to clean up the pointers before they become
dangling (and also potentially do some TLB purging as needed)

the point here is: we need that only for page_table_free_rcu(); all
other users of page_table_free() cannot act on guest page tables
(because we don't allow THP for KVM guests). and that is why
page_table_free() does not do gmap_unlink() currently.

> 
> > 
> > or will it be used instead of page_table_free?  
> 
> Not always; but yes, this case of removing a page table used
> page_table_free() before; but now, with the lighter locking, needs
> to keep the page table valid until the RCU grace period expires.

so if I understand correctly your code will, sometimes, under some
circumstances, replace what page_table_free() does, but it will never
replace page_table_free_rcu()?

because in that case there would be no issues 

> 
> > 
> > this is actually quite important for KVM on s390  
> 
> None of us are wanting to break KVM on s390: your guidance appreciated!
> 
> Thanks,
> Hugh

