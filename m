Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE76712613
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjEZL4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjEZL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:56:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3669116;
        Fri, 26 May 2023 04:56:12 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSNYk2f5Tz18LY9;
        Fri, 26 May 2023 19:51:38 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 19:56:10 +0800
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator use
 multipage folios
To:     David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>
References: <20230524153311.3625329-1-dhowells@redhat.com>
 <20230524153311.3625329-5-dhowells@redhat.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
Date:   Fri, 26 May 2023 19:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230524153311.3625329-5-dhowells@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2023/5/24 23:33, David Howells wrote:
> Change the page_frag_cache allocator to use multipage folios rather than
> groups of pages.  This reduces page_frag_free to just a folio_put() or
> put_page().

Hi, David

put_page() is not used in this patch, perhaps remove it to avoid
the confusion?
Also, Is there any significant difference between __free_pages()
and folio_put()? IOW, what does the 'reduces' part means here?

I followed some disscusion about folio before, but have not really
understood about real difference between 'multipage folios' and
'groups of pages' yet. Is folio mostly used to avoid the confusion
about whether a page is 'headpage of compound page', 'base page' or
'tailpage of compound page'? Or is there any abvious benefit about
folio that I missed?

> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..d7c52a5979cc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -420,18 +420,13 @@ static inline void *folio_get_private(struct folio *folio)
>  }
>  
>  struct page_frag_cache {
> -	void * va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	__u16 offset;
> -	__u16 size;
> -#else
> -	__u32 offset;
> -#endif
> +	struct folio	*folio;
> +	unsigned int	offset;
>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
>  	 */
> -	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
> +	unsigned int	pagecnt_bias;
> +	bool		pfmemalloc;
>  };

It seems 'va' and 'size' field is used to avoid touching 'stuct page' to
avoid possible cache bouncing when there is more frag can be allocated
from the page while other frags is freed at the same time before this patch?
It might be worth calling that out in the commit log or split it into another
patch to make it clearer and easier to review?
