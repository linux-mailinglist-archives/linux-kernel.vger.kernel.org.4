Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D06746081
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGCQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGCQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:12:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA290138;
        Mon,  3 Jul 2023 09:12:08 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363FqtYq009238;
        Mon, 3 Jul 2023 16:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wdh2RYAyHITrVgkXKMbm/krs8OGbtf5yBTnboTwlsec=;
 b=NGNDVCUXDniP9ks7v9zkcKDPOrZ5hRklMqLrpxDF9B5S0VVIriSuzB1fhcisG606wBEk
 QPqFKPTRJeXoQQL2fdlyuz3UU9Wx66gt2FKlMlQcqls/QU7hvUPOZpSMVpQPQnIErFNk
 26Mp+YxPRDdgeXO8CdGLro8fXUtPCvqpb36DbQnVvDyyfne2Q79PzqjSeLQ0pN9XM1Ts
 Y1s0lgcQ5y5SnVWCisewvr9NKqWHnlrlpsoBgOLliqKOdOSAc+3JJg+v0ivL/c+XLD6M
 gqQtoAHbNnioDyKOuDd0vKGRJvOV1LSmcYF9thH/HCIfNBE7qpLzmRnX782uQ2kZy7dX QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1burfyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 16:10:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FsDxK011531;
        Mon, 3 Jul 2023 16:10:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm1burfxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 16:10:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633njY3024429;
        Mon, 3 Jul 2023 16:10:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde1dea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 16:10:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363GAdU410420980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 16:10:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3760C2004B;
        Mon,  3 Jul 2023 16:10:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 730D420043;
        Mon,  3 Jul 2023 16:10:35 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.179.14.225])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon,  3 Jul 2023 16:10:35 +0000 (GMT)
Date:   Mon, 3 Jul 2023 18:10:32 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20230703181032.5803c333@thinkpad-T15>
In-Reply-To: <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
        <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
        <20230628211624.531cdc58@thinkpad-T15>
        <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
        <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
        <20230629175645.7654d0a8@thinkpad-T15>
        <edaa96f-80c1-1252-acbb-71c4f045b035@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cphjZUFFbr8OVTwFiLQZELsZpHPzMQRL
X-Proofpoint-ORIG-GUID: D2nN67tsd20HkmnZX5QgdLfJHxrI2c8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 23:00:07 -0700 (PDT)
Hugh Dickins <hughd@google.com> wrote:

> On Thu, 29 Jun 2023, Gerald Schaefer wrote:
> > On Thu, 29 Jun 2023 12:22:24 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:  
> > > On Wed, Jun 28, 2023 at 10:08:08PM -0700, Hugh Dickins wrote:  
> > > > On Wed, 28 Jun 2023, Gerald Schaefer wrote:    
> > > > > 
> > > > > As discussed in the other thread, we would rather go with less complexity,
> > > > > possibly switching to an approach w/o the list and fragment re-use in the
> > > > > future. For now, as a first step in that direction, we can try with not
> > > > > adding fragments back only for pte_free_defer(). Here is an adjusted
> > > > > version of your patch, copying most of your pte_free_defer() logic and
> > > > > also description, tested with LTP and all three of your patch series applied:    
> > > > 
> > > > Thanks, Gerald: I don't mind abandoning my 13/12 SLAB_TYPESAFE_BY_RCU
> > > > patch (posted with fewer Cc's to the s390 list last week), and switching
> > > > to your simpler who-cares-if-we-sometimes-don't-make-maximal-use-of-page
> > > > patch.
> > > > 
> > > > But I didn't get deep enough into it today to confirm it - and disappointed
> > > > that you've found it necessary to play with pt_frag_refcount in addition to
> > > > _refcount and HH bits.  No real problem with that, but my instinct says it
> > > > should be simpler.    
> > 
> > Yes, I also found it a bit awkward, but it seemed "good and simple enough",
> > to have something to go forward with, while my instinct was in line with yours.
> >   
> > > 
> > > Is there any reason it should be any different at all from what PPC is
> > > doing?
> > > 
> > > I still think the right thing to do here is make the PPC code common
> > > (with Hugh's proposed RCU modification) and just use it in both
> > > arches....  
> > 
> > With the current approach, we would not add back fragments _only_ for
> > the new pte_free_defer() path, while keeping our cleverness for the other
> > paths. Not having a good overview of the negative impact wrt potential
> > memory waste, I would rather take small steps, if possible.
> > 
> > If we later switch to never adding back fragments, of course we should
> > try to be in line with PPC implementation.  
> 
> I find myself half-agreeing with everyone.
> 
> I agree with Gerald that s390 should keep close to what it is already
> doing (except for adding pte_free_defer()): that changing its strategy
> and implementation to be much more like powerpc, is a job for some other
> occasion (and would depend on gathering data about how well each does).
> 
> But I agree with Jason that the powerpc solution we ended up with cut
> out a lot of unnecessary complication: it shifts the RCU delay from
> when pte_free_defer() is called, to when the shared page comes to be
> freed; which may be a lot later, and might not be welcome in a common
> path, but is quite okay for the uncommon pte_free_defer().

Ok, I guess I must admit that I completely ignored the latest progress in
the powerpc thread, and therefore was not up-to-date. Still had the older
approach in mind, where you also checked for pt_frag_refcount to avoid
double call_rcu().

The new approach sounds very reasonable, and I also like your latest
s390 patch from a first glance. Need to get more up-to-date with PageActive
and maybe also powerpc approach, and give this some proper review tomorrow.

> 
> And I agree with Alexander that pte_free_lower() and pte_free_upper()
> are better names than pte_free_now0() and pte_free_now1(): I was going
> to make that change, except all those functions disappear if we follow
> Jason's advice and switch the call_rcu() to when freeing the page.
> 
> (Lower and upper seem unambiguous to me: Gerald, does your confusion
> come just from the way they are shown the wrong way round in the PP AA
> diagram?  I corrected that in my patch, but you reverted it in yours.)

Ah yes, that could well be, and unfortunately I did not notice that you
fixed that in the comment. I only saw that you "fixed" the bit numbering
from 01234567 to 76543210, which I think is wrong on big-endian s390,
and therefore I simply removed that complete hunk.

But thanks a lot for pointing to that! We will certainly want to fix that
comment in a later patch, to reduce some or maybe all of the (at least
my) upper/lower confusion.
