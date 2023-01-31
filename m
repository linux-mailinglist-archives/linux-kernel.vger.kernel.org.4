Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9D683A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjAaXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAaXRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:17:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FE53558
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:17:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50129CE217B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B71C433D2;
        Tue, 31 Jan 2023 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675207063;
        bh=9gIG6ub4W7Ha8XoJuUw+fr70dVqCYbeFXGcT/33aTxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yYF2fcfJYQ9Oj2bsgYjdQr3rA3MST8yjvB6HjFHEs11Ec+JcfyjhnGzPpD76rdCjh
         5ETkg050rbXW8vogKCM3u0KwtMyLjv5iyGk+TAWBPx3981me5xnnSxTEqV2H004lzh
         Zajar06+fQHk9w6VqMTwtt2D5seDlwEt0Dkx+sBI=
Date:   Tue, 31 Jan 2023 15:17:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        <chinwen.chang@mediatek.com>, <andrew.yang@mediatek.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mm/gup: Add folio to list when folio_isolate_lru()
 succeed
Message-Id: <20230131151742.df43c3fd11bda01b613234ef@linux-foundation.org>
In-Reply-To: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
References: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 14:32:06 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> If we call folio_isolate_lru() successfully, we will get
> return value 0. We need to add this folio to the
> movable_pages_list.
> 
> Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
>
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1914,7 +1914,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>  			drain_allow = false;
>  		}
>  
> -		if (!folio_isolate_lru(folio))
> +		if (folio_isolate_lru(folio))
>  			continue;
>  
>  		list_add_tail(&folio->lru, movable_page_list);

Thanks.  What are the user-visible effects of this bug?

