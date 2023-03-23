Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B96C69D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCWNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:46:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88129434;
        Thu, 23 Mar 2023 06:46:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5PZfu015007;
        Thu, 23 Mar 2023 13:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FCwECpzcs4+z7hcnDhIUEvcrZSBgkmZcvMPBBSqHErE=;
 b=Zl2/bTR1xYxtKOSNXJWqbgvcfWexsTS2oiv8yp3cvbNPUhRxt6ENPn3Gh6Y6Rz/6mD9g
 bWOk8/62enFJyNRGrs7ziLqjB+PuPyyfhJN78SaoZYBdXzdUxKWrj9UkhKVw0GkorAHR
 PGXIwTYc5V+2V5myC++9RJIbw4DCgusoPrSd+4jyVwyeh2EFY3MhV/kQh3fd/0+l+i8d
 mTEaBfC2Uk8KeXmHLfIygwIJ7FRfKAg7ytycBtrJyxpsBGGkRwaIyrOgJU3ELe4XBdRE
 f8TcQshmsPWeM8VNtera0Mb7RxfKyzav64o/XbEvUv4XG/KamvwHjz7j+iMl5XcMyhrY bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgfaxh95q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:46:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NDkBDx023291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:46:11 GMT
Received: from [10.50.6.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 06:46:07 -0700
Message-ID: <5c4df95e-fb44-e873-7ecc-dec381a42aff@quicinc.com>
Date:   Thu, 23 Mar 2023 19:15:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 3/4] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <3f385562845ae26d519940ca8098fde89282991b.1679403696.git.quic_schowdhu@quicinc.com>
 <611ea918-64a6-f306-b5ec-db55e41abda2@linaro.org>
 <321005fc-1bfd-c04d-b2b5-d85d213ac00a@quicinc.com>
 <7b939818-993a-e849-e7e0-ae9ea74ea52b@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <7b939818-993a-e849-e7e0-ae9ea74ea52b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wnycLj2yT3c1tYU-uLHTy010Ws25XIUI
X-Proofpoint-ORIG-GUID: wnycLj2yT3c1tYU-uLHTy010Ws25XIUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230104
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 8:23 PM, Krzysztof Kozlowski wrote:
> On 22/03/2023 14:54, Souradeep Chowdhury wrote:
>>
>>
>> On 3/21/2023 11:07 PM, Krzysztof Kozlowski wrote:
>>> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>>> stats, like the time when the bootloader started execution and at what
>>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>>> region. This information is captured in a specific format by this driver
>>>> by mapping a structure to the IMEM memory region and then accessing the
>>>> members of the structure to print the information. This information is
>>>> useful in verifying if the existing boot KPIs have regre
>>>
>>>
>>>> +/**
>>>> + *  struct boot_stats - timestamp information related to boot stats
>>>> + *  @bootloader_start:	Time for the starting point of the abl bootloader
>>>> + *  @bootloader_end:	Time when the kernel starts loading from abl bootloader
>>>> + */
>>>> +struct boot_stats {
>>>> +	u32 bootloader_start;
>>>> +	u32 bootloader_end;
>>>> +} __packed;
>>>> +
>>>> +static struct boot_stats __iomem *boot_stats;
>>>> +static void __iomem *mpm_counter_base;
>>>> +static u32 mpm_counter_freq;
>>>
>>> No file-scope variables. Does not scale, not easy for review and
>>> maintenance. Avoid such code.
>>
>> Ack
>>>
>>>> +
>>>> +static int mpm_parse_dt(void)
>>>> +{
>>>> +	struct device_node *np_imem, *np_mpm2;
>>>> +
>>>> +	np_imem = of_find_compatible_node(NULL, NULL,
>>>> +					  "qcom,imem-boot_stats");
>>>> +	if (!np_imem) {
>>>> +		pr_err("can't find qcom,imem node\n");
>>>
>>> So you are printing errors everywhere, on every soc and with compile
>>> test on every platform there is in the world... sorry, it does not work
>>> like that.
>>
>> Ack
>>>
>>>> +		return -ENODEV;
>>>> +	}
>>>> +	boot_stats = of_iomap(np_imem, 0);
>>>> +	if (!boot_stats) {
>>>> +		pr_err("boot_stats: Can't map imem\n");
>>>> +		goto err1;
>>>> +	}
>>>
>>>
>>>> +
>>>> +static void __exit boot_stats_exit(void)
>>>> +{
>>>> +}
>>>> +module_exit(boot_stats_exit)
>>>
>>>
>>> I don't think this is some special code which deserves init calls. Make
>>> it module_platform_driver().
>>
>> Since this just reads some values from the Imem region and prints it to
>> the user and doesn't have a specific device associated with it, a
> 
> Which is not really an argument for such antipattern, but okay...
> 
>> generic module code is written for it and not a module_platform_driver().
> 
> ... so how do you handle deferred probe?

This has no dependency on other resources except that it parses some 
information from DT nodes, so deferred probe handling is not needed
in this case.

> 
> Best regards,
> Krzysztof
> 
