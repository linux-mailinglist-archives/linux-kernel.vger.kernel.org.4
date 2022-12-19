Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231A9650744
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 06:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiLSFFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 00:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSFF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 00:05:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B64AE66
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:04:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m18so18818995eji.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 21:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rD7i+tYqqhFJuFa94OR1meePFZcnKCYoZpo52/JXrU=;
        b=BkFRMIs86ingc8zd+K8pvyXtqPTXhXRk+jMvwoEdSgX+daJ7qnkS1XAAVaUYdSAMVH
         Mif3j5HHykOJLjajwyjNKmJrZsNIQl6FAN0aeJqvX0HqXsWAfr1AbQKNxypC6sT0R3aK
         kIxkOsEhI19Yh3w3xddomdDltjZtDWrV0Nuhkk8zUjjri8s9rBuAbA3Ca3b0E5+rkVIn
         2oypP2FAjIjhSnxyXhfRcxcJG4EwHULVDN3u8lO6KgMh0HWLG6llMCGvaM4xwzzrPF9O
         8MTODvvpVDELGdifUiLGYOLqBCFJnfiFCCTKJoGT3sObst8plgM/sosrmNOSRGX6hUgn
         wnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rD7i+tYqqhFJuFa94OR1meePFZcnKCYoZpo52/JXrU=;
        b=5XPdmghLOXhy2WBpaxjOCp9i/g4hOhtFSIg1xJ19K2bmoRkDgtf32NvI/BBsvtywkR
         oRrDzFbw9pC1Ln7Aui5m2ttV98bRLPwS/u1fxGLKaZ+F53NPTDARhSHuWh87ph8JSYlY
         BPVqaxmyXp/IDFLdFFip4QQ7O/F28PvMVpkbr6pjxXtI5979sBTx0sTiQi7RG4oIOoY5
         LcACxkot3K37llKROI3ofr8XV8dn8Q5wQiMEumjb88BYj7bm8edTcll2oWN1ClhAhqH/
         3YqDJyMHJ3ND82s9JpKEPmsMmBoEhssHMHJZN90QyapEg9Vy1ULpUutEv8lkrUsAgJSM
         UU6g==
X-Gm-Message-State: AFqh2krJNAjeNMjXTEMsdosyUB9T4+iWFKZ8zPuld8ydfQfS4BqJ6RcH
        UnSU1UOmdQrr9iJueyCRtPFmSYVAPrXIZUXZyaqf
X-Google-Smtp-Source: AMrXdXusQwQO9cZPZTM7ZyeeEIgQL3pEZpszovqofk9TXkKgUpKTdq24zNSXtoXOvGzk+f/qWYcbNBJlstk+Znt+iG4=
X-Received: by 2002:a17:907:d68e:b0:7de:de2c:7bbe with SMTP id
 wf14-20020a170907d68e00b007dede2c7bbemr1406303ejc.141.1671426294383; Sun, 18
 Dec 2022 21:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
In-Reply-To: <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 13:04:43 +0800
Message-ID: <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq injection
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

On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > This introduces a bound workqueue to support running
> > irq callback in a specified cpu.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 37809bfcb7ef..d126f3e32a20 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> >         struct vdpa_callback cb;
> >         struct work_struct inject;
> >         struct work_struct kick;
> > +       int irq_effective_cpu;
>
> I wonder why it's a cpu number instead of a cpumask. The latter seems
> more flexible, e.g when using NUMA.
>

This variable represents the CPU that runs the interrupt callback
rather than CPU affinity.

> >  };
> >
> >  struct vduse_dev;
> > @@ -128,6 +129,7 @@ static struct class *vduse_class;
> >  static struct cdev vduse_ctrl_cdev;
> >  static struct cdev vduse_cdev;
> >  static struct workqueue_struct *vduse_irq_wq;
> > +static struct workqueue_struct *vduse_irq_bound_wq;
> >
> >  static u32 allowed_device_id[] = {
> >         VIRTIO_ID_BLOCK,
> > @@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
> >  }
> >
> >  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > -                                   struct work_struct *irq_work)
> > +                                   struct work_struct *irq_work,
> > +                                   int irq_effective_cpu)
> >  {
> >         int ret = -EINVAL;
> >
> > @@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> >                 goto unlock;
> >
> >         ret = 0;
> > -       queue_work(vduse_irq_wq, irq_work);
> > +       if (irq_effective_cpu == -1)
>
> Is it better to have a macro for this magic number?
>

It makes sense to me.

Thanks,
Yongji
