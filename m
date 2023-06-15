Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95075731FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbjFOSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFOSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:12:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4210FE;
        Thu, 15 Jun 2023 11:12:01 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FHsPqd010983;
        Thu, 15 Jun 2023 18:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UT+6ukVIACEfrUc3MDgMmLIqUVBcBw86i9B0z8bwa98=;
 b=cTb4vkYMdiSTySAq0ta+KZkU4zXuuFcvJG0v9yGlk5a1vrLTu/AZ+G9S/Y/BaI2uzay6
 inb65zr7YVFvIFBv7P9PHVLNUA3lh0+AvD124EspImq6PQ3ELb+DWBx+mGsxuCYIB8kG
 0C5uisaQLN4DOdFcs3BRhsggEc4sT85TjCMB9NwQP9cXTL2MJQ31+7ZNjjch5YQiLKD+
 baWNHJM7L+EtYl8MYaB5oH1lz9iVWSDPBgGXqegxLjL7NRQwemXI3Ue6JSDSdtQuINbe
 uIsRDRBlEM1WxKuwz9qI94VzoC++xqway2cmZvv8brUishaYvU9VD3tQthtEV064UvOd YQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7p4qabqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 18:11:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FIBsdu001753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 18:11:54 GMT
Received: from [10.216.11.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 11:11:51 -0700
Message-ID: <3a90900f-bf60-0b9e-43ab-451264785cba@quicinc.com>
Date:   Thu, 15 Jun 2023 23:41:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
 <2023061547-staleness-camper-ae8a@gregkh>
 <d5561151-08bb-9f5f-aa51-44c5ad31976b@quicinc.com>
 <2023061512-vowed-panther-38ed@gregkh>
 <551145bb-18f7-45af-b75e-7caccca113bc@quicinc.com>
 <2023061556-hypnoses-quartet-766a@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023061556-hypnoses-quartet-766a@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: egXcXtm7eoR35bAh6vZdFax_7cZbg45J
X-Proofpoint-ORIG-GUID: egXcXtm7eoR35bAh6vZdFax_7cZbg45J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_14,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150156
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15-06-23 08:35 pm, Greg Kroah-Hartman wrote:
> On Thu, Jun 15, 2023 at 08:28:13PM +0530, Prashanth K wrote:
>>
>>
>> On 15-06-23 08:06 pm, Greg Kroah-Hartman wrote:
>>> On Thu, Jun 15, 2023 at 07:52:32PM +0530, Prashanth K wrote:
>>>>
>>>> In that case, can I resubmit v1 of this patch again, where I have used a
>>>> macro in usb-conn-gpio driver ? something like this.
>>>>
>>>> @@ -27,6 +27,8 @@
>>>>    #define USB_CONN_IRQF	\
>>>>    	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
>>>>
>>>> +#define USB_ROLE_UNKNOWN (USB_ROLE_NONE -1)
>>>
>>> Are you referencing an existing enum here and assuming it is a specific
>>> value?
>>
>> I' not assuming UBS_ROLE_NONE to be a specific value, but I want an integer
>> (for macro) which is not equal to USB_ROLE_NONE/DEVICE/HOST, that's why I'm
>> using (USB_ROLE_NONE - 1), assuming enumerators NONE, DEVICE & HOST will be
>> having adjacent integer values. Wouldn't that help?
> 
> You can't do "math" on an enumerated type and expect the result to be
> anything constant over time.
> 
> And yes, you can hope that enumerated types are sequential, and the spec
> says so, but please never rely on that as what happens if someone adds a
> new one in the list without you ever noticing it.
> 
> Pleasae treat enumerated types as an opaque thing that you never know
> the real value of, it's a symbol only.
> 
> thanks,
> 
> greg k-h

Then we can go ahead a different approach using a flag. But that would 
require us to add a new member to usb_conn_info struct. What do you suggest?

@@ -42,6 +42,7 @@ struct usb_conn_info {

         struct power_supply_desc desc;
         struct power_supply *charger;
+       bool initial_det;
  };

  /*
@@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct 
*work)
         dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
                 usb_role_string(info->last_role), 
usb_role_string(role), id, vbus);

-       if (info->last_role == role) {
+       if (!info->initial_det && (info->last_role == role)) {
                 dev_warn(info->dev, "repeated role: %s\n", 
usb_role_string(role));
                 return;
         }

+       info->initial_det = false;
+
         if (info->last_role == USB_ROLE_HOST && info->vbus)
                 regulator_disable(info->vbus);

@@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
         device_set_wakeup_capable(&pdev->dev, true);

         /* Perform initial detection */
+       info->initial_det = true;
         usb_conn_queue_dwork(info, 0);

Regards,
Prashanth K

