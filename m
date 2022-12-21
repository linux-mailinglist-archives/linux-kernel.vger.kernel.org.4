Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E323B6532D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLUPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLUPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:02:07 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9F722295;
        Wed, 21 Dec 2022 07:02:07 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id r130so13543335oih.2;
        Wed, 21 Dec 2022 07:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUouVsuH4nDvHqNLQ+k2JwBPwVSp7b+SrA5Adtq8QyU=;
        b=BE1lw3gqL3acaBnun5oJAV3wxvNvCcQ1Dbmr6Sen++AT6qYOVyr3O7LvGCWoaXKdFd
         cgKnFhO8ysKdhjJziutFhwcGts+joxRV/jT471jrxCpm2EBN+jMQ+9s/Q3G/H1pPftp3
         hXj5FgZj0/cYtXTSprhcCgwMXkev3Krp5yZPB5eRlte6CmyfN4yNM5xVg7E7bHfTz9tN
         nJn8AdsSu1q4jynHCuBbSbQ9OuGxzfPY5EYGkvG4AV0edhVPn/qZvHEykRdjM4C2QHG1
         SdDcSV1lol2JQHomU+ja6LDYUnwh9uZvmT/ccCO1Ewby4nAoGbyNHnM4eqJjY3yJ9PLz
         ZpQQ==
X-Gm-Message-State: AFqh2kpoOHiNzJoB4moI8SmEPukbJ3ybC+kSUEIbn1ve04EWKHGusFkY
        WWdpQ+Eo83ZQ5Nk7OEa3tstt1OH2IITHsw==
X-Google-Smtp-Source: AMrXdXvNq0OApu+uBKwR+qJ2s7bsdWrjS5FAU3cILaQIa+Yr5KEkVTYR8aiIPBYUaq8AGn2UjDHuIw==
X-Received: by 2002:a05:6808:1911:b0:360:e643:7e27 with SMTP id bf17-20020a056808191100b00360e6437e27mr1265875oib.36.1671634923973;
        Wed, 21 Dec 2022 07:02:03 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006b929a56a2bsm10964365qkb.3.2022.12.21.07.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:02:02 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-46198b81e5eso16931017b3.4;
        Wed, 21 Dec 2022 07:02:02 -0800 (PST)
X-Received: by 2002:a81:c84:0:b0:3b4:8af5:48e with SMTP id 126-20020a810c84000000b003b48af5048emr154231ywm.383.1671634922295;
 Wed, 21 Dec 2022 07:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com> <20221213230129.549968-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221213230129.549968-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Dec 2022 16:01:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpViKrCmnO-X0BTemJWqhmNZ-D5anzitJh6atbnFB6dQ@mail.gmail.com>
Message-ID: <CAMuHMdWpViKrCmnO-X0BTemJWqhmNZ-D5anzitJh6atbnFB6dQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: renesas: r9a09g011: Add SDHI/eMMC clock and
 reset entries
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Wed, Dec 14, 2022 at 12:01 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> Add SDHI/eMMC clock/reset entries to CPG driver.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>
> This patch can clash with the below patch (which hasn't been reviewed
> yet):
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221212172804.1277751-2-biju.das.jz@bp.renesas.com/

I'll just ignore the overlap...

I couldn't review the clock parents, as that information seems to
be restricted, but the rest LGTM.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
