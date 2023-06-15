Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D1730BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjFOABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFOABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:01:11 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E71BF8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:01:08 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75d4f12d4a3so270353685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686787267; x=1689379267;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fXEJjr+TFjnbDGeCeFz5U1t0C6/MVgVVi90r4Beh3k=;
        b=doMfZgoDO3Pa0jVsXpfFhkHRbDET4s3LUn2yWNZ1TkV0/zJH/dh70aOYH2kQCwa9go
         5fTCTeLXEw3pRJWrAagnQcI95V+QnvuH0VkXvRAEZydZxvV2V2Fmg/JP63fOmo4kUAmG
         i+AIMQAtk7f3til+1wLTSlDlSPx0h2yMtAznHvWiRB1SjQppVabWC4qlHGvZpIlnEupP
         JMTMGvMLIQ6BNZ+JXvpqNo3HKcOcy/fFMt+bj9UlE93UjJq4s3ZoiiBJXQNVqKjHG5yK
         WMi8jlF/842TLi4eQESQoGDP9ufrAStzdMEMOe5vs+0srv5y8iInHpy+cudRo3xtVpB1
         f0GQ==
X-Gm-Message-State: AC+VfDwC3LG518RhDe3y6JTe22zoWXWdb6M7/CnvGQntcGrIyp+QZxPY
        wEjwgQ5r9Vb025ZI3CHADU2Ls27oAI7cmU2x
X-Google-Smtp-Source: ACHHUZ5deRggMrKu1drB/8G2LhrhwrZCfpBzaxHPiJ0gtaE/r5cu/6T8hmN4L06wyp1Ks+4RGTYXuQ==
X-Received: by 2002:a37:ac08:0:b0:75b:23a1:480 with SMTP id e8-20020a37ac08000000b0075b23a10480mr16390083qkm.70.1686787267203;
        Wed, 14 Jun 2023 17:01:07 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a150100b007620b79eccesm636898qkk.2.2023.06.14.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 17:01:06 -0700 (PDT)
Date:   Wed, 14 Jun 2023 19:01:03 -0500
From:   David Vernet <void@manifault.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230615000103.GC2883716@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614043529.GA1942@ziqianlu-dell>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:35:29PM +0800, Aaron Lu wrote:
> On Tue, Jun 13, 2023 at 10:32:03AM +0200, Peter Zijlstra wrote:
> > 
> > Still gotta read it properly, however:
> > 
> > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> > > Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> > > Single-socket | 176-core | 11-CCX | 2-CCX per CCD | AMD Bergamo Zen4c
> > 
> > Could you please also benchmark on something Intel that has these stupid
> > large LLCs ?

Sure, please see below.

