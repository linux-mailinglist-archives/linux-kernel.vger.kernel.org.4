Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B287703413
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbjEOQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjEOQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81546AE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684169014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hemr9fYTXdjOkIhPf2RSmv1Y41p8SIi4cFyzTQq0CC4=;
        b=DzCkDD1Ds3ximGdm+JAcWFX6MdzfBvkhpkH+6+Y72TO1eftIittZjO7X+CCRWhxa1h9VDC
        xpd/mPdrfH58evEjNW8deK0An3jfuoM9QKdwEcxnsOfl4BRYDWNsAVy9zLfwzr7T3QJ8im
        SDj0/hM8kv1tSbzEKYmrr2nBvB/WE5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-PuyN2mdwMhS1bu3BzSUwQw-1; Mon, 15 May 2023 12:43:31 -0400
X-MC-Unique: PuyN2mdwMhS1bu3BzSUwQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2B97101A554;
        Mon, 15 May 2023 16:43:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DBF3140E917;
        Mon, 15 May 2023 16:43:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 May 2023 18:43:17 +0200 (CEST)
Date:   Mon, 15 May 2023 18:43:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v8] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230515164311.GC10759@redhat.com>
References: <20230515162249.709839-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515162249.709839-1-wander@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certainly I have missed something...

but,

On 05/15, Wander Lairson Costa wrote:
>
> -extern void __put_task_struct(struct task_struct *t);
> +extern void ___put_task_struct(struct task_struct *t);
> +extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);

I don't understand these renames, why can't you simply put this fix
into put_task_struct() ?

but this is minor,

> +static inline void __put_task_struct(struct task_struct *tsk)
> +{
...
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> +		call_rcu(&tsk->rcu, __put_task_struct_rcu_cb);
> +	else
> +		___put_task_struct(tsk);
> +}

did you see the emails from Peter? In particular, this one:

	https://lore.kernel.org/lkml/20230505133902.GC38236@hirez.programming.kicks-ass.net/

Oleg.

