Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1E749554
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjGFGHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjGFGH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4091FD3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688623585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7F1kuoBVvdilDrsKXZBNZrXBfxZI6rHyhY9EwQm6NA=;
        b=cD13HB4wq2nHCzICrKGLt6unL7HjRA0zx5XuFhqJC/q2Qfhp3YaMABG7akp8eFAfWZ2E/4
        w7sEI/MPGuhKpDMCfbyv7pbqofqNVyn2HGKdxd46W8BePthYsD6CONjQspxQ2hWl1e85cA
        FQdrEGYimLnOOX9LSBuzdaK2GfI3M+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-TBMqCWr4N6u_5l2d5a1_vw-1; Thu, 06 Jul 2023 02:05:58 -0400
X-MC-Unique: TBMqCWr4N6u_5l2d5a1_vw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so1845615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623556; x=1691215556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7F1kuoBVvdilDrsKXZBNZrXBfxZI6rHyhY9EwQm6NA=;
        b=UKsA8T6TivLItPHTIJVb34m2wJkOKIwiAyz4C0CF4aIGTEHww3ODMj9UENGEQDB5f1
         EEytyzvcwqgs24UD+W9jBWWgpibYQ+9dAJ10pPRfX5wCHuj45A/b8agu+tVyb+jcQWpc
         YmARppCn9dIUe8ERTwPTi5iEyZIr5k0e8xIKPqWbokeZ+shAXj+0mcR3IBJ2obJmAxJ1
         WsnvXV31ZhHxGmbJXt19UrJ6eBUu6dANUJtP3simPy3cH8xlkT78g1nD4yXNdMN/+6mr
         MOGXBQ7RM1YHWH9iJZkXyNnMYldpzqa50C2CNaFgDFYVeenp5rDJmqrY/pTxEHcmh1iV
         qFkw==
X-Gm-Message-State: ABy/qLbklOhhGHwlugYXqZZJTZUYqd6AjcAfWI5X2gvuhPhhZ/7qg56s
        ug9E39TIXLfEBwXv2pe8XdartVo0f10KVOBwvkQLjNwA5wAzV1eUtpJj4wA2PalwUjVPlAX3cvy
        oYNQBPJAyD0FhaZOphddBgQsqhQ+s/zrp
X-Received: by 2002:a7b:c7d8:0:b0:3f8:c9a4:4998 with SMTP id z24-20020a7bc7d8000000b003f8c9a44998mr463685wmk.28.1688623556609;
        Wed, 05 Jul 2023 23:05:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrouu/voEFMZNR/vXdUDZFJea9gZ8LyKhI9fqFldR83BbNhMWMgOYIuYvluurNHedhv9Ps+A==
X-Received: by 2002:a7b:c7d8:0:b0:3f8:c9a4:4998 with SMTP id z24-20020a7bc7d8000000b003f8c9a44998mr463673wmk.28.1688623556315;
        Wed, 05 Jul 2023 23:05:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e5:9a00:6cb0:ad0c:4846:6126])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b003fa8dbb7b5dsm1020276wmf.25.2023.07.05.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 23:05:55 -0700 (PDT)
Date:   Thu, 6 Jul 2023 02:05:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does
 not support it
Message-ID: <20230706020310-mutt-send-email-mst@kernel.org>
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CACGkMEvT4Y+-wfhyi324Y5hhAtn+ZF7cP9d=omdH-ZgdJ-4SOQ@mail.gmail.com>
 <20230705044151-mutt-send-email-mst@kernel.org>
 <CACGkMEu0MhQqNbrg9WkyGBboFU5RSqCs1W8LpksW4mO7hGxd7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu0MhQqNbrg9WkyGBboFU5RSqCs1W8LpksW4mO7hGxd7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:56:29AM +0800, Jason Wang wrote:
