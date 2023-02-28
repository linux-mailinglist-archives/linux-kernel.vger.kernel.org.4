Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC86A5191
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjB1DAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB1DAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:00:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7CF1D906;
        Mon, 27 Feb 2023 19:00:10 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S2Rpqh010567;
        Tue, 28 Feb 2023 02:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iGExTyfqA8UiNaWVM0CI3ERBpJ+ppSBXThFNDZNWvK0=;
 b=oXwk5/gMO3nnoQ3P1KcNZleSvKuZqit8I0FiBa65PV2bn6RtCDKE/6j95NxtdYUvXHxv
 mItLLNhIlVPQ+U/NehbpdViJwsZ1UufCsNhciEV6IKFYMO0kF8An6OjIe40ANQBnjMFm
 yePoXLWawYELCIbDaxtmWpqJRDgo2QTL4FQ9IgkWwGSJFTObPrsQBP5X/Dtc8wvUaFUh
 QYgG3LAXuYU0tdws+uFI3utDIprUOW16ubk7ECuLVhO+8czFLk98v+usiBXbzK9WwpXU
 bBh//Y0LZLu/8g41ES06UIxrjFJ65QBEad/9DRfHnUJv/rZtBwa5EloPxinJ8dP3FCcD pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p17ryr78w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 02:59:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31S2xe9F013059
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 02:59:40 GMT
Received: from [10.110.31.193] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 18:59:39 -0800
Message-ID: <5e5c6481-8d5d-dc3f-e40e-986e3ac30387@quicinc.com>
Date:   Mon, 27 Feb 2023 18:59:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND platform
 op callbacks
Content-Language: en-US
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
 <Y9Ui82OaI54Qx8Ft@kroah.com>
 <2c062ab0-905c-f1fe-eca2-02e23cc9fa6f@quicinc.com>
In-Reply-To: <2c062ab0-905c-f1fe-eca2-02e23cc9fa6f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6SRmoeFCRlxObLlSUAo-jbjYTEJwar6h
X-Proofpoint-GUID: 6SRmoeFCRlxObLlSUAo-jbjYTEJwar6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_19,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280018
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2/10/2023 2:49 PM, Wesley Cheng wrote:
> Hi Greg,
> 
> On 1/28/2023 5:28 AM, Greg KH wrote:
>> On Wed, Jan 25, 2023 at 07:14:14PM -0800, Wesley Cheng wrote:
>>> Allow for different platforms to be notified on USB SND 
>>> connect/disconnect
>>> seqeunces.  This allows for platform USB SND modules to properly 
>>> initialize
>>> and populate internal structures with references to the USB SND chip
>>> device.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> ---
>>>   sound/usb/card.c | 28 ++++++++++++++++++++++++++++
>>>   sound/usb/card.h | 20 ++++++++++++++++++++
>>>   2 files changed, 48 insertions(+)
>>>
>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>> index 26268ffb8274..803230343c16 100644
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip unit 
>>> descriptor validation (default: no)
>>>   static DEFINE_MUTEX(register_mutex);
>>>   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>>>   static struct usb_driver usb_audio_driver;
>>> +static struct snd_usb_platform_ops *platform_ops;
>>
>> You can not have a single "platform_ops" pointer, this HAS to be
>> per-bus.
>>
> 
> Agreed.
> 

I looked at seeing how we could implement this at a per bus level, but 
the USB class driver model doesn't exactly have a good framework for 
supporting this.  Reason being is because, at the time of the USB SND 
class driver initialization, there is a big chance that there isn't a 
USB bus registered in the system, so the point of adding the operations 
is not clear.  However, we need to ensure that we've added the 
platform/driver operations before any USB SND devices are detected.

To add to the above, in case of OTG/DRD (dual role) designs, the USB 
HCD/bus isn't created until we move into the host role.  At that time, 
using DWC3 as an example, we will create the XHCI platform device, and 
probe the USB HCD, where a USB bus is created.

In general, we currently think this USB offload driver should co-exist 
with the USB SND class driver, which handles all devices connected 
across every bus.  We can add a check to the platform connect routine to 
ensure that there is a reference to the USB backend.  If so, then that 
particular USB bus/sysdev can be supported by the audio DSP.  That way, 
we do not falsely populate USB SND cards which are present on another 
USB bus/controller.

Thanks
Wesley Cheng
