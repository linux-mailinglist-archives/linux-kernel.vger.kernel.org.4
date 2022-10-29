Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D76122DB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ2MVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ2MV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:21:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A841983
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IfP1Qw2e94i2vcWcWqeSNfaT2mFnnnpFCfGWKZkG+Tg=; b=L8XrnVEvbQEbZSmlFqt8LyKmNC
        o1mEHhFIAA89yUMZCwvE8whAxfz+r9zcHiyS/br/H48mvUT9Kn3GkgvuYTkZVSPBPGoGkH4CEiumq
        YJpAInoUjF6s1LpXSDkYW0rVVcDcRaQEgmzgj4lKNwSkAwnC4rpA0JzlmmaA7BE/HN+D5FfCW2/Lc
        BC7WmLXwkww6wR0F0q8i4F7OUr2/oEaDUxr1CiCoIzWSAQ8jKfPvunYecOGMyOJpItZR7tJVyQSXy
        KWFvSutV/hh1sh3E4LHra0TO5XndPbeia8spQm2zOiOLLg4pNE6jnxlPutp4NO6TY9RkDOtPrdMyh
        Xp7wWVcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ookpp-007LjK-Fu; Sat, 29 Oct 2022 12:21:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C0D030010B;
        Sat, 29 Oct 2022 14:21:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CEA12C67A917; Sat, 29 Oct 2022 14:21:08 +0200 (CEST)
Date:   Sat, 29 Oct 2022 14:21:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 00/13] Clean up pmd_get_atomic() and i386-PAE
Message-ID: <Y10atFd3sn1s1C6x@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022111403.531902164@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 01:14:03PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> At long *long* last a respin of the patches that clean up pmd_get_atomic() and
> i386-PAE. I'd nearly forgotten why I did this, but the old posting gave clue
> that patch #7 was the whole purpose of me doing these patches.
> 
> Having carried these patches for at least 2 years, they recently hit a rebase
> bump against the mg-lru patches, which is what prompted this repost.
> 
> Linus' comment about try_cmpxchg64() (and Uros before him) made me redo those
> patches (see patch #10) which resulted in pxx_xchg64(). This in turn led to
> killing off set_64bit().
> 
> The robot doesn't hate on these patches and they boot in kvm (because who still
> has i386 hardware).
> 
> Patches also available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/mm.pae

Aside from the whole discussions about TLB invalidates; I mean to commit
these patches to tip/x86/mm next week somewhere since they do improve
the current situation.

Holler if there's objections.
