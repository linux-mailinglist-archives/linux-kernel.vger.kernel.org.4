Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED46CB548
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjC1EF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1EFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:05:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9CDE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:04:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o11so10468214ple.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679976295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LErsHmsbRWX1t/tlmcxX2OThlM8pztoVwbQlHV2TBMA=;
        b=hZz2FWcWLz63/gqfIBEoqW9H85wulv/9+vjqu8L8Iz4De2+0LXj9tHSZm8aEeN6A99
         +Z/ZKIh8oc6pBnK/P7n1Ozj7MB9pQNsczMe+kaKhyydY6WxzGp2rDAMDTMelshih1B4S
         fAj6FStGtnQb37wbWEmEPW96SuCH/LUwitCQzoaXmhnYk9uMFaKT1UQnl2IeADXi+z+3
         Fjzw+TglH9fskNnhCIZK6TRntyWul3lhBtsYgk4cFolT9BISt8fkHEX5fiUK9oHot54Y
         Gj8qQf7/8jtZGdaUgXyL7Z7wke2jVRQl6Zv4+282jwTuKb8zSkxdIvbrGDl5csiHXyFu
         GeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679976295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LErsHmsbRWX1t/tlmcxX2OThlM8pztoVwbQlHV2TBMA=;
        b=fDU0OZV5OorsEu8OcmnQMiLcgkd0u3tR8dyX9Eglo9FrtXNPiNnf3Z1pu6HOIByNr3
         PAFo3Fuk275FjelHpBIaEj1x7MRGbVdosl8xg0kEMjPyUU0MwLZgit0KidVDN3A0a8I/
         vDxt5PA/tCN/6G623C9mfpasdFnDye82/UFAbCbu0ZQGse95sko6C3/mrKkD6Scn13dQ
         znoWsT1hM5FBiyIyp0xBJvnO2GGXI48dTUdLMdAcGfVWrLmf+DnuTakef91UQpQ9O1dA
         gH74Dt5phEK+2FsGa0a1dyyHBqsvgF2TmkinHWvhGV/jZ1j9ltW5Eo85wGow93zvGWrM
         WCmA==
X-Gm-Message-State: AAQBX9d687lQHaO4Ncl3dOqFlSUNmt9BdBR3ef9zf9Ef40fS+tGlAij3
        R/QIhyS/zP1TMzaJ75EvCDaCbqMCZoOxuYrarlS1
X-Google-Smtp-Source: AKy350aTVF4mnyqnOsPX/ZPu+50kYzQB8qDW/3m5DGmQ8jXqXkHnQYyqis9JMJNdpaNYVmJxH5/ik9U6PbMpTTBxhR0=
X-Received: by 2002:a17:902:f693:b0:1a1:8bf0:a75a with SMTP id
 l19-20020a170902f69300b001a18bf0a75amr5015786plg.13.1679976295532; Mon, 27
 Mar 2023 21:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
 <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
 <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com> <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com>
In-Reply-To: <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 28 Mar 2023 12:04:44 +0800
Message-ID: <CACycT3vCqisBS0OyMsnyrw0i6kWTDqSZ4GQbdoycHz-L3=1Q7Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 28, 2023 at 11:33=E2=80=AFAM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> >
> > On Tue, Mar 28, 2023 at 11:14=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Mar 28, 2023 at 11:03=E2=80=AFAM Yongji Xie <xieyongji@byteda=
nce.com> wrote:
> > > >
> > > > On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@byt=
edance.com> wrote:
> > > > > >
> > > > > > To support interrupt affinity spreading mechanism,
> > > > > > this makes use of group_cpus_evenly() to create
> > > > > > an irq callback affinity mask for each virtqueue
> > > > > > of vdpa device. Then we will unify set_vq_affinity
> > > > > > callback to pass the affinity to the vdpa device driver.
> > > > > >
> > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > >
> > > > > Thinking hard of all the logics, I think I've found something int=
eresting.
> > > > >
> > > > > Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") trie=
s to
> > > > > pass irq_affinity to transport specific find_vqs().  This seems a
> > > > > layer violation since driver has no knowledge of
> > > > >
> > > > > 1) whether or not the callback is based on an IRQ
> > > > > 2) whether or not the device is a PCI or not (the details are hid=
ed by
> > > > > the transport driver)
> > > > > 3) how many vectors could be used by a device
> > > > >
> > > > > This means the driver can't actually pass a real affinity masks s=
o the
> > > > > commit passes a zero irq affinity structure as a hint in fact, so=
 the
> > > > > PCI layer can build a default affinity based that groups cpus eve=
nly
> > > > > based on the number of MSI-X vectors (the core logic is the
> > > > > group_cpus_evenly). I think we should fix this by replacing the
> > > > > irq_affinity structure with
> > > > >
> > > > > 1) a boolean like auto_cb_spreading
> > > > >
> > > > > or
> > > > >
> > > > > 2) queue to cpu mapping
> > > > >
> > > >
> > > > But only the driver knows which queues are used in the control path
> > > > which don't need the automatic irq affinity assignment.
> > >
> > > Is this knowledge awarded by the transport driver now?
> > >
> >
> > This knowledge is awarded by the device driver rather than the transpor=
t driver.
> >
> > E.g. virtio-scsi uses:
> >
> >     struct irq_affinity desc =3D { .pre_vectors =3D 2 }; // vq0 is cont=
rol
> > queue, vq1 is event queue
>
> Ok, but it only works as a hint, it's not a real affinity. As replied,
> we can pass an array of boolean in this case then transport driver
> knows it doesn't need to use automatic affinity for the first two
> queues.
>

But we don't know whether we would use other fields in structure
irq_affinity in the future. So a full set should be better?

> >
> > > E.g virtio-blk uses:
> > >
> > >         struct irq_affinity desc =3D { 0, };
> > >
> > > Atleast we can tell the transport driver which vq requires automatic
> > > irq affinity.
> > >
> >
> > I think that is what the current implementation does.
> >
> > > > So I think the
> > > > irq_affinity structure can only be created by device drivers and
> > > > passed to the virtio-pci/virtio-vdpa driver.
> > >
> > > This could be not easy since the driver doesn't even know how many
> > > interrupts will be used by the transport driver, so it can't built th=
e
> > > actual affinity structure.
> > >
> >
> > The actual affinity mask is built by the transport driver,
>
> For PCI yes, it talks directly to the IRQ subsystems.
>
> > device
> > driver only passes a hint on which queues don't need the automatic irq
> > affinity assignment.
>
> But not for virtio-vDPA since the IRQ needs to be dealt with by the
> parent driver. For our case, it's the VDUSE where it doesn't need IRQ
> at all, a queue to cpu mapping is sufficient.
>

The device driver doesn't know whether it is binded to virtio-pci or
virtio-vdpa. So it should pass a full set needed by the automatic irq
affinity assignment instead of a subset. Then virtio-vdpa can choose
to pass a queue to cpu mapping to VDUSE, which is what we do now (use
set_vq_affinity()).

Thanks,
Yongji
