Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06CE66089E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjAFVKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAFVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:10:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67C809AE;
        Fri,  6 Jan 2023 13:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=we4WDla0B8D5etYJgGObevY0Omm564e2/Rat8mfhIu8=; b=5ERgl2DunrlCdl8nOHQFtVlztA
        ATQ3XG5oc9WnvC+DpHMRjx/pttuvsqpDlixP0IUlt/jypqVuGrFMboJYX4+zshs0u8aEu8MQajtaj
        K0viwhjiJXNMcRL3yB0VngEh57qRj1oT1sbmZoDjYIoAhGZSt00QMZICq57ZwFzSeTaJHQptx8mEi
        yHuc+OYRwtQjr2nGZ0TDXe4g1k3DndTTSWH5gpYtv2rWbGp+07qFIQWJYeMe9iZbHNP0gPU7IB+Aj
        9Xw8cZq2iDQddEPvLkIBZDLN4ed91jigdCK11oAaxjUDCMMWYDVYejAGcaE164H1XQPFux4Kq4Yvr
        5HpcLSjQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDtyf-00EyFG-IH; Fri, 06 Jan 2023 21:10:14 +0000
Message-ID: <fe3cb716-b787-f8ce-7a52-d4152445fbdc@infradead.org>
Date:   Fri, 6 Jan 2023 13:10:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] include/linux/mm: fix release_pages_arg kernel doc
 comment
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <20230106203331.127532-1-sj@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230106203331.127532-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/23 12:33, SeongJae Park wrote:
> Commit 449c796768c9 ("mm: teach release_pages() to take an array of
> encoded page pointers too") added the kernel doc comment for
> release_pages() on top of 'union release_pages_arg', so making 'make
> htmldocs' complains as below:
> 
>     ./include/linux/mm.h:1268: warning: cannot understand function prototype: 'typedef union '
> 
> The kernel doc comment for the function is already on top of the
> function's definition in mm/swap.c, and the new comment is actually not
> for the function but indeed release_pages_arg.  Fixing the comment to
> reflect the intent would be one option.  But, kernel doc cannot parse
> the union as below due to the attribute.
> 
>     ./include/linux/mm.h:1272: error: Cannot parse struct or union!
> 
> Modify the comment to reflect the intent but do not mark it as a kernel
> doc comment.
> 
> Fixes: 449c796768c9 ("mm: teach release_pages() to take an array of encoded page pointers too")
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/mm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2bf261cdbef..3df8815f6d51 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1297,10 +1297,10 @@ static inline void folio_put_refs(struct folio *folio, int refs)
>  		__folio_put(folio);
>  }
>  
> -/**
> - * release_pages - release an array of pages or folios
> +/*
> + * union release_pages_arg - an array of pages or folios
>   *
> - * This just releases a simple array of multiple pages, and
> + * release_pages() releases a simple array of multiple pages, and
>   * accepts various different forms of said page array: either
>   * a regular old boring array of pages, an array of folios, or
>   * an array of encoded page pointers.

-- 
~Randy
