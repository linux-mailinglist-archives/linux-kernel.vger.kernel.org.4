Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E539E66BC94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjAPLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAPLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:14:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB13110CE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:14:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so30020888pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/j+1WOB2+poIU0zjjNXAinFoRjK1wRjx3d+XHMefVA=;
        b=IKaS1mlsXdKP2qLzqb0Dyj556UOX3zeMPhPIirCQcTt3qQS2nyTrw1H+PTDeBL8zuV
         HM5hqzwdA1j2S+Owv380uXh4elme5UhoOwMxL5rwB6SEfOxqFisy3kf5PXKswLa2DQwZ
         ZbSg85c+dciT9fX+W0S917eX6PiPq8JsRiD7hiEgNGE0uDyd/QyqjwINAVDHmul8StHU
         g7sLEfykA1+gfNGZH3mWj1DPNJa/IpRkv5amvYAt97kyPizVZeEvRvSNKrRlkvJJAMDV
         n1yK9QwW5Xy/Z8sceRkhjoRr36n6xdiEOnqDkWDzss1yFAf2tXJokS2p8uBJx8DvUK4b
         8mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/j+1WOB2+poIU0zjjNXAinFoRjK1wRjx3d+XHMefVA=;
        b=qbDxcQpc3a6nqIk3q+Xpf3KpDldUwVkULjrAA7RJCe/O8GQKwVl37jU+M+rjePBy+U
         lNbJyCrVo7co6BpGvLY1Cd3zAKYC6/PE+ERZYffIyA86yZFNIvuY4RFQcrsEXA3WaICB
         SN10XM7eddqct03MYkHtsjMN2FPpz7YupENNePfed0adxGT9MyVHqRDj7n4egyyXm5E9
         aAi/sVb5AiSpsYPB80Xn8dxl38a1GxRp4YYMEFtiNQgqlboItCYwiHXP3ekS+zpZDVZl
         iBOhUpj3HDQOgFq4/cHT/kMlUDDC9EIDv4rO6PN9kMYgr7VlnRWfKmkVVvibKAfh7oVz
         f2ZA==
X-Gm-Message-State: AFqh2kpXObOoQQj7Eyz5SpSspZPVnZhO7aRtZ0lOMp8s4JrEHfvqI/lS
        2RTH211MsUAzJK4ayP2HN8k=
X-Google-Smtp-Source: AMrXdXuQRd6wOjQtljWK07qYLraoNulCoayDZNQpKT3xAcTulISKZqIOzMvtWPVA3/M2jPRTkeVMbA==
X-Received: by 2002:a05:6a20:5489:b0:b0:b870:54e1 with SMTP id i9-20020a056a20548900b000b0b87054e1mr140691094pzk.12.1673867695716;
        Mon, 16 Jan 2023 03:14:55 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id 3-20020a621503000000b00581c741f95csm16176892pfv.46.2023.01.16.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:14:54 -0800 (PST)
Date:   Mon, 16 Jan 2023 11:14:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
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
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8UxnqPCTLbbD+2F@localhost>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109205336.3665937-42-surenb@google.com>
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

On Mon, Jan 09, 2023 at 12:53:36PM -0800, Suren Baghdasaryan wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d40bf8a5e19e..294dd44b2198 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -627,12 +627,16 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
>  	 * mm->mm_lock_seq can't be concurrently modified.
>  	 */
>  	mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
> -	if (vma->vm_lock_seq == mm_lock_seq)
> +	if (vma->vm_lock->lock_seq == mm_lock_seq)
>  		return;
>  
> -	down_write(&vma->vm_lock->lock);
> -	vma->vm_lock_seq = mm_lock_seq;
> -	up_write(&vma->vm_lock->lock);
> +	if (atomic_cmpxchg(&vma->vm_lock->count, 0, -1))
> +		wait_event(vma->vm_mm->vma_writer_wait,
> +			   atomic_cmpxchg(&vma->vm_lock->count, 0, -1) == 0);
> +	vma->vm_lock->lock_seq = mm_lock_seq;
> +	/* Write barrier to ensure lock_seq change is visible before count */
> +	smp_wmb();
> +	atomic_set(&vma->vm_lock->count, 0);
>  }
>  
>  /*
> @@ -643,20 +647,28 @@ static inline void vma_write_lock(struct vm_area_struct *vma)
>  static inline bool vma_read_trylock(struct vm_area_struct *vma)
>  {
>  	/* Check before locking. A race might cause false locked result. */
> -	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
> +	if (vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
>  		return false;
>  
> -	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> +	if (unlikely(!atomic_inc_unless_negative(&vma->vm_lock->count)))
>  		return false;
>  
> +	/* If atomic_t overflows, restore and fail to lock. */
> +	if (unlikely(atomic_read(&vma->vm_lock->count) < 0)) {
> +		if (atomic_dec_and_test(&vma->vm_lock->count))
> +			wake_up(&vma->vm_mm->vma_writer_wait);
> +		return false;
> +	}
> +
>  	/*
>  	 * Overflow might produce false locked result.
>  	 * False unlocked result is impossible because we modify and check
>  	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
>  	 * modification invalidates all existing locks.
>  	 */
> -	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> -		up_read(&vma->vm_lock->lock);
> +	if (unlikely(vma->vm_lock->lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
> +		if (atomic_dec_and_test(&vma->vm_lock->count))
> +			wake_up(&vma->vm_mm->vma_writer_wait);
>  		return false;
>  	}

With this change readers can cause writers to starve.
What about checking waitqueue_active() before or after increasing
vma->vm_lock->count?

--
Thanks,
Hyeonggon
