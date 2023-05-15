Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8F703D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbjEOS7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbjEOS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE98A176CD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684177103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+3CYqiGDk2yYqbtHSwUDrT4kehB36yZJGZI0UXY9BY=;
        b=XZOjzJra7TZESherpAMThuowPA3tN7vztQoJ2sLsdFQXII/Edt7bfbJXmO6BpMDdQ02ChL
        yLpEapB8OlzG0SFGt+VCuAAXlfGr1qL+9LgZpYy0PFRxpKXKia/ugMP2kdzvynaOE8UHk6
        AtUQqsSWCWoll/SQRsMB3t4tWBJOlEQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-cVW3bHNwN3uzu_yhCZb2Ag-1; Mon, 15 May 2023 14:58:21 -0400
X-MC-Unique: cVW3bHNwN3uzu_yhCZb2Ag-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1aae803a5eeso78949455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177101; x=1686769101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+3CYqiGDk2yYqbtHSwUDrT4kehB36yZJGZI0UXY9BY=;
        b=PNTzaT99mk4HsLSwc79050YuhHhkyhW4A4mPpVjf2AZlTahx7gHbHj9WLDlsvOXm+Z
         fwejtxWC1nDqnIn+HDjLfV9I5P+XOMKunDhstmYev5EWaHY0ttWtEY+47kOHLNZE+VDp
         1mLXCf6XcRn1i3Tu7Zgtj2nAdP47+XB5Bbbwyuh4/TecMxnZsRLsOY2mKY8GcgzSYzPL
         aX3/UpCddziv+k2ioptwEQiqVRFgBY4u+0dwqRboO+YVFuQNA6Mi5dWT1i30f3qLG2c0
         gejzHOfEJyMsXatLoOxnXljApdaPMqHVuvrAqc8L8nUlx2fz96xReDq/SyfV74qb9gbT
         ad/g==
X-Gm-Message-State: AC+VfDw97DRs/p17TDGNiHWpibBnsyXlQNlWth2lPhwLIoFDPQo4cRKe
        7Obm0vfAkI7DOe78NmblOVwHZJL9Wnn5NpRiJUX+UICQe7MFymsyW/PdIJgi38E60L27izERvR4
        Q+qRaU75YiSIprkNbGYNm+tKfieZBk9v3rdr+/uzi
X-Received: by 2002:a17:902:a503:b0:1ae:197f:dba9 with SMTP id s3-20020a170902a50300b001ae197fdba9mr5168184plq.2.1684177100871;
        Mon, 15 May 2023 11:58:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6u+qjOfTVRSUWmIDaV9Wl4XdvvycX+Xg5tbx9MkER4O5zw8FP9SeddnFBXPWXQ8n+Td+SIt5a0fczIn9w/SL8=
X-Received: by 2002:a17:902:a503:b0:1ae:197f:dba9 with SMTP id
 s3-20020a170902a50300b001ae197fdba9mr5168157plq.2.1684177100631; Mon, 15 May
 2023 11:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515162249.709839-1-wander@redhat.com> <20230515164311.GC10759@redhat.com>
 <CAAq0SUkHDf6Tnhrc5ys4rOGWtepFfdv3=d6GiA=BB7yvDUj8vw@mail.gmail.com> <20230515180851.GD10759@redhat.com>
In-Reply-To: <20230515180851.GD10759@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 15 May 2023 15:58:09 -0300
Message-ID: <CAAq0SUkrF12gQpb6Qq-P5r4eobcajF=c_oGGTeOfwVNY8rppww@mail.gmail.com>
Subject: Re: [PATCH v8] kernel/fork: beware of __put_task_struct calling context
To:     Oleg Nesterov <oleg@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 3:09=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/15, Wander Lairson Costa wrote:
> > On Mon, May 15, 2023 at 1:43=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > Certainly I have missed something...
> > >
> > > but,
> > >
> > > On 05/15, Wander Lairson Costa wrote:
> > > >
> > > > -extern void __put_task_struct(struct task_struct *t);
> > > > +extern void ___put_task_struct(struct task_struct *t);
> > > > +extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
> > >
> > > I don't understand these renames, why can't you simply put this fix
> > > into put_task_struct() ?
> > >
> >
> > No particular reason, it was just a matter of style and keep the parts =
simple.
>
> Well, to me a single/simple change in put_task_struct() makes more
> sense, but I won't argue.
>

My initial thought was to break the code in smaller functions, but
maybe just changing put_task_struct() could be better.

>         static inline void put_task_struct(struct task_struct *t)
>         {
>                 if (!refcount_dec_and_test(...))
>                         return;
>
>                 if (IS_ENABLED(PREEMPT_RT) && ...)
>                         return call_rcu(...);
>
>                 ...
>                 __put_task_struct();
>                 ...
>         }
>
> > > > +static inline void __put_task_struct(struct task_struct *tsk)
> > > > +{
> > > ...
> > > > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > > > +             call_rcu(&tsk->rcu, __put_task_struct_rcu_cb);
> > > > +     else
> > > > +             ___put_task_struct(tsk);
> > > > +}
> > >
> > > did you see the emails from Peter? In particular, this one:
> > >
> > >         https://lore.kernel.org/lkml/20230505133902.GC38236@hirez.pro=
gramming.kicks-ass.net/
> > >
> >
> > I didn't notice the lock_acquire/lock_release part. However, I tested
> > the patch with CONFIG_PROVE_RAW_LOCK_NESTING and there was no warning.
>
> Hmm. I tend to trust the Sebastian's analysis in
>
>         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
>
> I'll try to look at it later, although I hope Sebastian or Peter
> can explain this before I try ;)
>

The inability to see and reproduce the potential issue is part of my
confusion about addressing this property.

> Oleg.
>

