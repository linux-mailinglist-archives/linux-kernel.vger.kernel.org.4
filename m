Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E66CBF54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjC1MkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjC1Mj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:39:58 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869093C3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680007168;
        bh=HkC8VWcgGkv9sYt7tZ295ZUqC71ZeQfKeoLlF8zq73M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLEZ5hHGyJZ2ytCuo6mxcir/Y5GfcaKjeFuEKdPJRHse2bVbyKUh+LxZt7nH7x+es
         Lph7QksnkraU7AxBH3KjS89W9jz5So2Qmu0LE57RWEy3uFetpK0ccGE42biA7Vkbeq
         Q2XekH3JCSDmdZuAI327/z5a4WrSxEwMvj8FCtdcLg6MWMGcNMrsWKJyjHgQ0sdBML
         vQ5ZbJ+2tP0j3jSqkAYVIP17re8FU4KgPx1vd571xXZf+9nfGceymcqaht9lPfK+sV
         8jGmQrL9gBDyTRVAQc3zcU+8LJxseG4ys3nHnIzJFYxCwkp1O/94ZjPFLeyTtH9st7
         nm9ivBF8Xgijg==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pm8Q85JDtzt8s;
        Tue, 28 Mar 2023 08:39:28 -0400 (EDT)
Message-ID: <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
Date:   Tue, 28 Mar 2023 08:39:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: rq lock contention due to commit af7f588d8f73
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
 <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
 <20230328065809.GB4899@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230328065809.GB4899@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-28 02:58, Aaron Lu wrote:
> On Mon, Mar 27, 2023 at 03:57:43PM -0400, Mathieu Desnoyers wrote:
>   
>> I've just resuscitated my per-runqueue concurrency ID cache patch from an older
>> patchset, and posted it as RFC. So far it passed one round of rseq selftests. Can
>> you test it in your environment to see if I'm on the right track ?
>>
>> https://lore.kernel.org/lkml/20230327195318.137094-1-mathieu.desnoyers@efficios.com/
> 
> There are improvements with this patch.
> 
> When running the client side sysbench with nr_thread=56, the lock contention
> is gone%; with nr_thread=224(=nr_cpu of this machine), the lock contention
> dropped from 75% to 27%.

This is a good start!

Can you compare this with Peter's approach to modify init/Kconfig, make 
SCHED_MM_CID a bool, and set it =n in the kernel config ?

I just want to see what baseline we should compare against.

Another test we would want to try here: there is an arbitrary choice for 
the runqueue cache array size in my own patch:

kernel/sched/sched.h:
# define RQ_CID_CACHE_SIZE    8

Can you try changing this value for 16 or 32 instead and see if it helps?

Thanks,

Mathieu

> 
> v6.3.0-rc4:
> 
>      75.21%    75.20%  [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
> 37.30% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_sys_poll;__x64_sys_poll;do_syscall_64;entry_SYSCALL_64_after_hwframe;__poll;0x7f943d6fcff8;PQgetResult;0x7f943d6f9a2b;0x55c7f9bde88b
> 26.01% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
> 11.36% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64_after_hwframe;epoll_wait;secure_read;0x55c4d1363867;pq_getbyte;PostgresMain;0x55c4d140c828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 
> v6.3.0-rc4+the_above_patch:
> 
>      27.86%    27.85%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> 7.31% native_queued_spin_lock_slowpath;_raw_spin_lock;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 4.62% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify
> 4.20% native_queued_spin_lock_slowpath;_raw_spin_lock;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;epoll_wait;secure_read;0x5637a602e867;pq_getbyte;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 1.66% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;_raw_spin_rq_lock_irqsave;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send
> 1.65% native_queued_spin_lock_slowpath;_raw_spin_lock;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_data_queue;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e69e;0x5637a602e7ae;0x5637a5e5f62e;standard_ExecutorRun;0x5637a615abeb;PortalRun;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 1.63% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__schedule;schedule;schedule_hrtimeout_range_clock;schedule_hrtimeout_range;do_epoll_wait;__x64_sys_epoll_wait;do_syscall_64;entry_SYSCALL_64;epoll_wait;secure_read;0x5637a602e867;pq_getbyte;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 1.40% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 1.20% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;_raw_spin_rq_lock_irqsave;try_to_wake_up;default_wake_function;pollwake;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send;0x5637a602e4cd;0x5637a602e98d;PostgresMain;0x5637a60d7828;PostmasterMain;main;__libc_start_main;0x5541d68949564100
> 0.83% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__task_rq_lock;try_to_wake_up;default_wake_function;ep_autoremove_wake_function;__wake_up_common;__wake_up_common_lock;__wake_up;ep_poll_callback;__wake_up_common;__wake_up_common_lock;__wake_up_sync_key;sock_def_readable;tcp_data_ready;tcp_rcv_established;tcp_v4_do_rcv;tcp_v4_rcv;ip_protocol_deliver_rcu;ip_local_deliver_finish;ip_local_deliver;ip_rcv;__netif_receive_skb_one_core;__netif_receive_skb;process_backlog;__napi_poll;net_rx_action;__do_softirq;do_softirq.part.0;__local_bh_enable_ip;ip_finish_output2;__ip_finish_output;ip_finish_output;ip_output;ip_local_out;__ip_queue_xmit;ip_queue_xmit;__tcp_transmit_skb;tcp_write_xmit;__tcp_push_pending_frames;tcp_push;tcp_sendmsg_locked;tcp_sendmsg;inet_sendmsg;sock_sendmsg;__sys_sendto;__x64_sys_sendto;do_syscall_64;entry_SYSCALL_64;__libc_send
> 0.65% native_queued_spin_lock_slowpath;_raw_spin_lock;raw_spin_rq_lock_nested;__schedule;schedule_idle;do_idle;cpu_startup_entry;start_secondary;secondary_startup_64_no_verify

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

