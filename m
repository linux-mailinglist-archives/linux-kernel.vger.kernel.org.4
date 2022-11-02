Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CF616B86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKBSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiKBSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:05:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B72EF19;
        Wed,  2 Nov 2022 11:05:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2HvRK8021920;
        Wed, 2 Nov 2022 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DYV6UhlxBjAVhUwnUSfoiUxcFgJpAGe3cb+kiFS//ko=;
 b=A/5TWOpZ6Q+PPzRcEALKyEY/6yCizUdad0FFpEE+QXWouXi24dc/jIlggChSg7dIJH+Z
 CGeimhqgbJ056v6hp99/yG0Ff5vIHHPXGvWbgixnEhctAVaPW9xveScqUOf9vx9dG56c
 pdykAI4fVjcnY6geCTQZSibaO+HaxYsXZLsmk/+HDr/Gs83s6TK6CVoktJBaeT6m7G2I
 cAHGPD2cXSVqBC7zAd8QNDPmFXvUwl3siupi67ZdaqVO3SX+MO+e64mBfxZvBWh0Knxp
 R8TnYBO5fGMr5lJPYsI+Cbd1VRimDDRPcZh2Oo+gygqV9Cf988nqVET7gq79Lt76qgMg nQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkm40132q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:04:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2I4kEN018416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 18:04:46 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 11:04:45 -0700
Message-ID: <28eaa4bd-a9ee-c415-57c4-a9a56ffeef18@quicinc.com>
Date:   Wed, 2 Nov 2022 11:04:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 10/21] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-11-quic_eberman@quicinc.com>
 <Y2FfKCKZ3N8rOqcT@kroah.com>
 <3d2858fe-ea3e-159c-faff-5052cba1e08c@quicinc.com>
 <Y2Hbl4y9Hioybxmq@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2Hbl4y9Hioybxmq@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qoEDl_mkLKaCYoFGnVLHFqai4C07Z8lz
X-Proofpoint-ORIG-GUID: qoEDl_mkLKaCYoFGnVLHFqai4C07Z8lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=657 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 7:53 PM, Greg Kroah-Hartman wrote:
> On Tue, Nov 01, 2022 at 05:12:58PM -0700, Elliot Berman wrote:
>>
>>
>> On 11/1/2022 11:02 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 26, 2022 at 11:58:35AM -0700, Elliot Berman wrote:
>>>> The resource manager is a special virtual machine which is always
>>>> running on a Gunyah system. It provides APIs for creating and destroying
>>>> VMs, secure memory management, sharing/lending of memory between VMs,
>>>> and setup of inter-VM communication. Calls to the resource manager are
>>>> made via message queues.
>>>>
>>>> This patch implements the basic probing and RPC mechanism to make those
>>>> API calls. Request/response calls can be made with gh_rm_call.
>>>> Drivers can also register to notifications pushed by RM via
>>>> gh_rm_register_notifier
>>>>
>>>> Specific API calls that resource manager supports will be implemented in
>>>> subsequent patches.
>>>>
>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>> ---
>>>>    MAINTAINERS                    |   2 +-
>>>>    drivers/virt/gunyah/Kconfig    |  15 +
>>>>    drivers/virt/gunyah/Makefile   |   3 +
>>>>    drivers/virt/gunyah/rsc_mgr.c  | 602 +++++++++++++++++++++++++++++++++
>>>>    drivers/virt/gunyah/rsc_mgr.h  |  34 ++
>>>>    include/linux/gunyah_rsc_mgr.h |  26 ++
>>>>    6 files changed, 681 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>>>    create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>>>    create mode 100644 include/linux/gunyah_rsc_mgr.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 586539eadd3b..e072a0d2e553 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -8945,7 +8945,7 @@ F:	Documentation/virt/gunyah/
>>>>    F:	arch/arm64/gunyah/
>>>>    F:	drivers/mailbox/gunyah-msgq.c
>>>>    F:	drivers/virt/gunyah/
>>>> -F:	include/linux/gunyah.h
>>>> +F:	include/linux/gunyah*.h
>>>>    HABANALABS PCI DRIVER
>>>>    M:	Oded Gabbay <ogabbay@kernel.org>
>>>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>>>> index 127156a678a6..4de88d80aa7b 100644
>>>> --- a/drivers/virt/gunyah/Kconfig
>>>> +++ b/drivers/virt/gunyah/Kconfig
>>>> @@ -10,3 +10,18 @@ config GUNYAH
>>>>    	  Say Y/M here to enable the drivers needed to interact in a Gunyah
>>>>    	  virtual environment.
>>>> +
>>>> +config GUNYAH_RESORUCE_MANAGER
>>>> +	tristate "Gunyah Resource Manager"
>>>> +	select MAILBOX
>>>> +	select GUNYAH_MESSAGE_QUEUES
>>>> +	depends on GUNYAH
>>>> +	default y
>>>
>>> You only have "default y" if your machine can not boot without it.
>>> Please do not add that here.
>>>
>>
>> There's a guideline in Documentation/kbuild/kconfig-language.rst to provide
>> some sane defaults for subdriver behavior. Here, CONFIG_GUNYAH is default n.
>> It's unlikely for someone to want to have Linux with base Gunyah support
>> (hypercalls and hypervisor detection) without also having the Resource
>> Manager driver. If it's better, I could change to default m?
> 
> Why is this a separate build option at all anyway?  If you want
> CONFIG_GUNYAH why would you ever turn this off?  So why even allow it to
> be an option?  Just always built it depending on the main option.
> 

