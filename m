Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B326B60AD4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiJXOUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiJXOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:15:35 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A34635DC;
        Mon, 24 Oct 2022 05:55:23 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id g28so8864796pfk.8;
        Mon, 24 Oct 2022 05:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIs/7jsTplOiTmK71IOmd1MtbeRmmHQaVO9SeNsFPEI=;
        b=H+f609bljltxHtEvGCrpGTUzOHEcOSDjxVS+GbzW8JDjnO63Rtoa1dazIb2L1Ekksw
         Hqsjr91OoWiyJ4sUplZSLOtrR8mQ/lVEpztiSxYNpmH9/8yveIPrM9c5SVK49hmEp+LY
         vS1VKeWnATXsa9rNgROwLP1q4EM7x8bFD8NUr0/WJ3NBruO9hVEZUGH/J0CL2HzYuxRX
         nZ1B2IJ5iCW0LZxwI1wm/RZVceucuYZyQE4OkBNJuNEbGDnKUOFD+wugpUr6KfXTIVQ2
         UkbLjk2vf9eYKVscXsD54+Ump0VY3U0ft4/zbLpA68YMn6dbQ9HLM2NhDuzLR1CvDIzK
         /qPg==
X-Gm-Message-State: ACrzQf0d/QcwUC/tEJC6At/G2xrXK43nrGEtoj6VSz9R9HJ7f/rMHbQU
        hMkKj460D3Rny5bqmYB1/vy4LfJ0keg44Q==
X-Google-Smtp-Source: AMsMyM5LUaTQ1hsO2YLfn08QQOEUI62y2A0C07T7lYkMYwIWtqpHRN2Y43Aq9a82c0quM4jC7rTX/w==
X-Received: by 2002:a05:6214:c68:b0:4b2:31c5:78bc with SMTP id t8-20020a0562140c6800b004b231c578bcmr27218596qvj.45.1666612034806;
        Mon, 24 Oct 2022 04:47:14 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b006ce3f1af120sm15029241qkb.44.2022.10.24.04.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:47:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j7so10695987ybb.8;
        Mon, 24 Oct 2022 04:47:13 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr27481885ybx.543.1666612033596;
 Mon, 24 Oct 2022 04:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221023182437.15263-1-afd@ti.com> <20221023182437.15263-2-afd@ti.com>
In-Reply-To: <20221023182437.15263-2-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 13:47:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSorMA8uBSfOQCBXpY+319Pb_fcaHX5B8o1=xxaaGofA@mail.gmail.com>
Message-ID: <CAMuHMdWSorMA8uBSfOQCBXpY+319Pb_fcaHX5B8o1=xxaaGofA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: Allow DTB overlays to built from .dtso named
 source files
To:     Andrew Davis <afd@ti.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 8:24 PM Andrew Davis <afd@ti.com> wrote:
> Currently DTB Overlays (.dtbo) are build from source files with the same
> extension (.dts) as the base DTs (.dtb). This may become confusing and
> even lead to wrong results. For example, a composite DTB (created from a
> base DTB and a set of overlays) might have the same name as one of the
> overlays that create it.
>
> Different files should be generated from differently named sources.
>  .dtb  <-> .dts
>  .dtbo <-> .dtso
>
> We do not remove the ability to compile DTBO files from .dts files here,
> only add a new rule allowing the .dtso file name. The current .dts named
> overlays can be renamed with time. After all have been renamed we can
> remove the other rule.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
