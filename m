Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781686716AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjARIzH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 03:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjARIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:52:37 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0475DC12;
        Wed, 18 Jan 2023 00:06:17 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id d13so23302285qvj.8;
        Wed, 18 Jan 2023 00:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E5o9U7zZsXisx3q8SidZtLQ1FchE/lbQb7lV8SwSYQ=;
        b=ZBE6EgDz2xx3kUUzYeyjwb1NjVPLGdkSsi5uBmtO71RveyeUMOJhqkASX568So1djX
         Kjk0QPqq3mRF+GdCC7jzUypLalH+ogy155tWu/HqsnchZoEaKuhEybI/etN8caqEQdua
         yEPUAYKCk+CcRZcoli3ajoUEkGOQuKqft07Azkg0XVx+Ust8yRaV6TTXUCOegEf8bFk6
         tx3Gtm3wgzIXLJRhhPd9j9iPVOVqeVYkFiZvJvTcEqkEvW7sh5d28S429EwgBXo4qKZe
         /yAHefMyrsL+BcKJqXV6Oho5S9fjAWEkviVfd8DT21SI5VZeMbEYcINhM7DMuTO0HZYR
         qfaQ==
X-Gm-Message-State: AFqh2kpU/GkWQzghGEpAnnW//Dy/ATw6StHbeNizicl6NQ1B1HF+WtT2
        cHQ4rmFC7wWNXOZ5bRTuJ+bw1h6lmoWQsA==
X-Google-Smtp-Source: AMrXdXuyW8gF8KjGH2qvrOAy4XRRXxiqKRnwCjpkVHLRWjxvbdHjxpXSFmvwp4D0px+PfHvDqJ0DNg==
X-Received: by 2002:a0c:ed4c:0:b0:534:e0b9:9059 with SMTP id v12-20020a0ced4c000000b00534e0b99059mr8095948qvq.33.1674029176786;
        Wed, 18 Jan 2023 00:06:16 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006ec62032d3dsm10280712qkj.30.2023.01.18.00.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 00:06:15 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 203so37162694yby.10;
        Wed, 18 Jan 2023 00:06:15 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr602817ybo.380.1674029174829; Wed, 18 Jan
 2023 00:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20230105152257.310642-1-herve.codina@bootlin.com>
In-Reply-To: <20230105152257.310642-1-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Jan 2023 09:06:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbzqvxoMxJ9MCRe4YqayB4YfP14jJ44-QJkSnQr230Ug@mail.gmail.com>
Message-ID: <CAMuHMdWbzqvxoMxJ9MCRe4YqayB4YfP14jJ44-QJkSnQr230Ug@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add the Renesas USBF controller support
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Thu, Jan 5, 2023 at 4:23 PM Herve Codina <herve.codina@bootlin.com> wrote:
> This series add support for the Renesas USBF controller (USB Device
> Controller) available in the Renesas RZ/N1 SoC.

As Greg seems to be happy with the USB patches (he took the whole
(sigh) series through usb-next), I will queue

> Herve Codina (5):
>   dt-bindings: usb: add the Renesas RZ/N1 USBF controller
>   soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF
>     presence

... this "clk" patch in renesas-clk-for-v6.3...

>   usb: gadget: udc: add Renesas RZ/N1 USBF controller support
>   ARM: dts: r9a06g032: Add the USBF controller node

... and this DT patch in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
