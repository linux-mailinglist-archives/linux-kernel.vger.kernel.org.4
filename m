Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1B6E403E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjDQG4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjDQG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:56:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3D5CF;
        Sun, 16 Apr 2023 23:56:46 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H6bqIZ019174;
        Mon, 17 Apr 2023 06:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+riOMhGrkPIlf8RZfAbq3w3SMQ3LxCD9OxvN7i//HhU=;
 b=T9XoFWCNOpx39m76jwDj7MSxOfBJXmBkGfrWf7Excg5Y7eFt1dzh2jOhGIWrS5FOZEDe
 pqVVGrkeuY6QsNhOFgGNNs2Awsc63ixo3can87hizEWdSDyM8MzeFXCf0YlyZ/vuWpzz
 geZ3e8ZM2I3SJc3Uys2pr7g08yHyDpegMRsQoSBCKuwBqT5p1oAXWCgQM9/vRo0xscU5
 RdDqqDkjX04tIdqV2R5Y5jW+Vv13MdpMsB1HDk+Yu9xH237fR31+s3hzOEC3r8FuiDtU
 I9+MfwKNz9fmO5q+E9XfjPUx8+tIctE93R/QExhtvTZMGuC8xXWWIxCY7At3BurCkF4i tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymnets0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:56:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H6uVb0029930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:56:31 GMT
Received: from [10.50.21.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 23:56:26 -0700
Message-ID: <7c46fe45-70b4-1f20-5ab4-cd51917d04a8@quicinc.com>
Date:   Mon, 17 Apr 2023 12:26:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1681480351.git.quic_schowdhu@quicinc.com>
 <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
 <ZDo4jIIV7cfPD2qW@kroah.com>
 <f3196d7a-50f0-9bfb-71a6-47ddb9686039@quicinc.com>
 <ZDzkkNQP5eO2vcxA@kroah.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <ZDzkkNQP5eO2vcxA@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1mkGfxLsbtpeUfezU-IoRVvBLb9FI7dM
X-Proofpoint-GUID: 1mkGfxLsbtpeUfezU-IoRVvBLb9FI7dM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_03,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170062
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2023 11:47 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 17, 2023 at 11:31:46AM +0530, Souradeep Chowdhury wrote:
>>
>>
>> On 4/15/2023 11:09 AM, Greg Kroah-Hartman wrote:
>>> On Fri, Apr 14, 2023 at 07:29:12PM +0530, Souradeep Chowdhury wrote:
>>>> The DCC is a DMA Engine designed to capture and store data
>>>> during system crash or software triggers. The DCC operates
>>>> based on user inputs via the debugfs interface. The user gives
>>>> addresses as inputs and these addresses are stored in the
>>>> dcc sram. In case of a system crash or a manual software
>>>> trigger by the user through the debugfs interface,
>>>> the dcc captures and stores the values at these addresses.
>>>> This patch contains the driver which has all the methods
>>>> pertaining to the debugfs interface, auxiliary functions to
>>>> support all the four fundamental operations of dcc namely
>>>> read, write, read/modify/write and loop. The probe method
>>>> here instantiates all the resources necessary for dcc to
>>>> operate mainly the dedicated dcc sram where it stores the
>>>> values. The DCC driver can be used for debugging purposes
>>>> without going for a reboot since it can perform software
>>>> triggers as well based on user inputs.
>>>
>>> You have 72 columns, why not use them all please?
>>>
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>>>
>>> It is now 2023 :)
>>
>> Ack
>>
>>>
>>>
>>>
>>>
>>>> + */
>>>> +
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/fs.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/iopoll.h>
>>>> +#include <linux/miscdevice.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/uaccess.h>
>>>> +
>>>> +#define STATUS_READY_TIMEOUT		5000  /* microseconds */
>>>> +
>>>> +#define DCC_SRAM_NODE "dcc_sram"
>>>
>>> You only use this once, why is a #define needed?
>>
>> This is as per the comment on version 1 of the patch series on DCC
>>
>> https://lore.kernel.org/linux-arm-kernel/YElUCaBUOx7hEuIh@builder.lan/
>>
>> "kzalloc + strlcpy can be replaced by kstrdup(), but that said...all this
>> does seems to be to copy a const string to the heap and lugging it
>> around. Use a define instead."
> 
> But as you are not doing any of that here, just using the string in the
> one place it is needed is the same thing :)

