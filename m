Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21468E58D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBHBrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBHBrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:47:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2E5FD3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:47:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g13so12852207ple.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 17:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjZgcroriwsEugk9weWmwBjNRJc6RS0hv55s25nO4rI=;
        b=T3Rnvod+sGjsj4Tp/F4rNsfDkPXTVmQKBueGwJ6rbffiNG3ks34G1SvONwjbbpKSLx
         K+aMl/olK6iozVZB51N7ov4qxoGCUcZBbDcc1w7U8kKQLGvoStlIamTHhU3Y3tMVXsQ2
         dwJV0Ik729AAGrh3WdwN1AMG+YeI6rvaleYvbndhh1/CGcVapI9TA7J8GqdJ+71qYHNv
         IN9Y5weECLfx5f0egpHIdWT3WSoDownqAQoNz1uTzumQKUU7zFyxshcwHYxy1z7YKEd5
         Trx94brejc8JavIrW8fWP36rkAMfgMsI0utsNzWJSsd0mzipVcsuKJSCJxgFNlUbpAXr
         DElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjZgcroriwsEugk9weWmwBjNRJc6RS0hv55s25nO4rI=;
        b=h270jcPIR4gx4jAlrskjjJ9vHLInARku26iCAOpjr8UjGbQnEeW/e5UyXfqwyN+mNZ
         CgTSOyxf+5U0Ql/yeeN/trgs99gd0HFxfMKJtiyNAIexGuvqp7f6yhUABWAxktbv1Tj0
         2NCvWSPfVGqQ4lo4cCKHUwlz0DTasDLzbJ+dQchF/HIIa0wrInNB45KAZjmKmk6ePLx/
         xXe/R9n4QNOA6O9W6wsT7OmLtqAJwCSThQA5vsW4GpdsgmERNaDQ/t0Pop7umpH1snfY
         S5CzYL95L4NZEUWuCNBfBDSve6pMKccI+YRiRJ7XSoLvAsA/fqa5YVfawvUMp9+lbomY
         kaQQ==
X-Gm-Message-State: AO0yUKUb6eUMHWgTLlpcllxokd1u1OfgmL2QLTFtd4Rkn+CvoWh1IKlU
        GkYia7192EFY6433/q5sCeY=
X-Google-Smtp-Source: AK7set+Rx8bwFJXZPUypnmLEaScqNCFoHUGKQdnDDCzWzsSJ8ehu9pZaOgXwJDEoM4zRSDGCA3KG3A==
X-Received: by 2002:a17:90b:1652:b0:22c:46a1:67ca with SMTP id il18-20020a17090b165200b0022c46a167camr6033526pjb.37.1675820821100;
        Tue, 07 Feb 2023 17:47:01 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a2dcc00b00230a50e6eadsm198397pjm.24.2023.02.07.17.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:46:58 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:46:46 +0000
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
Subject: Re: [PATCH 1/1] mm: introduce vm_flags_reset_once to replace
 WRITE_ONCE vm_flags updates
Message-ID: <Y+L/BubSzdbpTS4P@localhost>
References: <20230201000116.1333160-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201000116.1333160-1-surenb@google.com>
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

On Tue, Jan 31, 2023 at 04:01:16PM -0800, Suren Baghdasaryan wrote:
> Provide vm_flags_reset_once() and replace the vm_flags updates which used
> WRITE_ONCE() to prevent compiler optimizations.
> 
> Fixes: 0cce31a0aa0e ("mm: replace vma->vm_flags direct modifications with modifier calls")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Notes:
> - The patch applies cleanly over mm-unstable
> - The SHA in Fixes: line is from mm-unstable, so is... unstable
> 
>  include/linux/mm.h | 7 +++++++
>  mm/mlock.c         | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5bf0ad48faaa..23ce04f6e91e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -648,6 +648,13 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
>  	vm_flags_init(vma, flags);
>  }
>  
> +static inline void vm_flags_reset_once(struct vm_area_struct *vma,
> +				       vm_flags_t flags)
> +{
> +	mmap_assert_write_locked(vma->vm_mm);
> +	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
> +}
> +
>  static inline void vm_flags_set(struct vm_area_struct *vma,
>  				vm_flags_t flags)
>  {
> diff --git a/mm/mlock.c b/mm/mlock.c
> index ed49459e343e..617469fce96d 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -380,7 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  	 */
>  	if (newflags & VM_LOCKED)
>  		newflags |= VM_IO;
> -	vm_flags_reset(vma, newflags);
> +	vm_flags_reset_once(vma, newflags);
>  
>  	lru_add_drain();
>  	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
> @@ -388,7 +388,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  
>  	if (newflags & VM_IO) {
>  		newflags &= ~VM_IO;
> -		vm_flags_reset(vma, newflags);
> +		vm_flags_reset_once(vma, newflags);
>  	}
>  }

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 
