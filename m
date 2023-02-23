Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3351D6A034F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjBWHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:33:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBB923DB8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:33:43 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso11543163pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1EkZ9fcLGT2rHRy1aoUbWnVVwOkheHTfFY3poRtBPI=;
        b=QOzxSHuS6Dhz66oe1al5nhrBaEuowKDdCLD2Lsfr5OLk/KltW0uB1XzkUmHTpX9nYy
         JOfH/cT8uWe6n9pUunbuTZHY8mrmQ7jgOB3hPePkpDmpbXNWFyng9/XGueZTt9QAxX40
         azpjLygqYdsyP03oyyfuux30lD0awnk/wGLkp8PwYQmTsOqHTs6eeGvco5Onwmlkucnj
         BpFEAXJH5w/eq3mj6do7xeeeq9hUjOacEcETH7pDWfsyyKDtXUc3gnZn6yq5c2/sN07Z
         uSVntz2c64cJVxkuDLutwEuabdRidnOYDaRzLEDgCNZrN/Ti0Q3lUEhRyeqR/uh0NwAZ
         Sw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1EkZ9fcLGT2rHRy1aoUbWnVVwOkheHTfFY3poRtBPI=;
        b=GjkyYET0BMqbd77xnAG/eSAGtPvSJrii0NDLjllRXJgxYC4d70b0Paz2q11RH1yIvT
         Y4PVS7ypIf8lNGaArvDEl5hkRhyl7aK3f03FP9O90cxl8Ecb4N7gfH5mZm6TuUxjcGE5
         Xk1RNreTNg4oZ21VHzcqCEj7Zb76rqMIpSJ86iNgOiOtKcxE212n7sji+UaRtFnUuxVb
         aefvCwMsN2LrPkMGLq50Gh/VB2U4mZoTmBDAU1/wx94JvhBJM92PllQ/DaLHIA1NhOux
         h6UmyJFvZ8pvamlu5AiIMZ45DwatmUYjTGYjm0lLQa/4EzGuElkQ46Ek25NsujKp5JJc
         NbPw==
X-Gm-Message-State: AO0yUKVdhHoZppDj4Cv7LeDuD6hwt0dbEq0kwfeegN3scU571Q3IWRT9
        9o6tz0V4yiACMG9KhxV5uMeiS3E5frEZDMta5A5pRkBXUUjJ/3wP
X-Google-Smtp-Source: AK7set/0dy0HVB73IUe4iHT+X+8L44GFKcU+6PdtRi7u+rF2IiOZ0lyMsR8BzW1j445/5vILPyiVZThT62yN7BPqNyk=
X-Received: by 2002:a17:903:3281:b0:199:db3:9bcc with SMTP id
 jh1-20020a170903328100b001990db39bccmr1532223plb.11.1677137622522; Wed, 22
 Feb 2023 23:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20230221013414.86856-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230221013414.86856-1-yang.lee@linux.alibaba.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 23 Feb 2023 09:33:31 +0200
Message-ID: <CAOtvUMeMe=vwhC39FpGQJ2g=FKT5wKnT1pnT2XCS+c=4cBzyQg@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch.

On Tue, Feb 21, 2023 at 3:34 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/crypto/ccree/cc_driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_d=
river.c
> index d489c6f80892..c57f929805d5 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -350,9 +350,9 @@ static int init_cc_resources(struct platform_device *=
plat_dev)
>
>         /* Get device resources */
>         /* First CC registers space */
> -       req_mem_cc_regs =3D platform_get_resource(plat_dev, IORESOURCE_ME=
M, 0);
>         /* Map registers space */
> -       new_drvdata->cc_base =3D devm_ioremap_resource(dev, req_mem_cc_re=
gs);
> +       new_drvdata->cc_base =3D devm_platform_get_and_ioremap_resource(p=
lat_dev,
> +                                                                     0, =
&req_mem_cc_regs);
>         if (IS_ERR(new_drvdata->cc_base))
>                 return PTR_ERR(new_drvdata->cc_base);
>
>

The patch itself is good but can you please avoid the line break after
plat_dev, it adds nothing to readability.

With this minor nitpick for the next revision -

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Gilad




--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
