Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4161F63A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiKGOh4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 09:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:37:54 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9E92;
        Mon,  7 Nov 2022 06:37:53 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id x15so6933142qtv.9;
        Mon, 07 Nov 2022 06:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TjBAkGxwjp2lubMtDrrYVobZ7PDqd90S/P8hJIEVqU=;
        b=6cNIwcgDlKI56wBvfQ/JrkeTGKY+HkiZ1u6mdnChmrpFGtleWju/viasbgkDduOk8I
         syxK4ULb4VkmWCTu1msNyTMcFYGXLooOTx79TTEvm0Bab1Atl/hGVO1Qbf9+byww4J2e
         mXTPhpq1TxXswLty2RPpPY2VxEjHQYYwNIDEyKudRjvOEHrD6elkOcRntGLNkRhE4ZX+
         C+pGlJGftBviuEdM6nmWwOGOG+7YnGJk8GwiquSR4b+u4CTtXyEAcLhdypRteJn7jXKb
         cYay0GgotwS/d32PRy5UEMtUE8Py9A2ef/kfDg1ShHuKdXGeqIau7OMJqnuEfqzPVChh
         MfuQ==
X-Gm-Message-State: ACrzQf284dIgSEfj01cg9njMIvBeRk/VW8VvF/BhjgMq1zZ6dQOo5cyG
        mXKVyTkxeCMUkYqRB3gbiCumiFO6QQxS3+im
X-Google-Smtp-Source: AMsMyM4B4O0qColug4URI6v367aZVtrSGogAQamMxZKcpQu4oNIHFEKKxhCQhctowogXl6c3J6Tcig==
X-Received: by 2002:ac8:5c87:0:b0:3a5:704e:4ac7 with SMTP id r7-20020ac85c87000000b003a5704e4ac7mr11247756qta.612.1667831872409;
        Mon, 07 Nov 2022 06:37:52 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a424500b006f84ee3a4f3sm6882963qko.48.2022.11.07.06.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:37:52 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 129so13785727ybb.12;
        Mon, 07 Nov 2022 06:37:51 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr30783296ybs.380.1667831871538; Mon, 07
 Nov 2022 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-6-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-6-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 15:37:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVod1VqKSBFa5syeSPU=RzgqQ=3tg70V1OSZFOext7kgw@mail.gmail.com>
Message-ID: <CAMuHMdVod1VqKSBFa5syeSPU=RzgqQ=3tg70V1OSZFOext7kgw@mail.gmail.com>
Subject: Re: [PATCH 5/7] usb: gadget: udc: add Renesas RZ/N1 USBF controller support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 7, 2022 at 3:00 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add support for the Renesas USBF controller.
> This controller is an USB2.0 UDC controller available in the
> Renesas r9a06g032 SoC (RZ/N1 family).
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

> --- /dev/null
> +++ b/drivers/usb/gadget/udc/renesas_usbf.c

> +struct usbf_udc {
> +       struct usb_gadget               gadget;
> +       struct usb_gadget_driver        *driver;
> +       struct device                   *dev;
> +       struct clk_bulk_data            *clocks;
> +       int                             nclocks;
> +       void __iomem                    *regs;
> +       spinlock_t                      lock;
> +       bool                            is_remote_wakeup;
> +       bool                            is_usb_suspended;
> +       struct usbf_ep                  ep[USBF_NUM_ENDPOINTS];
> +       /* for EP0 control messages */
> +       enum usbf_ep0state              ep0state;
> +       struct usbf_req                 setup_reply;
> +       u8                              ep0_buf[USBF_EP0_MAX_PCKT_SIZE];
> +};

> +static int usbf_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct usbf_udc *udc;
> +       struct usbf_ep *ep;
> +       bool h2mode;
> +       int irq;
> +       int ret;
> +       int i;
> +
> +       ret = r9a06g032_sysctrl_get_usb_h2mode(&h2mode);
> +       if (ret)
> +               return ret;
> +       if (h2mode) {
> +               dev_warn(dev, "Disabled in H2 (host) mode\n");
> +               return -ENODEV;
> +       }
> +
> +       udc = devm_kzalloc(dev, sizeof(*udc), GFP_KERNEL);
> +       if (!udc)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, udc);
> +
> +       udc->dev = dev;
> +       spin_lock_init(&udc->lock);
> +
> +       udc->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(udc->regs))
> +               return PTR_ERR(udc->regs);
> +
> +       devm_pm_runtime_enable(&pdev->dev);
> +       ret = pm_runtime_resume_and_get(&pdev->dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = devm_clk_bulk_get_all(dev, &udc->clocks);
> +       if (ret < 1) {
> +               dev_err(dev, "failed to get clocks %d\n", ret);
> +               return ret;
> +       }
> +       udc->nclocks = ret;
> +
> +       ret = clk_bulk_prepare_enable(udc->nclocks, udc->clocks);
> +       if (ret) {
> +               dev_err(dev, "can not enable the clock\n");
> +               return ret;
> +       }

As this driver only enables/disables the clocks, perhaps you could
just delegate this to Runtime PM (through the clock domain pointed
by the power-domains property in DT), and drop the .clocks and
.nclocks fields?

> +clk_disable:
> +       clk_bulk_disable_unprepare(udc->nclocks, udc->clocks);
> +       return ret;
> +}
> +
> +static int usbf_remove(struct platform_device *pdev)
> +{
> +       struct usbf_udc *udc = platform_get_drvdata(pdev);
> +
> +       usb_del_gadget_udc(&udc->gadget);
> +
> +       clk_bulk_disable_unprepare(udc->nclocks, udc->clocks);
> +
> +       pm_runtime_put(&pdev->dev);
> +
> +       return 0;
> +}

> +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");

Hervé? ;-)

> +MODULE_DESCRIPTION("Renesas R-Car Gen3 & RZ/N1 USB Function driver");
> +MODULE_LICENSE("GPL");

> --
> 2.37.3
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
