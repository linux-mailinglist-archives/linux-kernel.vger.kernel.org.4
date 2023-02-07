Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA86D68D563
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBGL1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjBGL05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:26:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9505186BB;
        Tue,  7 Feb 2023 03:26:53 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PB14S4rmXz16NRF;
        Tue,  7 Feb 2023 19:24:40 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 7 Feb 2023 19:26:50 +0800
Message-ID: <c94b7dc4-7cea-7c07-b4b3-a224660444b4@huawei.com>
Date:   Tue, 7 Feb 2023 19:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug report] WARNINGs in rb_check_pages() and
 rb_handle_head_page()
Content-Language: en-US
To:     <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <wanghai38@huawei.com>
References: <20230203035608.2336906-1-zhengyejian1@huawei.com>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230203035608.2336906-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/3 11:56, Zheng Yejian wrote:
> Hi, steve
> 
> I happened to get two WARNINGs [1] [2] at same time when testing v5.10 with
> testcase 'func_profiler.tc':
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/ftrace/test.d/ftrace/func_profiler.tc
> 
> It seems a data race between ring_buffer writing and integrity checking.
> That is, head_page is moving when buffer is full and RB_FLAG is updating,
> however at same time RB_FLAG was cleared when doing integrity check:
>    rb_check_pages()            rb_handle_head_page():
>    --------                    --------
>    rb_head_page_deactivate()
>                                rb_head_page_set_normal()
>    rb_head_page_activate()
> 
> Mainline kernel seems have this problem as well, see the constructed
> testcase 'repro.sh' [3] and reproduction log [4].
> 
> Integrity checking of ring_buffer on closing "trace" file seems not a good
> point, do you have any idea, steve?
> 
> 1:
> One WARNING happened at
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/trace/ring_buffer.c?h=linux-5.10.y#n1492
>    Call Trace:
>     rb_check_pages
>     ring_buffer_read_finish
>     tracing_release
> 
> 2:
> The other WARNING happened at
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/trace/ring_buffer.c?h=linux-5.10.y#n2507
>    Call Trace:
>     rb_handle_head_page
>     rb_move_tail
>     __rb_reserve_next
>     rb_reserve_next_event
>     ring_buffer_lock_reserve
>     __trace_buffer_lock_reserve
>     trace_function
>     function_trace_call
> 
> 3:
> ``` read_trace.sh
>    while true;
>    do
>      # the "trace" file is closed after read
>      head -1 /sys/kernel/tracing/trace > /dev/null
>    done
> ```
> ``` repro.sh
>    # function tracer will writing enough data into ring_buffer
>    echo function > /sys/kernel/tracing/current_tracer
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
>    ./read_trace.sh &
> ```
> 

Kindly ping :)
Above testcase seems common, but after warning happened, ring buffer
would be disabled, so this is a problem. Would it be ok to move the
ring buffer integrity check before tracing on or after tracing off?

--

Best regards,
Zheng Yejian

> 4:
> ------------[ cut here ]------------
> WARNING: CPU: 9 PID: 62 at kernel/trace/ring_buffer.c:2653 rb_move_tail+0x450/0x470
> Modules linked in:
> CPU: 9 PID: 62 Comm: ksoftirqd/9 Tainted: G        W          6.2.0-rc6+ #261
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> RIP: 0010:rb_move_tail+0x450/0x470
> Code: ff ff 4c 89 c8 f0 4d 0f b1 02 48 89 c2 48 83 e2 fc 49 39 d0 75 24 83 e0 03 83 f8 02 0f 84 e1 fb ff ff 48 8b 57 10 f0 ff 42 08 <0f> 0b 83 f8 02 0f 84 ce fb ff ff e9 db
> RSP: 0018:ffffb5564089bd00 EFLAGS: 00000203
> RAX: 0000000000000000 RBX: ffff9db385a2bf81 RCX: ffffb5564089bd18
> RDX: ffff9db281110100 RSI: 0000000000000fe4 RDI: ffff9db380145400
> RBP: ffff9db385a2bf80 R08: ffff9db385a2bfc0 R09: ffff9db385a2bfc2
> R10: ffff9db385a6c000 R11: ffff9db385a2bf80 R12: 0000000000000000
> R13: 00000000000003e8 R14: ffff9db281110100 R15: ffffffffbb006108
> FS:  0000000000000000(0000) GS:ffff9db3bdcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005602323024c8 CR3: 0000000022e0c000 CR4: 00000000000006e0
> Call Trace:
>   <TASK>
>   ring_buffer_lock_reserve+0x136/0x360
>   ? __do_softirq+0x287/0x2df
>   ? __pfx_rcu_softirq_qs+0x10/0x10
>   trace_function+0x21/0x110
>   ? __pfx_rcu_softirq_qs+0x10/0x10
>   ? __do_softirq+0x287/0x2df
>   function_trace_call+0xf6/0x120
>   0xffffffffc038f097
>   ? rcu_softirq_qs+0x5/0x140
>   rcu_softirq_qs+0x5/0x140
>   __do_softirq+0x287/0x2df
>   run_ksoftirqd+0x2a/0x30
>   smpboot_thread_fn+0x188/0x220
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   kthread+0xe7/0x110
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2c/0x50
>   </TASK>
> ---[ end trace 0000000000000000 ]--
