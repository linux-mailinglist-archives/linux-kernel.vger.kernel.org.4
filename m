Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90E649815
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiLLC5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLLC5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:57:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C266335
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:57:11 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NVmV85YHJzJqTF;
        Mon, 12 Dec 2022 10:56:16 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:57:08 +0800
Subject: Re: [PATCH v4] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221129113009.182425-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <46733774-295a-ade9-497d-6e73c6c468de@huawei.com>
Date:   Mon, 12 Dec 2022 10:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221129113009.182425-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

PING.

Are there any other problems with this patch?

Thanks,
Yang.

On 2022/11/29 19:30, Yang Jihong wrote:
> print_trace_line may overflow seq_file buffer. If the event is not
> consumed, the while loop keeps peeking this event, causing a infinite loop.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>   kernel/trace/trace.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a7fe0e115272..de7c99f4b539 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6787,7 +6787,20 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>   
>   		ret = print_trace_line(iter);
>   		if (ret == TRACE_TYPE_PARTIAL_LINE) {
> -			/* don't print partial lines */
> +			/*
> +			 * If one print_trace_line() fills entire trace_seq in one shot,
> +			 * trace_seq_to_user() will returns -EBUSY because save_len == 0,
> +			 * In this case, we need to consume it, otherwise, loop will peek
> +			 * this event next time, resulting in an infinite loop.
> +			 */
> +			if (save_len == 0) {
> +				iter->seq.full = 0;
> +				trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
> +				trace_consume(iter);
> +				break;
> +			}
> +
> +			/* In other cases, don't print partial lines */
>   			iter->seq.seq.len = save_len;
>   			break;
>   		}
> 
