Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7D64B812
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiLMPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiLMPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:07:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0A692188A;
        Tue, 13 Dec 2022 07:07:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D157E2F4;
        Tue, 13 Dec 2022 07:08:33 -0800 (PST)
Received: from [10.57.87.129] (unknown [10.57.87.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115063F71E;
        Tue, 13 Dec 2022 07:07:50 -0800 (PST)
Message-ID: <741b64c2-0b09-6475-5736-d2cd3e33c34c@arm.com>
Date:   Tue, 13 Dec 2022 15:07:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-GB
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221213140724.8612-5-quic_sibis@quicinc.com>
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

On 2022-12-13 14:07, Sibi Sankar wrote:
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Any access
> to this region by the application processor after assigning it to the
> remote Q6 will result in a XPU violation. Fix this by replacing the
> dynamically allocated memory region with a no-map carveout and unmap the
> modem metadata memory region before passing control to the remote Q6.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> The addition of the carveout and memunmap is required only on SoCs that
> mandate memory protection before transferring control to Q6, hence the
> driver falls back to dynamic memory allocation in the absence of the
> modem metadata carveout.

The DMA_ATTR_NO_KERNEL_MAPPING stuff is still broken and pointless, so 
I'd expect to see this solution replacing it, not being added alongside. 
It's just silly to say pass the "I don't need a CPU mapping" flag, then 
manually open-code the same CPU mapping you would have got if you 
hadn't, in a way that only works at all when a cacheable alias exists 
anyway.

Thanks,
Robin.

>   drivers/remoteproc/qcom_q6v5_mss.c | 85 +++++++++++++++++++++---------
>   1 file changed, 61 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index fddb63cffee0..8264275ecbd0 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -211,6 +211,7 @@ struct q6v5 {
>   	size_t mba_size;
>   	size_t dp_size;
>   
> +	phys_addr_t mdata_phys;
>   	phys_addr_t mpss_phys;
>   	phys_addr_t mpss_reloc;
>   	size_t mpss_size;
> @@ -935,6 +936,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>   {
>   	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
>   	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> +	void *mdata_region;
>   	struct page **pages;
>   	struct page *page;
>   	dma_addr_t phys;
> @@ -951,34 +953,48 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>   	if (IS_ERR(metadata))
>   		return PTR_ERR(metadata);
>   
> -	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!page) {
> -		kfree(metadata);
> -		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> -		return -ENOMEM;
> -	}
> +	if (qproc->mdata_phys) {
> +		mdata_region = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
> +		if (!mdata_region) {
> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
> +				&qproc->mdata_phys, size);
> +			ret = -EBUSY;
> +			goto free_dma_attrs;
> +		}
>   
> -	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> -	if (!pages) {
> -		ret = -ENOMEM;
> -		goto free_dma_attrs;
> -	}
> +		memcpy(mdata_region, metadata, size);
> +		memunmap(mdata_region);
> +		phys = qproc->mdata_phys;
> +	} else {
> +		page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +		if (!page) {
> +			kfree(metadata);
> +			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> +			return -ENOMEM;
> +		}
>   
> -	for (i = 0; i < count; i++)
> -		pages[i] = nth_page(page, i);
> +		count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +		pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> +		if (!pages) {
> +			ret = -ENOMEM;
> +			goto free_dma_attrs;
> +		}
>   
> -	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> -	kfree(pages);
> -	if (!vaddr) {
> -		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> -		ret = -EBUSY;
> -		goto free_dma_attrs;
> -	}
> +		for (i = 0; i < count; i++)
> +			pages[i] = nth_page(page, i);
>   
> -	memcpy(vaddr, metadata, size);
> +		vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> +		kfree(pages);
> +		if (!vaddr) {
> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> +			ret = -EBUSY;
> +			goto free_dma_attrs;
> +		}
>   
> -	vunmap(vaddr);
> +		memcpy(vaddr, metadata, size);
> +
> +		vunmap(vaddr);
> +	}
>   
>   	/* Hypervisor mapping to access metadata by modem */
>   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -1008,7 +1024,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>   			 "mdt buffer not reclaimed system may become unstable\n");
>   
>   free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> +	if (!qproc->mdata_phys)
> +		dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>   	kfree(metadata);
>   
>   	return ret < 0 ? ret : 0;
> @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>   	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>   	qproc->mpss_size = resource_size(&r);
>   
> +	if (!child) {
> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
> +	} else {
> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
> +		node = of_parse_phandle(child, "memory-region", 0);
> +		of_node_put(child);
> +	}
> +
> +	if (!node)
> +		return 0;
> +
> +	ret = of_address_to_resource(node, 0, &r);
> +	of_node_put(node);
> +	if (ret) {
> +		dev_err(qproc->dev, "unable to resolve metadata region\n");
> +		return ret;
> +	}
> +
> +	qproc->mdata_phys = r.start;
> +
>   	return 0;
>   }
>   
