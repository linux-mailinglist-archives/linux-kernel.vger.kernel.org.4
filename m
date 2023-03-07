Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2946AD320
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGAFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCGAFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111C301A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678147457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hm7OyfDHZHod7VjHk1wTL2jptyUJSz+TF+BnRS3YH4M=;
        b=LcBDvX0cWkXSaUhFvhZ8KJRaTHWAeSqrCu5z0iFWLRDxOhudjZGJc5ctASMLnmPqv9971x
        FUISFaaBzTHMfIj2FjdifX+bcTPvXI5A23rFAprN17l1XavvFW5SvA/V2E0tHOkSXIN3XP
        Cwuu5YABPqOVffcKHiwtlFVetUiq+4w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-WEY-CNvUNCirDKH47lNaLA-1; Mon, 06 Mar 2023 19:04:16 -0500
X-MC-Unique: WEY-CNvUNCirDKH47lNaLA-1
Received: by mail-qt1-f199.google.com with SMTP id c11-20020ac85a8b000000b003bfdd43ac76so6167615qtc.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678147455;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm7OyfDHZHod7VjHk1wTL2jptyUJSz+TF+BnRS3YH4M=;
        b=WeNmX2Ic+kaXyxa+z/fqE/XUW30fwUPguPoEjN8nE0+08pPbUGnm8D+2/FOzWbBhiR
         160QZeyxxjStN28yoh1w3HJZyAcwmp7WHaa48bBom3I9tMrc15PCozhrQTTxbaCngtfW
         5OhxEKQPLOo9QlIu2CM9lI18Gi5EfnETCq0EZ2vAedtuE8boa2z/yNhidGyG0H3RvBpY
         TOu1SW2S1FJnHD1VzZxuJYjaUDLyoKD9J2J0mBdammviEa8zhH9O+6PS0Dqwf0stCDdn
         1uXwl49rLZ/GBEkSPUpwGd48zYB3/2gXbiIMnZHZpBMBmB9SIDlitvjV77S30hY4tnLK
         vDWQ==
X-Gm-Message-State: AO0yUKXiWR3Mp2mwSiwgEfVlZj05mLOxGKYuvNml1GJiQ392rApvqYY+
        URSrpH62H9sSGJuVyysOfKp/pd9F9UP9Dlh0tHWYEcMsbkV+4aBvgWNv08u8rlGVm6j7Ve7+MZd
        Ep9P8bAdj5CRQOdOolwREojRF
X-Received: by 2002:ac8:5c83:0:b0:3a8:e35:258f with SMTP id r3-20020ac85c83000000b003a80e35258fmr22529593qta.31.1678147455581;
        Mon, 06 Mar 2023 16:04:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9JP7mAg5m3cVZualEUszyw1XG+IBEsB4vFC4l/lnJoUCNQJOWCfSLVzf+bdS0kt1V9nLDD8w==
X-Received: by 2002:ac8:5c83:0:b0:3a8:e35:258f with SMTP id r3-20020ac85c83000000b003a80e35258fmr22529561qta.31.1678147455349;
        Mon, 06 Mar 2023 16:04:15 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id d64-20020a37b443000000b0073b587194d0sm8383852qkf.104.2023.03.06.16.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:04:14 -0800 (PST)
Message-ID: <c1dbdc4a41e67496eb8533e5a271eb2bbdc318d6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix use-after-free bug in
 nvkm_vmm_pfn_map
From:   Lyude Paul <lyude@redhat.com>
To:     Zheng Wang <zyytlz.wz@163.com>, nouveau@lists.freedesktop.org
Cc:     bskeggs@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        hackerzheng666@gmail.com, alex000young@gmail.com,
        security@kernel.org, daniel@ffwll.ch, Julia.Lawall@inria.fr,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Mar 2023 19:04:13 -0500
In-Reply-To: <20221029074654.203153-1-zyytlz.wz@163.com>
References: <20221029074654.203153-1-zyytlz.wz@163.com>
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Sat, 2022-10-29 at 15:46 +0800, Zheng Wang wrote:
> If it failed in kzalloc, vma will be freed in nvkm_vmm_node_merge.
> The later use of vma will casue use after free.
>=20
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Reported-by: Zhuorao Yang <alex000young@gmail.com>
>=20
> Fix it by returning to upper caller as soon as error occurs.
>=20
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/mmu/vmm.c
> index ae793f400ba1..04befd28f80b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> @@ -1272,8 +1272,7 @@ nvkm_vmm_pfn_map(struct nvkm_vmm *vmm, u8 shift, u6=
4 addr, u64 size, u64 *pfn)
>  						       page -
>  						       vmm->func->page, map);
>  			if (WARN_ON(!tmp)) {
> -				ret =3D -ENOMEM;
> -				goto next;
> +				return -ENOMEM;
>  			}
> =20
>  			if ((tmp->mapped =3D map))

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

