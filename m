Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82A64B90A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiLMP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiLMP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:57:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572E1D64E;
        Tue, 13 Dec 2022 07:57:27 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDFjepb023516;
        Tue, 13 Dec 2022 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hwHcewlGtXCpI5Rw5IIhzITMCWmxtmWt0BL5o+Tx+K0=;
 b=cCARiXVgqqZEU+bvEjQDoPElzmJuRdHUKqZ/Taaf4kNEnzCGRXKgxIfm1utjbuvtDr0O
 5d9Syp1UuyC3k9E3ZsvD9JVwKHoJ21/qtRzjOWKef1yCURA0znbFAexSRsXI1bGg8QxV
 CW/PG19aLnsT3F/QibC9pk4mvOAWETGYxjptAS+yhUuBnAHtLo2uf5VrhoEBSlEpRHBT
 +peRtIANQneSTYWjOLv899JWaVgniOX7kDD5DBRBs11JUhKm8bEDUakKICMbQ+Xm/T8u
 1bTniuAWhD3cnGpPPwTuF/kdzSN/LeqJ9lZqAFV4X7ynfQ3tBHbNL1tPwrU1mx2H9AMS eQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3megc5t4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:57:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDFvBhx032506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:57:11 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 07:57:07 -0800
Message-ID: <ba258979-0c65-4671-dd01-c1916c26e81b@quicinc.com>
Date:   Tue, 13 Dec 2022 21:27:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
 <741b64c2-0b09-6475-5736-d2cd3e33c34c@arm.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <741b64c2-0b09-6475-5736-d2cd3e33c34c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y3Y-xglJ_qKE83bISa0COxMY1Eo8P2fy
X-Proofpoint-GUID: Y3Y-xglJ_qKE83bISa0COxMY1Eo8P2fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Robin,

Thanks for taking time to review the series.

On 12/13/22 20:37, Robin Murphy wrote:
> On 2022-12-13 14:07, Sibi Sankar wrote:
>> The memory region allocated using dma_alloc_attr with no kernel mapping
>> attribute set would still be a part of the linear kernel map. Any access
>> to this region by the application processor after assigning it to the
>> remote Q6 will result in a XPU violation. Fix this by replacing the
>> dynamically allocated memory region with a no-map carveout and unmap the
>> modem metadata memory region before passing control to the remote Q6.
>>
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem 
>> ownership switch")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> The addition of the carveout and memunmap is required only on SoCs that
>> mandate memory protection before transferring control to Q6, hence the
>> driver falls back to dynamic memory allocation in the absence of the
>> modem metadata carveout.
> 
> The DMA_ATTR_NO_KERNEL_MAPPING stuff is still broken and pointless, so 
> I'd expect to see this solution replacing it, not being added alongside. 
> It's just silly to say pass the "I don't need a CPU mapping" flag, then 
> manually open-code the same CPU mapping you would have got if you 
> hadn't, in a way that only works at all when a cacheable alias exists 
> anyway.

only a subset of SoCs supported by the driver are affected by
the bug i.e. on the others dma_alloc_attr would still work
without problems. I can perhaps drop the NO_KERNEL_MAPPING along
with the vmap/vunmap and simplify things for those SoCs.

- Sibi

