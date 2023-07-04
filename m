Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373E2746EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGDKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjGDKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6C135
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688466581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGCDGT+5Ucs9GzX8ozVZ9woiFPUsyRi+dQCqsu34VxI=;
        b=OXNog1u+4Eu2hbUaolqV67eiRU2quenvffN+PA/KAGi2BG0z6+uivK3GCQoJLN7T4GA8DB
        tsS5WNXOXPsyb78oZ1Adt/FxX5bMNEFY0/Uv2ATZ39tU1tZDzDZAdFIOx+PQp443ggjgRW
        3hXoJ9vWkvRZAIpYOabQ7a/QUL1/Wqw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-jw7ImQM0OOO1YujtqDcT3A-1; Tue, 04 Jul 2023 06:29:38 -0400
X-MC-Unique: jw7ImQM0OOO1YujtqDcT3A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40234d83032so10955531cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688466577; x=1691058577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGCDGT+5Ucs9GzX8ozVZ9woiFPUsyRi+dQCqsu34VxI=;
        b=hsDrZC0EL8R4Wg1R1slwIMtlKqkeTmN5MI8sjJ+QB29aljdv9jMza8N6G8/P6RysoU
         LqkYY22NrXZaM/kPBl4sgNai95OZm4HFBucDgvb1iinnsRJgd7V5DSLZFQJj8ARfnsSD
         9Wt9YskN3cQRTzpmD8BPR+7L1FFYqlDviCIsT+Jrlv7aNr4sjqYb/VxIFK9d2WSaZ77O
         TflWqUn0ru3lES3uuIfRWLmnAJxDGVrOpn0MW9XdfqF+hpPtNr7btm6gQX2Wq6pW9Q28
         Zp6Y52Uulcz9N8pCRNP8eMvookDNp0xOswKkWlpLn2YCJymURtP4asFIpp4MBKtFnH4W
         dLiw==
X-Gm-Message-State: AC+VfDxnUlss4weouDG7c3XfDSbAjOyJMSnFrYQiSDlO+ALNidAGhyFW
        US1CuoxOxsWNNvRU5YKDMDHV10yNC0bPKpZ67eQ9+hGnXNsUeSL/hZMQeKMhh3SEtOY8zT0Ih5n
        JodK3aknNy4TFJACROoTwWgAMsMPIFoUm
X-Received: by 2002:a05:622a:1a27:b0:400:9ed9:7267 with SMTP id f39-20020a05622a1a2700b004009ed97267mr17522914qtb.3.1688466577561;
        Tue, 04 Jul 2023 03:29:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tUC0KAgufhRmOnB/HlqSyhLnELu52kXhmvyJ7YtGn5n3b7mX3zN3T24Wbw+mriewLuWMeVg==
X-Received: by 2002:a05:622a:1a27:b0:400:9ed9:7267 with SMTP id f39-20020a05622a1a2700b004009ed97267mr17522902qtb.3.1688466577256;
        Tue, 04 Jul 2023 03:29:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84b4c000000b003ff654694b6sm7636702qts.46.2023.07.04.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 03:29:36 -0700 (PDT)
Message-ID: <a4ed5a8cc35f34a3cb11aded76b0f289c658c1a7.camel@redhat.com>
Subject: Re: Splat in kernel RT while processing incoming network packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        juri.lelli@redhat.com
Date:   Tue, 04 Jul 2023 12:29:33 +0200
In-Reply-To: <20230704100527.75hMNZ35@linutronix.de>
References: <bkw2aao62e3ppg7332dbhycgzdwr7k5brezj3bcij6zewphmnd@eigmbvjh6wuu>
         <20230703142908.RcxjjF_E@linutronix.de>
         <x6d2ae4ss4wvvuib2hmop6ztysjsbyno7gbjkyek5xng2kmgyd@yfmnfognlj5n>
         <20230704100527.75hMNZ35@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-04 at 12:05 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-07-03 18:15:58 [-0300], Wander Lairson Costa wrote:
> > > Not sure how to proceed. One thing you could do is a hack similar lik=
e
> > > net-Avoid-the-IPI-to-free-the.patch which does it for defer_csd.
> >=20
> > At first sight it seems straightforward to implement.
> >=20
> > > On the other hand we could drop net-Avoid-the-IPI-to-free-the.patch a=
nd
> > > remove the warning because we have now commit
> > >    d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> >=20
> > But I am more in favor of a solution that removes code than one that
> > adds more :)
>=20
> Raising the softirq from anonymous (hardirq context) is not ideal for
> the reasons I stated below.
>=20
> > > Prior that, raising softirq from hardirq would wake ksoftirqd which i=
n
> > > turn would collect all pending softirqs. As a consequence all followi=
ng
> > > softirqs (networking, =E2=80=A6) would run as SCHED_OTHER and compete=
 with
> > > SCHED_OTHER tasks for resources. Not good because the networking work=
 is
> > > no longer processed within the networking interrupt thread. Also not =
a
> > > DDoS kind of situation where one could want to delay processing.
> > >=20
> > > With that change, this isn't the case anymore. Only an "unrelated" IR=
Q
> > > thread could pick up the networking work which is less then ideal. Th=
at
> > > is because the global softirq set is added, ksoftirq is marked for a
> > > wakeup and could be delayed because other tasks are busy. Then the di=
sk
> > > interrupt (for instance) could pick it up as part of its threaded
> > > interrupt.
> > >=20
> > > Now that I think about, we could make the backlog pseudo device a
> > > thread. NAPI threading enables one thread but here we would need one
> > > thread per-CPU. So it would remain kind of special. But we would avoi=
d
> > > clobbering the global state and delay everything to ksoftird. Process=
ing
> > > it in ksoftirqd might not be ideal from performance point of view.
> >=20
> > Before sending this to the ML, I talked to Paolo about using NAPI
> > thread. He explained that it is implemented per interface. For example,
> > for this specific case, it happened on the loopback interface, which
> > doesn't implement NAPI. I am cc'ing him, so the can correct me if I am
> > saying something wrong.
>=20
> It is per NAPI-queue/instance and you could have multiple instances per
> interface. However loopback has one and you need per-CPU threads if you
> want to RPS your skbs to any CPU.

Just to hopefully clarify the networking side of it, napi instances !=3D
network backlog (used by RPS). The network backlog (RPS) is available
for all the network devices, including the loopback and all the virtual
ones.=C2=A0

The napi instances (and the threaded mode) are available only on
network device drivers implementing the napi model. The loopback driver
does not implement the napi model, as most virtual devices and even
some H/W NICs (mostily low end ones).

The network backlog can't run in threaded mode: there is no API/sysctl
nor infrastructure for that. The backlog processing threaded mode could
be implemented, even if should not be completely trivial and it sounds
a bit weird to me.


Just for the records, I mentioned the following in the bz:

It looks like flush_smp_call_function_queue() has 2 only callers,
migration, and do_idle().

What about moving softirq processing from
flush_smp_call_function_queue() into cpu_stopper_thread(), outside the
unpreemptable critical section?

I *think*/wild guess the call from do_idle() could be just removed (at
least for RT build), as according to:

commit b2a02fc43a1f40ef4eb2fb2b06357382608d4d84
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue May 26 18:11:01 2020 +0200

	smp: Optimize send_call_function_single_ipi()

is just an optimization.

Cheers,

Paolo

