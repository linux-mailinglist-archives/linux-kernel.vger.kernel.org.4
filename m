Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A371F116
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjFARq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFARqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFB189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685641567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqnaudmEV/Hbvq9piHmTal6ZUl67zTDEn82unVMjFsg=;
        b=Qz0UtvwAWFqva3xe/zRZPLhXH5nJT6b5h0wBsYyTkv8ZY7Y7Z53WE6u9TIp6s2dYrnhVVl
        0S4l0H8bfUNg0uUDGvffpBAm0iFqE7dNae8UPEpk36Mf9ea6PBWUjLZqWObc+MIy68uEaq
        Yiql7iU6uXn8JufgzCWjb/2FbWdhT3Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-dlznfrllPwWV4upmlvPwvg-1; Thu, 01 Jun 2023 13:46:06 -0400
X-MC-Unique: dlznfrllPwWV4upmlvPwvg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2568461a928so436875a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641565; x=1688233565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqnaudmEV/Hbvq9piHmTal6ZUl67zTDEn82unVMjFsg=;
        b=ZE67NLV/WmwTcTvhEfy7H5odRpeUEI1bqMh1WeRjID10QOtjBx6b0PUmvrKZtZZ5ty
         8RPsP1nvd3ArRf+7KrYRpyb1yVK5qt0B0/zzGmhB/KHNXtNVOe8M2CY4aaZ01+yoDy0H
         B0RSmu2SdPUxFkL/wazdsPlfMWGejG8WB475mx3hxBVFC/2siYQG/JW4q8/LPYtM5PT3
         cRlngKovGe00DN9dL2D0Y67VJFHNQH1/J5iAsOS8W+2+D65qfnXLuv7yUcvq1PFynTlj
         3DypdKyDxw7FOtiku6izNDNNYb/4KADPli2mIaj636jJ3Di9Itpy/WKZ2d/pLR+AAMsr
         QJOw==
X-Gm-Message-State: AC+VfDzm9w2FxHb3DpjzrV/pSnvmItbquwGkZaIFZlxxfN9No1f4Wodm
        V4/5aMASra5TT9zVQ3JrgsB6I3VeNgActO1H/ygWNugG/0CI398GcT140CjNzjEnd2WdIZH4lT9
        YbWt8q9o5mYgBqY9sIjTHVTJPrU3jtaye8BpV6T9O
X-Received: by 2002:a17:90a:ec0e:b0:256:e021:c743 with SMTP id l14-20020a17090aec0e00b00256e021c743mr48150pjy.38.1685641565083;
        Thu, 01 Jun 2023 10:46:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71GvwbhJONV377HhnbbF1y20EFgMGVM6dpBuoslvKpefyBgYmU6Bi1wLSjmAOdtiEjeBghWLGB2oR6FRBoHWQ=
X-Received: by 2002:a17:90a:ec0e:b0:256:e021:c743 with SMTP id
 l14-20020a17090aec0e00b00256e021c743mr48119pjy.38.1685641564741; Thu, 01 Jun
 2023 10:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230516191441.34377-1-wander@redhat.com> <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com> <20230529122256.GA588@redhat.com>
In-Reply-To: <20230529122256.GA588@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 1 Jun 2023 14:45:53 -0300
Message-ID: <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
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

On Mon, May 29, 2023 at 9:23=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/17, Wander Lairson Costa wrote:
> >
> > On Wed, May 17, 2023 at 12:26=E2=80=AFPM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > >
> > > LGTM but we still need to understand the possible problems with CONFI=
G_PROVE_RAW_LOCK_NESTING ...
> > >
> > > Again, I'll try to investigate when I have time although I am not sur=
e I can really help.
> > >
> > > Perhaps you too can try to do this ? ;)
> > >
> >
> > FWIW, I tested this patch with CONFIG_PROVE_LOCK_NESTING in RT and
> > stock kernels. No splat happened.
>
> Strange... FYI, I am running the kernel with this patch
>
>         diff --git a/kernel/sys.c b/kernel/sys.c
>         index 339fee3eff6a..3169cceddf3b 100644
>         --- a/kernel/sys.c
>         +++ b/kernel/sys.c
>         @@ -2412,6 +2412,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsign=
ed long, arg2, unsigned long, arg3,
>
>                 error =3D 0;
>                 switch (option) {
>         +       case 666: {
>         +               static DEFINE_SPINLOCK(l);
>         +               static DEFINE_RAW_SPINLOCK(r);
>         +
>         +               raw_spin_lock(&r);
>         +               spin_lock(&l);
>         +               spin_unlock(&l);
>         +               raw_spin_unlock(&r);
>         +
>         +               break;
>         +       }
>                 case PR_SET_PDEATHSIG:
>                         if (!valid_signal(arg2)) {
>                                 error =3D -EINVAL;
>
> applied (because I am too lazy to compile a module ;) and
>

FWIW, I converted it to a module [1]

>         # perl -e 'syscall 157,666'
>
> triggers the lockdep bug
>
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>         [ BUG: Invalid wait context ]
>         6.4.0-rc2-00018-g4d6d4c7f541d-dirty #1176 Not tainted
>         -----------------------------
>         perl/35 is trying to lock:
>         ffffffff81c4cc18 (l){....}-{3:3}, at: __do_sys_prctl+0x21b/0x87b
>         other info that might help us debug this:
>         context-{5:5}
>         ...
>
> as expected.
>

Yeah, I tried it here and I had the same results, but only in the RT
kernel. But running the reproducer for put_task_struct(), works fine.

> Looks like your testing was wrong... Or maybe you missed another lockdep =
problem ?
> Did you check dmesg? Perhaps lockdep detected another bug,say, even at bo=
ot time ?
> In this case debug_locks_off() sets debug_locks =3D 0 and this disables l=
ockdep.
>
> Oleg.
>