> On Wed, Jul 5, 2023 at 4:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 03:55:23PM +0800, Jason Wang wrote:
> > > On Tue, Jul 4, 2023 at 6:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 12:25:32PM +0200, Eugenio Perez Martin wrote:
> > > > > On Mon, Jul 3, 2023 at 4:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jul 03, 2023 at 04:22:18PM +0200, Eugenio Pérez wrote:
> > > > > > > With the current code it is accepted as long as userland send it.
> > > > > > >
> > > > > > > Although userland should not set a feature flag that has not been
> > > > > > > offered to it with VHOST_GET_BACKEND_FEATURES, the current code will not
> > > > > > > complain for it.
> > > > > > >
> > > > > > > Since there is no specific reason for any parent to reject that backend
> > > > > > > feature bit when it has been proposed, let's control it at vdpa frontend
> > > > > > > level. Future patches may move this control to the parent driver.
> > > > > > >
> > > > > > > Fixes: 967800d2d52e ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
> > > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > >
> > > > > > Please do send v3. And again, I don't want to send "after driver ok" hack
> > > > > > upstream at all, I merged it in next just to give it some testing.
> > > > > > We want RING_ACCESS_AFTER_KICK or some such.
> > > > > >
> > > > >
> > > > > Current devices do not support that semantic.
> > > >
> > > > Which devices specifically access the ring after DRIVER_OK but before
> > > > a kick?
> > >
> > > Vhost-net is one example at last. It polls a socket as well, so it
> > > starts to access the ring immediately after DRIVER_OK.
> > >
> > > Thanks
> >
> >
> > For sure but that is not vdpa.
> 
> Somehow via vp_vdpa that I'm usually testing vDPA patches.
> 
> The problem is that it's very hard to audit all vDPA devices now if it
> is not defined in the spec before they are invented.
> 
> Thanks

vp_vdpa is exactly the part that bothers me. If on the host it is backed
by e.g. vhost-user then it does not work. And you don't know what is
backing it.

OTOH it supports RING_RESET ...

So, proposal: include both this solution and for drivers
vp_vdpa the RING_RESET trick.


Hmm?



> >
> > > >
> > > > > My plan was to convert
> > > > > it in vp_vdpa if needed, and reuse the current vdpa ops. Sorry if I
> > > > > was not explicit enough.
> > > > >
> > > > > The only solution I can see to that is to trap & emulate in the vdpa
> > > > > (parent?) driver, as talked in virtio-comment. But that complicates
> > > > > the architecture:
> > > > > * Offer VHOST_BACKEND_F_RING_ACCESS_AFTER_KICK
> > > > > * Store vq enable state separately, at
> > > > > vdpa->config->set_vq_ready(true), but not transmit that enable to hw
> > > > > * Store the doorbell state separately, but do not configure it to the
> > > > > device directly.
> > > > >
> > > > > But how to recover if the device cannot configure them at kick time,
> > > > > for example?
> > > > >
> > > > > Maybe we can just fail if the parent driver does not support enabling
> > > > > the vq after DRIVER_OK? That way no new feature flag is needed.
> > > > >
> > > > > Thanks!
> > > > >
> > > > > >
> > > > > > > ---
> > > > > > > Sent with Fixes: tag pointing to git.kernel.org/pub/scm/linux/kernel/git/mst
> > > > > > > commit. Please let me know if I should send a v3 of [1] instead.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/lkml/20230609121244-mutt-send-email-mst@kernel.org/T/
> > > > > > > ---
> > > > > > >  drivers/vhost/vdpa.c | 7 +++++--
> > > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > index e1abf29fed5b..a7e554352351 100644
> > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > @@ -681,18 +681,21 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > >  {
> > > > > > >       struct vhost_vdpa *v = filep->private_data;
> > > > > > >       struct vhost_dev *d = &v->vdev;
> > > > > > > +     const struct vdpa_config_ops *ops = v->vdpa->config;
> > > > > > >       void __user *argp = (void __user *)arg;
> > > > > > >       u64 __user *featurep = argp;
> > > > > > > -     u64 features;
> > > > > > > +     u64 features, parent_features = 0;
> > > > > > >       long r = 0;
> > > > > > >
> > > > > > >       if (cmd == VHOST_SET_BACKEND_FEATURES) {
> > > > > > >               if (copy_from_user(&features, featurep, sizeof(features)))
> > > > > > >                       return -EFAULT;
> > > > > > > +             if (ops->get_backend_features)
> > > > > > > +                     parent_features = ops->get_backend_features(v->vdpa);
> > > > > > >               if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
> > > > > > >                                BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> > > > > > >                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> > > > > > > -                              BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
> > > > > > > +                              parent_features))
> > > > > > >                       return -EOPNOTSUPP;
> > > > > > >               if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> > > > > > >                    !vhost_vdpa_can_suspend(v))
> > > > > > > --
> > > > > > > 2.39.3
> > > > > >
> > > >
> >

