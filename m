Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E10731B37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345009AbjFOOXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjFOOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:23:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF5123;
        Thu, 15 Jun 2023 07:23:02 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FE09Yc016967;
        Thu, 15 Jun 2023 14:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7ojsU532r+ZMrtTCmGzAXxkkR32ij0LjurrlXd2YYC0=;
 b=AgcprFuA5gw0XT1DDM5FqqTqhLSdZVoeZucLwpaCECap9xYRbeM61vAXy5rbwpQNkWEw
 88oHBQ8x4o1/6iE8w+x+aVKhj8+KTNUWUdyWGX2lMrjHuGaHxr1L0vq2UPJ2QqMTD9HS
 vokTBAoaUz6/VMjhtejiZ4VINrxtpNLR2iDZHvlgD1ACRaG2I/gVanuf1npVsdvhLK38
 U+NNIIERigxithXADz3NuhhGLOGUCspARa7ntxUWcmQFIPmdQPvuQ5PztkfIFaAZJrRD
 DSw5BAneKB7nYC1ZLWq0i6tXWwFYPZ8lachgQaYqEzhY/LGHTVYA8lGtWypmUHs8KNIU TA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7p4q9s60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:22:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FEMdgk021744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:22:40 GMT
Received: from [10.216.11.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 07:22:36 -0700
Message-ID: <d5561151-08bb-9f5f-aa51-44c5ad31976b@quicinc.com>
Date:   Thu, 15 Jun 2023 19:52:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
 <2023061547-staleness-camper-ae8a@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023061547-staleness-camper-ae8a@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6uRqE5KTw4hEWIz2pmYtZehKKNoKL__i
X-Proofpoint-ORIG-GUID: 6uRqE5KTw4hEWIz2pmYtZehKKNoKL__i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_10,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150125
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15-06-23 03:00 pm, Greg Kroah-Hartman wrote:
> On Wed, Jun 14, 2023 at 12:14:08PM +0300, Heikki Krogerus wrote:
>> On Wed, May 31, 2023 at 08:11:14PM +0530, Prashanth K wrote:
>>> Currently if we bootup a device without cable connected, then
>>> usb-conn-gpio won't call set_role() since last_role is same as
>>> current role. This happens because during probe last_role gets
>>> initialised to zero.
>>>
>>> To avoid this, added a new constant in enum usb_role, last_role
>>> is set to USB_ROLE_UNKNOWN before performing initial detection.
>>>
>>> While at it, also handle default case for the usb_role switch
>>> in cdns3, intel-xhci-usb-role-switch & musb/jz4740 to avoid
>>> build warnings.
>>>
>>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>> v7: Added default case in musb/jz4740.c & intel-xhci-usb-role-switch.c to
>>>      avoid build warnings.
>>> v6: Moved USB_ROLE_UNKNOWN towards the end of enum usb_role.
>>> v5: Update commit text to mention the changes made in cdns3 driver.
>>> v4: Added Reviewed-by tag.
>>> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>>>      the test robot.
>>> v2: Added USB_ROLE_UNKNWON to enum usb_role.
>>>
>>>   drivers/usb/cdns3/core.c                       | 2 ++
>>>   drivers/usb/common/usb-conn-gpio.c             | 3 +++
>>>   drivers/usb/musb/jz4740.c                      | 2 ++
>>>   drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
>>>   include/linux/usb/role.h                       | 1 +
>>>   5 files changed, 10 insertions(+)
>>
>> Just to be clear to everybody, that USB_ROLE_UNKNOWN is not handled in
>> drivers/usb/roles/class.c, so this patch is broken.
>>
>> But the whole approach is wrong. That USB_ROLE_UNKNOWN is clearly a
>> flag where the other values in enum usb_role are actual switch states.
>> So it does not belong there.
>>
>> In general, adding globals states like that just in order to work
>> around issues in single drivers is never a good idea IMO.
> 
> Ok, let me go revert this from my tree, thanks for the review.
> 
> greg k-h

In that case, can I resubmit v1 of this patch again, where I have used a 
macro in usb-conn-gpio driver ? something like this.

@@ -27,6 +27,8 @@
  #define USB_CONN_IRQF	\
  	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)

+#define USB_ROLE_UNKNOWN (USB_ROLE_NONE -1)
+
  struct usb_conn_info {
  	struct device *dev;
  	struct usb_role_switch *role_sw;
@@ -257,6 +259,9 @@  static int usb_conn_probe(struct platform_device *pdev)
  	platform_set_drvdata(pdev, info);
  	device_set_wakeup_capable(&pdev->dev, true);

+	/* Set last role to unknown before performing the initial detection */
+	info->last_role = USB_ROLE_UNKNOWN;
+
  	/* Perform initial detection */
  	usb_conn_queue_dwork(info, 0);

Thanks,
Prashanth K
