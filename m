Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77DB703C32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbjEOSOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbjEOSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED2225A4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684174153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtZtSSbwWjXLXKy/6LQdhCrrwRELJrN07bazT1pYPAc=;
        b=eXXNX+hev1jpK1t7ErGihwI7up/v9darH60WzHAgT8cX4u/gDV3vaNJ9IRRP5SIjbvFjJQ
        cAizzKrLEmcXuDzyIm/nXj1dBK8V0xxnSaFWLJ/eQ1BNnnnO6bJq/FN56UmRHJe/IAVjg0
        ALORCFvzS+woeFB1InUuwTxK3+V4h9I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-y5vLRCE1NyywcTxvRONQ0Q-1; Mon, 15 May 2023 14:09:12 -0400
X-MC-Unique: y5vLRCE1NyywcTxvRONQ0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34850380665F;
        Mon, 15 May 2023 18:09:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id CCB3235453;
        Mon, 15 May 2023 18:09:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 May 2023 20:08:57 +0200 (CEST)
Date:   Mon, 15 May 2023 20:08:52 +0200
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
Message-ID: <20230515180851.GD10759@redhat.com>
References: <20230515162249.709839-1-wander@redhat.com>
 <20230515164311.GC10759@redhat.com>
 <CAAq0SUkHDf6Tnhrc5ys4rOGWtepFfdv3=d6GiA=BB7yvDUj8vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUkHDf6Tnhrc5ys4rOGWtepFfdv3=d6GiA=BB7yvDUj8vw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Wander Lairson Costa wrote:
> On Mon, May 15, 2023 at 1:43 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Certainly I have missed something...
> >
> > but,
> >
> > On 05/15, Wander Lairson Costa wrote:
> > >
> > > -extern void __put_task_struct(struct task_struct *t);
> > > +extern void ___put_task_struct(struct task_struct *t);
> > > +extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
> >
> > I don't understand these renames, why can't you simply put this fix
> > into put_task_struct() ?
> >
>
> No particular reason, it was just a matter of style and keep the parts simple.

Well, to me a single/simple change in put_task_struct() makes more
sense, but I won't argue.

	static inline void put_task_struct(struct task_struct *t)
	{
		if (!refcount_dec_and_test(...))
			return;

		if (IS_ENABLED(PREEMPT_RT) && ...)
			return call_rcu(...);

		...
		__put_task_struct();
		...
	}

> > > +static inline void __put_task_struct(struct task_struct *tsk)
> > > +{
> > ...
> > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > > +             call_rcu(&tsk->rcu, __put_task_struct_rcu_cb);
> > > +     else
> > > +             ___put_task_struct(tsk);
> > > +}
> >
> > did you see the emails from Peter? In particular, this one:
> >
> >         https://lore.kernel.org/lkml/20230505133902.GC38236@hirez.programming.kicks-ass.net/
> >
>
> I didn't notice the lock_acquire/lock_release part. However, I tested
> the patch with CONFIG_PROVE_RAW_LOCK_NESTING and there was no warning.

Hmm. I tend to trust the Sebastian's analysis in

	https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/

I'll try to look at it later, although I hope Sebastian or Peter
can explain this before I try ;)

Oleg.

