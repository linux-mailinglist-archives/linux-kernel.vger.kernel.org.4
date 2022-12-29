Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2728658A38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiL2ILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiL2ILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD74FB48F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672301446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI6AlEc7KfZ1avo1jwJKrSQequUz5Q+UUl+tM82CWOM=;
        b=AV9zpFHRCl1/eZolQsiw8myZfyda+u6h+arE3PQfj+6tYKyuR45RnctNO4tHZfMNsKtyoD
        4NB++hTajBIfGANUkw/ie9x/tM9dpu+A0LIvZTuGL5HlGOodubr6pI2uJSp/jkNiiZa+Vt
        oBg5sFrfG4A7+yNZSaQzJXC/0oaGuH8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450-QGuZlwxoPcSfIULsVsuHRw-1; Thu, 29 Dec 2022 03:10:44 -0500
X-MC-Unique: QGuZlwxoPcSfIULsVsuHRw-1
Received: by mail-wm1-f70.google.com with SMTP id k20-20020a05600c1c9400b003d9717c8b11so7424135wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI6AlEc7KfZ1avo1jwJKrSQequUz5Q+UUl+tM82CWOM=;
        b=3I9724fSAZZNZcUOJaSBoe6d4vra9PQ6jA3da24NkZ3IBDYqR8F/ELAOfkzy/Z5ccp
         Wey+L2xWqB27fG2lqrG2+y2+netNhoVeZawvZ7dw4ExL/W/qniLbZGiaR8Fn83f1VTMb
         flxCtAMC18yfure67kZmcGk5yPivViLzmD/4hG5u+OdPoFzX7/YvwDVNR7vevV5nSTwx
         uEh+dhsdB8zP4rV4vmV0GpvqMuWBKimkbXbZEIUUKlwhnL3jFvDVX6aNTL92IjmUwytH
         xVRb9YBzvdOA6je5FiWpMKaoEIVruRrB1FwnV6x9fjmwwtpog8RrRKxWlliox45QGyW5
         fbYA==
X-Gm-Message-State: AFqh2ko1XEbdiYjReYyGqtt1PrkV+NI1SVjfrUUrbC0ShAQBdEbZE9dU
        ll/KHHd+3KIcFr+xANtHWf9NL6VnygvrlMF7DsnLjj00VYf3jNCL986QrBpgGzrTAs6j2BzUV4N
        aqYWwMSpcN/EYhxST+x/45yMt
X-Received: by 2002:adf:ce0a:0:b0:246:e6df:86e7 with SMTP id p10-20020adfce0a000000b00246e6df86e7mr17498204wrn.5.1672301442825;
        Thu, 29 Dec 2022 00:10:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtCwrO0CDFtRs3sThb9MNmLR5zMGV1PR7/QCvy+zp7ENhYRIgm6RfCU8IAhgG7fUSbme3pHsQ==
X-Received: by 2002:adf:ce0a:0:b0:246:e6df:86e7 with SMTP id p10-20020adfce0a000000b00246e6df86e7mr17498181wrn.5.1672301442504;
        Thu, 29 Dec 2022 00:10:42 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id a6-20020adff7c6000000b002421db5f279sm17347928wrq.78.2022.12.29.00.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:10:41 -0800 (PST)
Date:   Thu, 29 Dec 2022 03:10:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221229030633-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
 <20221227043148-mutt-send-email-mst@kernel.org>
 <0d9f1b89-9374-747b-3fb0-b4b28ad0ace1@redhat.com>
 <CACGkMEv=+D+Es4sfde_X7F0zspVdy4Rs1Wi9qfCudsznsUrOTQ@mail.gmail.com>
 <20221229020553-mutt-send-email-mst@kernel.org>
 <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs5s3Muo+4OfjaLK_P76rTdPhjQdTwykRNGOecAWnt+8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 04:04:13PM +0800, Jason Wang wrote:
