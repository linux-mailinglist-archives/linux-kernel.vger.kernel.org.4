Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8076E4F33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDQR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:27:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598E1FE9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+tuJX1We1PoACh/ojLaOjM7tDLHm8IU9UAe1VlYXWPI=; b=bUnZZH0kAE3IObO93zsnJUTx41
        wqOIdkHeJO2hWJQZyfOojZIZqzPzpCp0fsa29aGznFH48P8Qdvl7JrD3GRgYLxGfnk/mPt7b3Cj89
        +SeKo8+FjmHnHu+f+fIMcS2e0HYFWRkax+q6pn714X11WW2hLGmlmH2eaNwxOGAoFht2uzVW8WKop
        Kh85oRyH+MHYIcT3nvMfC63wbVPFAfhTuzU28qiZ/7wvffCoh57nHHDCWjUbX1Ad2JxHhSFKZHbPX
        Z0osQ5va9P6+UmQgr9eYCkOKHdOHAtbeskZXAMDmLoAUjKYXtpeR+0l72zB1FoXmxnawTiVq47bhq
        k1iWoXLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poScf-00BXC2-Vu; Mon, 17 Apr 2023 17:26:38 +0000
Date:   Mon, 17 Apr 2023 18:26:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD2BTZ5qDYgp/46E@casper.infradead.org>
References: <20230415000818.1955007-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415000818.1955007-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
>  	/*
> -	 * We don't do accounting for some specific faults:
> -	 *
> -	 * - Unsuccessful faults (e.g. when the address wasn't valid).  That
> -	 *   includes arch_vma_access_permitted() failing before reaching here.
> -	 *   So this is not a "this many hardware page faults" counter.  We
> -	 *   should use the hw profiling for that.
> -	 *
> -	 * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
> -	 *   once they're completed.
> +	 * Do not account for incomplete faults (VM_FAULT_RETRY). They will be

I don't think you need the "(VM_FAULT_RETRY)" here.

> @@ -5180,21 +5186,22 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
>  vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned int flags, struct pt_regs *regs)
>  {
> +	/* Copy vma->vm_mm in case mmap_lock is dropped and vma becomes unstable. */

How about:

	/* If the fault handler drops the mmap_lock, vma may be freed */

> +	struct mm_struct *mm = vma->vm_mm;
