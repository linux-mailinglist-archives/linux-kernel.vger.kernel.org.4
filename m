Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAD742A21
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjF2P6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2P6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:58:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D43C06;
        Thu, 29 Jun 2023 08:57:52 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TFkPM3013631;
        Thu, 29 Jun 2023 15:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=J7n4i56PjuYyheRXiT1h3zZxQxjoI3aURFtsNFhnzeA=;
 b=fJat8SyaeO/jZvMndX/6x2417ZRjc3DZarZ7bW3z0FoTpRYKPh4uN7pNn4UOWvjmarb3
 IQY5nUFE7bNlUXBdxYReE0UWVSc7h8MRtk0yunuB34XZ1e1IZ0OMI4kuGS/U9811cf7/
 U3nYS/uC5jUqbncbZPgN3IuVbY2a2fX8k2AeBsXt/Qf2VDYXWWMoLcGq2VFRMUuy7HEC
 KelsobjcuzPUpzItspSnwXtI5BMpby7hEFvy37e1OaFOZEdUaTogamnt2NO8uIdWrGxm
 i/5uAqXxKof5noy3h3DPc88V6gPsb3oWVvXrivfb1f6cNgZlA6YAnbwXml0QzwKKt0Xq Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhcw209q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:56:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TFkvQd014751;
        Thu, 29 Jun 2023 15:56:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhcw209p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:56:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T4lrrC024964;
        Thu, 29 Jun 2023 15:56:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rdr452k48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 15:56:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TFup4K56361424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 15:56:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2ACC20040;
        Thu, 29 Jun 2023 15:56:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2131120043;
        Thu, 29 Jun 2023 15:56:48 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.171.52.248])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 29 Jun 2023 15:56:48 +0000 (GMT)
Date:   Thu, 29 Jun 2023 17:56:45 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        Zack Rusin <zackr@vmware.com>,
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
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables
 sharing page
Message-ID: <20230629175645.7654d0a8@thinkpad-T15>
In-Reply-To: <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
        <20230628211624.531cdc58@thinkpad-T15>
        <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
        <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3HDFPvbn1Kqe9hJCMmYTIt5DBeoBHNxy
X-Proofpoint-GUID: lDFvs8dRlpQ8RTlIWc53XmzE2FLLW2CQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 12:22:24 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Jun 28, 2023 at 10:08:08PM -0700, Hugh Dickins wrote:
> > On Wed, 28 Jun 2023, Gerald Schaefer wrote:  
> > > 
> > > As discussed in the other thread, we would rather go with less complexity,
> > > possibly switching to an approach w/o the list and fragment re-use in the
> > > future. For now, as a first step in that direction, we can try with not
> > > adding fragments back only for pte_free_defer(). Here is an adjusted
> > > version of your patch, copying most of your pte_free_defer() logic and
> > > also description, tested with LTP and all three of your patch series applied:  
> > 
> > Thanks, Gerald: I don't mind abandoning my 13/12 SLAB_TYPESAFE_BY_RCU
> > patch (posted with fewer Cc's to the s390 list last week), and switching
> > to your simpler who-cares-if-we-sometimes-don't-make-maximal-use-of-page
> > patch.
> > 
> > But I didn't get deep enough into it today to confirm it - and disappointed
> > that you've found it necessary to play with pt_frag_refcount in addition to
> > _refcount and HH bits.  No real problem with that, but my instinct says it
> > should be simpler.  

Yes, I also found it a bit awkward, but it seemed "good and simple enough",
to have something to go forward with, while my instinct was in line with yours.

> 
> Is there any reason it should be any different at all from what PPC is
> doing?
> 
> I still think the right thing to do here is make the PPC code common
> (with Hugh's proposed RCU modification) and just use it in both
> arches....

With the current approach, we would not add back fragments _only_ for
the new pte_free_defer() path, while keeping our cleverness for the other
paths. Not having a good overview of the negative impact wrt potential
memory waste, I would rather take small steps, if possible.

If we later switch to never adding back fragments, of course we should
try to be in line with PPC implementation.
