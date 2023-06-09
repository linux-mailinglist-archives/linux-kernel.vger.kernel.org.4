Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2172A408
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFIUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjFIUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:03:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23D210D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:03:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39c7f78c237so888050b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686340989; x=1688932989;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRHbZHM11tMZIbHCANoNbk0Dr/SrecuO1LYm99EHhK4=;
        b=pKopmHpvLeR2joACRQv/ngHApkhi7F77iUQjLzlcpcRbo811qWJ5hAHeevhQvRLtyI
         HTwZMl88uQywWblTh/gCI7s3E48tvaIbifTvtg6ILE6YNjJAfl8M8zs+OOGhZSAos1Ox
         9FXL4bozv1Nn+387JrzoA+UoxIaxmWCFkTCmZ+WpP8Mu0epo74fPgCfKZlgV0bMrXwZw
         ST2f4F3DrLK8DBfmJ1d7JDQYK/zo2Xl3avD9AbwgPyo6PqRIJAZdvgOuEsq52804TsDt
         P3MUcNRYchtpmATdOKOBQURRdfWZBasxJh1w14WF/4O8Htc+iec+juBDjLV2ClLcANlw
         fI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340989; x=1688932989;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRHbZHM11tMZIbHCANoNbk0Dr/SrecuO1LYm99EHhK4=;
        b=kCrJEWksxsbjLezGIHcv1v0k8NmVZCd/TWDNDiYaUm3aAAFN/CoSz9TW/g0ziuLdOJ
         XC0AS5JVwxJ1XwKmqkhlpr7A4rG5GN1JIH59jj4F7VhEJ2CdCUA/XZ/xJGVs3bL8rEty
         PfIkXhCyLVxQEzG1mjSb1XIfokZvj/rIKqnKI6R8hxyE4xWUrpJPcfvH4crBy93WIX4C
         fuFenXEjdRWEZPN7BP4unK9WMVz/70gndENMkZbxG7tvvtscyS8MHlNAQMB65gzMU49x
         kHBojYi9/Hz+7Yc4HsUKJtNYfgIw6gdfdA0/+1cVWaLtN2bSQBYYqb5Q9kBvg3oXfeo/
         aaGw==
X-Gm-Message-State: AC+VfDzS+pnrx8FlK8quxuPrr7MqUlzw4gVAWHNAPmVHHGxhMxI2kPpP
        B1YQTFbZ4MhMVN8WRzqDbxkZUQ==
X-Google-Smtp-Source: ACHHUZ7ztmiTxP5Bz5ivt78H90m8jQbJXcKOudfas683UnOJYkelXLZWc/vYZCmwqAIDfFXZ6saujg==
X-Received: by 2002:a05:6359:d1c:b0:123:3f86:fa66 with SMTP id gp28-20020a0563590d1c00b001233f86fa66mr2382047rwb.5.1686340989284;
        Fri, 09 Jun 2023 13:03:09 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t69-20020a0dea48000000b00568d63f4b46sm791921ywe.133.2023.06.09.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:03:08 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:02:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Stevens <stevensd@chromium.org>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix iteration in collapse_file
In-Reply-To: <20230607053135.2087354-1-stevensd@google.com>
Message-ID: <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com>
References: <20230607053135.2087354-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023, David Stevens wrote:
> 
> Remove an unnecessary call to xas_set(index) when iterating over the
> target range in collapse_file. The extra call to xas_set reset the xas
> cursor to the top of the tree, causing the xas_next call on the next
> iteration to walk the tree to index instead of advancing to index+1.
> This returned the same page again, which would cause collapse_file to
> fail because the page is already locked.
> 
> This bug was hidden when CONFIG_DEBUG_VM was set. When that config was
> used, the xas_load in a subsequent VM_BUG_ON assert would walk xas from
> the top of the tree to index, causing the xas_next call on the next loop
> iteration to advance the cursor as expected.
> 
> Fixes: a2e17cc2efc7 ("mm/khugepaged: maintain page cache uptodate flag")
> Signed-off-by: David Stevens <stevensd@chromium.org>

This patch seems to be wrong, but I have not investigated why.

It's certainly an interesting and worrying observation,
if a CONFIG_DEBUG_VM=y kernel goes a significantly different way.

I almost always do have CONFIG_DEBUG_VM=y, so you won't be surprised that
I never saw the issue.  But once I ran an mm-everything with this patch in,
I hit that VM_BUG_ON_PAGE(page != xas_load(&xas), page) for the first time
(after about 2 hours of huge tmpfs swapping load).

As if you have just transferred the problem from DEBUG_VM=n to DEBUG_VM=y.
But I then tried a CONFIG_DEBUG_VM off 6.4-rc1 kernel (including the fixee
but not this fixer) under similar load, and saw no problem in 14 hours.
So I can't even reproduce the bug that is being fixed here: only hit a
bug that it introduces.

Hugh

> ---
>  mm/khugepaged.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b9d39d65b73..2d0d58fb4e7f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2070,7 +2070,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  					TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
>  
>  		xas_lock_irq(&xas);
> -		xas_set(&xas, index);
>  
>  		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
>  
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
