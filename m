Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11525738E50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFUSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:14:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03113FE;
        Wed, 21 Jun 2023 11:14:43 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687371282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8MH3W6fDZX8+T3D49XzxkWmupcm3/B6q+WFsdXJTP4=;
        b=QPw/6nK2qV3VkKyqz4fzI+OWKYuf+/j//RcXAZv1JqkCXbUPcNEqApDw4xJ1EnylwzGm3n
        eFoVEuqV7JfylvAnL9S3n5X57cX3P6N+H5INSniBuos6F4j3Qq6sbOUWFf1IZdcgqa98bp
        FkP65EARwhb+KVteydSDcq8lM8BP+pf3DqVAp6IUcXuXZj16EFPwseU3Z4YTTFCqAaLaXn
        v6CgPH/lzwAglqfbFfeC2MnSTUHRTP7PkemRFrrNrY2NolgMYXIg962914/64sPPiZglOd
        tL5W7zw3MXGQoZm5TF+JZgKZDERtv2zWbVGSHoev3adFWBb0B6+DS4aoHh0qVA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 837FE1BF207;
        Wed, 21 Jun 2023 18:14:41 +0000 (UTC)
Date:   Wed, 21 Jun 2023 20:14:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 00/14] rtc: pcf2127: add PCF2131 driver
Message-ID: <20230621181441cd214f99@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <Y8rl452Xm1FrnFfF@mail.local>
 <20230621101429.7f86490aa7590f0d978834ce@hugovil.com>
 <20230621125945.1f10b66832d0d1c61e21f78d@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621125945.1f10b66832d0d1c61e21f78d@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 12:59:45-0400, Hugo Villeneuve wrote:
> On Wed, 21 Jun 2023 10:14:29 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > On Fri, 20 Jan 2023 20:05:07 +0100
> > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > 
> > > Hello,
> > > 
> > > I know I've been holding off on the review of this series for a while
> > > and I'm sorry for that.
> > > 
> > > One of the main issue that is remaining is that the driver ends up being
> > > 53% bigger and generaly less efficient for no added functionality for
> > > the existing RTCs.
> > > 
> > > I know performance is not a concern however, having more code in the
> > > set/read time and irq paths means that it is more difficult to set an
> > > get the time precisely.
> > 
> > Hi Alexandre,
> > one way to keep rtc_read_time() as efficient as before, and even more
> > efficient by reading 7 instead of 10 registers, would be to drop reading
> > the CTRL3 register, which is only used to detect and display an info
> > message for the low battery condition. This low battery check could be
> > moved to an ioctl call, like it is done in the PCF8523 driver.
> > 
> > Hugo.
> 
> Hi,
> in fact it is already part of the ioctl, so it is even simpler...
> 

Yes, the dev_info can be removed.

