Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C96816DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjA3Que (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjA3Qu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC83D919
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675097379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odHB3ciPruJjXU7tLwPggH0AiQdDfTZCf2IkZ9diD/o=;
        b=i98HG+jzm490IgN2M1p9oI9f4tmhdAr84EUo59kjPi4cOWh+NU1hJQawdYiIc2VO1HWD57
        TRI1Jaubu0w+h8FkacaetoEscOWlahzUi0fyiFqqDlYdlMfxpCwCMldFie3UUIeo7niRb1
        kfsmoxBOvspYJ7+5oaU6JJ0UoXpea68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-29I8yhHNPNez9ZTOafvEKw-1; Mon, 30 Jan 2023 11:49:35 -0500
X-MC-Unique: 29I8yhHNPNez9ZTOafvEKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 180AC882821;
        Mon, 30 Jan 2023 16:49:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-102.brq.redhat.com [10.40.192.102])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C7B140C2064;
        Mon, 30 Jan 2023 16:49:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 30 Jan 2023 17:49:32 +0100 (CET)
Date:   Mon, 30 Jan 2023 17:49:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20230130164929.GB20353@redhat.com>
References: <20230126105128.2249938-1-dvyukov@google.com>
 <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
 <87o7qlgjce.ffs@tglx>
 <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
 <20230128195641.GA14906@redhat.com>
 <CACT4Y+YzTK8+gKm9pZ1hwGvaN-ExmVLuxZYKVia+dnakv6+b5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YzTK8+gKm9pZ1hwGvaN-ExmVLuxZYKVia+dnakv6+b5A@mail.gmail.com>
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

On 01/30, Dmitry Vyukov wrote:
>
> On Sat, 28 Jan 2023 at 20:56, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Dmitry,
> >
> > I agree with what you said, just one note...
> >
> > On 01/27, Dmitry Vyukov wrote:
> > >
> > > After this change the test passes quickly (within a second for me).
> >
> > yet perhaps it makes sense to slightly change it? It does
> >
> >         +static void *distribution_thr(void *arg) {
> >         +       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> >         +       return NULL;
> >         +}
> >
> > so distribution_thr() eats CPU even after this thread gets a signal and thus
> > (in theory) it can "steal" cpu_timer_fire() from other threads unpredictably
> > long ? How about
> >
> >         -       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> >         +       while (__atomic_load_n(&got_signal, __ATOMIC_RELAXED));
> > ?
>
> But why?
> IIUC this makes the test even "weaker". As Thomas notes it's already
> somewhat "weak". And this would make it even "weaker".

Not sure I understand why can this change make the test more weak...

IIUC, _in theory_ the test-case can "hang" forever, since all threads
are running nothing guarentees that every thread will have a chance to
call cpu_timer_fire() and get a signal.

With this change this is not possible, and the test-case will still
verify that all threads must get a signal.

Nevermind,

> So if it passes
> in the current version, I would keep it as is.

OK, I won't insist, please forget.

Oleg.

