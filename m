Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D676BE124
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCQGTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQGTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:19:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDDABAD9;
        Thu, 16 Mar 2023 23:19:48 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H0u0K5027439;
        Fri, 17 Mar 2023 06:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pA1tMapjhLc8luf/elXgKP2JckGZ8Ljg8ZpDb2dHeZA=;
 b=NQMLEQ8lOSe3DMD3vgOpurhWodYUJ99DpHOCdFNlXeTtdi4rY+XAphhTxvRrmkhkrJCI
 7O10w7dTLyhJvB6sbpF4bOkm5ExaMWsJTaJ87z5DFbnLjhczqCe8AEJdeIsuKbzR10A8
 RO0Zb7mK8jwXuYRZgGwkiOdFKp4aqyuP6aahvxnlzf7xiykY+F5A/7xv1bPfJ/5Or1+r
 50pxFMe2E2MkwrFltdKSp12HN8o6G6Ou2Sl9muLmMmMhjuthUV44GTlBPLbPyRhcXvcU
 kk1i91tadIQ+5rpypwOqSdHGhrEsWabD5e9OXo7JGWSOCNyvhdsQ5Ym9EIxp/Xx6o62T FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc3ypac3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:18:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32H6IfEq022928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:18:41 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Mar
 2023 23:18:38 -0700
Message-ID: <6320e079-4fc8-f435-52e5-6d5ad1369d84@quicinc.com>
Date:   Fri, 17 Mar 2023 14:18:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and
 sinks
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
To:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
 <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
 <CAJ9a7ViA5BsbLjRWMsttmpmcPh1yUXK8J79k-pqYybVZkMQHXQ@mail.gmail.com>
 <bb6c9df9-af9b-873e-85bd-a29d00bb39d7@arm.com>
 <1d9b8ee8-c3f2-99bc-cd4e-8c2dd0f04b2b@quicinc.com>
 <CAJ9a7Vh08A8b7YLF=pYPudB0CZ0XjEpF=4YHrNNd7xo_JQGYaA@mail.gmail.com>
 <0308d380-bc8b-cb66-55cd-b0934d8f9676@quicinc.com>
In-Reply-To: <0308d380-bc8b-cb66-55cd-b0934d8f9676@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rx5DTVCL2LmxNOfCHw9vifF3JL8mKbf7
X-Proofpoint-ORIG-GUID: Rx5DTVCL2LmxNOfCHw9vifF3JL8mKbf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303170041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/2023 11:04 PM, Jinlong Mao wrote:
> Hi Mike & Suzuki,
>
> On 2/9/2023 10:56 PM, Mike Leach wrote:
>> Hi,
>>
>> On Thu, 9 Feb 2023 at 03:02, Jinlong Mao <quic_jinlmao@quicinc.com> 
>> wrote:
>>>
>>> On 2/9/2023 12:36 AM, Suzuki K Poulose wrote:
>>>> On 08/02/2023 16:20, Mike Leach wrote:
>>>>> Quick correction - you need to look for enable_source  / enable_sink
>>>>> files and disable those that are currently '1'
>>>>>
>>>>> Mike
>>>>>
>>>>> On Wed, 8 Feb 2023 at 16:16, Mike Leach <mike.leach@linaro.org> 
>>>>> wrote:
>>>>>> Hi
>>>>>>
>>>>>> As this is a sysfs only update - would it not be easier to simply 
>>>>>> use
>>>>>> a shell script to iterate through coresight/devices/ looking for
>>>>>> disable_source / disable_sink files and setting those accordingly?
>>>>>>
>>>>>> See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
>>>>>> script that does similar iteration to test coresight in perf
>>>>>>
>>>> +1
>>>>
>>>> Suzuki
>>> Hi Mike & Suzuki,
>>>
>>> Sometimes user just want to have some quick test from PC with adb 
>>> commands.
>>> It is very easy to reset all sources and sinks' status by command 
>>> below.
>>> echo 1 > /sys/bus/coresight/reset_source_sink
>>>
>> Users of coresight via sysfs will have to know how to use the
>> coresight infrastructure in order to enable the sources and sinks in
>> the first place -
>> e.g
>> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
>> echo 1 > /sys/bus/coresight/devices/etm0/enable_source
>>
>> Given that they are aware of which sources and sinks they enabled -
>> disabling them should be simple.
>>
>>
>>> Preparing the script for test is not easy for users who are not 
>>> familiar
>>> with the coresight framework.
>>>
>> If there is a genuine use case were a user has opened so many sources
>> on the command line that they need a simpler way of closing them than
>> repeating the enabled commands with an
>> echo 0 > ...
>> then any script could be shipped as part of kernel/tools/coresight or
>> kernel/samples/coresight - they would not have to write it themselves,
>> and just run it from the command line - for example :-
>> ./kernel/tools/coresight/scripts/sysfs_disable_sources_and_sinks.sh
>>
>> Realistically users will only try out a couple of devices as the
>> usefulness of the sysfs interface is really limited to testing or
>> board bring up.
>> Any complex use with sysfs - as in the coresight tests I mentioned
>> earlier is really going to be done by scripting.
>>
>>
>> Regards
>>
>> Mike
>
> There is also requirement that reset all the sources and sinks in an 
> user space daemon.
> For such requirement, I think it is better to use only once sysfs node 
> instead of iterating through coresight/device folder in an user space 
> daemon.

Hi Mike & Suzuki,

In our internal build, there is binary executable which can configure 
coresight source/sink.
Before running the case, it will disable all the sources and sinks by 
writing reset_source_sink node to
avoid any other source packet's impact.


Thanks
Jinlong Mao

>
> Thanks
> Jinlong Mao
>
>>> Thanks
>>> Jinlong Mao
>>>
>>>>
>>
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
