Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7243D6AF98F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCGWti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCGWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC65EC4B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678229210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+lMV0jdd+rVbHQRucIl145VMEMkgnli2TmhEhYF6aE=;
        b=TdMHeLXkisv4dd0NrMsLT/nMZqOr5/MXBu6epDuDLpWVoBwPn62uj5ZKV6q4G/dkT10e7Q
        mcD/ts5wpNd9AjvhKs9n/Zjgg9WNP42JCM7yrhiLTTzjAXju9acJ8cYIQueRW2IKhWWcGr
        QmgUsE9sQQC5MyQ//Jwa1sVLpNrmA0A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-u0yUpsyRPHytXsVtAwoUzg-1; Tue, 07 Mar 2023 17:46:47 -0500
X-MC-Unique: u0yUpsyRPHytXsVtAwoUzg-1
Received: by mail-qk1-f199.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so8263945qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229207;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+lMV0jdd+rVbHQRucIl145VMEMkgnli2TmhEhYF6aE=;
        b=HqlqZ5Ks/7x0Y4gi2ZbwxokotQ9kwxpF/4opCF9usJctF3SX/KG4pCsqvZCwyRrEVW
         ZODsnZP/8LEKS3a1YnOE3HFFe3McQoMOUTpo40AJqUEYJbKjuyoIbnzge3lCiNnU+TWa
         EzB69AWQI88MT1hkjN5uquV2IRrA1QZsNADRR22jRCUjHs45SopRPbRHm3+ox9N+XoVO
         hDS3x9BGMXNjbXvjI0TBT1hsTdJplQRgQI4xtM/ycQQaS+mbmBtpSlLsvbActNzOaDaG
         WrSg1oNE6Nbx+da6OCi+b9mD1nVJe3PrU4R+nNSa6amFbdLF1Xi5G61Y+i9HKK/isNwI
         T5Zg==
X-Gm-Message-State: AO0yUKVNeVSrnrS6BVnsXqU1PsiIfOC+Fy265Rtq+R+NvdoPciYEdNrl
        6HrlMPqnLQ7byC2a2kp2n2nO0mUB6tZmAJbn6kyCEv/pNXYd/5dgft0iuXny/iRGEJ9ci7lRa+G
        tXzkKh2iL1efFnMlNWFAtBLem
X-Received: by 2002:a05:622a:24c:b0:3bf:d07e:ee17 with SMTP id c12-20020a05622a024c00b003bfd07eee17mr27703404qtx.39.1678229207433;
        Tue, 07 Mar 2023 14:46:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8P1yL5WfXGleyVYacQ3ibXaMhN21P0MtcWzIXGgZJYC6emze48ZF0Sor8oqXZOxb/jcDhmSA==
X-Received: by 2002:a05:622a:24c:b0:3bf:d07e:ee17 with SMTP id c12-20020a05622a024c00b003bfd07eee17mr27703371qtx.39.1678229207119;
        Tue, 07 Mar 2023 14:46:47 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id w19-20020ac843d3000000b003bfbf3afe51sm10369764qtn.93.2023.03.07.14.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:46:46 -0800 (PST)
Message-ID: <160cbdb25510df6f2e3194c6dd4a2c47a4ee70b7.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau: avoid usage of list iterator after loop
From:   Lyude Paul <lyude@redhat.com>
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Tue, 07 Mar 2023 17:46:45 -0500
In-Reply-To: <2732d141a82c0f9410d001fe656d30c5e32311de.camel@redhat.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
         <2732d141a82c0f9410d001fe656d30c5e32311de.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually hm, dim is warning me about this and making me realize there's
probably a better way to handle this, going to revoke the previous r-b I ga=
ve
and respond inline

On Tue, 2023-03-07 at 17:43 -0500, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>=20
> Will push upstream in just a moment
>=20
> On Wed, 2023-03-01 at 18:25 +0100, Jakob Koschel wrote:
> > This patch set includes two instances where the list iterator variable
> > 'pstate' is implicitly assumed to be valid after the iterator loop.
> > While in pratice that is most likely the case (if
> > 'pstatei'/'args->v0.state' is <=3D the elements in clk->states), we sho=
uld
> > explicitly only allow 'pstate' to always point to correct 'nvkm_pstate'
> > structs.
> >=20
> > That allows catching potential bugs with BUG_ON(!pstate) that otherwise
> > would be completely undetectable.
> >=20
> > It also helps the greater mission to hopefully move the list iterator
> > variable into the iterating macro directly [1].
> >=20
> > Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5Sq=
XPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> > Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> > ---
> > Jakob Koschel (2):
> >       drm/nouveau/device: avoid usage of list iterator after loop
> >       drm/nouveau/clk: avoid usage of list iterator after loop
> >=20
> >  drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 9 ++++++---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 9 ++++++---
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> > ---
> > base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> > change-id: 20230301-drm-nouveau-avoid-iter-after-loop-4bff97166efa
> >=20
> > Best regards,
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

