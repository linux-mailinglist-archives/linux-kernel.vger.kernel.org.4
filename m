Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524A6589DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiL2HI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2HIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349C9FFE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672297663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bPu20pS/DdT91F8IydmlqqU8a82kyRMHKQeQqC1iCsQ=;
        b=Q2eWVX4bIRTfWJLwEVQ86gpvcCoSyotdfY843I0aYGKpou+O0ABsqcDHZTjTqsL+1tpeyZ
        QBlE/5bhcVVuGnBCbGItTr7UctZ9TIZCEFZHATjc4emg1JAvNtfdIMmx00dJ4QzttPrtSt
        uE15yGRys7H9gKZ9I+nqtk0YsqZs7DA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-IuEapzSwOCa7Kt5jKxwwJw-1; Thu, 29 Dec 2022 02:07:42 -0500
X-MC-Unique: IuEapzSwOCa7Kt5jKxwwJw-1
Received: by mail-ed1-f72.google.com with SMTP id z20-20020a05640240d400b0047028edd264so12472055edb.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPu20pS/DdT91F8IydmlqqU8a82kyRMHKQeQqC1iCsQ=;
        b=0SmBD5GJCq9Ms/iTgPZ1MjEhy8+CCA2QPBloeBhbh189x4nG8pKIg/L2dc/S3HwOdK
         f7goFJNU1vIJkerWsoaeurJCfhmjsWCJcMtnISEbi0jS8NwGm/C3Z7qvo5NDnFInmYLZ
         /a581h7tTLvqqJf4AGZVfUsalL6y6/MFnuypeVp7GK9aR7CEM2F1jowPU5I34WnTwhoP
         ClFsU7lktBFbOw6U0fDY4H4eXmNHSpFrIk/l6As/Y9/RWve9RDuU/hwZz+w2FjLZr7/O
         VWYgXEQxO4bCtSftRTi0f/ayxhNnmijkuhQRA59T/gZRcrOVfkHgqToyfgTHW49pFnBI
         5VoQ==
X-Gm-Message-State: AFqh2kqt73nXLfMst9HUz9UNnMyF7jSEN+bx8VPcfEhxTx0qmlzU88sz
        u7Um1Gv7iEF4UblUeHCanyJSYC3RonLFZEnkEnf8UTiPp2EC8fz5QkHPb5w6RZrR8hFnjjC76Pj
        zplvgbTZC2Ih205jdcXTQ7g9q
X-Received: by 2002:a17:906:298f:b0:7c0:fa2c:fc9b with SMTP id x15-20020a170906298f00b007c0fa2cfc9bmr25411320eje.55.1672297661225;
        Wed, 28 Dec 2022 23:07:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRUDqAyosWJYpOIWrOSpWIbCvCqFmJmOZzZEXMSAjeKwf2iMUA7V6PSBUnHR31Ghwj8Gddrg==
X-Received: by 2002:a17:906:298f:b0:7c0:fa2c:fc9b with SMTP id x15-20020a170906298f00b007c0fa2cfc9bmr25411307eje.55.1672297660951;
        Wed, 28 Dec 2022 23:07:40 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b007c0f5d6f754sm8249151ejb.79.2022.12.28.23.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:07:40 -0800 (PST)
Date:   Thu, 29 Dec 2022 02:07:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221229020553-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 07:53:08PM +0800, Jason Wang wrote:
> On Wed, Dec 28, 2022 at 2:34 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > 在 2022/12/27 17:38, Michael S. Tsirkin 写道:
> > > On Tue, Dec 27, 2022 at 05:12:58PM +0800, Jason Wang wrote:
> > >> 在 2022/12/27 15:33, Michael S. Tsirkin 写道:
> > >>> On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
> > >>>>> But device is still going and will later use the buffers.
> > >>>>>
> > >>>>> Same for timeout really.
> > >>>> Avoiding infinite wait/poll is one of the goals, another is to sleep.
> > >>>> If we think the timeout is hard, we can start from the wait.
> > >>>>
> > >>>> Thanks
> > >>> If the goal is to avoid disrupting traffic while CVQ is in use,
> > >>> that sounds more reasonable. E.g. someone is turning on promisc,
> > >>> a spike in CPU usage might be unwelcome.
> > >>
> > >> Yes, this would be more obvious is UP is used.
> > >>
> > >>
> > >>> things we should be careful to address then:
> > >>> 1- debugging. Currently it's easy to see a warning if CPU is stuck
> > >>>      in a loop for a while, and we also get a backtrace.
> > >>>      E.g. with this - how do we know who has the RTNL?
> > >>>      We need to integrate with kernel/watchdog.c for good results
> > >>>      and to make sure policy is consistent.
> > >>
> > >> That's fine, will consider this.
> 
> So after some investigation, it seems the watchdog.c doesn't help. The
> only export helper is touch_softlockup_watchdog() which tries to avoid
> triggering the lockups warning for the known slow path.

I never said you can just use existing exporting APIs. You'll have to
write new ones :)

> And before the patch, we end up with a real infinite loop which could
> be caught by RCU stall detector which is not the case of the sleep.
> What we can do is probably do a periodic netdev_err().
> 
> Thanks

Only with a bad device.

> > >>
> > >>
> > >>> 2- overhead. In a very common scenario when device is in hypervisor,
> > >>>      programming timers etc has a very high overhead, at bootup
> > >>>      lots of CVQ commands are run and slowing boot down is not nice.
> > >>>      let's poll for a bit before waiting?
> > >>
> > >> Then we go back to the question of choosing a good timeout for poll. And
> > >> poll seems problematic in the case of UP, scheduler might not have the
> > >> chance to run.
> > > Poll just a bit :) Seriously I don't know, but at least check once
> > > after kick.
> >
> >
> > I think it is what the current code did where the condition will be
> > check before trying to sleep in the wait_event().
> >
> >
> > >
> > >>> 3- suprise removal. need to wake up thread in some way. what about
> > >>>      other cases of device breakage - is there a chance this
> > >>>      introduces new bugs around that? at least enumerate them please.
> > >>
> > >> The current code did:
> > >>
> > >> 1) check for vq->broken
> > >> 2) wakeup during BAD_RING()
> > >>
> > >> So we won't end up with a never woke up process which should be fine.
> > >>
> > >> Thanks
> > >
> > > BTW BAD_RING on removal will trigger dev_err. Not sure that is a good
> > > idea - can cause crashes if kernel panics on error.
> >
> >
> > Yes, it's better to use __virtqueue_break() instead.
> >
> > But consider we will start from a wait first, I will limit the changes
> > in virtio-net without bothering virtio core.
> >
> > Thanks
> >
> >
> > >
> > >>>

