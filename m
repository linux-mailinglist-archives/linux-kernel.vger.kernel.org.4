Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DA71204F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbjEZGkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjEZGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457319D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685083149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+bs/EeksfHI43M3AGFfTiuW/uRtRdXfogNY4shc8y0=;
        b=WLMbS94xPsz+u7Wie7Ayi82I70i2vj2Rr7bz452sX4SdjFMpS9nufnsXPcxZhrLqRlZLEJ
        ZFThEwWBZXOJS7Rmki9rZ/YeBxDsUXoGLzbLeA23YBK00NcXIaFJX0/bVTHAz1Doj5w4UZ
        cZjUta8gbKrja2bJj8tnJrOL5kcTkXY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-WnTrTTXAOMOI_IfSkuWpTw-1; Fri, 26 May 2023 02:39:07 -0400
X-MC-Unique: WnTrTTXAOMOI_IfSkuWpTw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f4b7b4e7c5so181979e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685083146; x=1687675146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+bs/EeksfHI43M3AGFfTiuW/uRtRdXfogNY4shc8y0=;
        b=Lnben8ZfjYlpNs6YHeSgIUoKKM+wlcMqkbSp0BRnnw+qjZHakN5zuoCjPOaP3khTnB
         O+hbL6avT7fhuJHa2KOLxPcwuwanX6ZfSlp9iSRwIRlH4w5FOvZNpbs0quyjKgts4W7P
         9HCdVjJfkjRWECAE1jX14iLqC4T//8bwSm3vbsWMKuOdAiZnA76JeF/noKa8K43OzPZO
         pzuf4/Tt6B6tmVLYCXXBu6A0rSmvCPJOEG6btpVDNK3/4hiekT/rSc3DBcgFPbz+QsI4
         7I2QIs/6L9hq8oAlA0gTe6WOoRLWSOYdgh2lo1KCPRHWMMPIYJBn27pGMOJMsAzHnd7O
         6+Mw==
X-Gm-Message-State: AC+VfDzLMVFfykmoKpkKHanZANyaCADMO4QcWNikfnB+W9TP//UpPyC0
        ICVUUHUIve0PhFMzGwI84ZckVlpaRd0RIRhralivgUXFHXJVED90J3hZeTBbWVzirshs63hwbWt
        1035POd5iVqN/NVbQBQtDXoGD1l0hl94xoPD8Riw8
X-Received: by 2002:ac2:5584:0:b0:4f3:ba53:35f2 with SMTP id v4-20020ac25584000000b004f3ba5335f2mr348199lfg.49.1685083145940;
        Thu, 25 May 2023 23:39:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZGMBvmDOnk6A1M9x8uXTgZpQopDuFIrCe6DF0zYSEQVhyP15JnRWL7SWoXzSYalkqHdBnvbODVvBx4F4Izbo=
X-Received: by 2002:ac2:5584:0:b0:4f3:ba53:35f2 with SMTP id
 v4-20020ac25584000000b004f3ba5335f2mr348187lfg.49.1685083145623; Thu, 25 May
 2023 23:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 26 May 2023 14:38:54 +0800
Message-ID: <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 1:46=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> "private" of buffer page is currently used for big mode to chain pages.
> But in mergeable mode, that offset of page could mean something else,
> e.g. when page_pool page is used instead. So excluding mergeable mode to
> avoid such a problem.

If this issue happens only in the case of page_pool, it would be
better to squash it there.

Thanks

>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..c5dca0d92e64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -497,7 +497,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                         return NULL;
>
>                 page =3D (struct page *)page->private;
> -               if (page)
> +               if (!vi->mergeable_rx_bufs && page)
>                         give_pages(rq, page);
>                 goto ok;
>         }
> --
> 2.31.1
>

