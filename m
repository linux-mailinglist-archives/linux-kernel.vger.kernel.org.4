Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F78711EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbjEZEqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:46:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374CE43;
        Thu, 25 May 2023 21:45:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q2tOWX002261;
        Fri, 26 May 2023 04:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1Dih0sAKjwpcRXPxZ76JqsfvyqwXr0hHg9S6VkysVR4=;
 b=FBfsxx/WBMbuGtYpuRwWk4Gb9WJnS8y6ffUai4AHQEGmq1sxMZEc5RUpJ/BdynSJzvGu
 OK/PgNi7HKstQU9KiWyxEQXI/yjS8jyUo75pt/1jogrdGxzt9jRMXfa7Mp86QTepsbwc
 ZYkQOURBZ6tFC8FOew+cZgEpksrI1LlWUZey/fj23N3vjkTww76b+2wry00Wv82vNowy
 UKJcvXX8D8GQwaaCsdGVQdHpIKQnSOWJbfMSHsmzpUBxXPlWzsB9VzSUjjX3N6OWzGbx
 v+GfAI9xUmxpfh4fczOfv3FyYi73R2QZZUIeSJiiSQtUdRS4t4jANTsUktSxKPzGE/96 gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtkxwg8nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 04:45:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q4jmfN011659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 04:45:48 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 21:45:46 -0700
Message-ID: <5f144d80-0439-d014-c845-1cfb1adb840a@quicinc.com>
Date:   Fri, 26 May 2023 10:15:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
 <2023052513-gestate-tartar-bf15@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023052513-gestate-tartar-bf15@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fO9cwBsLOgoe-icmeoK6ZMOunapFsdw1
X-Proofpoint-ORIG-GUID: fO9cwBsLOgoe-icmeoK6ZMOunapFsdw1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260040
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25-05-23 10:04 pm, Greg Kroah-Hartman wrote:
> On Thu, May 25, 2023 at 02:23:45PM +0530, Prashanth K wrote:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialised to zero.
>>
>> To avoid this, added a new constant in enum usb_role, last_role
>> is set to USB_ROLE_UNKNOWN before performing initial detection.
>>
>> While at it, also handle default case for the usb_role switch
>> in cdns3 to avoid build warnings.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>> v5: Update commit text to mention the changes made in cdns3 driver.
>> v4: Added Reviewed-by tag.
>> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>>      the test robot.
>> v2: Added USB_ROLE_UNKNWON to enum usb_role.
>>
>>   drivers/usb/cdns3/core.c           | 2 ++
>>   drivers/usb/common/usb-conn-gpio.c | 3 +++
>>   include/linux/usb/role.h           | 1 +
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index dbcdf3b..69d2921 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -252,6 +252,8 @@ static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
>>   		if (!vbus)
>>   			role = USB_ROLE_NONE;
>>   		break;
>> +	default:
>> +		break;
> 
> No error if this happens?
It wouldn't come to default case in as no one sets the role to 
USB_ROLE_UNKNOWN in cdns3 driver. Moreover it would work the same
without the default case also (we have added it just to address a 
warning pointed out be test-robot).
> 
>>   	}
>>   
>>   	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
>> index e20874c..30bdb81 100644
>> --- a/drivers/usb/common/usb-conn-gpio.c
>> +++ b/drivers/usb/common/usb-conn-gpio.c
>> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, info);
>>   	device_set_wakeup_capable(&pdev->dev, true);
>>   
>> +	/* Set last role to unknown before performing the initial detection */
>> +	info->last_role = USB_ROLE_UNKNOWN;
> 
> Shouldn't last_role have already been set to 0?  If so, why not just
> have this enum value be 0?
Last role would be 0 during first detection, that's the problem here.
During initial detection, if the the new role is detected as 
USB_ROLE_NONE (0), then we wouldn't call the set_role(). But it should 
send the current role to gadget after the inital detection.

if (info->last_role == role) {
		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
		return;
	}
> 
> 
>> +
>>   	/* Perform initial detection */
>>   	usb_conn_queue_dwork(info, 0);
>>   
>> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
>> index b5deafd..221d462 100644
>> --- a/include/linux/usb/role.h
>> +++ b/include/linux/usb/role.h
>> @@ -8,6 +8,7 @@
>>   struct usb_role_switch;
>>   
>>   enum usb_role {
>> +	USB_ROLE_UNKNOWN = -1,
> 
> Why is this explicitly set to a value?  What is magic about -1?  Why not
> 0x42?  Or something else?  Or as I mention above, 0?
> I just chose -1 as the currently 0,1,2 are used for NONE, Device and 
Host roles. Didn't make the USB_ROLE_UNKNOWN = 0 because i didn't want 
to break the existing logic in other drivers. Do you have any 
suggestion? Please let me know.

Thanks,
Prashanth K
