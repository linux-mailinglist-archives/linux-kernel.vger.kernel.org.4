Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADC654D30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiLWIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiLWIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EED31EF8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671782736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bFLWsQNHsge6wGJfAl0mL7hIz5gRpomgqSOVA8QczgI=;
        b=cdUhUEBPHntU2nGQVEl1UfgNl0sYazbvqQnfkUkVbfAVrru2Cw/uvN3O3IIqRe7qmyjHH9
        ougPrumUDv7VQzc7hW+24UxcAM89UoM97HE/1gjDa8aJA3WuIK/JMNdMeOUNCR8S5h6efD
        Pm+cpSIfCyoPX1XkgCE353HePWpHfsk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-XIL3JyD4OC2PbKORE7MabA-1; Fri, 23 Dec 2022 03:05:35 -0500
X-MC-Unique: XIL3JyD4OC2PbKORE7MabA-1
Received: by mail-ed1-f71.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso3159109edd.14
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFLWsQNHsge6wGJfAl0mL7hIz5gRpomgqSOVA8QczgI=;
        b=0IOmx5HL2o3x5862HxkLlt/JT6ITyBD1I4fOQH69Epo2pNoUQzw/jh4UDpGcskAWlo
         gNsFBhZyx+LP/Ejs+T/UKgpDAnRA+HILr0oqtYHewAsWfrlsU4q1uYaehJKStG8ZR4DY
         +aAw533GQ+bx5nEopa4Fpmj3POQPiNGXRDWzxFGxWSdyYl8NNeI0O7Mzd6cgnXHONdcU
         ghleyRqEiLM//l4d3O+StMszHMJ2yiBwXMiDXi6+1zw903Jq3kqtziSMhlM3qyKRIWaq
         WJMwOy1gxvQC9z+qBW5rUB85HM1q9+1EMYl/4tQRyZyBv+f0S/p5bjn8BbMb0gzRARJ/
         QyVA==
X-Gm-Message-State: AFqh2kqOvs875WAMvivabI3uKEIyCJBCNAUDQUFFkYxxO7NWLM4lspRD
        Z84Y+lAm8+zg6Gy7YxM2xYGGlupam5kAHkDO4s9xBmUB9PzDxDx/v+OkXxoNwxxUuk2zw5b0EIZ
        QhXSVDNk+ysfdINuWATavN130pfa+wTetJiGc6nI1
X-Received: by 2002:aa7:ccd6:0:b0:46b:fb7d:2188 with SMTP id y22-20020aa7ccd6000000b0046bfb7d2188mr812700edt.395.1671782733893;
        Fri, 23 Dec 2022 00:05:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsf+vA7wmRUinz14o+jRWMIhgxxiT4IeIrvDnetlxJiJT3eULqs5z5czOZ67qTTD+ZSFFK6EfJKzK4pDFoGaJg=
X-Received: by 2002:aa7:ccd6:0:b0:46b:fb7d:2188 with SMTP id
 y22-20020aa7ccd6000000b0046bfb7d2188mr812690edt.395.1671782733588; Fri, 23
 Dec 2022 00:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
 <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com> <CACGkMEvs6QenyQNR0GyJ81PgT-w2fy7Rag-JkJ7xNGdNZLGSfQ@mail.gmail.com>
In-Reply-To: <CACGkMEvs6QenyQNR0GyJ81PgT-w2fy7Rag-JkJ7xNGdNZLGSfQ@mail.gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 23 Dec 2022 09:04:56 +0100
Message-ID: <CAJaqyWfJriGB1aLJ8BWZnnZ+fYrpwpkwxSAmKhzmYE72VWBvEA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com
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

On Fri, Dec 23, 2022 at 4:04 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Dec 22, 2022 at 5:19 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Dec 22, 2022 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > We used to busy waiting on the cvq command this tends to be
> > > problematic since:
> > >
> > > 1) CPU could wait for ever on a buggy/malicous device
> > > 2) There's no wait to terminate the process that triggers the cvq
> > >    command
> > >
> > > So this patch switch to use sleep with a timeout (1s) instead of busy
> > > polling for the cvq command forever. This gives the scheduler a breath
> > > and can let the process can respond to a signal.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 8225496ccb1e..69173049371f 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > >         vi->rx_mode_work_enabled = false;
> > >         spin_unlock_bh(&vi->rx_mode_lock);
> > >
> > > +       virtqueue_wake_up(vi->cvq);
> > >         flush_work(&vi->rx_mode_work);
> > >  }
> > >
> > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > >         return !oom;
> > >  }
> > >
> > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > +{
> > > +       virtqueue_wake_up(cvq);
> > > +}
> > > +
> > >  static void skb_recv_done(struct virtqueue *rvq)
> > >  {
> > >         struct virtnet_info *vi = rvq->vdev->priv;
> > > @@ -2024,12 +2030,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > >         if (unlikely(!virtqueue_kick(vi->cvq)))
> > >                 return vi->ctrl->status == VIRTIO_NET_OK;
> > >
> > > -       /* Spin for a response, the kick causes an ioport write, trapping
> > > -        * into the hypervisor, so the request should be handled immediately.
> > > -        */
> > > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > -              !virtqueue_is_broken(vi->cvq))
> > > -               cpu_relax();
> > > +       virtqueue_wait_for_used(vi->cvq, &tmp);
> > >
> > >         return vi->ctrl->status == VIRTIO_NET_OK;
> > >  }
> > > @@ -3524,7 +3525,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >
> > >         /* Parameters for control virtqueue, if any */
> > >         if (vi->has_cvq) {
> > > -               callbacks[total_vqs - 1] = NULL;
> > > +               callbacks[total_vqs - 1] = virtnet_cvq_done;
> >
> > If we're using CVQ callback, what is the actual use of the timeout?
>
> Because we can't sleep forever since locks could be held like RTNL_LOCK.
>

Right, rtnl_lock kind of invalidates it for a general case.

But do all of the commands need to take rtnl_lock? For example I see
how we could remove it from ctrl_announce, so lack of ack may not be
fatal for it. Assuming a buggy device, we can take some cvq commands
out of this fatal situation.

This series already improves the current situation and my suggestion
(if it's worth it) can be applied on top of it, so it is not a blocker
at all.

> >
> > I'd say there is no right choice neither in the right timeout value
> > nor in the action to take.
>
> In the next version, I tend to put BAD_RING() to prevent future requests.
>
> > Why not simply trigger the cmd and do all
> > the changes at command return?
>
> I don't get this, sorry.
>

It's actually expanding the first point so you already answered it :).

Thanks!

> >
> > I suspect the reason is that it complicates the code. For example,
> > having the possibility of many in flight commands, races between their
> > completion, etc.
>
> Actually the cvq command was serialized through RTNL_LOCK, so we don't
> need to worry about this.
>
> In the next version I can add ASSERT_RTNL().
>
> Thanks
>
> > The virtio standard does not even cover unordered
> > used commands if I'm not wrong.
> >
> > Is there any other fundamental reason?
> >
> > Thanks!
> >
> > >                 names[total_vqs - 1] = "control";
> > >         }
> > >
> > > --
> > > 2.25.1
> > >
> >
>

