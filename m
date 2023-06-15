Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1F7319FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbjFONbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbjFONbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B312953
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686835838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP9co9WfWUk4ztl/ouzWok9QkNzYrfd6yzp+kWSdecc=;
        b=LYQtHUR3l5jwpqwgKhVsaXZPGX7BCqs/99juB0xcJHaUKo4coG4S8xcXFFBbLIiiQfusFJ
        PufP7oYpbK+XF6AAdlBq9vivZD56tam4vwm6yuVPUxO2dIMcZEKA+4zoByAaYRP86FVPMy
        OZBcn12VDeYp7DddyKUj5/l6kL11dug=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-YYKCW6r0Mqi6XCS-oGLDrw-1; Thu, 15 Jun 2023 09:30:36 -0400
X-MC-Unique: YYKCW6r0Mqi6XCS-oGLDrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E2B33811F41;
        Thu, 15 Jun 2023 13:30:31 +0000 (UTC)
Received: from [10.22.8.173] (unknown [10.22.8.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC3C40D1B60;
        Thu, 15 Jun 2023 13:30:31 +0000 (UTC)
Message-ID: <45660495-17b6-abac-c323-4d56fa051650@redhat.com>
Date:   Thu, 15 Jun 2023 09:30:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] locking/osq_lock: Fix false sharing of
 optimistic_spin_node in osq_lock
Content-Language: en-US
To:     Guo Hui <guohui@uniontech.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, wangxiaohua@uniontech.com
References: <20230615120152.20836-1-guohui@uniontech.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230615120152.20836-1-guohui@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 08:01, Guo Hui wrote:
> For the performance of osq_lock,
> I have made a patch before:
>
> https://lore.kernel.org/lkml/20220628161251.21950-1-guohui@uniontech.com/
>
> the analysis conclusion is due to the memory access
> of the following code caused performance degradation:
>
> cpu = node->cpu - 1;
>
> The instructions corresponding to the C code are:
> mov 0x14(%rax),%edi
> sub $0x1,%edi
>
> in the X86 operating environment,
> causing high cache-misses and degrading performance.
>
> The memory access instructions that cause performance degradation are
> further analyzed.The cache-misses of the above instructions are caused
> by a large number of cache-line false sharing
> when accessing non-local-CPU variables,as follows:
>
>           ---------------------------------
>           |   struct optimistic_spin_node |
>           ---------------------------------
>           | next | prev | locked |  cpu   |
>           ---------------------------------
>           |        cache line             |
>           ---------------------------------
>           |          CPU0                 |
>           ---------------------------------
>
> When a CPU other than CPU0 reads the value of
> optimistic_spin_node->cpu of CPU0,CPU0 frequently modifies
> the data of the cache line,which will cause false sharing
> on the currently accessing CPU,and the variable of
> the structure optimistic_spin_node type will be
> defined as a cacheline alignmented per cpu variable,
> each optimistic_spin_node variable is bound to the corresponding CPU core:
>
>      DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>
> Therefore, the value of optimistic_spin_node->cpu is usually unchanged,
> so the false sharing caused by access to optimistic_spin_node->cpu
> is caused by frequent modification of the other three attributes
> of optimistic_spin_node.
>
> There are two solutions as follows:
>
> solution 1:
> Put the cpu attribute of optimistic_spin_node into a cacheline separately.
> The patch is as follows：
>
>   struct optimistic_spin_node {
>          struct optimistic_spin_node *next, *prev;
>          int locked; /* 1 if lock acquired */
> -       int cpu; /* encoded CPU # + 1 value */
> +       int cpu ____cacheline_aligned; /* encoded CPU # + 1 value */
>   };
>
> Unixbench full-core performance data is as follows:
> Machine: Hygon X86, 128 cores
>                                      with patch   without patch  promote
> Dhrystone 2 using register variables   194923.07    195091      -0.09%
> Double-Precision Whetstone             79885.47     79838.87    +0.06%
> Execl Throughput                       2327.17      2272.1      +2.42%
> File Copy 1024 bufsize 2000 maxblocks  742.1        687.53      +7.94%
> File Copy 256 bufsize 500 maxblocks    462.73       428.03      +8.11%
> File Copy 4096 bufsize 8000 maxblocks  1600.37      1520.53     +5.25%
> Pipe Throughput                        79815.33     79522.13    +0.37%
> Pipe-based Context Switching           28962.9      27987.8     +3.48%
> Process Creation                       3084.4       2999.1      +2.84%
> Shell Scripts 1 concurrent             11687.1      11394.67    +2.57%
> Shell Scripts 8 concurrent             10787.1      10496.17    +2.77%
> System Call Overhead                   4322.77      4322.23     +0.01%
> System Benchmarks Index Score          8079.4       7848.37     +3.0%
>
> solution 2:
> The core idea of osq lock is that
> the lock applicant spins on the local-CPU variable
> to eliminate cache-line bouncing.Therefore,
> the same method is used for the above degradation.
> For the optimistic_spin_node of the current CPU,
> the cpu attribute of its predecessor optimistic_spin_node is
> non-local-CPU variables,the cpu attribute of
> the predecessor optimistic_spin_node is cached
> in the optimistic_spin_node of the current CPU
> to eliminate performance degradation
> caused by non-local-CPU variable access, as follows:
>
>          bool osq_lock(struct optimistic_spin_queue *lock)
>          {
>                  [... ...]
>
>                  node->prev = prev;
>                  node->prev_cpu = prev->cpu; --------------- A
>
>                  [... ...]
>
>                  WRITE_ONCE(next->prev, prev);
>                  WRITE_ONCE(prev->next, next);
>                  WRITE_ONCE(next->prev_cpu, prev->cpu); -------------- B
>
>                  [... ...]
>          }
>
>          static inline int node_cpu(struct optimistic_spin_node *node)
>          {
>                  return node->prev_cpu - 1; ----------------------------- C
>          }
>
> While setting the prev attribute of the optimistic_spin_node of
> the current CPU,the current patch also caches the prev cpu attribute
> in the prev_cpu attribute of the optimistic_spin_node of the current CPU,
> as in the above code lines A and B,where node is a per cpu variable,
> so each one node corresponds to a CPU core,and the cpu attribute of
> the node corresponding to the CPU core will not change.
> Only when the prev attribute of the node is set,
> the prev_cpu of the node may change with the change of prev.
> At other times, the prev attribute of the node will not change.
> so the prev_cpu of node will not change.
> This patch greatly reduces the non-local-CPU variable
> access at code line C and improves performance.
>
> Unixbench full-core performance data is as follows:
> Machine: Hygon X86, 128 cores
>                                      with patch   without patch   promote
> Dhrystone 2 using register variables  194818.7     195091        -0.14%
> Double-Precision Whetstone            79847.57     79838.87      +0.01%
> Execl Throughput                      2372.83      2272.1        +4.43%
> File Copy 1024 bufsize 2000 maxblocks 765          687.53        +11.27%
> File Copy 256 bufsize 500 maxblocks   472.13       428.03        +10.30%
> File Copy 4096 bufsize 8000 maxblocks 1658.13      1520.53       +9.05%
> Pipe Throughput                       79634.17     79522.13      +0.14%
> Pipe-based Context Switching          28584.7      27987.8       +2.13%
> Process Creation                      3020.27      2999.1        +0.71%
> Shell Scripts 1 concurrent            11890.87     11394.67      +4.35%
> Shell Scripts 8 concurrent            10912.9      10496.17      +3.97%
> System Call Overhead                  4320.63      4322.23       -0.04%
> System Benchmarks Index Score         8144.43      7848.37       +4.0%
>
> In summary, the performance of solution 2 is better than solution 1.
> Especially use cases: execl, file copy, shell1, shell8,
> great improvement,because solution 1 still has the possibility of
> remote memory access across NUMA nodes,
> and solution 2 completely accesses local-CPU variables,
> so solution 2 is better than solution 1.
>
> Both solutions also have a great improvement in the X86 virtual machine.
>
> The current patch also uses solution 2.
>
> Signed-off-by: Guo Hui <guohui@uniontech.com>
> ---
>   include/linux/osq_lock.h  | 1 +
>   kernel/locking/osq_lock.c | 8 +++++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index 5581dbd3bd34..8a1bb36f4a07 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -10,6 +10,7 @@ struct optimistic_spin_node {
>   	struct optimistic_spin_node *next, *prev;
>   	int locked; /* 1 if lock acquired */
>   	int cpu; /* encoded CPU # + 1 value */
> +	int prev_cpu; /* Only for optimizing false sharing */
>   };
>   
>   struct optimistic_spin_queue {
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52b92..ea1fdd10ab3e 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -22,9 +22,9 @@ static inline int encode_cpu(int cpu_nr)
>   	return cpu_nr + 1;
>   }
>   
> -static inline int node_cpu(struct optimistic_spin_node *node)
> +static inline int node_prev_cpu(struct optimistic_spin_node *node)
>   {
> -	return node->cpu - 1;
> +	return READ_ONCE(node->prev_cpu) - 1;
>   }
>   
>   static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
> @@ -110,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   
>   	prev = decode_cpu(old);
>   	node->prev = prev;
> +	node->prev_cpu = prev->cpu;
>   
>   	/*
>   	 * osq_lock()			unqueue
> @@ -141,7 +142,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * polling, be careful.
>   	 */
>   	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
> -				  vcpu_is_preempted(node_cpu(node->prev))))
> +				  vcpu_is_preempted(node_prev_cpu(node))))
>   		return true;
>   
>   	/* unqueue */
> @@ -200,6 +201,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   
>   	WRITE_ONCE(next->prev, prev);
>   	WRITE_ONCE(prev->next, next);
> +	WRITE_ONCE(next->prev_cpu, prev->cpu);
>   
>   	return false;
>   }

After a further look, I have one more comment.

First of all prev->next is NULL at this point. If you look at the 
beginning of osq_lock:

node->prev = prev;
smp_wmb();
WRITE_ONCE(prev->next, node);

To maintain the same memory ordering relationship, you may do

WRITE_ONCE(next->prev, prev);
WRITE_ONCE(next->prev_cpu, prev->cpu);
smp_wmb();
WRITE_ONCE(prev->next, next);

That should avoid the corner case that the next CPU is fetching the 
wrong prev_cpu when it try to dequeue itself concurrently. 
Alternatively, we can even remove prev from node since we can easily 
compute prev from prev_cpu using decode_cpu(). That will eliminate 
potential inconsistency between prev and prev_cpu.

Cheers,
Longman



