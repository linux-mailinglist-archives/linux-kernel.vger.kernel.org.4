Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB5738ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFUSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjFUS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:29:42 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD3270E;
        Wed, 21 Jun 2023 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j1CsjD1T9Eu3Vl2uYZSXNfp6lfyOHNdhhCP0yVD27E8=; b=TypqpFe1aJ1+2iiT9WiHsCV2py
        2l0h08Q9AMKQHV41pdKjansTTOsoRs4C7l5QfVVIVZdGVmoNMFpFMNE1HiE8qQDKfPUzEEt+WW7cP
        LfZYiqVNvCbls9lGujPGuZB3K1qFSwFd3DPgx7JpuTgXwt4dhqjBD9hqmfpuT9v2vA8w=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:33230 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qC2ZZ-0007Ko-BK; Wed, 21 Jun 2023 14:28:54 -0400
Date:   Wed, 21 Jun 2023 14:28:52 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230621142852.07c5f4940e5a9920039bf4d1@hugovil.com>
In-Reply-To: <20230621181441cd214f99@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <Y8rl452Xm1FrnFfF@mail.local>
        <20230621101429.7f86490aa7590f0d978834ce@hugovil.com>
        <20230621125945.1f10b66832d0d1c61e21f78d@hugovil.com>
        <20230621181441cd214f99@mail.local>
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
Subject: Re: [PATCH v3 00/14] rtc: pcf2127: add PCF2131 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 20:14:41 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 21/06/2023 12:59:45-0400, Hugo Villeneuve wrote:
> > On Wed, 21 Jun 2023 10:14:29 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > 
> > > On Fri, 20 Jan 2023 20:05:07 +0100
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > I know I've been holding off on the review of this series for a while
> > > > and I'm sorry for that.
> > > > 
> > > > One of the main issue that is remaining is that the driver ends up being
> > > > 53% bigger and generaly less efficient for no added functionality for
> > > > the existing RTCs.
> > > > 
> > > > I know performance is not a concern however, having more code in the
> > > > set/read time and irq paths means that it is more difficult to set an
> > > > get the time precisely.
> > > 
> > > Hi Alexandre,
> > > one way to keep rtc_read_time() as efficient as before, and even more
> > > efficient by reading 7 instead of 10 registers, would be to drop reading
> > > the CTRL3 register, which is only used to detect and display an info
> > > message for the low battery condition. This low battery check could be
> > > moved to an ioctl call, like it is done in the PCF8523 driver.
> > > 
> > > Hugo.
> > 
> > Hi,
> > in fact it is already part of the ioctl, so it is even simpler...
> > 
> 
> Yes, the dev_info can be removed.

Hi,
great, I will integrate that patch to improve rtc_read_time()
performance, and resubmit V4 soon with the requested changes mentioned
during V3 review.

Thank you, Hugo.