> > Because the last time I tried something like this, it came apart real
> > quick. And AMD has these relatively small 8-core LLCs.
> 
> I tested on Intel(R) Xeon(R) Platinum 8358, which has 2 sockets and each
> socket has a single LLC with 32 cores/64threads.
> 
> When running netperf with nr_thread=128, runtime=60:
> 
> "
> netserver -4
> 
> for i in `seq $nr_threads`; do
> 	netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l $runtime &
> done
> 
> wait
> "
> 
> The lock contention due to the per-LLC swqueue->lock is quite serious:
> 
>     83.39%    83.33%  [kernel.vmlinux]  [k] native_queued_spin_lock_slowpath                                  -      -            
>             |          
>             |--42.86%--__libc_sendto
>             |          entry_SYSCALL_64
>             |          do_syscall_64
>             |          |          
>             |           --42.81%--__x64_sys_sendto
>             |                     __sys_sendto
>             |                     sock_sendmsg
>             |                     inet_sendmsg
>             |                     udp_sendmsg
>             |                     udp_send_skb
>             |                     ip_send_skb
>             |                     ip_output
>             |                     ip_finish_output
>             |                     __ip_finish_output
>             |                     ip_finish_output2
>             |                     __dev_queue_xmit
>             |                     __local_bh_enable_ip
>             |                     do_softirq.part.0
>             |                     __do_softirq
>             |                     |          
>             |                      --42.81%--net_rx_action
>             |                                __napi_poll
>             |                                process_backlog
>             |                                __netif_receive_skb
>             |                                __netif_receive_skb_one_core
>             |                                ip_rcv
>             |                                ip_local_deliver
>             |                                ip_local_deliver_finish
>             |                                ip_protocol_deliver_rcu
>             |                                udp_rcv
>             |                                __udp4_lib_rcv
>             |                                udp_unicast_rcv_skb
>             |                                udp_queue_rcv_skb
>             |                                udp_queue_rcv_one_skb
>             |                                __udp_enqueue_schedule_skb
>             |                                sock_def_readable
>             |                                __wake_up_sync_key
>             |                                __wake_up_common_lock
>             |                                |          
>             |                                 --42.81%--__wake_up_common
>             |                                           receiver_wake_function
>             |                                           autoremove_wake_function
>             |                                           default_wake_function
>             |                                           try_to_wake_up
>             |                                           ttwu_do_activate
>             |                                           enqueue_task
>             |                                           enqueue_task_fair
>             |                                           _raw_spin_lock_irqsave
>             |                                           |          
>             |                                            --42.81%--native_queued_spin_lock_slowpath
>             |          
>             |--20.39%--0
>             |          __libc_recvfrom
>             |          entry_SYSCALL_64
>             |          do_syscall_64
>             |          __x64_sys_recvfrom
>             |          __sys_recvfrom
>             |          sock_recvmsg
>             |          inet_recvmsg
>             |          udp_recvmsg
>             |          __skb_recv_udp
>             |          __skb_wait_for_more_packets
>             |          schedule_timeout
>             |          schedule
>             |          __schedule
>             |          pick_next_task_fair
>             |          |          
>             |           --20.39%--swqueue_remove_task
>             |                     _raw_spin_lock_irqsave
>             |                     |          
>             |                      --20.39%--native_queued_spin_lock_slowpath
>             |          
>              --20.07%--__libc_recvfrom
>                        entry_SYSCALL_64
>                        do_syscall_64
>                        __x64_sys_recvfrom
>                        __sys_recvfrom
>                        sock_recvmsg
>                        inet_recvmsg
>                        udp_recvmsg
>                        __skb_recv_udp
>                        __skb_wait_for_more_packets
>                        schedule_timeout
>                        schedule
>                        __schedule
>                        |          
>                         --20.06%--pick_next_task_fair
>                                   swqueue_remove_task
>                                   _raw_spin_lock_irqsave
>                                   |          
>                                    --20.06%--native_queued_spin_lock_slowpath
> 
> I suppose that is because there are too many CPUs in a single LLC on
> this machine and when all these CPUs try to queue/pull tasks in this
> per-LLC shared wakequeue, it just doesn't scale well.

Hi Aaron,

Thanks for taking a look and running some benchmarks. I tried to
reproduce your results on a 26 core / 52 thread Cooperlake host, and a
20 core / 40 thread x 2 Skylake host, but I wasn't able to observe the
contention on the per-swqueue spinlock you were saw on your Ice Lake.

I ran the following netperf benchmarks:

- netperf -l 60 -n $(nproc) -6
- netperf -l 60 -n $(nproc) -6 -t UDP_RR

Here are the results I'm seeing from taking the average of running those
benchmarks three times on each host (all results are from the "Throughput"
column of the below table).

Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput <<<
bytes  bytes   bytes    secs.    10^6bits/sec


26 / 52 x 1 Cooperlake
----------------------

Default workload:

NO_SWQUEUE: 34103.76
SWQUEUE:    34707.46
Delta: +1.77%

UDP_RR:

NO_SWQUEUE: 57695.29
SWQUEUE: 54827.36
Delta: -4.97%

