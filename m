Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE268E592
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBHBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBHBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:48:56 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEEE4EFF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:48:55 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k13so17703803plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 17:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2dajks7+pLSuhCk0mnl5yufn01/RNR3ouO2WMM0QZw=;
        b=pR81DF44OfWquLPnGm6SkA1FB6N+pwQAdnY8mkVyK+SimNhi9y2ULovzSn1jp1qhqc
         mwLwe4WyIPB58XgoAt87CNAIhERfXOvmMCVSUJbO05YoWnMWIxAN+l+Zu0X+nNogvcgK
         9VOZPjnGugfGTxtJvJvy4yTI2QTDa0mk7EiJWvkTx1slVJJupGcuePODKdMVH+Utl9YN
         8wDq+5FQHemIrSq/AKc3i4nb0qTZmJnz6SZ5KWE4+vgOc8+8aWsxDeTTQNIRA6AMysse
         8Tv3p/dMtikONAl03d0CsQmmxg2GAWCwfZOUVMpE07f96bEwQnGspwatTyOu0ibhzWkV
         UoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2dajks7+pLSuhCk0mnl5yufn01/RNR3ouO2WMM0QZw=;
        b=yBeGZZ9i/L2Gwroo/6BG44voQpqLNWUxX2UPPHhpG1GHErGL5dsONFTaAxZNJ6lfds
         gMzwFGLXu79F1QIS9tSsn42cKPqC5r/CdPmHzFdhCvMw+X8Lp4jge95vf1UHRmPrauzr
         Y7llbwEBvpBrlephhuflYKWr/pvinoQxe+us5ksDfuMmKdafSh1Zk0GKav4/D+4pFx6T
         +ams1VDHu3I5WjXEmaDL6sC8elPBhr6pQBylQ51rTFxrWvLURonAPChLSDZLv6IRbR01
         cAQHlQyrKZ+alNdF4aAyDTPJNg3kBUi3ZwZN7q88IyDGJZBXjbEJHEabIgHoMR3eJ8YI
         uzkQ==
X-Gm-Message-State: AO0yUKUTPoA6ZgwshLctA/wqRINMOhy1mTWpSf/wUUTNMV+cifLz4Dad
        Fz2n6fZYAUH56jE3ILP3g64=
X-Google-Smtp-Source: AK7set+naAmhvq2efFvTFqN3g41QFEpkFxiyEFRHmMtUw8p7kOQvCHxftMqwTIX2qsh3cugyi2g6LA==
X-Received: by 2002:a17:90b:4a8e:b0:22b:f780:d346 with SMTP id lp14-20020a17090b4a8e00b0022bf780d346mr6363137pjb.1.1675820934449;
        Tue, 07 Feb 2023 17:48:54 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id o10-20020a17090a4b4a00b002308f09460fsm195288pjl.26.2023.02.07.17.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:48:52 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:48:39 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/7] mm: introduce vma->vm_flags wrapper functions
Message-ID: <Y+L/dzMaraz5oC3N@localhost>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193752.297968-3-surenb@google.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> -- 
> 2.39.1
> 
> 
