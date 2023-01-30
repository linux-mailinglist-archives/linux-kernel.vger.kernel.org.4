Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1C6804B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjA3EBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjA3EAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F2241C5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675051138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsSvm36Xk+HrOf60OemtCyImDVL0MFVHI7P7OR8LM6g=;
        b=UcguvUILjpf2bMv4o0is85L4I5G/jtVr/gzhHKEJNAsjxF3bLqd62IIm2cxj81azNV1nua
        c1A+Ef1EMxHTcL4HAX7cSCWUls/WIHCqjhSj/XMMsdEx1pXT5Feg+Ij9GDOYp0vLILfF5s
        3xz4DuUt38ieXhX3H3HWHXsPmqh4MEU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-mowRV-LYMj-MWi0j4R-3Jg-1; Sun, 29 Jan 2023 22:58:54 -0500
X-MC-Unique: mowRV-LYMj-MWi0j4R-3Jg-1
Received: by mail-ot1-f70.google.com with SMTP id bh27-20020a056830381b00b00686b0589045so5154302otb.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsSvm36Xk+HrOf60OemtCyImDVL0MFVHI7P7OR8LM6g=;
        b=3nVuQ8+2zgfznwipLZmTuoBgxw4Kw0dNf1d5OLC5CTE8y6pv6kPzpTtBYRygr0C2cb
         r8OmxLmDU0OB/SnW+W6nhL2gxpqG7GKmcvq48JryRKtWYcyxAGwsusCjl/6uPCWIUzma
         Kwm9FiTHOfgdZkZGlGwfmjwp5+xIiI7bfAyor/Any62N+NifQcmBwhSTWMfe7NUYrSL9
         46Ad1z0mR0s0cg8fR3cH7Eheu+omD9e0QhPPN8dNYYs+Nzw31xPTzxsKBT4jqE8iBS/8
         YhUxUjSQDdZP4zs/JhEDSe3CctUGgAwLjFMWZ89xIhGf496XlzWEjjg3XbT1rfs4O77h
         NT9w==
X-Gm-Message-State: AFqh2kp68Pfq9y0icgWTZk+KvrDdxsAAbdINs5KoZ+gS/r33qzVwg1br
        88WsfFnIDFYiBnYDilXIOLC+fsCN+3MMB0la/3TxbVwdEpc0+ZVYmH6Nqh6Y8Kq9y18d34aonWf
        xRzlRMM8A8sLPaOP3TH7JMfVhrclshsiL/P08GPYP
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id y14-20020a056871010e00b0015b96b59916mr3936908oab.280.1675051133877;
        Sun, 29 Jan 2023 19:58:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuM5wHn4sTMJyFxc8JJT0li6BZ912wXTAByPVQnh6DAkYFaVUTfYozLdOXqMoX/5eBKpP3njBrqsOtckLHf0bI=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr3936902oab.280.1675051133632; Sun, 29
 Jan 2023 19:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-4-jasowang@redhat.com>
 <20230129073713.5236-1-hdanton@sina.com>
In-Reply-To: <20230129073713.5236-1-hdanton@sina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 30 Jan 2023 11:58:42 +0800
Message-ID: <CACGkMEtUf=23oxwe=QjhD9AhSRHPNuHfNKBJHPrAPLQk3oLFWA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To:     Hillf Danton <hdanton@sina.com>
Cc:     mst@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 3:37 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 26 Dec 2022 15:49:07 +0800 Jason Wang <jasowang@redhat.com>
> > @@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +     wake_up_interruptible(&vq->wq);
> > +
> >       if (vq->we_own_ring) {
> >               if (vq->packed_ring) {
> >                       vring_free_queue(vq->vq.vdev,
> > @@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +int virtqueue_wait_for_used(struct virtqueue *_vq)
> > +{
> > +     struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +     /* TODO: Tweak the timeout. */
> > +     return wait_event_interruptible_timeout(vq->wq,
> > +            virtqueue_is_broken(_vq) || more_used(vq), HZ);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
>
>         waker           waiter
>         ---             ---
>         vring_del_virtqueue
>           vring_free(_vq);
>             wakeup
>           kfree(vq);
>                         get on CPU a tick later
>                         uaf ?
>

Exactly, this wakeup of vring_free is not needed. It's up to the
driver to do the proper wake up to avoid race when subsystem un
registration.

Thanks

