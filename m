Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94601651E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiLTKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiLTKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:14:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD5AE5E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:14:18 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so27933780ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H7kzZRNuyTs8t13T1cf2+aWiYOHBrlmOO5iLWAT2BiY=;
        b=B23yCIzbqBXB9nYLVk+QMC1x0zeMZRIADdCGYMlxjvglReuraK82hfqEOJxMqySKpZ
         JGfFHulidstuCKX8fRBu94ZxB3SBqZwuVTl+2T0cYIrrA0Ru0D6v2/DyGeYI1+pQ1FvS
         u8Rh16pm5baBMhrTSvgVPbjMy5igHxT4Zh0mayvRuFabJrVq5oyqXgT/7PV80nbbSI0J
         gnlD8ZFrYctyN+ugC4u1S7CWraB1iOcDkM8ndc32KlhbLEofHODe5Y3bXtomUxISiHZf
         JzqRdSc2pv/T0PmPHfSJeW55XOxAy5uzRSJd7N1CYoKUlGNmpQQhtil5vctElpso6Ts7
         F8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7kzZRNuyTs8t13T1cf2+aWiYOHBrlmOO5iLWAT2BiY=;
        b=jlFyxij4elnAffKQl833KyWXFDX/A7w3bUkOc4QSaofCXNoesLUXQiVmcDw7SwzfDM
         hkwshna/HmTwNlgBX1hKEwbx2iFW7SK/dUr4IdQU3reUQjCaihICWJiy3M8/0VSNDeb0
         C19XZanPjBvoPOsn/lr0w8SwiHVAEjBeUflId/gRRt/dZiYkSlft4vBHVqIlOa6szX+O
         D5M6s1N5EOA0FR/7yRhKc8NsSM+uaXlP310EoEOe0FRNYf1WmRjXRiwC5pvo99LLVZnz
         79wEjpLdFvwkSirKTuqF9F+UNuex7sl76raQ/5ksr8qCTiIjKVb45+PYhIlFB1EIxK8j
         o2pQ==
X-Gm-Message-State: ANoB5pmPnLCJV3iF60fzMaWtqxZe+LGDQBC1hvn6NuFxVN5Kyy0nDEbC
        4pjvPs/+xTQfNIvzV1Hm9lUZyqsyabG+7I4cCw6fkcxS7Zl7
X-Google-Smtp-Source: AA0mqf5nBD1sBWOMXFnmPajsNmL86+mKphEI8vu6mxtnIuuq/RmDw9Mk/ZcFdj5LTa2EK6G9DgY4jwszRs+GRCOVfKA=
X-Received: by 2002:a17:906:265b:b0:7c1:6fdf:3b70 with SMTP id
 i27-20020a170906265b00b007c16fdf3b70mr2041793ejc.619.1671531256887; Tue, 20
 Dec 2022 02:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
 <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
 <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com> <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com>
In-Reply-To: <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 20 Dec 2022 18:14:04 +0800
Message-ID: <CACycT3vP42dpq5NXFJ-Qua=MKsW9visq+mykS7H6i9gUcqo4NQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 2:31 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 3:12 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > >
> > > > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > >
> > > > > > This introduces set_irq_affinity callback in
> > > > > > vdpa_config_ops so that vdpa device driver can
> > > > > > get the interrupt affinity hint from the virtio
> > > > > > device driver. The interrupt affinity hint would
> > > > > > be needed by the interrupt affinity spreading
> > > > > > mechanism.
> > > > > >
> > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > > > >  include/linux/vdpa.h         | 8 ++++++++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > +       struct irq_affinity default_affd = { 0 };
> > > > > >         struct vdpa_callback cb;
> > > > > >         int i, err, queue_idx = 0;
> > > > > >
> > > > > > +       if (ops->set_irq_affinity)
> > > > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > > > >
> > > > > I wonder if we need to do this in vhost-vDPA.
> > > >
> > > > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
> > >
> > > If I was not wrong, this tries to set affinity on the host instead of
> > > the guest. More below.
> > >
> >
> > Yes, it's host stuff. This is used by the virtio device driver to pass
> > the irq affinity hint (tell which irq vectors don't need affinity
> > management) to the irq affinity manager. In the VM case, it should
> > only be related to the guest's virtio device driver and pci irq
> > affinity manager. So I don't get why we need to do this in vhost-vDPA.
>
> It's not necessarily the VM, do we have the same requirement for
> userspace (like DPDK) drivers?
>

IIUC the vhost-vdpa's irq callback just signals the eventfd. I didn't
see how to use the irq affinity hint in vdpa device driver. The real
irq callback should be called in DPDK internally.

Thanks,
Yongji
