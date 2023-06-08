Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6547727D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjFHKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFHKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:44:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCA1AB;
        Thu,  8 Jun 2023 03:44:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3586MvqF027461;
        Thu, 8 Jun 2023 10:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wUEiIhIjj7g/WIwbHZ11fcWHaz3Z2aJvN7BM7cb+73A=;
 b=g2n51g7e5JjVdwV4VgjLfUAaFj5MRAL+fFXETWTZ2jQBb1ArEq/qHUX0yqk6wY2YgL8y
 iSohyEPB9NdFGuhPI9OYVn8XSlPHszpZ26hKt1MI65AccwVm/cxAdb+K/ls7+NU9SQtG
 rlXF34EbR1w+wNPNP9yJO3ZFCTr8zIazqmAC1Wi7la+Jq6/YIB8hv22xOBWUadxz7rll
 EMH62CFYxiECY1LNj3NOsHUL456b2m86Vl4nf0WYqKnfbFEQVxR6qBTBgLHXzE9V7y6/
 C+MId5zDvvR5uKunkOO40pouVsm+XMzOSN0WknULgJ+OC2t4SmzYhNq2oGulS/bJ7L6W MA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2rbtjjdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 10:44:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358AiSgo031065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 10:44:28 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 03:44:23 -0700
Message-ID: <4c27849d-cd34-77ed-7d45-6f366f9fa86a@quicinc.com>
Date:   Thu, 8 Jun 2023 16:14:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v1 2/2] misc: fastrpc: detect privileged processes
 based on group ID
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-3-git-send-email-quic_ekangupt@quicinc.com>
 <bdf49a17-bb4c-a00d-0239-ed5d0eef470d@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <bdf49a17-bb4c-a00d-0239-ed5d0eef470d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -KEza8Per70tyz-V6xbFzEdBOKBdBskU
X-Proofpoint-ORIG-GUID: -KEza8Per70tyz-V6xbFzEdBOKBdBskU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=631 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 12:17 AM, Krzysztof Kozlowski wrote:
> On 07/06/2023 18:30, Ekansh Gupta wrote:
>> Get the information on privileged group IDs during rpmsg probing based
>> on DT property. Check if the process requesting an offload to remote
>> subsystem is privileged by comparing it's group ID with privileged
>> group ID. Initialization process attributes are updated for a
>> privileged process which is sent to remote process for resource
>> management.
>>
> 
> 
> 
>> +
>>   static const struct file_operations fastrpc_fops = {
>>   	.open = fastrpc_device_open,
>>   	.release = fastrpc_device_release,
>> @@ -2277,6 +2396,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   	if (!data)
>>   		return -ENOMEM;
>>   
>> +	err = fastrpc_init_privileged_gids(rdev, "qcom,fastrpc-gids", &data->gidlist);
>> +	if (err)
>> +		dev_err(rdev, "Privileged gids init failed.\n");
>> +
> 
> What about error paths? No need for cleanup?
> 
All the necessary clean-up is added as part of 
fastrpc_init_privileged_gids error path. There is no requirement to have 
any additional handling in error path other that error log. Also there 
is no intention to fail the probe in case gid information is not 
properly read.

Thanks,
Ekansh
> Best regards,
> Krzysztof
> 
