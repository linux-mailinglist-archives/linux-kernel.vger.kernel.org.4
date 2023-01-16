Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD666C86F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjAPQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjAPQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503812B63C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673886411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2boqvfD+RJ61HpS/wHyE329kUvwll2CIPBJV6eZl4c=;
        b=IDjmgHopGyiIonvakEi5RH1XTKJynlefCM8gCCgv3IkRDnrFsn8eHM3cdtLzevA610m6AY
        BoBdPpdTfnU6t+Kqz/fkCTVmcw/Ij/HM9LH0ubwdZEGXra5om8fly76wPFnJmZU3LbLIjC
        sLJhK09JlB3X6D/6uBQb92BgmQRr17o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-P-SDitaZM-OwPeXhG3cslQ-1; Mon, 16 Jan 2023 11:26:50 -0500
X-MC-Unique: P-SDitaZM-OwPeXhG3cslQ-1
Received: by mail-lj1-f198.google.com with SMTP id b25-20020a2e9899000000b002877a271a9dso5248707ljj.20
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2boqvfD+RJ61HpS/wHyE329kUvwll2CIPBJV6eZl4c=;
        b=ra5DhixLrTSDsEm9eKOdYwaNax8Kmqu9hX/THFVhoDV1vtExhNfkoFlBEMv4/N6G2T
         pppZo6pKdLcWI7vbbztXLAc8corKlVpuvfVmu6Q4wlfRgzWxopSDzDAADJtO5o/BMx3L
         A/weDb7w8MBsLVG3ruxZFnGkqe78Vd1Z5qv3NKpiSUCUbopY/Fw3B/nJEsBrNtnIjPRP
         3Y4v3t6DiGjlyp3arzdhi9t8PdagsexH/+e0q6M7mp5h+KQ7wSjzjqwy6TldOn3v+vPv
         Va82vADhFkx/f1budDK2DYI4AoYOTCu9IwLezlsVWK/RDHsM2hirRb03oIu9h8ikXnC+
         KPJg==
X-Gm-Message-State: AFqh2kpYeOqgZi6QPsb2zJ8ZE39ozw675qQniePzMCR59gVheUrkKP4t
        z50sZsZfBX67NDDzaVDWinNnyR2KC7ZT1mhg9LCF3glym68/KBrz0z3kqw7UKNzdHZeC913bMLI
        nDfrXLTEKyAKc4w1IswTMNc0q9sE9vK5coM5bYMAk
X-Received: by 2002:a05:6512:7c:b0:4d5:7b89:7b67 with SMTP id i28-20020a056512007c00b004d57b897b67mr110385lfo.17.1673886408806;
        Mon, 16 Jan 2023 08:26:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsl3G5delLpsUSEikj3rrvMcC9LUAx6uCt/IgZvb4ulTe/2Bhgjm8AC830LNMSyFXE01XKOE/f4hSEa4jTVlHk=
X-Received: by 2002:a05:6512:7c:b0:4d5:7b89:7b67 with SMTP id
 i28-20020a056512007c00b004d57b897b67mr110384lfo.17.1673886408656; Mon, 16 Jan
 2023 08:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20230103234835.never.378-kees@kernel.org> <Y7TNtQqunHIW8her@work> <CACO55tsyCtf-_mCPVEo-4Dj_mAu-tnNTTjP75wx=9n+TS1XVvw@mail.gmail.com>
In-Reply-To: <CACO55tsyCtf-_mCPVEo-4Dj_mAu-tnNTTjP75wx=9n+TS1XVvw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 16 Jan 2023 17:26:37 +0100
Message-ID: <CACO55tvuhLzbtg-wzy24Y7Y4k4CN_3JZM5VZ-9VPFNZK3skKCg@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 5:24 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Wed, Jan 4, 2023 at 1:52 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > On Tue, Jan 03, 2023 at 03:48:36PM -0800, Kees Cook wrote:
> > > Zero-length arrays are deprecated[1] and are being replaced with
> > > flexible array members in support of the ongoing efforts to tighten the
> > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > >
> > > Replace zero-length array with flexible-array member.
> > >
> > > This results in no differences in binary output.
> > >
> > > [1] https://github.com/KSPP/linux/issues/78
> > >
> > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > Cc: Karol Herbst <kherbst@redhat.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: nouveau@lists.freedesktop.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Here is my RB again:
> >
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >
>
> Reviewed-by: Karol Herbst <kherbst@redhat.com>
>
> will push in a moment
>

just noticed it's the same change than the other one... anyway, will
push the oldest one

> > Thanks!
> > --
> > Gustavo
> >
> > > ---
> > > Sent before as: https://lore.kernel.org/all/20221118211207.never.039-kees@kernel.org/
> > > ---
> > >  drivers/gpu/drm/nouveau/include/nvfw/hs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/include/nvfw/hs.h b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > > index 8c4cd08a7b5f..8b58b668fc0c 100644
> > > --- a/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > > +++ b/drivers/gpu/drm/nouveau/include/nvfw/hs.h
> > > @@ -52,7 +52,7 @@ struct nvfw_hs_load_header_v2 {
> > >       struct {
> > >               u32 offset;
> > >               u32 size;
> > > -     } app[0];
> > > +     } app[];
> > >  };
> > >
> > >  const struct nvfw_hs_load_header_v2 *nvfw_hs_load_header_v2(struct nvkm_subdev *, const void *);
> > > --
> > > 2.34.1
> > >
> >

