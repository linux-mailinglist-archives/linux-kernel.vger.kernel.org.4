Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324ED68FDB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBIDHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjBIDHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:07:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE5BB97;
        Wed,  8 Feb 2023 19:03:09 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3190MR2P016602;
        Thu, 9 Feb 2023 03:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bUW7dhTOA4J7ntYe0YElJ8u8CDEjugABASBb2PexONc=;
 b=NrpKqlh67jBu/PMYyKcqKYsluGgVLFl7gJ6vST6PdDxJQZBao4LOzKJf2/ZEbRVIMpty
 V1IOAG/ZCc3l3RAnqfKNGPDYJrJo1Mq8hTMWW9c4qeOBbvnVDZTOYXqKiIBuBE3ofRLZ
 EuLsnwUvdAuLhNAMif1q3HXQYUvf/RMYuVGVHiTHOeHTWOvdXvBRXKvOFf7vbor2rIdU
 WQfyNm7YeqtHXz5DREHwcp4PLvEkQ5Kcj33oZer7qaXQFpstjtR8ElnXa+xboqoueGpU
 pu672HmVjf7a5GuIJ4kpm1Zs6VVdenlSUblmnalQ9HtF4/W0gTB9cytDT7avXhrGJcqc Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf3bja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 03:02:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31932hU7013049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 03:02:43 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 19:02:39 -0800
Message-ID: <1d9b8ee8-c3f2-99bc-cd4e-8c2dd0f04b2b@quicinc.com>
Date:   Thu, 9 Feb 2023 11:02:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and
 sinks
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
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
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <bb6c9df9-af9b-873e-85bd-a29d00bb39d7@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BIraKdY_9K6WNvdrRoA0NvCHhEwZIwQ1
X-Proofpoint-GUID: BIraKdY_9K6WNvdrRoA0NvCHhEwZIwQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=893 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090026
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/2023 12:36 AM, Suzuki K Poulose wrote:
> On 08/02/2023 16:20, Mike Leach wrote:
>> Quick correction - you need to look for enable_source  / enable_sink
>> files and disable those that are currently '1'
>>
>> Mike
>>
>> On Wed, 8 Feb 2023 at 16:16, Mike Leach <mike.leach@linaro.org> wrote:
>>>
>>> Hi
>>>
>>> As this is a sysfs only update - would it not be easier to simply use
>>> a shell script to iterate through coresight/devices/ looking for
>>> disable_source / disable_sink files and setting those accordingly?
>>>
>>> See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
>>> script that does similar iteration to test coresight in perf
>>>
>
> +1
>
> Suzuki

Hi Mike & Suzuki,

Sometimes user just want to have some quick test from PC with adb commands.
It is very easy to reset all sources and sinks' status by command below.
echo 1 > /sys/bus/coresight/reset_source_sink

Preparing the script for test is not easy for users who are not familiar 
with the coresight framework.

Thanks
Jinlong Mao

>
>
