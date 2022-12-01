Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993363F28E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiLAOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiLAORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:17:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07061D32D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:17:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1BqUwG031346;
        Thu, 1 Dec 2022 14:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=RBHvfFvfjPggq85BmasY8t3grXmjKTmAAepeqUyVSSg=;
 b=IRQWKguMolO4NcpFbx9TyBlCJJCpgblSFAW9T8iNvi6PruFtUbDbnlUQ+3O6C3A9BRPP
 e8TzpNS8HHtRuc6K88KdjbD44VVYrvcdJXywBfVAqpBGWNrXGDSxuwAGG54kZUc9C7K7
 zlSN+mNubxKZw0Lwg/ICgDIi+WIhUltpQDviABkSehKGLm+MMz3gr8eQNGKb4gt4mKOb
 S6Tdfl264T2QcITC0hM6ZF6PKBNstlsOXe7S2HtFoVrdW/3RmYkdnyojkE1kNgNqTQk1
 PxOKsQ3KePLj3hgR6IFlBLLK2n8ALgWOAosdOT4Ggo3MYWGQIV+KmEwo3zf+jWgOLW7Y jQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m6k6xhypq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 14:17:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1EHXse012499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 14:17:33 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 1 Dec 2022 06:17:30 -0800
Date:   Thu, 1 Dec 2022 19:47:26 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
Message-ID: <20221201141726.GA18487@hu-pkondeti-hyd.qualcomm.com>
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
 <CANe_+Uidg=YuZG71VF7YnRhBtUHb-CGRMN45RGgp2PMn+SXGkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANe_+Uidg=YuZG71VF7YnRhBtUHb-CGRMN45RGgp2PMn+SXGkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oY82rhSEp2POs5Pbfe7YGy3HuPUmgv0A
X-Proofpoint-ORIG-GUID: oY82rhSEp2POs5Pbfe7YGy3HuPUmgv0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Dec 01, 2022 at 01:46:36PM +0000, Mark Hemment wrote:
> On Wed, 9 Nov 2022 at 05:19, Pavankumar Kondeti
> <quic_pkondeti@quicinc.com> wrote:
> >
> > When MADV_PAGEOUT is called on a private file mapping VMA region,
> > we bail out early if the process is neither owner nor write capable
> > of the file. However, this VMA may have both private/shared clean
> > pages and private dirty pages. The opportunity of paging out the
> > private dirty pages (Anon pages) is missed. Fix this by caching
> > the file access check and use it later along with PageAnon() during
> > page walk.
> >
> > We observe ~10% improvement in zram usage, thus leaving more available
> > memory on a 4GB RAM system running Android.
> >
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 
> Only scanned review the patch; the logic looks good (as does the
> reasoning) but a couple of minor comments;
> 
Thanks for the review and nice suggestions on how the patch can be improved.

