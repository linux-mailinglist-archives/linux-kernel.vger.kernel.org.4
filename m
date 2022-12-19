Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340E650749
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiLSFRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSFRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:17:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC526DE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:16:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so18810356ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMBE7pl8CpsG2lIEbLegfr9uchPd5FPsf/JwpNp4nE8=;
        b=P3DKlFq77IY8JORLIH8xE+w7ujjPl1h7P3+9P2EvUUzUBc02fRMmF51mvt/l9c9KGf
         8f91O0eoRn/DwgatmAlQeKnaFkoisnU/qJPWmMJqglmaAEfYEgNg4ZCxKKztCMFyAxqU
         reHgyyMCIuRi0FtNygUZrG/1ofdd1GyzkDdPFPdXd5Ck8zYUg5dzzXGMIXux5baC/fTK
         g1KvtPTaQVguPj4LPrEOEg5uuEH2DW2hd8zVhve3+jcdduL04eay6wOhf9EFdJRACOoF
         FbIWCyT3HdCwj1m6AVENVrbnU6/R7V4G7I5j4Veb6pa3VTRwmHhhE/Gto0WTf4LLoLQx
         qLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMBE7pl8CpsG2lIEbLegfr9uchPd5FPsf/JwpNp4nE8=;
        b=UYgM7xr3iCxnd0h3ePdqhI7zhQ5i9TjDa39uvAnBNwXhVPHoonQwEOnjRsyQgDG484
         MmEZ9Z3hZwf8zhUHygL+vkzu6t8igq1tvzU6Q8sP9ofCkk658qYwy2yzNeKE5Uqd3jlV
         Y/iwZbB+ze1/DxlaHoFrId/4wqmGbyclvfFj1v7fSJjKThHoW9355v63ZL/C333AfIBR
         mL/0VUB5GN80RU4tk4cUlM/rcRy5vvFNGXA44BsXbwQ///9n97LePrxiTfiVmTNP8HFo
         bGOQpkbIunHJ7/c1T+nnnDcqX/lBNj8xEWUjart+cefIBzLyDIKfVx1WARQYl9cs1Ef2
         jQSw==
X-Gm-Message-State: ANoB5pmRrVhks6TQj3w228uX14ZnuRkUoXgLPBCQsTpPkeomFBCLM5iH
        dg2LarcJqVBYFPua7VI0ccyRHlxmipgMh0/3AsHPk/r71URF
X-Google-Smtp-Source: AA0mqf51qk048ub74FJxWA9QFZ/jqPGPHwG5svRFEfWCGMF70ShuX1NfxGI2fOOo1yZ2so66HhH8mnk14lct2LvAnfQ=
X-Received: by 2002:a17:906:265b:b0:7c1:6fdf:3b70 with SMTP id
 i27-20020a170906265b00b007c16fdf3b70mr1740755ejc.619.1671427000227; Sun, 18
 Dec 2022 21:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com> <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
In-Reply-To: <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 13:16:28 +0800
Message-ID: <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 1:35 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > Add sysfs interface for each vduse virtqueue to
> > show the affinity and effective affinity for irq
> > callback.
> >
> > And we can also use this interface to change the
> > effective affinity which must be a subset of the
> > irq callback affinity mask for the virtqueue. This
> > might be useful for performance tuning when the irq
> > callback affinity mask contains more than one CPU.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
> >  1 file changed, 137 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 6507a78abc9d..c65f84100e30 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -61,6 +61,7 @@ struct vduse_virtqueue {
> >         int irq_effective_cpu;
> >         struct cpumask irq_affinity;
> >         spinlock_t irq_affinity_lock;
> > +       struct kobject kobj;
> >  };
> >
> >  struct vduse_dev;
> > @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
> >         .llseek         = noop_llseek,
> >  };
> >
> > +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> > +{
> > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> > +}
> > +
> > +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> > +                                             char *buf)
> > +{
> > +       struct cpumask all_mask = CPU_MASK_ALL;
> > +       const struct cpumask *mask = &all_mask;
> > +
> > +       if (vq->irq_effective_cpu != -1)
> > +               mask = get_cpu_mask(vq->irq_effective_cpu);
>
> Shouldn't this be vq->irq_affinity?
>

This sysfs interface is provided for effective irq affinity rather
than irq affinity. We created another read-only sysfs interface for
irq affinity.

> > +
> > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> > +}
> > +
> > +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> > +                                              const char *buf, size_t count)
> > +{
> > +       cpumask_var_t new_value;
> > +       int ret;
> > +
> > +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> > +               return -ENOMEM;
> > +
> > +       ret = cpumask_parse(buf, new_value);
> > +       if (ret)
> > +               goto free_mask;
> > +
> > +       ret = -EINVAL;
> > +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> > +               goto free_mask;
> > +
> > +       spin_lock(&vq->irq_affinity_lock);
> > +
> > +       if (vq->irq_effective_cpu != -1)
> > +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> > +
> > +       vq->irq_effective_cpu = cpumask_first(new_value);
>
> Does this mean except for the first cpu, the rest of the mask is unused?
>

Yes, but the user should always specify a mask that only contains one
CPU to make it work as expected. This sysfs interface is used to
specify the effective irq affinity rather than irq affinity.

Thanks,
Yongji
