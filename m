Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130868C5EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBFShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265292C676
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675708612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCuB67mzgc9pVwjJxOIQ+4v3lk09ScRYOYvvx39MYw4=;
        b=Fa3Q9rZDbE0CuJPhk9XPzgosNRsLsQ7PsMMpZF8hf4Jztte/Eys9N7H9IqBRVo1hOgQ4u8
        xG4LcC3CeEze1jcqN/p8xL/q+/WR97RfboYLEoT8Z8weus19ZaQdUtlUr78MZGww4YGmZ1
        FqRYJo9FwU9P32FgaTrbDFgo0VDeAKY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-aw1451hqNEqTXJphGIMcaw-1; Mon, 06 Feb 2023 13:36:51 -0500
X-MC-Unique: aw1451hqNEqTXJphGIMcaw-1
Received: by mail-pj1-f70.google.com with SMTP id k15-20020a17090a590f00b002300fe6b09dso9107738pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCuB67mzgc9pVwjJxOIQ+4v3lk09ScRYOYvvx39MYw4=;
        b=TFKrnonkAukGciRRCREl+hih7iM73Mgvd/arnaBFOMVbZ6usp6kJkJ6zvnu2AEm7ua
         DRG/F6cuM3HP++4MNNOfjDFjnzqydcBnVnOMh+Oujqd5sALn3rxVrtOkjaStyUDqJ4WV
         yvA2iaZsPZ2l9Dvki2fkW3Comoqdtn3yV5Mze94yiXYR6RNAf6c8dfIZgcG7mqOAFyBx
         C21ST0U4MsTmcmXEuZ9X1rWUYrVpsutLR9gGwt37hLtyyeAvEaZGYd8Py0c7xXGCNY2t
         ii2gYPS/E9ZnlHJEYgi5Vm59i6gmrZPg/Pw5Kwemvh2DvvTc1dM4zriODEuSrD6o1KP4
         8Tug==
X-Gm-Message-State: AO0yUKU5JHcGSFmKfZQDZjkrDHLvMpaB0V7IxIlSUO+51k6JkTRtCaQE
        HbJf+SN+p0FAIakQtEkNg8qnWLAXZkc921ehDcisul8dC8WGIAiGvfnwciLIWCz8k7+anmK1Bqd
        vS5kGW/csYiR0P6WrZFIpeYIxOEokYNa2XcTMG3rE
X-Received: by 2002:a62:19c3:0:b0:593:fe33:fa85 with SMTP id 186-20020a6219c3000000b00593fe33fa85mr107982pfz.12.1675708610127;
        Mon, 06 Feb 2023 10:36:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+2yOxGt4J9B4pWlEpRYDYr+4xO54QSu+cHJiSakpQDkIZTr3C93GWL4tKhIgP7WiH9CEoFox0BdF4QalXmXPw=
X-Received: by 2002:a62:19c3:0:b0:593:fe33:fa85 with SMTP id
 186-20020a6219c3000000b00593fe33fa85mr107972pfz.12.1675708609847; Mon, 06 Feb
 2023 10:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20230206130449.41360-1-wander@redhat.com> <Y+EVNz4ORkFSvTfP@linutronix.de>
 <20230206152712.GA1487@redhat.com> <Y+Ek98n1xUhTP+8a@linutronix.de>
In-Reply-To: <Y+Ek98n1xUhTP+8a@linutronix.de>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 6 Feb 2023 15:36:38 -0300
Message-ID: <CAAq0SU=aaoGdSrES9ge_UF+J+fh+awg1-hYVWLMt00jPDO339w@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling context
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:04 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-02-06 16:27:12 [+0100], Oleg Nesterov wrote:
> > On 02/06, Sebastian Andrzej Siewior wrote:
> > >
> > > On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
> > >
> > > > @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk=
)
> > > =E2=80=A6
> > > > +void __put_task_struct(struct task_struct *tsk)
> > > > +{
> > > > + if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task(=
)))
> > >
> > > Is it safe to use the rcu member in any case?
> >
> > I thinks it is safe but deserves a comment. I guess Wander misunderstoo=
d
> > me when I asked him to do this...
> >
> > __put_task_struct() is called when refcount_dec_and_test(&t->usage) suc=
ceeds.
> >
> > This means that it can't "conflict" with put_task_struct_rcu_user() whi=
ch
> > abuses ->rcu the same way; rcu_users has a reference so task->usage can=
't
> > be zero after rcu_users 1 -> 0 transition.
>
> Sounds good.
>
> > > If so why not use it
> > > unconditionally?
> >
> > performance ?
>
> All the free() part is moved from the caller into rcu.
>
> >
> > And... I still don't like the name of delayed_put_task_struct_rcu() to =
me
> > ___put_task_struct_rcu() looks a bit less confusing, note that we alrea=
dy
> > have delayed_put_task_struct(). But this is minor.
>
> So if we do it unconditionally then we could get rid of
> put_task_struct_rcu_user().
> Otherwise we could use put_task_struct_rcu_user() in that timer
> callback because it will lead to lockdep warnings once printk is fixed.

put_task_struct_rcu_user() calls delayed_put_task_struct(), which does
more than just call __put_task_struct(). I tried this approach at the
beginning, but I got another splat (unfortunately, I don't remember
where).

