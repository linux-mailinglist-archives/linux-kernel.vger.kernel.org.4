Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7796A9969
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCCO3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCCO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:29:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F81812BF7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677853724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3ApB4exZoXcG63nEHDI8L+9x3I4wPipSfbFGyH/f0E=;
        b=Kqq8v9XjdczmMFawP4kWi7W8SzB8q/q2eZcBFBSs6gdgFVlpmX1Xb9VBj5t/y7C7hTClF/
        A/pp0lUaoY2Zqu+4sdmWMFFsegKLTgbvrFqGySSyTp/fg9n9/uMgWbXHSP47f75Athy6Rr
        s0oag1wOb2OLHXf5GXqHcMs7Wn8XShk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-2Xu_6hE1P46BBoc39_A4Iw-1; Fri, 03 Mar 2023 09:28:35 -0500
X-MC-Unique: 2Xu_6hE1P46BBoc39_A4Iw-1
Received: by mail-lf1-f72.google.com with SMTP id k7-20020ac257c7000000b004db20d1cf7fso1074648lfo.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3ApB4exZoXcG63nEHDI8L+9x3I4wPipSfbFGyH/f0E=;
        b=sAIOOqa+niv/bQtGZYa5uikWkyNOUYGloIq1Ab/DQB6t9AyK8p9Y+/6b94PxdPzq9A
         sS7VsZtxyHztwOY0sspE00hgCJTLAbYW4G3YjLhNblS6swPMOEhI1lGT3V4MNOrNRDnY
         G2AQBexbmCSGhH63etstQ23srM2CbX1phgwCop1GwZ26L0gZ4dOhkDPRGZI4tQ3AxChr
         bompYyXX5EuB3EOhbluGXGhxE3R9Bx4V5EFJ7fgw7XPJFm9JkHfQmmUtpazy7sSNefxV
         2LNuxDxsQqafMo3bGgKD1gKig2/bgcGbli2Kg1OhgKthjhWhxBmlf7bhr264cPbohuHJ
         vkJg==
X-Gm-Message-State: AO0yUKWEPqpoeogiqwmGvOimYu31UOSBLsnE9WfneL2Ab8VI+L1kn+Wk
        xlm4pym/Y7apiTe93c/SWIsdXQffmcPG2pBmb+VCB//sfeZyR5TfwglyiCrE9hdsnVuteKtx7ik
        w9e7vwmuQ44uosF/2TUTJyDJiJ/Sx6l3hHg3Xj8zI
X-Received: by 2002:ac2:5927:0:b0:4d5:ca32:6aec with SMTP id v7-20020ac25927000000b004d5ca326aecmr645064lfi.12.1677853714512;
        Fri, 03 Mar 2023 06:28:34 -0800 (PST)
X-Google-Smtp-Source: AK7set89z3ZaDV+0l8hN22o89ZbCZILIi4QRjANWBxaYKra+nJigSS7Ho1XPgvAOO/WyESHVRzmPsFP0RA2BCA7iIf8=
X-Received: by 2002:ac2:5927:0:b0:4d5:ca32:6aec with SMTP id
 v7-20020ac25927000000b004d5ca326aecmr645049lfi.12.1677853714194; Fri, 03 Mar
 2023 06:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20230303132731.1919329-1-trix@redhat.com>
In-Reply-To: <20230303132731.1919329-1-trix@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 3 Mar 2023 15:28:21 +0100
Message-ID: <CACO55tuMxp5M+zgG_p3QpXUfrPhcssPMz91tfMBFt5OVobOSaw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/fifo: set gf100_fifo_nonstall_block_dump
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

On Fri, Mar 3, 2023 at 2:27 PM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:451:1: error:
>   no previous prototype for =E2=80=98gf100_fifo_nonstall_block=E2=80=99 [=
-Werror=3Dmissing-prototypes]
>   451 | gf100_fifo_nonstall_block(struct nvkm_event *event, int type, int=
 index)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> gf100_fifo_nonstall_block is only used in gf100.c, so it should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/fifo/gf100.c
> index 5bb65258c36d..6c94451d0faa 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
> @@ -447,7 +447,7 @@ gf100_fifo_nonstall_allow(struct nvkm_event *event, i=
nt type, int index)
>         spin_unlock_irqrestore(&fifo->lock, flags);
>  }
>
> -void
> +static void
>  gf100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
>  {
>         struct nvkm_fifo *fifo =3D container_of(event, typeof(*fifo), non=
stall.event);
> --
> 2.27.0
>

