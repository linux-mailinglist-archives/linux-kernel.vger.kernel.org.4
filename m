Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62D66BCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjAPLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAPLfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3807166CD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673868867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWPoxshq9dPBmcr/9P1qWrfk56DNaf4wBLS0tkWKWM0=;
        b=EPprxwnrLIWF0n6mCiDL28OYBSLYjVrehGIIS14UWRD2LG5qoJ8q4Ubc3MYUqxOBe/Sj5P
        GzQ1PyYFuLiE8uV1PvJXycbw+fMdiyLRw1CBDdQTF96nJUxWyxH3B6y+t+7fVIHbXdi4sQ
        k1NUs/iDofgwIXQyy8M9MHE9Hy0dCGs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-sqG84yPRMA2johNZyDsxTA-1; Mon, 16 Jan 2023 06:34:25 -0500
X-MC-Unique: sqG84yPRMA2johNZyDsxTA-1
Received: by mail-lj1-f198.google.com with SMTP id a25-20020a05651c211900b0028b7a49f813so1102728ljq.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWPoxshq9dPBmcr/9P1qWrfk56DNaf4wBLS0tkWKWM0=;
        b=07Q9sI5h99Ou4thmanxsYQp7iAYYCTZHea4eXPdJPcI5Cj1Dr8SVGMarHfhUIE5DcD
         LRcy/3iS6r8iN9mlsB2veep1LjjkFegirkanGBQ2BXZxu08VAZD3idWQpLlFZOfChYVy
         5WCLiomw3MvyL2dLKg8K9oDPK9MIpwJeQjUOst7BwwxQA+nEwMmRZMDBSvdhlvJ2T5gh
         PqnA83cASUhUc4/dOprPNSrnbqV2wrzqHa+prtt6Xxv1+JjavNiq607x8vDbmqw0dplL
         80BQCjQ3OBOhD3LqTs6VFNk8U23yq4athyBzbhoGnWGhr6EkzL3olZIDJTUwM+Q17SWi
         E0/Q==
X-Gm-Message-State: AFqh2kotzLG/q7newgGaKoHTZHR7gn9weEi/E3qs7GxuXo9GiAKu54v/
        i287NLOgTznhPg38TNvm6UuCuu6vsbua7aZIYO733GHcA83qybysj3JvztbaOFpc4lloOHA0G/w
        fOEpPEnF6oWrr8OSmf/P7k7NWdR4eQd4R5NbMVHaW
X-Received: by 2002:a2e:380b:0:b0:287:87ef:f274 with SMTP id f11-20020a2e380b000000b0028787eff274mr1024774lja.507.1673868864461;
        Mon, 16 Jan 2023 03:34:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs/A3BEIyrgk+b4q28+jNwXWqJsjWo4v5qbUO0d4qKJWtn0IHAJojTWDkmuo/bhHVhwciUfZfa4XHzMGXxQoWU=
X-Received: by 2002:a2e:380b:0:b0:287:87ef:f274 with SMTP id
 f11-20020a2e380b000000b0028787eff274mr1024771lja.507.1673868864276; Mon, 16
 Jan 2023 03:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20230116100718.12832-1-jirislaby@kernel.org>
In-Reply-To: <20230116100718.12832-1-jirislaby@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 12:34:12 +0100
Message-ID: <CACO55tvnedcj5ZmEoqLw1Vz2vJQjpKjtdbvMMQVbjydZ51JvJQ@mail.gmail.com>
Subject: Re: [PATCH -resend] drm/nouveau/kms/nv50- (gcc13): fix nv50_wndw_new_ prototype
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     airlied@redhat.com, linux-kernel@vger.kernel.org,
        Martin Liska <mliska@suse.cz>, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
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

On Mon, Jan 16, 2023 at 11:07 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> w=
rote:
>
> gcc-13 warns about mismatching types for enums. That revealed switched
> arguments of nv50_wndw_new_():
>   drivers/gpu/drm/nouveau/dispnv50/wndw.c:696:1: error: conflicting types=
 for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const struct =
nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, =
int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct nv50_=
wndw **)'
>   drivers/gpu/drm/nouveau/dispnv50/wndw.h:36:5: note: previous declaratio=
n of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struct =
drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum n=
v50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)'
>
> It can be barely visible, but the declaration says about the parameters
> in the middle:
>   enum nv50_disp_interlock_type,
>   u32 interlock_data,
>   u32 heads,
>
> While the definition states differently:
>   u32 heads,
>   enum nv50_disp_interlock_type interlock_type,
>   u32 interlock_data,
>
> Unify/fix the declaration to match the definition.
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will merge it into drm-misc soon

> Cc: Martin Liska <mliska@suse.cz>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>
> Notes:
>     [v2] switch to uint instead of to enum
>
>  drivers/gpu/drm/nouveau/dispnv50/wndw.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.h
> index 591c852f326b..76a6ae5d5652 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
> @@ -35,8 +35,9 @@ struct nv50_wndw {
>
>  int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
>                    enum drm_plane_type, const char *name, int index,
> -                  const u32 *format, enum nv50_disp_interlock_type,
> -                  u32 interlock_data, u32 heads, struct nv50_wndw **);
> +                  const u32 *format, u32 heads,
> +                  enum nv50_disp_interlock_type, u32 interlock_data,
> +                  struct nv50_wndw **);
>  void nv50_wndw_flush_set(struct nv50_wndw *, u32 *interlock,
>                          struct nv50_wndw_atom *);
>  void nv50_wndw_flush_clr(struct nv50_wndw *, u32 *interlock, bool flush,
> --
> 2.39.0
>

