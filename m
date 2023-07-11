Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9074ED67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGKLzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGKLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACCE5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689076494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ltfs96G2qWIBv3AataMyvfNvs/ZxeZQ5SXPMZ0jduU=;
        b=WVwBfM8nQFAfiW9lb85+5515meIglI+ow61U+wCER1hpAwAA8/pVvHdTTmpRXSw8gKK0Wz
        1v6pLBmzE5bfUyPcaBtA5/AFzlv8kUj2HnEiDwbEdr3tHO96PIGDjqUym1rm9x5f6fKNCz
        Qjxf+JhWPyXtuFwgcURupXgTpQfIeHY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-Ylr_Riy6P76G1LvI5eFCiQ-1; Tue, 11 Jul 2023 07:54:53 -0400
X-MC-Unique: Ylr_Riy6P76G1LvI5eFCiQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc08d6a40cso18845305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076492; x=1691668492;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ltfs96G2qWIBv3AataMyvfNvs/ZxeZQ5SXPMZ0jduU=;
        b=GHl/bUdfK0eTmoVinHmrjVkjSumQlD2GQdXnuxR4qY1eAAkpWJ3uv9mkXJusP+LYu0
         /kGQPDMiNUQaYk87Sk0GqCxXjw0aWue2Dp/PnptENRa1g4f+5lpBOzGCpo8d3kKD0q2f
         TYZUFUBKycmNohUBHEmM/wxHO8it1Zgpj3lbIENpEpDFrUpqP8xhhgAl2dTxAOJIe+57
         4Za3FUM+FQDxDB5J24VpSNSmSJAMBOyKOb4UqXqATA1zN7orzK7JgPT4FcxF2UVzYHbe
         n9vfl2WSfbKjuu7YZzWnz7/scGi/ZwgMlCmmBdQyLh3kBV/wLdDdTY6wX1QKplsxrrLQ
         GDlg==
X-Gm-Message-State: ABy/qLZNdoyxSoPGBK9DRgOZFDlJTL0A4QAPcPbLkAmuj1oWZQZwqgti
        0boc7CfmD3yaq+c8UVV9r6NesNArp4MT2q6ehY0TJdofqFfjb8MHGtXcADzSsvEQJzynyHMyVYg
        KRExELrvUirx9/KJJjaqWgnl5
X-Received: by 2002:a05:600c:294c:b0:3fb:ffef:d058 with SMTP id n12-20020a05600c294c00b003fbffefd058mr10788100wmd.0.1689076492104;
        Tue, 11 Jul 2023 04:54:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7yk4/9a7qsVmPysU0XyK+niweGp79jZE0baAAQRDb45p7c5tsWj9aND6mntHhLvGNKiIlKw==
X-Received: by 2002:a05:600c:294c:b0:3fb:ffef:d058 with SMTP id n12-20020a05600c294c00b003fbffefd058mr10788078wmd.0.1689076491720;
        Tue, 11 Jul 2023 04:54:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d? (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de. [2003:cb:c745:4000:13ad:ed64:37e6:115d])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003fbaade072dsm2360201wmg.23.2023.07.11.04.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:54:51 -0700 (PDT)
Message-ID: <c7d4364c-a067-567e-3248-6a0589d85472@redhat.com>
Date:   Tue, 11 Jul 2023 13:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dma-contiguous: support numa CMA for specified node
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, corbet@lwn.net, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        akpm@linux-foundation.org, paulmck@kernel.org,
        catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
