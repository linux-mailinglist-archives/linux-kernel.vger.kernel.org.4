Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56736A9BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCCQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCCQeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:34:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CBE168A3;
        Fri,  3 Mar 2023 08:34:16 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3236OcYd002307;
        Fri, 3 Mar 2023 16:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FdZ1DugPMawjEuylcZGbGq27FxVFM5zZadNSsKkc4cY=;
 b=VkQyhgixJuHtYiCBbOL8VrPEODig0uejA1q1w6T96s1wRWZ5PTocUrp4ZDtJYO7HEwBa
 S1q5HgIPoxOQ55RM5nV6TgBwodvpVxCdt5buToP+/RkPA5J22GRGNn8Mr8ngnyGV7V7L
 17jtMfOMQXLYcps5pcY8yLtClHDMeTDwBM1YiFbUPeu/s/28WW4ViTeOMINxEHsno/NG
 m88U45irODV7kacdJMW0kG2iajWeeSLYXQ9yOG2V06fuoS2nt60hbfxNNigL2Qjg4xpX
 yPS9udv3EGfucUTHIkiKFutZmnjkpnWUL8n2lU7Xl9pk51tuxw8aTR2ZENwVXcrTM70b sQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p32ty3091-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 16:34:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323GY7gL029694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 16:34:07 GMT
Received: from [10.216.34.86] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 08:34:05 -0800
Message-ID: <c63f96bb-2972-b96e-5105-d47c89f8571e@quicinc.com>
Date:   Fri, 3 Mar 2023 22:04:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/3] ring_buffer: Change some static functions to bool
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20230303151706.57851-1-ubizjak@gmail.com>
 <20230303151706.57851-3-ubizjak@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230303151706.57851-3-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0kHCHkvV0UtUrh0tHyiPXkLmgm4IVN_2
X-Proofpoint-ORIG-GUID: 0kHCHkvV0UtUrh0tHyiPXkLmgm4IVN_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=642
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030142
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2023 8:47 PM, Uros Bizjak wrote:
> The return values of some functions are of boolean type. Change the
> type of these function to bool and adjust their return values. Also
> change type of some internal varibles to bool.
> 
> No functional change intended.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
> v3: Rearrange variable declarations.
> ---
>   kernel/trace/ring_buffer.c | 47 ++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 05fdc92554df..71df857242b4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -163,7 +163,7 @@ enum {
>   #define extended_time(event) \
>   	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
>   
> -static inline int rb_null_event(struct ring_buffer_event *event)
> +static inline bool rb_null_event(struct ring_buffer_event *event)
>   {
>   	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
>   }
> @@ -367,11 +367,9 @@ static void free_buffer_page(struct buffer_page *bpage)
>   /*
>    * We need to fit the time_stamp delta into 27 bits.
>    */
> -static inline int test_time_stamp(u64 delta)
> +static inline bool test_time_stamp(u64 delta)
>   {
> -	if (delta & TS_DELTA_TEST)
> -		return 1;
> -	return 0;
> +	return !!(delta & TS_DELTA_TEST);
>   }
>   
>   #define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
> @@ -700,7 +698,7 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
>   	return ret == expect;
>   }
>   
> -static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> +static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>   {
>   	unsigned long cnt, top, bottom, msb;
>   	unsigned long cnt2, top2, bottom2, msb2;
> @@ -1490,7 +1488,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
>   	return NULL;
>   }
>   
> -static int rb_head_page_replace(struct buffer_page *old,
> +static bool rb_head_page_replace(struct buffer_page *old,
>   				struct buffer_page *new)

nit: did you miss ret in rb_get_reader_page()?

>   {
>   	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
> @@ -1917,7 +1915,7 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
>   	return local_read(&bpage->write) & RB_WRITE_MASK;
>   }
>   
> -static int
> +static bool
>   rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>   {
>   	struct list_head *tail_page, *to_remove, *next_page;
> @@ -2030,12 +2028,13 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>   	return nr_removed == 0;
>   }
>   
> -static int
> +static bool
>   rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   {
>   	struct list_head *pages = &cpu_buffer->new_pages;
> -	int retries, success;
>   	unsigned long flags;
> +	bool success;
> +	int retries;
>   
>   	/* Can be called at early boot up, where interrupts must not been enabled */
>   	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> @@ -2054,7 +2053,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   	 * spinning.
>   	 */
>   	retries = 10;
> -	success = 0;
> +	success = false;
>   	while (retries--) {
>   		struct list_head *head_page, *prev_page, *r;
>   		struct list_head *last_page, *first_page;
> @@ -2083,7 +2082,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   			 * pointer to point to end of list
>   			 */
>   			head_page->prev = last_page;
> -			success = 1;
> +			success = true;
>   			break;
>   		}
>   	}
> @@ -2111,7 +2110,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   
>   static void rb_update_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   {
> -	int success;
> +	bool success;
>   
>   	if (cpu_buffer->nr_pages_to_update > 0)
>   		success = rb_insert_pages(cpu_buffer);
> @@ -2994,7 +2993,7 @@ static u64 rb_time_delta(struct ring_buffer_event *event)
>   	}
>   }
>   
> -static inline int
> +static inline bool
>   rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>   		  struct ring_buffer_event *event)
>   {
> @@ -3015,7 +3014,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>   	delta = rb_time_delta(event);
>   
>   	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
> -		return 0;
> +		return false;
>   
>   	/* Make sure the write stamp is read before testing the location */
>   	barrier();
> @@ -3028,7 +3027,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>   		/* Something came in, can't discard */
>   		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
>   				       write_stamp, write_stamp - delta))
> -			return 0;
> +			return false;
>   
>   		/*
>   		 * It's possible that the event time delta is zero
> @@ -3061,12 +3060,12 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>   		if (index == old_index) {
>   			/* update counters */
>   			local_sub(event_length, &cpu_buffer->entries_bytes);
> -			return 1;
> +			return true;
>   		}
>   	}
>   
>   	/* could not discard */
> -	return 0;
> +	return false;
>   }
>   
>   static void rb_start_commit(struct ring_buffer_per_cpu *cpu_buffer)
> @@ -3281,7 +3280,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
>    * Note: The TRANSITION bit only handles a single transition between context.
>    */
>   
> -static __always_inline int
> +static __always_inline bool
>   trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
>   {
>   	unsigned int val = cpu_buffer->current_context;
> @@ -3298,14 +3297,14 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
>   		bit = RB_CTX_TRANSITION;
>   		if (val & (1 << (bit + cpu_buffer->nest))) {
>   			do_ring_buffer_record_recursion();
> -			return 1;
> +			return true;
>   		}
>   	}
>   
>   	val |= (1 << (bit + cpu_buffer->nest));
>   	cpu_buffer->current_context = val;
>   
> -	return 0;
> +	return false;
>   }
>   
>   static __always_inline void
> @@ -5408,9 +5407,8 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
>   {
>   	struct ring_buffer_per_cpu *cpu_buffer;
>   	unsigned long flags;
> -	bool dolock;
> +	bool dolock, ret;
>   	int cpu;
> -	int ret;

nit: would have been nice if you would not have changed existing stuff 
i.e each variable on a separate line.

>   
>   	/* yes this is racy, but if you don't like the race, lock the buffer */
>   	for_each_buffer_cpu(buffer, cpu) {
> @@ -5438,8 +5436,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
>   {
>   	struct ring_buffer_per_cpu *cpu_buffer;
>   	unsigned long flags;
> -	bool dolock;
> -	int ret;
> +	bool dolock, ret;

same here

>   
>   	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>   		return true;


Feel free to add

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
