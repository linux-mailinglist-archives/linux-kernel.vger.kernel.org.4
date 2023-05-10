Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA986FE334
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbjEJRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:25:39 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5AA5595
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:25:34 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id aa706346-ef57-11ed-abf4-005056bdd08f;
        Wed, 10 May 2023 20:25:32 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 10 May 2023 20:25:31 +0300
To:     Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: pca953x issue when driving a DSI bridge
Message-ID: <ZFvTi3tQGUq2OCHi@surfacebook>
References: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 10, 2023 at 06:12:19PM +0200, Jean-Michel Hautbois kirjoitti:
> Hello there !
> 
> I have a custom board, based on a i.MX8mm SoC which has a MIPI-DSI to eDP
> bridge (namely, a TI sn65dsi86). This bridge has a DSI enable pin, which is
> basically its reset pin, connected to my PCA9539 GPIO expander.
> 
> The issue is that this pin can't be sleeping, and it is tested in the
> gpiod_set_value() function.
> 
> Here is where it fails in my dmesg:

...

> [   11.273968]  gpiod_set_value+0x5c/0xcc
> [   11.277722]  ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]

Your problem even worse, i.e. ->resume() might sleep.

> [   11.283131]  __rpm_callback+0x48/0x19c
> [   11.286885]  rpm_callback+0x6c/0x80
> [   11.290375]  rpm_resume+0x3b0/0x660
> [   11.293864]  __pm_runtime_resume+0x4c/0x90
> [   11.297960]  __device_attach+0x90/0x1e4
> [   11.301797]  device_initial_probe+0x14/0x20
> [   11.305980]  bus_probe_device+0x9c/0xa4
> [   11.309817]  device_add+0x3d8/0x820
> [   11.313308]  __auxiliary_device_add+0x40/0xa0
> [   11.317668]  ti_sn65dsi86_add_aux_device.isra.0+0xb0/0xe0 [ti_sn65dsi86]
> [   11.324381]  ti_sn65dsi86_probe+0x20c/0x2ec [ti_sn65dsi86]
> [   11.329876]  i2c_device_probe+0x3b8/0x3f0
> [   11.333889]  really_probe+0xc0/0x3dc

...

> I suppose this is not a corner case and we may have other drivers and other
> boards connecting a GPIO which can sleep in a context where it should not ?
> 
> I would like to add one thing: on this board, the expander is routed in a
> way that makes it impossible to "sleep" as the reset is forced pulled-up and
> the power regulators are fixed and can't be stopped.

Can you elaborate why you think there is a problem?

> I don't know how to address this issue nicely and any thoughts is
> appreciated !

As a workaround you can consider the code around i2c_in_atomic_xfer_mode()
but since I have heard about i.MX8 so many negative remarks which makes me
think that hardware is a train wreck and shouldn't be used at all.

-- 
With Best Regards,
Andy Shevchenko