> 
> Thanks,
> Robin.
> 
>>   drivers/remoteproc/qcom_q6v5_mss.c | 85 +++++++++++++++++++++---------
>>   1 file changed, 61 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index fddb63cffee0..8264275ecbd0 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -211,6 +211,7 @@ struct q6v5 {
>>       size_t mba_size;
>>       size_t dp_size;
>> +    phys_addr_t mdata_phys;
>>       phys_addr_t mpss_phys;
>>       phys_addr_t mpss_reloc;
>>       size_t mpss_size;
>> @@ -935,6 +936,7 @@ static int q6v5_mpss_init_image(struct q6v5 
>> *qproc, const struct firmware *fw,
>>   {
>>       unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | 
>> DMA_ATTR_NO_KERNEL_MAPPING;
>>       unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
>> +    void *mdata_region;
>>       struct page **pages;
>>       struct page *page;
>>       dma_addr_t phys;
>> @@ -951,34 +953,48 @@ static int q6v5_mpss_init_image(struct q6v5 
>> *qproc, const struct firmware *fw,
>>       if (IS_ERR(metadata))
>>           return PTR_ERR(metadata);
>> -    page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, 
>> dma_attrs);
>> -    if (!page) {
>> -        kfree(metadata);
>> -        dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>> -        return -ENOMEM;
>> -    }
>> +    if (qproc->mdata_phys) {
>> +        mdata_region = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
>> +        if (!mdata_region) {
>> +            dev_err(qproc->dev, "unable to map memory region: 
>> %pa+%zx\n",
>> +                &qproc->mdata_phys, size);
>> +            ret = -EBUSY;
>> +            goto free_dma_attrs;
>> +        }
>> -    count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> -    pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
>> -    if (!pages) {
>> -        ret = -ENOMEM;
>> -        goto free_dma_attrs;
>> -    }
>> +        memcpy(mdata_region, metadata, size);
>> +        memunmap(mdata_region);
>> +        phys = qproc->mdata_phys;
>> +    } else {
>> +        page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, 
>> dma_attrs);
>> +        if (!page) {
>> +            kfree(metadata);
>> +            dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>> +            return -ENOMEM;
>> +        }
>> -    for (i = 0; i < count; i++)
>> -        pages[i] = nth_page(page, i);
>> +        count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +        pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
>> +        if (!pages) {
>> +            ret = -ENOMEM;
>> +            goto free_dma_attrs;
>> +        }
>> -    vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
>> -    kfree(pages);
>> -    if (!vaddr) {
>> -        dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", 
>> &phys, size);
>> -        ret = -EBUSY;
>> -        goto free_dma_attrs;
>> -    }
>> +        for (i = 0; i < count; i++)
>> +            pages[i] = nth_page(page, i);
>> -    memcpy(vaddr, metadata, size);
>> +        vaddr = vmap(pages, count, flags, 
>> pgprot_dmacoherent(PAGE_KERNEL));
>> +        kfree(pages);
>> +        if (!vaddr) {
>> +            dev_err(qproc->dev, "unable to map memory region: 
>> %pa+%zx\n", &phys, size);
>> +            ret = -EBUSY;
>> +            goto free_dma_attrs;
>> +        }
>> -    vunmap(vaddr);
>> +        memcpy(vaddr, metadata, size);
>> +
>> +        vunmap(vaddr);
>> +    }
>>       /* Hypervisor mapping to access metadata by modem */
>>       mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
>> @@ -1008,7 +1024,8 @@ static int q6v5_mpss_init_image(struct q6v5 
>> *qproc, const struct firmware *fw,
>>                "mdt buffer not reclaimed system may become unstable\n");
>>   free_dma_attrs:
>> -    dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>> +    if (!qproc->mdata_phys)
>> +        dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
>>       kfree(metadata);
>>       return ret < 0 ? ret : 0;
>> @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct q6v5 
>> *qproc)
>>       qproc->mpss_phys = qproc->mpss_reloc = r.start;
>>       qproc->mpss_size = resource_size(&r);
>> +    if (!child) {
>> +        node = of_parse_phandle(qproc->dev->of_node, "memory-region", 
>> 2);
>> +    } else {
>> +        child = of_get_child_by_name(qproc->dev->of_node, "metadata");
>> +        node = of_parse_phandle(child, "memory-region", 0);
>> +        of_node_put(child);
>> +    }
>> +
>> +    if (!node)
>> +        return 0;
>> +
>> +    ret = of_address_to_resource(node, 0, &r);
>> +    of_node_put(node);
>> +    if (ret) {
>> +        dev_err(qproc->dev, "unable to resolve metadata region\n");
>> +        return ret;
>> +    }
>> +
>> +    qproc->mdata_phys = r.start;
>> +
>>       return 0;
>>   }
