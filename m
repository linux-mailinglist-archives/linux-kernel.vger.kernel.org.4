Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404366BE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAPNCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAPNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:02:05 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F65E22033;
        Mon, 16 Jan 2023 04:58:57 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id x5so867167qti.3;
        Mon, 16 Jan 2023 04:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xw2bF+7MxIfm5k6ouCEy1zSWGDR9wStyiUaq/I6FAg=;
        b=6jVPH3qTMLiK3zdte4Y7fccKSc9SHBU0LcJaVQ4ATHrekR7S1tMOTonAZ56+hjkYM4
         PRlazpuBkt2MG+RyfjQxG/kLo2QUcCFbqcnr48C0yLZIysNyQSXFl5UKJoiL+yGrSSWl
         1VjAveH+D77mJujlmFwg63XghdMP4rqMdd9Dn7s9RagsZgQ6atRfUqBmvJCA5UHuMLty
         3BCAg/10G/4hfj6xoxhFdI6UitKiz3h1pum7BTXHFfX6h0KO4hhfyvuafl0vx+oO0zjC
         hF2KyM6NJhVTn38zr4Ion1auLKWQ26/hItxZgU0IuOpAdN2kCzJOZYUXPvKsRp91L6BH
         8wwQ==
X-Gm-Message-State: AFqh2krXfekc52/keQ6YQdiqBBRL54q+pLVfkavXKOXEN+eHyfC1PBGC
        5euPbb7bRoz1yMSa9i2Os14HhgFTzOfc8w==
X-Google-Smtp-Source: AMrXdXtKew0OUzQM1RryPXK5CioiugKddudAr9h2r0IPRduqhU4kyOzcnVriLpeh/bv6CK1aFX19pQ==
X-Received: by 2002:a05:622a:4885:b0:3b6:378c:5cd5 with SMTP id fc5-20020a05622a488500b003b6378c5cd5mr1658254qtb.62.1673873913854;
        Mon, 16 Jan 2023 04:58:33 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b0070383f1b6f1sm18348749qkp.31.2023.01.16.04.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 04:58:33 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id d62so14003135ybh.8;
        Mon, 16 Jan 2023 04:58:33 -0800 (PST)
X-Received: by 2002:a5b:541:0:b0:7d5:620e:b60f with SMTP id
 r1-20020a5b0541000000b007d5620eb60fmr849755ybp.89.1673873913099; Mon, 16 Jan
 2023 04:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20230106125816.10600-1-fabrizio.castro.jz@renesas.com> <20230106125816.10600-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230106125816.10600-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 13:58:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAFqMRRyfRsV8-ASzdLS5Fa7dS8UrSc73We+=WuOeDZQ@mail.gmail.com>
Message-ID: <CAMuHMdXAFqMRRyfRsV8-ASzdLS5Fa7dS8UrSc73We+=WuOeDZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] soc: renesas: Add PWC support for RZ/V2M
To:     fabrizio.castro.jz@renesas.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 1:58 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The Renesas RZ/V2M External Power Sequence Controller (PWC)
> IP is capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>
> Add the corresponding device driver.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v1: In the first version, I had 1 driver for GPIO handling, and 1 driver
>     for poweroff handling, both based on syscon to share the mapped
>     memory region.
> v2: One more driver added to act as MFD core driver. Dropped syscon, and
>     dropped the OF compatible string for the GPIO and poweroff drivers.
> v3: This new patch merges all the PWC code in 1 new driver.
>     It also takes into account the comments received from Bartosz and Geert.
>     Since this is a new driver, I have dropped all the Reviewed-by tags
>     received on the separated drivers.
> v4: No change.
> v5: No change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
