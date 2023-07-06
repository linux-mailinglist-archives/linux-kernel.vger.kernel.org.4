Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354C6749CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGFNGG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGFNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:06:05 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141C1986;
        Thu,  6 Jul 2023 06:06:04 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5703d12ab9aso8506387b3.2;
        Thu, 06 Jul 2023 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648763; x=1691240763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/qcFDS70fG1QEtJD3Cn4gIevcgGB6/3BFVjpZF24XE=;
        b=cbjyem1IPvUdqrNPnrLwGCW6TzXC26CkOhJgBPiqcGYlOGbnBON+G8dCoJbHq3Wovw
         iBHrFEezI+gjexeOM8uY2RUL9xpAygtyCfP7fKm25522x2IPWcFkHseyFxDqILgwzMAS
         s3EuvYzFzLKQtNtT8bUfm9DcOKWdAXJldG+B2BRa80hB/KGq5QZa+bAogwHcvpRoBiTK
         VyyBssDPKSEsZtZ4QGTyrhWYQECKKlCZAy7qHXB5IKrqkCYF5RKXpL2pfrGDqBPgnZmO
         Z0mpNWilgVWmwto08O+sPUHVo/JNs2/H8M7Mp9dfPekmqB62Q5F8xR1S41BzT7/9UybP
         XJNQ==
X-Gm-Message-State: ABy/qLbmTNmAQSbn1GE/uMbxXkfkH1HFLhR8uDp77zBNdaI+U2IcKshX
        Vo9g4SeA1LOcQ4UwzOgbY1FtxTXFZylpkQ==
X-Google-Smtp-Source: APBJJlGld0cUqmhd0R7V1Rs4rchGALteKCZSv16kqXBafSepV/bjt26MKtKt+w5Dsr3BNawTKk0tgw==
X-Received: by 2002:a81:bf50:0:b0:577:2f3f:c712 with SMTP id s16-20020a81bf50000000b005772f3fc712mr2038913ywk.40.1688648763389;
        Thu, 06 Jul 2023 06:06:03 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x5-20020a818705000000b0056d31a089e9sm323261ywf.126.2023.07.06.06.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 06:06:02 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so682246276.3;
        Thu, 06 Jul 2023 06:06:02 -0700 (PDT)
X-Received: by 2002:a25:ad4b:0:b0:c68:c71e:cdb1 with SMTP id
 l11-20020a25ad4b000000b00c68c71ecdb1mr1170563ybe.26.1688648762741; Thu, 06
 Jul 2023 06:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230706124239.23366-1-frank.li@vivo.com> <20230706124239.23366-5-frank.li@vivo.com>
In-Reply-To: <20230706124239.23366-5-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 15:05:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz=gyH_c1bq435Wtu53yG6MJgNodRa7_0T2q6BLppmSw@mail.gmail.com>
Message-ID: <CAMuHMdWz=gyH_c1bq435Wtu53yG6MJgNodRa7_0T2q6BLppmSw@mail.gmail.com>
Subject: Re: [PATCH 5/8] ata: sata_rcar: Convert to devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Thu, Jul 6, 2023 at 2:44 PM Yangtao Li <frank.li@vivo.com> wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for your patch!

> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -861,15 +861,11 @@ static int sata_rcar_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct ata_host *host;
>         struct sata_rcar_priv *priv;
> -       struct resource *mem;
> -       int irq;
> -       int ret = 0;
> +       int irq, ret;
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> -       if (!irq)
> -               return -EINVAL;

Why this change?
It is not documented in the patch description.

>
>         priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
>         if (!priv)
> @@ -890,8 +886,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
>
>         host->private_data = priv;
>
> -       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->base = devm_ioremap_resource(dev, mem);
> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->base)) {
>                 ret = PTR_ERR(priv->base);
>                 goto err_pm_put;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
