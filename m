Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF1651C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiLTIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLTIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:25:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B32178AC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:24:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c17so16361865edj.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 00:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vn9Nt9IJlIMMg9LSThVifFo0TYNvYT361Pi382B0888=;
        b=jx1t0UmKWYYGeYew+Prv1/KTMXe4NVP1XdzX6/GnM0M3k9//zj4kooOPQXvcPu75LH
         GCmCdDrHwI4sFxhFlHdc5GfTOuLxFA+uRpxs/2srtHiayEFQiwcmTepPdBK8ntKRT7ZC
         43ffFyv9l1TJlboTSFjSyUswCC5VqcVzYdAGkgyyoNFCetacuEDrcidB4qNpUlz9zSoH
         X9zCH0QficOj4ARwc5lECKhaNeEt3AjOHrl7LAnHzljKAmyXVQ1LVG/hZ0bCaeBDmlzD
         SADUE6xhKw5RAx/II/8JQbhGAnUTsPKqoIuDzicHv4BQuC7SNwbsEuH49vgyvJBKqtM4
         YQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn9Nt9IJlIMMg9LSThVifFo0TYNvYT361Pi382B0888=;
        b=g4jirFwaafV3nikU2+85pwdFYVrSx3wpJtqSERsRngZ4Ezhry+JDcP4upd7UMdjUk6
         eBnzUudJJK+6kNHMWrinUMmYxif4SiCQ/jOTuNgs2zRoAb1b+gWOUjvDg9NAshHzwbfO
         OeUP5Q9iYZM5EAILPXX8JCVnvke7XDbZJkBX4hlqX6OF63Aq72bK6agBOs7xfwLkMR0v
         SXl75KAc2ebwBDei7/NwvDJoKTTErJNaeHUme9DvBbzPkjOPTCabTiA3tpES7swfFBLy
         4qQy+lwXuXgp7D1OqrS7X/ToaIggcYeonmvk3/ekegqTGK9s16KUFoCINAgIqRS094Ei
         e0iw==
X-Gm-Message-State: ANoB5pmofgXkWqcdDiBs4Es9obJbLt4LevnHmE9WYTpI9+D+rMqDj2b+
        0xf4vEtP1Qiv06Oxm/Ry5qn8Ydp5Rsh/83XBQ2oP
X-Google-Smtp-Source: AA0mqf459+YxUfzZAII1ome4M5LVER7wiG4cpr6EAzpkTjR2jCTKL6j4Uh1ZisOt10fKlv4tZ2j1QGGwdFkr30+qOkU=
X-Received: by 2002:aa7:d4d4:0:b0:46b:5c9f:52e with SMTP id
 t20-20020aa7d4d4000000b0046b5c9f052emr43944453edr.416.1671524691636; Tue, 20
 Dec 2022 00:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com> <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
 <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com> <CACGkMEuDXytqSWNsx1+GDOSLL0X2Z1fEWWBWT5_nJc-iks9Udw@mail.gmail.com>
In-Reply-To: <CACGkMEuDXytqSWNsx1+GDOSLL0X2Z1fEWWBWT5_nJc-iks9Udw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 20 Dec 2022 16:24:39 +0800
Message-ID: <CACycT3stmvptVrbvFXXgM2oWzHwG_rGRuO=WkpbNcZ=Dvujy-A@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback affinity
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

On Tue, Dec 20, 2022 at 2:29 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 1:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 1:35 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > Add sysfs interface for each vduse virtqueue to
> > > > show the affinity and effective affinity for irq
> > > > callback.
> > > >
> > > > And we can also use this interface to change the
> > > > effective affinity which must be a subset of the
> > > > irq callback affinity mask for the virtqueue. This
> > > > might be useful for performance tuning when the irq
> > > > callback affinity mask contains more than one CPU.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
> > > >  1 file changed, 137 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index 6507a78abc9d..c65f84100e30 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -61,6 +61,7 @@ struct vduse_virtqueue {
> > > >         int irq_effective_cpu;
> > > >         struct cpumask irq_affinity;
> > > >         spinlock_t irq_affinity_lock;
> > > > +       struct kobject kobj;
> > > >  };
> > > >
> > > >  struct vduse_dev;
> > > > @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
> > > >         .llseek         = noop_llseek,
> > > >  };
> > > >
> > > > +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> > > > +{
> > > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> > > > +}
> > > > +
> > > > +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> > > > +                                             char *buf)
> > > > +{
> > > > +       struct cpumask all_mask = CPU_MASK_ALL;
> > > > +       const struct cpumask *mask = &all_mask;
> > > > +
> > > > +       if (vq->irq_effective_cpu != -1)
> > > > +               mask = get_cpu_mask(vq->irq_effective_cpu);
> > >
> > > Shouldn't this be vq->irq_affinity?
> > >
> >
> > This sysfs interface is provided for effective irq affinity rather
> > than irq affinity. We created another read-only sysfs interface for
> > irq affinity.
> >
> > > > +
> > > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> > > > +}
> > > > +
> > > > +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> > > > +                                              const char *buf, size_t count)
> > > > +{
> > > > +       cpumask_var_t new_value;
> > > > +       int ret;
> > > > +
> > > > +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> > > > +               return -ENOMEM;
> > > > +
> > > > +       ret = cpumask_parse(buf, new_value);
> > > > +       if (ret)
> > > > +               goto free_mask;
> > > > +
> > > > +       ret = -EINVAL;
> > > > +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> > > > +               goto free_mask;
> > > > +
> > > > +       spin_lock(&vq->irq_affinity_lock);
> > > > +
> > > > +       if (vq->irq_effective_cpu != -1)
> > > > +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> > > > +
> > > > +       vq->irq_effective_cpu = cpumask_first(new_value);
> > >
> > > Does this mean except for the first cpu, the rest of the mask is unused?
> > >
> >
> > Yes, but the user should always specify a mask that only contains one
> > CPU to make it work as expected.
>
> This doesn't seem to be the way that the IRQ affinity{hint} exported
> via /sys work. Any reason for doing this?
>
> (E.g we may have the require to limit the IRQ/callback to a NUMA node
> instead of a specific cpu)
>

Yes, I think we need to make the sysfs interface for irq affinity
writable. The effective irq affinity can be removed now since we
choose using round-robin to spread IRQs between CPUs.

Thanks,
Yongji
