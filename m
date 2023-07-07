Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC474B2FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjGGOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjGGOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:22:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460B170F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+YSopFfs/Xp1rj/0X1dHDDq/oR8SUXSZqyGCDyjotRc=; b=RQgyGV8dYkwnQHsJe5kgrgMrNG
        JgRzOXyhUHfh1GwD4UYlFoF3sGhBbkB5BWWFBToTIZxbZoO0p2PWs6BGllgvpB2VwmAbVwfqkOX42
        d2JaRl8NWHPUV3ZtzkiINLLt4djx5vePTPhCxCuBytVA+0ucyB7ddt+7GXwf5SE+BzJrXHkrxj3ee
        SWmhbLbe9gI7XqnbgD3Uaae9YDcKGaA1I7uvPJmmpW0pqLwcWQnVwwRYhILcTWYUAjEPjOlcxLjAr
        XkutZI4R956ROn0Y27V0lIeHkB26Vdo9K2WIUHWXVCS8JWq9AWQclmMTXx9hoS0VD0I+FObFCjnLQ
        J4kvhmww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHmLa-00C5Tc-RS; Fri, 07 Jul 2023 14:22:10 +0000
Date:   Fri, 7 Jul 2023 15:22:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
Message-ID: <ZKgfkhOMNT1xDjk+@casper.infradead.org>
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com>
 <ZKgJIlqZk8cw4MBa@casper.infradead.org>
 <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
 <ZKgctnmuVbLvYb9d@casper.infradead.org>
 <CAOuPNLjcBe7iEdJUhLS-kJuCc-uxXarh6o=JiTirGixq+tj+jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLjcBe7iEdJUhLS-kJuCc-uxXarh6o=JiTirGixq+tj+jg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:46:31PM +0530, Pintu Agarwal wrote:
> On Fri, 7 Jul 2023 at 19:40, Matthew Wilcox <willy@infradead.org> wrote:
> > > One more question from here:
> > > pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> > >                 (void *)cma, cma->name, count, align);
> > >
> > > Do we really need this "cma %p" printing ?
> > > I hardly check it and simply rely on name and count.
> >
> > Printing pointers is almost always a bad idea.  Printing the base_pfn
> > might be a good idea to distinguish CMAs which happen to have the
> > same name?
> >
> No there is no name there, it's just a ptrval
> cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)

You misunderstand me.  I don't know how CMAs get their name.  Is it not
possible for two CMAs to have the same name as each other?

