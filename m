Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0321C6ABF76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCFM2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCFM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:28:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531A1FE8;
        Mon,  6 Mar 2023 04:28:40 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326AsWi1005673;
        Mon, 6 Mar 2023 12:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=w+dretXfOL6v87H797k8h5OZjEv4f65zOOku+HkGzD4=;
 b=dCNCFY7qBVhb1fdK95aY5QQ6B6ou2WZDUnWsMM4wFoExA2w9TnzNDBigbvhBifcTFHcF
 U+6acpbbBSwn7fkq7tAIBrVzlixidmMCzJ21UFG1qdS3Mav+Bwb+ldjSXHRVoyaDndVh
 bDsv+sI7A9t9zBRDwjHwh/35K69cOdkCqh54Y3yMV4K10W/H1ejvbi7CRUw3AhD5VSo2
 jOet5fuVpCz5yEw1uYWjMIOdVLFoiJ96hbtb3SviAoFpE5mMHCOUitzaYP17/pL7HprA
 f4V4RU/G3lY9J5CeCmiXAMZnkmBWcvObImXaGyfHVAXaFvn9JROFq0z9ia8X1KFDaBwC jw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p415hvpxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 12:28:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326CSa60001631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 12:28:36 GMT
Received: from [10.204.79.110] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 04:28:34 -0800
Message-ID: <45cac39e-3b9e-f5f6-a534-421574953856@quicinc.com>
Date:   Mon, 6 Mar 2023 17:58:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230305155532.5549-1-ubizjak@gmail.com>
 <20230305155532.5549-4-ubizjak@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230305155532.5549-4-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 83V-C1bxbJ1apAziIk8IBByXh1-p8rnm
X-Proofpoint-GUID: 83V-C1bxbJ1apAziIk8IBByXh1-p8rnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=512 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2023 9:25 PM, Uros Bizjak wrote:
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old.
> x86 CMPXCHG instruction returns success in ZF flag, so this change
> saves a compare after cmpxchg (and related move instruction in
> front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
> 
> No functional change intended.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
> v2: Convert only loops with cmpxchg.
> ---
>   kernel/trace/ring_buffer.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5235037f83d3..d17345b522f4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4061,10 +4061,10 @@ void ring_buffer_record_off(struct trace_buffer *buffer)
>   	unsigned int rd;
>   	unsigned int new_rd;
>   
> +	rd = atomic_read(&buffer->record_disabled);
>   	do {
> -		rd = atomic_read(&buffer->record_disabled);
>   		new_rd = rd | RB_BUFFER_OFF;
> -	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
> +	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
>   }
>   EXPORT_SYMBOL_GPL(ring_buffer_record_off);
>   
> @@ -4084,10 +4084,10 @@ void ring_buffer_record_on(struct trace_buffer *buffer)
>   	unsigned int rd;
>   	unsigned int new_rd;
>   
> +	rd = atomic_read(&buffer->record_disabled);
>   	do {
> -		rd = atomic_read(&buffer->record_disabled);
>   		new_rd = rd & ~RB_BUFFER_OFF;
> -	} while (atomic_cmpxchg(&buffer->record_disabled, rd, new_rd) != rd);
> +	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
>   }

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   EXPORT_SYMBOL_GPL(ring_buffer_record_on);
>   
