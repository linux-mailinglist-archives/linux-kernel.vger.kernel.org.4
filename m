Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B621C6823D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjAaFYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjAaFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:24:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9DE38F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675142599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBuwpBVXvpFhXGcDe/LdMP61Sfzf57MnN//0wiFS4tA=;
        b=bknq3fgdbkDTwq1TVPDd65JuilgHInI9BT8Pf20onM44IZ9HT017XHk8C1K7RYCWhGReus
        vrWliDnMLT5LxlSrufweKT97nMIjbZiGu9JHMg11jE3QBjuNEh2396hVOhpXlRPyYEl/Gt
        p3j5LSc/LK3m41BDjLIa8Zpt5f22/gc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-D3CD3ZYmOJ6-g194vlWFSg-1; Tue, 31 Jan 2023 00:23:17 -0500
X-MC-Unique: D3CD3ZYmOJ6-g194vlWFSg-1
Received: by mail-ot1-f71.google.com with SMTP id e20-20020a9d5614000000b0068401872536so6595712oti.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBuwpBVXvpFhXGcDe/LdMP61Sfzf57MnN//0wiFS4tA=;
        b=FxP1I4YlMjKO7kyOq/fjRsOZmDkueixK2zcupYpIS/o7ln4rj1/PNdEN7TXXAwCiMb
         oiur03QvA79duWgvzzpaqNBXgQbotRSGEk1QLCdW1pv/mcKD6Vt6lj73SQa9512K7QhQ
         nLorUuQjHiX897YA0ylmiiuOfjzqTb7OjLMmILqdcZFwQJLD5IZ/yCRUKyLLiy+8a2C0
         n0CSjfK32NQ4HgkIvFxTRI+PQUfIsDEXoQL4cmYdaZUxEjd/dGhK4zLpdPmJXElPiKoc
         XvCBQSb68pglRgZBva3u9eWlFaNyBuXQ0+syn/1OaUOQ2J3qPg0QDvg9xC5A+BwlVJmR
         9zzw==
X-Gm-Message-State: AFqh2koHTcIkUCcsCxpJG17VtcTExdkJC4nUa91P+2/HvaDuHMcske3S
        bmiWTSG31cVBUJ2E1+GAh8DVGo/KmLewSINLAIwNY22/PO1/5vyVbTmHSGHMGkiSrY8XVASACMC
        q1GOCmVpJI+BebCRUftx0K+0kTjsTjynre8RszMKx
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id y14-20020a056871010e00b0015b96b59916mr4391886oab.280.1675142596878;
        Mon, 30 Jan 2023 21:23:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtz7jMxZSFLd+CNnOJpiqDKGvOYMcNJ6sBtUoRkm8qhoapPK42eBepYF1fhvcrqoTDubwtnrXBwROgRvtImXgM=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr4391882oab.280.1675142596696; Mon, 30
 Jan 2023 21:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20230130092644.37002-1-colin.i.king@gmail.com>
In-Reply-To: <20230130092644.37002-1-colin.i.king@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 31 Jan 2023 13:23:05 +0800
Message-ID: <CACGkMEu9eg3aem4a_Xu_uxn4HvifyQqe-JRfH0rdxXDmsMfDuw@mail.gmail.com>
Subject: Re: [PATCH][next] vdpa: Fix a couple of spelling mistakes in some messages
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 5:26 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There are two spelling mistakes in some literal strings. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa.c                  | 2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 6821b2850bbb..a1bb5b92212d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1016,7 +1016,7 @@ static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>         switch (device_id) {
>         case VIRTIO_ID_NET:
>                 if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
> -                       NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
> +                       NL_SET_ERR_MSG_MOD(info->extack, "queue index exceeds max value");
>                         err = -ERANGE;
>                         break;
>                 }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index e827708adcca..862f405362de 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -324,7 +324,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>                                       rx_errors, VDPA_ATTR_PAD))
>                         break;
>                 if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
> -                                 "rx overrunss"))
> +                                 "rx overruns"))
>                         break;
>                 if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>                                       rx_overruns, VDPA_ATTR_PAD))
> --
> 2.30.2
>

