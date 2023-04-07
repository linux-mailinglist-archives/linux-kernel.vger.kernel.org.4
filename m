Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4E6DAB8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDGKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDGKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:35:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A179768
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Dh0X11LhsMIL/llzoSRk+89So8t9R/DJ91aQRLwQ2Q=; b=VZm/PMaLXgstJ4IH5UdXBsgVVr
        c6OMMQI49QFP+fuRLT/FiVq1ASDppgQMAX6aWDPUPb+1nUfY9MSi2IaiNPre90cTAgfAWYE4HNFzq
        Ncg1SPTLZjvnyOwvLXlThRLaFBl35D7gIKvQegYq33SvptveYh2nnOIdlCBbgidfr4NTmFFDKwEUX
        jcSQf7Bop/vJqzTPyD+Exa2c41iPf+H+de8IqiMqA79Y2mvlQJPCXK419lB2etBuX3u0yJ9DCM/at
        fo3wKpzVOx1gAvRwVfJuiOYUCS2sFsttWo494Xc7+0tJ7uQaAjBy5ZdfQVM88iGPZLIFYFgGZLWed
        xltQWm9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkjQc-000lmj-84; Fri, 07 Apr 2023 10:34:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC519300070;
        Fri,  7 Apr 2023 12:34:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0C032625093E; Fri,  7 Apr 2023 12:34:44 +0200 (CEST)
Date:   Fri, 7 Apr 2023 12:34:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 5/9] x86/clear_pages: add clear_pages()
Message-ID: <20230407103444.GB430894@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-6-ankur.a.arora@oracle.com>
 <20230406082304.GE386572@hirez.programming.kicks-ass.net>
 <878rf4jz1x.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rf4jz1x.fsf@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:50:18PM -0700, Ankur Arora wrote:
> 
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Sun, Apr 02, 2023 at 10:22:29PM -0700, Ankur Arora wrote:
> >> Add clear_pages() and define the ancillary clear_user_pages().
> >>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  arch/x86/include/asm/page.h    | 6 ++++++
> >>  arch/x86/include/asm/page_32.h | 6 ++++++
> >>  arch/x86/include/asm/page_64.h | 9 +++++++--
> >>  3 files changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> >> index d18e5c332cb9..03e3c69fc427 100644
> >> --- a/arch/x86/include/asm/page.h
> >> +++ b/arch/x86/include/asm/page.h
> >> @@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
> >>  	clear_page(page);
> >>  }
> >>
> >> +static inline void clear_user_pages(void *page, unsigned long vaddr,
> >> +				    struct page *pg, unsigned int nsubpages)
> >> +{
> >> +	clear_pages(page, nsubpages);
> >> +}
> >
> > This seems dodgy, clear_user* has slightly different semantics. It needs
> > the access_ok() and stac/clac thing on at the very least.
> 
> That can't be right. On x86, clear_user_page(), copy_user_page() (and
> now the multi-page versions) only write to kernel maps of user pages.
> That's why they can skip the access_ok(), stac/clac or uacess
> exception handling.

Bah, that namespace is a mess :/
