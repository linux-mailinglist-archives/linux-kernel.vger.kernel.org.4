Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56373652BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLUDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUDU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:20:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F51FCE6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671592809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5PhGqrRUN76i46hBbm+WOniSm6R7Qnx8r/lonz443aM=;
        b=NO0s15sfbYEoHsCKAAjLwetOJbs7W/QeeBFXdGbwR8Y3PCs97ZPhXh4MhQfEs2tP3CFwJC
        oRn4dOanxcy1rQ9EBfMPNpieclBZi+5GpkT4ngqPNIMzQ8W0+zKWhUfUhL5GZNWyHU797n
        /QX6Z5GFjdDNn2xsBqdM4EC/35qbs7k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-4zk5h8pSM8KtiQTmq9J3Qw-1; Tue, 20 Dec 2022 22:20:08 -0500
X-MC-Unique: 4zk5h8pSM8KtiQTmq9J3Qw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1438729f685so6351436fac.19
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PhGqrRUN76i46hBbm+WOniSm6R7Qnx8r/lonz443aM=;
        b=UfJ2TzndHBRKL7Mkv3e5b+pRxkcZ1GRgMFN/nyvUvNvTe8ghGbHiJuW2V7z9f88Osg
         9sCInzPQQwLrrNHYK2FSsvO/EIgllvJ7WQ8Xpj2cPEPhqxSGSeDkMq5U0Baxpnk/3fSJ
         1RPkmJYFjHSRrgbXc6svyOLixLgTTdNNzIDOSp6sgTS03x2AZJYKJ2s/rxKumvxm2+5e
         8bgNh1Jh5M7XmPTRBtHSnbrdFK+iqqGUeUiAVBlqXR2ouGnbZMl2oh3KjG73opRLljtz
         Co9Q20TCf198Y1QcQGwuaOKwqtXmfHoTPTjYr7YcYHzQ4cP4WV5oRHRisXceQqpEx88i
         OpeA==
X-Gm-Message-State: AFqh2koQTxneb731Y2FheF3HDADPfaIDzxL+yq2yevYGyFxSKgPc9qyR
        2ktkWAsq64izs4RZYMhV9SNDRAJlJRhPramn36/7lum0nXXZD3zDEIFpZ5cQsgknTysIr+z+fzN
        AboepA4RPVu53cBrxIjP6o/tKHlEoeLi+8l8v++I/
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id lm23-20020a0568703d9700b00144b22a38d3mr3041oab.280.1671592807427;
        Tue, 20 Dec 2022 19:20:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu80Fp/m85ZH256zw4DWcN6YVHlXSSkapee7nTh0Y+wiR5jIND72HG+S30UfEDw5dpEf3RodR118oC3e4tZPrE=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr3040oab.280.1671592807260; Tue, 20 Dec
 2022 19:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-6-xieyongji@bytedance.com>
 <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
 <CACycT3tyR0zTfTgE3BhL0GZqWAj2KDC0Q+tfm+rV=wbgHPOhFA@mail.gmail.com>
 <CACGkMEt1MkoxJQUixMsR8gVmTVUVoPh1CNo7GpbOyWGb3bzoPw@mail.gmail.com> <CACycT3vMktY1g57NhRMnAD0_F45MxpM=730reN-U_qqaN=daDg@mail.gmail.com>
In-Reply-To: <CACycT3vMktY1g57NhRMnAD0_F45MxpM=730reN-U_qqaN=daDg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Dec 2022 11:19:56 +0800
Message-ID: <CACGkMEtw9eWGZ04gs0zKdnJks+AHQyKHWdqNdhCNBbiXsB9X+Q@mail.gmail.com>
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

On Tue, Dec 20, 2022 at 6:02 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 20, 2022 at 2:28 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 1:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Fri, Dec 16, 2022 at 12:02 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces a bound workqueue to support running
> > > > > irq callback in a specified cpu.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
> > > > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > index 37809bfcb7ef..d126f3e32a20 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -57,6 +57,7 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_callback cb;
> > > > >         struct work_struct inject;
> > > > >         struct work_struct kick;
> > > > > +       int irq_effective_cpu;
> > > >
> > > > I wonder why it's a cpu number instead of a cpumask. The latter seems
> > > > more flexible, e.g when using NUMA.
> > > >
> > >
> > > This variable represents the CPU that runs the interrupt callback
> > > rather than CPU affinity.
> >
> > Ok, but for some reason it only gets updated when a new affinity is set?
> >
>
> Yes, since we don't use round-robin now. And if affinity is not set,
> we rollback to the default behavior (use un-bounded workqueue to run
> irq callback).
>
> > (Btw, I don't see how the code deals with cpu hotplug, do we need
> > cpuhot notifier?)
> >
>
> Currently the queue_work_on() can handle the cpu hotplug case, so I
> think we can simply check whether the CPU is online each time queuing
> the kwork, then update the affinity if needed.

Right.

Thanks

>
> Thanks,
> Yongji
>

