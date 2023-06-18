Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD277345E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFRLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:20:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB4E40
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PDfKEQOvoEs+ntOdENvzD9q/MXNZ4PuEsAjU3CrG4JE=; b=jruA45ZxBcAt7/PPzuthy7X1Ms
        H9fn92GCaIhpvFJ30Y1I0m9aHIomePHPVFnqF1c0lM9r8BkIECxB458Jr8blBx5r2ASzlRatJS6bw
        0Yyj2vvmL4MwBgoQIZiZK0fc92RfBFLIBI3OZxbrGxe7ayX+M2+9jPjxYlUH/JFGqqorScfaXXKlg
        svIVwhYfwMuWZwp8gO3JzJVXw/ODpbJQKNFPzWxmbR3KkSRJSw1r5N1x6JQ/OVrli12LsNapKXMfy
        q+sizeZ0uOdhnlmduZYIElH0HDORLlpWd6CL4msuSPYrl/l3asLOA08ne3Ll/OpyPzB9Ma1MPGgmg
        ywjrjPGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qAqS8-00Ajoz-R3; Sun, 18 Jun 2023 11:20:16 +0000
Date:   Sun, 18 Jun 2023 12:20:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm/mlock: rework mlock_count to use _mapcount
 for order-0 folios
Message-ID: <ZI7ocP/Jstx7TNDy@casper.infradead.org>
References: <20230618065744.1363948-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618065744.1363948-1-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 06:57:44AM +0000, Yosry Ahmed wrote:
> @@ -337,6 +318,7 @@ struct folio {
>  			atomic_t _entire_mapcount;
>  			atomic_t _nr_pages_mapped;
>  			atomic_t _pincount;
> +			atomic_t _mlock_count;
>  #ifdef CONFIG_64BIT
>  			unsigned int _folio_nr_pages;
>  #endif

You can't quite do this.  On 32-bt systems (I know, I know ...),
we have:

offset	page 0		page 1
0	flags		flags
4	lru		head
8	lru		dtor+order
12	mapping		entire_mapcount
16	index		nr_pages_napped
20	private		pincount
24	mapcount
28	refcount

so it actually ends up overlapping page->mapcount on the second page,
which is of course used for counting the number of PTEs which map
that specific page.

I don't have a scenario where this would matter, but we are quite
careful to only allocate order-2+ large folios, so I'd suggest putting
it in page 2 instead of page 1.

I should probably add a comment to struct folio warning of this dragon.
I thought the #ifdef CONFIG_64BIT would be enough to warn unwary
passers-by of its presence, but a more explicit sign must be in order.

