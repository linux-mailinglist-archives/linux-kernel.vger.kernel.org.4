Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2570DB43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjEWLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjEWLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:10:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA0129;
        Tue, 23 May 2023 04:10:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 107)
        id 4927E68B05; Tue, 23 May 2023 13:10:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from blackhole.lan (p5b33fa9c.dip0.t-ipconnect.de [91.51.250.156])
        by verein.lst.de (Postfix) with ESMTPSA id 676E867328;
        Tue, 23 May 2023 13:10:11 +0200 (CEST)
Date:   Tue, 23 May 2023 13:10:06 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <yanhong.wang@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL
 clock generator
Message-ID: <20230523131006.46997d84@blackhole.lan>
In-Reply-To: <20230523-fondue-monotype-0c751a8f0c13@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
        <20230512022036.97987-2-xingyu.wu@starfivetech.com>
        <20230519135733.GA10188@lst.de>
        <20230519-smokeless-guileless-2a71cae06509@wendy>
        <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
        <20230523-fondue-monotype-0c751a8f0c13@wendy>
Organization: LST e.V.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 09:28:39 +0100
Conor Dooley <conor.dooley@microchip.com> wrote:

> On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> > On 2023/5/19 22:16, Conor Dooley wrote:
> > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> > >> [...]

> > >> > +/* PLL clocks */
> > >> > +#define JH7110_CLK_PLL0_OUT			0
> > >> > +#define JH7110_CLK_PLL1_OUT			1
> > >> > +#define JH7110_CLK_PLL2_OUT			2
> > >> 
> > >> In U-Boot commit 58c9c60b Yanhong Wang added:
> > >> 
> > >> +
> > >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> > >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> > >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> > >> +
> > >> +#define JH7110_SYSCLK_END                    193
[...]
> > > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it
> > > won't understand the numbering. The headers are part of the
> > > dt-binding :/

In fact, the clock index >= 190 makes linux hang on boot, waiting with
EPROBE_DEFER for every device's clock, because the sysclk driver errors
out with EINVAL (jh7110_sysclk_get()).

> > Because PLL driver is separated from SYSCRG drivers in Linux, the
> > numbering starts from 0. But in Uboot, the PLL driver is included
> > in the SYSCRG driver, and the number follows the SYSCRG.
> 
> Unfortunately, how you choose to construct your drivers has nothing to
> do with this.
> These defines/numbers appear in the dts and are part of the DT ABI.
> The same dts is supposed to work for Linux & U-Boot.

The JH7110 has 6 blocks of 64k iomem in that functional area:
{SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
The good news: the current DTS, as proposed here and in U-Boot master,
provides nodes for all 6 entities. The bad news is that the clock
assignments to those nodes and their numbering is messed up.

AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot gets it
wrong, in addition to the erroneous DTS.

	Torsten
