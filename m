Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E452732398
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjFOX1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFOX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:27:31 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A72D5D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:27:05 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-62ff12ba965so1801676d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871569; x=1689463569;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUpnKcxX83e/42mugp3BwoOPoVyd1XEyCwaCu/itwec=;
        b=DVZbyQBv1xioJ7PFNwMLvLIfXPmGEY+tHQAHp6uQVZET6mYH7xx0ZGe0fzsMC/Gojr
         UDPK6200G4ff2yduLc/IysuHLBuwKHuy/nYj2MqJa+lDe9gdZ4wxKMS8P//b0DxPypbv
         BF6jbHJe7uceOB/AQIoRPkal+rqstc8KFyiY55oi8KgJuzgrNugsJGVV4Vdr5r0U7zhF
         hMArmAtVQVpXqVkrzlAoXRNf+CsvFn8t/edrmzI/l6WGPEIf9XCXQH/4/vm9Yw/S3mbU
         B44UQkyRsWFM5yx3eAmdriEFZ0+AZDj0+ZeMJo/mTuqEH6JxGsFVkaxvLrYHxQzdYJy3
         bJiA==
X-Gm-Message-State: AC+VfDwbojsdQ3mkZABezmvkSFC0Sr4RKZ+rhgNlzhUtzqqSAbd5jNsC
        1jMHeAKw+qFjd0EoOwGXjw4=
X-Google-Smtp-Source: ACHHUZ4Tpiky6qHRNbX6UMpuS06Q7JWS8POE/CF8BvbTPznw1X+nSWWGUM5EqJYnvKHi7+vdKpmRpw==
X-Received: by 2002:a05:6214:1cc7:b0:62d:feee:252e with SMTP id g7-20020a0562141cc700b0062dfeee252emr376605qvd.55.1686871568767;
        Thu, 15 Jun 2023 16:26:08 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id q5-20020ad45ca5000000b00623950fbe48sm6285341qvh.41.2023.06.15.16.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:26:08 -0700 (PDT)
Date:   Thu, 15 Jun 2023 18:26:05 -0500
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
Message-ID: <20230615232605.GB2915572@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615073153.GA110814@ziqianlu-dell>
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

On Thu, Jun 15, 2023 at 03:31:53PM +0800, Aaron Lu wrote:
> On Thu, Jun 15, 2023 at 12:49:17PM +0800, Aaron Lu wrote:
> > I'll see if I can find a smaller machine and give it a run there too.
> 
> Found a Skylake with 18cores/36threads on each socket/LLC and with
> netperf, the contention is still serious.
> 
> "
> $ netserver
> $ sudo sh -c "echo SWQUEUE > /sys/kernel/debug/sched/features"
> $ for i in `seq 72`; do netperf -l 60 -n 72 -6 -t UDP_RR & done
> "
> 
>         53.61%    53.61%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath            -      -            
>             |          
>             |--27.93%--sendto
>             |          entry_SYSCALL_64
>             |          do_syscall_64
>             |          |          
>             |           --27.93%--__x64_sys_sendto
>             |                     __sys_sendto
>             |                     sock_sendmsg
>             |                     inet6_sendmsg
>             |                     udpv6_sendmsg
>             |                     udp_v6_send_skb
>             |                     ip6_send_skb
>             |                     ip6_local_out
>             |                     ip6_output
>             |                     ip6_finish_output
>             |                     ip6_finish_output2
>             |                     __dev_queue_xmit
>             |                     __local_bh_enable_ip
>             |                     do_softirq.part.0
>             |                     __do_softirq
>             |                     net_rx_action
>             |                     __napi_poll
>             |                     process_backlog
>             |                     __netif_receive_skb
>             |                     __netif_receive_skb_one_core
>             |                     ipv6_rcv
>             |                     ip6_input
>             |                     ip6_input_finish
>             |                     ip6_protocol_deliver_rcu
>             |                     udpv6_rcv
>             |                     __udp6_lib_rcv
>             |                     udp6_unicast_rcv_skb
>             |                     udpv6_queue_rcv_skb
>             |                     udpv6_queue_rcv_one_skb
>             |                     __udp_enqueue_schedule_skb
>             |                     sock_def_readable
>             |                     __wake_up_sync_key
>             |                     __wake_up_common_lock
>             |                     |          
>             |                      --27.85%--__wake_up_common
>             |                                receiver_wake_function
>             |                                autoremove_wake_function
>             |                                default_wake_function
>             |                                try_to_wake_up
>             |                                |          
>             |                                 --27.85%--ttwu_do_activate
>             |                                           enqueue_task
>             |                                           enqueue_task_fair
>             |                                           |          
>             |                                            --27.85%--_raw_spin_lock_irqsave
>             |                                                      |          
>             |                                                       --27.85%--native_queued_spin_lock_slowpath
>             |          
>              --25.67%--recvfrom
>                        entry_SYSCALL_64
>                        do_syscall_64
>                        __x64_sys_recvfrom
>                        __sys_recvfrom
>                        sock_recvmsg
>                        inet6_recvmsg
>                        udpv6_recvmsg
>                        __skb_recv_udp
>                        |          
>                         --25.67%--__skb_wait_for_more_packets
>                                   schedule_timeout
>                                   schedule
>                                   __schedule
>                                   |          
>                                    --25.66%--pick_next_task_fair
>                                              |          
>                                               --25.65%--swqueue_remove_task
>                                                         |          
>                                                          --25.65%--_raw_spin_lock_irqsave
>                                                                    |          
>                                                                     --25.65%--native_queued_spin_lock_slowpath
> 
> I didn't aggregate the throughput(Trans. Rate per sec) from all these
> clients, but a glimpse from the result showed that the throughput of
> each client dropped from 4xxxx(NO_SWQUEUE) to 2xxxx(SWQUEUE).
> 
> Thanks,
> Aaron

