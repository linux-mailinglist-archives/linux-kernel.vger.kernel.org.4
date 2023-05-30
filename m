Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E1716956
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjE3Q0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjE3QZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:25:47 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D67126;
        Tue, 30 May 2023 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O5PoVwqtJMunIZl33Ih/EqcDrZE0eTg44KxSraoqv8s=; b=kJL9/C/2vVwuQk8e8PwpNcqULY
        RhgNu6JGjfFol47lEMXVOsEExbH1bbz6PxTU+IH5R+EVXALfZc5vNtJuHDAc06rVG0yrJ1Qq+CLwf
        KetyM49pHm51xAzRub+kJ+rZ0desMqIZyW05aXMMsSpe58U92mV9D48+RXrVNDROwzkU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53080 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q429u-0007SA-QC; Tue, 30 May 2023 12:25:19 -0400
Date:   Tue, 30 May 2023 12:25:18 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230530122518.fca22556015bcdf8c588d274@hugovil.com>
In-Reply-To: <2023053058-onlooker-fondue-8c24@gregkh>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <20230529140711.896830-8-hugo@hugovil.com>
        <2023053058-onlooker-fondue-8c24@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 11:25:53 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > changed the function of the GPIOs pins to act as modem control
> > lines without any possibility of selecting GPIO function.
> > 
> > As a consequence, applications that depends on GPIO lines configured
> > by default as GPIO pins no longer work as expected.
> > 
> > Also, the change to select modem control lines function was done only
> > for channel A of dual UART variants (752/762). This was not documented
> > in the log message.
> > 
> > Allow to specify GPIO or modem control line function in the device
> > tree, and for each of the ports (A or B).
> > 
> > Do so by using the new device-tree property named
> > "modem-control-line-ports" (property added in separate patch).
> > 
> > When registering GPIO chip controller, mask-out GPIO pins declared as
> > modem control lines according to this new "modem-control-line-ports"
> > DT property.
> > 
> > Boards that need to have GPIOS configured as modem control lines
> > should add that property to their device tree. Here is a list of
> > boards using the sc16is7xx driver in their device tree and that may
> > need to be modified:
> >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> >     mips/boot/dts/ingenic/cu1830-neo.dts
> >     mips/boot/dts/ingenic/cu1000-neo.dts
> > 
> > Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> 
> So you are marking this as a "bugfix" and yet, it is at the end of a
> much larger series of patches.  Does this fix require all of them?  If
> so, it's not really relevant for stable kernels, right?  Or is it?

Like I said to Andy, I will re-order the patches so that "bugfix" patches are first. See new order below.

> I'm confused, what should I, as a maintainer, do here?  Take just this
> one fix for 6.4-final, and the rest for 6.5-rc1?  And add a proper cc:
> stable@ tag?  Or queue them all up for 6.4-final?  Or all for 6.5-rc1?
> Or something else?
> 
> What would you want to see if you were in my position here to help make
> your life easier?

From what I understand from https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst,
here is the new proposed patches order as well as what I plan to do in the commit message:

2f0f23e598df serial: sc16is7xx: fix broken port 0 uart init
  I will add tag "Cc: <stable@vger.kernel.org>"
  This patch is a prerequiste of "fix regression with GPIO configuration".

f292951c521e serial: sc16is7xx: mark IOCONTROL register as volatile
  I will add tag "Cc: <stable@vger.kernel.org>"
  This patch is a prerequiste of "fix regression with GPIO configuration".
  This patch has no "Fixes:" tag because it doesn't fix a previous bug, but Lech Perczak reported that it was required for 
  patch "fix regression with GPIO configuration" to work.

78930d607121 serial: sc16is7xx: refactor GPIO controller registration
  This patch is a prerequiste of "fix regression with GPIO configuration".
  It was done separately to ease the review process, but from a stable kernel backport, maybe it would be best to integrate it directly into "fix regression with GPIO configuration"?
  If not, should I add tag "Cc: <stable@vger.kernel.org>"?

f7ba105873d7 dt-bindings: sc16is7xx: Add property to change GPIO function
  This patch is a prerequiste of "fix regression with GPIO configuration".
  I will add tag "Cc: <stable@vger.kernel.org>"
  Should I add a tag "Fixes: " like I did in patch "fix regression with GPIO configuration"?

f2238e8f69b0 serial: sc16is7xx: fix regression with GPIO configuration
  I will add tags:
    Cc: <stable@vger.kernel.org> 2f0f23e5 serial: sc16is7xx: fix broken port 0 uart init
    Cc: <stable@vger.kernel.org> f292951c serial: sc16is7xx: mark IOCONTROL register as volatile
    Cc: <stable@vger.kernel.org> 78930d60 serial: sc16is7xx: refactor GPIO controller registration
    Cc: <stable@vger.kernel.org> f7ba1058 dt-bindings: sc16is7xx: Add property to change GPIO function
    Cc: <stable@vger.kernel.org>

2d98ab070b70 serial: sc16is7xx: fix bug when first setting GPIO direction
  This is a standalone bugfix
  I will add tag "Cc: <stable@vger.kernel.org>"

658e39d9073e serial: sc16is7xx: add call to get rs485 DT flags and properties
  Enhancement

588aac544e00 serial: sc16is7xx: add post reset delay
  Enhancement

5bb1b45bca81 serial: sc16is7xx: improve comments about variants
  Comments enhancements

Please tell me if it makes sense and if some tags are wrong/missing.

Hugo.
