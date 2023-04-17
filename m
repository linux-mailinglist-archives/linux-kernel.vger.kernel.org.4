Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A652F6E429D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjDQIbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDQIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:31:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F549F8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:30:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sz19so4908696ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681720257; x=1684312257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkodB1zytRbF9QO4BRTAJCPNWh+4ypd4er+H1ch/Q3M=;
        b=WyCh4fYtMhPaR/jEQQ6tftR0L3u7oCUoCLqfg9k2zw7MPjwkIPOSNIirzxwgz8UtEP
         lC7QrG9rd1R00+KNtCPrJTN/7rIK63Pp3kS5MjWD263DXc8pLaUkpVyDXmuGXSvOqrbi
         zm1B/QtdUoMh11C0u0YxKKmhESDCEVVQQQ+E46m1VSCTrxVXtSxThIakAj6iA4krkpLK
         Okb8b/VZeEeNqj43S5Sx8Pqxrop/ESf4gKUd0857yLKl9D7cAbxNB3V3q9E2+odj6Wow
         nKJ6A1s9TbqOuRsn6c8koqP/BuWNwHXeTKDw8Aj8ykX9EaFCtWHpbpUCMLiX8Lotk7gO
         X/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720257; x=1684312257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkodB1zytRbF9QO4BRTAJCPNWh+4ypd4er+H1ch/Q3M=;
        b=jfLR3NG+nmdn7mP0hZSUttr7UYpG+39oYJ8GFA4Wghn0jJMipp2sb2rM9+tmHgplCZ
         DPKHXK9RmNAvsNW3EsQfRJBmUcDZTMIdq5QYqTwggjgT8u5JyGK8xlKpxwQkv9BFA2Hp
         GqIYhyfzguBNtxPfUrg7UfjWBFzyUbHKgNBoKR8db7+/eTG2RxBlariM9IfJZyKpRoBW
         PzTT9bxpUKhSPadNHB26fYK/pUTooSO4vfMSn/w4rEgHm1mZvvbpWanYTer7fKFnK9FG
         rB5FRQxar/Yx6t6uJcT+n5dcoblUFq0AVLBCPmvwARdAI1O3KvQg5qeIELQyMKTHtbfd
         aiig==
X-Gm-Message-State: AAQBX9fxO+Z2aeBB0jHdltCERc8c4EYi3nRydpgkq3kiUuxm8FieyMM/
        nB1GH/hwD+/PvL8oOcwcfCDUWQj4dKYaByXKUNaoJg==
X-Google-Smtp-Source: AKy350bCf6ZF8olTVDhfwgFxjs9OPM8GrtQrZFdUBDhMBuWGai9bQ7jB7gRoqGxdxZucjbhDvyWUqmLaQUOXg4HoQic=
X-Received: by 2002:a17:906:470d:b0:94e:ec32:ba28 with SMTP id
 y13-20020a170906470d00b0094eec32ba28mr6834528ejq.29.1681720256664; Mon, 17
 Apr 2023 01:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de> <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
 <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com> <c9b07e76-9953-b34f-dac0-4a9762b4ac34@suse.de>
In-Reply-To: <c9b07e76-9953-b34f-dac0-4a9762b4ac34@suse.de>
From:   Li Feng <fengli@smartx.com>
Date:   Mon, 17 Apr 2023 16:32:56 +0800
Message-ID: <CAHckoCz2ZTiSB6WQ8t5m6A9z6zC3BHid12_QFoPe5VGeq5Wwgw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu affinity
To:     Hannes Reinecke <hare@suse.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 2:27=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/15/23 23:06, David Laight wrote:
> > From: Li Feng
> >> Sent: 14 April 2023 10:35
> >>>
> >>> On 4/13/23 15:29, Li Feng wrote:
> >>>> The default worker affinity policy is using all online cpus, e.g. fr=
om 0
> >>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tc=
p will
> >>>> have a bad performance.
> >>>>
> >>>> This patch adds a module parameter to set the cpu affinity for the n=
vme-tcp
> >>>> socket worker threads.  The parameter is a comma separated list of C=
PU
> >>>> numbers.  The list is parsed and the resulting cpumask is used to se=
t the
> >>>> affinity of the socket worker threads.  If the list is empty or the
> >>>> parsing fails, the default affinity is used.
> >>>>
> > ...
> >>> I am not in favour of this.
> >>> NVMe-over-Fabrics has _virtual_ queues, which really have no
> >>> relationship to the underlying hardware.
> >>> So trying to be clever here by tacking queues to CPUs sort of works i=
f
> >>> you have one subsystem to talk to, but if you have several where each
> >>> exposes a _different_ number of queues you end up with a quite
> >>> suboptimal setting (ie you rely on the resulting cpu sets to overlap,
> >>> but there is no guarantee that they do).
> >>
> >> Thanks for your comment.
> >> The current io-queues/cpu map method is not optimal.
> >> It is stupid, and just starts from 0 to the last CPU, which is not con=
figurable.
> >
> > Module parameters suck, and passing the buck to the user
> > when you can't decide how to do something isn't a good idea either.
> >
> > If the system is busy pinning threads to cpus is very hard to
> > get right.
> >
> > It can be better to set the threads to run at the lowest RT
> > priority - so they have priority over all 'normal' threads
> > and also have a very sticky (but not fixed) cpu affinity so
> > that all such threads tends to get spread out by the scheduler.
> > This all works best if the number of RT threads isn't greater
> > than the number of physical cpu.
> >
> And the problem is that you cannot give an 'optimal' performance metric
> here. With NVMe-over-Fabrics the number of queues is negotiated during
> the initial 'connect' call, and the resulting number of queues strongly
> depends on target preferences (eg a NetApp array will expose only 4
> queues, with Dell/EMC you end up with up max 128 queues).
> And these queues need to be mapped on the underlying hardware, which has
> its own issues wrt to NUMA affinity.
>
> To give you an example:
> Given a setup with a 4 node NUMA machine, one NIC connected to
> one NUMA core, each socket having 24 threads, the NIC exposing up to 32
> interrupts, and connections to a NetApp _and_ a EMC, how exactly should
> the 'best' layout look like?
> And, what _is_ the 'best' layout?
> You cannot satisfy the queue requirements from NetApp _and_ EMC, as you
> only have one NIC, and you cannot change the interrupt affinity for each
> I/O.
>
Not all users have so many NIC cards that they can have one NIC per NUMA no=
de.
This scenario is quite common that only has one NIC.

There doesn=E2=80=99t exist a =E2=80=98best' layout for all cases,
So add this parameter to let users select what they want.

> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>