> > > > I guess I'll take it as a merged driver but I took a different decision
> > > > for other RTCs.
> > > > 
> > > > On 15/12/2022 10:02:01-0500, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > 
> > > > > Hello,
> > > > > this patch series adds the driver for the PCF2131 real-time clock.
> > > > > 
> > > > > This RTC is very similar in functionality to the PCF2127/29 with the
> > > > > following differences:
> > > > >   -supports two new control registers at offsets 4 and 5
> > > > >   -supports a new reset register
> > > > >   -supports 4 tamper detection functions instead of 1
> > > > >   -has no nvmem (like the PCF2129)
> > > > >   -has two output interrupt pins instead of one
> > > > >   -has 1/100th seconds capabilities (not supported in this driver)
> > > > >   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
> > > > >    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
> > > > >   -watchdog value register cannot be read after being set
> > > > > 
> > > > > Most of the register addresses are very different, although they still
> > > > > follow the same layout. For example, the time/date and tamper registers
> > > > > have a different base address, but the offsets are all the same.
> > > > > Consequently, the source code of the PCF2127 driver can be easily adapted
> > > > > to support this new device.
> > > > > 
> > > > > Patches 1 to 6 modify the existing pcf2127 driver to make it more generic
> > > > > and able to support multiple variants, like the PCF2131. This is done
> > > > > mostly by using offsets instead of absolute hardcoded register addresses.
> > > > > 
> > > > > Patch 7 add actual support for the PCF2131.
> > > > > 
> > > > > Patch 8 configures all interrupt sources to go through the INT A pin.
> > > > > 
> > > > > Patch 9 changes the PWRMNG bits to be the same with the PCF2131 as they
> > > > >       are with the PCF2127/29 (different default values).
> > > > > 
> > > > > Patch 10 allow to confirm PCF2131 device presence by reading the reset
> > > > >       register fixed pattern.
> > > > > 
> > > > > Patch 11 adapt the time/date registers write sequence for PCF2131 (STOP and
> > > > >       CPR bits).
> > > > > 
> > > > > Patch 12 add support for generic watchdog timing configuration.
> > > > > 
> > > > > Patch 13 add a new flag to identify if device has read support for reading
> > > > >       watchdog register value.
> > > > >       Since the watchdog value register cannot be read on the PCF2131 after
> > > > >       being set, it seems that we cannot detect if watchdog timer was
> > > > >       started by bootloader. I am not sure what is the best way to handle
> > > > >       this situation, suggestions are welcomed.
> > > > > 
> > > > > Patch 14 add the dt-bindings for the PCF2131.
> > > > > 
> > > > > I have tested the driver using a PCF2131-ARD evaluation board connected to
> > > > > an NXP imx8mp evaluation board:
> > > > >   - Time get/set ok;
> > > > >   - Alarms get/set ok
> > > > >   - Timestamp 1 to 4 ok
> > > > >   - IRQ alarm ok
> > > > >   - Watchdog ok
> > > > >   - Also tested successfully with "RTC Driver Test Example" from
> > > > >     Documentation/rtc.txt
> > > > > 
> > > > > I have also tested the driver on a custom PCF2129 adapter board connected to a
> > > > > beaglebone black.
> > > > > 
> > > > > Thank you.
> > > > > 
> > > > > Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
> > > > > Link: [v2] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=285734
> > > > > 
> > > > > Changes for V3:
> > > > > - Rebased for kernel v6.1
> > > > > 
> > > > > Changes for V2:
> > > > > - In general, fix and improvements after I have tested on real hardware
> > > > > - Fix alarm interrupt A/B mask setting for PCF2131:
> > > > >   PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
> > > > > - Remove low_reg validation: only check if TS interrupt flag is
> > > > >   defined, as low_reg is defined at address 0 for PCF2127/29.
> > > > > - Change PWRMNG value for PCF2131: default is different than PCF2127/29.
> > > > > - Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
> > > > > - Map all interrupt sources to INT A pin
> > > > > - Read and validate PCF2131 device presence from RESET register
> > > > > - Adapt watchdog configuration for PCF2131
> > > > > 
> > > > > Hugo Villeneuve (14):
> > > > >   rtc: pcf2127: add variant-specific configuration structure
> > > > >   rtc: pcf2127: adapt for time/date registers at any offset
> > > > >   rtc: pcf2127: adapt for alarm registers at any offset
> > > > >   rtc: pcf2127: adapt for WD registers at any offset
> > > > >   rtc: pcf2127: adapt for CLKOUT register at any offset
> > > > >   rtc: pcf2127: add support for multiple TS functions
> > > > >   rtc: pcf2127: add support for PCF2131 RTC
> > > > >   rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
> > > > >   rtc: pcf2127: set PWRMNG value for PCF2131
> > > > >   rtc: pcf2127: read and validate PCF2131 device signature
> > > > >   rtc: pcf2127: adapt time/date registers write sequence for PCF2131
> > > > >   rtc: pcf2127: support generic watchdog timing configuration
> > > > >   rtc: pcf2127: add flag for watchdog register value read support
> > > > >   dt-bindings: rtc: pcf2127: add PCF2131
> > > > > 
> > > > >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   4 +-
> > > > >  drivers/rtc/Kconfig                           |   4 +-
> > > > >  drivers/rtc/rtc-pcf2127.c                     | 939 ++++++++++++++----
> > > > >  3 files changed, 752 insertions(+), 195 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > > > 
> > > > -- 
> > > > Alexandre Belloni, co-owner and COO, Bootlin
> > > > Embedded Linux and Kernel engineering
> > > > https://bootlin.com
> > > > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
