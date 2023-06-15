Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B1731A67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjFONsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjFONsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:48:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140441FD4;
        Thu, 15 Jun 2023 06:48:00 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FDdHPa014416;
        Thu, 15 Jun 2023 13:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0LDiQ7QQb1AId1XieMZ6NIoy9CpkFaV7zwJID5Hj/Oo=;
 b=dkwIuS/c8s/lzaC7I2z2MxTfkPdt5vZscD3+SJd3czXpZfJx9eo+Oq+Dj6av2UoDS00d
 k6Gjx+AfqJzamGswkqFqK7+cYjVi33kPUFvTT8IPQDSZpATbR51ZqthtvgN+4lqcZsdf
 TYlUSW0QdyX4E/SNSGfgjVVr9ep1ArUTgS4nhP6XXiwFd0eQv6UglAPLchaXvS0A1XyL
 m6iLcR32c7H7LJCjlfo4Tpqd0LrFCotPZ2F2idslvc4LXHed/5LDQOzyFn8AQQJhIwA1
 n0zSBNr3RD4u+5R3w5bxm6E7F6C2N0Fic1kwWf47U4gWrwum7zkgJGti4yk42H4WTmQa vQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r83p980sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 13:47:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FDlf8L031123
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 13:47:41 GMT
Received: from [10.50.16.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 06:47:37 -0700
Message-ID: <5d9ab90f-4fc3-26c6-141e-e9388ac2f0cf@quicinc.com>
Date:   Thu, 15 Jun 2023 19:17:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH V23 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
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
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
 <2259ab0348282349e88905ea99bcb4aa815d941f.1683265984.git.quic_schowdhu@quicinc.com>
 <2023061542-reformed-unholy-10a3@gregkh>
 <cc9750f3-c85c-be7f-e63c-0fcf4eb160f0@quicinc.com>
 <2023061515-unbuckled-consonant-e207@gregkh>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023061515-unbuckled-consonant-e207@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eHemSX8XnrDNw_eIcSRWHcTwR2raXKl9
X-Proofpoint-GUID: eHemSX8XnrDNw_eIcSRWHcTwR2raXKl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_09,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150121
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 6:20 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 15, 2023 at 06:13:53PM +0530, Souradeep Chowdhury wrote:
>>
>>
>> On 6/15/2023 4:03 PM, Greg Kroah-Hartman wrote:
>>> On Thu, May 04, 2023 at 11:36:22PM -0700, Souradeep Chowdhury wrote:
>>>> +/**
>>>> + * struct dcc_config_entry - configuration information related to each dcc instruction
>>>> + * @base:                    Base address of the register to be configured in dcc
>>>
>>> Why is this a u32 and not a bigger size?
>>
>> Currently only 32 bit register addresses are supported for DCC
>> configuration.
>>
>>>
>>>> + * @offset:                  Offset to the base address to be configured in dcc
>>>> + * @len:                     Length of the address in words to be configured in dcc
>>>
>>> What is a "word" here, 16 bits?
>>
>> Each word is 4 bytes(32 bits)
> 
> See, I guess wrong, you should say what this is :)

Ack

> 
>>>> + * @loop_cnt:                The number of times to loop on the register address in case
>>>> +				of loop instructions
>>>> + * @write_val:               The value to be written on the register address in case of
>>>> +				write instructions
>>>> + * @mask:                    Mask corresponding to the value to be written in case of
>>>> +				write instructions
>>>> + * @apb_bus:                 Type of bus to be used for the instruction, can be either
>>>> +				'apb' or 'ahb'
>>>
>>> How can a bool be either "apb" or "ahb"?
>>
>> 1 stands for apb and 0 for ahb. Will update the same here.
> 
> Why not have an enum?  Will there ever be another "bus"?

No, only these two are supported for dcc.

> 
>>>> +static ssize_t ready_read(struct file *filp, char __user *userbuf,
>>>> +			  size_t count, loff_t *ppos)
>>>> +{
>>>> +	int ret = 0;
>>>> +	char *buf;
>>>> +	struct dcc_drvdata *drvdata = filp->private_data;
>>>> +
>>>> +	mutex_lock(&drvdata->mutex);
>>>> +
>>>> +	if (!is_dcc_enabled(drvdata)) {
>>>> +		ret = -EINVAL;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>> +	if (!FIELD_GET(BIT(1), readl(drvdata->base + dcc_status(drvdata->mem_map_ver))))
>>>> +		buf = "Y\n";
>>>> +	else
>>>> +		buf = "N\n";
>>>> +out_unlock:
>>>> +	mutex_unlock(&drvdata->mutex);
>>>> +
>>>> +	if (ret < 0)
>>>> +		return -EINVAL;
>>>> +	else
>>>
>>> You do the "lock, get a value, unlock, do something with the value"
>>> thing a bunch, but what prevents the value from changing after the lock
>>> happens?  So why is the lock needed at all?
>>
>> The lock is used to prevent concurrent accesses of the drv_data when
>> scripts are being run from userspace.
> 
> How would that matter?  The state can change instantly after the lock is
> given up, and then the returned value is now incorrect.  So no need for
> a lock at all as you really aren't "protecting" anything, or am I
> missing something else?

This lock is needed to protect the access to the global instance of 
drv_data structure instantiated at probe time within each individual 
callbacks of debugfs.

> 
> thanks,
> 
> greg k-h
