Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045874F7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGKS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjGKS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:26:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB360A7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:26:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso66566865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689099979; x=1691691979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlSVz2JK2QfkUY0e2bO341IdHytAGDY8Oy/1arX04Ks=;
        b=Du4yrT1OOMvuNNcTOYTMkOYQldDuwK7MDHA5+YhI60s8yycZT83WcHqIY+gnPmrUuX
         u3WG+SMRBLq7Mu2ASaiKqhgJtNtaUGXsKTSkGgAQ4BT69a2uAi2zRh2ECNm2MGiXqE9i
         qN8UdMgXuZdLymoKCZu2wUZYsYhGOUX66kAYKYmkfcwdIDYWoVctkeB+vK5uoTQB40dO
         YstqAzy+YnFj+E3Y1sELlIuOnggqRzQbKGxESNW9IQokRA0aKFgvUeZCCH+u0tUf5RXC
         CKTT06i5EWIDhJPryjee3z0MJF3syi4u2Jxls9Z7W6/gw9eyfF22koy7JtFpt3a8jRzy
         laZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099979; x=1691691979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlSVz2JK2QfkUY0e2bO341IdHytAGDY8Oy/1arX04Ks=;
        b=j6EI5iQ0krfvTAEEoHrT+/eP1PJ1Su1g7XndCRZbzvFdvGyaxEJ/8xpFVoMdMqEVcn
         s+gMMp4c49DPqNznSfjQr0+KRwMH5rNIFcc0uYhlG1ZV3norm/tH9MYMVY2XI/s9p23y
         pfm43xR547LDGaRRKWOO8tx0qwIk/lnzfpqfcxwBVd75OaMNtiDBAiKuVc091Eik2/9i
         sH8L5aMRrexZ0IbgoIUk6Tnhx9XzK5HzoVaXtLlSZvlQ1q6TvJB8MVF756hWb1b7ilvs
         NCwP6U7yCzVz4qGsAja6pV6kLv4jV+5B7lvGFIsOcRx+qhEC4hL09HYCrRtDYVgROX66
         Oy4w==
X-Gm-Message-State: ABy/qLb9wmGoz9WrJsSMPaEZ2HqZMOjyPnk9XpI90hzZ6j6orR0q2i38
        HJmhmIt6G4zxTwNM/3eB7oA=
X-Google-Smtp-Source: APBJJlHGY9WABdLgL+mZBFQl3gX7vI50KHydxcPqI8YnC8fb8cuWDIjPwjgg79jMhCdErxfFuuiV4g==
X-Received: by 2002:a05:600c:b45:b0:3f7:b1df:26d with SMTP id k5-20020a05600c0b4500b003f7b1df026dmr17826544wmr.38.1689099979101;
        Tue, 11 Jul 2023 11:26:19 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003fc06169abdsm3214211wmj.2.2023.07.11.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:26:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
Date:   Tue, 11 Jul 2023 20:26:17 +0200
Message-ID: <3747576.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 06. julij 2023 ob 06:04:57 CEST je Yangtao Li napisal(a):
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/nvmem/sunxi_sid.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index a970f1741cc6..6bfe02ab169a 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -125,7 +125,6 @@ static int sun8i_sid_read_by_reg(void *context, unsig=
ned
> int offset, static int sunxi_sid_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct resource *res;
>  	struct nvmem_config *nvmem_cfg;
>  	struct nvmem_device *nvmem;
>  	struct sunxi_sid *sid;
> @@ -142,8 +141,7 @@ static int sunxi_sid_probe(struct platform_device *pd=
ev)
> return -EINVAL;
>  	sid->value_offset =3D cfg->value_offset;
>=20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sid->base =3D devm_ioremap_resource(dev, res);
> +	sid->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sid->base))
>  		return PTR_ERR(sid->base);




