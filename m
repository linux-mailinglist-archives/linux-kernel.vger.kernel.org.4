Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE0656743
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiL0EfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 23:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiL0Ee4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 23:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABB1122
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 20:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672115649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLVMwljC7O+CWcnKyQoxnEA4xSzKKq2Chko3D5CrdLA=;
        b=i4NLN9K45jIBu35VzASCMwzgDGtzD8jZBWK0gCERUy73A9w4gtfqhmmuuaTzDCMtQfLpqk
        oSHzn3CjSKiXTfEVhtpCOMMKdp0cWZWafMZ1MlqFhYiHWfpdtqbNGQpKHgNXCbB8gXy0UY
        nh8SjjF7656QSlSq+I6tnMYPtAn3TdI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-YvwR1Kt9M7KwJtfHJoB-oQ-1; Mon, 26 Dec 2022 23:34:05 -0500
X-MC-Unique: YvwR1Kt9M7KwJtfHJoB-oQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1448c7afeccso5870184fac.15
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 20:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLVMwljC7O+CWcnKyQoxnEA4xSzKKq2Chko3D5CrdLA=;
        b=nY/Zk/hXDigj05+8rAwhoPQPCPaveL1ivYIr3VwqCLmIVIB9lR4M/AdBkt2VHCiMD9
         Da0u7zEgTC4L6xsZTh9+HSVKhH7IO+QmUPwiZITxV5PUxy9r8/keeKiYPMXCBoiO02e9
         /vJMjlMnHn39qfb73bz2qGyXFdiahkgl8a2ro72rLb0yap2d9febBJ25fwpfsIGqGZA+
         iplRE2M9ivSxCJFi9erpNujjm1WBpY0f4gbXFZGUzH59jVWdBYWfOgOA2C9q1xRnZrQX
         lm3pKbUAHJefPPtID+bLWw/8O8HB9/n8fFZ5qTH9BpHTgkOiUwd9aqPImfwynj3AQwAI
         UQoQ==
X-Gm-Message-State: AFqh2kq8HbxNsHhDbWnjTt7GWRYXU2EiIwlwfa8xSUggF3Rbe59Rn+9g
        IfTez+W7nKGg7+vS8uRmx58MobpnSAaud80psQConNn0UKL4w9dGlLyUZahnbHK2un3que4sIBf
        OLMV6cweKI8a3Y8lBDRLpJTkSpEC87gVLVPfgsYJ/
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id u19-20020a056870441300b00144a97b1ae2mr999929oah.35.1672115644481;
        Mon, 26 Dec 2022 20:34:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZAN7oKMf0wM3k63DQM44GpupAtM1md6Fw5I1P4sbRhDpAg5v73EA67TgqjKvQwX0A4ZadODRhmJ0ZibTXUNE=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr999924oah.35.1672115644270; Mon, 26 Dec
 2022 20:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Dec 2022 12:33:53 +0800
Message-ID: <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net, mst@redhat.com
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

On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > We used to busy waiting on the cvq command this tends to be
> > problematic since:
> >
> > 1) CPU could wait for ever on a buggy/malicous device
> > 2) There's no wait to terminate the process that triggers the cvq
> >    command
> >
> > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > timeout (1s) instead of busy polling for the cvq command forever. This
>
> I don't think that a fixed 1S is a good choice.

Well, it could be tweaked to be a little bit longer.

One way, as discussed, is to let the device advertise a timeout then
the driver can validate if it's valid and use that timeout. But it
needs extension to the spec.

> Some of the DPUs are very
> lazy for cvq handle.

Such design needs to be revisited, cvq (control path) should have a
better priority or QOS than datapath.

> In particular, we will also directly break the device.

It's kind of hardening for malicious devices.

>
> I think it is necessary to add a Virtio-Net parameter to allow users to define
> this timeout by themselves. Although I don't think this is a good way.

Very hard and unfriendly to the end users.

Thanks

>
> Thanks.
>
>
> > gives the scheduler a breath and can let the process can respond to
> > asignal. If the device doesn't respond in the timeout, break the
> > device.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - break the device when timeout
> > - get buffer manually since the virtio core check more_used() instead
> > ---
> >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index efd9dd55828b..6a2ea64cfcb5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> >       vi->rx_mode_work_enabled = false;
> >       spin_unlock_bh(&vi->rx_mode_lock);
> >
> > +     virtqueue_wake_up(vi->cvq);
> >       flush_work(&vi->rx_mode_work);
> >  }
> >
> > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> >       return !oom;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +     virtqueue_wake_up(cvq);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >       struct virtnet_info *vi = rvq->vdev->priv;
> > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> >       return err;
> >  }
> >
> > +static int virtnet_close(struct net_device *dev);
> > +
> >  /*
> >   * Send command via the control virtqueue and check status.  Commands
> >   * supported by the hypervisor, as indicated by feature bits, should
> > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >       if (unlikely(!virtqueue_kick(vi->cvq)))
> >               return vi->ctrl->status == VIRTIO_NET_OK;
> >
> > -     /* Spin for a response, the kick causes an ioport write, trapping
> > -      * into the hypervisor, so the request should be handled immediately.
> > -      */
> > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -            !virtqueue_is_broken(vi->cvq))
> > -             cpu_relax();
> > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > +             virtqueue_get_buf(vi->cvq, &tmp);
> > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > +     }
> >
> > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > +     virtio_break_device(vi->vdev);
> > +     return VIRTIO_NET_ERR;
> >  }
> >
> >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >
> >       /* Parameters for control virtqueue, if any */
> >       if (vi->has_cvq) {
> > -             callbacks[total_vqs - 1] = NULL;
> > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> >               names[total_vqs - 1] = "control";
> >       }
> >
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

