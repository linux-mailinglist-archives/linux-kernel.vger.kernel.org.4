Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EA65DC2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbjADScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbjADSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:31:45 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39860140A1;
        Wed,  4 Jan 2023 10:31:44 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304DbDcb015505;
        Wed, 4 Jan 2023 19:31:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WfZwJcrBMKwvdfBPxILWgnGLzt5unwxxJQQXBDQ228w=;
 b=EyxULBq1hBMOm39zDHirxvckCg+FF3nnQhekLwqUYo4Wf3PvM5cIp+M8rtubGfUDhlYI
 AQlHW1ftx0VOamx9Jhuiym3KPGuTFJHhAePaFBVHCzmZCIqnaxQ6d+v/8cEWrRoEZ6Vv
 cOeZjDN/QgNqkbp9lJsjD+veZO7OZV/ldjf0kvC7a9nLjMqi8WCDgsVKcjV8Pes/N8ob
 tb+RA1Z842RVQKxHWrMWc7LImhyHI8UmLPMjSRojJGK8/VV5L2fdRFZnfF4pXMO8me1c
 i5GAZTAE/BspwVTf+ytfMUaFGRbQ4LQolDlJp3n2NhkbfiqmeRXWav79ztCRb2LtSuk1 eQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtb3ecwfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 19:31:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2A2E10002A;
        Wed,  4 Jan 2023 19:31:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BBD5422FA22;
        Wed,  4 Jan 2023 19:31:28 +0100 (CET)
Received: from [10.201.20.180] (10.201.20.180) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 4 Jan
 2023 19:31:25 +0100
Message-ID: <72b4fa78-0526-5ff9-c5ed-9301227a7770@foss.st.com>
Date:   Wed, 4 Jan 2023 19:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-4-git-send-email-quic_sarannya@quicinc.com>
 <12f53ff1-a358-7129-c9ed-9b9fd7dad7e7@foss.st.com>
 <20221227155641.xlkel7uhk7jr4qru@builder.lan>
 <45444451-26e3-c203-bdeb-59170b6cc5ba@foss.st.com>
 <20230104160331.w2sicwlqiygr42hl@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230104160331.w2sicwlqiygr42hl@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.180]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 17:03, Bjorn Andersson wrote:
