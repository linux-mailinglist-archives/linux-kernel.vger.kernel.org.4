Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9196A703715
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbjEORQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbjEORQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F462DD90
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684170866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCaTfWW2xhs0hSSPB8jrlZj4mSv/ZzFytK9nmt5nLIs=;
        b=d8rUvXeTle2d6k9qbnYXCq6P0YDe9uYtUzWhBA9VwocR0bhds10Q56+OmeqPVfFbzsm2ok
        6y+H5ltepPRcDyqCLsaP0XQp7ZRwAzWcNs+pU/AXZlRMnGJAfZvmuvd6/jd6zE5lm2YsmU
        5XDYeRYgQCPsvYWmMbRLw6DrdwE9Vps=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-8KveY445OOqQ9nykPLmfZA-1; Mon, 15 May 2023 13:14:25 -0400
X-MC-Unique: 8KveY445OOqQ9nykPLmfZA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64380c45e84so13461796b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684170864; x=1686762864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCaTfWW2xhs0hSSPB8jrlZj4mSv/ZzFytK9nmt5nLIs=;
        b=SG+72ZHrwMLCb4IoEelm3WmKQ35hD5AnVLVUzwtEwL9a6QmtbdB2xj2iifIfqUdTlb
         6TocvhjpQYEODx+cuqvhzpkwF86T2n25ZLVO1b1UkoB3VGGi5aTAzylZg6OpipS74orz
         xqbFApMJyVZmotmOoxn0KCa63UwAJrDUWwY5hDgUjdShojBrxIdcHxS/zw6phxbgsHbx
         XAOBHgymI3xOvYhQYemA8DeKO5oJGYMLZ2+VwzT0qYP+E5oH8qqXk34I6F+WxwZYxyAA
         l/SmUSy4Hvl39uisJUkAiqbsTS8WxVAlJsC/d9Y4fd6PgN2/H7WE7jYTmo4mSh/D9Bmb
         eo6Q==
X-Gm-Message-State: AC+VfDwTTr0rRkdNl4DW2ZvE9lf7hdWP9qmPUYO+PquYAjpJ+1DP2ttu
        J8DV5dcvj/zw3OvmjjsP27JUKqlX4sFnXR9HDa3MpczPE86hS/JN6pB+rVHsvmIC4vfF/29HkOM
        zsCBWv0GXkNUCinoXq0RmdVGFZ5ZQrTca1ma1nj7I9iujXwu0eTDFEg==
X-Received: by 2002:a05:6a21:7891:b0:101:209e:bc57 with SMTP id bf17-20020a056a21789100b00101209ebc57mr30261049pzc.50.1684170863918;
        Mon, 15 May 2023 10:14:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IS70g9H5r0kfY7dvdN6bvF/ev82UDRxMNiH4L3LfFtIumzt74jnJY+HBrTRGNaHENki2e1qrOSQdCf2JRmjg=
X-Received: by 2002:a05:6a21:7891:b0:101:209e:bc57 with SMTP id
 bf17-20020a056a21789100b00101209ebc57mr30261019pzc.50.1684170863606; Mon, 15
 May 2023 10:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230515162249.709839-1-wander@redhat.com> <20230515164311.GC10759@redhat.com>
In-Reply-To: <20230515164311.GC10759@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 15 May 2023 14:14:12 -0300
Message-ID: <CAAq0SUkHDf6Tnhrc5ys4rOGWtepFfdv3=d6GiA=BB7yvDUj8vw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 1:43=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Certainly I have missed something...
>
> but,
>
> On 05/15, Wander Lairson Costa wrote:
> >
> > -extern void __put_task_struct(struct task_struct *t);
> > +extern void ___put_task_struct(struct task_struct *t);
> > +extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
>
> I don't understand these renames, why can't you simply put this fix
> into put_task_struct() ?
>

No particular reason, it was just a matter of style and keep the parts simp=
le.

> but this is minor,
>
> > +static inline void __put_task_struct(struct task_struct *tsk)
> > +{
> ...
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > +             call_rcu(&tsk->rcu, __put_task_struct_rcu_cb);
> > +     else
> > +             ___put_task_struct(tsk);
> > +}
>
> did you see the emails from Peter? In particular, this one:
>
>         https://lore.kernel.org/lkml/20230505133902.GC38236@hirez.program=
ming.kicks-ass.net/
>

I didn't notice the lock_acquire/lock_release part. However, I tested
the patch with CONFIG_PROVE_RAW_LOCK_NESTING and there was no warning.

> Oleg.
>