> On Thu, Dec 29, 2022 at 3:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Dec 28, 2022 at 07:53:08PM +0800, Jason Wang wrote:
> > > On Wed, Dec 28, 2022 at 2:34 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > >
> > > > 在 2022/12/27 17:38, Michael S. Tsirkin 写道:
> > > > > On Tue, Dec 27, 2022 at 05:12:58PM +0800, Jason Wang wrote:
> > > > >> 在 2022/12/27 15:33, Michael S. Tsirkin 写道:
> > > > >>> On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
> > > > >>>>> But device is still going and will later use the buffers.
> > > > >>>>>
> > > > >>>>> Same for timeout really.
> > > > >>>> Avoiding infinite wait/poll is one of the goals, another is to sleep.
> > > > >>>> If we think the timeout is hard, we can start from the wait.
> > > > >>>>
> > > > >>>> Thanks
> > > > >>> If the goal is to avoid disrupting traffic while CVQ is in use,
> > > > >>> that sounds more reasonable. E.g. someone is turning on promisc,
> > > > >>> a spike in CPU usage might be unwelcome.
> > > > >>
> > > > >> Yes, this would be more obvious is UP is used.
> > > > >>
> > > > >>
> > > > >>> things we should be careful to address then:
> > > > >>> 1- debugging. Currently it's easy to see a warning if CPU is stuck
> > > > >>>      in a loop for a while, and we also get a backtrace.
> > > > >>>      E.g. with this - how do we know who has the RTNL?
> > > > >>>      We need to integrate with kernel/watchdog.c for good results
> > > > >>>      and to make sure policy is consistent.
> > > > >>
> > > > >> That's fine, will consider this.
> > >
> > > So after some investigation, it seems the watchdog.c doesn't help. The
> > > only export helper is touch_softlockup_watchdog() which tries to avoid
> > > triggering the lockups warning for the known slow path.
> >
> > I never said you can just use existing exporting APIs. You'll have to
> > write new ones :)
> 
> Ok, I thought you wanted to trigger similar warnings as a watchdog.
> 
> Btw, I wonder what kind of logic you want here. If we switch to using
> sleep, there won't be soft lockup anymore. A simple wait + timeout +
> warning seems sufficient?
> 
> Thanks

I'd like to avoid need to teach users new APIs. So watchdog setup to apply
to this driver. The warning can be different.


> >
> > > And before the patch, we end up with a real infinite loop which could
> > > be caught by RCU stall detector which is not the case of the sleep.
> > > What we can do is probably do a periodic netdev_err().
> > >
> > > Thanks
> >
> > Only with a bad device.
> >
> > > > >>
> > > > >>
> > > > >>> 2- overhead. In a very common scenario when device is in hypervisor,
> > > > >>>      programming timers etc has a very high overhead, at bootup
> > > > >>>      lots of CVQ commands are run and slowing boot down is not nice.
> > > > >>>      let's poll for a bit before waiting?
> > > > >>
> > > > >> Then we go back to the question of choosing a good timeout for poll. And
> > > > >> poll seems problematic in the case of UP, scheduler might not have the
> > > > >> chance to run.
> > > > > Poll just a bit :) Seriously I don't know, but at least check once
> > > > > after kick.
> > > >
> > > >
> > > > I think it is what the current code did where the condition will be
> > > > check before trying to sleep in the wait_event().
> > > >
> > > >
> > > > >
> > > > >>> 3- suprise removal. need to wake up thread in some way. what about
> > > > >>>      other cases of device breakage - is there a chance this
> > > > >>>      introduces new bugs around that? at least enumerate them please.
> > > > >>
> > > > >> The current code did:
> > > > >>
> > > > >> 1) check for vq->broken
> > > > >> 2) wakeup during BAD_RING()
> > > > >>
> > > > >> So we won't end up with a never woke up process which should be fine.
> > > > >>
> > > > >> Thanks
> > > > >
> > > > > BTW BAD_RING on removal will trigger dev_err. Not sure that is a good
> > > > > idea - can cause crashes if kernel panics on error.
> > > >
> > > >
> > > > Yes, it's better to use __virtqueue_break() instead.
> > > >
> > > > But consider we will start from a wait first, I will limit the changes
> > > > in virtio-net without bothering virtio core.
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > >>>
> >

