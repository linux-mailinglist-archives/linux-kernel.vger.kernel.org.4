Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249376DBFFA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDIN0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:26:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748F272D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OZVpjqYnjuACauM9dYm5rZuanWGcBCJRaWS6vvh56mc=; b=LTidLx3YJKz6L2/YqZcM4/TvJo
        MxnNdECkcnCpX7TQB9g3+0xKm0yGmLMfeVqPk3hqUEEgaK1iHrqO3ZV20rzx3oKqht5IPVBrgZ7J1
        Zp+80QvnBGq3CGQMrJoush05Yb1g2w/gHswBAF6MGB1jIjb3n8wDcIBlQE1QEtBwwhKhnNZmLfYsc
        4mXNBlo6QwYZHHlXKWN6Vr/oqcpx8wossUib3SCfafqiFZ46OVY2i107dIa/N24+gz+WglIER6PWA
        w8ltEcnX3i7QUsyUJBBb520Ey17L8DmlJC7SPBqxnH834c0mvqL1eZQfcFPJU0coim/x0keU8Biqz
        dctLkJNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1plV3q-002jDf-Ec; Sun, 09 Apr 2023 13:26:26 +0000
Date:   Sun, 9 Apr 2023 14:26:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        mgorman@suse.de, rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 5/9] x86/clear_pages: add clear_pages()
Message-ID: <ZDK9AoX6rRVJZD5s@casper.infradead.org>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-6-ankur.a.arora@oracle.com>
 <20230406082304.GE386572@hirez.programming.kicks-ass.net>
 <878rf4jz1x.fsf@oracle.com>
 <20230407103444.GB430894@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407103444.GB430894@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:34:44PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 05:50:18PM -0700, Ankur Arora wrote:
> > 
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > On Sun, Apr 02, 2023 at 10:22:29PM -0700, Ankur Arora wrote:
> > >> Add clear_pages() and define the ancillary clear_user_pages().
> > >>
> > >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > >> ---
> > >>  arch/x86/include/asm/page.h    | 6 ++++++
> > >>  arch/x86/include/asm/page_32.h | 6 ++++++
> > >>  arch/x86/include/asm/page_64.h | 9 +++++++--
> > >>  3 files changed, 19 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
> > >> index d18e5c332cb9..03e3c69fc427 100644
> > >> --- a/arch/x86/include/asm/page.h
> > >> +++ b/arch/x86/include/asm/page.h
> > >> @@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
> > >>  	clear_page(page);
> > >>  }
> > >>
> > >> +static inline void clear_user_pages(void *page, unsigned long vaddr,
> > >> +				    struct page *pg, unsigned int nsubpages)
> > >> +{
> > >> +	clear_pages(page, nsubpages);
> > >> +}
> > >
> > > This seems dodgy, clear_user* has slightly different semantics. It needs
> > > the access_ok() and stac/clac thing on at the very least.
> > 
> > That can't be right. On x86, clear_user_page(), copy_user_page() (and
> > now the multi-page versions) only write to kernel maps of user pages.
> > That's why they can skip the access_ok(), stac/clac or uacess
> > exception handling.
> 
> Bah, that namespace is a mess :/

What (I think) it's suppsoed to be is that clear_page() works on kernel
pages that are never seen by userspace while clear_user_page() works
on kernel mappings of pages the user can definitely see.  This makes
no difference to x86, but some architectures can skip a lot of cache
flushing.
