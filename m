Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298F06BCCAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCPKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCPKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:25:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99EBBCBA1;
        Thu, 16 Mar 2023 03:24:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A025C2F4;
        Thu, 16 Mar 2023 03:25:04 -0700 (PDT)
Received: from [10.57.54.201] (unknown [10.57.54.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C7F3F67D;
        Thu, 16 Mar 2023 03:24:19 -0700 (PDT)
Message-ID: <44d364bc-62ac-7d31-b886-0f7ee94e3a08@arm.com>
Date:   Thu, 16 Mar 2023 10:24:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dma-debug: small dma_debug_entry's comment and
 variable name updates
Content-Language: en-GB
To:     Desnes Nunes <desnesn@redhat.com>, iommu@lists.linux.dev,
        linux-scsi@vger.kernel.org, storagedev@microchip.com,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, jejb@linux.ibm.com, jsnitsel@redhat.com
References: <20230315192130.970021-1-desnesn@redhat.com>
 <20230315192130.970021-2-desnesn@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230315192130.970021-2-desnesn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 19:21, Desnes Nunes wrote:
> Small update on dma_debug_entry's struct commentary and also standardize
> the usage of 'dma_addr' variable name from debug_dma_map_page() on
> debug_dma_unmap_page(), and similarly on debug_dma_free_coherent()
> 
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
>   kernel/dma/debug.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 18c93c2276ca..e0ad8db1ec25 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -52,7 +52,8 @@ enum map_err_types {
>   /**
>    * struct dma_debug_entry - track a dma_map* or dma_alloc_coherent mapping
>    * @list: node on pre-allocated free_entries list
> - * @dev: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coherent
> + * @dev: pointer to the device driver

The original comment was correct...

> + * @dev_addr: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coherent

...and the address is clearly not the argument representing the device, 
since it is an address :/

Thanks,
Robin.

>    * @size: length of the mapping
>    * @type: single, page, sg, coherent
>    * @direction: enum dma_data_direction
> @@ -1262,13 +1263,13 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   }
>   EXPORT_SYMBOL(debug_dma_mapping_error);
>   
> -void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
> +void debug_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
>   			  size_t size, int direction)
>   {
>   	struct dma_debug_entry ref = {
>   		.type           = dma_debug_single,
>   		.dev            = dev,
> -		.dev_addr       = addr,
> +		.dev_addr       = dma_addr,
>   		.size           = size,
>   		.direction      = direction,
>   	};
> @@ -1403,13 +1404,13 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
>   }
>   
>   void debug_dma_free_coherent(struct device *dev, size_t size,
> -			 void *virt, dma_addr_t addr)
> +			 void *virt, dma_addr_t dma_addr)
>   {
>   	struct dma_debug_entry ref = {
>   		.type           = dma_debug_coherent,
>   		.dev            = dev,
>   		.offset		= offset_in_page(virt),
> -		.dev_addr       = addr,
> +		.dev_addr       = dma_addr,
>   		.size           = size,
>   		.direction      = DMA_BIDIRECTIONAL,
>   	};
