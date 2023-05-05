Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5E6F7D36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjEEGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEEGqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93903156B7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683269142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKpAY5tib+SQpvOchvtEiIJtmEfRPK050PpqPwR0jHc=;
        b=XApaVaYhFFSj0aDxsb91UmXPsNa9bPzmfMraB6LF5bFaIrihGBcYGC2cowToau6bISyTMg
        ironTNdNf2qSF4jK/D4yModgtr2NDRn+7e68AMpPycl9P7g2+qBy0AXud6gf90X+2cg7fK
        3u+H88bR7YA2TeulahJgcTliwh/cWpI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-L1HOGZm1OTKGDe9_FGJ5Dg-1; Fri, 05 May 2023 02:45:41 -0400
X-MC-Unique: L1HOGZm1OTKGDe9_FGJ5Dg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4edc5d704bbso738937e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269140; x=1685861140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKpAY5tib+SQpvOchvtEiIJtmEfRPK050PpqPwR0jHc=;
        b=O7+I6M6ieOJCsmE26jprNa7VWoGZk8Ee5dV8NQpaH6Ao3gbQRkO3gq2JnIAWPBXHzQ
         5cr0V93YxiK8ynLBDVUaXnlTiqTZ8LYeHs/uSpcKL+v/iEf9qa8a9pt1NlwguqttnaaL
         Ce33sm8ZH8wGI38RW2D2CwgRxUl4R37jlnc3+OlLaaPi9udVKAuepEgM1utHz8fAPLjV
         Lc7jDuaBn9LakP6FbZZs3GqchY84M7Uk2FcxIHid78qq3a2/aL6n6eZsnwOaSqBoW+w9
         cH7BZNqo+sTg2ACAdbIH4k0h5FyK3BHqZKj4NbMsidqrDJsfnmNc7v9Gv4I4qMBgIs4h
         FPmg==
X-Gm-Message-State: AC+VfDyt64BaMwW/TJGDMGQVOPy5QAhQZ6Dfv5oUdrqmis/cpb3d247Q
        Fe5b9ljzaI9YHIv+F3W7Oz2gg5iltCUMZPEykocQ+t/Wbl2Du9Y7NNwpXeTAntnK8kLu1m/h6DH
        1CNzL4PhHT+5h0Ts7UvsZqi5ggvrpLtRIzGCjJ3Xi
X-Received: by 2002:ac2:442a:0:b0:4dd:afd7:8f1 with SMTP id w10-20020ac2442a000000b004ddafd708f1mr243037lfl.52.1683269139920;
        Thu, 04 May 2023 23:45:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P/6Ery2ecRIgtV5T5zf4Jc/nCqTDngMKXH4mXgZ7mTAePFoMVTxdzE82a2WU80aozee42X8+tx+80IrXPk0s=
X-Received: by 2002:ac2:442a:0:b0:4dd:afd7:8f1 with SMTP id
 w10-20020ac2442a000000b004ddafd708f1mr243034lfl.52.1683269139638; Thu, 04 May
 2023 23:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <202305051424047152799@zte.com.cn>
In-Reply-To: <202305051424047152799@zte.com.cn>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 5 May 2023 14:45:28 +0800
Message-ID: <CACGkMEsmf3PgxmhgRCsPZe7fRWHDXQ=TtYu5Tgx1=_Ymyvi-pA@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: Use fdget() and fdput()
To:     ye.xingchen@zte.com.cn
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 2:24=E2=80=AFPM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> convert the fget()/fput() uses to fdget()/fdput().

What's the advantages of this?

Thanks

>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/vhost/net.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index ae2273196b0c..5b3fe4805182 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1466,17 +1466,17 @@ static struct ptr_ring *get_tap_ptr_ring(struct f=
ile *file)
>
>  static struct socket *get_tap_socket(int fd)
>  {
> -       struct file *file =3D fget(fd);
> +       struct fd f =3D fdget(fd);
>         struct socket *sock;
>
> -       if (!file)
> +       if (!f.file)
>                 return ERR_PTR(-EBADF);
> -       sock =3D tun_get_socket(file);
> +       sock =3D tun_get_socket(f.file);
>         if (!IS_ERR(sock))
>                 return sock;
> -       sock =3D tap_get_socket(file);
> +       sock =3D tap_get_socket(f.file);
>         if (IS_ERR(sock))
> -               fput(file);
> +               fdput(f);
>         return sock;
>  }
>
> --
> 2.25.1
>

