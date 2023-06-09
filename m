Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB972991E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbjFIMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFIMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBE180
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686312529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhTsvnKWHMyANiF+ypBvF6dWV6TA3YEIeRPL9ez0lTg=;
        b=RjRJbiYwx6weEXtvPb3EETzTV8JV19kj9GV3kXkx/WuBFBd1RYnjBtrHe/Ui0i22YtnpY7
        jbc02eXRdoSKQ3r2kOv5IPA5TvVYtzS8UmelxBVym3dRu14trnE32Lr1ehg3PMjWYl6+Ig
        eBwIiO+Jb8uY6S0fZ4eMqWb9RlHzT1o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-JrxcQYVZOZqFujDbtk0eaA-1; Fri, 09 Jun 2023 08:08:48 -0400
X-MC-Unique: JrxcQYVZOZqFujDbtk0eaA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b216f624c0so1896281fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312526; x=1688904526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhTsvnKWHMyANiF+ypBvF6dWV6TA3YEIeRPL9ez0lTg=;
        b=LUk8eWDwSnWrfvFj6RXHfJxgH7vOXZPidQM8r7fNnys3wNjOM9MLKvyL3wdTtE9BS4
         7RHJLLV9u3bDtJvukfPnfApnEG1qdC0VIMrK6mzpTZbYvRxU/DFKkGoAmhhHnh9YUXsA
         CfWvX+64TSnt1dB/wUH/tgyDaiin6y5jp6SvmP6Ym5yNXcF/0HZ6s1fIZLhCBsp1sgKW
         1gINjy61uTldCcVLGrctjQGxyLbLLoXhK/K8a45J6zpbSDD1TRBulr0GmXQFjhh5IE+l
         LkXsXjthcAdEIIQ9ng5FUwZhHDtqi79zjlS6A+BVq1nW25RIsVTaeZsFA9NNa/xtvufa
         RO9A==
X-Gm-Message-State: AC+VfDz2qmN5Mj/pzKbd+Ze68hfASTrHVyfbtb9HpTOGZPHkiKOQ/9+b
        a+ziU1gPuu0tJnLkowgGP5VTQUXkKxEA4u6QFnAyCStV2pJOtxjl9eylc043757fH42bjjm710F
        tTkda651gccDJuYSfVFYiJ1w4acXLQQ/cZRqCVN2e
X-Received: by 2002:a2e:a60a:0:b0:2b2:84:fae6 with SMTP id v10-20020a2ea60a000000b002b20084fae6mr840252ljp.5.1686312526806;
        Fri, 09 Jun 2023 05:08:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/u83dgJO9ijfmv0l+OO9YcGJ/L6qBK50cyPbNLbgarvaR6qFwIZEoR0L+ekfQ6ZkypevTiTMqJhUVw0mWglg=
X-Received: by 2002:a2e:a60a:0:b0:2b2:84:fae6 with SMTP id v10-20020a2ea60a000000b002b20084fae6mr840247ljp.5.1686312526573;
 Fri, 09 Jun 2023 05:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-7-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-7-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Jun 2023 14:08:35 +0200
Message-ID: <CACO55ttQa-M3amPtFTG2JCC=wnJ7y6=JvZ9ak93tW-WtfXYUxg@mail.gmail.com>
Subject: Re: [RESEND 06/15] drm/nouveau/nvkm/subdev/acr/lsfw: Remove unused
 variable 'loc'
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:18=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c: In function =E2=80=98nvk=
m_acr_lsfw_load_sig_image_desc_v2=E2=80=99:
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:21: warning: variable=
 =E2=80=98loc=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/acr/lsfw.c
> index f36a359d4531c..bd104a030243a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> @@ -218,7 +218,7 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subd=
ev *subdev,
>                 const struct firmware *hsbl;
>                 const struct nvfw_ls_hsbl_bin_hdr *hdr;
>                 const struct nvfw_ls_hsbl_hdr *hshdr;
> -               u32 loc, sig, cnt, *meta;
> +               u32 sig, cnt, *meta;
>
>                 ret =3D nvkm_firmware_load_name(subdev, path, "hs_bl_sig"=
, ver, &hsbl);
>                 if (ret)
> @@ -227,7 +227,6 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subd=
ev *subdev,
>                 hdr =3D nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
>                 hshdr =3D nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->head=
er_offset);
>                 meta =3D (u32 *)(hsbl->data + hshdr->meta_data_offset);
> -               loc =3D *(u32 *)(hsbl->data + hshdr->patch_loc);

Ben: should we do anything with this value or is it safe to ignore?

>                 sig =3D *(u32 *)(hsbl->data + hshdr->patch_sig);
>                 cnt =3D *(u32 *)(hsbl->data + hshdr->num_sig);
>
> --
> 2.41.0.162.gfafddb0af9-goog
>

