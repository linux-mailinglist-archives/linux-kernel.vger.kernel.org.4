Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7CA5F4CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJDXtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:49:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5EDF0D;
        Tue,  4 Oct 2022 16:49:49 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294MUXuf006009;
        Tue, 4 Oct 2022 23:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yYVBFpUoTmUxhl8D1TwoByLx+KIUeOaM+r4p6TN4k2Q=;
 b=OO+OyhMy7bbfvswA8jW5UtYW9fXD/R9Ol93nLrL8M0Q6mORqKb3CZbM+tFrfntuQQwuD
 uqPFuTyqSJlVeLDe9+TKq3j9xuWNc0IMheq+z//lhjAIPJkofMIgkQMICRhxgWB6FVNy
 GlBeMf8Q+1W3uwBBRLByDjKvyQCWU3ccHwZoiLflsD8yV3JW3G69BBtqOoMQZshmkBhY
 CGG3+D0XldS/qAyoxKu6ml+I1v5vE40qUTSzask50hL9A56ZqjXSk7T7APiLdp/qy8JB
 o6fiGOJAwunnambuHF91ixg/m73c1AUKZl9dB6vUWICLaF1ShGZAaEFfP4dpcGjpIXn+ QQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxdn1y1ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 23:49:31 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294NnTal004320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 23:49:29 GMT
Received: from [10.110.114.145] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 16:49:28 -0700
Message-ID: <1db27cda-356e-bae2-3c6a-b7916123a269@quicinc.com>
Date:   Tue, 4 Oct 2022 16:49:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v4 13/14] gunyah: rsc_mgr: Add auxiliary devices for
 console
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-14-quic_eberman@quicinc.com>
 <Yzbev2mZodsZhFY3@kroah.com>
Content-Language: en-US
In-Reply-To: <Yzbev2mZodsZhFY3@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: geDxqVOcG3Kb2ukHP0NGn_g3deTKmUrU
X-Proofpoint-GUID: geDxqVOcG3Kb2ukHP0NGn_g3deTKmUrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040153
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2022 5:19 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 28, 2022 at 12:56:32PM -0700, Elliot Berman wrote:
>> Gunyah resource manager exposes a concrete functionalities which
>> complicate a single resource manager driver.
> 
> I am sorry, but I do not understand this sentance.  What is so
> complicated about individual devices being created?  Where are they
> created?  What bus?

There's no complexity here with using individual devices, that's why I 
wanted to create secondary (auxiliary devices).

IOW -- "I have a platform device that does a lot of different things. 
Split up the different functionalities of that device into sub devices 
using the auxiliary bus."

> 
> Use auxiliary bus

>> to help split high level functions for the resource manager and keep the
>> primary resource manager driver focused on the RPC with RM itself.
>> Delegate Resource Manager's console functionality to the auxiliary bus.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Kconfig   |  1 +
>>   drivers/virt/gunyah/rsc_mgr.c | 21 +++++++++++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> index 78deed3c4562..610c8586005b 100644
>> --- a/drivers/virt/gunyah/Kconfig
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -17,6 +17,7 @@ config GUNYAH_RESORUCE_MANAGER
>>   	tristate "Gunyah Resource Manager"
>>   	select MAILBOX
>>   	select GUNYAH_MESSAGE_QUEUES
>> +	select AUXILIARY_BUS
>>   	default y
>>   	help
>>   	  The resource manager (RM) is a privileged application VM supporting
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
>> index 7f7e89a6436b..435fe0149915 100644
>> --- a/drivers/virt/gunyah/rsc_mgr.c
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/notifier.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/completion.h>
>> +#include <linux/auxiliary_bus.h>
>>   #include <linux/gunyah_rsc_mgr.h>
>>   #include <linux/platform_device.h>
>>   
>> @@ -98,6 +99,8 @@ struct gh_rsc_mgr {
>>   	struct mutex send_lock;
>>   
>>   	struct work_struct recv_work;
>> +
>> +	struct auxiliary_device console_adev;
>>   };
>>   
>>   static struct gh_rsc_mgr *__rsc_mgr;
>> @@ -573,13 +576,31 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>>   
>>   	__rsc_mgr = rsc_mgr;
>>   
>> +	rsc_mgr->console_adev.dev.parent = &pdev->dev;
>> +	rsc_mgr->console_adev.name = "console";
>> +	ret = auxiliary_device_init(&rsc_mgr->console_adev);
>> +	if (ret)
>> +		goto err_msgq;
>> +	ret = auxiliary_device_add(&rsc_mgr->console_adev);
>> +	if (ret)
>> +		goto err_console_adev_uninit;
>> +
>>   	return 0;
>> +
>> +err_console_adev_uninit:
>> +	auxiliary_device_uninit(&rsc_mgr->console_adev);
>> +err_msgq:
>> +	gunyah_msgq_remove(&rsc_mgr->msgq);
>> +	return ret;
>>   }
> 
> Why can't you just have individual platform devices for the individual
> devices your hypervisor exposes?
> 
> You control the platform devices, why force them to be shared like this?
> 

The resource manager exposes quite a bit of functionality, and I think 
it makes sense to expose them as auxiliary devices. From 
Documentation/driver-api/auxiliary_bus.rst:

A key requirement for utilizing the auxiliary bus is that there is no
dependency on a physical bus, device, register accesses or regmap support.
These individual devices split from the core cannot live on the platform 
bus as
they are not physical devices that are controlled by DT/ACPI.

> thanks,
> 
> greg k-h
