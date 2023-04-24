Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C46ED12E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDXPVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDXPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091826196
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682349631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ybXQpJGX8ksVbqeQTg5aMwu/7o/goFFitwiYzrK7BM=;
        b=iLWSstTU8RFdFouf+/9bbF0wRY5a22XyOHsBZdBww1Ueumuu/zMB4dnk03Aqzid/ba0OuY
        DEMrGKXlRU0KHPsTfjPcNvLsghxKTlz3XFRIG2lBVk7DQIAeJAOdIDdw/Txe/1832IkE6k
        eChzSTmhKna7fjboE8L9lkDu3uYsJZI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-QlyhFwpLMN2ZPcoffdRBiw-1; Mon, 24 Apr 2023 11:20:29 -0400
X-MC-Unique: QlyhFwpLMN2ZPcoffdRBiw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2a8aaa36757so2685391fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349628; x=1684941628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ybXQpJGX8ksVbqeQTg5aMwu/7o/goFFitwiYzrK7BM=;
        b=MqaHCoaGIgkh1HY1JpH1zacv67ZEbs9wbwkiat0+ANH6QblrtBBguKckR5T0socVTK
         CRXdjOjgP+sgotfMaQN6bH6TY+DYUQo4Rs63+feZQ7dxfdNRU16McluNUoQt9QOdvMRw
         STNSw+2qVsheVbkfs+fnXBuWla9ijrcNnZMPbwNWJDWouHIbFifIbFrVFADvtEnfrjlr
         UYrhAOmeoFauhILT/nbeDtNSi33SWoKpgwshcNjQxPEMmZNzl+OE91iUX7BhQYP1tK0/
         eSxjH4DQMegUnCgVyEvL/Ln9GY3Kq+N+FLkFslpCDyN9WIR31rU/gOFX7qRpMCZrCYFu
         ciuQ==
X-Gm-Message-State: AAQBX9e6+T4lHUHZwD+EoN7cSO5P1ewlxbBXuaFwbc9bildsC8p1u4Ht
        +IFJDQPoS5nnuJjmsT4gTchSqNkucaufw6mkNqwvTYUZ0Dy1L9IAdAgebsVqBa2gocVTgnH8XcT
        eeapiQ6KrdpaTsZVh73tAb7utKpQ4Se6Z1N9sZ5Cd
X-Received: by 2002:a2e:924b:0:b0:2a9:f6f0:fc84 with SMTP id v11-20020a2e924b000000b002a9f6f0fc84mr3486699ljg.4.1682349628202;
        Mon, 24 Apr 2023 08:20:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350brn3/2mvZw23jR8Revx5XmXXtkygZGuUo8HD5LLVeLxmu8zC85TkjrgP/HdRDXdUOJ1/BuBAsvCCX/3rAcWwU=
X-Received: by 2002:a2e:924b:0:b0:2a9:f6f0:fc84 with SMTP id
 v11-20020a2e924b000000b002a9f6f0fc84mr3486688ljg.4.1682349627904; Mon, 24 Apr
 2023 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230204184307.never.825-kees@kernel.org> <0a48d61b-6e11-9144-b11e-dd46de836c53@embeddedor.com>
In-Reply-To: <0a48d61b-6e11-9144-b11e-dd46de836c53@embeddedor.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 24 Apr 2023 17:20:16 +0200
Message-ID: <CACO55tv43F7TQGYCmifyzOxR-Ddt28wpj9t9RyK4sQPR6aU+bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Wed, Mar 22, 2023 at 10:40=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 2/4/23 12:43, Kees Cook wrote:
> > More arrays (and arguments) for dcpd were set to 16, when it looks like
> > DP_RECEIVER_CAP_SIZE (15) should be used. Fix the remaining cases, seen
> > with GCC 13:
> >
> > ../drivers/gpu/drm/nouveau/nvif/outp.c: In function 'nvif_outp_acquire_=
dp':
> > ../include/linux/fortify-string.h:57:33: warning: array subscript 'unsi=
gned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned=
 char[15]'} [-Warray-bounds=3D]
> >     57 | #define __underlying_memcpy     __builtin_memcpy
> >        |                                 ^
> > ...
> > ../drivers/gpu/drm/nouveau/nvif/outp.c:140:9: note: in expansion of mac=
ro 'memcpy'
> >    140 |         memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
> >        |         ^~~~~~
> > ../drivers/gpu/drm/nouveau/nvif/outp.c:130:49: note: object 'dpcd' of s=
ize [0, 15]
> >    130 | nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIV=
ER_CAP_SIZE],
> >        |                                              ~~~^~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >
> > Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquir=
e")
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

sorry for not seeing this earlier.

> Thanks!
> --
> Gustavo
>
> > ---
> >   drivers/gpu/drm/nouveau/include/nvif/if0012.h    | 4 +++-
> >   drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h  | 3 ++-
> >   drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 2 +-
> >   3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gp=
u/drm/nouveau/include/nvif/if0012.h
> > index eb99d84eb844..16d4ad5023a3 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
> > @@ -2,6 +2,8 @@
> >   #ifndef __NVIF_IF0012_H__
> >   #define __NVIF_IF0012_H__
> >
> > +#include <drm/display/drm_dp.h>
> > +
> >   union nvif_outp_args {
> >       struct nvif_outp_v0 {
> >               __u8 version;
> > @@ -63,7 +65,7 @@ union nvif_outp_acquire_args {
> >                               __u8 hda;
> >                               __u8 mst;
> >                               __u8 pad04[4];
> > -                             __u8 dpcd[16];
> > +                             __u8 dpcd[DP_RECEIVER_CAP_SIZE];
> >                       } dp;
> >               };
> >       } v0;
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/=
gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > index b7631c1ab242..4e7f873f66e2 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > @@ -3,6 +3,7 @@
> >   #define __NVKM_DISP_OUTP_H__
> >   #include "priv.h"
> >
> > +#include <drm/display/drm_dp.h>
> >   #include <subdev/bios.h>
> >   #include <subdev/bios/dcb.h>
> >   #include <subdev/bios/dp.h>
> > @@ -42,7 +43,7 @@ struct nvkm_outp {
> >                       bool aux_pwr_pu;
> >                       u8 lttpr[6];
> >                       u8 lttprs;
> > -                     u8 dpcd[16];
> > +                     u8 dpcd[DP_RECEIVER_CAP_SIZE];
> >
> >                       struct {
> >                               int dpcd; /* -1, or index into SUPPORTED_=
LINK_RATES table */
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers=
/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > index 4f0ca709c85a..fc283a4a1522 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > @@ -146,7 +146,7 @@ nvkm_uoutp_mthd_release(struct nvkm_outp *outp, voi=
d *argv, u32 argc)
> >   }
> >
> >   static int
> > -nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[16],
> > +nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[DP_RECEIVER=
_CAP_SIZE],
> >                          u8 link_nr, u8 link_bw, bool hda, bool mst)
> >   {
> >       int ret;
>

