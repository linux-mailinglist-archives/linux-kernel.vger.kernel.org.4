Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27A678177
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjAWQbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0264265BF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674491418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4WFf0qCjoISjlbl9oDJUT+rYiaHBgzm+Nne34laQe4=;
        b=Og1MInjk0PHZMwjERiJmR9v4eUmuTzjjNtxgLQ5khxeErNrc2az+uqQXwv4cSnp25ZUpXA
        C7H0ArvSMCjiJvnz0jcoAGKNviV/gUTmvIODmytn8IbV4BpQXGjoRBXyA0T8Ldp1EqPSzx
        kR/G6MRUokGlMrHVtN+zh7DijUJpCEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-aSyTRqDuNSmd_Tw2901ykQ-1; Mon, 23 Jan 2023 11:30:13 -0500
X-MC-Unique: aSyTRqDuNSmd_Tw2901ykQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA7CC857A85;
        Mon, 23 Jan 2023 16:30:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-224.brq.redhat.com [10.40.192.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91C201121333;
        Mon, 23 Jan 2023 16:30:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Jan 2023 17:30:09 +0100 (CET)
Date:   Mon, 23 Jan 2023 17:30:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Message-ID: <20230123163002.GB6268@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120150246.20797-2-wander@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20, Wander Lairson Costa wrote:
>
> +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		/*
> +		 * Decrement the refcount explicitly to avoid unnecessarily
> +		 * calling call_rcu.
> +		 */
> +		if (refcount_dec_and_test(&task->usage))
> +			/*
> +			 * under PREEMPT_RT, we can't call put_task_struct
> +			 * in atomic context because it will indirectly
> +			 * acquire sleeping locks.
> +			 */
> +			call_rcu(&task->rcu, __delayed_put_task_struct);
                                  ^^^^^^^^^
I am not sure the usage of task->rcu is safe...

Suppose that, before __delayed_put_task_struct() is called by RCU, this task
does the last schedule and calls put_task_struct_rcu_user().

And, can't we simply turn put_task_struct() into something like

	put_task_struct(struct task_struct *t)
	{
		if (refcount_dec_and_test(&t->usage)) {
			if (IS_ENABLED(CONFIG_PREEMPT_RT)
			    && (in_atomic() || irqs_disabled()))
				call_rcu(...);
			else
				__put_task_struct(t);
		}
	}

?

Oleg.

