Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB04666C84C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjAPQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjAPQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:37:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957531E37
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673886301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SapRDhSD4bg3SNicTSW2wGgbS66LIJZoHqZZ/9cufV4=;
        b=KKec3WhzPW49Hf4c0lgI1FRD59s0ltp1jZD5Yma+1MwitgrYXw0tyZPhSThkpO6AHUUO4v
        OYHEynqate4/Ir6Jo0Oi4hL3BoIw4aiXylOydVFyoQRLwAb159N6mDYGCmhqIGiDvDtLrq
        Uxt37DiTFFr5SFf1rS0ymavoWvHpDfk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-355-xnb5Pp4FNDaT1c235wdM-A-1; Mon, 16 Jan 2023 11:25:00 -0500
X-MC-Unique: xnb5Pp4FNDaT1c235wdM-A-1
Received: by mail-lf1-f71.google.com with SMTP id q9-20020a19a409000000b004b6ee156e03so10473850lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SapRDhSD4bg3SNicTSW2wGgbS66LIJZoHqZZ/9cufV4=;
        b=iC8vqvgwE3ewHpzNCLeDBmjmjj9CwhYTRmtdc9/4PWRmL9FY1Wf4ua4CaVk9u2IDXV
         gdM2ZBZlNjr+Kyd9W9uCemIMfxKtoaNMBHgEDp9UpTu3nLCME9wqn8BELOo4TmeEAach
         lG0d41J/HrKyRGhc19gJqzS+7rNhH4Ct1ZAckFMLBVKEpyiKIdd35QTUtrU4U11ImeBX
         AntTNz1E2eWkS3yT5a2133/U7V1uPUoe5xpZxEXk3UwI/r4ELRg78S0q2ZSZy/9XG30D
         Uy2DYMRKgVlZchcsIiv3+WhkGzIWH5JrJ7r9XUw4JYmVyCGRsYEJsDCPYw25eMOrfpJ7
         xXxQ==
X-Gm-Message-State: AFqh2krMNPx+qWFzl+sZ0cleu/ddamzT5VRqOaiayT5RGdc5lfXDNw88
        NqwjJakGkNX5Vw9vhHB0sHBtAO4np6cqkPUz9DUoKM0Y9BS8wP58CnzRIn7MLuCfTrldbrzz/RS
        ODJjTs8jn2nZDkguteUHw1c5pDzvrf9Xb5GNwSuEZ
X-Received: by 2002:ac2:4f8c:0:b0:4d0:7b7:65dc with SMTP id z12-20020ac24f8c000000b004d007b765dcmr483281lfs.122.1673886298802;
        Mon, 16 Jan 2023 08:24:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXskVXALh3cMxytws6o+ulKkC0aRueGIcJS8YRlvP7WpfCxojGKp4y72qPmz5veoTJzcgsV96C0ycbrb/7Q/f08=
X-Received: by 2002:ac2:4f8c:0:b0:4d0:7b7:65dc with SMTP id
 z12-20020ac24f8c000000b004d007b765dcmr483278lfs.122.1673886298656; Mon, 16
 Jan 2023 08:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20230103234835.never.378-kees@kernel.org> <Y7TNtQqunHIW8her@work>
In-Reply-To: <Y7TNtQqunHIW8her@work>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 17:24:47 +0100
Message-ID: <CACO55tsyCtf-_mCPVEo-4Dj_mAu-tnNTTjP75wx=9n+TS1XVvw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] drm/nouveau/fb/ga102: Replace zero-length array
 of trailing structs with flex-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>
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

On Wed, Jan 4, 2023 at 1:52 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Tue, Jan 03, 2023 at 03:48:36PM -0800, Kees Cook wrote:
> > Zero-length arrays are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> >
> > Replace zero-length array with flexible-array member.
> >
> > This results in no differences in binary output.
> >
> > [1] https://github.com/KSPP/linux/issues/78
> >
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Here is my RB again:
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

> Thanks!
> --
> Gustavo
>
> > ---
> > Sent before as: https://lore.kernel.org/all/20221118211207.never.039-kees@kernel.org/
> > ---
> >  drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > index 8c4cd08a7b5f..8b58b668fc0c 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > @@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
> >       struct {
> >               u32 offset;
> >               u32 size;
> > -     } app[0];
> > +     } app[];
> >  };
> >
> >  const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
> > --
> > 2.34.1
> >
>

