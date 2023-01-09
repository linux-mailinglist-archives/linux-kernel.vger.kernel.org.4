Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF72661FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjAIISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjAIISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:18:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4EB64E7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:18:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w3so8713734ply.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s513E4dErzOS7TZdSXS86SQPydYzgshBqtf/+wa1x4E=;
        b=L6mq5UmjA2YzxuvR0EpoEO1abZqE9g9ZP71jkxJRpO8UlcZi6AnlU07KnrUcRwQgdx
         m0hNjXZDmVTgRgjChcNHJ09O6Oc/On6JwUs+jmAVSKt1C/qdfoZAf02SzxZ7LzkQpPgz
         W/sf+zknQpuAY3LXRKDrwvXLCSGH/3a7/3epciI6s0S6DafB4hj8uhQLAkMmFdsEP2in
         DboyVlktXhiMHL75W3fDNSg0mPh3Nvsv5YJsLRDUd9954cDm/9YqQ4XtNow1ZRmVxs8M
         J3sbBIXW6GXyNzwR91p+p8+6a31Fkor776Aviw0VGKiJCYQxdFczA6VmwANJ7ype3Vtr
         Oh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s513E4dErzOS7TZdSXS86SQPydYzgshBqtf/+wa1x4E=;
        b=aSIcn4jyu8UjktroUOXniimCROn8DUjNlqVKo3vvbgS7oBAV/mrcNn10AB05s396cn
         CpUBG2HLnfzuKg94xjQjjmYCfQgYRMsGE41Y6Tm9Qeo+84TaZDEkJpN3ss2VffiaCYkn
         jH9/jKqWZaRPbVBG6lwIKVUrF0reUCUDCMIErR3564kK8RHfO7HcIwCsYSNWaaQCgJaA
         Uj2RWkSacW6mk3JfM+vEfOF+S6k4Z30jgg+p9uaUDM//8aHRL5GYgoQFxxNC6JFz70EB
         vv6VnahrCHovHdK61NPaji0/JfaG7dtdPyZuaJGze2nw0A6mU5CCivn5GjSjB7C3ylbd
         +9Kg==
X-Gm-Message-State: AFqh2kqVYa4VmxqMRvvuUEi/UwRGYC4Xj1n8tRz2slz1hV3wDQl95i+x
        NfpszREyUXIZQUDMAaZ2CqM4cTxgbGGiuOs=
X-Google-Smtp-Source: AMrXdXs8AKMvnXxMrUQDy6esHiyJWQEv/AV0sLSY3/lKfqwIyYnflbG4wWhx8N/FOgcUqHVJ8uMytQ==
X-Received: by 2002:a05:6a20:3a84:b0:b5:cc98:153c with SMTP id d4-20020a056a203a8400b000b5cc98153cmr3746328pzh.24.1673252322777;
        Mon, 09 Jan 2023 00:18:42 -0800 (PST)
Received: from thinkpad ([117.217.177.135])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b00192cf87ed25sm5500117plg.35.2023.01.09.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:18:41 -0800 (PST)
Date:   Mon, 9 Jan 2023 13:48:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, robin.murphy@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        hch@lst.de
Subject: Re: [PATCH V2 05/11] remoteproc: qcom_q6v5_mss: revert "map/unmap
 metadata region before/after use"
Message-ID: <20230109081832.GA4966@thinkpad>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-6-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109034843.23759-6-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Christoph

Hi Sibi,

On Mon, Jan 09, 2023 at 09:18:37AM +0530, Sibi Sankar wrote:
> This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.
> 
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Hence as a
> precursor to using reserved memory for modem metadata region, revert back
> to the simpler way of dynamic memory allocation.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Christoph already submitted a patch that reverts fc156629b23a:
https://lore.kernel.org/linux-arm-msm/20221223092703.61927-2-hch@lst.de/

Thanks,
Mani

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 2f4027664a0e..e2f765f87ec9 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -10,7 +10,6 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/devcoredump.h>
> -#include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -961,52 +960,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
>  static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  				const char *fw_name)
>  {
> -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
> -	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> -	struct page **pages;
> -	struct page *page;
> +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
>  	dma_addr_t phys;
>  	void *metadata;
>  	int mdata_perm;
>  	int xferop_ret;
>  	size_t size;
> -	void *vaddr;
> -	int count;
> +	void *ptr;
>  	int ret;
> -	int i;
>  
>  	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> -	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!page) {
> +	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +	if (!ptr) {
>  		kfree(metadata);
>  		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>  		return -ENOMEM;
>  	}
>  
> -	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> -	if (!pages) {
> -		ret = -ENOMEM;
> -		goto free_dma_attrs;
> -	}
> -
> -	for (i = 0; i < count; i++)
> -		pages[i] = nth_page(page, i);
> -
> -	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> -	kfree(pages);
> -	if (!vaddr) {
> -		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> -		ret = -EBUSY;
> -		goto free_dma_attrs;
> -	}
> -
> -	memcpy(vaddr, metadata, size);
> -
> -	vunmap(vaddr);
> +	memcpy(ptr, metadata, size);
>  
>  	/* Hypervisor mapping to access metadata by modem */
>  	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -1036,7 +1010,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> +	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
