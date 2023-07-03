Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFC8745586
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGCGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:37:26 -0400
Received: from out-2.mta0.migadu.com (out-2.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9DBA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:37:24 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:37:13 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688366240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgtl3KNejjhGEFo01vKVSysKHUjXjywDSUtFXciTS1E=;
        b=n/Jxl3fbSyGprRr6uYBzHo7yc4dLFYDR4dt+n80peUyflF+Xzu8sLTlg8sU2GQebeUGJnM
        ClNEb5IjHUFQe4DEO2UOm5mp84wX4ZV2Sd/afQdnzXxVygoHwj3lqPOC0LGCYwJp0YOrMM
        a3sECEZhChEr1HkaNUBlrLdOEwhSMzk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: fix potential page refcnt leak in
 memory_failure()
Message-ID: <20230703063713.GA3012709@ik1-406-35019.vs.sakura.ne.jp>
References: <20230701072837.1994253-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230701072837.1994253-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 03:28:37PM +0800, Miaohe Lin wrote:
> put_ref_page() is not called to drop extra refcnt when comes from madvise
> in the case pfn is valid but pgmap is NULL leading to page refcnt leak.

Is this test scenario realistic one?  I don't think that we can call madvise() for
such a device memory page.  If this is the case, this issue can be thought as
potentioal one (so no need to send to stable). 

> 
> Fixes: 1e8aaedb182d ("mm,memory_failure: always pin the page in madvise_inject_error")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Anyway, the patch looks good to me. Thanks you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/memory-failure.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e245191e6b04..65e2d4c5b50d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2080,8 +2080,6 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  {
>  	int rc = -ENXIO;
>  
> -	put_ref_page(pfn, flags);
> -
>  	/* device metadata space is not recoverable */
>  	if (!pgmap_pfn_valid(pgmap, pfn))
>  		goto out;
> @@ -2157,6 +2155,7 @@ int memory_failure(unsigned long pfn, int flags)
>  
>  		if (pfn_valid(pfn)) {
>  			pgmap = get_dev_pagemap(pfn, NULL);
> +			put_ref_page(pfn, flags);
>  			if (pgmap) {
>  				res = memory_failure_dev_pagemap(pfn, flags,
>  								 pgmap);
> -- 
> 2.33.0
> 
> 
> 
