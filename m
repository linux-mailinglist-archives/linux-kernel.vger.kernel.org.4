Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71A662278
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjAIKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjAIKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:06:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE881DC7;
        Mon,  9 Jan 2023 02:05:55 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3098mLvX012979;
        Mon, 9 Jan 2023 10:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=njzyDNi5DpxoyZkQbk7rKCG2fibPz6j5fRLlrKFQ0Lw=;
 b=pDzkpTDfu4nZNM3cuYpVvewnIvdE3ddFI9CkoZXUoEOJonmgJdl74AvN83QywnlrSG+M
 KG8q+5b9/etntKMjPR6XiwPWhd7fr3CVmDO8/ID5bpeKAPi/hYgQSssaPAjKIy+R8v6D
 m1kFR3D0/OB5OLjdqA7vOOt8v6v9S98jofpVDH5DQ4oamLtIONdW79xBADEl9LSwH3Ft
 K7qRVj0FOkqNY6RqSj+jDj3mEt8ufF6WlN00puerdZKJaRBn0TTeWMQQtvHF2FC+ps8G
 n3nRbwa5junK/J9PLSIxgw+9lsPsdsx6moEflDwcyGcEkpcchhdFwKKE3EUSxVQETPgp Uw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0b92snr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 10:05:42 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309A5fTS017793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 10:05:41 GMT
Received: from [10.79.43.91] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 02:05:35 -0800
Message-ID: <7552f8a1-9503-de7c-a6d4-46452ef78ece@quicinc.com>
Date:   Mon, 9 Jan 2023 15:35:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 06/11] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <robin.murphy@arm.com>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-7-quic_sibis@quicinc.com>
 <20230109083231.GB4966@thinkpad>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230109083231.GB4966@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KSN7rH8A2GjzdGeXK9enMIAbm8MxEC5j
X-Proofpoint-ORIG-GUID: KSN7rH8A2GjzdGeXK9enMIAbm8MxEC5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mani,

On 1/9/23 14:02, Manivannan Sadhasivam wrote:
> On Mon, Jan 09, 2023 at 09:18:38AM +0530, Sibi Sankar wrote:
>> Any access to the dynamically allocated metadata region by the application
>> processor after assigning it to the remote Q6 will result in a XPU
>> violation. Fix this by replacing the dynamically allocated memory region
>> with a no-map carveout and unmap the modem metadata memory region before
>> passing control to the remote Q6.
>>
>> Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>>   * Revert no_kernel_mapping [Mani/Robin]
>>
>>   drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
>> index e2f765f87ec9..b7a158751cef 100644
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
>> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
>> +				&qproc->mdata_phys, size);
>> +			ret = -EBUSY;
>> +			goto free_dma_attrs;
> 
> There is no memory to free at this point.

we would just free the metadata in the no-map carveout scenario since
mdata_phys wouldn't be NULL. I can do a kfree(metadata) directly from
this branch and return as well if you think it makes things more
readable.

> 
> Thanks,
> Mani
> 
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
