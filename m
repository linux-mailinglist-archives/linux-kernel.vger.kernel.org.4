Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB11D68627A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjBAJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjBAJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:08:24 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D676185A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:07:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vag58Zn_1675242449;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vag58Zn_1675242449)
          by smtp.aliyun-inc.com;
          Wed, 01 Feb 2023 17:07:30 +0800
Message-ID: <fa50efda-0229-ca8a-cd4d-99ea73dc3f90@linux.alibaba.com>
Date:   Wed, 1 Feb 2023 17:08:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mm/gup: Add folio to list when folio_isolate_lru()
 succeed
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     chinwen.chang@mediatek.com, andrew.yang@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 2:32 PM, Kuan-Ying Lee wrote:
> If we call folio_isolate_lru() successfully, we will get
> return value 0. We need to add this folio to the
> movable_pages_list.
> 
> Fixes: 67e139b02d99 ("mm/gup.c: refactor check_and_migrate_movable_pages()")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Good catch.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f3d2cccb89f8..918c364d01ac 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1914,7 +1914,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>   			drain_allow = false;
>   		}
>   
> -		if (!folio_isolate_lru(folio))
> +		if (folio_isolate_lru(folio))
>   			continue;
>   
>   		list_add_tail(&folio->lru, movable_page_list);
