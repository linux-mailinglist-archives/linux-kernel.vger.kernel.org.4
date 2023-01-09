Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF25662263
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAIKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjAIKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:14 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C28125CE;
        Mon,  9 Jan 2023 02:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1673258437; x=1704794437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+fJR2sAedoWc7HqsxjvIU4JOVkW5oQW3/x8Cb8OtMLE=;
  b=ViNRcoZi8CjB9qgBXa84Ga0hDMVCVYa+wTHtnatG4PppVppHb7J7Ms0c
   WeJaYQYt0RRZV2QEopMqjUfGAe/DG5U1jd6PjgFIYrdPdfG0XFrVXlMEm
   x1FLRVRan4HFxdJncoLR1H/Itc2nQuZJuOqxVccgvbEgZJlsvPKcvY229
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jan 2023 02:00:36 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 02:00:36 -0800
Received: from [10.79.43.91] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 02:00:31 -0800
Message-ID: <92a32081-a521-33c7-72bd-fb8cb307c5bc@quicinc.com>
Date:   Mon, 9 Jan 2023 15:30:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 05/11] remoteproc: qcom_q6v5_mss: revert "map/unmap
 metadata region before/after use"
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <robin.murphy@arm.com>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <hch@lst.de>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-6-quic_sibis@quicinc.com>
 <20230109081832.GA4966@thinkpad>
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230109081832.GA4966@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mani,
Thanks for taking time to review the series.

On 1/9/23 13:48, Manivannan Sadhasivam wrote:
> + Christoph
> 
> Hi Sibi,
> 
> On Mon, Jan 09, 2023 at 09:18:37AM +0530, Sibi Sankar wrote:
>> This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.
>>
>> The memory region allocated using dma_alloc_attr with no kernel mapping
>> attribute set would still be a part of the linear kernel map. Hence as a
>> precursor to using reserved memory for modem metadata region, revert back
>> to the simpler way of dynamic memory allocation.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Christoph already submitted a patch that reverts fc156629b23a:
> https://lore.kernel.org/linux-arm-msm/20221223092703.61927-2-hch@lst.de/

Having ^^ revert as part of the this series makes more sense. I'll
just replace my patch with ^^ in the next re-spin.

> 
> Thanks,
> Mani
> 
>> ---
>>   drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
>>   1 file changed, 6 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 2f4027664a0e..e2f765f87ec9 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -10,7 +10,6 @@
>>   #include <linux/clk.h>
>>   #include <linux/delay.h>
>>   #include <linux/devcoredump.h>
>> -#include <linux/dma-map-ops.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> @@ -961,52 +960,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
>>   static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   				const char *fw_name)
>>   {
>> -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
>> -	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
>> -	struct page **pages;
>> -	struct page *page;
>> +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
>>   	dma_addr_t phys;
>>   	void *metadata;
>>   	int mdata_perm;
>>   	int xferop_ret;
>>   	size_t size;
>> -	void *vaddr;
>> -	int count;
>> +	void *ptr;
>>   	int ret;
>> -	int i;
>>   
>>   	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>>   	if (IS_ERR(metadata))
>>   		return PTR_ERR(metadata);
>>   
>> -	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> -	if (!page) {
>> +	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> +	if (!ptr) {
>>   		kfree(metadata);
>>   		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>>   		return -ENOMEM;
>>   	}
>>   
>> -	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> -	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
>> -	if (!pages) {
>> -		ret = -ENOMEM;
>> -		goto free_dma_attrs;
>> -	}
>> -
>> -	for (i = 0; i < count; i++)
>> -		pages[i] = nth_page(page, i);
>> -
>> -	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
>> -	kfree(pages);
>> -	if (!vaddr) {
>> -		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
>> -		ret = -EBUSY;
>> -		goto free_dma_attrs;
>> -	}
>> -
>> -	memcpy(vaddr, metadata, size);
>> -
>> -	vunmap(vaddr);
>> +	memcpy(ptr, metadata, size);
>>   
>>   	/* Hypervisor mapping to access metadata by modem */
>>   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
>> @@ -1036,7 +1010,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   			 "mdt buffer not reclaimed system may become unstable\n");
>>   
>>   free_dma_attrs:
>> -	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>> +	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>>   	kfree(metadata);
>>   
>>   	return ret < 0 ? ret : 0;
>> -- 
>> 2.17.1
>>
> 
