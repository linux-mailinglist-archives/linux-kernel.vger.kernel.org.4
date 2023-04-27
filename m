Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E786F079D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbjD0OiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0OiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423F3C29
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682606244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+bc7ZuC8G9X6V5Pyx75I64zhOn5ekB770BG95AHrN0=;
        b=Np+xfUz84d0s0i5jGaMf/uIZV5hlXe8YKoHqlXqiCrAHLfYRqEFBlpZdPkhQkTW0x7YuhT
        1iOeevhXrqi+el20rjcP2aFk8OzZ7ThQHXv/XNG0QZ3f2yW2i/hESU1wh29gDSDcyOrFMP
        0L81pEtVZFKNMhr7v9yRbURl+hsJrnI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-JYYJ_BBONRGyPw0F1WGp3g-1; Thu, 27 Apr 2023 10:36:59 -0400
X-MC-Unique: JYYJ_BBONRGyPw0F1WGp3g-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-42ff5f5c5daso143214137.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606208; x=1685198208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+bc7ZuC8G9X6V5Pyx75I64zhOn5ekB770BG95AHrN0=;
        b=Xj2YvEVbxG+N0Wxg+APXVND9Q+dVvCa77YyeMprzC9CCVfQCOXF0j6ZBJiWn3Y4jOr
         TsQ2pQKJX+SSk3ODB0696R0IOYiQwDpknye1kXlYPcxZQMYxwcPe7jq1s2em/7mE1d4Q
         fqMMOCG+HWpHvnREg9R4xb+u9K9ShfV56cJaIlj6uhIU7rDiswt6cDPCDToODfbV0SbF
         MTU/hmb9dmWF/5LmOgv6w83nVzGnpsbaxNBB14elcz8QHN4rI+kpBr7M7/sY8PKS1VrL
         Uv8RVyqPtuy/Aufdsq/OCsAQZKBzYHyufv5+IpX8sZU/ENePEdsN8ELlH3VWBrnvlsv3
         eIQw==
X-Gm-Message-State: AC+VfDzbQVlCnyEiPWopSNU5E7lt/BoYj51BrrzGYvsTlovVPCb+KJXs
        xJ0HNty5EC+XIVN6Heh8uPkzrLUtzePQ/TcWcMtxoiEbRet0zwNfBdhiQecBKGZke/sOevAc1vL
        U2V96c7to/jr5EdSupV5AAumXznqvFxqoRP1k4vh8
X-Received: by 2002:a67:cd16:0:b0:42c:599d:f96a with SMTP id u22-20020a67cd16000000b0042c599df96amr919448vsl.0.1682606207809;
        Thu, 27 Apr 2023 07:36:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58HGmVOdnmzREy9nBdtSIoSod5J7jyQssPmFiLqufzftlIDgM4+jwwoaJI/AuCnje4qJMYnlgc9cLWHGPGCAQ=
X-Received: by 2002:a67:cd16:0:b0:42c:599d:f96a with SMTP id
 u22-20020a67cd16000000b0042c599df96amr919432vsl.0.1682606207540; Thu, 27 Apr
 2023 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me> <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me> <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
 <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
In-Reply-To: <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 27 Apr 2023 22:36:36 +0800
Message-ID: <CAFj5m9+1VBuDV5HFM3-BiS9T5cxvdB5BuaZOTCYs8uTMxuTzqw@mail.gmail.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
To:     Hannes Reinecke <hare@suse.de>
Cc:     Li Feng <fengli@smartx.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 7:34=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/25/23 10:32, Li Feng wrote:
> > Hi Sagi,
> >
> > On Wed, Apr 19, 2023 at 5:32=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> >>
> >>
> >>>> Hey Li,
> >>>>
> >>>>> The default worker affinity policy is using all online cpus, e.g. f=
rom 0
> >>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-t=
cp will
> >>>>> have a bad performance.
> >>>>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
> >>>>> socket worker threads.  The parameter is a comma separated list of =
CPU
> >>>>> numbers.  The list is parsed and the resulting cpumask is used to s=
et the
> >>>>> affinity of the socket worker threads.  If the list is empty or the
> >>>>> parsing fails, the default affinity is used.
> >>>>
> >>>> I can see how this may benefit a specific set of workloads, but I ha=
ve a
> >>>> few issues with this.
> >>>>
> >>>> - This is exposing a user interface for something that is really
> >>>> internal to the driver.
> >>>>
> >>>> - This is something that can be misleading and could be tricky to ge=
t
> >>>> right, my concern is that this would only benefit a very niche case.
> >>> Our storage products needs this feature~
> >>> If the user doesn=E2=80=99t know what this is, they can keep it defau=
lt, so I thinks this is
> >>> not unacceptable.
> >>
> >> It doesn't work like that. A user interface is not something exposed t=
o
> >> a specific consumer.
> >>
> >>>> - If the setting should exist, it should not be global.
> >>> V2 has fixed it.
> >>>>
> >>>> - I prefer not to introduce new modparams.
> >>>>
> >>>> - I'd prefer to find a way to support your use-case without introduc=
ing
> >>>> a config knob for it.
> >>>>
> >>> I=E2=80=99m looking forward to it.
> >>
> >> If you change queue_work_on to queue_work, ignoring the io_cpu, does i=
t
> >> address your problem?
> > Sorry for the late response, I just got my machine back.
> > Replace the queue_work_on to queue_work, looks like it has a little
> > good performance.
> > The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
> > 90('cpus_allowed=3D90'),
> > I don't know why the worker 56 is selected.
> > The performance of 256k read up from 1.15GB/s to 1.35GB/s.
> >
> >>
> >> Not saying that this should be a solution though.
> >>
> >> How many queues does your controller support that you happen to use
> >> queue 0 ?
> > Our controller only support one io queue currently.
>
> Ouch.
> Remember, NVMe gets most of the performance improvements by using
> several queues, and be able to bind the queues to cpu sets.
> Exposing just one queue will be invalidating any assumptions we do,
> and trying to improve interrupt steering won't work anyway.
>
> I sincerely doubt we should try to 'optimize' for this rather peculiar
> setup.

Queue isn't free, and it does consume both host and device resources,
especially blk-mq takes static mapping.

Also it may depend on how application uses the nvme/tcp, such as,
io_uring may saturate one device easily in very limited tasks/queues
(one or two or a little more, depends on the device and driver implementati=
on)

Thanks,
Ming