References: <20230710074944.3501810-1-yajun.deng@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230710074944.3501810-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 09:49, Yajun Deng wrote:
> The kernel parameter 'cma_pernuma=' only supports reserving the same
> size of CMA area for each node. We need to reserve different sizes of
> CMA area for specified nodes if these devices belong to different nodes.
> 
> Change kernel parameter from 'cma_pernuma=' to 'numa_cma='. If node
> isn't specified, it will reserve CMA area for per-numa node. if the node
> is specified, it will reserve CMA area for the specified node.
> 
> At the same time, print the node id in cma_declare_contiguous_nid() if
> enabled CONFIG_NUMA.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   .../admin-guide/kernel-parameters.txt         | 17 ++--
>   kernel/dma/Kconfig                            | 11 +--
>   kernel/dma/contiguous.c                       | 90 +++++++++++++------
>   mm/cma.c                                      | 12 ++-
>   4 files changed, 89 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdf0ab6716c8..b287647f0873 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -695,14 +695,19 @@
>   			altogether. For more information, see
>   			kernel/dma/contiguous.c
>   
> -	cma_pernuma=nn[MG]
> +	numa_cma=nn[MG] or (node format)
> +			    <node>:nn[MG][,<node>:nn[MG]]
>   			[KNL,CMA]
> -			Sets the size of kernel per-numa memory area for
> +			Sets the size of kernel numa memory area for
>   			contiguous memory allocations. A value of 0 disables
> -			per-numa CMA altogether. And If this option is not
> -			specified, the default value is 0.
> -			With per-numa CMA enabled, DMA users on node nid will
> -			first try to allocate buffer from the pernuma area
> +			numa CMA altogether. If this option is not specified,
> +			the default value is 0. If node isn't specified, it
> +			will reserve CMA area for per-numa node, if the node
> +			is specified, it will reserve CMA area for the
> +			specified node.
> +
> +			With numa CMA enabled, DMA users on node nid will
> +			first try to allocate buffer from the numa area
>   			which is located in node nid, if the allocation fails,
>   			they will fallback to the global default memory area.
>   
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 7afde9bc529f..f07fb97ef3e8 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -145,15 +145,16 @@ config DMA_CMA
>   
>   if  DMA_CMA
>   
> -config DMA_PERNUMA_CMA
> -	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"
> +config DMA_NUMA_CMA
> +	bool "Enable separate DMA Contiguous Memory Area for NUMA Node"
>   	default NUMA
>   	help
> -	  Enable this option to get pernuma CMA areas so that NUMA devices
> +	  Enable this option to get numa CMA areas so that NUMA devices
>   	  can get local memory by DMA coherent APIs.
>   
> -	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
> -	  on the kernel's command line.
> +	  You can set the size of pernuma CMA by specifying "numa_cma=size"
> +	  or set the node id and its size of CMA by specifying "numa_cma=
> +	  <node>:size[,<node>:size]" on the kernel's command line.
>   
>   comment "Default contiguous memory area size:"
>   
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 26a8e5365fcd..bf62d78abff7 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -50,6 +50,7 @@
>   #include <linux/sizes.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/cma.h>
> +#include <linux/nospec.h>
>   
>   #ifdef CONFIG_CMA_SIZE_MBYTES
>   #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
> @@ -96,17 +97,44 @@ static int __init early_cma(char *p)
>   }
>   early_param("cma", early_cma);
>   
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> +#ifdef CONFIG_DMA_NUMA_CMA
>   
> -static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> +static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
>   static phys_addr_t pernuma_size_bytes __initdata;
> +static phys_addr_t numa_cma_size_in_node[MAX_NUMNODES] __initdata;
>   
> -static int __init early_cma_pernuma(char *p)
> +static int __init early_numa_cma(char *p)
>   {
> -	pernuma_size_bytes = memparse(p, &p);
> +	int nid, count = 0;
> +	unsigned long tmp;
> +	char *s = p;
> +
> +	while (*s) {
> +		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
> +			break;
> +
> +		if (s[count] == ':') {
> +			if (tmp >= MAX_NUMNODES)
> +				break;
> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
> +
> +			s += count + 1;
> +			tmp = memparse(s, &s);
> +			numa_cma_size_in_node[nid] = tmp;
> +
> +			if (*s == ',')
> +				s++;
> +			else
> +				break;
> +		} else {
> +			pernuma_size_bytes = memparse(p, &p);
> +			break;
> +		}
> +	}
> +
>   	return 0;
>   }
> -early_param("cma_pernuma", early_cma_pernuma);
> +early_param("numa_cma", early_numa_cma);
>   #endif
>   
>   #ifdef CONFIG_CMA_SIZE_PERCENTAGE
> @@ -127,34 +155,42 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>   
>   #endif
>   
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> -static void __init dma_pernuma_cma_reserve(void)
> +#ifdef CONFIG_DMA_NUMA_CMA
> +static void __init dma_numa_cma_reserve(void)
>   {
> +	phys_addr_t size;
>   	int nid;
>   
> -	if (!pernuma_size_bytes)
> -		return;
> -
> -	for_each_online_node(nid) {
> +	for_each_node(nid) {
>   		int ret;
>   		char name[CMA_MAX_NAME];
> -		struct cma **cma = &dma_contiguous_pernuma_area[nid];
> +		struct cma **numa_cma;
>   
> -		snprintf(name, sizeof(name), "pernuma%d", nid);
> -		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> -						 0, false, name, cma, nid);
> -		if (ret) {
> -			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> -				ret, nid);
> +		if (!node_online(nid)) {
> +			if (pernuma_size_bytes || numa_cma_size_in_node[nid])
> +				pr_warn("invalid node %d specified\n", nid);
>   			continue;
>   		}
>   
> -		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
> -			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
> +		if (pernuma_size_bytes)
> +			size = pernuma_size_bytes;
> +		else
> +			size = numa_cma_size_in_node[nid];
> +
> +		if (!size)
> +			continue;
> +
> +		numa_cma = &dma_contiguous_numa_area[nid];
> +		snprintf(name, sizeof(name), "numa%d", nid);
> +		ret = cma_declare_contiguous_nid(0, size, 0, 0, 0, false,
> +						 name, numa_cma, nid);
> +		if (ret)
> +			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> +				ret, nid);
>   	}
>   }
>   #else
> -static inline void __init dma_pernuma_cma_reserve(void)
> +static inline void __init dma_numa_cma_reserve(void)
>   {
>   }
>   #endif
> @@ -175,7 +211,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>   	phys_addr_t selected_limit = limit;
>   	bool fixed = false;
>   
> -	dma_pernuma_cma_reserve();
> +	dma_numa_cma_reserve();
>   
>   	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>   
> @@ -309,7 +345,7 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
>    */
>   struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   {
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> +#ifdef CONFIG_DMA_NUMA_CMA
>   	int nid = dev_to_node(dev);
>   #endif
>   
> @@ -321,9 +357,9 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   	if (size <= PAGE_SIZE)
>   		return NULL;
>   
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> +#ifdef CONFIG_DMA_NUMA_CMA
>   	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
> -		struct cma *cma = dma_contiguous_pernuma_area[nid];
> +		struct cma *cma = dma_contiguous_numa_area[nid];
>   		struct page *page;
>   
>   		if (cma) {
> @@ -362,8 +398,8 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>   		/*
>   		 * otherwise, page is from either per-numa cma or default cma
>   		 */
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> -		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
> +#ifdef CONFIG_DMA_NUMA_CMA
> +		if (cma_release(dma_contiguous_numa_area[page_to_nid(page)],
>   					page, count))
>   			return;
>   #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index 4880f72102fa..af5945932e9e 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -244,6 +244,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>   {
>   	phys_addr_t memblock_end = memblock_end_of_DRAM();
>   	phys_addr_t highmem_start;
> +	char nid_buf[32] = "";

That's a but ugly just for the sake of printing an info/error.


if (!IS_ENABLED(CONFIG_NUMA))
	nid = NUMA_NO_NODE;

...

pr_info("Reserved %ld MiB at %pa on node %d\n", (unsigned long)size /
         SZ_1M, &base, nid);


"on node -1" would certainly be good enough for my taste.

-- 
Cheers,

David / dhildenb

