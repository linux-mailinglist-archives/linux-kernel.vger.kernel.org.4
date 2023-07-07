Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956274B718
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjGGT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGGT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E02108;
        Fri,  7 Jul 2023 12:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7879461A53;
        Fri,  7 Jul 2023 19:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E3C433C7;
        Fri,  7 Jul 2023 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688758071;
        bh=b/nwBttY6PR9kozBothsfSykputrrbxrsvZzb9AG8AU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wCvnlZrBJGLSDJgRrLUP8aaVEj7mKzHi5Xl7RY9sPfO9gEXCFboDs+BkPgdm2xi0U
         qL//eHQGQ5spOtGzccOdBx8sBHY0HKSffBwQhpYq8PjujN2Vd0UGqPG6Lc8/DJ+Zij
         +4ML/Rvc8EsrL1/Or79/KAuP6drfMI7GStW6KqrU=
Date:   Fri, 7 Jul 2023 12:27:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, ldufour@linux.ibm.com, hughd@google.com,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        rientjes@google.com, axelrasmussen@google.com, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] mm: lock a vma before stack expansion
Message-Id: <20230707122750.f7cd77fe19b625cff37423ed@linux-foundation.org>
In-Reply-To: <20230707043211.3682710-1-surenb@google.com>
References: <20230707043211.3682710-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 21:32:10 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> With recent changes necessitating mmap_lock to be held for write while
> expanding a stack, per-VMA locks should follow the same rules and be
> write-locked to prevent page faults into the VMA being expanded. Add
> the necessary locking.

What are the possible runtime effects of this change?

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1977,6 +1977,8 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		return -ENOMEM;
>  	}
>  
> +	/* Lock the VMA before expanding to prevent concurrent page faults */
> +	vma_start_write(vma);
>  	/*
>  	 * vma->vm_start/vm_end cannot change under us because the caller
>  	 * is required to hold the mmap_lock in read mode.  We need the
> @@ -2064,6 +2066,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  		return -ENOMEM;
>  	}
>  
> +	/* Lock the VMA before expanding to prevent concurrent page faults */
> +	vma_start_write(vma);
>  	/*
>  	 * vma->vm_start/vm_end cannot change under us because the caller
>  	 * is required to hold the mmap_lock in read mode.  We need the
> -- 
> 2.41.0.255.g8b1d071c50-goog
