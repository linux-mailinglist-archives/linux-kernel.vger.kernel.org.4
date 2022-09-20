Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6615BE497
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiITLgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiITLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAC6EF0C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663673804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsCfV3jb8Y6CJkx3bnF/8eo0TaIrp2G1MgoQNK12Cok=;
        b=M3rUlbFM61qUUSSF8jvKnStvxlPo8GPXaBEyzKarlg/+gVoXcUEOkMtKeliRQ0jmKzzxbP
        QL88kH5+90rSbvB3uUIZbdlecKIugnx7QGv3ZnIhCwRzbsq1C2cLcAuZqtV5G14IQcCqYQ
        qONOKVeQSlHUic78bCf58Gl0pQnSXYo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-qGoznZu0O-ClvLKlpaaaNA-1; Tue, 20 Sep 2022 07:36:43 -0400
X-MC-Unique: qGoznZu0O-ClvLKlpaaaNA-1
Received: by mail-qk1-f200.google.com with SMTP id bi3-20020a05620a318300b006cf2d389cdaso1679217qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PsCfV3jb8Y6CJkx3bnF/8eo0TaIrp2G1MgoQNK12Cok=;
        b=25nLTI38ayeKD0aw6CIYdUTnuQrR89pJT40PfBON3ud6fZSelQXdBTX1DMKEoSnE+J
         rE7s9nR/UJ/BEE3eDQsgckSa2GcBa16wuHDdGJW1aMZmInVnShcLQVZOAR2OvtzFAEK8
         MAP4fjT+hdqSoURMcVDbjVvle6piqae9jjxrpWBa2bXuSnwqRX5+7oGfQ2ryr4+GUwY/
         rGoAzIfsa2r5elxikf/0+DbvLWXLlSV2rsaycd9bBp4md9feR65k98prlywzlJqoNSsH
         za7F4dVc1kObbZTnIHtnwK6oGnDvl5HnBSijBq70epS6BzJSgtTSOzgM8BXusFBu0NsN
         tF8g==
X-Gm-Message-State: ACrzQf2EraLDOahMnKnYdmyxkiOWkdxumDir+TGTxazR+kk2g+k8N8IY
        hVcw+SXcgBiv4m2MUNtTTPXpIY1G8JKP97EFZuzgwnmdxM9GvJ02mZ7gEjmni40jaZuyxJ44S6Z
        +FKfAEWnayQh2kkieSnPOn8PsvjmU1iM4/Cfi+8r3
X-Received: by 2002:a05:622a:1793:b0:35b:af87:4f22 with SMTP id s19-20020a05622a179300b0035baf874f22mr18699729qtk.673.1663673803213;
        Tue, 20 Sep 2022 04:36:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wIQ0jFhCaudvcBegNkhf6TY0qdf9hDp0ELXrNPeuoLTirgC5lOzDVWzTY40c9modUSL/vnMBgHTmfH7PrYgM=
X-Received: by 2002:a05:622a:1793:b0:35b:af87:4f22 with SMTP id
 s19-20020a05622a179300b0035baf874f22mr18699716qtk.673.1663673802999; Tue, 20
 Sep 2022 04:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220819200928.401416-1-kherbst@redhat.com> <YymY+3+C2aI7T3GU@eldamar.lan>
In-Reply-To: <YymY+3+C2aI7T3GU@eldamar.lan>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 20 Sep 2022 13:36:32 +0200
Message-ID: <CACO55ts7rpbyYv3ovWt1iCfkGsChCUVitmHqtzAwFpfbPEZGYQ@mail.gmail.com>
Subject: Re: [PATCH] nouveau: explicitly wait on the fence in nouveau_bo_move_m2mf
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, stable@vger.kernel.org,
        Computer Enthusiastic <computer.enthusiastic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:42 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>
> Hi,
>
> On Fri, Aug 19, 2022 at 10:09:28PM +0200, Karol Herbst wrote:
> > It is a bit unlcear to us why that's helping, but it does and unbreaks
> > suspend/resume on a lot of GPUs without any known drawbacks.
> >
> > Cc: stable@vger.kernel.org # v5.15+
> > Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/156
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_bo.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > index 35bb0bb3fe61..126b3c6e12f9 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> > @@ -822,6 +822,15 @@ nouveau_bo_move_m2mf(struct ttm_buffer_object *bo, int evict,
> >               if (ret == 0) {
> >                       ret = nouveau_fence_new(chan, false, &fence);
> >                       if (ret == 0) {
> > +                             /* TODO: figure out a better solution here
> > +                              *
> > +                              * wait on the fence here explicitly as going through
> > +                              * ttm_bo_move_accel_cleanup somehow doesn't seem to do it.
> > +                              *
> > +                              * Without this the operation can timeout and we'll fallback to a
> > +                              * software copy, which might take several minutes to finish.
> > +                              */
> > +                             nouveau_fence_wait(fence, false, false);
> >                               ret = ttm_bo_move_accel_cleanup(bo,
> >                                                               &fence->base,
> >                                                               evict, false,
> > --
> > 2.37.1
> >
> >
>
> While this is marked for 5.15+ only, a user in Debian was seeing the
> suspend issue as well on 5.10.y and did confirm the commit fixes the
> issue as well in the 5.10.y series:
>
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=989705#69
>
> Karol, Lyude, should that as well be picked for 5.10.y?
>

mhh from the original report 5.10 was fine, but maybe something got
backported and it broke it? I'll try to do some testing on my machine
and see what I can figure out, but it could also be a debian only
issue at this point.

> Regards,
> Salvatore
>