There's clearly a statistically significant decline in performance for
UDP_RR here, but surprisingly, I don't see any contention on swqueue
locks when I profile with perf. Rather, we seem to be contending on the
rq lock (presumably in swqueue_pick_next_task() which is unexpected (to
me, at least):

     7.81%  netperf  [kernel.vmlinux]                                           [k] queued_spin_lock_slowpath
            |          
             --7.81%--queued_spin_lock_slowpath
                       |          
                        --7.55%--task_rq_lock
                                  pick_next_task_fair
                                  schedule
                                  schedule_timeout
                                  __skb_wait_for_more_packets
                                  __skb_recv_udp
                                  udpv6_recvmsg
                                  inet6_recvmsg
                                  __x64_sys_recvfrom
                                  do_syscall_64
                                  entry_SYSCALL_64
                                  __libc_recvfrom
                                  0x7f923fdfacf0
                                  0
     4.97%  netperf  [kernel.vmlinux]                                           [k] _raw_spin_lock_irqsave
            |          
             --4.96%--_raw_spin_lock_irqsave
                       |          
                       |--1.13%--prepare_to_wait_exclusive
                       |          __skb_wait_for_more_packets
                       |          __skb_recv_udp
                       |          udpv6_recvmsg
                       |          inet6_recvmsg
                       |          __x64_sys_recvfrom
                       |          do_syscall_64
                       |          entry_SYSCALL_64
                       |          __libc_recvfrom
                       |          0x7f923fdfacf0
                       |          0
                       |          
                       |--0.92%--default_wake_function
                       |          autoremove_wake_function
                       |          __wake_up_sync_key
                       |          sock_def_readable
                       |          __udp_enqueue_schedule_skb
                       |          udpv6_queue_rcv_one_skb
                       |          __udp6_lib_rcv
                       |          ip6_input
                       |          ipv6_rcv
                       |          process_backlog
                       |          net_rx_action
                       |          __softirqentry_text_start
                       |          __local_bh_enable_ip
                       |          ip6_output
                       |          ip6_local_out
                       |          ip6_send_skb
                       |          udp_v6_send_skb
                       |          udpv6_sendmsg
                       |          __sys_sendto
                       |          __x64_sys_sendto
                       |          do_syscall_64
                       |          entry_SYSCALL_64
                       |          __libc_sendto
                       |          
                       |--0.81%--__wake_up_sync_key
                       |          sock_def_readable
                       |          __udp_enqueue_schedule_skb
                       |          udpv6_queue_rcv_one_skb
                       |          __udp6_lib_rcv
                       |          ip6_input
                       |          ipv6_rcv
                       |          process_backlog
                       |          net_rx_action
                       |          __softirqentry_text_start
                       |          __local_bh_enable_ip
                       |          ip6_output
                       |          ip6_local_out
                       |          ip6_send_skb
                       |          udp_v6_send_skb
                       |          udpv6_sendmsg
                       |          __sys_sendto
                       |          __x64_sys_sendto
                       |          do_syscall_64
                       |          entry_SYSCALL_64
                       |          __libc_sendto
                       |          
                       |--0.73%--enqueue_task_fair
                       |          |          
                       |           --0.72%--default_wake_function
                       |                     autoremove_wake_function
                       |                     __wake_up_sync_key
                       |                     sock_def_readable
                       |                     __udp_enqueue_schedule_skb
                       |                     udpv6_queue_rcv_one_skb
                       |                     __udp6_lib_rcv
                       |                     ip6_input
                       |                     ipv6_rcv
                       |                     process_backlog
                       |                     net_rx_action
                       |                     __softirqentry_text_start
                       |                     __local_bh_enable_ip
                       |                     ip6_output
                       |                     ip6_local_out
                       |                     ip6_send_skb
                       |                     udp_v6_send_skb
                       |                     udpv6_sendmsg
                       |                     __sys_sendto
                       |                     __x64_sys_sendto
                       |                     do_syscall_64
                       |                     entry_SYSCALL_64
                       |                     __libc_sendto
                       |          
                        --0.68%--task_rq_lock
                                  pick_next_task_fair
                                  schedule
                                  schedule_timeout
                                  __skb_wait_for_more_packets
                                  __skb_recv_udp
                                  udpv6_recvmsg
                                  inet6_recvmsg
                                  __x64_sys_recvfrom
                                  do_syscall_64
                                  entry_SYSCALL_64
                                  __libc_recvfrom
                                  0x7f923fdfacf0
                                  0

The profile without swqueue doesn't show any contention on the rq lock,
but does show us spending a good amount of time in the scheduler:

     4.03%  netperf  [kernel.vmlinux]                                           [k] default_wake_function
            |          
             --3.98%--default_wake_function
                       autoremove_wake_function
                       __wake_up_sync_key
                       sock_def_readable
                       __udp_enqueue_schedule_skb
                       udpv6_queue_rcv_one_skb
                       __udp6_lib_rcv
                       ip6_input
                       ipv6_rcv
                       process_backlog
                       net_rx_action
                       __softirqentry_text_start
                       __local_bh_enable_ip
                       ip6_output
                       ip6_local_out
                       ip6_send_skb
                       udp_v6_send_skb
                       udpv6_sendmsg
                       __sys_sendto
                       __x64_sys_sendto
                       do_syscall_64
                       entry_SYSCALL_64
                       __libc_sendto
     3.70%  netperf  [kernel.vmlinux]                                           [k] enqueue_entity
            |          
             --3.66%--enqueue_entity
                       enqueue_task_fair
                       |          
                        --3.66%--default_wake_function
                                  autoremove_wake_function
                                  __wake_up_sync_key
                                  sock_def_readable
                                  __udp_enqueue_schedule_skb
                                  udpv6_queue_rcv_one_skb
                                  __udp6_lib_rcv
                                  ip6_input
                                  ipv6_rcv
                                  process_backlog
                                  net_rx_action
                                  __softirqentry_text_start
                                  __local_bh_enable_ip
                                  ip6_output
                                  ip6_local_out
                                  ip6_send_skb
                                  udp_v6_send_skb
                                  udpv6_sendmsg
                                  __sys_sendto
                                  __x64_sys_sendto
                                  do_syscall_64
                                  entry_SYSCALL_64
                                  __libc_sendto

There's clearly a measurable impact on performance here due to swqueue
(negative for UDP_RR, positive for the default workload), but this looks
quite different than what you were observing.

20 / 40 x 2 Skylake
-------------------

Default workload:

NO_SWQUEUE: 57437.45
SWQUEUE: 58801.11
Delta: +2.37%

UDP_RR:

NO_SWQUEUE: 75932.28
SWQUEUE: 75232.77
Delta: -.92%

Same observation here. I didn't collect a profile, but the trend seems
consistent, and there's clearly a tradeoff. Despite the small drop in
perf for UDP_RR, it seems quite a bit less drastic than what would be
expected with the contention you showed in your profile.

7950X (8 cores / 16 threads per CCX, 2 CCXs)
--------------------------------------------

Default workload:

NO_SWQUEUE: 77615.08
SWQUEUE: 77465.73
Delta: -.19%

UDP_RR:

NO_SWQUEUE: 230258.75
SWQUEUE: 230280.34
Delta: ~0%

I'd call this essentially a no-op.

Milan (6 cores / 12 threads per CCX, 6 CCXs)
--------------------------------------------

Default workload:

NO_SWQUEUE: 23571.39
SWQUEUE: 23791.47
Delta: +.93%

UDP_RR:

NO_SWQUEUE: 40954.66
SWQUEUE: 40385.08
Delta: -1.39%

Same story here as above. Interesting to note though that Milan has a
small numer of cores per-LLC. I collected a profile, but I'm not sure
how useful it is given that so much of the profile seems to be indicting
perf as the bottleneck:

    24.93%           664  netperf  [kernel.vmlinux]                                           [k] x86_pmu_disable_all
            |
            ---x86_pmu_disable_all
               amd_pmu_disable_all
               |          
               |--23.87%--__perf_event_task_sched_out
               |          schedule
               |          |          
               |           --23.84%--schedule_timeout
               |                     __skb_wait_for_more_packets
               |                     __skb_recv_udp
               |                     udpv6_recvmsg
               |                     inet6_recvmsg
               |                     __x64_sys_recvfrom
               |                     do_syscall_64
               |                     entry_SYSCALL_64
               |                     __libc_recvfrom
               |                     0x7fbfa69facf0
               |                     0
               |          
                --0.62%--perf_mux_hrtimer_handler
                          hrtimer_interrupt
                          __sysvec_apic_timer_interrupt
                          sysvec_apic_timer_interrupt
                          asm_sysvec_apic_timer_interrupt
     5.33%           135  netperf  [kernel.vmlinux]                                           [k] amd_pmu_test_overflow_topbit
            |
            ---amd_pmu_test_overflow_topbit
               amd_pmu_check_overflow
               |          
                --5.18%--__perf_event_task_sched_out
                          schedule
                          schedule_timeout
                          __skb_wait_for_more_packets
                          __skb_recv_udp
                          udpv6_recvmsg
                          inet6_recvmsg
                          __x64_sys_recvfrom
                          do_syscall_64
                          entry_SYSCALL_64
                          __libc_recvfrom
                          0x7fbfa69facf0
                          0
     3.73%           102  netperf  [kernel.vmlinux]                                           [k] native_sched_clock
            |
            ---native_sched_clock
               |          
               |--1.18%--sched_clock_cpu
               |          |          
               |           --0.75%--irqtime_account_irq
               |                     |          
               |                      --0.71%--__softirqentry_text_start
               |                                __local_bh_enable_ip
               |                                ip6_output
               |                                ip6_local_out
               |                                ip6_send_skb
               |                                udp_v6_send_skb
               |                                udpv6_sendmsg
               |                                __sys_sendto
               |                                __x64_sys_sendto
               |                                do_syscall_64
               |                                entry_SYSCALL_64
               |                                __libc_sendto
               |          
               |--1.18%--vtime_user_exit
               |          __context_tracking_exit
               |          syscall_enter_from_user_mode
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          |          
               |          |--0.61%--__libc_recvfrom
               |          |          0x7fbfa69facf0
               |          |          0
               |          |          
               |           --0.57%--__libc_sendto
               |          
                --0.51%--vtime_user_enter
                          __context_tracking_enter
                          syscall_exit_to_user_mode
                          do_syscall_64
                          entry_SYSCALL_64
     3.53%           107  netperf  [kernel.vmlinux]                                           [k] copy_user_generic_string
            |
            ---copy_user_generic_string
               |          
               |--1.45%--_copy_to_iter
               |          udpv6_recvmsg
               |          inet6_recvmsg
               |          __x64_sys_recvfrom
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          __libc_recvfrom
               |          0x7fbfa69facf0
               |          0
               |          
               |--0.91%--_copy_to_user
               |          move_addr_to_user
               |          __x64_sys_recvfrom
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          __libc_recvfrom
               |          0x7fbfa69facf0
               |          0
               |          
                --0.73%--_copy_from_user
                          __sys_sendto
                          __x64_sys_sendto
                          do_syscall_64
                          entry_SYSCALL_64
                          __libc_sendto
     2.98%            79  netperf  [kernel.vmlinux]                                           [k] default_wake_function
            |
            ---default_wake_function
               autoremove_wake_function
               __wake_up_sync_key
               sock_def_readable
               __udp_enqueue_schedule_skb
               udpv6_queue_rcv_one_skb
               __udp6_lib_rcv
               ip6_input
               ipv6_rcv
               process_backlog
               net_rx_action
               __softirqentry_text_start
               __local_bh_enable_ip
               ip6_output
               ip6_local_out
               ip6_send_skb
               udp_v6_send_skb
               udpv6_sendmsg
               __sys_sendto
               __x64_sys_sendto
               do_syscall_64
               entry_SYSCALL_64
               __libc_sendto

In any case, as expected, the swqueue lock doesn't seem to be causing
any issues here.


I was wondering if the contention you were seeing could be due to
something like TTWU_QUEUE (though I wouldn't have expected that because
we don't use the swqueue if a task is migrated following
select_task_rq()), so I also tried collecting data with NO_TTWU_QUEUE
(only on the 2-socket SKL), but the results matched what I observed
without it:

Default workload:

NO_SWQUEUE: 57552.69
SWQUEUE: 58320.29
Delta: +1.33%

UDP_RR:

NO_SWQUEUE: 76296.46
SWQUEUE: 75418.35
Delta: -1.15%


I also tried running kernel compile workloads just to verify they didn't
regress per Peter's request:


26 / 52 x 1 Cooperlake
----------------------

NO_SWQUEUE: 1187.72s
SWQUEUE: 1185.39s
Delta: +.20%


20 / 40 x 2 Skylake
-------------------

NO_SWQUEUE: 418.15s
SWQUEUE: 418.87s
Delta: -.17%

I'd call this essentially a no-op for kernel compile.


In general, the results indicate some wins and some losses.

For kernel compile, larger LLCs with more cores was a no-op. For
netperf, the default workload had some gains, and for UPD_RR, some
losses.

With all that said, I have a few thoughts.

Firstly, would you mind please sharing your .config? It's possible that
the hosts I'm testing on just don't have big enough LLCs to observe the
contention you're seeing on the swqueue spinlock, as my 26 / 52 CPL host
is smaller than a single socket of your 32/64 ICL host. On the other
hand, your ICL isn't _that_ much bigger per-LLC, so I'd be curious to
see if there's a .config difference here that's causing the contention.
Also, the fact that Milan (which has only 6 cores / 12 threads per LLC)
also saw a performance hit with swqueue for UDP_RR suggests to me that
the issue with UDP_RR is not the scalability of the per-LLC swqueue
spinlock.

Regardless, even if there are some SKUs that have so many cores per LLC
that we do end up contending, I don't think that should preclude adding
a feature that which does benefit plenty of other configurations that
have fewer cores per LLC.

Thanks,
David
