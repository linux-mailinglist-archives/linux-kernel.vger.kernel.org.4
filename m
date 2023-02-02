Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732E6887DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBBT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9E7B43B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675367748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/JM9kJaVGtFzg6Ri4FZyLnb2Sk0vyezm9m9AuJEgs8=;
        b=WSdO0GCpYHtRRYexu3NKs3AaTeQFIt9W+T+d1cY+TxPRZxAmV8s9cd2BFUOt2fhQimE9AN
        0BiPI4ly2H3yyaVJmOmnC0mJhcac2Gcto+qFqtK5lOOIfWllzvupAXpGGt3bAF0KdVY0st
        WoK9aVbn+jxPwvsqm7sLprzyYJnC9Fk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-wlw0G_lIOXmnxg-oKC58Lw-1; Thu, 02 Feb 2023 14:55:47 -0500
X-MC-Unique: wlw0G_lIOXmnxg-oKC58Lw-1
Received: by mail-pf1-f197.google.com with SMTP id n34-20020a056a000d6200b005912ead88aeso1463480pfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/JM9kJaVGtFzg6Ri4FZyLnb2Sk0vyezm9m9AuJEgs8=;
        b=j1g72MtuCAOZfJd6P2xnHk5BrInEBI01E8e3xFBoAJbyp3ZQFXLhBzlInywAo6Rer5
         lM6tsO6DN+OeF3N3MdLppp4crwy4eTKtusTpnniizWejjkfh7L1rxz8Sy3Tl58fdrfdJ
         jrGUJrWFoeArNrBOqpd9SH7nMFcM026D+X0wTC0buMv1PNr0lf63mwxN/J+uFtDH/jpl
         J27aXGBNxEXjNMcwta1zSM1fazOx570QNP/ipjUaxw3yVCgMEF0NveMn22z4780rW/Mx
         QeoLSP/Aj14R3tb/ZrQZ4xbKnGwroshTho7xfDb7DO7MWM3UCkLPrnkv4WXakwB7VmkF
         RGXA==
X-Gm-Message-State: AO0yUKUvit6QCA9Viq3Bqpat1nmoKDPiBJ6ZQ9NxOXRRjWaOQOB3qrL3
        xarRqaDLtXOijilNWwGrOgLHuH94BKeFMWEeSRKIHgASnHcaplUTfDWo9KlAepD+GLSL70U+/Ln
        Ula7w1EVcSp29vsT+ReiFPLI6JGd8Z44gGYJRG4aa
X-Received: by 2002:a62:1d11:0:b0:593:d1b9:2962 with SMTP id d17-20020a621d11000000b00593d1b92962mr1572027pfd.45.1675367746026;
        Thu, 02 Feb 2023 11:55:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8ini/hVuBx1+o+8wNLYa1wuDaQg0HJE1K63a64m4cJswUvdlm6vvHBTDa9GiTFF9j4xKnDJxzk+hgU9oyQxgU=
X-Received: by 2002:a62:1d11:0:b0:593:d1b9:2962 with SMTP id
 d17-20020a621d11000000b00593d1b92962mr1572019pfd.45.1675367745649; Thu, 02
 Feb 2023 11:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20230201124541.62104-1-wander@redhat.com> <20230202183735.GA17563@redhat.com>
In-Reply-To: <20230202183735.GA17563@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 2 Feb 2023 16:55:34 -0300
Message-ID: <CAAq0SUmYbpTnVBe+FEn+wQjLsfaAv-uxP0QuNEpSh8iaxAD+1g@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/fork: beware of __put_task_struct calling context
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:37 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/01, Wander Lairson Costa wrote:
> >
> > Instead of calling __put_task_struct() directly, we defer it using
> > call_rcu(). A more natural approach would use a workqueue, but since
> > in PREEMPT_RT, we can't allocate dynamic memory from atomic context,
> > the code would become more complex because we would need to put the
> > work_struct instance in the task_struct and initialize it when we
> > allocate a new task_struct.
>
> I don't think I can ack the changes in PREEMPT_RT but this version LGTM.
>
>
>
>
> just a couple of purely cosmetic nits, feel free to ignore...
>
> > +static void __delayed_put_task_struct(struct rcu_head *rhp)
> > +{
> > +     struct task_struct *task = container_of(rhp, struct task_struct, rcu);
> > +
> > +     ___put_task_struct(task);
> > +}
>
> We already have delayed_put_task_struct() which differs very much.
> Perhaps something like ___put_task_struct() will look less confusing.
>

___put_task_struct()? I already added a function with this name below.

> > +void __put_task_struct(struct task_struct *tsk)
> > +{
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))
> > +             /*
> > +              * under PREEMPT_RT, we can't call put_task_struct
> > +              * in atomic context because it will indirectly
> > +              * acquire sleeping locks.
> > +              */
> > +             call_rcu(&tsk->rcu, __delayed_put_task_struct);
>
> Perhaps this deserves additional note to explain why is it safe to use tsk->rcu
> union. May be this is obvious, but I was confused when I looked at the previous
> version ;)
>

Makes sense, I will add it in the next version.

> but again, feel free to ignore.
>
> Oleg.
>

