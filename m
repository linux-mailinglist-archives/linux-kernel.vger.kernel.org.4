Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894EE5B3439
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIIJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiIIJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:40:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A751F7B797
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:40:10 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP9rX5PpWznV9y;
        Fri,  9 Sep 2022 17:37:32 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:40:08 +0800
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 17:40:08 +0800
Message-ID: <9d070742-8a82-3cb0-cea0-8ecce01c06b6@huawei.com>
Date:   Fri, 9 Sep 2022 17:40:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 2/2] riscv: tracing: Improve hardirq tracing message
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>
References: <20220901104515.135162-1-zouyipeng@huawei.com>
 <20220901104515.135162-3-zouyipeng@huawei.com>
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <20220901104515.135162-3-zouyipeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

在 2022/9/1 18:45, Yipeng Zou 写道:
> Use trace_hardirqs_on_caller to improve irq_tracing message.
>
> lockdep log in riscv showing the last {enabled,disabled} at
> __trace_hardirqs_{on,off} all the time(if called by).
> But that's not what we want to see, the caller is what we want.
>
> Before this commit:
> [   57.853175] hardirqs last  enabled at (2519): __trace_hardirqs_on+0xc/0x14
> [   57.853848] hardirqs last disabled at (2520): __trace_hardirqs_off+0xc/0x14
>
> After this commit
> [   53.781428] hardirqs last  enabled at (2595): restore_all+0xe/0x66
> [   53.782185] hardirqs last disabled at (2596): ret_from_exception+0xa/0x10
>
> Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> ---
>   arch/riscv/kernel/trace_irq.c | 4 ++--
>   include/linux/irqflags.h      | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
> index 095ac976d7da..7ca24b26e19f 100644
> --- a/arch/riscv/kernel/trace_irq.c
> +++ b/arch/riscv/kernel/trace_irq.c
> @@ -16,12 +16,12 @@
>   
>   void __trace_hardirqs_on(void)
>   {
> -	trace_hardirqs_on();
> +	trace_hardirqs_on_caller(CALLER_ADDR0);
>   }
>   NOKPROBE_SYMBOL(__trace_hardirqs_on);
>   
>   void __trace_hardirqs_off(void)
>   {
> -	trace_hardirqs_off();
> +	trace_hardirqs_off_caller(CALLER_ADDR0);
>   }
>   NOKPROBE_SYMBOL(__trace_hardirqs_off);
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 5ec0fa71399e..46774fa85cde 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -53,6 +53,8 @@ extern void trace_hardirqs_on_prepare(void);
>   extern void trace_hardirqs_off_finish(void);
>   extern void trace_hardirqs_on(void);
>   extern void trace_hardirqs_off(void);
> +extern void trace_hardirqs_on_caller(unsigned long caller_addr);
> +extern void trace_hardirqs_off_caller(unsigned long caller_addr);
>   
>   # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
>   # define lockdep_softirq_context(p)	((p)->softirq_context)

-- 
Regards,
Yipeng Zou