Ok, it seems that the issue is that I wasn't creating enough netperf
clients. I assumed that -n $(nproc) was sufficient. I was able to repro
the contention on my 26 core / 52 thread skylake client as well:


    41.01%  netperf          [kernel.vmlinux]                                                 [k] queued_spin_lock_slowpath
            |          
             --41.01%--queued_spin_lock_slowpath
                       |          
                        --40.63%--_raw_spin_lock_irqsave
                                  |          
                                  |--21.18%--enqueue_task_fair
                                  |          |          
                                  |           --21.09%--default_wake_function
                                  |                     |          
                                  |                      --21.09%--autoremove_wake_function
                                  |                                |          
                                  |                                 --21.09%--__wake_up_sync_key
                                  |                                           sock_def_readable
                                  |                                           __udp_enqueue_schedule_skb
                                  |                                           udpv6_queue_rcv_one_skb
                                  |                                           __udp6_lib_rcv
                                  |                                           ip6_input
                                  |                                           ipv6_rcv
                                  |                                           process_backlog
                                  |                                           net_rx_action
                                  |                                           |          
                                  |                                            --21.09%--__softirqentry_text_start
                                  |                                                      __local_bh_enable_ip
                                  |                                                      ip6_output
                                  |                                                      ip6_local_out
                                  |                                                      ip6_send_skb
                                  |                                                      udp_v6_send_skb
                                  |                                                      udpv6_sendmsg
                                  |                                                      __sys_sendto
                                  |                                                      __x64_sys_sendto
                                  |                                                      do_syscall_64
                                  |                                                      entry_SYSCALL_64
                                  |          
                                   --19.44%--swqueue_remove_task
                                             |          
                                              --19.42%--pick_next_task_fair
                                                        |          
                                                         --19.42%--schedule
                                                                   |          
                                                                    --19.21%--schedule_timeout
                                                                              __skb_wait_for_more_packets
                                                                              __skb_recv_udp
                                                                              udpv6_recvmsg
                                                                              inet6_recvmsg
                                                                              __x64_sys_recvfrom
                                                                              do_syscall_64
                                                                              entry_SYSCALL_64
    40.87%  netserver        [kernel.vmlinux]                                                 [k] queued_spin_lock_slowpath
            |          
             --40.87%--queued_spin_lock_slowpath
                       |          
                        --40.51%--_raw_spin_lock_irqsave
                                  |          
                                  |--21.03%--enqueue_task_fair
                                  |          |          
                                  |           --20.94%--default_wake_function
                                  |                     |          
                                  |                      --20.94%--autoremove_wake_function
                                  |                                |          
                                  |                                 --20.94%--__wake_up_sync_key
                                  |                                           sock_def_readable
                                  |                                           __udp_enqueue_schedule_skb
                                  |                                           udpv6_queue_rcv_one_skb
                                  |                                           __udp6_lib_rcv
                                  |                                           ip6_input
                                  |                                           ipv6_rcv
                                  |                                           process_backlog
                                  |                                           net_rx_action
                                  |                                           |          
                                  |                                            --20.94%--__softirqentry_text_start
                                  |                                                      __local_bh_enable_ip
                                  |                                                      ip6_output
                                  |                                                      ip6_local_out
                                  |                                                      ip6_send_skb
                                  |                                                      udp_v6_send_skb
                                  |                                                      udpv6_sendmsg
                                  |                                                      __sys_sendto
                                  |                                                      __x64_sys_sendto
                                  |                                                      do_syscall_64
                                  |                                                      entry_SYSCALL_64
                                  |          
                                   --19.48%--swqueue_remove_task
                                             |          
                                              --19.47%--pick_next_task_fair
                                                        schedule
                                                        |          
                                                         --19.38%--schedule_timeout
                                                                   __skb_wait_for_more_packets
                                                                   __skb_recv_udp
                                                                   udpv6_recvmsg
                                                                   inet6_recvmsg
                                                                   __x64_sys_recvfrom
                                                                   do_syscall_64
                                                                   entry_SYSCALL_64

Thanks for the help in getting the repro on my end.

So yes, there is certainly a scalability concern to bear in mind for
swqueue for LLCs with a lot of cores. If you have a lot of tasks quickly
e.g. blocking and waking on futexes in a tight loop, I expect a similar
issue would be observed.

On the other hand, the issue did not occur on my 7950X. I also wasn't
able to repro the contention on the Skylake if I ran with the default
netperf workload rather than UDP_RR (even with the additional clients).
I didn't bother to take the mean of all of the throughput results
between NO_SWQUEUE and SWQUEUE, but they looked roughly equal.

So swqueue isn't ideal for every configuration, but I'll echo my
sentiment from [0] that this shouldn't on its own necessarily preclude
it from being merged given that it does help a large class of
configurations and workloads, and it's disabled by default.

[0]: https://lore.kernel.org/all/20230615000103.GC2883716@maniforge/

Thanks,
David
