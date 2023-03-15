Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672A6BBE12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCOUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCOUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:42:13 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709F6770D;
        Wed, 15 Mar 2023 13:42:10 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 09AD92146A;
        Wed, 15 Mar 2023 21:42:00 +0100 (CET)
Date:   Wed, 15 Mar 2023 21:41:56 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
        linux-serial@vger.kernel.org, Zeng Chao <chao.zeng@siemens.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, tony@atomide.com,
        andriy.shevchenko@linux.intel.com,
        matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Wrong RS485 RTS polarity in 8250 OMAP UART Driver vs DT binding?
Message-ID: <ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I have been recently working on RS485 on a TI K3 AM62 (using 8250_omap.c
driver) and there is something that I do not really understand about
the RTS polarity.

According to the DT binding (Documentation/devicetree/bindings/serial/rs485.yaml)
when `rs485-rts-active-low` is present the behavior should be "drive RTS
low when sending", however in the code it seems that this is handled the
opposite way (drivers/tty/serial/8250/8250_omap.c:861).

/*
 * Retain same polarity semantics as RS485 software emulation,
 * i.e. SER_RS485_RTS_ON_SEND means driving RTS low on send.
 */

We have working hardware, using another UART that expect
rs485-rts-active-low, and the exact same HW, when using OMAP uart,
requires rs485-rts-active-high (the HW is modular, so we are really just
changing the uart, keeping the same RS485 transceiver / connections).

What's going on there? Is the semantic of the 8250_omap driver just the
opposite as it should be? Am I doing something wrong in the device tree?

This is the relevant DTS part.

&main_uart1 {
	linux,rs485-enabled-at-boot-time;
	rs485-rts-active-high;
	rs485-rx-during-tx;
	status = "okay";
};

Francesco

