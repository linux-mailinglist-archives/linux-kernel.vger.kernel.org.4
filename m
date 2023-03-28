Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7B6CB4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjC1DPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjC1DPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24570212B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679973264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfSd4iprB6xpdvDd+tF+/DbujSEekae1K8j4YlTNtK0=;
        b=Znh9byUZV/IVjJQXCDv5ZbPe+BJTX/zKPuTmQPosQcC4gwIWcPSN2FGlAj/g+uopgd0qox
        klhypw7ZXLasJW1sAZJ6DS9U+yg7B21rOOByXXxMpLmtL8//rmbNjWxzyp1Pj7ayC+o+10
        Wy/O3BYria6U4fEWiut+8WNEP8MYq0U=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Ba1pO_7MMpiCRL2-7fsswA-1; Mon, 27 Mar 2023 23:14:22 -0400
X-MC-Unique: Ba1pO_7MMpiCRL2-7fsswA-1
Received: by mail-oo1-f70.google.com with SMTP id t18-20020a4a7452000000b00525456d55f7so2633631ooe.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679973262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfSd4iprB6xpdvDd+tF+/DbujSEekae1K8j4YlTNtK0=;
        b=BrurhtVOs8x8qzRSlM+fk3yy53qO7lxSc5DmENt1ZlEaWjarZ/kiiiib62ahYAvYqp
         CXGjVrCDpfDwbGYAYis8faY/g3KqYi/qeK3UHSAaeiuHC00nsumBGxF9PRYvjMD02QSV
         rTOYGKJZK5bCchribKgvapWinQsYSk/z8UQn8hnhX5njPyVRQTruMP/1eXX0ncPWyosz
         2EFM79pk6W4ev9qWWGp1GdUSqYmUBSE35CaLR7qDiv1q/BhWmh6qkoEp/UN+dv4DplQa
         c+SuwBCLuZlM1rQXWZqIctmzJRbppxoLl9BWhUljBnOY7+lGk07JMpmsguSJIpmqP8fA
         D/VQ==
X-Gm-Message-State: AO0yUKWgSp/N8+oh7grNytYGCBDESIWG0R8bpb7CHA5yDgMorKuV5hUz
        6TP5MOXgqfFQYmK/Vs/dq0rUoedXm6TvzZ8mWVfH4DJePS+TFQkVVlVG/ELYn2igcbrZE72Dl0P
        42y35wJbmKRjMFOIz4vL6pc9yuMXo/DX92DUaPo96
X-Received: by 2002:a05:6871:4983:b0:17e:e3b2:6d99 with SMTP id tx3-20020a056871498300b0017ee3b26d99mr3938743oab.9.1679973262032;
        Mon, 27 Mar 2023 20:14:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set83X5uRalp/q1Az1aXoaYAcjZMuoq/FCcOLJr4KBwApiTagb5if8djVQwLei3LjA/chntfq8CUYDDNtc/l5cAA=
X-Received: by 2002:a05:6871:4983:b0:17e:e3b2:6d99 with SMTP id
 tx3-20020a056871498300b0017ee3b26d99mr3938742oab.9.1679973261812; Mon, 27 Mar
 2023 20:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com> <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
In-Reply-To: <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Mar 2023 11:14:10 +0800
Message-ID: <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com>
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

On Tue, Mar 28, 2023 at 11:03=E2=80=AFAM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
>
> On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@bytedance=
.com> wrote:
> > >
> > > To support interrupt affinity spreading mechanism,
> > > this makes use of group_cpus_evenly() to create
> > > an irq callback affinity mask for each virtqueue
> > > of vdpa device. Then we will unify set_vq_affinity
> > > callback to pass the affinity to the vdpa device driver.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > Thinking hard of all the logics, I think I've found something interesti=
ng.
> >
> > Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
> > pass irq_affinity to transport specific find_vqs().  This seems a
> > layer violation since driver has no knowledge of
> >
> > 1) whether or not the callback is based on an IRQ
> > 2) whether or not the device is a PCI or not (the details are hided by
> > the transport driver)
> > 3) how many vectors could be used by a device
> >
> > This means the driver can't actually pass a real affinity masks so the
> > commit passes a zero irq affinity structure as a hint in fact, so the
> > PCI layer can build a default affinity based that groups cpus evenly
> > based on the number of MSI-X vectors (the core logic is the
> > group_cpus_evenly). I think we should fix this by replacing the
> > irq_affinity structure with
> >
> > 1) a boolean like auto_cb_spreading
> >
> > or
> >
> > 2) queue to cpu mapping
> >
>
> But only the driver knows which queues are used in the control path
> which don't need the automatic irq affinity assignment.

Is this knowledge awarded by the transport driver now?

E.g virtio-blk uses:

        struct irq_affinity desc =3D { 0, };

Atleast we can tell the transport driver which vq requires automatic
irq affinity.

> So I think the
> irq_affinity structure can only be created by device drivers and
> passed to the virtio-pci/virtio-vdpa driver.

This could be not easy since the driver doesn't even know how many
interrupts will be used by the transport driver, so it can't built the
actual affinity structure.

>
> > So each transport can do its own logic based on that. Then virtio-vDPA
> > can pass that policy to VDUSE where we only need a group_cpus_evenly()
> > and avoid duplicating irq_create_affinity_masks()?
> >
>
> I don't get why we would have duplicated irq_create_affinity_masks().

I meant the create_affinity_masks() in patch 3 seems a duplication of
irq_create_affinity_masks().

Thanks

>
> Thanks,
> Yongji
>

