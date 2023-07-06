Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058DF749C61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGFMsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGFMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:48:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8226D1FF9;
        Thu,  6 Jul 2023 05:47:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxbnV4YfyzMqTH;
        Thu,  6 Jul 2023 20:44:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 20:47:28 +0800
Subject: Re: [PATCH RFC net-next v4 5/9] libie: add Rx buffer management (via
 Page Pool)
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-6-aleksander.lobakin@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <138b94a7-c186-bdd9-e073-2794760c9454@huawei.com>
Date:   Thu, 6 Jul 2023 20:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230705155551.1317583-6-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/5 23:55, Alexander Lobakin wrote:

> +/**
> + * libie_rx_page_pool_create - create a PP with the default libie settings
> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
> + * @size: size of the PP, usually simply Rx queue len
> + *
> + * Returns &page_pool on success, casted -errno on failure.
> + */
> +struct page_pool *libie_rx_page_pool_create(struct napi_struct *napi,
> +					    u32 size)
> +{
> +	struct page_pool_params pp = {
> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order		= LIBIE_RX_PAGE_ORDER,
> +		.pool_size	= size,
> +		.nid		= NUMA_NO_NODE,
> +		.dev		= napi->dev->dev.parent,
> +		.napi		= napi,
> +		.dma_dir	= DMA_FROM_DEVICE,
> +		.offset		= LIBIE_SKB_HEADROOM,

I think it worth mentioning that the '.offset' is not really accurate
when the page is split, as we do not really know what is the offset of
the frag of a page except for the first frag.

> +	};
> +	size_t truesize;
> +
> +	pp.max_len = libie_rx_sync_len(napi->dev, pp.offset);
> +
> +	/* "Wanted" truesize, passed to page_pool_dev_alloc() */
> +	truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset + pp.max_len));
> +	pp.init_arg = (void *)truesize;

I am not sure if it is correct to use pp.init_arg here, as it is supposed to
be used along with init_callback. And if we want to change the implemetation
of init_callback, we may stuck with it as the driver is using it very
differently here.

Is it possible to pass the 'wanted true size' by adding a parameter for
libie_rx_alloc()?

> +
> +	return page_pool_create(&pp);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
