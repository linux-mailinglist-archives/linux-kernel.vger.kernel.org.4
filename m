Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19927407CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjF1Bvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF1Bvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:51:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C9296D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:51:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QrPgp2HjGz1HCB4;
        Wed, 28 Jun 2023 09:51:18 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 09:51:33 +0800
Subject: Re: [PATCH v2] mm: memory-failure: remove unneeded page state check
 in shake_page()
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230628014604.3432146-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <df9eb561-2650-b58b-d39d-a4f4d90f1846@huawei.com>
Date:   Wed, 28 Jun 2023 09:51:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230628014604.3432146-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 9:46, Miaohe Lin wrote:
> Remove unneeded PageLRU(p) and is_free_buddy_page(p) check as slab caches
> are not shrunk now. This check can be added back when a lightweight range
> based shrinker is available.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Sorry for make noise. Acked-by tag is missing. Will re-post one.

> ---
> v2:
>   put TODO comment together with "if (PageSlab)" block per Naoya
>   collect Acked-by tag per Naoya
> ---
>  mm/memory-failure.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5b663eca1f29..66e7b3ceaf2d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -372,17 +372,14 @@ void shake_page(struct page *p)
>  {
>  	if (PageHuge(p))
>  		return;
> -
> -	if (!PageSlab(p)) {
> -		lru_add_drain_all();
> -		if (PageLRU(p) || is_free_buddy_page(p))
> -			return;
> -	}
> -
>  	/*
>  	 * TODO: Could shrink slab caches here if a lightweight range-based
>  	 * shrinker will be available.
>  	 */
> +	if (PageSlab(p))
> +		return;
> +
> +	lru_add_drain_all();
>  }
>  EXPORT_SYMBOL_GPL(shake_page);
>  
> 

