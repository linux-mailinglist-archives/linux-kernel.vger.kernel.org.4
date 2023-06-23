Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9104173B0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFWGtY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWGtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:49:20 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465010FD;
        Thu, 22 Jun 2023 23:49:19 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-570282233ceso1859857b3.1;
        Thu, 22 Jun 2023 23:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687502958; x=1690094958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vw3cY1kzXKgiIBKra8+o5IKtv1gR0wSU11KZNvDzks=;
        b=DhQDHBst6BkvsN5pgAmIuv8FI5/O+7hYxi/2pu4C0FO5lAp4NtWFw7ZcJpVdgCBar8
         NlVh3fn1c7J2FapeXQFxcCEF1y2VGuJEI/nq7/GmmhWWC6QtTaepPPhWouWO/uNDJfNa
         yaeWmfG30gSwIJcGzPWtXCGPC+878SP3ToF/8JsmGZm2no7oKEUwVLrVlAHj3OWCuUke
         RB0/nX7M5wZsZVnfQuHZAq6hYnPull9dZCVcYS96RDgg1rI0IqkP7FbbKdxqRW5IQmfM
         m3sRIBRze/3wEqiFg10PivF5z5+od/N61niT9BFQE/iL/zqV3CdiNic1bDa7cpdqAdO/
         FNJg==
X-Gm-Message-State: AC+VfDwavan9c5+Po7xoH4VTTzSZ8lZrES+BiMc1xi7JnQ5vR68QXSTO
        nzp5KmWbT/fgYHu6+ROq4hUaUbVh+DFH+g==
X-Google-Smtp-Source: ACHHUZ4dO04OPf4XlR8c0SixCFwgK6UfutZ6Ex5ScdwW1oEbnAgOsnND6Rht3PyRQJlM6gIzo1GY/g==
X-Received: by 2002:a81:6e89:0:b0:568:e6d9:7c1a with SMTP id j131-20020a816e89000000b00568e6d97c1amr19078679ywc.4.1687502958415;
        Thu, 22 Jun 2023 23:49:18 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x7-20020a0dee07000000b0056dfbc37d9fsm2307241ywe.50.2023.06.22.23.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 23:49:18 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so236630276.3;
        Thu, 22 Jun 2023 23:49:17 -0700 (PDT)
X-Received: by 2002:a0d:dbce:0:b0:573:a003:6e0b with SMTP id
 d197-20020a0ddbce000000b00573a0036e0bmr6663390ywe.26.1687502957717; Thu, 22
 Jun 2023 23:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com> <168748034127.332493.277333132642198960.b4-ty@kernel.org>
In-Reply-To: <168748034127.332493.277333132642198960.b4-ty@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 08:49:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU53jn5UP-5xB_YLh2T5gPaxL1dxWY5Vr5D8p2mUDnqwA@mail.gmail.com>
Message-ID: <CAMuHMdU53jn5UP-5xB_YLh2T5gPaxL1dxWY5Vr5D8p2mUDnqwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] spi: Add CSI support for Renesas RZ/V2M
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
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

Hi Mark,

On Fri, Jun 23, 2023 at 2:32 AM Mark Brown <broonie@kernel.org> wrote:
> On Thu, 22 Jun 2023 12:33:36 +0100, Fabrizio Castro wrote:
> > This series is to add support for the Clocked Serial Interface (CSI)
> > IP found in the Renesas RZ/V2M SoC.
> >
> > Thanks,
> > Fab
> >
> > v2: edited list of include files in drivers/spi/spi-rzv2m-csi.c
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/5] spi: dt-bindings: Add bindings for RZ/V2M CSI
>       commit: db63e7ad2895409f78a04f331f781baa7a879dd7
> [2/5] clk: renesas: r9a09g011: Add CSI related clocks
>       commit: 7c78eb3e5d30eaa217cecaa32711e41cd849d498
> [3/5] spi: Add support for Renesas CSI
>       commit: dcf92036cb3e1b7bf3472109e4290a0937b270dd
> [4/5] arm64: dts: renesas: r9a09g011: Add CSI nodes
>       commit: ef643c6b57020ee279d18636d9d967ee048dbffa
> [5/5] arm64: defconfig: Enable Renesas RZ/V2M CSI driver
>       commit: dfbd12ae0e7c761e07369f5a2d55fe06eb54ad31

I hoped this would have been a bug in b4 thanks, but unfortunately it
is not.

Please do not apply unreviewed clock, DTS, and defconfig patches to
your tree.  These are intended to go upstream through the renesas-clk
and clk, renesas-dt and soc, resp. renesas-defconfig and soc trees.

Thanks for your understanding!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
