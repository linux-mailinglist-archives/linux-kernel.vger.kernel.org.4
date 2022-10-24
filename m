Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69538609C18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJXIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJXIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:10:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DF320370
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UwtyZS/lYmNxfO8IfzbqIzyAUJEvEF9ONCF2NviYd8Y=; b=Fcvm9olpUulVNJSzwt/lYCJUHg
        vZyRSpuk/rl/rVPUPnWQgh9oyUq/fO4f1EGBwkbgr+zXM6ZI1d0h2vhSopYTmlby14THJGywG61c2
        YRnyf7Zh4mc5vkO4/YmkkOa7uxTetB7pVBoZX/TlpBqdkU7BgR4ZYEaFoWpLwSN05y6TVI0pGVoM7
        kdy+WNZCIv6yVa6qm/1jrMAhrRoZBl/NJWfU2l2HXfFVuna428CejJjhilF+bWQaSq/NAFK8JpkDi
        hAmD+p0KBIuBcO5ZzQ/KFTBl6CWnv9sQ4weuDAe+V1tk9OLc+XcAXjQC4xwyaly9GKscjRWV7NztT
        oZw0j77g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omsX2-00FGt5-Am; Mon, 24 Oct 2022 08:10:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F37C300242;
        Mon, 24 Oct 2022 10:09:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 203AD2C2328BB; Mon, 24 Oct 2022 10:09:55 +0200 (CEST)
Date:   Mon, 24 Oct 2022 10:09:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 04/13] mm: Fix pmd_read_atomic()
Message-ID: <Y1ZIU8eL3ieeXmDS@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.711181252@infradead.org>
 <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 10:30:51AM -0700, Linus Torvalds wrote:
> On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -258,6 +258,13 @@ static inline pte_t ptep_get(pte_t *ptep
> >  }
> >  #endif
> >
> > +#ifndef __HAVE_ARCH_PMDP_GET
> > +static inline pmd_t pmdp_get(pmd_t *pmdp)
> > +{
> > +       return READ_ONCE(*pmdp);
> > +}
> > +#endif
> 
> What, what, what?
> 
> Where did that __HAVE_ARCH_PMDP_GET come from?

Copy/paste like from ptep_get(), that has __HAVE_ARCH_PTEP_GET (which
does appear to get used, once).

Do I break the pattern and simply leave this off, or do I stay
consistent even though we hate it a little? ;-)
