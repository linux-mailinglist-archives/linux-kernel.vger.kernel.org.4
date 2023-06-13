Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1B72ECE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjFMU3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjFMU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA86135
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OrA3nYHV2kwtLgffjhCAj6EA13cg0ZzpKIffYzucd0E=; b=i02TPBLcl/8+jUdcAWBPDrs58l
        XaKvEIeljpEDQ8Fguis2DrCIlAj+XXtPocmj0DR+MUnQj/s54891p80EczYtu3AgZipgx4rD21vLy
        tLgOv5x0kIoUj69wiQcHxvfxj4rbNQtAGzO17bRHux34sxqw2bdDhbUu5RJZaziKRqNj9bL6VxS/q
        JE8f4LgTrfwzlg4WqGVrtasBME9YyoyYToAnQVpnulasmSGwFh4ey6vXw2H1t0Nv4Cq48kAiZnSrR
        UZnBtGy75jlVH622X/5L+Q41Hqn/QF9bjpdqPEaUSp9aIxV8y5MjqH5LkiALMMY1Cpn5wKj2eGY+o
        L4yyKKTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Adr-004Ik4-2D; Tue, 13 Jun 2023 20:29:27 +0000
Date:   Tue, 13 Jun 2023 21:29:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/gup.c: Reorganize try_get_folio()
Message-ID: <ZIjRpy1qBJGOxciw@casper.infradead.org>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
 <20230613201827.9441-5-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201827.9441-5-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:18:26PM -0700, Vishal Moola (Oracle) wrote:
>  struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>  {
> +	struct folio *folio;

checkpatch will whinge about there not being a blank line here, and in
this case, I think it's correct.

>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
>  		return NULL;
>  
> +	folio = try_get_folio(page, refs);
> +
>  	if (flags & FOLL_GET)
> -		return try_get_folio(page, refs);
> -	else if (flags & FOLL_PIN) {
> -		struct folio *folio;
> +		return folio;
>  
> -		/*
> -		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
> -		 * right zone, so fail and let the caller fall back to the slow
> -		 * path.
> -		 */
> -		if (unlikely((flags & FOLL_LONGTERM) &&
> -			     !is_longterm_pinnable_page(page)))
> -			return NULL;
> +	if (unlikely(!(flags & FOLL_PIN))) {
> +		WARN_ON_ONCE(1);
> +		return NULL;

Don't we need to folio_put_refs() in this case?  Or rather, I think the

	if (WARN_ON_ONCE(flags & (FOLL_PIN|FOLL_GET) == 0) {

test should be first.

> +	/*
> +	 * CAUTION: Don't use compound_head() on the page before this
> +	 * point, the result won't be stable.
> +	 */

I think we can lose the comment at this point?

> +	if (!folio)
> +		return NULL;
