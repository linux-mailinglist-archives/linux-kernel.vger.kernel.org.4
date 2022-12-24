Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC5655971
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiLXIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLXIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:51:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C013B634A;
        Sat, 24 Dec 2022 00:51:13 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BO8l2R0008795;
        Sat, 24 Dec 2022 08:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OW+eLGSz1Heim9HIqKFjzlkSom2T4l1aNalgqaBNqGk=;
 b=pc/T0q5BtY5mgFJUeBeTpYbgJT8izfPC37HG0gDiBTDc+mHpBJebnrqoO0C5miXNQwq2
 ku9rsCBQFCFWXp4xHXMbh/N+JrAjfs6NjG7iwaVr+85yca4YatIGay6dQEct1GByzYME
 eXt/ptb3/+mGz/PIlXcaHTGmaNip8HKxxYlatViyslFvQshEmXi0kWFHSEL9GP2+3BAb
 cQaE8WdD7vhCNTnHUxQD4A9ywTy+IIlTGNHWqil4ZQELTEb2ZMVFfGYk7TUOChd6Dn6D
 jzL9LZ6teWtS+Fp2GwU37+m2O/PM222tpQuJIBl1tCF8jx3K5B/GpvVYzt+To6b9QTey HQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnstf88yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Dec 2022 08:50:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BO8oJZZ015040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Dec 2022 08:50:19 GMT
Received: from [10.110.37.149] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 24 Dec
 2022 00:50:18 -0800
Message-ID: <ec40628c-ac9e-7043-21c6-5b21231928a8@quicinc.com>
Date:   Sat, 24 Dec 2022 00:50:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 12/14] sound: soc: qcom: qusb6: Ensure PCM format is
 supported by USB audio device
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-13-quic_wcheng@quicinc.com>
 <6e5da084-d2fb-4b84-1c3c-cd428ee111ec@omp.ru>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <6e5da084-d2fb-4b84-1c3c-cd428ee111ec@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h0uFfLzZYSailoaNKNxVSBUrq-SUnT9X
X-Proofpoint-ORIG-GUID: h0uFfLzZYSailoaNKNxVSBUrq-SUnT9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-24_02,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212240074
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On 12/24/2022 12:19 AM, Sergey Shtylyov wrote:
> Hello!
> 
> On 12/24/22 2:31 AM, Wesley Cheng wrote:
> 
>> Check for if the PCM format is supported during the hw_params callback.  If
>> the profile is not supported then the userspace ALSA entity will receive an
>> error, and can take further action.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/soc/qcom/qdsp6/q6usb.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
>> index a9da6dec6c6f..128e0974db4e 100644
>> --- a/sound/soc/qcom/qdsp6/q6usb.c
>> +++ b/sound/soc/qcom/qdsp6/q6usb.c
>> @@ -42,7 +42,14 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
>>   			   struct snd_pcm_hw_params *params,
>>   			   struct snd_soc_dai *dai)
>>   {
>> -	return 0;
>> +	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
>> +	int direction = substream->stream;
>> +	int ret;
> 
>     You don't seem to need this variable, just use *return*
> snd_soc_usb_find_format(...) >

Thanks for catching this... Will fix it in the next submission I make. 
Happy holidays!

Thanks
Wesley Cheng

