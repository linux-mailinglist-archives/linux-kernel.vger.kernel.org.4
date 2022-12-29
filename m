Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D36658A28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiL2IFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiL2IFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53548FCF3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672301068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vle3ibqeQcUc3o0c9rRrl2gAzdgVWVtbpb/9M/RDS4Q=;
        b=WJyV3EC2EgdDCWSH7xtcVy3kePgEd769wtJ/mlWU/o2M5bY/gbIHGQNJ6O79W4dWQJGVBZ
        z7IyDC8gjlQcFs42e+TIBgbs46bRDD6dcKTJcMjPsAW38Ccq7JbimLgjpbW6sNBUW6d1Yl
        0foTiy2A2s6xUkDgDTu93lJ16OtR0is=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-JIUL_BMhNgyR-QcCYcRBiQ-1; Thu, 29 Dec 2022 03:04:25 -0500
X-MC-Unique: JIUL_BMhNgyR-QcCYcRBiQ-1
Received: by mail-oo1-f70.google.com with SMTP id c6-20020a4ad206000000b004a33f36aa4dso8291613oos.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vle3ibqeQcUc3o0c9rRrl2gAzdgVWVtbpb/9M/RDS4Q=;
        b=Njp6GhTcRB63vNlEclQ5YWBdflBwiAHeJFmdI5r5aGtkeBTnfWviQQL6PhSzBD+sjG
         no4TrX3jOZxHsrOhijHz59576xMJBaQuaXaRg7KU2l2lswXfiljdqNEvgD3K66+JmlZd
         jByTgHmscyWEzhZbBl+JuTTfkWMdJ67BFy6aST3F1hSOnjPwk4mNfV3JPuR4X2AeiPWj
         akI+6itv4i28UX0YxGZ/C/wKszAhq3jald/bee3JTWFwbZc3Bs4wa/djJC0XJ8/flruS
         7F0+T4uBn21Nv1OHhkm9wV/YqzKF3PmCu7MbpNcIo+VrsfTy0PaRqI88Y74jl14Dx4+A
         riIQ==
X-Gm-Message-State: AFqh2krgVRU6r4V7nlccYaFUENjJjlmk0AlIRqwKEXrhuNQlc95YCTbY
        pZFwKhe0b/T1fBfwl/ewzxJB+E9Wm+z/G0dNv7jDUCC+ZOIn7nrcM7jPROIOvTa6Peh0JnHj0YG
        weUgqu/lbHmDnThOS5LqZCXMMy5AfDG+y9YfgDlu+
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id 17-20020aca1111000000b0035e7a427ab5mr1472676oir.280.1672301065020;
        Thu, 29 Dec 2022 00:04:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvP44RmCToT51pJfyvWSPl3P4STkPSA7vMDACFHHl+aDZ9sWlAE+dF2c1pbK85ZI5ctd6sscLzOaVLzM2bPnB0=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1472673oir.280.1672301064783; Thu, 29
 Dec 2022 00:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org> <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org> <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org> <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com> <20221229020553-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229020553-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 29 Dec 2022 16:04:13 +0800
Message-ID: <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 3:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Dec 28, 2022 at 07:53:08PM +0800, Jason Wang wrote:
> > On Wed, Dec 28, 2022 at 2:34 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > =E5=9C=A8 2022/12/27 17:38, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > On Tue, Dec 27, 2022 at 05:12:58PM +0800, Jason Wang wrote:
> > > >> =E5=9C=A8 2022/12/27 15:33, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > >>> On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
> > > >>>>> But device is still going and will later use the buffers.
> > > >>>>>
> > > >>>>> Same for timeout really.
> > > >>>> Avoiding infinite wait/poll is one of the goals, another is to s=
leep.
> > > >>>> If we think the timeout is hard, we can start from the wait.
> > > >>>>
> > > >>>> Thanks
> > > >>> If the goal is to avoid disrupting traffic while CVQ is in use,
> > > >>> that sounds more reasonable. E.g. someone is turning on promisc,
> > > >>> a spike in CPU usage might be unwelcome.
> > > >>
> > > >> Yes, this would be more obvious is UP is used.
> > > >>
> > > >>
> > > >>> things we should be careful to address then:
> > > >>> 1- debugging. Currently it's easy to see a warning if CPU is stuc=
k
> > > >>>      in a loop for a while, and we also get a backtrace.
> > > >>>      E.g. with this - how do we know who has the RTNL?
> > > >>>      We need to integrate with kernel/watchdog.c for good results
> > > >>>      and to make sure policy is consistent.
> > > >>
> > > >> That's fine, will consider this.
> >
> > So after some investigation, it seems the watchdog.c doesn't help. The
> > only export helper is touch_softlockup_watchdog() which tries to avoid
> > triggering the lockups warning for the known slow path.
>
> I never said you can just use existing exporting APIs. You'll have to
> write new ones :)

Ok, I thought you wanted to trigger similar warnings as a watchdog.

Btw, I wonder what kind of logic you want here. If we switch to using
sleep, there won't be soft lockup anymore. A simple wait + timeout +
warning seems sufficient?

Thanks

>
> > And before the patch, we end up with a real infinite loop which could
> > be caught by RCU stall detector which is not the case of the sleep.
> > What we can do is probably do a periodic netdev_err().
> >
> > Thanks
>
> Only with a bad device.
>
> > > >>
> > > >>
> > > >>> 2- overhead. In a very common scenario when device is in hypervis=
or,
> > > >>>      programming timers etc has a very high overhead, at bootup
> > > >>>      lots of CVQ commands are run and slowing boot down is not ni=
ce.
> > > >>>      let's poll for a bit before waiting?
> > > >>
> > > >> Then we go back to the question of choosing a good timeout for pol=
l. And
> > > >> poll seems problematic in the case of UP, scheduler might not have=
 the
> > > >> chance to run.
> > > > Poll just a bit :) Seriously I don't know, but at least check once
> > > > after kick.
> > >
> > >
> > > I think it is what the current code did where the condition will be
> > > check before trying to sleep in the wait_event().
> > >
> > >
> > > >
> > > >>> 3- suprise removal. need to wake up thread in some way. what abou=
t
> > > >>>      other cases of device breakage - is there a chance this
> > > >>>      introduces new bugs around that? at least enumerate them ple=
ase.
> > > >>
> > > >> The current code did:
> > > >>
> > > >> 1) check for vq->broken
> > > >> 2) wakeup during BAD_RING()
> > > >>
> > > >> So we won't end up with a never woke up process which should be fi=
ne.
> > > >>
> > > >> Thanks
> > > >
> > > > BTW BAD_RING on removal will trigger dev_err. Not sure that is a go=
od
> > > > idea - can cause crashes if kernel panics on error.
> > >
> > >
> > > Yes, it's better to use __virtqueue_break() instead.
> > >
> > > But consider we will start from a wait first, I will limit the change=
s
> > > in virtio-net without bothering virtio core.
> > >
> > > Thanks
> > >
> > >
> > > >
> > > >>>
>

