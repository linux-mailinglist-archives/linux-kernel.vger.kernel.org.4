Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F86D2ADE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjCaWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0A1FD3E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E134562C22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 22:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F77FC433D2;
        Fri, 31 Mar 2023 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680300271;
        bh=y75tzqtO/00AP4h3NcC3yhpaClgjp49viV/Jpgl25Gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vs6Lz4cAD8QohfCI437uO557Vnvq0b76OWFRvJsAKCHGygOsdzzGReFzksV2buL80
         IHi8KOP1IFpIlRbVJrWEZuv3VitjFuV0Hj64kw1dokZLWh9Gq4bPOQ7hpjnCTQA382
         ex71kxhcZ2X+w+BMMWP0+1G9c6+RY5vpRDAogG8I=
Date:   Fri, 31 Mar 2023 15:04:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     willy@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: swap: use folio_batch_reinit() in
 folio_batch_move_lru()
Message-Id: <20230331150430.546de954b0a7918f042c562e@linux-foundation.org>
In-Reply-To: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
References: <20230331095858.51810-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 17:58:57 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> In folio_batch_move_lru(), the folio_batch is not freshly
> initialised, so it should call folio_batch_reinit() as
> pagevec_lru_move_fn() did before.
> 
> ...
>
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -222,7 +222,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>  	if (lruvec)
>  		unlock_page_lruvec_irqrestore(lruvec, flags);
>  	folios_put(fbatch->folios, folio_batch_count(fbatch));
> -	folio_batch_init(fbatch);
> +	folio_batch_reinit(fbatch);
>  }
>  
>  static void folio_batch_add_and_move(struct folio_batch *fbatch,

Well...  why?  This could leave the kernel falsely thinking that the
folio's pages have been drained from the per-cpu LRU addition
magazines.

Maybe that's desirable, maybe not, but I think this change needs much
much more explanation describing why it is beneficial.


folio_batch_reinit() seems to be a custom thing for the mlock code -
perhaps it just shouldn't exist, and its operation should instead be
open-coded in mlock_folio_batch().


The dynamics and rules around ->percpu_pvec_drained are a bit
mysterious.  A code comment which explains all of this would be
useful.