Ack.

I'll also end up removing CONFIG_GUNYAH_MESSAGE_QUEUES from patch 9 as well.

>>>> +/* Resource Manager Header */
>>>> +struct gh_rm_rpc_hdr {
>>>> +	u8 version : 4, hdr_words : 4;
>>>> +	u8 type : 2, fragments : 6;
>>>
>>> Ick, that's hard to read.  One variable per line please?
>>
>> Ack.
>>
>>> And why the bit packed stuff?  Are you sure this is the way to do this?
>>> Why not use a bitmask instead?
>>>
>>
>> I felt bit packed implementation is cleaner and easier to map to
>> understanding what the fields are used for.
> 
> Ah, so this isn't what is on the "wire", then don't use a bitfield like
> this, use a real variable and that will be faster and simpler to
> understand.
> 

This is what's on the "wire". Whether I use bitfield or bit packed would 
be functionally the same and is just a cosmetic change IMO.

>>>> +static struct gh_rsc_mgr *__rsc_mgr;
>>>
>>> Sorry, no, you don't get to just limit yourself to one of these.  Please
>>> make this properly handle any number of "resource managers", static
>>> variables like this is not ok.
>>>
>>
>> There will only ever be one resource manager. optee, psci, and qcom_scm use
>> a similar approach.
> 
> And all of those are also wrong.
> 
> There is no need for this variable at all, you are doing extra work to
> make this a "single" device.  Just always work off of the device that
> the driver core gave you and all is good and you will have no limits on
> how many different ones you eventually get.  It will be less code
> overall, so it's the right thing to do.
> 

Ack

>>>> +SRCU_NOTIFIER_HEAD_STATIC(gh_rm_notifier);
>>>
>>> Why do you need a notifier list?
>>>
>>> Who will register for this?  For what?  Why?
>>>
>>
>> The majority of notifications that RM sends to Linux will be related to VM
>> state, e.g. "VM crashed." I've not added the handling in VM manager yet to
>> reduce the number of patches in this series. It was used in the previous
>> series for the console driver. I can remove for now and re-introduce it once
>> VM manager makes use?
> 
> Please remove if you are not using it.  Notifier lists are almost always
> wrong when it comes to the driver model, so please don't add them now,
> we can discuss it later if you feel it really needs to be introduced
> then.
> 

Ack

>>>> +static struct platform_driver gh_rm_driver = {
>>>> +	.probe = gh_rm_drv_probe,
>>>> +	.remove = gh_rm_drv_remove,
>>>> +	.driver = {
>>>> +		.name = "gh_rsc_mgr",
>>>> +		.of_match_table = gh_rm_of_match,
>>>> +	},
>>>
>>> Wait, why is this a platform driver?  This is binding to a real device
>>> on a real bus, not a random platform description in DT, right?
>>
>> This a binding for a real device and not a "random platform description" in
>> DT to get the driver probed.
>>
>>> Or is it controlled by your DT?  I can't figure that out here, sorry.
>>
>> There is some info in Patch 2 about why the DT node exists and how it looks.
>> Essentially, The DT node is provided by Gunyah during boot and describes how
>> Linux can communicate with resource manager.
> 
> Ick, ok, for now let's leave this alone but for dynamic devices, you
> should never use a platform device.  All devices that hang off of this
> controller better not be platform devices, but belong to the bus type of
> your new bus, right?
> 

That's correct.
