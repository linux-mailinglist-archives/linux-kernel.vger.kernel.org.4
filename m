Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CF72EDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbjFMVYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046C519B7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686691427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWsjugpohne5df5/X+6GB3p53oFQ5MGoNldK3p6P9vk=;
        b=X/4nz5U38yZvJ9RIBYt7Xc/zhZv6Z7WjN6tnAK1418zaOtQEL6gxe/TdGj5KRkeRhlsspA
        w88Sof+tO/+MiVGi/q8LWdXSptLONaEwz3in6Mpmq51agwOFLjiXbGId+bFsEPpBRgtcTl
        RIG8Nns2u7lWNMrmwYXSXO2gxtfbwEE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-AWb_fnPbMVKot56bpfgMmw-1; Tue, 13 Jun 2023 17:23:46 -0400
X-MC-Unique: AWb_fnPbMVKot56bpfgMmw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1b8ec9343so9501481fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691424; x=1689283424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWsjugpohne5df5/X+6GB3p53oFQ5MGoNldK3p6P9vk=;
        b=YkjpKtR1JEHvp2/wfc1dLxQcAFS8z0iEUavhLQ8tX349Blo/SzsPQcEVTqXi+9ZWSO
         fVDForAUXGdyxTWhPf6XewHlfdr+QR/0oVWZyPQwOywf74dM5zL6Y/AHOyQ4T4CRJg0O
         +VlozS0jWNZs2RA4eur/lyJia3BMSLgps44g0YRGxek3gNmcYAQnwnR8zj0a1mjwolOO
         1knynQDR6jIApCktqoilSZB1svHwDgz8tmKHmXGBrd4KYet2HrNxkn6iHRluanezwHcl
         DK9jPz9m8+vrwXZ2Rtgan9H6swBE2M00spFRf9Z5UbLmfQOFthmfwQIgm/QNWigEXbXb
         TS1w==
X-Gm-Message-State: AC+VfDxIXH84KmOEpzG5Ep2v+Fh+4iU0Cf0VGIMQqVFoqPV9DK8l1Y+9
        7GzjPZYr/ch619Qw4AI3CwPWu08TR5vxW7WvLPj0Kc2NKlgcBtqjzNAvhXPQ+nGBLbX+1INS/td
        cWL5Cgru+1smUbapG27Tsdo07QjGZ1dgEW4/1PaO53XkfOQSTD6I=
X-Received: by 2002:a05:651c:169b:b0:2b1:e625:7e1b with SMTP id bd27-20020a05651c169b00b002b1e6257e1bmr6319977ljb.0.1686691424031;
        Tue, 13 Jun 2023 14:23:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AlCNoOaXbVxU5NOLaYc+4CaTl5SFp3/u3ykWEuLnEhB2JrvIcHz5LPSUIjytKMktVlyqAzKFlzlBmlBdkItY=
X-Received: by 2002:a05:651c:169b:b0:2b1:e625:7e1b with SMTP id
 bd27-20020a05651c169b00b002b1e6257e1bmr6319969ljb.0.1686691423715; Tue, 13
 Jun 2023 14:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230613210529.552098-1-lyude@redhat.com>
In-Reply-To: <20230613210529.552098-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 13 Jun 2023 23:23:32 +0200
Message-ID: <CACO55tvju6-pF-e9-Zx+7dNB1XKavaf74RW0yGheGzbM1w9nhg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nv50-: Fix drm_dp_remove_payload() invocation
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau-devel@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:05=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> We changed the semantics for this in:
>
> e761cc20946a ("drm/display/dp_mst: Handle old/new payload states in drm_d=
p_remove_payload()")
>
> But I totally forgot to update this properly in nouveau. So, let's do tha=
t.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 5bb777ff13130..1637e08b548c2 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -909,15 +909,19 @@ nv50_msto_prepare(struct drm_atomic_state *state,
>         struct nouveau_drm *drm =3D nouveau_drm(msto->encoder.dev);
>         struct nv50_mstc *mstc =3D msto->mstc;
>         struct nv50_mstm *mstm =3D mstc->mstm;
> -       struct drm_dp_mst_atomic_payload *payload;
> +       struct drm_dp_mst_topology_state *old_mst_state;
> +       struct drm_dp_mst_atomic_payload *payload, *old_payload;
>
>         NV_ATOMIC(drm, "%s: msto prepare\n", msto->encoder.name);
>
> +       old_mst_state =3D drm_atomic_get_old_mst_topology_state(state, mg=
r);
> +
>         payload =3D drm_atomic_get_mst_payload_state(mst_state, mstc->por=
t);
> +       old_payload =3D drm_atomic_get_mst_payload_state(old_mst_state, m=
stc->port);
>
>         // TODO: Figure out if we want to do a better job of handling VCP=
I allocation failures here?
>         if (msto->disabled) {
> -               drm_dp_remove_payload(mgr, mst_state, payload, payload);
> +               drm_dp_remove_payload(mgr, mst_state, old_payload, payloa=
d);
>
>                 nvif_outp_dp_mst_vcpi(&mstm->outp->outp, msto->head->base=
.index, 0, 0, 0, 0);
>         } else {
> --
> 2.40.1
>

