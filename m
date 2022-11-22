Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4150E63381F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiKVJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKVJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:16:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85182101C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:16:42 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGdsm3PBBzRpNN;
        Tue, 22 Nov 2022 17:16:12 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:16:40 +0800
Subject: Re: [PATCH --next] tracing: Make tracepoint_print_iter static
From:   xiujianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.or>
CC:     <linux-kernel@vger.kernel.org>
References: <20221122091031.71248-1-xiujianfeng@huawei.com>
Message-ID: <e5228259-da7c-f6ae-4ec6-9fdfb2725a26@huawei.com>
Date:   Tue, 22 Nov 2022 17:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20221122091031.71248-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, ignore this.

ÔÚ 2022/11/22 17:10, Xiu Jianfeng Ð´µÀ:
> After change in commit 4239174570da ("tracing: Make tracepoint_printk a
> static_key"), this symbol is not used outside of the file, so mark it
> static.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/trace/trace.c | 2 +-
>   kernel/trace/trace.h | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..11a7214a2f49 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -85,7 +85,7 @@ void __init disable_tracing_selftest(const char *reason)
>   #endif
>   
>   /* Pipe tracepoints to printk */
> -struct trace_iterator *tracepoint_print_iter;
> +static struct trace_iterator *tracepoint_print_iter;
>   int tracepoint_printk;
>   static bool tracepoint_printk_stop_on_boot __initdata;
>   static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 54ee5711c729..d9b470a0adf2 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1941,8 +1941,6 @@ static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
>   static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
>   #endif
>   
> -extern struct trace_iterator *tracepoint_print_iter;
> -
>   /*
>    * Reset the state of the trace_iterator so that it can read consumed data.
>    * Normally, the trace_iterator is used for reading the data when it is not
> 
