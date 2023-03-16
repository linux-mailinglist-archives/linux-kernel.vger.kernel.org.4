Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A76BCC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCPKK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCPKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:10:57 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 03:10:55 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D6B420C;
        Thu, 16 Mar 2023 03:10:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D2BBD28022ECD;
        Thu, 16 Mar 2023 10:51:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C829253DFE; Thu, 16 Mar 2023 10:51:26 +0100 (CET)
Date:   Thu, 16 Mar 2023 10:51:26 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
        linux-serial@vger.kernel.org, Zeng Chao <chao.zeng@siemens.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com, tony@atomide.com,
        andriy.shevchenko@linux.intel.com,
        matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: Wrong RS485 RTS polarity in 8250 OMAP UART Driver vs DT binding?
Message-ID: <20230316095126.GA4235@wunner.de>
References: <ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:41:56PM +0100, Francesco Dolcini wrote:
> We have working hardware, using another UART that expect
> rs485-rts-active-low, and the exact same HW, when using OMAP uart,
> requires rs485-rts-active-high (the HW is modular, so we are really just
> changing the uart, keeping the same RS485 transceiver / connections).
> 
> What's going on there? Is the semantic of the 8250_omap driver just the
> opposite as it should be?

Yes, sadly, for historic reasons.

See these threads:

https://lore.kernel.org/linux-serial/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/

https://lore.kernel.org/linux-serial/2de36eba3fbe11278d5002e4e501afe0ceaca039.1663863805.git.lukas@wunner.de/


> Am I doing something wrong in the device tree?

No, but regrettably you need a separate device tree depending on which SoC
you're using.

Thanks,

Lukas
