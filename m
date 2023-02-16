Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5A698FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBPJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBPJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:27:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA071C7C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:27:37 -0800 (PST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 691F83F71C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676539656;
        bh=YtSJffCXpHu3ueJ8PsUTFVvEARiCiygu2497e6lu3sk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QQThPt4GZgoIWa+mJJOpXgisZ6bhH0mw5BwatBNiUocc/9xr9o2RGxEPP1VZm5v66
         SWmiZPYk+fOVzy12FC0eUAPAEa6lNkM+9uNhQMkHY5nnM72zxH9HM5R5lwR659bFmM
         XviDIkKjTQ8B8nzAqZQorybOGAu42WrlxOn4jdaDhREmYafjuNMUSkkZaPaA2G4q72
         CoyWyYfRsf6YkOBo93SHA1pfd5JM4k9aY+1q+WUvCzOK+HZzysfl2YaXG59kvoxIo2
         j19IqVMZmfYXSI4FSrofDUtUcIqdGu4DAGNxVfFTFT44AsjqxtXt9Nxp7wSD+Za2nY
         wo3ShV8wHhTfQ==
Received: by mail-qv1-f70.google.com with SMTP id k15-20020a0cd68f000000b00535261af1b1so778773qvi.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676539655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtSJffCXpHu3ueJ8PsUTFVvEARiCiygu2497e6lu3sk=;
        b=xDHf3TgoktUdrHyI+98RldIdRcdy854fAed/il+lEML6YecKZJDvArU3KPqLcjtTdr
         DxNuoVPNM2GHek1c6lU+G2zFnLRDkjJkD3mzeMRw6SgzgZo7Tq0W1N7s/u6KgmZRD/WQ
         T/SF58W8V848+k2YsV7NmRFToBFlLy/LCTT3ALBnoy62oaHsOs4WhtLVR435XQJbEzki
         Ts6vTrhAVnvdFm+EeIEdDTle2/zedb8EjcO/cEx+vX90SF9MOGka7IvNwBb/iFWMBBz+
         o3pVBgY4+rnE/+LTV0+UQ/elCXEpW9lazmdFvy4wPZXkB/uU/JD0DaUrBU5o2fJcpMLy
         RNGg==
X-Gm-Message-State: AO0yUKUT3070DbRt1mjRheTxXdShqfmwvhycZT1tqMiviM2k2w0kMs8b
        vnUMW1MKV1p4TvdDTbMGjExgeFYw+JP8lfLIw3zdzvffroppPeHy6j21pzZN83zBFtMRXK+acZc
        5k6cha3QEgtsU+GhmGDUG52Ndh6yIZ2x4J3lfZ/QHDZK1G0zONUz4x1rb2Q==
X-Received: by 2002:a0c:aa99:0:b0:56e:9a77:3d2c with SMTP id f25-20020a0caa99000000b0056e9a773d2cmr423877qvb.5.1676539654705;
        Thu, 16 Feb 2023 01:27:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+gOh5M+60vN2srtjtTI82UUYYfTQ40fizvaxdbVgr7R/vjEXOgtRRd+V8bdRCq8Uk/39SmMqfAZgINDo1mvAo=
X-Received: by 2002:a0c:aa99:0:b0:56e:9a77:3d2c with SMTP id
 f25-20020a0caa99000000b0056e9a773d2cmr423864qvb.5.1676539654466; Thu, 16 Feb
 2023 01:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com> <CAJM55Z9Y_fF+4Dtu++C_jVS0+ohXp5U0GyuJCBpUh-SpTMGrVA@mail.gmail.com>
 <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
In-Reply-To: <af42ed91-95aa-014a-1efb-6f70ee5a0433@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 16 Feb 2023 10:27:17 +0100
Message-ID: <CAJM55Z-+Cz8d=YySRaFJSAffDfoZ4Madx322qCX100-nAcx+5Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 15:04, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> On 2/14/2023 5:53 PM, Emil Renner Berthing wrote:
> > On Tue, 20 Dec 2022 at 02:12, Hal Feng <hal.feng@starfivetech.com> wrote:
> >>
> >> From: Emil Renner Berthing <kernel@esmil.dk>
> >>
> >> Add a minimal device tree for StarFive JH7110 VisionFive 2 board
> >> which has version A and version B. Support booting and basic
> >> clock/reset/pinctrl/uart drivers.
> >>
> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> >> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---
> >>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
> >>  .../jh7110-starfive-visionfive-2-va.dts       |  13 ++
> >>  .../jh7110-starfive-visionfive-2-vb.dts       |  13 ++
> >>  .../jh7110-starfive-visionfive-2.dtsi         | 111 ++++++++++++++++++
> >>  4 files changed, 138 insertions(+)
> >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
> >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
> >>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> >> index 0ea1bc15ab30..79e925a4a227 100644
> >> --- a/arch/riscv/boot/dts/starfive/Makefile
> >> +++ b/arch/riscv/boot/dts/starfive/Makefile
> >> @@ -1,2 +1,3 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
> >> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-2-va.dtb jh7110-starfive-visionfive-2-vb.dtb
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
> >> new file mode 100644
> >> index 000000000000..188d3fddbe88
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-va.dts
> >> @@ -0,0 +1,13 @@
> >> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >> +/*
> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> >> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +#include "jh7110-starfive-visionfive-2.dtsi"
> >> +
> >> +/ {
> >> +       model = "StarFive VisionFive 2 VA";
> >> +       compatible = "starfive,visionfive-2-va", "starfive,jh7110";
> >> +};
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
> >> new file mode 100644
> >> index 000000000000..f75c10536f84
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-vb.dts
> >> @@ -0,0 +1,13 @@
> >> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >> +/*
> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> >> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +#include "jh7110-starfive-visionfive-2.dtsi"
> >> +
> >> +/ {
> >> +       model = "StarFive VisionFive 2 VB";
> >> +       compatible = "starfive,visionfive-2-vb", "starfive,jh7110";
> >
> > Hi Hal,
> >
> > I just want to double check, is "VisionFive 2 VA" / "visoinfive-2-va"
> > and "VisionFive 2 VB" / "visionfive-2-vb" really what you want? I
> > still think having these names match what is printed on the silkscreen
> > makes it a lot easier for everybody. Even your own releases calls the
> > boards "v1.2A" and "v1.3B":
> > https://github.com/starfive-tech/VisionFive2/releases/
> >
> > So I'd suggest
> > model = "StarFive VisionFive 2 v1.3B";
> > compatible = "starfive,visionfive-2-v1.3b", "starfive,jh7110";
> >
> > I haven't seen these "VA" and "VB" anywhere else, so if you don't want
> > the version numbers and can promise that there will be no incompatible
> > future revisions of the boards then maybe just drop the "V". Eg.
> > model = "StarFive VisionFive 2 B";
> > compatible = "starfive,visionfive-2-b", "starfive,jh7110";
>
> The version A board has reached the end of life. As far as I know, the
> version B board will not update also unless there are some important
> requirements and StarFive decides to update. Furthermore, it's too late
> to change the compatible as patch 1 was already accepted. Will it be
> easier to read if I modify it as below?
>
>         model = "StarFive VisionFive 2 vB";
>         compatible = "starfive,visionfive-2-vb", "starfive,jh7110";

Oh, that's sad that the kernel will now end up calling the boards
something that's used nowhere else, even by StarFive :/
But yeah, I guess vA and vB are a little easier to read.

> Best regards,
> Hal
