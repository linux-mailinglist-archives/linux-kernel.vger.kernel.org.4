Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085786F9F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjEHGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEHGOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3B1885A
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683526437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnGoERqYvEOx4rgm1MihSTLdb9c387eTW69LQCmBdTs=;
        b=Tp5YhECpeQPgptEKaUpU1ncGkbv3WYdFzzmrHn73gOWxWM9Zp1IcwWVP65Lm6WH+f8hKS/
        XvRpH7qx7kVmAMCuDSeApC6hqL5qOU8OP9H8WTZcnJTBkjXJRgEB1u858JbLbX3MhMa3AE
        V7VF9Pify3nIBN0104lNkNnXY2N5IfE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-ELD1ETIVMp-ks9i9vwaQJg-1; Mon, 08 May 2023 02:13:55 -0400
X-MC-Unique: ELD1ETIVMp-ks9i9vwaQJg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4edc7406cb5so2394286e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 23:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683526434; x=1686118434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnGoERqYvEOx4rgm1MihSTLdb9c387eTW69LQCmBdTs=;
        b=LcpM0yZzRsF/yNRYwHtkADm0uN4zvwInlr/gU6LQBnY6++c6mzkwbjjNFB49z7oqrQ
         lCQn7EetEi8V5Pa5fQLvcAxwKS2g1uN5hc4fpOETnrHdBEn5pbL9a9xGmFghmWifV7I9
         mzPG0dW4zFUrjOKV0UXQ+O8uMxRDJW/ZevdXxJgJRsdC7oF4S1rvbjrfyO/cA9TWlq8C
         50OoJYyj/EWDVg/73E2bx+hxgWBU185W9R1VGr6tgLV/nqVPjyutPQWAYti0bwgMyPzw
         jl1JMPLeasXj/Yv9sjqQeiW0B1flwfS/yBX1WQxjdr1ew9YM+8IHU6qyMOJ65q0NCno6
         f+6g==
X-Gm-Message-State: AC+VfDwtFSWIha3QH+BiS2Hlb0DZoMYBUGvTI660mCZ/pTTfJ6g5mjXw
        HtBjHvCmWYNgsfwyZQZenBfD/dYEyoyYabUgo3GGEnotQiPscqwPnauZ0PKGZu41Bi6sG3fcRaI
        n0ozEx/AonM9FE7DNZCStbaUjKQVHTDl8SZ2X8VaC
X-Received: by 2002:ac2:593b:0:b0:4ef:ef67:65c9 with SMTP id v27-20020ac2593b000000b004efef6765c9mr2058507lfi.23.1683526434064;
        Sun, 07 May 2023 23:13:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xe3F00uxjHFgO1bBN466ruxcj/9ORWBBNpVG7tQRZFYEKmzPnbfmii1vtrAf20GtOe/ACrR9OgSj4WDi/k7E=
X-Received: by 2002:ac2:593b:0:b0:4ef:ef67:65c9 with SMTP id
 v27-20020ac2593b000000b004efef6765c9mr2058496lfi.23.1683526433776; Sun, 07
 May 2023 23:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
 <20230507093328-mutt-send-email-mst@kernel.org> <2b5cf90a-efa8-52a7-9277-77722622c128@redhat.com>
 <20230508020717-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508020717-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 8 May 2023 14:13:42 +0800
Message-ID: <CACGkMEuQdy8xi=eD4v7-UNQ12xOUdnuyQ73vvC6vdGXUfeasug@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wenliang Wang <wangwenliang.1995@bytedance.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 2:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, May 08, 2023 at 11:12:03AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2023/5/7 21:34, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > On Fri, May 05, 2023 at 11:28:25AM +0800, Jason Wang wrote:
> > > > On Thu, May 4, 2023 at 10:27=E2=80=AFAM Wenliang Wang
> > > > <wangwenliang.1995@bytedance.com> wrote:
> > > > > For multi-queue and large ring-size use case, the following error
> > > > > occurred when free_unused_bufs:
> > > > > rcu: INFO: rcu_sched self-detected stall on CPU.
> > > > >
> > > > > Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> > > > > Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > > > > ---
> > > > > v2:
> > > > > -add need_resched check.
> > > > > -apply same logic to sq.
> > > > > v3:
> > > > > -use cond_resched instead.
> > > > > v4:
> > > > > -add fixes tag
> > > > > ---
> > > > >   drivers/net/virtio_net.c | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8d8038538fc4..a12ae26db0e2 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtn=
et_info *vi)
> > > > >                  struct virtqueue *vq =3D vi->sq[i].vq;
> > > > >                  while ((buf =3D virtqueue_detach_unused_buf(vq))=
 !=3D NULL)
> > > > >                          virtnet_sq_free_unused_buf(vq, buf);
> > > > > +               cond_resched();
> > > > Does this really address the case when the virtqueue is very large?
> > > >
> > > > Thanks
> > >
> > > it does in that a very large queue is still just 64k in size.
> > > we might however have 64k of these queues.
> >
> >
> > Ok, but we have other similar loops especially the refill, I think we m=
ay
> > need cond_resched() there as well.
> >
> > Thanks
> >
>
> Refill is already per vq isn't it?

Not for the refill_work().

Thanks

>
>
> > >
> > > > >          }
> > > > >
> > > > >          for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > >                  struct virtqueue *vq =3D vi->rq[i].vq;
> > > > >                  while ((buf =3D virtqueue_detach_unused_buf(vq))=
 !=3D NULL)
> > > > >                          virtnet_rq_free_unused_buf(vq, buf);
> > > > > +               cond_resched();
> > > > >          }
> > > > >   }
> > > > >
> > > > > --
> > > > > 2.20.1
> > > > >
>

