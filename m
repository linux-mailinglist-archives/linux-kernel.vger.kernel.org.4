Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A96AD899
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCGH73 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 02:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCGH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:59:24 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D03B64B;
        Mon,  6 Mar 2023 23:59:18 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id l13so13517048qtv.3;
        Mon, 06 Mar 2023 23:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678175957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXHZjwfjtfEafDBqZYZAbPiu3rBa6YtCoijdnzn31fc=;
        b=co3YxAx2peetv1980jqFdLhlnaq97GmTE87wZLxM9oyFA6DQvv4ScAt1gqzVQP+NRf
         r/N9pS6+oQKY3sn+4bn7qMqM0iWpS5mEyzvWMrmM4PaTVy+DUTadlHjkW+7kIyuDJL1s
         LyitDSXjzGbzjrJzLst4v8A682VdFMUao7mosExeyC0MzwwDGzXXu6emCEcRMYrlQk2R
         gJObv6uR5ssmCo0jAr4qRsHHKud9ofMYAj7ifhCRYV4PjCfgqtEXveIzEqXwNXKeIFRF
         JuYSRkMPlVEBe0zGYheoZe07DRQbH8r3ZB0EGHJpbxwqjVQUQDXXPVABUfQTk5h6dAyJ
         MCFw==
X-Gm-Message-State: AO0yUKWStWkrDZrAhpbAGtTvm6rLgqxpAE+HQVD6IK1YkX6Yy7ey8ydk
        Ggr+XaNliUZbkw3BoZXT/ZprJ74cYB3ljg==
X-Google-Smtp-Source: AK7set9vcMi9r6ZCL77C3hdaKICcHi7R1Hh/mTc25ZeevprTHbDrTX8fEQRs8oD7cXLUb2oPH3YCuw==
X-Received: by 2002:a05:622a:1002:b0:3b9:bc8c:c200 with SMTP id d2-20020a05622a100200b003b9bc8cc200mr31633719qte.11.1678175957664;
        Mon, 06 Mar 2023 23:59:17 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id b198-20020ae9ebcf000000b007429d1f6176sm9080274qkg.94.2023.03.06.23.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 23:59:14 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id x12so10550821ybt.7;
        Mon, 06 Mar 2023 23:59:13 -0800 (PST)
X-Received: by 2002:a5b:308:0:b0:90d:af77:9ca6 with SMTP id
 j8-20020a5b0308000000b0090daf779ca6mr8146138ybp.7.1678175953631; Mon, 06 Mar
 2023 23:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20230306224752.8417-1-afd@ti.com>
In-Reply-To: <20230306224752.8417-1-afd@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Mar 2023 08:59:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8hkMhEfKm3Xv-0JWo02bxm2kSULjzJC+caMEw-z3dbg@mail.gmail.com>
Message-ID: <CAMuHMdW8hkMhEfKm3Xv-0JWo02bxm2kSULjzJC+caMEw-z3dbg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disallow DTB overlays to built from .dts named
 source files
To:     Andrew Davis <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, Mar 6, 2023 at 11:48 PM Andrew Davis <afd@ti.com> wrote:
> As a follow up to the series allowing DTB overlays to built from .dtso
> files. Now that all overlays have been renamed, remove the ability to
> build from overlays from .dts files to prevent any files with the old
> name from accidental being added.
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
