Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DFB5EA6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiIZNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiIZNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:08:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5874446216
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:38:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QB0gkV029830;
        Mon, 26 Sep 2022 11:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Vzm6YsMtxmkkPWLp1OI8TtX0+HUhG4sy/W+ukkWTMuc=;
 b=gVeyo81UZK3eI5LDEF//pv/JvjpOmtfFm0i8QUylJ9sPIbwS8AErJwadcV5NnoClNDU+
 wyx17TiaTMnLPUEfmkcpb5PW/gUwAWtiWLbwTGiIEMyqDz0WFUA3hIkgAAUrtmYY5Y1c
 UeR3kNyxM6hCB3yDvZAv1NdaSZ8KG9UjmUBLU4NGxzF0mhlZ5wAYU99jPNgwZnsQBETG
 NGqgrGDl2fN/XTL5RXpcRc9GNFTRLBlFUs4mVqh9PdcwmaFsCbQ/zskfY9BebZTNF+3r
 X1lWflbs/dhQ7vkY6MZ0eFof9J80DEDyAcKhLVKgRPlPTnCH/c21/T/ALea9T6iMuTYQ CA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsrwfkbap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:08:13 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28QB8CkV019886;
        Mon, 26 Sep 2022 11:08:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jstyke1p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:08:12 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28QB8BLd019880;
        Mon, 26 Sep 2022 11:08:11 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 28QB8Bcv019879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 11:08:11 +0000
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:08:10 -0700
Message-ID: <281ca744-c7fb-6fdb-9348-a0c0d957710b@quicinc.com>
Date:   Mon, 26 Sep 2022 19:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
From:   Kassey Li <quic_yingangl@quicinc.com>
Subject: Re: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <tj@kernel.org>,
        <william.kucharski@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20220923075105.28251-1-quic_yingangl@quicinc.com>
 <20220923110044.7261afa0@gandalf.local.home>
 <fee4b5ec-0e0d-8158-7e60-90f0918cab51@quicinc.com>
 <20220925224204.4e5d341e@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20220925224204.4e5d341e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tNXayVKaJptsfA7JTC-TTLRi0pKMZpLh
X-Proofpoint-GUID: tNXayVKaJptsfA7JTC-TTLRi0pKMZpLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260071
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2022 10:42 AM, Steven Rostedt wrote:
> On Mon, 26 Sep 2022 10:18:55 +0800
> Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>>>> @@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>>>>    		__entry->dst_level = dst_cgrp->level;
>>>>    		__assign_str(dst_path, path);
>>>>    		__entry->pid = task->pid;
>>>> -		__assign_str(comm, task->comm);
>>>> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
>> 	I think the problem is here, __assign_str using strcpy
>> 	the task->comm here tail is not '\0'
>> 	that's why it out of bounds access.
>>
> 
> If this is the case, then there's a lot more than just tracing that will
> break. There are other places in the kernel has used strcpy() on task->comm,
> and many more that do "%s" on task->comm, which would also crash on this.

You are right.

by re-check my local logs(arm64), we can see the src has '\0' as end of 
string.
but looks strcpy did not catch this and crossed.
I can not figure out how this could happen. if there is debug suggest, 
please help.


src: task->comm   SharedPreferenc   pid  28395
_____________________address|________0________4________8________C_0123456789ABCDEF
   NSD:0000::FFFFFFBD1B6C59D0|>72616853 72506465 72656665 00636E65 
SharedPreferenc.


dst: trace event buffer:
_____________________address|________0________4________8________C_0123456789ABCDEF
   NSD:0000::FFFFFFBCF744FFE0| 00090020 000B0029 706F742F 7070612D 
...).../top-app
   NSD:0000::FFFFFFBCF744FFF0| 61685300 50646572 65666572 636E6572 
.SharedPreferenc
   NSD:0000::FFFFFFBCF7450000|>52800101 97FD3A05 140000B3 AA1303E0 
...R.:..........

layout of the struct:

   [ND:0x0::0xFFFFFFBCF744FFC8] (struct 
trace_event_raw_cgroup_migrate)0xFFFFFFBCF744FFc8 = (
     [ND:0x0::0xFFFFFFBCF744FFC8] ent = (
       [ND:0x0::0xFFFFFFBCF744FFC8] type = 0x98,
       [ND:0x0::0xFFFFFFBCF744FFCA] flags = 0x1,
       [ND:0x0::0xFFFFFFBCF744FFCB] preempt_count = 0x1,
       [ND:0x0::0xFFFFFFBCF744FFCC] pid = 0x0773),
     [ND:0x0::0xFFFFFFBCF744FFD0] dst_root = 0x1,
     [ND:0x0::0xFFFFFFBCF744FFD4] dst_id = 0x6,
     [ND:0x0::0xFFFFFFBCF744FFD8] dst_level = 0x1,
     [ND:0x0::0xFFFFFFBCF744FFDC] pid = 28395 = 0x6EEB,
     [ND:0x0::0xFFFFFFBCF744FFE0] __data_loc_dst_path = 0x00090020 = '... ',
     [ND:0x0::0xFFFFFFBCF744FFE4] __data_loc_comm = 0x000B0029 = '...)',
     [ND:0x0::0xFFFFFFBCF744FFE8] __data_=_"/top-app")

name: cgroup_attach_task
ID: 152
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int dst_root;	offset:8;	size:4;	signed:1;
	field:int dst_id;	offset:12;	size:4;	signed:1;
	field:int dst_level;	offset:16;	size:4;	signed:1;
	field:int pid;	offset:20;	size:4;	signed:1;
	field:__data_loc char[] dst_path;	offset:24;	size:4;	signed:0;
	field:__data_loc char[] comm;	offset:28;	size:4;	signed:0;


_____________________address|________0________4________8________C_0123456789ABCDEF
   NSD:0000::FFFFFFBCF744FFC0| 00656C64 0066D18D>01010098 00000773 
dle...f.....s...
   NSD:0000::FFFFFFBCF744FFD0| 00000001 00000006 00000001 00006EEB 
.............n..
   NSD:0000::FFFFFFBCF744FFE0| 00090020 000B0029 706F742F 7070612D 
...).../top-app
   NSD:0000::FFFFFFBCF744FFF0| 61685300 50646572 65666572 636E6572 
.SharedPreferenc
   NSD:0000::FFFFFFBCF7450000| 52800101 97FD3A05 140000B3 AA1303E0 
...R.:..........

> 
>> 	do you want to this version or just modify the memcpy or strncpy to do
>> with a known length ?  please give suggest so I can modify .
> 
> I'm guessing a problem exists elsewhere that makes it look like this is the
> issue. I suggest finding where the '\0' is dropped (if that is indeed the
> case).
> 
> -- Steve
