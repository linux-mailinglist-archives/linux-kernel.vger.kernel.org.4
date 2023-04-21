Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B86EA462
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjDUHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDUHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446F1BD6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682061085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Hel2lvkUNp3cy9BYWMzYJ5GhkmTlSKb52dwGchz6iE=;
        b=XvdrBRZRrE+wIjMfm07i5aHzqdEWFzRX6NsCaHyBhSQjt485YiCiJQZ9UtpEOyz3npZijD
        6sPqJ6m5wtMqagBH/ZJC/M4LyyQC4r1wCnDQO2MGDqyit29ENGbsDDhj3Lq3S0grx14IPD
        VJXySAZ2u4SzPwBJu3RyEXLXz3FS84g=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Qt1PwXDtOr6-eKUllS2E1A-1; Fri, 21 Apr 2023 03:11:23 -0400
X-MC-Unique: Qt1PwXDtOr6-eKUllS2E1A-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6a604fbda57so1578853a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061083; x=1684653083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hel2lvkUNp3cy9BYWMzYJ5GhkmTlSKb52dwGchz6iE=;
        b=Oj8n+fNMOem1SGCd/16fUoNguSgdRKZMYagP0bw8lP0/JKhlI9Guf1yN7RLySsRMS9
         ju570lnDJx2bVmKKGRyOOSYTjpnwyVzvXflu1aHzU2uSZgu9DIKa8FrCh4xqpuuJPZuD
         VI/oFgkseztUxVF515wphTVTfs0o+Ak1DVWNzYbDioRoPidR0Wa97LnNrPx5/iJDbmKb
         tlum8J7wCDUVsFB8SI8eixKg55OE7jCHraP5DSG2po+digJN2O5ExtC99WWuyMo7rdG3
         dJUDeMNDAn6KPFNFC/BOf9TPbdf5INw/GI3xgT8OPyBedqJdY0RO5vkETqs/pMlnOQrm
         C/tQ==
X-Gm-Message-State: AAQBX9fLWY70Cih8w7Exbq23FZkKczMFTNAB372p7xhdnB9EKTIJNjZ3
        Kvjvhz7QfazMTEPpy6lpGUESWu8CZTqu1GFofv2B8hJlpJF/heUoO6iywHmFIwif3n8v2cbkbJ0
        k86YvVbTv6seBMfE+wFGJlBYgpPtdP+qFQoycXF/h
X-Received: by 2002:aca:100d:0:b0:38e:1ee1:982 with SMTP id 13-20020aca100d000000b0038e1ee10982mr2391091oiq.7.1682061082565;
        Fri, 21 Apr 2023 00:11:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdspLDBkX4UR5Dt85qLMuFsxfyjUCXK87ZmqnGFhfDDXACeESMDThi+Q9XtnTMnXrA9rajHiS8urkCLXJBtO0=
X-Received: by 2002:aca:100d:0:b0:38e:1ee1:982 with SMTP id
 13-20020aca100d000000b0038e1ee10982mr2391079oiq.7.1682061082091; Fri, 21 Apr
 2023 00:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com> <20230421030345-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230421030345-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 21 Apr 2023 15:11:11 +0800
Message-ID: <CACGkMEujFHDR4NCxtBm5DyE_H=xkZA_YnH-p0SNiwbWQFPa_bg@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andrey Smetanin <asmetanin@yandex-team.ru>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
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

On Fri, Apr 21, 2023 at 3:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Dec 01, 2022 at 05:01:58PM +0800, Jason Wang wrote:
> > On Wed, Nov 23, 2022 at 6:24 PM Andrey Smetanin
> > <asmetanin@yandex-team.ru> wrote:
> > >
> > > Fix possible virtqueue used buffers leak and corresponding stuck
> > > in case of temporary -EIO from sendmsg() which is produced by
> > > tun driver while backend device is not up.
> > >
> > > In case of no-retriable error and zcopy do not revert upend_idx
> > > to pass packet data (that is update used_idx in corresponding
> > > vhost_zerocopy_signal_used()) as if packet data has been
> > > transferred successfully.
> >
> > Should we mark head.len as VHOST_DMA_DONE_LEN in this case?
> >
> > Thanks
>
> Jason do you want to take over this work? It's been stuck
> in my inbox for a while.

Andrey,

Any update on this patch?

Btw, if we haven't heard from Andrey for a week, I can do that.

Thanks

>
> > >
> > > Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> > > ---
> > >  drivers/vhost/net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 20265393aee7..93e9166039b9 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -934,13 +934,16 @@ static void handle_tx_zerocopy(struct vhost_net=
 *net, struct socket *sock)
> > >
> > >                 err =3D sock->ops->sendmsg(sock, &msg, len);
> > >                 if (unlikely(err < 0)) {
> > > +                       bool retry =3D err =3D=3D -EAGAIN || err =3D=
=3D -ENOMEM || err =3D=3D -ENOBUFS;
> > > +
> > >                         if (zcopy_used) {
> > >                                 if (vq->heads[ubuf->desc].len =3D=3D =
VHOST_DMA_IN_PROGRESS)
> > >                                         vhost_net_ubuf_put(ubufs);
> > > -                               nvq->upend_idx =3D ((unsigned)nvq->up=
end_idx - 1)
> > > -                                       % UIO_MAXIOV;
> > > +                               if (retry)
> > > +                                       nvq->upend_idx =3D ((unsigned=
)nvq->upend_idx - 1)
> > > +                                               % UIO_MAXIOV;
> > >                         }
> > > -                       if (err =3D=3D -EAGAIN || err =3D=3D -ENOMEM =
|| err =3D=3D -ENOBUFS) {
> > > +                       if (retry) {
> > >                                 vhost_discard_vq_desc(vq, 1);
> > >                                 vhost_net_enable_vq(net, vq);
> > >                                 break;
> > > --
> > > 2.25.1
> > >
>

