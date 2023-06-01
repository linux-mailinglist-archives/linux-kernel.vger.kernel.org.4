Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC72D719EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjFAN7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFAN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:59:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55844136;
        Thu,  1 Jun 2023 06:59:12 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Dm9hh015701;
        Thu, 1 Jun 2023 13:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=qT8kRrIQamscJRst5pRHoKfdEH4/busNADa3JrTVC3g=;
 b=EcF02Jqmvf+6HAT9LaMZa+MhPEGs9/+dTMTHpBaDRYrD5RPuGnr/K2/HP64SQalUJkHk
 ZWCjCaw2lONRj2AhM3Crarlu/K6+od0DBexSl1zjUar0MrEQxfRIg/K7oY8QhHG4KQXL
 FdBCF9dVOXSp8UoJLVE/juG1zcIni6dNQ6K9we5th1ge6iX8NT1b3WKIBNGdBdfaq4c2
 CzoTcRaNiE6ez9GoMWOuDymKC2ot745yFN19iHAxlwHlTTDmga8lIyU9/qTJhslkaaLq
 jfZtcwiIOHA/pscR30JBpqbSY7VooS5bEAnLZQmzhsJp9ZR59g9tYAqGE4DeTia9Cf1r Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxvhdg9mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:58:01 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351DmkhY017127;
        Thu, 1 Jun 2023 13:58:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxvhdg9je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:58:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351119CB028926;
        Thu, 1 Jun 2023 13:57:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g52jpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 13:57:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 351DvrTb43450766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jun 2023 13:57:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E094820040;
        Thu,  1 Jun 2023 13:57:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB4BD20043;
        Thu,  1 Jun 2023 13:57:52 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.238])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jun 2023 13:57:52 +0000 (GMT)
Date:   Thu, 1 Jun 2023 15:57:51 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
Message-ID: <20230601155751.7c949ca4@thinkpad-T15>
In-Reply-To: <a8df11d-55ae-64bc-edcb-d383a7a941ea@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
        <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
        <ZHSwWgLWaEd+zi/g@casper.infradead.org>
        <a8df11d-55ae-64bc-edcb-d383a7a941ea@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SzHo2UjAE6P2WmSmv78QU1Y8kPZW3VM5
X-Proofpoint-GUID: 3TDd0Cl2h1aUFcqmXlzGLt1BVByjS4S3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 07:36:40 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Mon, 29 May 2023, Matthew Wilcox wrote:
> > On Sun, May 28, 2023 at 11:20:21PM -0700, Hugh Dickins wrote:  
> > > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > > +{
> > > +	struct page *page;
> > > +
> > > +	page = virt_to_page(pgtable);
> > > +	call_rcu(&page->rcu_head, pte_free_now);
> > > +}  
> > 
> > This can't be safe (on ppc).  IIRC you might have up to 16x4k page
> > tables sharing one 64kB page.  So if you have two page tables from the
> > same page being defer-freed simultaneously, you'll reuse the rcu_head
> > and I cannot imagine things go well from that point.  
> 
> Oh yes, of course, thanks for catching that so quickly.
> So my s390 and sparc implementations will be equally broken.
> 
> > 
> > I have no idea how to solve this problem.  
> 
> I do: I'll have to go back to the more complicated implementation we
> actually ran with on powerpc - I was thinking those complications just
> related to deposit/withdraw matters, forgetting the one-rcu_head issue.
> 
> It uses large (0x10000) increments of the page refcount, avoiding
> call_rcu() when already active.
> 
> It's not a complication I had wanted to explain or test for now,
> but we shall have to.  Should apply equally well to sparc, but s390
> more of a problem, since s390 already has its own refcount cleverness.

Yes, we have 2 pagetables in one 4K page, which could result in same
rcu_head reuse. It might be possible to use the cleverness from our
page_table_free() function, e.g. to only do the call_rcu() once, for
the case where both 2K pagetable fragments become unused, similar to
how we decide when to actually call __free_page().

However, it might be much worse, and page->rcu_head from a pagetable
page cannot be used at all for s390, because we also use page->lru
to keep our list of free 2K pagetable fragments. I always get confused
by struct page unions, so not completely sure, but it seems to me that
page->rcu_head would overlay with page->lru, right?
