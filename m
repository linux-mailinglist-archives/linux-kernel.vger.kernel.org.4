Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73239706CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjEQP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjEQP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350F93E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684337222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6yIWaNodP/2hACRWZBkL2KKzTbaV+Om3pS8ElADryp8=;
        b=hfdCltSI0IrmAu4quEkttKA2aG9RggJ57s1WlgAgvFSxHrrHqnkWBIPNThbmpbhswPXAv/
        yMs9rbAW0vVeoBpS4+hOTOA6fIgUHX5VZKkYtQi3HTOBVZT3+y+Jv0EAoqvR2vz8ry48vX
        s0WzzpRFmaT6f57bySUDLCwnYccDD2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-BNxCk8mcM_-0Xo9yAx7G3g-1; Wed, 17 May 2023 11:26:58 -0400
X-MC-Unique: BNxCk8mcM_-0Xo9yAx7G3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE6F86C611;
        Wed, 17 May 2023 15:26:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5EF5BC16024;
        Wed, 17 May 2023 15:26:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 May 2023 17:26:39 +0200 (CEST)
Date:   Wed, 17 May 2023 17:26:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230517152632.GC1286@redhat.com>
References: <20230516191441.34377-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516191441.34377-1-wander@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16, Wander Lairson Costa wrote:
>
>  static inline void put_task_struct(struct task_struct *t)
>  {
> -	if (refcount_dec_and_test(&t->usage))
> +	if (!refcount_dec_and_test(&t->usage))
> +		return;
> +
> +	/*
> +	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * in atomic context because it will indirectly
> +	 * acquire sleeping locks.
> +	 *
> +	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * to be called in process context.
> +	 *
> +	 * __put_task_struct() is called when
> +	 * refcount_dec_and_test(&t->usage) succeeds.
> +	 *
> +	 * This means that it can't "conflict" with
> +	 * put_task_struct_rcu_user() which abuses ->rcu the same
> +	 * way; rcu_users has a reference so task->usage can't be
> +	 * zero after rcu_users 1 -> 0 transition.
> +	 *
> +	 * delayed_free_task() also uses ->rcu, but it is only called
> +	 * when it fails to fork a process. Therefore, there is no
> +	 * way it can conflict with put_task_struct().
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> +		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
> +	else
>  		__put_task_struct(t);
>  }

LGTM but we still need to understand the possible problems with CONFIG_PROVE_RAW_LOCK_NESTING ...

Again, I'll try to investigate when I have time although I am not sure I can really help.

Perhaps you too can try to do this ? ;)

Oleg.

