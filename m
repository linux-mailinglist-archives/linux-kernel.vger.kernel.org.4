Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496F27016D4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjEMNOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjEMNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:14:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456363C39
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:14:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so56914355e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683983661; x=1686575661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KScg4ydCaUpShKuw7MCg69AXYFIohUjFbKBvL+ntZ4c=;
        b=fru4WBJFozuJiW7li8qmMR6SqWTExWH9KYH9ot9EMkzBgywJGHGPAYTXhcVjfJ0wn/
         8iDLYVxJf0YME4AHr9WfrySF9zZyuNYVOKJczQiqZ/KnzzJTBvWUKzOzmzY3pbRhcyM2
         5BJpoIeWehf1zOH8M26AjCMq1HpJe1cVuhmHvYXxDaNue4GIg4/RKjV53xMPd7P5BVKb
         6RisXKsCRPnd98WlzEq1U6/FAmzagUxVvF8JKsOPX5ky++/5Psgoeotx4gLU7xCD0SCf
         beAhH7mHuFmr3asVygACGMJz9yIrp4g+H4btpTXqNh7mHr5ns2F/FcoaMyaWUhO6pFm+
         yt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683983661; x=1686575661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KScg4ydCaUpShKuw7MCg69AXYFIohUjFbKBvL+ntZ4c=;
        b=YMcC0Z/rbyMFvY6XaIOF725ldXCAojASMu+aStv78loIavyPYgpaCXrfRvMvKHF/mg
         hQg31L60GXTJ7J6UNGpJq09cEfCnVL3FC4rMVg1NzMKNOqAHwictxkgOaNVeBsoPb5k6
         wkZBggg+8f7nKr7JtfK3kM/DW6xS84aZ/DfmhtJWaWUN4rNOXAIWsKr6yPn6TS6NYM6N
         l6C54t35P5Jai4LBtYIRHdjDR9bA6I6tFDdXZn5IICxNVC0LK+rYNfN+hujxeh9AqKNz
         KDRoGq8IK3MokupNjajm3smi75Qo9mNBDXisOnh/i39cPYgPfLGWJCnlxsgljBc9WCB6
         9U5w==
X-Gm-Message-State: AC+VfDyrYGjrhoetxoNEYlvNfCQNeKNZoQN5VLN5EQ6JaS/CwoN2AFXl
        V9k36Nf4LzTMhFHz4tGrNT4=
X-Google-Smtp-Source: ACHHUZ6GzE4EtDYDWvxFIutm/k122S95nAwJ4sg8r+G2b7K9rajmoRg+0Exa9qsZwr3ZRfT2MnPrCQ==
X-Received: by 2002:a7b:c4c3:0:b0:3f1:75ae:1cfe with SMTP id g3-20020a7bc4c3000000b003f175ae1cfemr19040929wmk.7.1683983661254;
        Sat, 13 May 2023 06:14:21 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm15878056wmj.23.2023.05.13.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:14:19 -0700 (PDT)
Date:   Sat, 13 May 2023 14:14:18 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511132113.80196-2-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You've not cc'd the vmalloc reviewers, including the author of 3e9a9e256b1e
whose patch you purport to fix. Please remember to run get_maintainers.pl
on all files you patch and cc them at least on relevant patches.

Have added Christoph + Uladzislau as cc.

You'll definitely want an ack from Christoph on this!

On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to validate
> (and potentially modify) the operation.

This does make sense, and I see for example in xtensa that an arch-specific
instruction is issued under certain circumstances so I do suspect we should
do this.

As for validation, the function never indicates an error, so only in the
sense that a WARN_ON() could _in theory_ trigger is it being
validated. This might be quite a nitty point :) as set_pte_at() has no
means of indicating an error. But maybe to be pedantic 'check' rather than
'validate'?

>
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")

Not sure if this is really 'fixing' anything, I mean ostensibly, but not
sure if the tag is relevant here, that is more so for a bug being
introduced, and unless an issue has arisen not sure if it's
appropriate. But this might be a nit, again!

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9683573f1225..d8d2fe797c55 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
>  {
>  	struct vmap_pfn_data *data = private;
> +	pte_t ptent;
>
>  	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
>  		return -EINVAL;
> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +
> +	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +	set_pte_at(&init_mm, addr, pte, ptent);

While we're refactoring, it'd be nice to stash data->pfns[data->idx] into a
local pfn variable.

>  	return 0;
>  }
>
> --
> 2.25.1
>
