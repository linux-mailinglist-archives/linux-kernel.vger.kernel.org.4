Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACC74B871
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjGGVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjGGVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCD1BE8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688763831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyU5zBy/a84oEoWoieA/ffOtOuuHwgqV4ycNSTCevL0=;
        b=GgOK4ebGLWs47+pK5hpfiLez2xQr2IquBpFU7uK6sPyUbmN3ucoMa7Vtc20zqQmi+rFD1/
        q/zw5l+z4i4U6Sx8MYGz09oPsBXgZ80Eokhj/nZ2Z+4uUaEFMG9QNcwGQSo/9qcnVqe3VH
        UWNft5nZ/CHW16NmNetJjVOyOAUG1fE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-MFrQocwXOz2ERLvzDiiL7Q-1; Fri, 07 Jul 2023 17:03:50 -0400
X-MC-Unique: MFrQocwXOz2ERLvzDiiL7Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7675fc3333eso175236785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688763829; x=1691355829;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyU5zBy/a84oEoWoieA/ffOtOuuHwgqV4ycNSTCevL0=;
        b=M4YyNZG3jGtPBJKXmg3vP/irCzEL7CwQD0lCroNSYPKftrUsBVaWceFjqKDKGnXijf
         ZYqx3B+Cbyotwm4RCKa/i4iQ0a+5xWnaYaBz4+BqwJU0jts72bX2SDuH7FQe2WOOPKQ4
         KNasxrUwEI29VSt3bTLMqi0M/38IWC9YpNZbYBo9HoKXnPdcILJCWRBV+edtigdQ/0EQ
         grjoiYKXDchLxcPuDqSJjdQAga8RlU+4Y1qFhFw4aks3N7kgqEPBLApZmagHn46UwoXO
         LUh4ZSN+IuMPPb5qzJMYQJcWOZMf6Y7MiUxoMeYgJKkPtBnUaqzwNaS4ZiN4YgbNcjvv
         HC5g==
X-Gm-Message-State: ABy/qLb0JRx2uVcYYLj+4mBDM3qHNcnKjacWt4spdr+q6MKRx1knnyd4
        lEtIHnxxn9H+fn8fcAc8yE65S//0pMxuvhHFDqnIJqlasKLdtES7tuULuQQC/V90Spio9TcuFo5
        +gCgJqvtuLwbh9t6MA4rhW2GZ
X-Received: by 2002:a05:620a:28cc:b0:762:3841:c098 with SMTP id l12-20020a05620a28cc00b007623841c098mr11890017qkp.30.1688763829744;
        Fri, 07 Jul 2023 14:03:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHub679rj9p13wuI63bc+RfomIr/ACWE3AhFx9HYEJTtP2JkglWWuEwG3TTkgaIDBh6fY4VsA==
X-Received: by 2002:a05:620a:28cc:b0:762:3841:c098 with SMTP id l12-20020a05620a28cc00b007623841c098mr11889999qkp.30.1688763829506;
        Fri, 07 Jul 2023 14:03:49 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200:4d3e:bd5a:7e0a:133a? ([2600:4040:5c62:8200:4d3e:bd5a:7e0a:133a])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cdd06000000b006301ec0d16fsm2493703qvk.0.2023.07.07.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:03:49 -0700 (PDT)
Message-ID: <14f2b03302c07a62cce1ec272f54727b2ad39721.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp/g94: enable HDMI
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Date:   Fri, 07 Jul 2023 17:03:48 -0400
In-Reply-To: <20230630160645.3984596-1-kherbst@redhat.com>
References: <20230630160645.3984596-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

But seeing as I looked at this + some other patches yesterday I assume ther=
e's
still more to this?

On Fri, 2023-06-30 at 18:06 +0200, Karol Herbst wrote:
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + i=
nfoframe methods")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/disp/g94.c
> index a4853c4e5ee3..67ef889a0c5f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
> @@ -295,6 +295,7 @@ g94_sor =3D {
>  	.clock =3D nv50_sor_clock,
>  	.war_2 =3D g94_sor_war_2,
>  	.war_3 =3D g94_sor_war_3,
> +	.hdmi =3D &g84_sor_hdmi,
>  	.dp =3D &g94_sor_dp,
>  };
> =20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

