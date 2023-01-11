Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EED665B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjAKM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjAKM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:29:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65BFCF5;
        Wed, 11 Jan 2023 04:29:17 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BBa5W0001599;
        Wed, 11 Jan 2023 12:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WwmrrFyOLXw8SVs6+MY0KxGQRNOSaDQCUny1d/ABA90=;
 b=ZhntcEhfVWtqXzW5HyQr0V3IDhawqPJ+rbMMcjli9RvlHxxNWR9V0fe/a/ROf2B9+VYq
 ptMUvM4F0gqYh6ChLhQCIrd26HHZMzvVkLSBRwvFEG/H7C9bYjrfs1fCsl/RmtCA4qPZ
 yTy6zVnx7PT424PlPkxWexjPr7F9DhIgxM02+/RtfETCy69afT084m96IdmTE4sCsrJR
 Ji5E048AaoHKXGI7cYDETEHIJBLvFJuKs3xOI+RW+gTkygv+87LKwZJ+YbX5vFb/Utc8
 I3pBMS/vwgvpuxPc5eMHqi/Kby8HmNr5knuQuUDFKS9nXeArQUzgeXQhN0kZmYXCjPLb xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k7qs77t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 12:29:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BCT2X7010849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 12:29:02 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 04:28:57 -0800
Message-ID: <d714a068-ee48-2a86-4d54-173312d9720e@quicinc.com>
Date:   Wed, 11 Jan 2023 17:58:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V3 05/10] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-6-quic_sibis@quicinc.com>
 <20230111115422.GD4873@thinkpad>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230111115422.GD4873@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zb_zpxvd69ozebbdJCDftacfBiPFGQYo
X-Proofpoint-ORIG-GUID: zb_zpxvd69ozebbdJCDftacfBiPFGQYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_05,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mani,

Thanks for taking time to review the series.

On 1/11/23 17:24, Manivannan Sadhasivam wrote:
> On Wed, Jan 11, 2023 at 05:13:32PM +0530, Sibi Sankar wrote:
>> Any access to the dynamically allocated metadata region by the application
>> processor after assigning it to the remote Q6 will result in a XPU
>> violation. Fix this by replacing the dynamically allocated memory region
>> with a no-map carveout and unmap the modem metadata memory region before
>> passing control to the remote Q6.
>>
>> Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
>> ---
>>
>> v3:
>>   * Drop revert no_kernel_mapping since it's already on the list [Mani]
> 
> I thought you are going to include Christoph's patch into your series. That way
> all the patches will be in the same series, makig life easier for Bjorn.
> 

Since there were multiple patches in Christoph's original series, I
decided I'll just drop the revert and have it depends on instead.


> Thanks,
> Mani
> 
>>   * kfree metadata from the branch for parity
>>
>>   drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index e2f765f87ec9..e25d44e20ae7 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -215,6 +215,7 @@ struct q6v5 {
>>   	size_t mba_size;
>>   	size_t dp_size;
>>   
>> +	phys_addr_t mdata_phys;
>>   	phys_addr_t mpss_phys;
>>   	phys_addr_t mpss_reloc;
>>   	size_t mpss_size;
>> @@ -973,15 +974,29 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   	if (IS_ERR(metadata))
>>   		return PTR_ERR(metadata);
>>   
>> -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> -	if (!ptr) {
>> -		kfree(metadata);
>> -		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>> -		return -ENOMEM;
>> +	if (qproc->mdata_phys) {
>> +		phys = qproc->mdata_phys;
>> +		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
>> +		if (!ptr) {
>> +			kfree(metadata);
>> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
>> +				&qproc->mdata_phys, size);
>> +			return -EBUSY;
>> +		}
>> +	} else {
>> +		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
>> +		if (!ptr) {
>> +			kfree(metadata);
>> +			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>> +			return -ENOMEM;
>> +		}
>>   	}
>>   
>>   	memcpy(ptr, metadata, size);
>>   
>> +	if (qproc->mdata_phys)
>> +		memunmap(ptr);
>> +
>>   	/* Hypervisor mapping to access metadata by modem */
>>   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
>>   	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true,
>> @@ -1010,7 +1025,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>   			 "mdt buffer not reclaimed system may become unstable\n");
>>   
>>   free_dma_attrs:
>> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>> +	if (!qproc->mdata_phys)
>> +		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>>   	kfree(metadata);
>>   
>>   	return ret < 0 ? ret : 0;
>> @@ -1893,6 +1909,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>>   	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>>   	qproc->mpss_size = resource_size(&r);
>>   
>> +	if (!child) {
>> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
>> +	} else {
>> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
>> +		node = of_parse_phandle(child, "memory-region", 0);
>> +		of_node_put(child);
>> +	}
>> +
>> +	if (!node)
>> +		return 0;
>> +
>> +	ret = of_address_to_resource(node, 0, &r);
>> +	of_node_put(node);
>> +	if (ret) {
>> +		dev_err(qproc->dev, "unable to resolve metadata region\n");
>> +		return ret;
>> +	}
>> +
>> +	qproc->mdata_phys = r.start;
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
