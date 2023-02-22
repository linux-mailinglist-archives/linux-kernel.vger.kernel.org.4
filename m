Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9D69F6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBVOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBVOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:41:34 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8637B65;
        Wed, 22 Feb 2023 06:41:32 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id l12so7659642qtr.0;
        Wed, 22 Feb 2023 06:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyg7tFXKKjj8PrnUvFEvHIekvmZr7jdKTCzqqNpQ8t4=;
        b=p5mExyw1yIvrgSC/dLz49+AS1jcItTLT6qadDsCFEZUfGMOobv2mcwbqKUYauz4vcS
         wGDnMIEjiTmWlLEI+x86O1BIBhkxhr/kN7o6L6b572yXYag0xduTcPddHdNftfd8gv5z
         8AGeeeGaypiqI5KUNmwgTYMgSJ0apPBAK+9E/t4azQNw58HS+ueFQdloYu0st1Yr1ilh
         H0Y5htnWosot0uDYFxaIyRhNuAinKXHFm9txzXirITYhkrO5QzKE+INzzB+VcuwTUqDu
         7G0Go1MQVpABsx+5W2ncKmqD8SuMuwuJcGpWecq7t13gPkhWvjK5XbDJtl54xYopEhoJ
         Rfug==
X-Gm-Message-State: AO0yUKXFuQM1GWxT98iRMow0Q7+M9N09zcwkb9noJBYs7e5sGkElndOE
        QJWBDtJBTKMatGNQh4ZAqZz0DGY/TieOCw==
X-Google-Smtp-Source: AK7set/soV7qmOCZlWD7VTPeXURUe0DStM3tQPUpr6Y85feozQtnp+dRa4RN5p2FX6apfnQq9pjiyg==
X-Received: by 2002:a05:622a:198d:b0:3ba:1c07:e472 with SMTP id u13-20020a05622a198d00b003ba1c07e472mr2496249qtc.51.1677076891323;
        Wed, 22 Feb 2023 06:41:31 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id d17-20020ac800d1000000b003bd0719cf20sm1889863qtg.39.2023.02.22.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:41:30 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id z95so8563256ybh.0;
        Wed, 22 Feb 2023 06:41:30 -0800 (PST)
X-Received: by 2002:a25:fb0e:0:b0:890:ac61:3ed9 with SMTP id
 j14-20020a25fb0e000000b00890ac613ed9mr850231ybe.540.1677076890300; Wed, 22
 Feb 2023 06:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20230104013436.203427-1-neal_liu@aspeedtech.com> <20230104013436.203427-2-neal_liu@aspeedtech.com>
In-Reply-To: <20230104013436.203427-2-neal_liu@aspeedtech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Feb 2023 15:41:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
Message-ID: <CAMuHMdVS_JF0+5CyNM6ivxqRLKkMte9=Xw5E-fc-OTHibwc5vw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] crypto: aspeed: Add ACRY RSA driver
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neal,

On Wed, Jan 4, 2023 at 2:37 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
> ACRY Engine is designed to accelerate the throughput of
> ECDSA/RSA signature and verification.
>
> This patch aims to add ACRY RSA engine driver for hardware
> acceleration.
>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Thanks for your patch, which is now commit 2f1cf4e50c956f88 ("crypto:
aspeed - Add ACRY RSA driver").

> --- /dev/null
> +++ b/drivers/crypto/aspeed/aspeed-acry.c

> +static int aspeed_acry_probe(struct platform_device *pdev)
> +{
> +       struct aspeed_acry_dev *acry_dev;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       int rc;
> +
> +       acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
> +                               GFP_KERNEL);
> +       if (!acry_dev)
> +               return -ENOMEM;
> +
> +       acry_dev->dev = dev;
> +
> +       platform_set_drvdata(pdev, acry_dev);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       acry_dev->regs = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(acry_dev->regs))
> +               return PTR_ERR(acry_dev->regs);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       acry_dev->acry_sram = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(acry_dev->acry_sram))
> +               return PTR_ERR(acry_dev->acry_sram);
> +
> +       /* Get irq number and register it */
> +       acry_dev->irq = platform_get_irq(pdev, 0);
> +       if (acry_dev->irq < 0)
> +               return -ENXIO;
> +
> +       rc = devm_request_irq(dev, acry_dev->irq, aspeed_acry_irq, 0,
> +                             dev_name(dev), acry_dev);
> +       if (rc) {
> +               dev_err(dev, "Failed to request irq.\n");
> +               return rc;
> +       }
> +
> +       acry_dev->clk = devm_clk_get_enabled(dev, NULL);
> +       if (IS_ERR(acry_dev->clk)) {
> +               dev_err(dev, "Failed to get acry clk\n");
> +               return PTR_ERR(acry_dev->clk);
> +       }
> +
> +       acry_dev->ahbc = syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                        "aspeed,ahbc");
> +       if (IS_ERR(acry_dev->ahbc)) {
> +               dev_err(dev, "Failed to get AHBC regmap\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Initialize crypto hardware engine structure for RSA */
> +       acry_dev->crypt_engine_rsa = crypto_engine_alloc_init(dev, true);
> +       if (!acry_dev->crypt_engine_rsa) {
> +               rc = -ENOMEM;
> +               goto clk_exit;
> +       }
> +
> +       rc = crypto_engine_start(acry_dev->crypt_engine_rsa);
> +       if (rc)
> +               goto err_engine_rsa_start;
> +
> +       tasklet_init(&acry_dev->done_task, aspeed_acry_done_task,
> +                    (unsigned long)acry_dev);
> +
> +       /* Set Data Memory to AHB(CPU) Access Mode */
> +       ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB, ASPEED_ACRY_DMA_CMD);
> +
> +       /* Initialize ACRY SRAM index */
> +       aspeed_acry_sram_mapping(acry_dev);
> +
> +       acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
> +                                                &acry_dev->buf_dma_addr,
> +                                                GFP_KERNEL);
> +       memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);

When compile-testing with CONFIG_HAS_DMA=n:

    error: argument 1 null where non-null expected [-Werror=nonnull]

The call to dmam_alloc_coherent() lacks error handling, as the returned
address may be NULL.

Moreover, is it safe to allocate this buffer only after the call to
crypto_engine_start()? I.e. could acry_dev->buf_addr be accessed
before, causing a NULL pointer dereference?
Is there any other initialization that should be done earlier?

> +
> +       aspeed_acry_register(acry_dev);
> +
> +       dev_info(dev, "Aspeed ACRY Accelerator successfully registered\n");
> +
> +       return 0;
> +
> +err_engine_rsa_start:
> +       crypto_engine_exit(acry_dev->crypt_engine_rsa);
> +clk_exit:
> +       clk_disable_unprepare(acry_dev->clk);
> +
> +       return rc;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
