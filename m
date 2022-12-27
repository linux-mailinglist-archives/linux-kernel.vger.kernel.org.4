Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D569F656FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiL0VKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiL0VJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:09:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE622D;
        Tue, 27 Dec 2022 13:07:56 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRKrAxv005531;
        Tue, 27 Dec 2022 21:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=33cI4kCZpU9jHyUxIKbVSh4H+8vw4e4ZvFaKA1z1Xl8=;
 b=oDXqDyMhJMLOorTlS4H/ZcOeV2yQ0HVKovXmaijUwtIiBuvFbLzMq/X9mAN/caHPH84W
 +tDHzBKEqHDvYkmgLdyok7lvek7uvTiwoOMFe6SdzDfE+pf5iSSAbxQdSTcXYq4XYf36
 wrcAM6Jc/muicbC5jwL4UTztcQIvKx3+cuZA7VHzaPNLqMl71ttcEdAByIe4rOdf0/5W
 Ec2qVcDVFxrsruvW0PWHuFhOtJzHdxqxp7Ue0pBDlqQWbRzinBoll97wHZwKW+TOtd4H
 aK+L8up4jbYPLXyy0kGw6NQb1oH2M4v+Mmm98b4B+aizFHO12dA1Qx1Q+sQ8t3Ne26YL mQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mntqf5g97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:07:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL77v5028849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:07:07 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:07:06 -0800
Message-ID: <730d8cbc-c391-6d77-2374-713f539d38b6@quicinc.com>
Date:   Tue, 27 Dec 2022 13:07:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op
 callbacks
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-5-quic_wcheng@quicinc.com>
 <CAA8EJprFD53zmECHJ44FpjztRjwsMym2QP_Gk-JWya-SL_ryHA@mail.gmail.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <CAA8EJprFD53zmECHJ44FpjztRjwsMym2QP_Gk-JWya-SL_ryHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7CZl33Ocf1ue6_djQegt5-iJFt_uzPMd
X-Proofpoint-ORIG-GUID: 7CZl33Ocf1ue6_djQegt5-iJFt_uzPMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_16,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=959 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 12/24/2022 3:03 AM, Dmitry Baryshkov wrote:
> Hi,
> 
> On Sat, 24 Dec 2022 at 01:33, Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>>
>> Allow for different vendors to be notified on USB SND connect/disconnect
>> seqeunces.  This allows for vendor USB SND modules to properly initialize
>> and populate internal structures with references to the USB SND chip
>> device.
> 
> The commit message definitely needs some improvement. We do not notify
> vendors on SND connect/disconnect events.
> 
> 
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c | 22 ++++++++++++++++++++++
>>   sound/usb/card.h |  7 +++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 26268ffb8274..212f55a7683c 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -117,6 +117,21 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>>   static DEFINE_MUTEX(register_mutex);
>>   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>>   static struct usb_driver usb_audio_driver;
>> +static struct snd_usb_vendor_ops *vendor_ops;
>> +
>> +int snd_usb_register_vendor_ops(struct snd_usb_vendor_ops *ops)
> 
> platform ops?
> 

Will change it.

>> +{
>> +       vendor_ops = ops;
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_usb_register_vendor_ops);
> 
> What happens if several platforms try to register different ops? I saw
> from the patch 09/14 that you register these ops unconditionally. If
> other devices follow your approach there is an obvious conflict.
> 

Thank you for the review.

That is true.  I don't think there is a proper need to have multiple 
vendor ops being registered, so maybe just returning an error for if ops 
are already registered is sufficient.

Thanks
Wesley Cheng
