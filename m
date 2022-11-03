Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85399618B96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKCWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCWdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:33:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2C61FCE7;
        Thu,  3 Nov 2022 15:33:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3MWa4N020807;
        Thu, 3 Nov 2022 22:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ojVz6+kfupsCAHfqd+jwQYHHjRd1Sj2lQ0/Cs05oazE=;
 b=LkdqzMfJ93AdRhxbWol/fmuJlpLghVdOFB3XzaescAeQX+LAUJ1igua1AjNnUpCQTwj/
 ljrVkFn25suqv+8wbm4uayIHIJtpfGDXEVquZnLf/wQuUiKxdFo/89x/eA7lWuCdSPiZ
 GqgpTxgJna40ta5gfUnO6tyKryK9YBWI9DH7Ul3V/u/KaOmC+K5th6rx96Wz71pEEe8T
 8pI78PuMgjuuDcQ570Sz1op9QpfQ1283fdiBG8dqfKdE9Dqdb/7EAk5fjj6oZnsNmFAI
 wHyQ527MJMZnWRuIBEeiadMP6TD7sW9EcKNCZGjMXZwJK5vBqgGOt0InLHbAoAiAo6+S eA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmpgx803a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 22:33:25 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A3MXOVt006920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 22:33:24 GMT
Received: from [10.110.42.219] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 15:33:23 -0700
Message-ID: <ab7184f6-09e4-4b1c-bebe-30119b8da46c@quicinc.com>
Date:   Thu, 3 Nov 2022 15:33:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
 <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
 <Y2MJYEqnJONvH0fY@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2MJYEqnJONvH0fY@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bjBicJSDzvATZudAaAiSrBktCr4v1hol
X-Proofpoint-ORIG-GUID: bjBicJSDzvATZudAaAiSrBktCr4v1hol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=909 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 5:20 PM, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 11:44:51AM -0700, Elliot Berman wrote:
>>
>>
>> On 11/2/2022 12:31 AM, Arnd Bergmann wrote:
>>> On Wed, Oct 26, 2022, at 20:58, Elliot Berman wrote:
>>>
>>>> +static const struct file_operations gh_vm_fops = {
>>>> +	.unlocked_ioctl = gh_vm_ioctl,
>>>> +	.release = gh_vm_release,
>>>> +	.llseek = noop_llseek,
>>>> +};
>>>
>>> There should be a .compat_ioctl entry here, otherwise it is
>>> impossible to use from 32-bit tasks. If all commands have
>>> arguments passed through a pointer to a properly defined
>>> structure, you can just set it to compat_ptr_ioctl.
>>>
>>
>> Ack.
>>
>>>> +static long gh_dev_ioctl_create_vm(unsigned long arg)
>>>> +{
>>>> +	struct gunyah_vm *ghvm;
>>>> +	struct file *file;
>>>> +	int fd, err;
>>>> +
>>>> +	/* arg reserved for future use. */
>>>> +	if (arg)
>>>> +		return -EINVAL;
>>>
>>> Do you have something specific in mind here? If 'create'
>>> is the only command you support, and it has no arguments,
>>> it would be easier to do it implicitly during open() and
>>> have each fd opened from /dev/gunyah represent a new VM.
>>>
>>
>> I'd like the argument here to support different types of virtual machines. I
>> want to leave open what "different types" can be in case something new comes
>> up in the future, but immediately "different type" would correspond to a few
>> different authentication mechanisms for virtual machines that Gunyah
>> supports.
> 
> Please don't add code that does not actually do something now, as that
> makes it impossible to review properly, _AND_ no one knows what is going
> to happen in the future.  In the future, you can just add a new ioctl
> and all is good, no need to break working userspace by suddenly looking
> at the arg value and doing something with it.
> 

I think the argument does something today and it's documented to need to 
be 0. If a userspace from the future provides non-zero value, Linux will 
correctly reject it because it doesn't know how to interpret the 
different VM types.

I can document it more clearly as the VM type field and support only the 
one VM type today.

Creating new ioctl for each VM type feels to me like I didn't design 
CREATE_VM ioctl right in first place.

Thanks,
Elliot
