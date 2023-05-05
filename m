Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01666F7B83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjEED3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjEED32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAD12082
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683257320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtGTOV4w8H+HmedJBYfP7zUt+D2uJS6ykp/9DQHbib8=;
        b=dryACXacK7uRTKssh7c0+0kPyq98/16rMWUDDJN0uK544AaCTYl0xBMoaWwgq5+tgwdJg1
        X1y3t0Nr2id7zbVmFH2bBCsFdYo1Yx5M3yAsUqvC9UEh5CvgWUWVeEk2UFEbVAqXI+rbiv
        niNCZjxuq4DAduFREy+zIzzRpuLQWdk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-IC-gzcE2OP-rKPUZxRUE9Q-1; Thu, 04 May 2023 23:28:38 -0400
X-MC-Unique: IC-gzcE2OP-rKPUZxRUE9Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f12f45d113so696845e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 20:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257317; x=1685849317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtGTOV4w8H+HmedJBYfP7zUt+D2uJS6ykp/9DQHbib8=;
        b=W4Sn2GxuQI6iggCKCPDtqM0vVHDUHs3Adhv2J6KiLy4jNUbpPAYIDWuFS+xVpXeixC
         bv3JH3VMaB2azqpVQMhg8bWibV93htaieIQ7SjSPyQa7dYRjDt4zNp08aehRIMjRz3x1
         Fpr+ETEq5WG9y/Ni3fzKt5oosxHU2IJEn7dZuoVaX2+v3emFZv4QubF8O4fj9ZyPOCPB
         PYKQpfDHdLpdt4Pk+HOZVBeS0CIYL7On9gPGYfsdR895cqlcgJ6NoD4rsIekAj+bGgA/
         SGPylKX2mtwn550NAI82YROY221JiB1DnTGg74VeVJ2VoPUeVw6UeF4kb5ud0oEcIgxA
         znxA==
X-Gm-Message-State: AC+VfDzL4CKalj4znDra3+PlU/ZgJdC3km8DTPWd/Fmn0m+uYblvZBUU
        8EaYPF7aVj7OOoS2SThns+zaom7IdMPNcGEnAS6mjwa6Dz3lOP8Yn6uVGU0HS8cemkTMXzKkABk
        qg+WrIivp2FBc3jqBj+Jhb0vxTgaUA6rzvLIXhscw
X-Received: by 2002:ac2:4d1a:0:b0:4ec:363a:5f24 with SMTP id r26-20020ac24d1a000000b004ec363a5f24mr132430lfi.23.1683257317336;
        Thu, 04 May 2023 20:28:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ipOT60VlicZnRmQ8NuJpg74uxqB+3AiqJuLc3hm+sdWRslDFolnCBok9HRcDycod3TakBwcUmh99tPZ15x4I=
X-Received: by 2002:ac2:4d1a:0:b0:4ec:363a:5f24 with SMTP id
 r26-20020ac24d1a000000b004ec363a5f24mr132425lfi.23.1683257317049; Thu, 04 May
 2023 20:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
In-Reply-To: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 5 May 2023 11:28:25 +0800
Message-ID: <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
To:     Wenliang Wang <wangwenliang.1995@bytedance.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zhengqi.arch@bytedance.com,
        willemdebruijn.kernel@gmail.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:27=E2=80=AFAM Wenliang Wang
<wangwenliang.1995@bytedance.com> wrote:
>
> For multi-queue and large ring-size use case, the following error
> occurred when free_unused_bufs:
> rcu: INFO: rcu_sched self-detected stall on CPU.
>
> Fixes: 986a4f4d452d ("virtio_net: multiqueue support")
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> ---
> v2:
> -add need_resched check.
> -apply same logic to sq.
> v3:
> -use cond_resched instead.
> v4:
> -add fixes tag
> ---
>  drivers/net/virtio_net.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8d8038538fc4..a12ae26db0e2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3560,12 +3560,14 @@ static void free_unused_bufs(struct virtnet_info =
*vi)
>                 struct virtqueue *vq =3D vi->sq[i].vq;
>                 while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NUL=
L)
>                         virtnet_sq_free_unused_buf(vq, buf);
> +               cond_resched();

Does this really address the case when the virtqueue is very large?

Thanks

>         }
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 struct virtqueue *vq =3D vi->rq[i].vq;
>                 while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NUL=
L)
>                         virtnet_rq_free_unused_buf(vq, buf);
> +               cond_resched();
>         }
>  }
>
> --
> 2.20.1
>

