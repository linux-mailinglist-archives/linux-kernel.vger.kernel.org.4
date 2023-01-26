Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF567D030
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjAZP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjAZP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:29:09 -0500
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB21CAF0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:29:07 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id B1F931C3C9C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:19:27 +0000 (GMT)
Received: (qmail 13604 invoked from network); 26 Jan 2023 15:19:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 15:19:26 -0000
Date:   Thu, 26 Jan 2023 15:19:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 5/7] mm: replace vma->vm_flags indirect modification
 in ksm_madvise
Message-ID: <20230126151923.4fu34ytwkpbbnvha@techsingularity.net>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230125233554.153109-6-surenb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:35:52PM -0800, Suren Baghdasaryan wrote:
> Replace indirect modifications to vma->vm_flags with calls to modifier
> functions to be able to track flag changes and to keep vma locking
> correctness.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
>  arch/s390/mm/gmap.c                | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 1d67baa5557a..325a7a47d348 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -393,6 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  {
>  	unsigned long gfn = memslot->base_gfn;
>  	unsigned long end, start = gfn_to_hva(kvm, gfn);
> +	unsigned long vm_flags;
>  	int ret = 0;
>  	struct vm_area_struct *vma;
>  	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
> @@ -409,12 +410,14 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  			ret = H_STATE;
>  			break;
>  		}
> +		vm_flags = vma->vm_flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -			  merge_flag, &vma->vm_flags);
> +			  merge_flag, &vm_flags);
>  		if (ret) {
>  			ret = H_STATE;
>  			break;
>  		}
> +		reset_vm_flags(vma, vm_flags);
>  		start = vma->vm_end;
>  	} while (end > vma->vm_end);

Add a comment on why the vm_flags are copied in case someone "optimises"
this in the future? Something like

/* Copy vm_flags to avoid any partial modifications in ksm_madvise. */

>  
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 3a695b8a1e3c..d5eb47dcdacb 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2587,14 +2587,17 @@ int gmap_mark_unmergeable(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	unsigned long vm_flags;
>  	int ret;
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	for_each_vma(vmi, vma) {
> +		vm_flags = vma->vm_flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				  MADV_UNMERGEABLE, &vma->vm_flags);
> +				  MADV_UNMERGEABLE, &vm_flags);
>  		if (ret)
>  			return ret;
> +		reset_vm_flags(vma, vm_flags);

Same.

Not necessary as such as there are few users of ksm_madvise and I doubt
it'll introduce new surprises.

With or without the comment;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
