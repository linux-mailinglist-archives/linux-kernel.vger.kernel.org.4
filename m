Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64256F559E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjECKJq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 May 2023 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjECKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:09:45 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353E1A5;
        Wed,  3 May 2023 03:09:43 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-55a79671a4dso39920847b3.2;
        Wed, 03 May 2023 03:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108582; x=1685700582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sawd4wpoRtHE8s6UvEovoP3gm1uY3ejIUgCGBfkkyLU=;
        b=ZYtGy04apyTkfG5MjQFhd9tmehcu813IpBOeqxVap0RZ46CfL+cbFHDKSOlo7XL69Z
         wXBhwpg80jWmCTlUwIPW5fjRKp15WD6ybZYVvj8IrkOAplFKvxJSfIJmta98AebAcGeC
         II52QXGVsV2WYfZTJDlhfGT8JFMG5T2d8+Q6BO76CAX+A7ZkcXtTEo+Q6+LdcGeSG4qw
         32DBWJ+lvQwOnMPl+UkIGgY2WgtsAeC+a9dxcOvfT7XWJ8aB+Csinmmj0Ylkl0PkEvJP
         xVsXunslfSLyZTqfPCbaW4DjnpfcZDrPnqyx0xmOzElJ/NBrYITOpBw02vMiF+ToUZ8N
         oZvw==
X-Gm-Message-State: AC+VfDw4VwPb8gcZOpqdHwPO+jkndYQPotaykWCpKoMcmjQRtw/u4cxn
        Ho6R5H2JiuX4Rk3Ay+upEXDdZiynyUO4FA==
X-Google-Smtp-Source: ACHHUZ54oosSzxi/8tOiAnFCUh2kjyZhlP4God13vC+klLQhjpuO8Nx6cCe31zYrr6p0+7bBuiPtjw==
X-Received: by 2002:a81:8886:0:b0:55a:592d:9ec0 with SMTP id y128-20020a818886000000b0055a592d9ec0mr10060051ywf.20.1683108582047;
        Wed, 03 May 2023 03:09:42 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y206-20020a81a1d7000000b0055a07585a91sm2494527ywg.11.2023.05.03.03.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 03:09:41 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55af4277904so14442667b3.1;
        Wed, 03 May 2023 03:09:41 -0700 (PDT)
X-Received: by 2002:a81:84d2:0:b0:55a:6551:7ea8 with SMTP id
 u201-20020a8184d2000000b0055a65517ea8mr9163012ywf.42.1683108581083; Wed, 03
 May 2023 03:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com> <20230502170618.55967-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230502170618.55967-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 12:09:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
Message-ID: <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: r8a779a0: Add PWM clock
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, May 2, 2023 at 7:06 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> @@ -170,6 +170,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
>         DEF_MOD("msi3",         621,    R8A779A0_CLK_MSO),
>         DEF_MOD("msi4",         622,    R8A779A0_CLK_MSO),
>         DEF_MOD("msi5",         623,    R8A779A0_CLK_MSO),
> +       DEF_MOD("pwm",          628,    R8A779A0_CLK_S1D8),

Do you mind if I rename this to "pwm0" while applying, to match the docs?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.5.

>         DEF_MOD("rpc-if",       629,    R8A779A0_CLK_RPCD2),
>         DEF_MOD("scif0",        702,    R8A779A0_CLK_S1D8),
>         DEF_MOD("scif1",        703,    R8A779A0_CLK_S1D8),

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
