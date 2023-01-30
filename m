Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA87681F85
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjA3XUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA3XUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:20:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F02A144A9;
        Mon, 30 Jan 2023 15:20:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UM2b88009878;
        Mon, 30 Jan 2023 23:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=99WODW3J7GhU0EkcLJZeiwYlNeOFNhO6mFi3Lr6ZqLM=;
 b=f5lINehjc3BTKPiZNHGnx0WFVoTqm+4+cqwjKKBY+kA29Kg7/ev3gnwX2Ef0ZGHZA1Kw
 qw3OgxJIBoxWwC0qYW7zq1YS61CrQQWjfzRZ3iShGL8z6fImX91e+ZW9qPs/um8MsluP
 CuCkCUoIod02UaiqX3YDE86E4yj3wOPDQ1oQ3IT7LnkiNiR74uPPCEhqTiZKP/d7Tt+5
 vi/Vf0oyKyo85kZMy3+KNdvX5qCgX3suhtrx3NtQR8qO/r01o7lqO+BA6FNWJ8HGQrWO
 nUw+yGVhFpp1yEM3M/gOsmHqe1Dq2/pXkUkJzLccu2lv6hXzzHa3gXAHq7aYYGsLjqoD 2Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxamtj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 23:00:34 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UN0XQ1023427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 23:00:33 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 15:00:32 -0800
Message-ID: <63ef99b7-c6c4-497d-da08-a3966291de9f@quicinc.com>
Date:   Mon, 30 Jan 2023 15:00:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND platform
 op callbacks
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
 <1013f667-c11f-25a2-ab2b-87b9368ad456@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <1013f667-c11f-25a2-ab2b-87b9368ad456@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YxBG3Jnkvw4vvbPrO9t0zF_PiC2Ra7GI
X-Proofpoint-GUID: YxBG3Jnkvw4vvbPrO9t0zF_PiC2Ra7GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=762 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300211
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/26/2023 7:50 AM, Pierre-Louis Bossart wrote:
> 
> 
> 
>> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
>> +{
>> +	if (platform_ops)
>> +		return -EEXIST;
>> +
>> +	platform_ops = ops;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_register_platform_ops);
>> +
>> +int snd_usb_unregister_platform_ops(void)
>> +{
>> +	platform_ops = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
> 
> I find this super-racy.
> 
> If the this function is called just before ...
> 
>>   
>>   /*
>>    * disconnect streams
>> @@ -910,6 +928,10 @@ static int usb_audio_probe(struct usb_interface *intf,
>>   	usb_set_intfdata(intf, chip);
>>   	atomic_dec(&chip->active);
>>   	mutex_unlock(&register_mutex);
>> +
>> +	if (platform_ops->connect_cb)
>> +		platform_ops->connect_cb(intf, chip);
>> +
> 
> ... this, then you have a risk of using a dandling pointer.
> 
> You also didn't test that the platform_ops != NULL, so there's a risk of
> dereferencing a NULL pointer.
> 
> Not so good, eh?
> 
> It's a classic (I've had the same sort of issues with SoundWire), when
> you export ops from one driver than can be removed, then additional
> protection is needed when using those callbacks.
> 
> 

Yep, will take a look at this a bit more to improve it.

Thanks
Wesley Cheng
