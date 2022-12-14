Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701764C86D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiLNLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiLNLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:51:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BD19C3B;
        Wed, 14 Dec 2022 03:51:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEB8d85012742;
        Wed, 14 Dec 2022 11:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jYZg+kLIKhBDF5wW/QrkjH6TjMMJkibiqKu73DC6phE=;
 b=XPvm7Vk5cNKz97h4ILY0d9QiCc0vHqbykDz2GLYolY7vtQRWT/+aeV7Ty6VImdAF4a4t
 uHj+OCyHZIznbK3QsJD5+QyztH1W56N/ff7F0SeKEFDYWASKGp8VUBi8ukh0+dcd9MJ9
 uwjwatCztPCJ9bpMwBUJYAUbzO5uYv09QAssZcOtpsV1yCQRNQRwwRlrzILEFPCJJ6YB
 qIGCGt00iC2HiGVH76zfpUWUx9UJJlT+kbn4RZ/6Is2Pm0anmQy/vd4+cRPTBbpzx83u
 zJyrjD2K3aarRUtwBU+WrNHSkkql1z/sjB52NhF/urE1ASzJZ77kEN/TedKF3e7RPcIY OQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rd12tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:51:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEBpEo1026364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:51:14 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 03:51:09 -0800
Message-ID: <e4bef035-c448-7c75-13a6-d9c61aa8cde7@quicinc.com>
Date:   Wed, 14 Dec 2022 17:21:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
 <8739f59b-c551-2da4-5523-a89f960bd402@linaro.org>
 <f4595a18-23bd-d54f-4e50-c0ed63008225@quicinc.com>
 <1d3c7d01-bfa9-6654-28d9-b9f4964a88a4@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <1d3c7d01-bfa9-6654-28d9-b9f4964a88a4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p-WLqOpF4P2JSpD1Ydh6GjQ-DyeR3XZO
X-Proofpoint-ORIG-GUID: p-WLqOpF4P2JSpD1Ydh6GjQ-DyeR3XZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_04,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/22 16:58, Krzysztof Kozlowski wrote:
> On 14/12/2022 11:33, Sibi Sankar wrote:
>>
>>
>> On 12/14/22 01:17, Krzysztof Kozlowski wrote:
>>> On 13/12/2022 15:07, Sibi Sankar wrote:
>>>> The memory region allocated using dma_alloc_attr with no kernel mapping
>>>> attribute set would still be a part of the linear kernel map. Any access
>>>> to this region by the application processor after assigning it to the
>>>> remote Q6 will result in a XPU violation. Fix this by replacing the
>>>> dynamically allocated memory region with a no-map carveout and unmap the
>>>> modem metadata memory region before passing control to the remote Q6.
>>>>
>>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
>>>
>>> Thank you for your patch. There is something to discuss/improve.
>>>>    
>>>>    	return ret < 0 ? ret : 0;
>>>> @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>>>>    	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>>>>    	qproc->mpss_size = resource_size(&r);
>>>>    
>>>> +	if (!child) {
>>>> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
>>>> +	} else {
>>>> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
>>>
>>> Bindings do not allow to have child "metadata", do they?
>>
>> memory-region property was used to specify mba/mpss region in a phandle
>> array only from SC7180 SoC. All the older dtbs in the wild/upstream
>> still had sub-nodes to achieve the same. Patch 3 allows for a sub-set
>> of the SoCs (MSM8996/MSM8998/SDM845) to use metadata as a sub-node so
>> as to not break bindings when newer kernel uses a older dtb.
> 
> This does not explain why you extend the driver without extending the
> bindings. You do not do it for legacy stuff but for SC7180. But even for
> legacy devices you cannot add new properties without having it in some
> legacy bindings.

https://patchwork.kernel.org/project/linux-arm-msm/patch/20221213140724.8612-4-quic_sibis@quicinc.com/

The legacy bindings are a part of patch 3 ^^.

> 
> 
> Best regards,
> Krzysztof
> 