> 
> > ---
> >  mm/madvise.c | 30 +++++++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index c7105ec..b6b88e2 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -40,6 +40,7 @@
> >  struct madvise_walk_private {
> >         struct mmu_gather *tlb;
> >         bool pageout;
> > +       bool can_pageout_file;
> >  };
> >
> >  /*
> > @@ -328,6 +329,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >         struct madvise_walk_private *private = walk->private;
> >         struct mmu_gather *tlb = private->tlb;
> >         bool pageout = private->pageout;
> > +       bool pageout_anon_only = pageout && !private->can_pageout_file;
> >         struct mm_struct *mm = tlb->mm;
> >         struct vm_area_struct *vma = walk->vma;
> >         pte_t *orig_pte, *pte, ptent;
> > @@ -364,6 +366,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >                 if (page_mapcount(page) != 1)
> >                         goto huge_unlock;
> >
> > +               if (pageout_anon_only && !PageAnon(page))
> > +                       goto huge_unlock;
> > +
> >                 if (next - addr != HPAGE_PMD_SIZE) {
> >                         int err;
> >
> > @@ -432,6 +437,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >                 if (PageTransCompound(page)) {
> >                         if (page_mapcount(page) != 1)
> >                                 break;
> > +                       if (pageout_anon_only && !PageAnon(page))
> > +                               break;
> >                         get_page(page);
> >                         if (!trylock_page(page)) {
> >                                 put_page(page);
> > @@ -459,6 +466,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >                 if (!PageLRU(page) || page_mapcount(page) != 1)
> >                         continue;
> >
> > +               if (pageout_anon_only && !PageAnon(page))
> > +                       continue;
> > +
> 
> The added PageAnon()s probably do not have a measurable performance
> impact, but not ideal when walking a large anonymous mapping (as
> '->can_pageout_file' is zero for anon mappings).
> Could the code be re-structured so that PageAnon() is only tested when
> filtering is needed? Say;
>     if (pageout_anon_only_filter && !PageAnon(page)) {
>         continue;
>     }
> where 'pageout_anon_only_filter' is only set for a private named
> mapping when do not have write perms on backing object.  It would not
> be set for anon mappings.
> 
Understood. Like you suggested, PageAnon() check can be eliminated for
an anon mapping. will make the necessary changes.

> 
> >                 VM_BUG_ON_PAGE(PageTransCompound(page), page);
> >
> >                 if (pte_young(ptent)) {
> > @@ -541,11 +551,13 @@ static long madvise_cold(struct vm_area_struct *vma,
> >
> >  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> >                              struct vm_area_struct *vma,
> > -                            unsigned long addr, unsigned long end)
> > +                            unsigned long addr, unsigned long end,
> > +                            bool can_pageout_file)
> >  {
> >         struct madvise_walk_private walk_private = {
> >                 .pageout = true,
> >                 .tlb = tlb,
> > +               .can_pageout_file = can_pageout_file,
> >         };
> >
> >         tlb_start_vma(tlb, vma);
> > @@ -553,10 +565,8 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
> >         tlb_end_vma(tlb, vma);
> >  }
> >
> > -static inline bool can_do_pageout(struct vm_area_struct *vma)
> > +static inline bool can_do_file_pageout(struct vm_area_struct *vma)
> >  {
> > -       if (vma_is_anonymous(vma))
> > -               return true;
> >         if (!vma->vm_file)
> >                 return false;
> >         /*
> > @@ -576,17 +586,23 @@ static long madvise_pageout(struct vm_area_struct *vma,
> >  {
> >         struct mm_struct *mm = vma->vm_mm;
> >         struct mmu_gather tlb;
> > +       bool can_pageout_file;
> >
> >         *prev = vma;
> >         if (!can_madv_lru_vma(vma))
> >                 return -EINVAL;
> >
> > -       if (!can_do_pageout(vma))
> > -               return 0;
> 
> The removal of this test results in a process, which cannot get write
> perms for a shared named mapping, performing a 'walk'.  As such a
> mapping cannot have anon pages, this walk will be a no-op.  Not sure
> why a well-behaved program would do a MADV_PAGEOUT on such a mapping,
> but if one does this could be considered a (minor performance)
> regression. As madvise_pageout() can easily filter this case, might be
> worth adding a check.
> 

Got it. we can take care of this edge case by rejecting shared mappings i.e
!!(vma->vm_flags & VM_MAYSHARE) == 1 where the process has no write
permission.

> 
> > +       /*
> > +        * If the VMA belongs to a private file mapping, there can be private
> > +        * dirty pages which can be paged out if even this process is neither
> > +        * owner nor write capable of the file. Cache the file access check
> > +        * here and use it later during page walk.
> > +        */
> > +       can_pageout_file = can_do_file_pageout(vma);
> >
> >         lru_add_drain();
> >         tlb_gather_mmu(&tlb, mm);
> > -       madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> > +       madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
> >         tlb_finish_mmu(&tlb);
> >
> >         return 0;
> > --
> > 2.7.4
> >
> >
> 
Thanks,
Pavan
