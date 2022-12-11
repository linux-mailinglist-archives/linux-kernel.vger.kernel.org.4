Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2D6493F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiLKLkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLKLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:40:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C519DFC5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 03:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670758834; x=1702294834;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=astvZh8nWsVzPt1jQxCFv8l0mlIeuLksFqxluzjYH1k=;
  b=Efngl+IFB4xQzsfP6kxfKntgvScixzDv3RQ2PdaA8jp6VEAH2DlQL6AN
   /Yk5fZrGnlYYV1x3G2RfG7DUCsH/yr9WOee+/8nbSL8PIUilDXgjETtXp
   5r87w95ACx9NzSQlrr+TvtU94aS+zbz3TcYLnaootieW8Ij3RVeSOuvCg
   Qt4B/y/vfZLWVYVzwO22829PeDSbNhM70sQebKUopeMJ8xzxlhQYaoGXn
   aJ0N29IogeSk9UM356uv1mwh7ubF8bUF/t2q3Lvju8jewFb46i25A3mSt
   q3RnU2FDZIef0M56AsYf1IhuWgyFYy3zVoSw9fm+oFyQQAy7yYJxbQaT7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="316388243"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="316388243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 03:40:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="647864747"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="647864747"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 03:40:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Kairui Song <kasong@tencent.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 4/5] swap: remove the swap lock in swap_cache_get_folio
References: <20221208180209.50845-1-ryncsn@gmail.com>
        <20221208180209.50845-5-ryncsn@gmail.com>
Date:   Sun, 11 Dec 2022 19:39:34 +0800
In-Reply-To: <20221208180209.50845-5-ryncsn@gmail.com> (Kairui Song's message
        of "Fri, 9 Dec 2022 02:02:08 +0800")
Message-ID: <87iliiqidl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> There is only one caller not keep holding a reference or lock the
> swap device while calling this function. Just move the lock out
> of this function, it only used to prevent swapoff, and this helper
> function is very short so there is no performance regression
> issue. Help saves a few cycles.

> Subject: Re: [PATCH 4/5] swap: remove the swap lock in swap_cache_get_folio

I don't think you remove `swap lock` in swap_cache_get_folio().  Just
avoid to inc/dec the reference count.

And I think it's better to add '()' after swap_cache_get_folio to make
it clear it's a function.

> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c      | 8 +++++++-
>  mm/swap_state.c | 8 ++------
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c1d8b8a1aa3b..0183b6678270 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1725,6 +1725,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
> +	struct swap_info_struct *si;
>  	struct folio *folio = NULL;
>  	swp_entry_t swap;
>  	int error;
> @@ -1737,7 +1738,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  		return -EIO;
>  
>  	/* Look it up and read it in.. */
> -	folio = swap_cache_get_folio(swap, NULL, 0);
> +	si = get_swap_device(swap);
> +	if (si) {
> +		folio = swap_cache_get_folio(swap, NULL, 0);
> +		put_swap_device(si);

I'd rather to call put_swap_device() at the end of function.  That is,
whenever we get a swap entry without proper lock/reference to prevent
swapoff, we should call get_swap_device() to check its validity and
prevent the swap device from swapoff.

Best Regards,
Huang, Ying

> +	}
> +
>  	if (!folio) {
>  		/* Or update major stats only when swapin succeeds?? */
>  		if (fault_type) {
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 19089417abd1..eba388f67741 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -324,19 +324,15 @@ static inline bool swap_use_vma_readahead(void)
>   * unlocked and with its refcount incremented - we rely on the kernel
>   * lock getting page table operations atomic even if we drop the folio
>   * lock before returning.
> + *
> + * Caller must lock the swap device or hold a reference to keep it valid.
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>  		struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct folio *folio;
> -	struct swap_info_struct *si;
>  
> -	si = get_swap_device(entry);
> -	if (!si)
> -		return NULL;
>  	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
> -	put_swap_device(si);
> -
>  	if (folio) {
>  		bool vma_ra = swap_use_vma_readahead();
>  		bool readahead;
