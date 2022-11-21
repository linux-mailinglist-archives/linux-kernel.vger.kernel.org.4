Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5442F6319B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKUGZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:25:43 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C926571;
        Sun, 20 Nov 2022 22:25:38 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AA67B24E205;
        Mon, 21 Nov 2022 14:25:35 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 14:25:35 +0800
Received: from [192.168.50.235] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 14:25:34 +0800
Message-ID: <7cf9be4a-6ef2-f1f9-07a3-4801fd2833a8@starfivetech.com>
Date:   Mon, 21 Nov 2022 14:25:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 01/14] clk: starfive: Factor out common JH7100 and
 JH7110 code
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-2-hal.feng@starfivetech.com>
 <CAJM55Z8nGNm_TrTsw0HZnAVehWrFU9-MtAj0ngRRx_E8jFapGg@mail.gmail.com>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8nGNm_TrTsw0HZnAVehWrFU9-MtAj0ngRRx_E8jFapGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 00:22:10 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > The clock control registers on the StarFive JH7100 and JH7110 work
> > identically, so factor out the code then drivers for the two SoCs
> > can share it without depending on each other. No functional change.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  MAINTAINERS                                |   2 +-
> >  drivers/clk/starfive/Kconfig               |   5 +
> >  drivers/clk/starfive/Makefile              |   3 +-
> >  drivers/clk/starfive/clk-starfive-jh7100.c | 325 --------------------
> >  drivers/clk/starfive/clk-starfive-jh7100.h |   2 +
> >  drivers/clk/starfive/clk-starfive-jh71x0.c | 333 +++++++++++++++++++++
> >  6 files changed, 343 insertions(+), 327 deletions(-)
> >  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 256f03904987..d43daa89d5f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19602,7 +19602,7 @@ STARFIVE JH7100 CLOCK DRIVERS
> >  M:     Emil Renner Berthing <kernel@esmil.dk>
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
> > -F:     drivers/clk/starfive/clk-starfive-jh7100*
> > +F:     drivers/clk/starfive/
> 
> When this entry cover all the starfive clock drivers the header should
> also match. Eg.
> STARFIVE CLOCK DRIVERS

OK, will fix it. Ditto for the reset driver.

Best regards,
Hal
