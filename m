Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4839167D590
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjAZTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjAZTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:42:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B022A1164B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB2B6187E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD75DC433EF;
        Thu, 26 Jan 2023 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674762149;
        bh=E0Awn8IrDI0cjsY1zBcnDnJ8/kHskzlyS2ZRlhbVGpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOR8SpJGBLgLCTbpFfWyABzoglOwWkVC4qJRpXwMyy8edq2U+IEetogeCxqMJORUL
         ITlr15BU3l4JyJpIzyGlxgIWpIxtCBzYYG/isBf5BBRviAFqo5RV2ZXv3hzbt8Jy8A
         fi8bCQ9hiE0NpulsRBz/XpA+dgRYmn+gvnB+zONjs+eJJs0AHxg6vEMaLbfkYU2ETm
         vbXycJ2kHYRY8NeQNaxsRJBqkCG0WGIdpk833PNIjQ/xBFcQ4NkNN0S3fRfUNO3HYg
         MIU2+pOOlnxz7zr9qwC1zq871fB0XOWKtA84xyaxjyohcEs5R3BSlVDTrd9nvE/dzb
         k33gM0+Rg4mMA==
Date:   Thu, 26 Jan 2023 21:42:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/7] mm: introduce vma->vm_flags wrapper functions
Message-ID: <Y9LXjSKIb27YUk0d@kernel.org>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193752.297968-3-surenb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:37:47AM -0800, Suren Baghdasaryan wrote:
> vm_flags are among VMA attributes which affect decisions like VMA merging
> and splitting. Therefore all vm_flags modifications are performed after
> taking exclusive mmap_lock to prevent vm_flags updates racing with such
> operations. Introduce modifier functions for vm_flags to be used whenever
> flags are updated. This way we can better check and control correct
> locking behavior during these updates.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h       | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h | 10 +++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8d636e895ee9..abb31103d060 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -627,6 +627,46 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  }
>  
> +/* Use when VMA is not part of the VMA tree and needs no locking */
> +static inline void vm_flags_init(struct vm_area_struct *vma,
> +				 vm_flags_t flags)
> +{
> +	ACCESS_PRIVATE(vma, __vm_flags) = flags;
> +}
> +
> +/* Use when VMA is part of the VMA tree and modifications need coordination */
> +static inline void vm_flags_reset(struct vm_area_struct *vma,
> +				  vm_flags_t flags)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	vm_flags_init(vma, flags);
> +}
> +
> +static inline void vm_flags_set(struct vm_area_struct *vma,
> +				vm_flags_t flags)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
> +}
> +
> +static inline void vm_flags_clear(struct vm_area_struct *vma,
> +				  vm_flags_t flags)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
> +}
> +
> +/*
> + * Use only when the order of set/clear operations is unimportant, otherwise
> + * use vm_flags_{set|clear} explicitly.
> + */
> +static inline void vm_flags_mod(struct vm_area_struct *vma,
> +				vm_flags_t set, vm_flags_t clear)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	vm_flags_init(vma, (vma->vm_flags | set) & ~clear);
> +}
> +
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
>  {
>  	vma->vm_ops = NULL;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2d6d790d9bed..da983aedb741 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -491,7 +491,15 @@ struct vm_area_struct {
>  	 * See vmf_insert_mixed_prot() for discussion.
>  	 */
>  	pgprot_t vm_page_prot;
> -	unsigned long vm_flags;		/* Flags, see mm.h. */
> +
> +	/*
> +	 * Flags, see mm.h.
> +	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
> +	 */
> +	union {
> +		const vm_flags_t vm_flags;
> +		vm_flags_t __private __vm_flags;
> +	};
>  
>  	/*
>  	 * For areas with an address space and backing store,
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
