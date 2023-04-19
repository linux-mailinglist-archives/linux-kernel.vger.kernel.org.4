Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C236E722E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjDSETz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDSETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:19:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847341705
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:19:50 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J45ixm023745;
        Wed, 19 Apr 2023 04:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fxFKsrUL3l9DMaDGWHS5NCZlebiGDfNwYCxNcetUNBI=;
 b=V5FMRvugaf4bdoIHuEk4KuRgC7bMQNKKqgTlvbx6HKkvG9eZU54T3NzwdXP7kCtREiId
 vnWLL8tXV7pEHyQi9PUBRGBvCQWtGXXjQ2y1lqtPR5axa587orvJLe1PaOCyO+ccp5sv
 kv0oQOu6fCxzY2rJ7eFjatIjD2pvQQr5tuy9tXg9IGZmrp5Kn1MyXmfOWqftwKzQBoeX
 d/URtWKr82IlNUrqRCYqw8aQbB8ap+5LUhm5ZkmVXBnZCZzvtC1DnsoGunFN1IphRpBQ
 QlbL9aFwh492XL8q2ODLbQL++Nn4VrkaBGraWfG+WVXgOfB4PTO7KhuTlsVj6Ye0QouR mQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1w219s5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 04:19:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33J4JYU4001769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 04:19:34 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 21:19:30 -0700
Date:   Wed, 19 Apr 2023 09:49:26 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Frank van der Linden <fvdl@google.com>
CC:     <quic_charante@quicinc.com>, <akpm@linux-foundation.org>,
        <hughd@google.com>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <rientjes@google.com>,
        <surenb@google.com>, <shakeelb@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
Message-ID: <20230419041926.GA99028@hu-pkondeti-hyd.qualcomm.com>
References: <e6cd1f1e-e54c-87ae-ed23-cc1eca26837c@quicinc.com>
 <20230418172942.740769-1-fvdl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230418172942.740769-1-fvdl@google.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6612H3_FDH4H_60UzHBow5lb_5Einqbp
X-Proofpoint-GUID: 6612H3_FDH4H_60UzHBow5lb_5Einqbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_17,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=845 malwarescore=0 suspectscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:29:42PM +0000, Frank van der Linden wrote:
> Below is a quick patch to allow FADVISE_DONTNEED for shmem to reclaim
> mapped pages too. This would fit our usecase, and matches MADV_PAGEOUT
> more closely.
> 
> The patch series as posted skips mapped pages even if you remove
> the folio_mapped() check, because page_referenced() in
> shrink_page_list() will find page tables with the page mapped,
> and ignore_references is not set when called from reclaim_pages().
> 
> You can make this work in a similar fashion to MADV_PAGEOUT by
> first unmapping a page, but only if the mapping belongs to
> the caller. You just have to change the check for "is there
> only one mapping and am I the owner". To do that, change a few
> lines in try_to_unmap to allow for checking the mm the mapping
> belongs to, and pass in current->mm (NULL still unmaps all mappings).
> 
> I lightly tested this in a somewhat older codebase, so the diff
> below isn't fully tested. But if there are no objections to
> this approach, we could add it on top of your patchset after
> better testing.
> 
> - Frank
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..4403cc2ccc4c 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -368,6 +368,8 @@ int folio_referenced(struct folio *, int is_locked,
>  
>  void try_to_migrate(struct folio *folio, enum ttu_flags flags);
>  void try_to_unmap(struct folio *, enum ttu_flags flags);
> +void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
> +			enum ttu_flags flags);
>  
>  int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, struct page **pages,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8632e02661ac..4d30e8f5afe2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1443,6 +1443,11 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  	munlock_vma_folio(folio, vma, compound);
>  }
>  
> +struct unmap_arg {
> +	enum ttu_flags flags;
> +	struct mm_struct *mm;
> +};
> +
>  /*
>   * @arg: enum ttu_flags will be passed to this argument
>   */
> @@ -1455,7 +1460,11 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	struct page *subpage;
>  	bool anon_exclusive, ret = true;
>  	struct mmu_notifier_range range;
> -	enum ttu_flags flags = (enum ttu_flags)(long)arg;
> +	struct unmap_arg *uap = (struct unmap_arg *)arg;
> +	enum ttu_flags flags = uap->flags;
> +
> +	if (uap->mm && uap->mm != mm)
> +		return true;
>  
>  	/*
>  	 * When racing against e.g. zap_pte_range() on another cpu,
> @@ -1776,6 +1785,7 @@ static int folio_not_mapped(struct folio *folio)
>  
>  /**
>   * try_to_unmap - Try to remove all page table mappings to a folio.
> + * @mm: mm to unmap from (NULL to unmap from all)
>   * @folio: The folio to unmap.
>   * @flags: action and flags
>   *
> @@ -1785,11 +1795,16 @@ static int folio_not_mapped(struct folio *folio)
>   *
>   * Context: Caller must hold the folio lock.
>   */
> -void try_to_unmap(struct folio *folio, enum ttu_flags flags)
> +void try_to_unmap_mm(struct mm_struct *mm, struct folio *folio,
> +		enum ttu_flags flags)
>  {
> +	struct unmap_arg ua = {
> +		.flags = flags,
> +		.mm = mm,
> +	};
>  	struct rmap_walk_control rwc = {
>  		.rmap_one = try_to_unmap_one,
> -		.arg = (void *)flags,
> +		.arg = (void *)&ua,
>  		.done = folio_not_mapped,
>  		.anon_lock = folio_lock_anon_vma_read,
>  	};
> @@ -1800,6 +1815,11 @@ void try_to_unmap(struct folio *folio, enum ttu_flags flags)
>  		rmap_walk(folio, &rwc);
>  }
>  
> +void try_to_unmap(struct folio *folio, enum ttu_flags flags)
> +{
> +	try_to_unmap_mm(NULL, folio, flags);
> +}
> +
>  /*
>   * @arg: enum ttu_flags will be passed to this argument.
>   *
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1af85259b6fc..b24af2fb3378 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2362,8 +2362,24 @@ static void shmem_isolate_pages_range(struct address_space *mapping, loff_t star
>  
>  		if (!folio_try_get(folio))
>  			continue;
> -		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
> -				folio_isolate_lru(folio)) {
> +
> +		if (folio_test_unevictable(folio)) {
> +			folio_put(folio);
> +			continue;
> +		}
> +
> +		/*
> +		 * If the folio is mapped once, try to unmap it from the
> +		 * caller's page table. If it's still mapped afterwards,
> +		 * it belongs to someone else, and we're not going to
> +		 * change someone else's mapping.
> +		 */
> +		if (folio_mapcount(folio) == 1 && folio_trylock(folio)) {
> +			try_to_unmap_mm(current->mm, folio, TTU_BATCH_FLUSH);
> +			folio_unlock(folio);
> +		}

Is rmap walk can be done from a RCU read critical section which does not
allow explicit blocking? 

Thanks,
Pavan
