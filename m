Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B908A61EC5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiKGHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKGHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D64120BC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667807089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
        b=Iek/KzOm2J73QybFzp5A+L2iWxWBjp2WXKoPDaaLNgq+N12aBMniEGJVmp+lnwadQ0jdrx
        8tERIGfc1oWzKh9Wei61CpARNySIbq1b9XWTR+qFX5N/e6TLJhvgN4TTD0sXPLivHcwSIH
        aumi2rfkX6IlRZvFDTxjFS0dTCclSoM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-5tECyuVYNWK7ooNjOY3TyA-1; Mon, 07 Nov 2022 02:44:47 -0500
X-MC-Unique: 5tECyuVYNWK7ooNjOY3TyA-1
Received: by mail-ot1-f70.google.com with SMTP id s5-20020a9d7585000000b0066c7a3ddf59so5290927otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7z2W2hOxemz6tv67+J3i16DweKsS7PYaPjormYEZtI=;
        b=sHY6BcDOqTdmHAigTVZpyNE0CObuns/Aut1VRT2Gj8h/ub2JrpL0FHavBhN0uaAg9M
         oOMzCpWdFuvnHQv2ZuYNgB0cgZaNXz7lqfrXCt+jr0JDQYpsI3aNevXuoIIDcQ390Ow1
         SDX5l5yp5d/Aw+DO53k7rK+UB9Kk1KaNhc8q4eKRFx4UAu/UDAqVHk28GsFHN6sBweRK
         QXUaBaM9WoJnqe/mP5YoN4KNdxUrUY4RvvdJcrRcM/PajBspmcGTGkedEl13I9Er4BNt
         XKt7Q6uBZe9a+PZXrAvl0HEl0bG2L+AQa/6QdQuvaj1u04zm31NuZUJhMCb5v7+TmW84
         iyPA==
X-Gm-Message-State: ACrzQf0y8nvRE5MNvz7F5aWgYl8LKd/DLkmQYmQIxVtVQvJ48jpmXwi1
        hSGz2t1D9bOfKpD7LeAp/OtNAJt2h4I6LG2A0U+sbswH8Bgk1oLcjmQk6nrH5a2AKkQnf3/IEkb
        /A5gKDkFrVzq+qz1MKK5mdMhBmypoxV6yUlFHYgYz
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id t14-20020a056871054e00b0013b29b7e2e8mr37655792oal.35.1667807087058;
        Sun, 06 Nov 2022 23:44:47 -0800 (PST)
X-Google-Smtp-Source: AMsMyM43CuZtbbZUUL09mIBdM0KXhoZTHYA7ejIPeVZeiGHn6tLwkEXQi3wb+5rVf+Ne1rZHUmGFX/lGOM+1MoRzqcc=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr37655777oal.35.1667807086875; Sun, 06
 Nov 2022 23:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 7 Nov 2022 15:44:35 +0800
Message-ID: <CACGkMEtPGK1rkpbtDNQYKNZTMpgx+iPSMyK_aBQ_e=7356mLTA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Oct 22, 2022 at 4:42 AM Rafael Mendonca <rafaelmendsr@gmail.com> wrote:
>
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Do we need to cc the stable?

Thanks

> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..291f705e61a8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>                                         struct virtblk_req *vbr)
>  {
>         blk_status_t status;
> +       int num;
>
>         status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>         if (unlikely(status))
>                 return status;
>
> -       vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -       if (unlikely(vbr->sg_table.nents < 0)) {
> +       num = virtblk_map_data(hctx, req, vbr);
> +       if (unlikely(num < 0)) {
>                 virtblk_cleanup_cmd(req);
>                 return BLK_STS_RESOURCE;
>         }
> +       vbr->sg_table.nents = num;
>
>         blk_mq_start_request(req);
>
> --
> 2.34.1
>

