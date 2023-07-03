Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD37745593
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGCGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A29CE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688366699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
        b=PiKIt3UUtdh9SKfsUFd3OdUxoUgcBdbJXWDUac3NH1zd2eYkmx+0xPnoPzPgXRIfEEEOW0
        +jZxhEUvEfGSPnYiOYWY6VRPs1dX9LEuDjL6wnTm0g3ES3Cd2hab4j5f4b9ySx9On8oAAA
        jzs7DbF7ijtwAysEK+CTBh4zMfJ720E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-atnsiuKvMZyNCkwLAkav9Q-1; Mon, 03 Jul 2023 02:44:58 -0400
X-MC-Unique: atnsiuKvMZyNCkwLAkav9Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b699c5f238so32979351fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688366696; x=1690958696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovluAHTmtFvydqG5OYZ6GVGeRDsdOvDwQZe/fLVcLSo=;
        b=NWzkihIHhfvGf0xHyemHo7tCMgbLZ0bJXG+6sToO5ekPpgV4OJEtNTdBGX3vwMtmjj
         Mf/NvcEmkxPHwd031PwM5JkqUB3MRlG8/FF9SdGh2faUxazbG5KVUtAtxTmGRQ9040b8
         WP7ux9ROcQFWcSMRBrd8EuSZ4Ib1vN/l6Oydy0OOCyZFzHcmnLdYrTRefurjHtG6p1Z7
         prFKMdlrE+ENgxE8lE98R8kxhPRVMs+m8q09NTmKgmUUSyvQmT6J0XdV0OjcTX7CU8mq
         GRTeip4L2ENweHNkvhO6Bg/WwFJObn2KtFfJLSGLaPOz4K5iQvt1F8tBVVQXpOv4iXnA
         k30A==
X-Gm-Message-State: ABy/qLYY116aKL5rlap8vLHrjgVGvYOY0WDKeKVVnxYns8wZPfnMns8J
        ZQHuf8bYS/IrGhH4KxM1MjOJRRCWZF29IhD002wIaZk/SprFCi2omqSfR6GtZ3QK9+E2qfbuVx5
        NnB6NHduBw0X7z1KZZ0QHuBtMqK6DlmuX47DRq6XT
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id m12-20020a2e910c000000b002b6a22f9fb9mr6009890ljg.27.1688366696672;
        Sun, 02 Jul 2023 23:44:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlynqGGlx9Jhthcs4p2/VB3UnNVeBKpKxmHTXOyGfI54rO4NRmFnzaCGXKfgksJmq0cNXrTsUIyES6jnl+V9A=
X-Received: by 2002:a2e:910c:0:b0:2b6:a22f:9fb9 with SMTP id
 m12-20020a2e910c000000b002b6a22f9fb9mr6009887ljg.27.1688366696399; Sun, 02
 Jul 2023 23:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230702093530-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230702093530-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 3 Jul 2023 14:44:45 +0800
Message-ID: <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        xieyongji@bytedance.com, david.marchand@redhat.com,
        lulu@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 2, 2023 at 9:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > This small series enables virtio-net device type in VDUSE.
> > With it, basic operation have been tested, both with
> > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > adding VDUSE support using split rings layout (merged in
> > DPDK v23.07-rc1).
> >
> > Control queue support (and so multiqueue) has also been
> > tested, but requires a Kernel series from Jason Wang
> > relaxing control queue polling [1] to function reliably.
> >
> > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0Wv=
jGRr3whU+QasUg@mail.gmail.com/T/
>
> Jason promised to post a new version of that patch.
> Right Jason?

Yes.

> For now let's make sure CVQ feature flag is off?

We can do that and relax on top of my patch.

Thanks

>
> > RFC -> v1 changes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Fail device init if it does not support VERSION_1 (Jason)
> >
> > Maxime Coquelin (2):
> >   vduse: validate block features only with block devices
> >   vduse: enable Virtio-net device type
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > --
> > 2.41.0
>

