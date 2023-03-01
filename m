Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826DA6A67D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCAHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:02:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF532E7B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:02:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso11005284pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3wu5/hA45huVzW4HMjx8Pxv25mjeuJerMIQ0CD8yO0=;
        b=atM6j7nQoRJ1fx1ZnTgRJdjPFZ5QuebiC4qPDEvQBz+lBOWXyYd0SoEg1mOG6AY29/
         c5Z+UXhpjoM5M58ByHFZ7bnfeMBt6hDczwuOTIpqh1WFSLSSne49d3Msw1uLPJM4iOu/
         /xsyT0/ivvmjPEQDhOJMp/b1DSSqyqMOcLYyZJ1Luit54Ff5PhbJN2P49DbReWskMzyt
         AQAbSWmSV3rNhqJiRchUONDIi/JjBb1qaFHcZOEm/vT7LapjP61OjGibFHfgVHRcGKOR
         qVO8jOtj6tRbMle2blLi8k9Jc0Uw77wwaGOZtXyBGLcuv+SFQl5eqYDo67d/+a6seR3Y
         gxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3wu5/hA45huVzW4HMjx8Pxv25mjeuJerMIQ0CD8yO0=;
        b=QQ+t9+SfA1G9rta1JS0XOa+zg9w3/vrqUPyc/vfJbvIsnslqsRSCJYc7M5xHxV2fXg
         lu2u+Ihbraa17hsD4HAmXYsMgwhN+79EYnw+d6VKtjs/lJ/xHaLvhXdS4PWF7apUs/1m
         NeL5f+gi4eY1kEp6krHHJhw5xGheW5y3bc3H/6gRjK0ehRHNsIZ6s84+er7gTyLRYdcN
         iuSVxHpbCDXKFchgI2Tw+WeqCZGC8qv1E9rz267AVI0SrMk18NScDlTFSCtoYnr2TWnI
         /Uikq0+2RJtKVKps95vO3lILVbB670G/8OnCOl81yvfo+wFe3z/k+GTJczba3Vw4FEYN
         wTzQ==
X-Gm-Message-State: AO0yUKVDd1G8NyKig1qCKB1f6KNCDhEb4CqXx7qmrQXs93bJCtRj/E7D
        1Yoc7hcM8XUVX/Y6QsBbCrc=
X-Google-Smtp-Source: AK7set/gVrc9ripGXC/S0wswKbJY6lWDLcBFGqWvgNzQqQxJBKZiJediguAZ0r6H1m0xT+8MkCf8ZQ==
X-Received: by 2002:a17:902:dacf:b0:19c:f232:21ca with SMTP id q15-20020a170902dacf00b0019cf23221camr6828944plx.3.1677654119534;
        Tue, 28 Feb 2023 23:01:59 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b0019a95764e68sm7552966plm.294.2023.02.28.23.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:01:58 -0800 (PST)
Date:   Wed, 1 Mar 2023 07:01:44 +0000
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
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Laurent Dufour <laurent.dufour@fr.ibm.com>
Subject: Re: [PATCH v4 17/33] mm/mremap: write-lock VMA while remapping it to
 a new address range
Message-ID: <Y/74WA6JLPWAZ/G6@localhost>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-18-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227173632.3292573-18-surenb@google.com>
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

On Mon, Feb 27, 2023 at 09:36:16AM -0800, Suren Baghdasaryan wrote:
> Write-lock VMA as locked before copying it and when copy_vma produces
> a new VMA.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
> ---
>  mm/mmap.c   | 1 +
>  mm/mremap.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e73fbb84ce12..1f42b9a52b9b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3189,6 +3189,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  			get_file(new_vma->vm_file);
>  		if (new_vma->vm_ops && new_vma->vm_ops->open)
>  			new_vma->vm_ops->open(new_vma);
> +		vma_start_write(new_vma);

Oh, it's to prevent handling page faults during move_page_tables().


>  		if (vma_link(mm, new_vma))
>  			goto out_vma_link;
>  		*need_rmap_locks = false;
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 1ddf7beb62e9..327c38eb132e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -623,6 +623,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  			return -ENOMEM;
>  	}
>  
> +	vma_start_write(vma);
>  	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
>  	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
>  			   &need_rmap_locks);
> -- 
> 2.39.2.722.g9855ee24e9-goog

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> 
