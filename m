Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA36DA3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjDFUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjDFUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6AAF0D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680813388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LXsKr+a/Z33uwWnUodThDv9wbW0mvJrlyH2U+mElvk=;
        b=NrVU+EEFdSvF0OHZCEVqeT4X8mW9jgycK/pawB24N/kksMm2TagIIwDokmiPQfMTOOGTz/
        Wn/bLewgrMeiOlUGxcKnJRvcY5zgdd4b9IrAil+Af3HZwBLXWFL4YXvKlRKt2vuUKZO1GK
        c8EzB6QNOa+9OW2thkGBXil0GwH999g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-tBFO1uY3OjWSmHTn9s6I0w-1; Thu, 06 Apr 2023 16:36:27 -0400
X-MC-Unique: tBFO1uY3OjWSmHTn9s6I0w-1
Received: by mail-qk1-f197.google.com with SMTP id s190-20020ae9dec7000000b00746b7fae197so6971550qkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813386; x=1683405386;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LXsKr+a/Z33uwWnUodThDv9wbW0mvJrlyH2U+mElvk=;
        b=52WBk3pE17nclwIBxbnQ/yROGB8BYwsmSwLQC6v2KQMkRpr2g73CB7GXrwuWKcoTn0
         GCPrty6q5tYWlu8V1J5SJ3NYqmTkkKm967/Y613g/LQiM/0TiS0NV9/yf7VQeQNXnXCI
         gGpwKAE0fO69m/njcRRNdBVXTzuHEWc5BOlUT4EFoeWHxRVT4rCeTwEl9eavA0BOLRuV
         jB/m+7eu7NQxQTY3Zg48W9828AFcssLA0a5jzFXNd0Iinbpa3jdu8QmaFi0hPH6KEwG7
         HXIPOa3VOjzbI3pjJYdS80D40phH29KiLsyVpuuxfLH6A0NsRjp7CJGAE1Sxiv4FnQ4B
         mP8Q==
X-Gm-Message-State: AAQBX9fwa1LBO0VNR8K25YJ8uBqmC0rARI/6CYSgRQBC02MoeERbWNnN
        ekiWx6DOL3sHrpxjVZR4khZFXlJkEnkl5snJD7HBVb8q+2LSHuBoN///MtkoDtLVJOhRcnn1cjm
        pNJSECTr7A6S0Ndf9yceGc+fj
X-Received: by 2002:a05:6214:5011:b0:5e0:2d2a:33c7 with SMTP id jo17-20020a056214501100b005e02d2a33c7mr1134138qvb.17.1680813386442;
        Thu, 06 Apr 2023 13:36:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aMIlr6kOr7QlKmLXQ+/A47WKSK2XBUpbzukLONDGPnJm/66bMRzwwZPj9Vn6QKrcOYSdjPyw==
X-Received: by 2002:a05:6214:5011:b0:5e0:2d2a:33c7 with SMTP id jo17-20020a056214501100b005e02d2a33c7mr1134098qvb.17.1680813386085;
        Thu, 06 Apr 2023 13:36:26 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id u12-20020a0ced2c000000b005dd8b934572sm784208qvq.10.2023.04.06.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:36:25 -0700 (PDT)
Message-ID: <dc98897a97ba0f7e959dbcb8465ebc522e91dc3a.camel@redhat.com>
Subject: (Attn. Skeggsb) Re: [PATCH] drm/nouveau/gr/tu102: remove unused
 tu102_gr_load function
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 16:36:24 -0400
In-Reply-To: <20230406125102.1952202-1-trix@redhat.com>
References: <20230406125102.1952202-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ben - this patch looks fine to me but I figured I should check before
giving it the OK: I assume we're not planning on using tu102_gr_load for
anything in the future? (if we are, do we want to just #if 0 this for the t=
ime
being?)

On Thu, 2023-04-06 at 08:51 -0400, Tom Rix wrote:
> smatch reports
> drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: symbol
>   'tu102_gr_load' was not declared. Should it be static?
>=20
> This function is not used so remove it.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/tu102.c
> index 3b6c8100a242..a7775aa18541 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> @@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, str=
uct gf100_gr_pack **ppack)
>  	return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
>  }
> =20
> -int
> -tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *=
fwif)
> -{
> -	int ret;
> -
> -	ret =3D gm200_gr_load(gr, ver, fwif);
> -	if (ret)
> -		return ret;
> -
> -	return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, tu102_g=
r_av_to_init_veid,
> -				 &gr->bundle_veid);
> -}
> -
>  static const struct gf100_gr_fwif
>  tu102_gr_fwif[] =3D {
>  	{  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpccs_acr=
 },

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

