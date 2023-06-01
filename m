Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBF71F18B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFASPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjFASPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5413D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685643273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7upMiNAR9+4z3Vj7VjoE6UJazN2Bsg6RUcSnR0glX6s=;
        b=YUhxgMPQvfKsElRpGM1dqBybhlMb7HvvIQ7uilWYDcU8p7wGAPmFdCpHDC4+5YqhpSbzdy
        T1IXRxSzbQCA2jmxM0a/QtSOT9a90N7cm02pxGq6w91qfyGpvBJjAT76GRjXJdhUGowIZF
        cyZvhtGA6/xP6IaXf1xWxKs8HS6Hv9Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-p9MYtEy2MkWf5VubT3B2TA-1; Thu, 01 Jun 2023 14:14:28 -0400
X-MC-Unique: p9MYtEy2MkWf5VubT3B2TA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A113C0C88A;
        Thu,  1 Jun 2023 18:14:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92F94112132C;
        Thu,  1 Jun 2023 18:14:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Jun 2023 20:14:07 +0200 (CEST)
Date:   Thu, 1 Jun 2023 20:13:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
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
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230601181359.GA23852@redhat.com>
References: <20230516191441.34377-1-wander@redhat.com>
 <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
 <20230529122256.GA588@redhat.com>
 <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Wander Lairson Costa wrote:
>
> On Mon, May 29, 2023 at 9:23 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 05/17, Wander Lairson Costa wrote:
> > >
> > > On Wed, May 17, 2023 at 12:26 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > LGTM but we still need to understand the possible problems with CONFIG_PROVE_RAW_LOCK_NESTING ...
> > > >
> > > > Again, I'll try to investigate when I have time although I am not sure I can really help.
> > > >
> > > > Perhaps you too can try to do this ? ;)
> > > >
> > >
> > > FWIW, I tested this patch with CONFIG_PROVE_LOCK_NESTING in RT and
> > > stock kernels. No splat happened.
> >
> > Strange... FYI, I am running the kernel with this patch
> >
> >         diff --git a/kernel/sys.c b/kernel/sys.c
> >         index 339fee3eff6a..3169cceddf3b 100644
> >         --- a/kernel/sys.c
> >         +++ b/kernel/sys.c
> >         @@ -2412,6 +2412,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >
> >                 error = 0;
> >                 switch (option) {
> >         +       case 666: {
> >         +               static DEFINE_SPINLOCK(l);
> >         +               static DEFINE_RAW_SPINLOCK(r);
> >         +
> >         +               raw_spin_lock(&r);
> >         +               spin_lock(&l);
> >         +               spin_unlock(&l);
> >         +               raw_spin_unlock(&r);
> >         +
> >         +               break;
> >         +       }
> >                 case PR_SET_PDEATHSIG:
> >                         if (!valid_signal(arg2)) {
> >                                 error = -EINVAL;
> >
> > applied (because I am too lazy to compile a module ;) and
> >
>
> FWIW, I converted it to a module [1]

where is [1] ?  not that I think this matters though...

> >         # perl -e 'syscall 157,666'
> >
> > triggers the lockdep bug
> >
> >         =============================
> >         [ BUG: Invalid wait context ]
> >         6.4.0-rc2-00018-g4d6d4c7f541d-dirty #1176 Not tainted
> >         -----------------------------
> >         perl/35 is trying to lock:
> >         ffffffff81c4cc18 (l){....}-{3:3}, at: __do_sys_prctl+0x21b/0x87b
> >         other info that might help us debug this:
> >         context-{5:5}
> >         ...
> >
> > as expected.
> >
>
> Yeah, I tried it here and I had the same results,

OK,

> but only in the RT kernel

this again suggests that your testing was wrong or I am totally confused (quite
possible, I know nothing about RT). I did the testing without CONFIG_PREEMPT_RT.

> But running the reproducer for put_task_struct(), works fine.

which reproducer ?

Oleg.

