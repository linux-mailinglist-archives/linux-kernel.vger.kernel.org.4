Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246C5647C66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLICt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLICt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:49:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EE79C06
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670554195; x=1702090195;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=camHpBbJjLrAb2h11w8/RSo9EU+YkLRp9/dJEdKNeDk=;
  b=fJRKmvE2mEkWGUEM1FGHgd0G0w2phKzerzvwSudZTBqofLY5INi8YLRA
   v1ph81s3QdZoCAjE8OaE5/Sj9iB67Qs2eP14hN4JQeCaItZDtsK7gra0K
   AFLxgBBJPFM5j9qhHdkNrTV6fAIKfGLLxcRZX3eShPGFARE/+srW2XmI+
   yZzb0WIRL5RLdotNu8z5BYeEUP0KPHOiRw0ZGza5aj5ncT4wqjqDvM+jq
   9hCJekDfDkI1KCWCpsjssoOVUkTwulWSTSj5Gk24U1Qx3O7OBRqBWKc7B
   DI0/cIUlX4C3W5lKYn4Qqn6HLKXfLrfHW0QAlHnJRUaZixrMRwkHsCHhN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="381673157"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="381673157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 18:49:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="710736287"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="710736287"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 18:49:52 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/5] swapfile: get rid of volatile and avoid redundant read
References: <20221208180209.50845-1-ryncsn@gmail.com>
        <20221208180209.50845-2-ryncsn@gmail.com>
Date:   Fri, 09 Dec 2022 10:48:41 +0800
In-Reply-To: <20221208180209.50845-2-ryncsn@gmail.com> (Kairui Song's message
        of "Fri, 9 Dec 2022 02:02:05 +0800")
Message-ID: <874ju5s35i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Convert a volatile variable to more readable READ_ONCE. And this
> actually avoids the code from reading the variable twice redundantly
> when it races.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/swapfile.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 72e481aacd5d..ff4f3cb85232 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1836,13 +1836,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  	pte_t *pte;
>  	struct swap_info_struct *si;
>  	int ret = 0;
> -	volatile unsigned char *swap_map;
>  
>  	si = swap_info[type];
>  	pte = pte_offset_map(pmd, addr);
>  	do {
>  		struct folio *folio;
>  		unsigned long offset;
> +		unsigned char swp_count;
>  
>  		if (!is_swap_pte(*pte))
>  			continue;
> @@ -1853,7 +1853,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  		offset = swp_offset(entry);
>  		pte_unmap(pte);
> -		swap_map = &si->swap_map[offset];
>  		folio = swap_cache_get_folio(entry, vma, addr);
>  		if (!folio) {
>  			struct page *page;
> @@ -1870,8 +1869,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				folio = page_folio(page);
>  		}
>  		if (!folio) {
> -			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
> +			swp_count = READ_ONCE(si->swap_map[offset]);
> +			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
>  				goto try_next;
> +
>  			return -ENOMEM;
>  		}
