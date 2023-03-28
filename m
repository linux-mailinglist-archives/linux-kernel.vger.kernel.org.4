Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE856CB470
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC1DDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1DDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:03:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDD1FE7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:03:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w4so10329026plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679972602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jneq/GANdehmIvLuc1I+eb/hvcf7UfuDEQEk+5ugBPU=;
        b=SZG72enAMBCiLEDZ3jl9/O8wx28e7unRCWE3qCxokC7VQq/VOswoEH7bHSErzlTihd
         eS3epPH4e51orvV4ZJ+bxt9mM+M5Oe5tjRIN+Kkzjzd5yTmdji3IQll/hSSRHUaFaWFN
         Cb29BWfFD3f1JFNFW8YP65utlOZFrJLe+gETp7sjBPxQoZdEmjEl4kwbPI5HFf4QLKCq
         4TUdvPnzAkKyvVIY3+Jcl2wGOpPJ80+987YlYPQWRqx6HSeI7XD02RNsgFFHGXEJPAVI
         tudYzxTxh2ex+x5M3UkWxOoy8neNIts8hNDN5M3UtDMi2v2KTh/sQxc3e4wHsyk8ovvm
         YIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679972602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jneq/GANdehmIvLuc1I+eb/hvcf7UfuDEQEk+5ugBPU=;
        b=yll/ViskDO8WmHtNViveqqsyoSG4utVSxKKJeuFfJz748bUgLe9LWyC7Zj1j3RyTIq
         LyNvzi1Jdu/f6PoZcxI046DJpS4Pu+1rdFX6OZ5RO4EifQGilyWlB/KOcqiZYj7CU30s
         LJKk3yS9mx1WJ2QKqaPyQ2hhVbbDjXrc8+hVLWNKdMbdKYnuNvt2lzmOxlqtZPXZDL/c
         0WoXekhEzm7xAMFuozaj1rCYpPK0TNZ2TX9+9RXSukR9QPejA78B6sAJHezy1e2ljTMr
         Qatb5Il21rbqM2nzBfT2QWTUQLxz5v0uYINpd+PkgjJmTjimFZxfYGv7YWH52NI908j3
         e+7w==
X-Gm-Message-State: AAQBX9dUujyu/WIDIAM7m25yUu2li9rl4+KZSw1se+K9edR+kheJobCm
        Uhab4dOlqEmFrm572D4/tsDDAMDJzfoiGs/DOOzv
X-Google-Smtp-Source: AKy350aV2K7TZmTSLnKfayvKhRJIfgahi334+sDgdvli/gvrMFQTnZmelzH1kHLYkw0buI+gxcs0u2NgguvDIjzM+Uk=
X-Received: by 2002:a17:90a:bf0b:b0:23d:54c1:27b0 with SMTP id
 c11-20020a17090abf0b00b0023d54c127b0mr4195804pjs.6.1679972602134; Mon, 27 Mar
 2023 20:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
In-Reply-To: <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 28 Mar 2023 11:03:11 +0800
Message-ID: <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
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

On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@bytedance.c=
om> wrote:
> >
> > To support interrupt affinity spreading mechanism,
> > this makes use of group_cpus_evenly() to create
> > an irq callback affinity mask for each virtqueue
> > of vdpa device. Then we will unify set_vq_affinity
> > callback to pass the affinity to the vdpa device driver.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> Thinking hard of all the logics, I think I've found something interesting=
.
>
> Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
> pass irq_affinity to transport specific find_vqs().  This seems a
> layer violation since driver has no knowledge of
>
> 1) whether or not the callback is based on an IRQ
> 2) whether or not the device is a PCI or not (the details are hided by
> the transport driver)
> 3) how many vectors could be used by a device
>
> This means the driver can't actually pass a real affinity masks so the
> commit passes a zero irq affinity structure as a hint in fact, so the
> PCI layer can build a default affinity based that groups cpus evenly
> based on the number of MSI-X vectors (the core logic is the
> group_cpus_evenly). I think we should fix this by replacing the
> irq_affinity structure with
>
> 1) a boolean like auto_cb_spreading
>
> or
>
> 2) queue to cpu mapping
>

But only the driver knows which queues are used in the control path
which don't need the automatic irq affinity assignment. So I think the
irq_affinity structure can only be created by device drivers and
passed to the virtio-pci/virtio-vdpa driver.

> So each transport can do its own logic based on that. Then virtio-vDPA
> can pass that policy to VDUSE where we only need a group_cpus_evenly()
> and avoid duplicating irq_create_affinity_masks()?
>

I don't get why we would have duplicated irq_create_affinity_masks().

Thanks,
Yongji
