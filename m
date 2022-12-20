Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99EC651E53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiLTKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiLTKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:03:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABD19C39
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:02:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jo4so19040733ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HmgiYw3Ezgtgc0Fnyw2i+o//lXCiSoYu98n5jTUuNLE=;
        b=ff6ZUWPexkB+ZmN7C9VxDIABpsR1CyjvgW0lZWexnLXL9Sz+XmpiaazjvhYOfttvbH
         xruTUbkLNvlqXNu97Wqg0p+qzCG04/wT4ZVkQQqOijOKLqsizQtVre7s8fXRyB+ptoHM
         f9v8Tw+G6snSZK53PVN+BOKfGqB/VhEzv2UJcse7EUE17W3ETQWtlV0OS1DHM0y1xXig
         RZMz71/6l5DWx4xPM16iU2yae7MK0nd6xyvlpBL5gHuYYKMeHd1cg8zVe76Y/740oR4n
         TPRELZ2+JdOeveuMobwNFOi1BUqk8eHsRIjF35/NCNgZpsywPGMsnBxU/LhWghxu8ddm
         7Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmgiYw3Ezgtgc0Fnyw2i+o//lXCiSoYu98n5jTUuNLE=;
        b=Z4swqEYLLZko/8DGFtudX6fX0yOZcHdl+6P6Okt7LSR1rBKTdOAinU/BLvzLaJ6f/I
         8XWE97n/SpwZOsPMdIAUgbjiTXa8RSDqPi+RmXB8V2OwJkCnIRXlnskFH5O2fjvzZQUr
         Tf/B25Kbmst7tWE8k83PJEW70N5JK44z3QcxpJTVzOZWVGo3L6GVl5+ztO2n01PxwjrM
         IF1/tpCvHCDzm2et6nzlVK02g3Dh9Q9WCk/W2I9qnhr4OKapueBbdagNoz2WqYkwuII4
         lfrddYNiAyRksxCYrBLjAGdzCUjWM/0geW7Gs01LmC74uDz9epMuZ556deKsN3dUznYG
         LEUg==
X-Gm-Message-State: AFqh2krIVq0a4iot0wqaQnuStNoch+AoEMRiu1X65terTpaGFG6OW6AP
        OdxDY9EQqUMyorcuWCf4RX+YioIbo/+Xk5ukauqf
X-Google-Smtp-Source: AMrXdXuad5eUk26FxuGZbonpsAmp40MvVbvaz5zdmm4ERTIvQ44V3myxSozh5xqDQlP7kvSEYOyZ4PUu6N2ImXm9EdQ=
X-Received: by 2002:a17:906:c041:b0:834:5c4a:26cb with SMTP id
 bm1-20020a170906c04100b008345c4a26cbmr399789ejb.653.1671530523429; Tue, 20
 Dec 2022 02:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
 <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com> <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com>
In-Reply-To: <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 20 Dec 2022 18:01:51 +0800
Message-ID: <CACycT3vMktY1g57NhRMnAD0_F45MxpM=730reN-U_qqaN=daDg@mail.gmail.com>
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

On Tue, Dec 20, 2022 at 2:28 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 1:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This introduces a bound workqueue to support running
> > > > irq callback in a specified cpu.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> > > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index 37809bfcb7ef..d126f3e32a20 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> > > >         struct vdpa_callback cb;
> > > >         struct work_struct inject;
> > > >         struct work_struct kick;
> > > > +       int irq_effective_cpu;
> > >
> > > I wonder why it's a cpu number instead of a cpumask. The latter seems
> > > more flexible, e.g when using NUMA.
> > >
> >
> > This variable represents the CPU that runs the interrupt callback
> > rather than CPU affinity.
>
> Ok, but for some reason it only gets updated when a new affinity is set?
>

Yes, since we don't use round-robin now. And if affinity is not set,
we rollback to the default behavior (use un-bounded workqueue to run
irq callback).

> (Btw, I don't see how the code deals with cpu hotplug, do we need
> cpuhot notifier?)
>

Currently the queue_work_on() can handle the cpu hotplug case, so I
think we can simply check whether the CPU is online each time queuing
the kwork, then update the affinity if needed.

Thanks,
Yongji
