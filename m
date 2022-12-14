Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3364C3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 07:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiLNGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 01:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 01:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7264639A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670998053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dYXLJoN5dP9NW2lg01y5/yjuzNPbyCS4n0VoKBGjJPU=;
        b=Ov8y7UdpG001APONdyViiUz+zNbuOnV1Zn3sTBnuXHrUOHY8YHWECJhWwYBJ2kYuWJ9YhD
        JKo3XSZZvm7SFaNehYS//32zEzh7W7nTqcu4QnMRJSrbr1/lsf0j7vJ/FTgyuloNdfF8Ym
        fqD4H5ezmLZwUwlI1eXRB67ZwVm/Od8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-XwByG8doMwe_quU1Rt3q6w-1; Wed, 14 Dec 2022 01:07:32 -0500
X-MC-Unique: XwByG8doMwe_quU1Rt3q6w-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-143c7a3da8aso4945095fac.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYXLJoN5dP9NW2lg01y5/yjuzNPbyCS4n0VoKBGjJPU=;
        b=ij0sCsi4mv5ZZxKOSjeyV6WLpPzoIdJFAjbO/4CS0baEAicqi6rWQz3TGyjorcrQCu
         aCcVp89u67Bm2UnKU1brdMP7PA8D5qzgEXyoR0Aa2WbgNIsYP9TX4M8cKnN1jYIYWucn
         kJBO0S2HTvye5h5WMYssfAR8NhGm0YIXBa8XgptF/JtI2Y1n1Es2K5bulj+kRMtyDDU8
         LdeAQ+Vf7K/myMX2k8U+GxCGqSBY1W4acFZ11f6uXR6JYYLWly+esdeHVWxbUKRhRvoX
         SECtE1Db2oRy87YIXrF/84qwEWROnWShLGJbfvhTu39YdIlwJ9CuJHhKtjmoTxK/3U4i
         y7Yw==
X-Gm-Message-State: AFqh2kqFO6FHcuS1B2/Rt2euch/t6UniP4vbHbijgWQcSEbGCBDNX9h+
        d21ozQV+2o0f20VDlF2/v9xcb0tkeA+rwjakRmHj9JrjvJmiRjrQHmSGEgSSUkH7ScxDgWS4KjQ
        mYR1JzT+shAqXPiKQaBzWk5CZI7OgDGv1n3/kvhO5
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id nw26-20020a056870bb1a00b00144b22a38d3mr120381oab.280.1670998051127;
        Tue, 13 Dec 2022 22:07:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtd2jYdwaV4dxEOpTRHj2thmSUZZrgKIt6DRY5YGFqRfCpKAe9rId2osrQITeJMjFJGSD4lh8eHuJwUYDnMBSg=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr120378oab.280.1670998050902; Tue, 13
 Dec 2022 22:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20221214054306.24145-1-lulu@redhat.com>
In-Reply-To: <20221214054306.24145-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 14 Dec 2022 14:07:19 +0800
Message-ID: <CACGkMEuLnCqzKF+_P1Z-iaTiQkiz5U-Ovekyw94WMPaug76Adg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_net: should not drop the multicast/broadcast packet
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 14, 2022 at 1:43 PM Cindy Lu <lulu@redhat.com> wrote:
>
> In the receive_filter(), should not drop the packet with the
> broadcast/multicast address. Add the check for this
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c3cb225ea469..0f4739c31eea 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -62,6 +62,9 @@ static bool receive_filter(struct vdpasim *vdpasim, size_t len)
>         if (len < ETH_ALEN + hdr_len)
>                 return false;
>
> +       if (is_broadcast_ether_addr(vdpasim->buffer + hdr_len) ||
> +           is_multicast_ether_addr(vdpasim->buffer + hdr_len))
> +               return true;
>         if (!strncmp(vdpasim->buffer + hdr_len, vio_config->mac, ETH_ALEN))
>                 return true;
>
> --
> 2.34.3
>

