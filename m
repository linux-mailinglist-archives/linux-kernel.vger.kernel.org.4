Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51903654B88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiLWDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiLWDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:05:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1932180C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671764653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nk22SddT8s32uuy10mS2yxkS5L294EJjQs4S55LMRvI=;
        b=RLlgb4RpQ436TzgpK8Eg6uC2AVq7nodNlAsKMybhPB9o4DaUhngmBYliY+1gtUBoHwMLVq
        nIVZggw9tz5mDspnp/S2/gTaPbqIcrtEXVMDeL6VQ9KkVkdxkI1aaH5URZPqfZWZw2gmcD
        Dcz6fVUiUtanR8LNB7HnMVkO0X3HRfA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-zdH4cWFuNdCs9t1iQ_53uA-1; Thu, 22 Dec 2022 22:04:11 -0500
X-MC-Unique: zdH4cWFuNdCs9t1iQ_53uA-1
Received: by mail-oi1-f198.google.com with SMTP id r32-20020a056808212000b0035e98193903so773195oiw.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk22SddT8s32uuy10mS2yxkS5L294EJjQs4S55LMRvI=;
        b=ut1cHngShT9XTxgUauNp47DvneBEciMKDg35tbMKkyNc4CFs32/hrm2kplKyyn1goq
         ypmZmynnx0KySYxAt3Pq24aDgszR8z8KyIB6dlvHUE0ZbXs8imkyXpBacQTgUbtXpffg
         h0KtTjvxl/ydlMM8Fd7MKGF8Cpop79gt/OVUnWSYW5TH6mERIDaPay2eq0p+d+cE+3ml
         yHPOcBQVY9JTv4zPVxJLAiMYXJ/PtkJBo/WiXvsgSM4dJhgzO6xp10n1SvGZMJQ2xEwW
         91lJKN4df7f4Y7uobgyMYx0njiGiLdpM8v/Ri2fDGSTA8ifo3NnovZPr3sdOTsml6mZI
         74oQ==
X-Gm-Message-State: AFqh2kohCAqDSjxnpL4vOUaescueKqMnErrOm5exji0QjeJSdvL0zgeE
        xdyOTCY4TOwS3vIBmywEX/2i+vxniqzLJ+mBVjA2uyDhFSpxYVl3qx+ygARyU3HJ5AywwJ9B8f3
        fIX5dEtMLpVQmdnqn9LlEUtHo/k1Iuf7/nka/K13s
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id c9-20020a544e89000000b0035c303dfe37mr218396oiy.35.1671764650577;
        Thu, 22 Dec 2022 19:04:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbL3LlKBLthwI89NipAwg3/BzVWpLTk8GXoTYMUIMS3DQO3dU//K5z2UA8qfcPRw+PutWyU9/4ADoDgk3Mic0=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr218393oiy.35.1671764650344; Thu, 22 Dec
 2022 19:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
 <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
In-Reply-To: <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 23 Dec 2022 11:03:59 +0800
Message-ID: <CACGkMEvs6QenyQNR0GyJ81PgT-w2fy7Rag-JkJ7xNGdNZLGSfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com
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

On Thu, Dec 22, 2022 at 5:19 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 22, 2022 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > We used to busy waiting on the cvq command this tends to be
> > problematic since:
> >
> > 1) CPU could wait for ever on a buggy/malicous device
> > 2) There's no wait to terminate the process that triggers the cvq
> >    command
> >
> > So this patch switch to use sleep with a timeout (1s) instead of busy
> > polling for the cvq command forever. This gives the scheduler a breath
> > and can let the process can respond to a signal.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8225496ccb1e..69173049371f 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> >         vi->rx_mode_work_enabled = false;
> >         spin_unlock_bh(&vi->rx_mode_lock);
> >
> > +       virtqueue_wake_up(vi->cvq);
> >         flush_work(&vi->rx_mode_work);
> >  }
> >
> > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> >         return !oom;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +       virtqueue_wake_up(cvq);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >         struct virtnet_info *vi = rvq->vdev->priv;
> > @@ -2024,12 +2030,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >         if (unlikely(!virtqueue_kick(vi->cvq)))
> >                 return vi->ctrl->status == VIRTIO_NET_OK;
> >
> > -       /* Spin for a response, the kick causes an ioport write, trapping
> > -        * into the hypervisor, so the request should be handled immediately.
> > -        */
> > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq))
> > -               cpu_relax();
> > +       virtqueue_wait_for_used(vi->cvq, &tmp);
> >
> >         return vi->ctrl->status == VIRTIO_NET_OK;
> >  }
> > @@ -3524,7 +3525,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >
> >         /* Parameters for control virtqueue, if any */
> >         if (vi->has_cvq) {
> > -               callbacks[total_vqs - 1] = NULL;
> > +               callbacks[total_vqs - 1] = virtnet_cvq_done;
>
> If we're using CVQ callback, what is the actual use of the timeout?

Because we can't sleep forever since locks could be held like RTNL_LOCK.

>
> I'd say there is no right choice neither in the right timeout value
> nor in the action to take.

In the next version, I tend to put BAD_RING() to prevent future requests.

> Why not simply trigger the cmd and do all
> the changes at command return?

I don't get this, sorry.

>
> I suspect the reason is that it complicates the code. For example,
> having the possibility of many in flight commands, races between their
> completion, etc.

Actually the cvq command was serialized through RTNL_LOCK, so we don't
need to worry about this.

In the next version I can add ASSERT_RTNL().

Thanks

> The virtio standard does not even cover unordered
> used commands if I'm not wrong.
>
> Is there any other fundamental reason?
>
> Thanks!
>
> >                 names[total_vqs - 1] = "control";
> >         }
> >
> > --
> > 2.25.1
> >
>

