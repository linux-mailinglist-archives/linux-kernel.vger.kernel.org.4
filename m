Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250676956BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjBNChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNChP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:37:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A351204A;
        Mon, 13 Feb 2023 18:37:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 16so9253534pfo.8;
        Mon, 13 Feb 2023 18:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaxI42DSfFpxaDhmYDJ0RT3UOsJNqbaTt2BOaS6Cx5c=;
        b=MRqo48WBB3wNVjo2Xj1aDS1fBbf7gfYp7VhQ21bmA+VjqKrDbWnjYKbQgMWpqZ5XTf
         +joKB3HxVpd7Ysot5N9sjUGALcQy652+WOHQviqrIw+D0iyKGAyqEyvRbQZUf8NxKw1y
         GyS7wZs2QCT6zb9vtSTtK3IfTiB+kl2UN+U+b/XA3wYa7mIigkO3UnxoRpXYIbkF+B2j
         ojH/RkTuuoUS230RWli7MvhNqAMAHa9kbtUqqBKoJ/q3x2xCq/KLn7wOmATg/WA2p3/N
         Qy4QXvuB10xfmMq4s7FzbEn1CeLTaxRbMRh3E+Ms88gywpYybI2Q9Z2WZtxIWr7iXEhx
         zE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaxI42DSfFpxaDhmYDJ0RT3UOsJNqbaTt2BOaS6Cx5c=;
        b=zVKipfYNliw1vYM/hax2TMGGNL+1wYRGy+DttF+Jdz0WIogwWZNeiwXw/ME3v5t+GN
         adw1npZ1x5T4zkhHkYz08joHHNCGYpe7uJqWZUqrySY1XgD9P5N7y4YgV+2RNJzzLM+f
         ScGMIYDcy3NEm+BIQ9SLqZ+AYGErf9OpDr3fShFqsInADHhnCL5fc6FlaE+ukJt96ayU
         KsIjX0WlWBJhExv6/otRP7rXqT2PrEzpqS2rsgar90yB3CMu11Dqq/ZQs7x3BoeYP7NL
         6RAKDPCh+3NPfhyHYAa7LmWrzyRJKdIUrE/3Xi52T9i0o6pOf31GAaKZykKn5KtdLnnQ
         JIYg==
X-Gm-Message-State: AO0yUKWhc7KNsxGSeA2kAm2wGRUuoCuV6t1XEM/XPoTGRAptjTpC/nL6
        nKpqsqslEsSh7EASzaPfbEoZMjGL48Xox0ikKn8=
X-Google-Smtp-Source: AK7set8aYMOPDqrFk8MkbEQxZe9hvjJTkkJ1/DIIhc7J3q4173iJ0NqVBEGcsye3r3yn5urXIhbxgg6XgQ/2GauqKXQ=
X-Received: by 2002:a62:5206:0:b0:5a8:d4af:fbdc with SMTP id
 g6-20020a625206000000b005a8d4affbdcmr135964pfb.46.1676342229370; Mon, 13 Feb
 2023 18:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20230202064124.22277-1-zyytlz.wz@163.com> <20230213070906-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230213070906-mutt-send-email-mst@kernel.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 14 Feb 2023 10:36:56 +0800
Message-ID: <CAJedcCxAjsahL1MAjHMfZkOWZD5Rnbq-vgFTvUfFU3zXMUWCaQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in virtscsi_rescan_hotunplug
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=80 20:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Feb 02, 2023 at 02:41:24PM +0800, Zheng Wang wrote:
> > There is no check about the return value of kmalloc in
> > virtscsi_rescan_hotunplug. Add the check to avoid use
> > of null pointer 'inq_result' in case of the failure
> > of kmalloc.
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
>
> I fixed a typo in subject and tweaked the patch a bit

Thanks for your kindness ^^

>
> > v2:
> > - add kfree to avoid memory leak
> > ---
> >  drivers/scsi/virtio_scsi.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> > index d07d24c06b54..a66d8815d738 100644
> > --- a/drivers/scsi/virtio_scsi.c
> > +++ b/drivers/scsi/virtio_scsi.c
> > @@ -330,7 +330,7 @@ static void virtscsi_handle_param_change(struct vir=
tio_scsi *vscsi,
> >       scsi_device_put(sdev);
> >  }
> >
> > -static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> > +static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> >  {
> >       struct scsi_device *sdev;
> >       struct Scsi_Host *shost =3D virtio_scsi_host(vscsi->vdev);
> > @@ -338,6 +338,11 @@ static void virtscsi_rescan_hotunplug(struct virti=
o_scsi *vscsi)
> >       int result, inquiry_len, inq_result_len =3D 256;
> >       char *inq_result =3D kmalloc(inq_result_len, GFP_KERNEL);
> >
> > +     if (!inq_result) {
> > +             kfree(inq_result);
> > +             return -ENOMEM;
> > +     }
> > +
> >       shost_for_each_device(sdev, shost) {
> >               inquiry_len =3D sdev->inquiry_len ? sdev->inquiry_len : 3=
6;
> >
> > @@ -366,6 +371,7 @@ static void virtscsi_rescan_hotunplug(struct virtio=
_scsi *vscsi)
> >       }
> >
> >       kfree(inq_result);
> > +     return 0;
> >  }
> >
> >  static void virtscsi_handle_event(struct work_struct *work)
> > @@ -374,12 +380,15 @@ static void virtscsi_handle_event(struct work_str=
uct *work)
> >               container_of(work, struct virtio_scsi_event_node, work);
> >       struct virtio_scsi *vscsi =3D event_node->vscsi;
> >       struct virtio_scsi_event *event =3D &event_node->event;
> > +     int ret =3D 0;
> >
>
> dropped =3D 0 here

Get it.

>
> >       if (event->event &
> >           cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
>
> and moved declaration here.

Will do in the next version of patch.
>
> >               event->event &=3D ~cpu_to_virtio32(vscsi->vdev,
> >                                                  VIRTIO_SCSI_T_EVENTS_M=
ISSED);
> > -             virtscsi_rescan_hotunplug(vscsi);
> > +             ret =3D virtscsi_rescan_hotunplug(vscsi);
> > +             if (ret)
> > +                     return;
> >               scsi_scan_host(virtio_scsi_host(vscsi->vdev));
> >       }
> >
> > --
> > 2.25.1
> >
> >
>
