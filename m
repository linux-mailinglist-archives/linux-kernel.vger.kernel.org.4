Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244097380AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFUJTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:19:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4C51B4;
        Wed, 21 Jun 2023 02:19:27 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L6S9jI014635;
        Wed, 21 Jun 2023 09:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vAU1Ys21VigpVm04YN3UwYN6qhXIfFW/h2O0LO0OSkQ=;
 b=W8tHjkD+x3IpP0NQZ+x4link8tgA1je6GgNR3qMxzb1G8Q7mLZEIwAy0h/b/c2EuG9rH
 mqRyByOkozGtH9vCl3WD3EwmTyWiYoNeIaftkyqIE88WxCff+0gWXxpNPAQYsyTto3At
 QAtQK2WTVDvbGFw4M57+1zbeJmaDfxYo0ulSbSEJZXY3j0r+3jppKqV/Qaf9G4TWi4h2
 RnIW7nzhe+bSebmKvDxd2lwUMmTS92w4/N7IVoFbZHX2BLjR86mN7WJisU8qlpMBCw/V
 0dP4sVYu1incJa6al3MHYlJ2t2Q9BtJ8yZzyCT2Udpt37FA3tbW8jkh7TAFGpKyrBNrD Bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqkh0rwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 09:19:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L9IsJE015739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 09:18:54 GMT
Received: from [10.50.7.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 02:18:49 -0700
Message-ID: <31cb09ae-dbb8-8ba0-08dc-fcc2af63ca30@quicinc.com>
Date:   Wed, 21 Jun 2023 14:48:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V23 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
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
 <5d9ab90f-4fc3-26c6-141e-e9388ac2f0cf@quicinc.com>
 <2023061548-subtly-cackle-8be2@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023061548-subtly-cackle-8be2@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QQgPXKIzyOTwBP_LMUYqItkgCave8iml
X-Proofpoint-GUID: QQgPXKIzyOTwBP_LMUYqItkgCave8iml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=869
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210079
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 7:36 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 15, 2023 at 07:17:34PM +0530, Souradeep Chowdhury wrote:
>>>>>> +static ssize_t ready_read(struct file *filp, char __user *userbuf,
>>>>>> +			  size_t count, loff_t *ppos)
>>>>>> +{
>>>>>> +	int ret = 0;
>>>>>> +	char *buf;
>>>>>> +	struct dcc_drvdata *drvdata = filp->private_data;
>>>>>> +
>>>>>> +	mutex_lock(&drvdata->mutex);
>>>>>> +
>>>>>> +	if (!is_dcc_enabled(drvdata)) {
>>>>>> +		ret = -EINVAL;
>>>>>> +		goto out_unlock;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!FIELD_GET(BIT(1), readl(drvdata->base + dcc_status(drvdata->mem_map_ver))))
>>>>>> +		buf = "Y\n";
>>>>>> +	else
>>>>>> +		buf = "N\n";
>>>>>> +out_unlock:
>>>>>> +	mutex_unlock(&drvdata->mutex);
>>>>>> +
>>>>>> +	if (ret < 0)
>>>>>> +		return -EINVAL;
>>>>>> +	else
>>>>>
>>>>> You do the "lock, get a value, unlock, do something with the value"
>>>>> thing a bunch, but what prevents the value from changing after the lock
>>>>> happens?  So why is the lock needed at all?
>>>>
>>>> The lock is used to prevent concurrent accesses of the drv_data when
>>>> scripts are being run from userspace.
>>>
>>> How would that matter?  The state can change instantly after the lock is
>>> given up, and then the returned value is now incorrect.  So no need for
>>> a lock at all as you really aren't "protecting" anything, or am I
>>> missing something else?
>>
>> This lock is needed to protect the access to the global instance of drv_data
>> structure instantiated at probe time within each individual callbacks of
>> debugfs.
> 
> What exactly are you "protecting" here that could change in a way that
> cause a problem?
> 
> You aren't returning a value that is ever guaranteed to be "correct"
> except that it happened sometime in the past, it might be right anymore.

Hi Greg,

The lock doesn't add any value in this particular case and I will be 
dropping it from here but in other cases it is being used to protect the 
concurrent access of the data-structures used inside the drv_data mainly 
the list which is being used to append register configurations, write 
the configuration to the dcc_sram and also delete it while doing a 
config reset. The lock is also used in case of software trigger to read 
the bitmap of the lists to set register values.

Thanks,
Souradeep

> 
> thanks,
> 
> greg k-h
