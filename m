Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF571F1DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjFASYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFASYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3DE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685643826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5dSayMLOZ2SWfW3EHSyHTiLOVAvqWyyk7XNs5jXd68=;
        b=N0BEVuLnX0JrmHtTslII+F5JakSfu24+x9yn5u9F0IvG7bYRRLkxoz/kTzKxR7awY3txMh
        Ni0zCGUGwo3XMdQwAQILtB+PhMEf8pZk+PCFjvLsGAjO6rbg35VkReSc1qQFd8Jdd8VMiM
        dP90yPenfBo8KZnRrD0XNS5uYgCLag4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137--2GlbbB-NmOLrAxRIV2nlg-1; Thu, 01 Jun 2023 14:23:45 -0400
X-MC-Unique: -2GlbbB-NmOLrAxRIV2nlg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53f44c2566dso510957a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 11:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643824; x=1688235824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5dSayMLOZ2SWfW3EHSyHTiLOVAvqWyyk7XNs5jXd68=;
        b=MiSmd2uJTMBh+L6OsKBc/FqVZ4Bx/YGlWabuO1AHyeIZxKxnB10RUjqGTc5HcSu1dg
         3q4yI2GCpKL/i/p1212RPInNWrR8Co3tpJTy4lN/otTF6VKAU/j7NkuBxnLJ856lss09
         q8NfSHffMvFr8Ee7DPGnG+xguJ+89cE9KsPEp/aKEUTnJIv7Bu7x1YQVMxiyLQY3eQoj
         gD+cOSMS6HhGl2/n6Sc7MJZEygtgLFdhphFjttXeK0HZkDSb6dh6Y+sIL9AHBHdU1WOG
         25MP0W9qLzWrhDxGJcZf3mJHWQ0XTBM0so4y3w1+AJDVuHNW2t9jjgJx/HBmNqn6tQN9
         GBDw==
X-Gm-Message-State: AC+VfDz/YvBAKeYQF+JeK59i0DiAd/93vWMzjsFTEdBC5Qe8naOpVzy4
        e/yv4BLXD6Rr5mrPCscxeNP6e7aVGFdKpTvSW5yZ9X4RDhleZpTkpKhiFNdqQu1hNA0t1hD9qBf
        dD3lTG+TcC5v0TBfIhOiH2w2rDfA+4LYKVBuVQjLI
X-Received: by 2002:a17:90a:3b0b:b0:256:4246:d94d with SMTP id d11-20020a17090a3b0b00b002564246d94dmr225484pjc.3.1685643823891;
        Thu, 01 Jun 2023 11:23:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/P/aqzJFuq1pKBUF3hORL/29piNX52KVVyKOvTqT0bWfuR9VoCUaNziMqfIGhUYmNVO31gifuBmh2ec2e/cI=
X-Received: by 2002:a17:90a:3b0b:b0:256:4246:d94d with SMTP id
 d11-20020a17090a3b0b00b002564246d94dmr225462pjc.3.1685643823561; Thu, 01 Jun
 2023 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230516191441.34377-1-wander@redhat.com> <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
 <20230529122256.GA588@redhat.com> <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
 <20230601181359.GA23852@redhat.com>
In-Reply-To: <20230601181359.GA23852@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 1 Jun 2023 15:23:32 -0300
Message-ID: <CAAq0SUk3c5H8YCVAfRAU=pZFNLrA90mNMq=k5BohTutM7cfcvg@mail.gmail.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling context
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 3:14=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 06/01, Wander Lairson Costa wrote:
> >
> > On Mon, May 29, 2023 at 9:23=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 05/17, Wander Lairson Costa wrote:
> > > >
> > > > On Wed, May 17, 2023 at 12:26=E2=80=AFPM Oleg Nesterov <oleg@redhat=
.com> wrote:
> > > > >
> > > > > LGTM but we still need to understand the possible problems with C=
ONFIG_PROVE_RAW_LOCK_NESTING ...
> > > > >
> > > > > Again, I'll try to investigate when I have time although I am not=
 sure I can really help.
> > > > >
> > > > > Perhaps you too can try to do this ? ;)
> > > > >
> > > >
> > > > FWIW, I tested this patch with CONFIG_PROVE_LOCK_NESTING in RT and
> > > > stock kernels. No splat happened.
> > >
> > > Strange... FYI, I am running the kernel with this patch
> > >
> > >         diff --git a/kernel/sys.c b/kernel/sys.c
> > >         index 339fee3eff6a..3169cceddf3b 100644
> > >         --- a/kernel/sys.c
> > >         +++ b/kernel/sys.c
> > >         @@ -2412,6 +2412,17 @@ SYSCALL_DEFINE5(prctl, int, option, un=
signed long, arg2, unsigned long, arg3,
> > >
> > >                 error =3D 0;
> > >                 switch (option) {
> > >         +       case 666: {
> > >         +               static DEFINE_SPINLOCK(l);
> > >         +               static DEFINE_RAW_SPINLOCK(r);
> > >         +
> > >         +               raw_spin_lock(&r);
> > >         +               spin_lock(&l);
> > >         +               spin_unlock(&l);
> > >         +               raw_spin_unlock(&r);
> > >         +
> > >         +               break;
> > >         +       }
> > >                 case PR_SET_PDEATHSIG:
> > >                         if (!valid_signal(arg2)) {
> > >                                 error =3D -EINVAL;
> > >
> > > applied (because I am too lazy to compile a module ;) and
> > >
> >
> > FWIW, I converted it to a module [1]
>
> where is [1] ?  not that I think this matters though...
>
> > >         # perl -e 'syscall 157,666'
> > >
> > > triggers the lockdep bug
> > >
> > >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >         [ BUG: Invalid wait context ]
> > >         6.4.0-rc2-00018-g4d6d4c7f541d-dirty #1176 Not tainted
> > >         -----------------------------
> > >         perl/35 is trying to lock:
> > >         ffffffff81c4cc18 (l){....}-{3:3}, at: __do_sys_prctl+0x21b/0x=
87b
> > >         other info that might help us debug this:
> > >         context-{5:5}
> > >         ...
> > >
> > > as expected.
> > >
> >
> > Yeah, I tried it here and I had the same results,
>
> OK,
>
> > but only in the RT kernel
>
> this again suggests that your testing was wrong or I am totally confused =
(quite
> possible, I know nothing about RT). I did the testing without CONFIG_PREE=
MPT_RT.
>

Hrm, could you please share your .config?

> > But running the reproducer for put_task_struct(), works fine.
>
> which reproducer ?
>

Only now I noticed I didn't add the reproducer to the commit message:

while true; do
    stress-ng --sched deadline --sched-period 1000000000
--sched-runtime 800000000 --sched-deadline 1000000000 --mmapfork 23 -t
20
done

