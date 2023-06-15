Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003DD7312ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbjFOJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbjFOJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:01:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E22119;
        Thu, 15 Jun 2023 02:01:13 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qhbmx0nxlztR1c;
        Thu, 15 Jun 2023 16:58:41 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 17:01:11 +0800
Subject: Re: [PATCH net-next] page pool: not return page to alloc cache during
 pool destruction
To:     Liang Chen <liangchen.linux@gmail.com>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
References: <20230615013645.7297-1-liangchen.linux@gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5296508e-5008-b5bb-ac2e-a0a69b720954@huawei.com>
Date:   Thu, 15 Jun 2023 17:01:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230615013645.7297-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/15 9:36, Liang Chen wrote:
> When destroying a page pool, the alloc cache and recycle ring are emptied.
> If there are inflight pages, the retry process will periodically check the
> recycle ring for recently returned pages, but not the alloc cache (alloc
> cache is only emptied once). As a result, any pages returned to the alloc
> cache after the page pool destruction will be stuck there and cause the
> retry process to continuously look for inflight pages and report warnings.

It seems there is still page_pool_put[_full]_page() called with
allow_direct being true after page_pool_destroy() is call, which
is not allowed.

Normally the driver will call napi_disable() before
page_pool_destroy() to ensure there is no such page_pool_destroy()
calling with allow_direct being true after page_pool_destroy() is
called.

> 
> To safeguard against this situation, any pages returning to the alloc cache
> after pool destruction should be prevented.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3e12a61d456..76255313d349 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -595,7 +595,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  			page_pool_dma_sync_for_device(pool, page,
>  						      dma_sync_size);
>  
> -		if (allow_direct && in_softirq() &&
> +		if (allow_direct && in_softirq() && !pool->destroy_cnt &&

The checking seems racy when  __page_pool_put_page() and
page_pool_destroy() are called concurently.

>  		    page_pool_recycle_in_cache(page, pool))
>  			return NULL;
>  
> 
