Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6DD60C1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJYCxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJYCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:53:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48725120EF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:53:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MxGZw2bxcz15M0R;
        Tue, 25 Oct 2022 10:48:08 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:52:59 +0800
Subject: Re: [PATCH 1/3] mm: memory-failure: make put_ref_page() more useful
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <96b39919-7054-7378-a6ab-a20401458d7c@huawei.com>
Date:   Tue, 25 Oct 2022 10:52:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/21 16:46, Kefeng Wang wrote:
> Pass pfn/flags to put_ref_page(), then check MF_COUNT_INCREASED
> and drop refcount to make the code look cleaner.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory-failure.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index bead6bccc7f2..b94152abb1c9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1913,17 +1913,25 @@ static inline unsigned long free_raw_hwp_pages(struct page *hpage, bool flag)
>  }
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
> +/* Drop the extra refcount in case we come from madvise() */
> +static void put_ref_page(unsigned long pfn, int flags)
> +{
> +	struct page *page;
> +
> +	if (!(flags & MF_COUNT_INCREASED))
> +		return;
> +
> +	page = pfn_to_page(pfn);
> +	if (page)

IMO above check is unneeded. Page can't be NULL as pfn is valid. But this is trival and this patch looks
good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


