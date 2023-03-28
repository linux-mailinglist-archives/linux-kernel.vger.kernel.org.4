Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68E6CB692
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC1GIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1GIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E01995
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679983679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0Vc6MylE0cQeMrB6SHC1KjX7fRlexD9+rdnaEldCZQ=;
        b=VX6H1zaqYsvhlyBSNFOza85sL34n0bp48ZzoPVi/zJ5YRg1foiB9zdxDhN2Dhh9wj9zAQ+
        7bifUtT3DTXA9jfeAKJ10DQGpIImYE+bWAssz5bcVaYun82LwECcPkf/2POUALFqwsewTk
        fO5mhowzQ9WR1M6yovfPsARqdsyqmd0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-24g6QU75Pa6_J6sEoncTRg-1; Tue, 28 Mar 2023 02:07:57 -0400
X-MC-Unique: 24g6QU75Pa6_J6sEoncTRg-1
Received: by mail-oo1-f72.google.com with SMTP id 62-20020a4a0341000000b0053e2e3db15dso1330582ooi.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679983676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0Vc6MylE0cQeMrB6SHC1KjX7fRlexD9+rdnaEldCZQ=;
        b=Ih6szjP9V3euou3i5SWqvXWsqqIjpWPW2fL4VGHsWyVi31WZ/TEkR3a6UPRPvIpzb6
         H0NFgsu7ThGt1Hgap0ooUI6n/sntVACj3I4DUC/7QrbK/dwRNSR9t+hkelR9pgiPYRpj
         ydUQCN4R0vFfjWEv+J5jM8VGf4tRbFi+3LAe5Xt1D/QcIlHG8j+6wifjt2ud2j1AJpBG
         X1kE62UqbbF51f+xGnPwfhl/K1sQulm9miEqTFyxipQH/UGTflqSwYgZdSn9DlGoJB4A
         4knibWrYV0scYB+xFWV6u7HQo2YloTlNqf8DBahLET6sfHOCBIspRlWcTVAGWzIBuGEQ
         YEpg==
X-Gm-Message-State: AAQBX9dx0VZEfTzXzboJsT37/cZ3ql4xWqR/is5FuI7sz87AcIrzN7pC
        98GDUU78XJFiSljwZrzSa3yyrVwoeiVGcjF0a1IPDdZZtcC9KQo9GQPUFJzrI/1QdK4GdI6ta54
        kGe89oWjAHtm08vnvLRYV0ZMKIxXI7G5qDCK+XXPeP+k5uhuqT+M=
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id m18-20020a0568080f1200b003894edddeb8mr741859oiw.9.1679983676294;
        Mon, 27 Mar 2023 23:07:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350byREbJffOwxc746aJJUIjiY3s4O20O5cWDp8FTjfHkZLNpHWRedA1rifb7FpV0bXF4S8vgyh9U9DMpp9Gxv7w=
X-Received: by 2002:a05:6808:f12:b0:389:4edd:deb8 with SMTP id
 m18-20020a0568080f1200b003894edddeb8mr741851oiw.9.1679983676036; Mon, 27 Mar
 2023 23:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
 <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
 <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
 <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com> <CACycT3vCqisBS0OyMsnyrw0i6kWTDqSZ4GQbdoycHz-L3=1Q7Q@mail.gmail.com>
In-Reply-To: <CACycT3vCqisBS0OyMsnyrw0i6kWTDqSZ4GQbdoycHz-L3=1Q7Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Mar 2023 14:07:44 +0800
Message-ID: <CACGkMEvAUPakxFEuZPTGTQXwkhoTsU+hwdnjeV-vzGRFK1Qygg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:05=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
>
> On Tue, Mar 28, 2023 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Mar 28, 2023 at 11:33=E2=80=AFAM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > >
> > > On Tue, Mar 28, 2023 at 11:14=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Mar 28, 2023 at 11:03=E2=80=AFAM Yongji Xie <xieyongji@byte=
dance.com> wrote:
> > > > >
> > > > > On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@b=
ytedance.com> wrote:
> > > > > > >
> > > > > > > To support interrupt affinity spreading mechanism,
> > > > > > > this makes use of group_cpus_evenly() to create
> > > > > > > an irq callback affinity mask for each virtqueue
> > > > > > > of vdpa device. Then we will unify set_vq_affinity
> > > > > > > callback to pass the affinity to the vdpa device driver.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > >
> > > > > > Thinking hard of all the logics, I think I've found something i=
nteresting.
> > > > > >
> > > > > > Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tr=
ies to
> > > > > > pass irq_affinity to transport specific find_vqs().  This seems=
 a
