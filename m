Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AD7014AF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjEMGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 02:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEMGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 02:38:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C252D48;
        Fri, 12 May 2023 23:38:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965cc5170bdso1630071866b.2;
        Fri, 12 May 2023 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683959880; x=1686551880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJAHS0Zaj0yVKhfNHhf5jx/XvjbWQe6dR3+gBFASJBU=;
        b=YFD59SfNwI80NXatbYx+VnyB6F8bgTWYF5cM6l+/+0MBybE4ati0s2sJJIOR2Dql7+
         p1amTvshUKIr2n/XCcTaSELHndPCCWo+owGMRBQcF/Dqmp+vlOOYoDOxZRpsvEpdJTTt
         uUWxOlqz2ZYWlYXn3eE74ooL2nOXT5Ihsd3l/9W6ncaGvgy3lVfZ82Ck9LaTltNt5dzg
         lJRmt1J1fdlgtxYrkXdL/DEI7/7ui+2QBZi4T4g0e30hckViwFx3A7ksKyFnKHVWrPK9
         jVMcj+eSseJrZuT5YwPN3F/Fco1dfu1OckFwiEsVHkkT4aZx7GvkIUR0MCgOw0J9PThd
         O3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683959880; x=1686551880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJAHS0Zaj0yVKhfNHhf5jx/XvjbWQe6dR3+gBFASJBU=;
        b=IBhZdPh07+EvYI3Zdr1zz0x9ur6rWbMt2GcafERLsqhcCxrjsEI6nBeQ3eUwRIBr40
         xupvIZ+RQogVbpIVcXcQyrLGfLf6ehqE3a9/9+UQx+MQKE+nUAoxlcrysUARCWVUPdfb
         8As4/w9Y3pF/Q+SniaccT8qaEsRkF1hGjGtfMqzGcBSjvTInbNByHKHMlz+akTzZxN+g
         N/WtLmWnO8f373vi/0Ghl+vpanrsOi72QGOOQfOOmXO3ZMZdNvozYV7W82NOL9FIlnmd
         t5/xqlw1KsDrbcPtuumfy0O7HRUH7+Vo6ekv8uONx1jxmUVQ+3aiGZANSMlgV8DcuUgi
         TtBQ==
X-Gm-Message-State: AC+VfDz4N2aywPAJ9Hm8qW7N5qV1ZhODS5M4SIwGZkh25NwXzsZI5rwe
        0ktc4Zrixdx8As4QzzMwv4w=
X-Google-Smtp-Source: ACHHUZ6ItNQrDwZ3aO2IHbDnGlrK+eX28iXA7zT5j5NaZuSZ7J3VBuL20juqQ/09jGy+jwM+MI5cag==
X-Received: by 2002:a17:906:5d0f:b0:96a:ec5c:687b with SMTP id g15-20020a1709065d0f00b0096aec5c687bmr248946ejt.64.1683959880013;
        Fri, 12 May 2023 23:38:00 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906195000b0094e96e46cc0sm6371733eje.69.2023.05.12.23.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 23:37:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA SUBSYSTEM" <linux-ide@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Make ata_platform_remove_one return void
Date:   Sat, 13 May 2023 08:37:58 +0200
Message-ID: <4827684.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230512204646.137746-1-u.kleine-koenig@pengutronix.de>
References: <20230512204646.137746-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 12. maj 2023 ob 22:46:46 CEST je Uwe Kleine-K=F6nig napisal(a):
> The function returned zero unconditionally, so the function returning an
> int is something between useless and irritating. With the goal to make
> platform drivers' remove function return void, it's helpful to convert
> the function accordingly. This converts several drivers to the new
> .remove_new callback that was introduced to smoothen the platform driver
> conversion.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/ata/ahci_brcm.c        | 6 +++---
>  drivers/ata/ahci_ceva.c        | 2 +-
>  drivers/ata/ahci_da850.c       | 2 +-
>  drivers/ata/ahci_dm816.c       | 2 +-
>  drivers/ata/ahci_dwc.c         | 2 +-
>  drivers/ata/ahci_imx.c         | 2 +-
>  drivers/ata/ahci_mtk.c         | 2 +-
>  drivers/ata/ahci_mvebu.c       | 2 +-
>  drivers/ata/ahci_platform.c    | 2 +-
>  drivers/ata/ahci_qoriq.c       | 2 +-
>  drivers/ata/ahci_seattle.c     | 2 +-
>  drivers/ata/ahci_st.c          | 2 +-
>  drivers/ata/ahci_sunxi.c       | 2 +-

=46or sunxi:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/ata/ahci_tegra.c       | 2 +-
>  drivers/ata/ahci_xgene.c       | 2 +-
>  drivers/ata/libata-core.c      | 4 +---
>  drivers/ata/pata_ixp4xx_cf.c   | 2 +-
>  drivers/ata/pata_of_platform.c | 2 +-
>  drivers/ata/pata_platform.c    | 2 +-
>  drivers/ata/sata_highbank.c    | 2 +-
>  include/linux/libata.h         | 2 +-



