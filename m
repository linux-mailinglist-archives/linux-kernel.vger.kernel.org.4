Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B26B5B96
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCKMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84F12BC4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678537390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0ncK7kQPU4tM41Xw7Dto2fGmFTmgA/05JfWF548UL4=;
        b=dYiooBR2Sdu5dFshiJ9qC/T8ok4+mS7Q2S3r3zV+E1MyJ54xe6mLCEPWRaqjYZfjLjIp8I
        MxaudMgv2tL0f60UN4xoJhqFBXKcgwiPYnOzJlgbsSz1G7AP4r1tZR4VscCObBL2t2L/dC
        sbDBFflTRXJanvTwcRtY7x/WiC+s/js=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-DHssJIeHOdGAfpKlKr2KuA-1; Sat, 11 Mar 2023 07:23:07 -0500
X-MC-Unique: DHssJIeHOdGAfpKlKr2KuA-1
Received: by mail-qv1-f69.google.com with SMTP id oo15-20020a056214450f00b005a228adfcefso617609qvb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0ncK7kQPU4tM41Xw7Dto2fGmFTmgA/05JfWF548UL4=;
        b=C1Sm+QpitNkt6PqAjr6dMinSRSOYojCMNPxPNz2DJQWg4ZVZ0rlCk31Cd+y5pXCB7D
         FxFAmLIR2zAHW5AlggONbMdPzoIQCaN572wBycR9vZDNmr0hpLaeT9d8qnVuwuNNmKcK
         XXbRh7qfj8j0IuZ9AzJHTAkuvm2D4wRaQJ8qkxW5D8FyVeEQTzTYu5yCmgLXlpmQckMt
         3yJGUL8oci4N/8R89A7nf1inxKqK0tZby5MyAWh71i9MIDES3GptMSnK4Ve5s6Y2oKIn
         iTQi6zYc7mSRjdYjPNgc1xIDYmSX8xtkLoJs09IFIBFkBsUBZu+Xe4KjXgZwZBnCkZkO
         MqZA==
X-Gm-Message-State: AO0yUKWsws2hFF6faVVnXUnKdiJMJwlqOs4lMzqNb5vE/ujHIjp7MV0u
        cIvOAR1mE9OborDb7w1cSiUE6XM243LLje/1iwnimTSPTpGPxEM1R54ctZc7ch816aF2XeKo0Gr
        3DPAhCc7LxuL4yVz2cXIUgx02FTHTmqJQhJcW/ws7
X-Received: by 2002:ae9:f00a:0:b0:742:6e03:4091 with SMTP id l10-20020ae9f00a000000b007426e034091mr1365172qkg.6.1678537387414;
        Sat, 11 Mar 2023 04:23:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+ahdPUjKtqLXS4t/tIFiVrX+FhWFPj4c7AdJccBkphBZCKDMNyJB/8I64SarjmIvrKHtooaHXg7cKfznTu95I=
X-Received: by 2002:ae9:f00a:0:b0:742:6e03:4091 with SMTP id
 l10-20020ae9f00a000000b007426e034091mr1365155qkg.6.1678537387081; Sat, 11 Mar
 2023 04:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20230310201525.2615385-1-eblake@redhat.com> <20230310201525.2615385-4-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-4-eblake@redhat.com>
From:   Nir Soffer <nsoffer@redhat.com>
Date:   Sat, 11 Mar 2023 14:22:51 +0200
Message-ID: <CAMRbyyv59L9GiLr5tJvnNdwnBNdNGw+xveG7S63WC9ycOuJYrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block nbd: use req.cookie instead of req.handle
To:     Eric Blake <eblake@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:16=E2=80=AFPM Eric Blake <eblake@redhat.com> wro=
te:
>
> A good compiler should not compile this any differently, but it seems
> nicer to avoid memcpy() when integer assignment will work.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  drivers/block/nbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 592cfa8b765a..672fb8d1ce67 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -606,7 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struc=
t nbd_cmd *cmd, int index)
>                 request.len =3D htonl(size);
>         }
>         handle =3D nbd_cmd_handle(cmd);

This returns native u64 (likely little endian) but the new interface
specifies __be64. Should we swap the bytes if needed?

This will help tools like the wireshark plugin to display the right value
when checking traces from machines with different endianness. Or help
the nbd server to show the same *cooike* value in the logs. The value
is opaque but reasonable code can assume that __be64 can be safely
parsed as an integer.

> -       memcpy(request.handle, &handle, sizeof(handle));
> +       request.cookie =3D handle;
>
>         trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(c=
md));
>
> @@ -732,7 +732,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_de=
vice *nbd, int index,
>         u32 tag;
>         int ret =3D 0;
>
> -       memcpy(&handle, reply->handle, sizeof(handle));
> +       handle =3D reply->cookie;
>         tag =3D nbd_handle_to_tag(handle);
>         hwq =3D blk_mq_unique_tag_to_hwq(tag);
>         if (hwq < nbd->tag_set.nr_hw_queues)
> --
> 2.39.2
>

Also the same file has references to *handle* like:

static u64 nbd_cmd_handle(struct nbd_cmd *cmd)
{
    struct request *req =3D blk_mq_rq_from_pdu(cmd);
    u32 tag =3D blk_mq_unique_tag(req);
    u64 cookie =3D cmd->cmd_cookie;

    return (cookie << NBD_COOKIE_BITS) | tag;
}

static u32 nbd_handle_to_tag(u64 handle)
{
    return (u32)handle;
}

static u32 nbd_handle_to_cookie(u64 handle)
{
    return (u32)(handle >> NBD_COOKIE_BITS);
}

So this change is a little bit confusing.

I think we need to use a term like *nbd_cookie* instead of
*handle* to make this more clear.

Nir

