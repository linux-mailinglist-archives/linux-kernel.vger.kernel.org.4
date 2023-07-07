Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED61A74B2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjGGOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjGGOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:10:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAAB2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4y1KiB4O8hGbu3AjjejbE6BG+oeF2nc27k9lwgLOlF8=; b=WZJhiHzqTMhdm4VzAWcQ++MRa/
        q93WzTTCHemzFmR+Z4iz2/btSxpxpcvfsy7cOW3mvgpXmUN5C+WnXCU7hWQVpdIobEc3ixicOV1wV
        StROGC9XO4B4HievV4m193Wp6+Od4skTLFkKFhHme3cQp1/a+ickU9nDauywmtttGFefEwIhQS+jk
        E+PdW3Mt7pTH2Cid5vOZN1StLYlb04f2iYclP1aal4Jcxlke86IjDtqaxXhvLMPs6KEEaWeCig0P7
        hpD5q96lGayFLGTbgpO3H1Qq0X4OAszLoMeP3Z1S8QPi2QhxjoEdz1U7GEyrEi+MEEAo6RLvR10TA
        qPcfcLJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHm9m-00C51p-3N; Fri, 07 Jul 2023 14:09:58 +0000
Date:   Fri, 7 Jul 2023 15:09:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
Message-ID: <ZKgctnmuVbLvYb9d@casper.infradead.org>
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com>
 <ZKgJIlqZk8cw4MBa@casper.infradead.org>
 <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:36:20PM +0530, Pintu Agarwal wrote:
> On Fri, 7 Jul 2023 at 18:16, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 07, 2023 at 03:57:42PM +0530, Anshuman Khandual wrote:
> > > LGTM, cma->name is an identifying attribute for the region for which the allocation
> > > request was made. But how about using cma_get_name() helper instead ? Very few call
> > > sites have been using the helper.
> >
> > It's not really a "helper", is it?  The function name is longer than
> > its implementation.
> >
> > cma_get_name(cma)
> > vs
> > cma->name
> >
> > Plus there's the usual question about whether a "got" name needs to be
> > "put" (does it grab a refcount?)
> >
> > I think it's useful that this function exists since it lets us not expose
> > struct cma outside of mm/, but it really should be called cma_name()
> > and I don't think we should be encouraging its use within cma.c.
> 
> Also, cma_get_name() is a trivial assignment.
> And in one of the previous patches we avoided function calls with
> trivial assignments.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/dma/contiguous.c?h=next-20230705&id=5af638931eb374aa0894d8343cee72f50307ef20
> dma-contiguous: remove dev_set_cma_area
> 
> One more question from here:
> pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
>                 (void *)cma, cma->name, count, align);
> 
> Do we really need this "cma %p" printing ?
> I hardly check it and simply rely on name and count.

Printing pointers is almost always a bad idea.  Printing the base_pfn
might be a good idea to distinguish CMAs which happen to have the
same name?

