Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589D6BBF93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCOWFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCOWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:05:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACD65C6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:05:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay8so8256333wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678917917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+zYG2Px+01uKGNZzjuZ/JXfH1Fwf89A4Lj08OQ0tek=;
        b=Mmo/xsvOa2tW4oyHywucXtb0e9AHmI4JUOPupO9156suHJgnIJimTRDbBBZqOFw+oB
         iXlDgmv62bRYNJp2GpwAoskSAHdjaylT7SU4LqgezI3CUXIXQl6ht2WTxUYHeaZsrd5H
         dUVdechpZVadqL0pHVS4R727lrdZRbnNrYGHwbAskFClH8spaGOksKfG7ddIrF4ZzR5y
         tURXSWCiwiOJAsxHVBObjdAk/K7Z5YyqwiCy2lcS2UoH8L+x2Fu/5lDYWrjFNGxIiHQs
         SQIF1b5lOZXVTxzmoGRxRsBUVn/3uT2ci0NVpP2q/nho+Tc1X095jC5E7g/U9lDiAE4g
         YMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678917917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+zYG2Px+01uKGNZzjuZ/JXfH1Fwf89A4Lj08OQ0tek=;
        b=pSYQ2HJOacA3wowkM+4evR1fGGRjbij7kvjkH6o+QatAD37uFqYHcwj0jj96C/VnoF
         7+P2cDVbP88SmEAu4i9Lbwlu5pkpkShpW3RjkuiZDjScJMFCCOD/Q7QUnP5m4uOZubcn
         i31M0brMVdOIR5v0vGm2eo/hr5+mOiIxx/RBP4PNxbnAQm7kfR64tYG5NDftBJI1YC56
         ihPDrGa3LSfKayZEJqSaoO3Bph5d1vlxvDT7pR3oHg0tmSJehAlUcZIo18qLiZfpLxt5
         DBttJSnOwKTgkG2LHo++JFfa8jGVoRH5L2K/Vot19wx5M/VhDjh3Go/Hyiq4y9hGu2MB
         ZfIg==
X-Gm-Message-State: AO0yUKWudrbBFA8PnkRp3cvnoDz+8PHxizjGK3GxvDCYNcEzQ0K+4axe
        +CP7s+byXlB6yAbUh9K9HMk=
X-Google-Smtp-Source: AK7set/sT2+cwYFh0P1OMwcqbbKvk0BMeMOFJyi82OI3UTsrR+YQ9B2KDMk7hxL7GuqMl+UEMbfajQ==
X-Received: by 2002:a05:600c:35ce:b0:3e2:1368:e3a0 with SMTP id r14-20020a05600c35ce00b003e21368e3a0mr20212833wmq.18.1678917916978;
        Wed, 15 Mar 2023 15:05:16 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id t8-20020a1c7708000000b003ed2276cd0dsm3029854wmi.38.2023.03.15.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:05:15 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:05:14 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 09/10] mm/mmap: start distinguishing if vma can be
 removed in mergeability test
Message-ID: <7e0e33a7-4e9b-4714-8d4b-9487c8d1f799@lucifer.local>
References: <20230309111258.24079-1-vbabka@suse.cz>
 <20230309111258.24079-10-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309111258.24079-10-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:12:57PM +0100, Vlastimil Babka wrote:
> Since pre-git times, is_mergeable_vma() returns false for a vma with
> vm_ops->close, so that no owner assumptions are violated in case the vma
> is removed as part of the merge.
>
> This check is currently very conservative and can prevent merging even
> situations where vma can't be removed, such as simple expansion of
> previous vma, as evidenced by commit d014cd7c1c35 ("mm, mremap: fix
> mremap() expanding for vma's with vm_ops->close()")
>
> In order to allow more merging when appropriate and simplify the code
> that was made more complex by commit d014cd7c1c35, start distinguishing
> cases where the vma can be really removed, and allow merging with
> vm_ops->close otherwise.
>
> As a first step, add a may_remove_vma parameter to is_mergeable_vma().
> can_vma_merge_before() sets it to true, because when called from
> vma_merge(), a removal of the vma is possible.
>
> In can_vma_merge_after(), pass the parameter as false, because no
> removal can occur in each of its callers:
> - vma_merge() calls it on the 'prev' vma, which is never removed
> - mmap_region() and do_brk_flags() call it to determine if it can expand
>   a vma, which is not removed
>
> As a result, vma's with vm_ops->close may now merge with compatible
> ranges in more situations than previously. We can also revert commit
> d014cd7c1c35 as the next step to simplify mremap code again.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d20bbe9ec613..65503ea07f32 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -742,12 +742,13 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  /*
>   * If the vma has a ->close operation then the driver probably needs to release
> - * per-vma resources, so we don't attempt to merge those.
> + * per-vma resources, so we don't attempt to merge those in case the caller
> + * indicates the current vma may be removed as part of the merge.

Nit: 'in case the caller indicates' -> 'if the caller indicates'

>   */
>  static inline bool is_mergeable_vma(struct vm_area_struct *vma,
>  		struct file *file, unsigned long vm_flags,
>  		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +		struct anon_vma_name *anon_name, bool may_remove_vma)
>  {
>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> @@ -761,7 +762,7 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
>  		return false;
>  	if (vma->vm_file != file)
>  		return false;
> -	if (vma->vm_ops && vma->vm_ops->close)
> +	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
>  		return false;
>  	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
>  		return false;
> @@ -793,6 +794,8 @@ static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
>   * We don't check here for the merged mmap wrapping around the end of pagecache
>   * indices (16TB on ia32) because do_mmap() does not permit mmap's which
>   * wrap, nor mmaps which cover the final page at index -1UL.
> + *
> + * We assume the vma may be removed as part of the merge.
>   */
>  static bool
>  can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> @@ -800,7 +803,7 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>  		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  		struct anon_vma_name *anon_name)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
> +	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
>  	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
>  		if (vma->vm_pgoff == vm_pgoff)
>  			return true;
> @@ -814,6 +817,8 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>   *
>   * We cannot merge two vmas if they have differently assigned (non-NULL)
>   * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
> + *
> + * We assume that vma is not removed as part of the merge.
>   */
>  static bool
>  can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> @@ -821,7 +826,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>  		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  		struct anon_vma_name *anon_name)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
> +	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
>  	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
>  		pgoff_t vm_pglen;
>  		vm_pglen = vma_pages(vma);
> --
> 2.39.2
>

I wonder whether this might be moved later into the actual vma_merge() logic so
we only abort a merge at the point a VMA with ->close() would otherwise be
removed? But obviously that would probably need some further clean up to make it
not add yet more complexity to an already very complicated bit of logic.

Otherwise, very nice, clear + conservative so,

Reviewed-By: Lorenzo Stoakes <lstoakes@gmail.com>
