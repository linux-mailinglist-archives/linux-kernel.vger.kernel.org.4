Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD15EC7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiI0PbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiI0PbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:31:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF91BBEC1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:31:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RF7bKT005442;
        Tue, 27 Sep 2022 15:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pteMmzmFE/0rlHtcgr3tgcSqCyUL+eWf8CyEh/Zv6Ac=;
 b=c4HYvdkfEONe9tlUf5StGz/pZSSpy+uBysXwEGVeW72NsmoYR21Bs18tSpgqk3Yl27xL
 lz4j68e+sHAK7LTMWpW3hmbMniCNuraZ3TRUT382j84zmcGpp0WjICBSaoKelHlKBcZN
 Bh+dmXI/m8XLBpGBnOcKA+IQnhLYKsYbK4Ie+cOhue9jAjUnzzWkLZe+cVLxCb6GvnTh
 cpOfZKyDetqdqlxxXqfShYwAX7RytpmBzXHuBseY6CAXhslPRJ57NITkVuHcFrsQmDJj
 k7cIEvlO5bPAlbhabFKoWwU7UH91/ayM/foN/s+vuZ/jfMA9DSlN7KYhbHDRAwtYRCJB lw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juwru1h6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 15:30:55 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28RFUsPa026051;
        Tue, 27 Sep 2022 15:30:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jv2t08r56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 15:30:54 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28RFUsOE026045;
        Tue, 27 Sep 2022 15:30:54 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 28RFUsnF026044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 15:30:54 +0000
Received: from [10.216.13.72] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 08:30:51 -0700
Message-ID: <9ae90959-4d7c-bc3c-4710-5867a0cd4573@quicinc.com>
Date:   Tue, 27 Sep 2022 21:00:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: locking/rwsem: RT throttling issue due to RT task hogging the cpu
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <"<boqun.feng"@gmail.com>
References: <e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com>
 <40d0decc-0565-1e13-3c12-ac963ebed429@redhat.com>
 <be87a130-62ba-e0a7-1c5b-c48f1e5548e1@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <be87a130-62ba-e0a7-1c5b-c48f1e5548e1@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bcAgR1Nbe2tWAqo4d4WwBrncP_6gHSUw
X-Proofpoint-ORIG-GUID: bcAgR1Nbe2tWAqo4d4WwBrncP_6gHSUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_06,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxlogscore=914 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270095
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Thanks for the reply.

On 9/27/2022 8:56 PM, Waiman Long wrote:
> On 9/27/22 11:25, Waiman Long wrote:
>>
>> On 9/20/22 12:19, Mukesh Ojha wrote:
>>> Hi,
>>>
>>> We are observing one issue where, sem->owner is not set and 
>>> sem->count=6 [1] which means both RWSEM_FLAG_WAITERS and 
>>> RWSEM_FLAG_HANDOFF bits are set. And if unfold the sem->wait_list we 
>>> see the following order of process waiting [2] where [a] is waiting 
>>> for write, while [b],[c] are waiting for read and [d] is the RT task 
>>> for which waiter.handoff_set=true and it is continuously running on 
>>> cpu7 and not letting the first write waiter [a] on cpu7.
>>>
>>> [1]
>>>
>>>   sem = 0xFFFFFFD57DDC6680 -> (
>>>     count = (counter = 6),
>>>     owner = (counter = 0),
>>>
>>> [2]
>>>
>>> [a] kworker/7:0 pid: 32516 ==> [b] iptables-restor pid: 18625 ==> 
>>> [c]HwBinder:1544_3  pid: 2024 ==> [d] RenderEngine pid: 2032 cpu: 7 
>>> prio:97 (RT task)
>>>
>>>
>>> Sometime back, Waiman has suggested this which could help in RT task
>>> leaving the cpu.
>>>
>>> https://lore.kernel.org/all/8c33f989-8870-08c6-db12-521de634b34e@redhat.com/ 
>>>
>>>
>> Sorry for the late reply. There is now an alternative way of dealing 
>> with this RT task hogging issue with the commit 48dfb5d2560d 
>> ("locking/rwsem: Disable preemption while trying for rwsem lock"). 
>> Could you try it to see if it can address your problem?
> 
> FYI, this commit is in the tip tree. It is not in the mainline yet.


I only posted that patch so, i am aware about it. In that issue 
sem->count was 7 and here it is 6 and current issue occurs after fix
48dfb5d2560d ("locking/rwsem: Disable preemption while trying for rwsem 
lock").

-Mukesh

> 
> Cheers,
> Longman
> 
