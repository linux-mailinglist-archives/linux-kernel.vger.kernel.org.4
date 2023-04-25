Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5696EE821
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjDYTUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:20:52 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111C14F48;
        Tue, 25 Apr 2023 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6+cHucglDJdNHAF2oPzTY4GeYjK4vKDbP9nofsw5r1w=; b=zYzE0wJwOBZQ0uR2Q2Ig4wZR9t
        sRfBiUeZfil+xYPZ3G0pEd3se38f9AfkdXx02cSaB4hJkUPrluVtaVsnbfzyWFXokeme+e2Log3I3
        pWnpYLydgPWr2/hN6rHIAki4qdVJBfg6GMAudf99V7OUWTeN44bi7SsqUVvKK7OzzIo/K5GkOSb9M
        /5UzokINIMce5YNg5JmQfH/QjuWn37sSMVJIaPFoTZ6CguLFE1AI0ST8DAO4Myub2ZyfQFSCgq4jS
        yH5w5nmJ6BtmdHLv+lq1SbRoUuxVuZ49pYdYQ7Pb0nLWoeDfSjus7bgNxORyHrNiwa5JiEF9diYMT
        kTTNzFzg==;
Received: from p200300ccff17ff001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff17:ff00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prODR-0005ZR-KJ; Tue, 25 Apr 2023 21:20:41 +0200
Date:   Tue, 25 Apr 2023 21:20:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425212040.5a4d5b09@aktux>
In-Reply-To: <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
        <20230425201117.457f224c@aktux>
        <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 21:38:57 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
> 
> On Tue, Apr 25, 2023 at 08:11:17PM +0200, Andreas Kemnade wrote:
> > On Tue, 25 Apr 2023 20:32:41 +0300
> > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:  
> > > It seems GPIOs on OMAP1 boards are somewhat broken after:
> > > 
> > > commit 92bf78b33b0b463b00c6b0203b49aea845daecc8
> > > Author: Andreas Kemnade <andreas@kemnade.info>
> > > Date:   Fri Jan 13 21:59:22 2023 +0100
> > > 
> > >     gpio: omap: use dynamic allocation of base
> > > 
> > > E.g. on OSK1 the ethernet IRQ cannot (omap_gpio.0) no longer be requested:
> > > 
> > > [    0.277252] Error requesting gpio 0 for smc91x irq
> > > 
> > > Also the tps65010 (still using static allocation) will now conflict:
> > > 
> > > [    0.400726] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > [    0.400848] gpio gpiochip5: (tps65010): GPIO integer space overlap, cannot add chip
> > > [    0.400970] gpiochip_add_data_with_key: GPIOs 208..214 (tps65010) failed to register, -16
> > > [    0.401092] tps65010 i2c-tps65010: can't add gpiochip, err -16
> > > 
> > > I think this change should be reverted until the board files and other
> > > gpiochips are fixed accordingly.
> > >   
> > well, then just fix that tps65010 thing. 
> > 
> > that change is itself a regression fix for exactly the same kind of error.  
> 
> Which commit introduced that regression? Also, the changelog mentions
> it happens only with "unusual" probe order. Now, all the ordinary cases
> for OMAP1 are broken.
> 
did not bisect that to an exact commit.
Unusual probe order: on the device where I tested it,
I did not see a completely successful probe.

> And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> stopped now working.
> 
so we break every non-devicetree user of omap-gpio? 

Regards,
Andreas
