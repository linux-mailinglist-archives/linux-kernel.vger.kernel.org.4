Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF0656FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiL0VLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiL0VKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:10:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC855BF;
        Tue, 27 Dec 2022 13:08:45 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRKnHDb006665;
        Tue, 27 Dec 2022 21:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=90sLDS6yNbgqGEPFzP0/hRUZPRIlPL5t8sK528cXKO0=;
 b=E0uUFz9MVA+yMRs3Bti3+ySQOfCnyun5gJVUOOr+9wT8yJcKTmmNbngO+tFNaLr/ID52
 X++1tu8bS7m4oB1tcIv4SfdLbzJ1TWmx94glIULu/KgGhOM6ghEpgUL07l1VwTV13Qbd
 E+W3uO+1cbjOS16roenEZrR3F+pgvHVs4PvXraMrK+IYNJ8umm4QRQmc5cqhegsb9weL
 JO/o/bgm3FJDXHCYhmD2DcX5kM2Y6Hn9hRb30WspBRErHRcfJnH5P2EqdT8uCHUg8khf
 JNQXxhjzM/eaUO1GkfceYQxUtBkTaFUZApbVh4j+GfnXEgDO8g7vBEkkdVW83I8iHzOU Yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mr1r1guy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:07:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL7l2P020720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:07:47 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:07:46 -0800
Message-ID: <e1203849-01b4-b196-36f3-76d58dd7c724@quicinc.com>
Date:   Tue, 27 Dec 2022 13:07:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for
 interrupter management
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
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
 <20221223233200.26089-7-quic_wcheng@quicinc.com>
 <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KdP-7w-uMKR4pSh2fA3koT6YVSP7mIVD
X-Proofpoint-ORIG-GUID: KdP-7w-uMKR4pSh2fA3koT6YVSP7mIVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_16,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=549 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 12/24/2022 7:29 AM, Alan Stern wrote:
> On Fri, Dec 23, 2022 at 03:31:52PM -0800, Wesley Cheng wrote:
>> For USB HCDs that can support multiple USB interrupters, expose functions
>> that class drivers can utilize for setting up secondary interrupters.
>> Class drivers can pass this information to its respective clients, i.e.
>> a dedicated DSP.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/core/hcd.c  | 86 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/usb.h     |  7 ++++
>>   include/linux/usb/hcd.h | 16 +++++++-
>>   3 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 8300baedafd2..90ead90faf1d 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
> 
>> +/**
>> + * usb_hcd_stop_endpoint - Halt USB EP transfers
>> + * @udev: usb device
>> + * @ep: usb ep to stop
>> + *
>> + * Stop pending transfers on a specific USB endpoint.
>> + **/
>> +int usb_hcd_stop_endpoint(struct usb_device *udev,
>> +					struct usb_host_endpoint *ep)
>> +{
>> +	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>> +	int ret = 0;
>> +
>> +	if (hcd->driver->stop_endpoint)
>> +		ret = hcd->driver->stop_endpoint(hcd, udev, ep);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_hcd_stop_endpoint);
> 
> You know, there already is a function that does this.  It's named
> usb_hcd_flush_endpoint().  No need to add another function that does the
> same thing.
> 

Thanks for the suggestion and review.

Hmmm...maybe I should change the name of the API then to avoid the 
confusion.  Yes, usb_hcd_flush_endpoint() does ensure that URBs 
submitted to the EP are stopped.  However, with this offloading concept, 
we aren't actually submitting URBs from the main processor, so the 
ep->urb_list will be empty.

This means the usb_hcd_flush_endpoint() API won't actually do anything. 
  What we need is to ensure that we send a XHCI stop ep command to the 
controller.

Thanks
Wesley Cheng