> > > > > > layer violation since driver has no knowledge of
> > > > > >
> > > > > > 1) whether or not the callback is based on an IRQ
> > > > > > 2) whether or not the device is a PCI or not (the details are h=
ided by
> > > > > > the transport driver)
> > > > > > 3) how many vectors could be used by a device
> > > > > >
> > > > > > This means the driver can't actually pass a real affinity masks=
 so the
> > > > > > commit passes a zero irq affinity structure as a hint in fact, =
so the
> > > > > > PCI layer can build a default affinity based that groups cpus e=
venly
> > > > > > based on the number of MSI-X vectors (the core logic is the
> > > > > > group_cpus_evenly). I think we should fix this by replacing the
> > > > > > irq_affinity structure with
> > > > > >
> > > > > > 1) a boolean like auto_cb_spreading
> > > > > >
> > > > > > or
> > > > > >
> > > > > > 2) queue to cpu mapping
> > > > > >
> > > > >
> > > > > But only the driver knows which queues are used in the control pa=
th
> > > > > which don't need the automatic irq affinity assignment.
> > > >
> > > > Is this knowledge awarded by the transport driver now?
> > > >
> > >
> > > This knowledge is awarded by the device driver rather than the transp=
ort driver.
> > >
> > > E.g. virtio-scsi uses:
> > >
> > >     struct irq_affinity desc =3D { .pre_vectors =3D 2 }; // vq0 is co=
ntrol
> > > queue, vq1 is event queue
> >
> > Ok, but it only works as a hint, it's not a real affinity. As replied,
> > we can pass an array of boolean in this case then transport driver
> > knows it doesn't need to use automatic affinity for the first two
> > queues.
> >
>
> But we don't know whether we would use other fields in structure
> irq_affinity in the future. So a full set should be better?

Good point. So the issue is the calc_sets() and we probably need that
if there's a virtio driver that needs more than one set of vectors
that needs to be spreaded. Technically, we could have a virtio level
abstraction for this but I agree it's probably not worth bothering
now.

>
> > >
> > > > E.g virtio-blk uses:
> > > >
> > > >         struct irq_affinity desc =3D { 0, };
> > > >
> > > > Atleast we can tell the transport driver which vq requires automati=
c
> > > > irq affinity.
> > > >
> > >
> > > I think that is what the current implementation does.
> > >
> > > > > So I think the
> > > > > irq_affinity structure can only be created by device drivers and
> > > > > passed to the virtio-pci/virtio-vdpa driver.
> > > >
> > > > This could be not easy since the driver doesn't even know how many
> > > > interrupts will be used by the transport driver, so it can't built =
the
> > > > actual affinity structure.
> > > >
> > >
> > > The actual affinity mask is built by the transport driver,
> >
> > For PCI yes, it talks directly to the IRQ subsystems.
> >
> > > device
> > > driver only passes a hint on which queues don't need the automatic ir=
q
> > > affinity assignment.
> >
> > But not for virtio-vDPA since the IRQ needs to be dealt with by the
> > parent driver. For our case, it's the VDUSE where it doesn't need IRQ
> > at all, a queue to cpu mapping is sufficient.
> >
>
> The device driver doesn't know whether it is binded to virtio-pci or
> virtio-vdpa. So it should pass a full set needed by the automatic irq
> affinity assignment instead of a subset. Then virtio-vdpa can choose
> to pass a queue to cpu mapping to VDUSE, which is what we do now (use
> set_vq_affinity()).

Yes, so basically two ways:

1) automatic IRQ management, passing affd to find_vqs(), affinity was
determined by the transport (e.g vDPA).
2) affinity that is under the control of the driver, it needs to use
set_vq_affinity() but need to deal with cpu hotplug stuffs.

Thanks

>
> Thanks,
> Yongji
>