> Hugo.
> 
> 
> > 
> > 
> > > I guess I'll take it as a merged driver but I took a different decision
> > > for other RTCs.
> > > 
> > > On 15/12/2022 10:02:01-0500, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > Hello,
> > > > this patch series adds the driver for the PCF2131 real-time clock.
> > > > 
> > > > This RTC is very similar in functionality to the PCF2127/29 with the
> > > > following differences:
> > > >   -supports two new control registers at offsets 4 and 5
> > > >   -supports a new reset register
> > > >   -supports 4 tamper detection functions instead of 1
> > > >   -has no nvmem (like the PCF2129)
> > > >   -has two output interrupt pins instead of one
> > > >   -has 1/100th seconds capabilities (not supported in this driver)
> > > >   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
> > > >    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
> > > >   -watchdog value register cannot be read after being set
> > > > 
> > > > Most of the register addresses are very different, although they still
> > > > follow the same layout. For example, the time/date and tamper registers
> > > > have a different base address, but the offsets are all the same.
> > > > Consequently, the source code of the PCF2127 driver can be easily adapted
> > > > to support this new device.
> > > > 
> > > > Patches 1 to 6 modify the existing pcf2127 driver to make it more generic
> > > > and able to support multiple variants, like the PCF2131. This is done
> > > > mostly by using offsets instead of absolute hardcoded register addresses.
> > > > 
> > > > Patch 7 add actual support for the PCF2131.
> > > > 
> > > > Patch 8 configures all interrupt sources to go through the INT A pin.
> > > > 
> > > > Patch 9 changes the PWRMNG bits to be the same with the PCF2131 as they
> > > >       are with the PCF2127/29 (different default values).
> > > > 
> > > > Patch 10 allow to confirm PCF2131 device presence by reading the reset
> > > >       register fixed pattern.
> > > > 
> > > > Patch 11 adapt the time/date registers write sequence for PCF2131 (STOP and
> > > >       CPR bits).
> > > > 
> > > > Patch 12 add support for generic watchdog timing configuration.
> > > > 
> > > > Patch 13 add a new flag to identify if device has read support for reading
> > > >       watchdog register value.
> > > >       Since the watchdog value register cannot be read on the PCF2131 after
> > > >       being set, it seems that we cannot detect if watchdog timer was
> > > >       started by bootloader. I am not sure what is the best way to handle
> > > >       this situation, suggestions are welcomed.
> > > > 
> > > > Patch 14 add the dt-bindings for the PCF2131.
> > > > 
> > > > I have tested the driver using a PCF2131-ARD evaluation board connected to
> > > > an NXP imx8mp evaluation board:
> > > >   - Time get/set ok;
> > > >   - Alarms get/set ok
> > > >   - Timestamp 1 to 4 ok
> > > >   - IRQ alarm ok
> > > >   - Watchdog ok
> > > >   - Also tested successfully with "RTC Driver Test Example" from
> > > >     Documentation/rtc.txt
> > > > 
> > > > I have also tested the driver on a custom PCF2129 adapter board connected to a
> > > > beaglebone black.
> > > > 
> > > > Thank you.
> > > > 
> > > > Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
> > > > Link: [v2] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=285734
> > > > 
> > > > Changes for V3:
> > > > - Rebased for kernel v6.1
> > > > 
> > > > Changes for V2:
> > > > - In general, fix and improvements after I have tested on real hardware
> > > > - Fix alarm interrupt A/B mask setting for PCF2131:
> > > >   PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
> > > > - Remove low_reg validation: only check if TS interrupt flag is
> > > >   defined, as low_reg is defined at address 0 for PCF2127/29.
> > > > - Change PWRMNG value for PCF2131: default is different than PCF2127/29.
> > > > - Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
> > > > - Map all interrupt sources to INT A pin
> > > > - Read and validate PCF2131 device presence from RESET register
> > > > - Adapt watchdog configuration for PCF2131
> > > > 
> > > > Hugo Villeneuve (14):
> > > >   rtc: pcf2127: add variant-specific configuration structure
> > > >   rtc: pcf2127: adapt for time/date registers at any offset
> > > >   rtc: pcf2127: adapt for alarm registers at any offset
> > > >   rtc: pcf2127: adapt for WD registers at any offset
> > > >   rtc: pcf2127: adapt for CLKOUT register at any offset
> > > >   rtc: pcf2127: add support for multiple TS functions
> > > >   rtc: pcf2127: add support for PCF2131 RTC
> > > >   rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
> > > >   rtc: pcf2127: set PWRMNG value for PCF2131
> > > >   rtc: pcf2127: read and validate PCF2131 device signature
> > > >   rtc: pcf2127: adapt time/date registers write sequence for PCF2131
> > > >   rtc: pcf2127: support generic watchdog timing configuration
> > > >   rtc: pcf2127: add flag for watchdog register value read support
> > > >   dt-bindings: rtc: pcf2127: add PCF2131
> > > > 
> > > >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   4 +-
> > > >  drivers/rtc/Kconfig                           |   4 +-
> > > >  drivers/rtc/rtc-pcf2127.c                     | 939 ++++++++++++++----
> > > >  3 files changed, 752 insertions(+), 195 deletions(-)
> > > > 
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > -- 
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> > > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
