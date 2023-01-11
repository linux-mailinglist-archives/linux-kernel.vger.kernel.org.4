Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C7665930
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjAKKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjAKKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:41:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6DC0D;
        Wed, 11 Jan 2023 02:41:33 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFYXv-0004Rf-N7; Wed, 11 Jan 2023 11:41:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     wens@kernel.org, Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk356x: Add dma-names to UART device nodes
Date:   Wed, 11 Jan 2023 11:41:27 +0100
Message-ID: <18284546.sWSEgdgrri@diego>
In-Reply-To: <CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com>
References: <20221106161443.4104-1-wens@kernel.org> <CAGb2v64vKbgZxZUyVSdTfzuukHeUdK-8ymxUVGYg=GGShY6O-g@mail.gmail.com> <CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 7. November 2022, 02:50:43 CET schrieb Peter Geis:
> On Sun, Nov 6, 2022 at 8:28 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > On Mon, Nov 7, 2022 at 8:52 AM Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > On Sun, Nov 6, 2022 at 11:15 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> > > >
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > At least one implementation, Linux, requires "dma-names" properties
> > > > be used together with "dmas" to describe DMA resources. These are
> > > > currently missing, causing DMA to not be used for UARTs.
> > > >
> > > > Add "dma-names" to the UART device nodes.
> > > >
> > > > Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568 SoC")
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > Enabling dma globally can cause some interesting issues, have you
> > > tested this fully?
> >
> > It seems to work OK with the Bluetooth controller, though I'm not running
> > extensive transfers over it. Scanning both traditional and LE works, and
> > does exercise the DMA controller.
> >
> > If your worried about the DMA controller running out of channels and
> > impacting other peripherals, the DMA controller for the UARTs is only
> > shared with other UARTs, SPI, and PWM (which the kernel doesn't support
> > DMAing to). The UART and SPI drivers can fall back to PIO if DMA isn't
> > available.
> 
> Nah, enabling it for bluetooth is fine because you have flow control.
> My issues have been on channels without flow control. Without DMA it
> simply drops messages or the channel hangs until you close and reopen
> it. With DMA, when an overflow locks up the channel it is usually
> unavailable until the board is rebooted.
> 
> It's the main reason I've stopped daisy chaining boards to each other,
> when the board powers off the pinmux pulls go crazy just long enough
> to lock up the other end. It sometimes happens with reboots and large
> data bursts as well.
> 
> I'd only enable them on bluetooth channels for the time being because of this.

I guess I'll agree with Peter here. So enabling uart dmas should likely
happen on a board-level for bluetooth connections.


