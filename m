Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17ED648D13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 05:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLJEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 23:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLJEM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 23:12:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9556B70BAD;
        Fri,  9 Dec 2022 20:12:25 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NTZFr4b0wzRpqd;
        Sat, 10 Dec 2022 12:11:28 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 12:12:23 +0800
Message-ID: <d585e629-92ea-3ba4-876f-4fda11c5c055@huawei.com>
Date:   Sat, 10 Dec 2022 12:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ftrace: Fix print_ip_ins() to print only two digits per
 byte
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221209105640.6d5eda0e@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20221209105640.6d5eda0e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/9 23:56, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Fix print_ip_ins() to use unsigned char, as:
> 
> 	e9:2b:b6:0d:18
> 
> is easier to understand than
> 
> 	ffffffe9:2b:ffffffb6:0d:18
> 
> Link: https://lore.kernel.org/all/CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 6c14133d2d3f7 ("ftrace: Do not blindly read the ip address in ftrace_bug()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/ftrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index d04552c0c275..32fc1600d596 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2028,7 +2028,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
>   
>   static void print_ip_ins(const char *fmt, const unsigned char *p)
>   {
> -	char ins[MCOUNT_INSN_SIZE];
> +	unsigned char ins[MCOUNT_INSN_SIZE];
>   
>   	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
>   		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);

Hi, Steve,

commit 30f7d1cac2aa ("ftrace: Fix char print issue in print_ip_ins()")
has solved this issue.

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30f7d1cac2aab8fec560a388ad31ca5e5d04a822
