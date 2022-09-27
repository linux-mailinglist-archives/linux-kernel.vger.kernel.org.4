Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88875EB75A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiI0CFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiI0CFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:05:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377436DF0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:05:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R1rR6M002045;
        Tue, 27 Sep 2022 02:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mteTxWy2DX4fGvrPRRg76+sWQTfaA0qxlYjysZsF9WE=;
 b=HWm3zT6/eVCaozc9fj+5nOMmePyvjtEc0vsbWvakLrvKZ8wA3Feu1xiJVw7EI1yJq/jw
 K+U0W2Rmbhba9ujoX3yFYENrU4x1bFsKZTxZGybOq53sYuVHUTdyvxLQ+Xfam5zXz/Gp
 jbDUcXj/NIMJ56jnhKldnv2ZPhweso2K5BfYVBlG28igMcQaD9FF4IvmrgVnhRmo2zjY
 phQ5CUFEQq3mHujXgJonDJ5OssgGbBdi2nMNYe1l3lZJXSttMrk62lozMW5nlxH9Kpr0
 MqQHDORqyQ5NLwI2yfjx+81b6eRd2BNaK8ZEsNyvYWY1jdzfOkx2CiUVk9C9M7Q5ClPZ gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jua2ut92p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 02:04:42 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28R24fLj030200;
        Tue, 27 Sep 2022 02:04:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3jstykghst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 02:04:41 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28R24fFO030192;
        Tue, 27 Sep 2022 02:04:41 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 28R24fEV030191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 02:04:41 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 19:04:39 -0700
Message-ID: <b1dd577d-b153-0cfd-6ab6-e7c973c0955e@quicinc.com>
Date:   Tue, 27 Sep 2022 10:04:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] kernel/hung_task: add option to ignore task
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <quic_namajain@quicinc.com>
References: <20220923085335.19593-1-quic_yingangl@quicinc.com>
 <Yy2S16jOPVzDZSBe@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <Yy2S16jOPVzDZSBe@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fodyxmSy_67XO7uIf8-Y6zhRQfPw7PFe
X-Proofpoint-ORIG-GUID: fodyxmSy_67XO7uIf8-Y6zhRQfPw7PFe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=845 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270011
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2022 7:04 PM, Peter Zijlstra wrote:
> On Fri, Sep 23, 2022 at 04:53:35PM +0800, Kassey Li wrote:
>> By default, hung_task will iterate the tasklist and check
>> state in TASK_UNINTERRUPTIBLE with a given timeout value.
>>
>> Some tasks may in this state as expected but reported by hung_task.
> 
> Please explain..
I want to set timout value as 60s, 20s, 10s,  or even 5s to more 
aggressive to detect my VIP tasks "init", "surfaceflinger", 
"system_server" for example as debug.

many other tasks wait for IO, mutex, delayed timer ...
will hit this while we want to ignore.






