Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EE72ED38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjFMUlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFMUlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A31BD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686688822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KEV8rgNWQcziNkOQw3aa12KM/0QxpSM9LvG+rNFReA=;
        b=BjU+3NC7xFjF0bx54zJ8ofaZf3lv1b38ou4nQkhRofYV/G9SpxtD+GWqDi1yvimDxzI4Sy
        /hp4FYgz0L8EfqRM7zldlgg4xUtI4FxxUd7WxzQzYPj9spet+vKODkj1F6Q86iSMrJNYne
        jMdcVHQh/8yQ5a5f1Av5yXCjG0GijDM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-6o7CW7PMOSWWjcEawHjdZg-1; Tue, 13 Jun 2023 16:40:21 -0400
X-MC-Unique: 6o7CW7PMOSWWjcEawHjdZg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d44483fdeso175995585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688819; x=1689280819;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KEV8rgNWQcziNkOQw3aa12KM/0QxpSM9LvG+rNFReA=;
        b=eTa337D3NBiQlRjkkeqpqC7ojt91Rj3btFS6XDlpZ89bhgZwRElJso0d0A1RHrp9MV
         zmiTkr5LjwYST71ut3smMMDmwE4GmFy7QE/xgsTIaVgsKUsWUoaVcpTZg50N1Lc5dD8O
         Kld0DMKLrFYILPf+WOZ2SREtmr9x+t6P9zrNHqTVZEXu0msUcPDb7nDY0h9s5PCHAex2
         4mal9ZFXp4FC/c4B4gt9/Yi9y8eC84Vy7YmE51v6eHn3cfmCfAXoW2/yfAX9SVxbjWSp
         XdtWoerAwNlZoj3DoE7PKFH5nSb8sVK4afOqy2hE7ALoM8/y5T/h3JX3dCrlwtrH5M2B
         sflQ==
X-Gm-Message-State: AC+VfDyxYw9CEv/t3BEL0HR2GkEdbUsQE0jokWdFSj9Cjy6mx6dUp4pd
        PKq86lqNKgX2Xez0xSPwHe70jzE903NgQbLQXpJdBJx8Y2fuy00F5GZgCODXAsac+krD1GMI/Jh
        WKmLXQ+D7Rta7lhof28FOJypZ
X-Received: by 2002:a05:620a:8e13:b0:75b:23a1:8e67 with SMTP id re19-20020a05620a8e1300b0075b23a18e67mr10918319qkn.56.1686688819333;
        Tue, 13 Jun 2023 13:40:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ531Nu7ofpSl0Xf9KKfuKJTyiRduM7Azc8WhTHGMU/grfOlSdbBgp+kcjzgvYLlWsWJIlQgoQ==
X-Received: by 2002:a05:620a:8e13:b0:75b:23a1:8e67 with SMTP id re19-20020a05620a8e1300b0075b23a18e67mr10918309qkn.56.1686688819045;
        Tue, 13 Jun 2023 13:40:19 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id g17-20020ae9e111000000b0075d49ce31c3sm3823609qkm.91.2023.06.13.13.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:40:18 -0700 (PDT)
Message-ID: <c2bf9c25b5ba7d00cc476ed1389ad5e2dd9b2491.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dp: check for NULL nv_connector->native_mode
From:   Lyude Paul <lyude@redhat.com>
To:     Natalia Petrova <n.petrova@fintech.ru>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Tue, 13 Jun 2023 16:40:17 -0400
In-Reply-To: <20230512111526.82408-1-n.petrova@fintech.ru>
References: <20230512111526.82408-1-n.petrova@fintech.ru>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a bit

On Fri, 2023-05-12 at 14:15 +0300, Natalia Petrova wrote:
> Add checking for NULL before calling nouveau_connector_detect_depth() in
> nouveau_connector_get_modes() function because nv_connector->native_mode
> could be dereferenced there since connector pointer passed to
> nouveau_connector_detect_depth() and the same value of
> nv_connector->native_mode is used there.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: d4c2c99bdc83 ("drm/nouveau/dp: remove broken display depth functio=
n, use the improved one")
>=20
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index 086b66b60d91..5dbf025e6873 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -966,7 +966,7 @@ nouveau_connector_get_modes(struct drm_connector *con=
nector)
>  	/* Determine display colour depth for everything except LVDS now,
>  	 * DP requires this before mode_valid() is called.
>  	 */
> -	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
> +	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS && nv_connec=
tor->native_mode)
>  		nouveau_connector_detect_depth(connector);
> =20
>  	/* Find the native mode if this is a digital panel, if we didn't
> @@ -987,7 +987,7 @@ nouveau_connector_get_modes(struct drm_connector *con=
nector)
>  	 * "native" mode as some VBIOS tables require us to use the
>  	 * pixel clock as part of the lookup...
>  	 */
> -	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS && nv_conn=
ector->native_mode)
>  		nouveau_connector_detect_depth(connector);
> =20
>  	if (nv_encoder->dcb->type =3D=3D DCB_OUTPUT_TV)

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

