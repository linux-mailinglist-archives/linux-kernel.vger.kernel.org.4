Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515BE6886C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjBBSjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBBSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6C979F25
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675363067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13Fcd1d4Gee3BKElvOUgZHCzkM2hbpWCpU1mCmHYLgA=;
        b=TawWOe3lViSXFIV73trUOwb/xE4q0c3IgFUDKzzMKjfuhaaFmNMuTanEEqckDm6Kr1kGZd
        V5hUJKLO4GFCoiciBsrwbQm4hruFrMvh6V0rQx2u9qUIorMCj5kXIaD8rB26ubC8n5hW4/
        bola4tYm19OZrofCWR99PjpX5qK4i7Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-w7HcwcL4MW22lDetfn-lfA-1; Thu, 02 Feb 2023 13:37:43 -0500
X-MC-Unique: w7HcwcL4MW22lDetfn-lfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 186F42A59542;
        Thu,  2 Feb 2023 18:37:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-48.brq.redhat.com [10.40.192.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id E13B1404BEC0;
        Thu,  2 Feb 2023 18:37:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Feb 2023 19:37:39 +0100 (CET)
Date:   Thu, 2 Feb 2023 19:37:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v3] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230202183735.GA17563@redhat.com>
References: <20230201124541.62104-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201124541.62104-1-wander@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01, Wander Lairson Costa wrote:
>
> Instead of calling __put_task_struct() directly, we defer it using
> call_rcu(). A more natural approach would use a workqueue, but since
> in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> the code would become more complex because we would need to put the
> work_struct instance in the task_struct and initialize it when we
> allocate a new task_struct.

I don't think I can ack the changes in PREEMPT_RT but this version LGTM.




just a couple of purely cosmetic nits, feel free to ignore...

> +static void __delayed_put_task_struct(struct rcu_head *rhp)
> +{
> +	struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> +
> +	___put_task_struct(task);
> +}

We already have delayed_put_task_struct() which differs very much.
Perhaps something like ___put_task_struct() will look less confusing.

> +void __put_task_struct(struct task_struct *tsk)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> +		/*
> +		 * under PREEMPT_RT, we can't call put_task_struct
> +		 * in atomic context because it will indirectly
> +		 * acquire sleeping locks.
> +		 */
> +		call_rcu(&tsk->rcu, __delayed_put_task_struct);

Perhaps this deserves additional note to explain why is it safe to use tsk->rcu
union. May be this is obvious, but I was confused when I looked at the previous
version ;)

but again, feel free to ignore.

Oleg.