> On Tue, Jan 03, 2023 at 03:50:10PM +0100, Arnaud POULIQUEN wrote:
>> On 12/27/22 16:56, Bjorn Andersson wrote:
>>> On Wed, Dec 21, 2022 at 05:28:16PM +0100, Arnaud POULIQUEN wrote:
>>>>
>>>>
>>>> On 12/7/22 14:04, Sarannya S wrote:
> [..]
>>>>>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>>>>>  
>>>>> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
>>>>> -		return -EINVAL;
>>>>> -
>>>>> -	/* Don't allow to destroy a default endpoint. */
>>>>> -	if (eptdev->default_ept)
>>>>> -		return -EINVAL;
>>>>> +	bool set;
>>>>> +	u32 val;
>>>>> +	int ret;
>>>>> +	
>>>>> +	switch (cmd) {
>>>>> +	case TIOCMGET:
>>>>> +		eptdev->signals_pending = false;
>>>>> +		ret = put_user(eptdev->remote_signals, (int __user *)arg);
>>>>> +		break;
>>>>> +	case TIOCMSET:
>>>>> +		ret = get_user(val, (int __user *)arg);
>>>>> +		if (ret)
>>>>> +			break;
>>>>> +		set = (val & (TIOCM_DTR | TIOCM_RTS)) ? true : false;
>>>>> +		ret = rpmsg_set_flow_control(eptdev->ept, set, 0);
>>>>> +		break;
>>>>
>>>> I still wonder if it makes sense to implement serial IOCTRL in rpmsg_char.
>>>
>>> I've thinking about this since v1 as well...
>>>
>>>> I think it is quite dangerous to have such kind of mixed interface.
>>>> User application would want to use the serial interface should use the tty
>>>> interface.
>>>>
>>>
>>> Can you please elaborate on this statement, because I have a hard time
>>> to state why the user space application must use the tty interface
>>> instead of rpmsg_char.
>>>
>>> And in particular, I don't think this is a question for the "user
>>> application", but rather for the system configuration.
>>>
>>> In order to move an application that works with rpmsg_char to the tty
>>> driver ("because it's the right thing to do..."?) means that the system
>>> needs to be reconfigured, such that the given rpmsg channel is exposed
>>> through the tty driver instead.
>>>
>>> This in turn either implies that the firmware needs to be changed to
>>> expose these channels with the name "rpmsg-tty" - and the application
>>> taught how to figure out which ttyRPMSGn to open - or the rpmsg_ctrl
>>> interface needs to be extended to allow the Linux side to request a
>>> particular channel to be exposed as rpmsg_char vs rpmsg-tty...
>>>
>>
>> You are right, it can be not straightforward to migrate to rpmsg_tty. That's why
>> it also makes sense to implement flow control in the rpmsg char.
>>
>> What I try to highlight is the use of the RS232 signaling(e.g TIOCM_DTR) and
>> TIOCMGET/TIOCMSE  terminal IOCTL in this patch.
>> Please tell me if I wrong, but seems to me that such interface is dedicated to
>> the serial/TTY frameworks [1].
>> So does it make sense to reuse this interface for the rpmsg char?
>>
> 
> We're in understanding of the usefulness and the question about the
> validity of reusing the tty's TIOCM{GET,SET} ioctl here. I don't know
> the answer to the latter, and haven't pushed on this point.
> 
>> [1]https://elixir.bootlin.com/linux/latest/source/include/uapi/asm-generic/ioctls.h#L8
>>
>> Instead we could have generic RPMSG IOCTLs that can be implemented on different
>> rpmsg clients whatever the rpmsg channel (so not only the rpmsg char). This is
>> the proposal below.
>>
> 
> Using a new pair of rpmsg_char ioctls for "set/get flow enable/disable"
> would, IMHO, be easier to understand and it would avoid assumptions
> inherited about all the other bits in the TIOCMSET ioctl.

This also seems to me the best approach

Regards,
Arnaud


> 
> Regards,
> Bjorn
> 
>> Regards,
>> Arnaud
>>
>>>> For the rpmsg char, I would be in favor of creating a specific RPMSG IOCTRLs
>>>> to avoid confusion.
>>>>
>>>> For instance:
>>>>
>>>>  - RPMSG_GET_SIGN_IOCTRL
>>>>  - RPMSG_SET_SIGN_IOCTRL
>>>>
>>>
>>> Again, we're talking "flow control" at this level. So either we follow
>>> the standard IOCTL and make it easy for existing applications to use
>>> rpmsg_char, or we provide a _good_ explanation why they must use the
>>> tty interface instead (and if so solve above mentioned problems).
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> With associated parameter corresponding to the bitmap proposed in my comment of
>>>> your patch 1/4.
>>>>
>>>> Of course, this is only a suggestion, I let Bjorn and Mathieu comment.
>>>>
>>>> Regards,
>>>> Arnaud
>>>>
>>>>
>>>>> +	case RPMSG_DESTROY_EPT_IOCTL:
>>>>> +		/* Don't allow to destroy a default endpoint. */
>>>>> +		if (eptdev->default_ept) {
>>>>> +			ret = -EINVAL;
>>>>> +			break;
>>>>> +		}
>>>>> +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
>>>>> +		break;
>>>>> +	default:
>>>>> +		ret = -EINVAL;
>>>>> +	}
>>>>>  
>>>>> -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
>>>>> +	return ret;
>>>>>  }
>>>>>  
>>>>>  static const struct file_operations rpmsg_eptdev_fops = {
