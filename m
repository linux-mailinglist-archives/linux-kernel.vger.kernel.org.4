Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF66D7482
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjDEGmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjDEGl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:41:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F11FE7;
        Tue,  4 Apr 2023 23:41:56 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3353g7Er017906;
        Wed, 5 Apr 2023 06:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aQAQQtsT5e6+vLdaoAjRE4Dj+TiRwbJphmZ7LZWsMdQ=;
 b=i1jRXWFnZnwrj1oNYMlGdYRZiDizC76CIGcGHUGSdlrC33WTalAmhAxcSFNtUtgZhyQJ
 4nMDJVSiH2JvExA7FOI/Or2B9quo6na9Y3X/Uq/pNj6rC+AAhM7aXlnlzKli40JjH2GB
 Rt2XeJMXR8XRqw5J8FDJZ0ZxCw9tVQeOYwVvlQqBhWvBfJphW2f4lvt1DNDLBoUyYDTz
 NrS+FaeZuQejzhI73+FeJnboirAa+1SgDOCIRo7dbQIKzbQXATVrrbLU6Hl5rSPe3kc7
 FQ4tS/eAshLMAsot+R0pekL0WWWu6VUZcABxKm8jH5CzEaSJWd2MPkeWssjz/VOczmnh /g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnvg20ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 06:41:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3356foaq031530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 06:41:50 GMT
Received: from [10.50.42.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 23:41:46 -0700
Message-ID: <62cc41a2-ff48-40b9-eb89-69e352e6f6e9@quicinc.com>
Date:   Wed, 5 Apr 2023 12:11:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] venus: fix EOS handling in decoder stop command
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Viswanath Boma" <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-4-git-send-email-quic_dikshita@quicinc.com>
 <93b78f82-d2db-fc1d-4bad-732f7a1b33de@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <93b78f82-d2db-fc1d-4bad-732f7a1b33de@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m1RwIexUAcCcMo38kAq_cfAf8aOJymA9
X-Proofpoint-ORIG-GUID: m1RwIexUAcCcMo38kAq_cfAf8aOJymA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_02,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050061
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2023 11:54 PM, Konrad Dybcio wrote:
>
> On 4.04.2023 08:17, Dikshita Agarwal wrote:
>> Use firmware version based check to assign correct
>> device address for EOS buffer to fix the EOS handling
>> with different firmware version.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
> Does it only concern fw 1.0.xx?
>
> Konrad

that's right.

changes were made in later firmware (newer than 1.0.87) to

make the behavior generic across all supported SOCs.

Thanks,

Dikshita

>>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index f0394b9..c59b34f 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>>   
>>   		fdata.buffer_type = HFI_BUFFER_INPUT;
>>   		fdata.flags |= HFI_BUFFERFLAG_EOS;
>> -		if (IS_V6(inst->core))
>> +		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>>   			fdata.device_addr = 0;
>>   		else
>>   			fdata.device_addr = 0xdeadb000;