Ack

> 
>>>> +static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
>>>> +{
>>>> +	int i;
>>>> +	char list_num[10];
>>>> +	struct dentry *list;
>>>> +	struct device *dev = drvdata->dev;
>>>> +
>>>> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
>>>
>>> You are creating a directory at the root of debugfs with just your
>>> device name?  While that will work, that feels very odd.  Please use a
>>> subdirectory.
>>
>> This is as per the comment on v17 of the patch series on DCC
>>
>> https://lore.kernel.org/linux-arm-kernel/6693993c-bd81-c974-a903-52a62bfec606@ieee.org/
>>
>> "You never remove this dcc_dbg directory.  Why not?
>>
>> And since you don't, dcc_dbg could just be a local
>> variable here rather than being a global.  But it
>> seems to me this is the root directory you want to
>> remove when you're done."
> 
> But that's not the issue.  The issue is that you are putting into
> /sys/kernel/debug/ a flat namespace of all of your devices.  Is that
> really what you want?  If so, why do you think this will never conflict
> with any other device in the system?

Since we are going by the dev_name here which also contains the address
as per the example in the yaml binding, this will not conflict with 
other dev_names in the system.

> 
>>>> +	if (IS_ERR(drvdata->dbg_dir)) {
>>>> +		pr_err("can't create debugfs dir\n");
>>>
>>> There is no need to ever check the return value of a debugfs call.
>>>
>>> Nor do you really ever even need to save off the dentry here, just look
>>> it up when you need to remove it.
>>
>> Ack
>>
>>>
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i <= drvdata->nr_link_list; i++) {
>>>> +		sprintf(list_num, "%d", i);
>>>> +		list = debugfs_create_dir(list_num, drvdata->dbg_dir);
>>>> +		debugfs_create_file("enable", 0600, list, drvdata, &enable_fops);
>>>> +		debugfs_create_file("config", 0600, list, drvdata, &config_fops);
>>>> +	}
>>>> +
>>>> +	debugfs_create_file("trigger", 0200, drvdata->dbg_dir, drvdata, &trigger_fops);
>>>> +	debugfs_create_file("ready", 0400, drvdata->dbg_dir, drvdata, &ready_fops);
>>>> +	debugfs_create_file("config_reset", 0200, drvdata->dbg_dir,
>>>> +			    drvdata, &config_reset_fops);
>>>
>>> This really looks like you are using debugfs to control the device, not
>>> just for debugging information.  How are you going to be able to use the
>>> device in a system that has debugfs disabled?
>>
>> As per upstream discussions it was decided that debugfs will be a suitable
>> interface for DCC. More on this in the following link:-
>>
>> https://lore.kernel.org/linux-arm-kernel/20221228172825.r32vpphbdulaldvv@builder.lan/
> 
> debugfs is not a suitable interface for anything that is "real" as
> that's not what it is there for.  Most systems disable debugfs entirely
> (i.e. Android), or prevent any normal user from accessing it, so this
> api you are creating will not be able to be used by anyone.
> 
> debugfs is for debugging, not for anything that the system functionality
> relies on to work properly.

DCC is a debugging hardware which stores the values of the configured 
register address on a system crash on it's dedicated sram. These 
register addresses are configured by the user through the debugfs 
interface. Also on the platforms where debugfs is disabled there is an 
alternative of using bootconfig suggested to configure the register 
values during boot-time. There is an ongoing patch series for that as 
follows:-

https://lore.kernel.org/linux-arm-kernel/cover.1675054375.git.quic_schowdhu@quicinc.com/T/

> 
> Also, that was a v21 of the patch series, why did the numbering start
> over here at v1?

Ack. It was decided prior to merge this driver under drivers/soc/qcom 
but after discussions it was concluded that drivers/misc will be the 
suitable home for this driver. Will post subsequent versions as a 
continuation of the previous series for convenience.


> 
> thanks,
> 
> greg k-h
