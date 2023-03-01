Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF16A6859
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCAHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCAHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:43:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D35265
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:43:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h8so9803363plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWjpqnVGFtJHppOeTMNCvEvJYUpqOyji4irq19gGZLo=;
        b=IVuk/FRrQ1cnFEOcjIQKxmcSCAt5b8wwU30o9yvRkxkrtthfUWs4MWtfnshVW22vWV
         pxG7b/5dfs+C8VjLBFS2wkbt+qjSk/VFBUxhrhScOhmkgtuOxWtfEZ7FDF4YbhxoAFtf
         7gzmv/O9XC6bNpz8jWth4nLzBG5TX1M3DpJwR/F6ix9wK7nDrcJRXJwbYBcHxJ6nQxIO
         oKgj/wJ7qANmcszJOk0mIbf1NFi3ht5tlJJFxVMGizGnLGMRMrUCqn8HsKJVjxYaKXxL
         yj9Gd18KbPAo0nhLRBZR9E9/M4icHsh7OZm9uWzuOXch9CRasHUAL1sLbYZFSM3W/ZFj
         yFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWjpqnVGFtJHppOeTMNCvEvJYUpqOyji4irq19gGZLo=;
        b=3hcTycbfDrqD+ZSN7YxzzNJASQyH4fQutCIkx6BJM06APbQuMHRDhDtXLULko5uYm+
         scSjDCJDkUG14lgyTyV/I1GViRHTjIEUb7jpSmcEbeeSosLiQoA3MZ1wUF2XIFN3ubth
         0rj+oZjmbEsayXxApVFvp23U2Bm7baDiXlREMp377pDXbj7WbSF8BWPvPXdxQmh8Q4+B
         o8OrDCQD1jcYPIw/YvJoOaD/ziVW723nBwEGDJaMbo+C4ca4Si7wIPBHn7zzOFH570eK
         F+evogsMUK3sTyeh2nhSkbzMLyTjWbQeLVJ1XaXryE3Jt33fIFEUgK0aMLy76VZpzH7B
         sVtA==
X-Gm-Message-State: AO0yUKXxyqv7xIPrSQEf3r4ktRPblykwkVPA3NTVLsNF5QDk5anbZJjD
        w0Dlo3pAp1kELHoCdVDe00g=
X-Google-Smtp-Source: AK7set/NzwkQJ1R6EDT0Imnsgt3x8Nd6NQY8wcxlk07k0GJDQu1OIK3Vxc/SLHh5JSP6hXwMeNFAfQ==
X-Received: by 2002:a17:90b:1c8d:b0:233:eba7:10c0 with SMTP id oo13-20020a17090b1c8d00b00233eba710c0mr6319388pjb.1.1677656629419;
        Tue, 28 Feb 2023 23:43:49 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a304600b00231261061a5sm7206661pjl.5.2023.02.28.23.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:43:48 -0800 (PST)
Date:   Wed, 1 Mar 2023 07:43:33 +0000
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
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
Message-ID: <Y/8CJQGNuMUTdLwP@localhost>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-19-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227173632.3292573-19-surenb@google.com>
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

On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrote:
> Write-locking VMAs before isolating them ensures that page fault
> handlers don't operate on isolated VMAs.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c  | 1 +
>  mm/nommu.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1f42b9a52b9b..f7ed357056c4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  static inline int munmap_sidetree(struct vm_area_struct *vma,
>  				   struct ma_state *mas_detach)
>  {
> +	vma_start_write(vma);
>  	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);

I may be missing something, but have few questions:

	1) Why does a writer need to both write-lock a VMA and mark the VMA detached
	   when unmapping it, isn't it enough to just only write-lock a VMA?

	2) as VMAs that are going to be removed are already locked in vma_prepare(),
	   so I think this hunk could be dropped?

>  	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
>  		return -ENOMEM;
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 57ba243c6a37..2ab162d773e2 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>  		       current->pid);
>  		return -ENOMEM;
>  	}
> +	vma_start_write(vma);
>  	cleanup_vma_from_mm(vma);

	3) I think this hunk could be dropped as Per-VMA lock depends on MMU anyway.

Thanks,
Hyeonggon

>  
>  	/* remove from the MM's tree and list */
> @@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
>  	 */
>  	mmap_write_lock(mm);
>  	for_each_vma(vmi, vma) {
> +		/*
> +		 * No need to lock VMA because this is the only mm user and no
> +		 * page fault handled can race with it.
> +		 */
>  		cleanup_vma_from_mm(vma);
>  		delete_vma(mm, vma);
>  		cond_resched();
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 
> 
