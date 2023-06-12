Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0C72CC93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjFLR3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjFLR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:28:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9254170C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:28:41 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHJqel015170;
        Mon, 12 Jun 2023 17:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=cx95bW4SbB5z+l0ikJhaFb6aZ3vBFxncXDXQHurb2E0=;
 b=YrPFyhVi/dngQxTSkjS1ED+9QZPuGe/RTSHZkbdvn6/TwxowFX6SC/U44tWz1rV3D2Df
 x0fn2ZYEYY3YZPPKxz9NPaxwaqYSbml0MwCKy7jRDvETM89Lmtauv12h7E94wPIRbIib
 mFT0Kw/i8eA/1CjS5R+AjuQbx7UbfKV2RYms8dBOTRC5kUm8ZuYda6rBkwt1H9KjoZDy
 gVQY8jmmEpOftWdKpf5Wtluv2KS/g1Oxfw/xkPh7tchN+GLL1gDhkMTvBmCFPFoSipE0
 H2sYHsM8yKFnkmMRRR8wXngwPPF/0b7N4RCTf5O6sw4VuFQTH5oBacwTDJ/jrqcW19c5 eA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r67ns059f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 17:28:32 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35CEpIqJ014911;
        Mon, 12 Jun 2023 17:28:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r4gt517yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 17:28:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35CHSS2g15794826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 17:28:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B6220043;
        Mon, 12 Jun 2023 17:28:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B965320040;
        Mon, 12 Jun 2023 17:28:26 +0000 (GMT)
Received: from tarunpc (unknown [9.43.32.94])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 12 Jun 2023 17:28:26 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH] mm: remove set_compound_page_dtor()
In-Reply-To: <20230612163405.99345-1-sidhartha.kumar@oracle.com>
References: <20230612163405.99345-1-sidhartha.kumar@oracle.com>
Date:   Mon, 12 Jun 2023 22:58:24 +0530
Message-ID: <87fs6w7fpj.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKL54VRqqH0EXOA78_Sbn6K_iourvIkC
X-Proofpoint-ORIG-GUID: fKL54VRqqH0EXOA78_Sbn6K_iourvIkC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


LGTM;

Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:

> All users can use the folio equivalent so this function can be safely
> removed.
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>
> rebased on 06/12/23 mm-unstable + Tarun's patch[1]
> [1]: https://lore.kernel.org/linux-mm/20230612093514.689846-1-tsahu@linux.ibm.com/
>
>  include/linux/mm.h | 10 ----------
>  mm/huge_memory.c   |  2 +-
>  mm/internal.h      |  2 +-
>  3 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4a1aec5e4b83c..485224cd62ffb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1223,16 +1223,6 @@ enum compound_dtor_id {
>  };
>  extern compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS];
>  
> -static inline void set_compound_page_dtor(struct page *page,
> -		enum compound_dtor_id compound_dtor)
> -{
> -	struct folio *folio = (struct folio *)page;
> -
> -	VM_BUG_ON_PAGE(compound_dtor >= NR_COMPOUND_DTORS, page);
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
> -	folio->_folio_dtor = compound_dtor;
> -}
> -
>  static inline void folio_set_compound_dtor(struct folio *folio,
>  		enum compound_dtor_id compound_dtor)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 31bc8fa768e3d..76f970aa5b4da 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -583,7 +583,7 @@ void prep_transhuge_page(struct page *page)
>  
>  	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
>  	INIT_LIST_HEAD(&folio->_deferred_list);
> -	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
> +	folio_set_compound_dtor(folio, TRANSHUGE_PAGE_DTOR);
>  }
>  
>  static inline bool is_transparent_hugepage(struct page *page)
> diff --git a/mm/internal.h b/mm/internal.h
> index 61acceface45f..a64967bfcd2ab 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -406,7 +406,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>  {
>  	struct folio *folio = (struct folio *)page;
>  
> -	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> +	folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
>  	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
>  	atomic_set(&folio->_nr_pages_mapped, 0);

Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>
