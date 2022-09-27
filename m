Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30995EC7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiI0P21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiI0P2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D11B525E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664292497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxgwwm25os2+wxSm5hwPfEX8XjQEE+YfNWB+GqPQdaY=;
        b=PBXNrO7mzgD4HvQuMaI8aRB4Sf1rXhpmpttl5qqaKxFCzVe3xwNoPHne9MoHNviZSg1jHM
        CZe8mwqrUjPCcyeoSGxP8xVCEQgijK/NVCSkHpbbHNFx+Us598EdtKeKDwz204g7O5UVuL
        wPgLvX3DsYWTH02SaQ+oNcu5h9MA8Qg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-wLGm3zcTM7-1g-y7NaUIlw-1; Tue, 27 Sep 2022 11:28:14 -0400
X-MC-Unique: wLGm3zcTM7-1g-y7NaUIlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17006299E76C;
        Tue, 27 Sep 2022 15:28:14 +0000 (UTC)
Received: from [10.22.9.237] (unknown [10.22.9.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C23D4C15BA4;
        Tue, 27 Sep 2022 15:28:13 +0000 (UTC)
Message-ID: <9c798af6-aa2c-5f76-7a50-ef1983f9bdcd@redhat.com>
Date:   Tue, 27 Sep 2022 11:28:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Resend PATCH v2] tracing: Disable interrupt or preemption before
 acquiring arch_spinlock_t
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220922133158.1731333-1-longman@redhat.com>
 <20220922145622.1744826-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220922145622.1744826-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 10:56, Waiman Long wrote:
> It was found that some tracing functions in kernel/trace/trace.c acquire
> an arch_spinlock_t with preemption and irqs enabled. An example is the
> tracing_saved_cmdlines_size_read() function which intermittently causes
> a "BUG: using smp_processor_id() in preemptible" warning when the LTP
> read_all_proc test is run.
>
> That can be problematic in case preemption happens after acquiring the
> lock. Add the necessary preemption or interrupt disabling code in the
> appropriate places before acquiring an arch_spinlock_t.
>
> The convention here is to disable preemption for trace_cmdline_lock and
> interupt for max_lock.
>
> Fixes: a35873a0993b ("tracing: Add conditional snapshot")
> Fixes: 939c7a4f04fc ("tracing: Introduce saved_cmdlines_size file")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/trace/trace.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Ping!

Any comment on this patch?

Thanks,
Longman

>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d3005279165d..aed7ea6e6045 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1193,12 +1193,14 @@ void *tracing_cond_snapshot_data(struct trace_array *tr)
>   {
>   	void *cond_data = NULL;
>   
> +	local_irq_disable();
>   	arch_spin_lock(&tr->max_lock);
>   
>   	if (tr->cond_snapshot)
>   		cond_data = tr->cond_snapshot->cond_data;
>   
>   	arch_spin_unlock(&tr->max_lock);
> +	local_irq_enable();
>   
>   	return cond_data;
>   }
> @@ -1334,9 +1336,11 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
>   		goto fail_unlock;
>   	}
>   
> +	local_irq_disable();
>   	arch_spin_lock(&tr->max_lock);
>   	tr->cond_snapshot = cond_snapshot;
>   	arch_spin_unlock(&tr->max_lock);
> +	local_irq_enable();
>   
>   	mutex_unlock(&trace_types_lock);
>   
> @@ -1363,6 +1367,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
>   {
>   	int ret = 0;
>   
> +	local_irq_disable();
>   	arch_spin_lock(&tr->max_lock);
>   
>   	if (!tr->cond_snapshot)
> @@ -1373,6 +1378,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
>   	}
>   
>   	arch_spin_unlock(&tr->max_lock);
> +	local_irq_enable();
>   
>   	return ret;
>   }
> @@ -2200,6 +2206,11 @@ static size_t tgid_map_max;
>   
>   #define SAVED_CMDLINES_DEFAULT 128
>   #define NO_CMDLINE_MAP UINT_MAX
> +/*
> + * Preemption must be disabled before acquiring trace_cmdline_lock.
> + * The various trace_arrays' max_lock must be acquired in a context
> + * where interrupt is disabled.
> + */
>   static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
>   struct saved_cmdlines_buffer {
>   	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
> @@ -2412,7 +2423,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
>   	 * the lock, but we also don't want to spin
>   	 * nor do we want to disable interrupts,
>   	 * so if we miss here, then better luck next time.
> +	 *
> +	 * This is called within the scheduler and wake up, so interrupts
> +	 * had better been disabled and run queue lock been held.
>   	 */
> +	lockdep_assert_preemption_disabled();
>   	if (!arch_spin_trylock(&trace_cmdline_lock))
>   		return 0;
>   
> @@ -5890,9 +5905,11 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
>   	char buf[64];
>   	int r;
>   
> +	preempt_disable();
>   	arch_spin_lock(&trace_cmdline_lock);
>   	r = scnprintf(buf, sizeof(buf), "%u\n", savedcmd->cmdline_num);
>   	arch_spin_unlock(&trace_cmdline_lock);
> +	preempt_enable();
>   
>   	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>   }
> @@ -5917,10 +5934,12 @@ static int tracing_resize_saved_cmdlines(unsigned int val)
>   		return -ENOMEM;
>   	}
>   
> +	preempt_disable();
>   	arch_spin_lock(&trace_cmdline_lock);
>   	savedcmd_temp = savedcmd;
>   	savedcmd = s;
>   	arch_spin_unlock(&trace_cmdline_lock);
> +	preempt_enable();
>   	free_saved_cmdlines_buffer(savedcmd_temp);
>   
>   	return 0;
> @@ -6373,10 +6392,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>   
>   #ifdef CONFIG_TRACER_SNAPSHOT
>   	if (t->use_max_tr) {
> +		local_irq_disable();
>   		arch_spin_lock(&tr->max_lock);
>   		if (tr->cond_snapshot)
>   			ret = -EBUSY;
>   		arch_spin_unlock(&tr->max_lock);
> +		local_irq_enable();
>   		if (ret)
>   			goto out;
>   	}
> @@ -7436,10 +7457,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>   		goto out;
>   	}
>   
> +	local_irq_disable();
>   	arch_spin_lock(&tr->max_lock);
>   	if (tr->cond_snapshot)
>   		ret = -EBUSY;
>   	arch_spin_unlock(&tr->max_lock);
> +	local_irq_enable();
>   	if (ret)
>   		goto out;
>   

