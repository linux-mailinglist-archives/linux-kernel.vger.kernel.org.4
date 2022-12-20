Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA9651AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLTG2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTG2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09EB1028
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671517678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk2PiE0CunQ+TDmLGNL5qpMQY7lBOmo7teDnAJQAAFs=;
        b=Zfiv7YnCSmQJzoDxef26FP1rTzN4+0P+ZxlCEDpSbJ8wwMU6US7edDtCARKjwJ8eHRvtuU
        ddpZhupL3fUYIiPFV2PsRwa71GRzF69+sGIkEORA7k9q+SqhxyKkysijjM36CMwoPJ6529
        TxkeT26sFbd2ms0c+68Lbxgse8TX1Oo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-tJ8ziIH6NjSDYqdApcaMTw-1; Tue, 20 Dec 2022 01:27:56 -0500
X-MC-Unique: tJ8ziIH6NjSDYqdApcaMTw-1
Received: by mail-ot1-f69.google.com with SMTP id e8-20020a9d63c8000000b006704cedcfe2so6672012otl.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fk2PiE0CunQ+TDmLGNL5qpMQY7lBOmo7teDnAJQAAFs=;
        b=Sy4mttW0NA4+qDeg01z2mDE/2+w/nCnuZRYz/Pc0HBUY/wglw7P5wXdWtlgTAZUmD2
         gAyObsOny1J3Kzhh4DBTucNCgHarZakJ7FdplnkY7CWCZPBMDVEncEEkk9+PyYx7h7sd
         1EXrVZCYXx2WjTuFHch76MIwqNYxr1Nr4kMJws/JRT9hDOy7F2PX48+4q29gJvTFlWPM
         TvIfM4MWH3tGghwbzVTDzWWSnLUnANjrrSnhZTOtHpg8DJaHW0MikgJKNl7NZk1718TH
         fOyb4xEn4RIpGHN01bE0c9wtXfLmGabCnm8PCKdABAIc4xsrOTXF7zY/m+hAgE5CtOoZ
         op7g==
X-Gm-Message-State: AFqh2kpPWtmNJTB9LKQr9mc5BoBnqaF/PdrN6s3NzE1FGj8QqPq64R+k
        l1As16tU0bd6uXK20j6TfYpmas1fcC9uIjyYKFNMLKohu3+RZYA2dv0TkD5RtAA+BnghKumX4Rm
        9zv/eIiKtON3flpfQ7naqr+K7MhmmUVXnVk3Rtstj
X-Received: by 2002:a05:6830:3359:b0:678:1eb4:3406 with SMTP id l25-20020a056830335900b006781eb43406mr524117ott.237.1671517675858;
        Mon, 19 Dec 2022 22:27:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsZt7pm6VhKZOL4+wxRQBFH0VoFxpTBBIytwLKsgR30rvYBkn3/JGtSy1k4ZwbJeR++nPgPC5pfUAnP0VMPL4M=
X-Received: by 2002:a05:6830:3359:b0:678:1eb4:3406 with SMTP id
 l25-20020a056830335900b006781eb43406mr524114ott.237.1671517675583; Mon, 19
 Dec 2022 22:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com> <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
In-Reply-To: <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:27:44 +0800
Message-ID: <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq injection
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 1:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces a bound workqueue to support running
> > > irq callback in a specified cpu.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 37809bfcb7ef..d126f3e32a20 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_callback cb;
> > >         struct work_struct inject;
> > >         struct work_struct kick;
> > > +       int irq_effective_cpu;
> >
> > I wonder why it's a cpu number instead of a cpumask. The latter seems
> > more flexible, e.g when using NUMA.
> >
>
> This variable represents the CPU that runs the interrupt callback
> rather than CPU affinity.

Ok, but for some reason it only gets updated when a new affinity is set?

(Btw, I don't see how the code deals with cpu hotplug, do we need
cpuhot notifier?)

Thanks

>
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -128,6 +129,7 @@ static struct class *vduse_class;
> > >  static struct cdev vduse_ctrl_cdev;
> > >  static struct cdev vduse_cdev;
> > >  static struct workqueue_struct *vduse_irq_wq;
> > > +static struct workqueue_struct *vduse_irq_bound_wq;
> > >
> > >  static u32 allowed_device_id[] = {
> > >         VIRTIO_ID_BLOCK,
> > > @@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
> > >  }
> > >
> > >  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > > -                                   struct work_struct *irq_work)
> > > +                                   struct work_struct *irq_work,
> > > +                                   int irq_effective_cpu)
> > >  {
> > >         int ret = -EINVAL;
> > >
> > > @@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > >                 goto unlock;
> > >
> > >         ret = 0;
> > > -       queue_work(vduse_irq_wq, irq_work);
> > > +       if (irq_effective_cpu == -1)
> >
> > Is it better to have a macro for this magic number?
> >
>
> It makes sense to me.
>
> Thanks,
> Yongji
>

