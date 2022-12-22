Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13C5653D67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiLVJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiLVJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489C20F77
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671700781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mZAWSv5M153WIjy8BKTsqFkdNutmq5ALdbbPWu1odZ4=;
        b=MoxR6ImwmBc8gqb8VGChXu6Q7YkkRTKmOuVQlv9Y6dOHouO2pz64kuXeGV27rHhvfpo+Lj
        8f6WcI0VDiDrpIdadHItT2IMduiGdn62aUBzG2MCQdayHLThhwrvT3TF6qFH4WcNQnbv0d
        29DyCWhymLT2Q1lx19N/wLYsZ1q4Rpo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-IGBPGB1lMhWS8n5YAwo-pw-1; Thu, 22 Dec 2022 04:19:39 -0500
X-MC-Unique: IGBPGB1lMhWS8n5YAwo-pw-1
Received: by mail-ed1-f70.google.com with SMTP id l17-20020a056402255100b00472d2ff0e59so1099085edb.19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZAWSv5M153WIjy8BKTsqFkdNutmq5ALdbbPWu1odZ4=;
        b=RcrnU/t/S9jqN/p8zzEfRRJaJ5o1aInSyKb33ehLl+Cx3COvVYafBqE8RGJDxB6Oj8
         /Kd2eVeCD0ecIt716JD9AqNxyf9yfaEyEIliSDfS/+5z/uAe3HCiBrlvRxhISjTetfoP
         nZw/WvD6K1nmtlmn9Rx6hvXN/eU8nVVdA1MhWBzC/q2D4IK1c9Z5x+LR59bklWJ5YIz4
         5F7ovO3PeUeO7/yvuXQXuwPRAcPPNg6zoQNg2tGQ8Tm/LJqegRbDqzZoMVtQTF+0dRbE
         DscHij03cqvOMKBH0k02b71FkhWuGwZIi8RU4z5doUoh/s7X05cnDoCKKJoXEuP04M4O
         SECg==
X-Gm-Message-State: AFqh2kow9dRYgWGy+Tny5hzGdJ2fJfQ7kuQqxWWzUgDndAQRVyjvZfBq
        wt84HH86O1wiOd2U/Kb12h4m6rQ0/aDbtMyAc/DDUy9rKTxF6iscczqOS4T54OlC2SYcB4GKgGz
        JMv6Wtvfwms/zxGZP5g88NtihIG6yKsfEeYRsF1s0
X-Received: by 2002:aa7:dd41:0:b0:46f:a73d:6bd7 with SMTP id o1-20020aa7dd41000000b0046fa73d6bd7mr418029edw.93.1671700777538;
        Thu, 22 Dec 2022 01:19:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvkyiuhyBopip+XvfvYqHHMpinouZZJTlfKlm1DIvH+vHsGNjxuontzwrB3mM8x3c2b5FEYMldk6bz7E7v/Ec4=
X-Received: by 2002:aa7:dd41:0:b0:46f:a73d:6bd7 with SMTP id
 o1-20020aa7dd41000000b0046fa73d6bd7mr418019edw.93.1671700777332; Thu, 22 Dec
 2022 01:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
In-Reply-To: <20221222060427.21626-5-jasowang@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 22 Dec 2022 10:19:00 +0100
Message-ID: <CAJaqyWetutMj=GrR+ieS265_aRr7OhoP+7O5rWgPnP+ZAyxbPg@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 7:05 AM Jason Wang <jasowang@redhat.com> wrote:
>
> We used to busy waiting on the cvq command this tends to be
> problematic since:
>
> 1) CPU could wait for ever on a buggy/malicous device
> 2) There's no wait to terminate the process that triggers the cvq
>    command
>
> So this patch switch to use sleep with a timeout (1s) instead of busy
> polling for the cvq command forever. This gives the scheduler a breath
> and can let the process can respond to a signal.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8225496ccb1e..69173049371f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
>         vi->rx_mode_work_enabled = false;
>         spin_unlock_bh(&vi->rx_mode_lock);
>
> +       virtqueue_wake_up(vi->cvq);
>         flush_work(&vi->rx_mode_work);
>  }
>
> @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>         return !oom;
>  }
>
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +       virtqueue_wake_up(cvq);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>         struct virtnet_info *vi = rvq->vdev->priv;
> @@ -2024,12 +2030,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>         if (unlikely(!virtqueue_kick(vi->cvq)))
>                 return vi->ctrl->status == VIRTIO_NET_OK;
>
> -       /* Spin for a response, the kick causes an ioport write, trapping
> -        * into the hypervisor, so the request should be handled immediately.
> -        */
> -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq))
> -               cpu_relax();
> +       virtqueue_wait_for_used(vi->cvq, &tmp);
>
>         return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> @@ -3524,7 +3525,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>
>         /* Parameters for control virtqueue, if any */
>         if (vi->has_cvq) {
> -               callbacks[total_vqs - 1] = NULL;
> +               callbacks[total_vqs - 1] = virtnet_cvq_done;

If we're using CVQ callback, what is the actual use of the timeout?

I'd say there is no right choice neither in the right timeout value
nor in the action to take. Why not simply trigger the cmd and do all
the changes at command return?

I suspect the reason is that it complicates the code. For example,
having the possibility of many in flight commands, races between their
completion, etc. The virtio standard does not even cover unordered
used commands if I'm not wrong.

Is there any other fundamental reason?

Thanks!

>                 names[total_vqs - 1] = "control";
>         }
>
> --
> 2.25.1
>

