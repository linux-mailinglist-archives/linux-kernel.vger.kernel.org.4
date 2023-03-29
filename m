Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651066CD136
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjC2EfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:35:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B526A5;
        Tue, 28 Mar 2023 21:35:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T4AfJs006679;
        Wed, 29 Mar 2023 04:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SdAgyLL2K/zVFRXxGuvJBSI7rL3Xfw9E2+HAaXX2SEI=;
 b=PDP9FC1Ug2Lz6FYYIX+MFB0MGC3HBfiAIAdSOOoRj9m2wkH3CBnNLHo14Pp8z+uCIr04
 fht9eKhxJvT893IYt8wNb4NqwiWeHa/+5H06VarMg68yelQHJ7AH8WDdY6l6+V6KRpz3
 BnoB+c10V6aP2L/h5mw4sEY7ODJe5om3cGPAKALuKOg0Eevf2ylLuNY+hOFWB4NJM40M
 JhSPSK+fL04gJ/u8y3EPng7L5iKVeKzy2bTXd9C1/T79hU6OApj4Cf0VbU1gPlg2xHGq
 KFtHQCviKRL5+P9VArI8mV+W/bP3LXr0+oW6hhpNTufIIs+GI6MqIrjo+n4U8XeG8DKG BA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmawsgd0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 04:34:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T4Ytwh001195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 04:34:55 GMT
Received: from [10.216.46.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 21:34:50 -0700
Message-ID: <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
Date:   Wed, 29 Mar 2023 10:04:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230328212048.rpm4ly265etahwm3@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iMI-9u49VPE8CEf-dirm4WoYakeiNfB9
X-Proofpoint-ORIG-GUID: iMI-9u49VPE8CEf-dirm4WoYakeiNfB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290036
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2023 2:50 AM, Thinh Nguyen wrote:
> Hi,
> 
> On Tue, Mar 28, 2023, Krishna Kurapati wrote:
>> If the core soft reset timeout happens, avoid setting up event
>> buffers and starting gadget as the writes to these registers
>> may not reflect when in reset and setting the run stop bit
>> can lead the controller to access wrong event buffer address
>> resulting in a crash.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 3c63fa97a680..f0472801d9a5 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2620,13 +2620,16 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>   		 * device-initiated disconnect requires a core soft reset
>>   		 * (DCTL.CSftRst) before enabling the run/stop bit.
>>   		 */
>> -		dwc3_core_soft_reset(dwc);
>> +		ret = dwc3_core_soft_reset(dwc);
>> +		if (ret)
>> +			goto done;
>>   
>>   		dwc3_event_buffers_setup(dwc);
>>   		__dwc3_gadget_start(dwc);
>>   		ret = dwc3_gadget_run_stop(dwc, true, false);
>>   	}
>>   
>> +done:
>>   	pm_runtime_put(dwc->dev);
>>   
>>   	return ret;
>> -- 
>> 2.40.0
>>
> 
> I think there's one more place that may needs this check. Can you also
> add this check in __dwc3_set_mode()?

Hi Thinh,

   Sure. Will do it.
Will the below be good enough ? Or would it be good to add an error/warn 
log there>

kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales2/skales/kernel$ 
git diff drivers/usb/
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..8d1d213d1dcd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -210,7 +210,9 @@ static void __dwc3_set_mode(struct work_struct *work)
                 }
                 break;
         case DWC3_GCTL_PRTCAP_DEVICE:
-               dwc3_core_soft_reset(dwc);
+               ret = dwc3_core_soft_reset(dwc);
+               if (ret)
+                       goto out;

                 dwc3_event_buffers_setup(dwc);

Regards,
Krishna,
