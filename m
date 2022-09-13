Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FD5B691C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiIMH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:59:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85345A3C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZSuHqErBdLq/WjJ+4mcD880q8RV5cT2VvtIHCgGu7tA=; b=XKsiu+BkB0bgK7rldV7WiuPw5j
        e66tuTB0BowARIzVPTyQblNFQnpVVLLnFOW70jgMgJRCelISL57ZGUGsuG9B/hSGvZwCrNDqJYi3V
        wQntdW3RfHV800/1iU4ZBPCSYkRzPDa2goPomk3ijOTcBrahxNxz3sUiiv1PSaijRi6Sdr51LbQBt
        40k6K/mBev1+LP+HHeHoArRbGWNmSEMP/sPHZ3OHKO0CqL3kRKjYDhCoE449sFZOco5xjQ6oWTdeL
        8gKb6s7WQH3pCqcKYDrNLCnOIZOz9aI+cpiqbrTmBnGP3eZx++sp4ZifobZk32K4gaONjb3jJqfvQ
        XsX7HcXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY0op-00GhZw-Km; Tue, 13 Sep 2022 07:58:55 +0000
Date:   Tue, 13 Sep 2022 08:58:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm/page_alloc: ensure kswapd doesn't accidentally
 go to sleep
Message-ID: <YyA4Pz8hnnTsomUh@casper.infradead.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-2-linmiaohe@huawei.com>
 <ea96d35e-46ae-c168-3186-ddf58ad6806c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea96d35e-46ae-c168-3186-ddf58ad6806c@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:32:50PM +0530, Anshuman Khandual wrote:
> 
> 
> On 9/9/22 14:54, Miaohe Lin wrote:
> > If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
> > kswapd doesn't accidentally go to sleep. But when reserve_flags is
> > set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
> > Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
> > go to sleep accidentally.
> 
> Currently wake_all_kswapds() gets skipped subsequently if ALLOC_KSWAPD
> is lost, but this only happens when the 'retry:' loops is taken ?

Right, but see the comment:

        /* Ensure kswapd doesn't accidentally go to sleep as long as we loop */

and that is not currently true.  I think that was an inadvertent change.
Particularly since the changelog for 0a79cdad5eb2 says "No functional
change".

> > 
> > Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/page_alloc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index ba5c9402a5cb..4b97a03fa2dd 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5147,7 +5147,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  
> >  	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
> >  	if (reserve_flags)
> > -		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
> > +		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
> > +					  (alloc_flags & ALLOC_KSWAPD);
> >  
> >  	/*
> >  	 * Reset the nodemask and zonelist iterators if memory policies can be
> 
