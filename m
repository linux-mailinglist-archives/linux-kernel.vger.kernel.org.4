Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2662FF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKRVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKRVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:52:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00168A9972;
        Fri, 18 Nov 2022 13:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9889DB8255C;
        Fri, 18 Nov 2022 21:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6344BC433C1;
        Fri, 18 Nov 2022 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668808340;
        bh=0cxrDpCwAMLk20jFMUHD/+u3L6thMq/hKuFlsCzqPWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f3fGrrFzwpkh+5okDDUnpw4F6fUgoDBavKgkQdikAfgCdvvbjc4DqYjVsNXNXfeJG
         wEfxFdszGHyCeJ0mJBpjBz5DkP9GIWfBtiv1pwOaMctD/mGl5/kR6CppBKbOQkoKiN
         zDTovMqZWT67X6sLU2lrW96HaslsX9PFxXeHEhmklPS8nIH5Vzg1+pMyBISPfYy1Bf
         pg2Qb1osaxU+BMw5k4j3SUuHPmgHC5xQffVkgHM8ZhQ3g8AYcxzrde1zpof8JMtME2
         NW5XmNFpTl3aKB9uh8qzXBJIkzNxq+8D1Y7PnTsjZnG4vj2T2SDvkUwyo9rjyzGwf8
         l8vtbIBGiNvGA==
Received: by mail-lj1-f170.google.com with SMTP id x21so8368179ljg.10;
        Fri, 18 Nov 2022 13:52:20 -0800 (PST)
X-Gm-Message-State: ANoB5pndDg0AQ+iE1X/gcHXiLfTmG+oI2NXxsh17+auqbtIWyb6sRcOx
        63+cJ0eCOFCOPpUzLvRXzqb3zF51+zw0NouvXg==
X-Google-Smtp-Source: AA0mqf4XaC3HUFYd0cpd8pfENTYkpLT+rDEu5EqRwsFJTg0pPxnLvsBb4Mty+XHF8EMEDzaHvnlaXxXsyxQJDrZYtTI=
X-Received: by 2002:a05:651c:12ca:b0:277:a9d:9355 with SMTP id
 10-20020a05651c12ca00b002770a9d9355mr2838505lje.102.1668808338344; Fri, 18
 Nov 2022 13:52:18 -0800 (PST)
MIME-Version: 1.0
References: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc> <20221118214036.1269005-1-michael@walle.cc>
In-Reply-To: <20221118214036.1269005-1-michael@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Nov 2022 15:52:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com>
Message-ID: <CAL_JsqKnuycUSHfxxcZMcidELA-ttZUv5NhV5ApkpUQMsc-aQQ@mail.gmail.com>
Subject: Re: [PATCH] of: property: special #nvmem-cell-cells handling
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:40 PM Michael Walle <michael@walle.cc> wrote:
>
> Since recently, there is a new #nvmem-cell-cells. To be backwards
> compatible this is optional. Therefore, we need special handling and
> cannot use DEFINE_SIMPLE_PROP() anymore.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> This patch will be part of the following series:
> https://lore.kernel.org/linux-arm-kernel/20221118185118.1190044-1-michael@walle.cc/
>
>  drivers/of/property.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 967f79b59016..93c0ea662336 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1305,7 +1305,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
>  DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
>  DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
> -DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
>  DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
>  DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
>  DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
> @@ -1381,6 +1380,22 @@ static struct device_node *parse_interrupts(struct device_node *np,
>         return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>  }
>
> +static struct device_node *parse_nvmem_cells(struct device_node *np,
> +                                            const char *prop_name, int index)
> +{
> +       struct of_phandle_args sup_args;
> +
> +       if (strcmp(prop_name, "nvmem-cells"))
> +               return NULL;
> +
> +       if (of_parse_phandle_with_optional_args(np, prop_name,
> +                                               "#nvmem-cell-cells", index,
> +                                               &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}

There's a couple of other cases like that (MSI IIRC), so can we
generalize this to work in more than 1 case?

Rob
