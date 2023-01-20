Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6678675D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjATTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjATTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:06:29 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B317A53C;
        Fri, 20 Jan 2023 11:06:05 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C12E120003;
        Fri, 20 Jan 2023 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674241508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9E+QtNt/tZxl4Is0JIBM8KaZdkhA+rSRubd0xlkD1hw=;
        b=Mb2Fh1aAnkRXnvGascZr+4jUG7mf45VPGVIDZ5JWEclvUMQSA4O8XxOEho9saTFPoLDAKr
        aolcDJFeJGw+ZBeqA6/cCGJHkYSk0CdX8apdLmW/w2x3vtJjthgcVl7EXkT5Rzi+fCxrmZ
        Speb6jwBwtbIvnEn9ZsVkozwfZooo9AKsKjBwNWd+Uu2Xlb+DzUsK2AjfN4pt/mUJNwm84
        xx5mXRZ69BEilJkI+ofitdBqrDwQh18RefGedM+WqOGhqxdA+i92Aqx4SfGNwsp23GQzEF
        XGk/mil2kkZrS/pRC04umAlVhesz+bZb+EKGZjEqjUm5AuOJX8o281Zj+iYhtA==
Date:   Fri, 20 Jan 2023 20:05:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 00/14] rtc: pcf2127: add PCF2131 driver
Message-ID: <Y8rl452Xm1FrnFfF@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know I've been holding off on the review of this series for a while
and I'm sorry for that.

One of the main issue that is remaining is that the driver ends up being
53% bigger and generaly less efficient for no added functionality for
the existing RTCs.

I know performance is not a concern however, having more code in the
set/read time and irq paths means that it is more difficult to set an
get the time precisely.

I guess I'll take it as a merged driver but I took a different decision
for other RTCs.

On 15/12/2022 10:02:01-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series adds the driver for the PCF2131 real-time clock.
> 
> This RTC is very similar in functionality to the PCF2127/29 with the
> following differences:
>   -supports two new control registers at offsets 4 and 5
>   -supports a new reset register
>   -supports 4 tamper detection functions instead of 1
>   -has no nvmem (like the PCF2129)
>   -has two output interrupt pins instead of one
>   -has 1/100th seconds capabilities (not supported in this driver)
>   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
>    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
>   -watchdog value register cannot be read after being set
> 
> Most of the register addresses are very different, although they still
> follow the same layout. For example, the time/date and tamper registers
> have a different base address, but the offsets are all the same.
> Consequently, the source code of the PCF2127 driver can be easily adapted
> to support this new device.
> 
> Patches 1 to 6 modify the existing pcf2127 driver to make it more generic
> and able to support multiple variants, like the PCF2131. This is done
> mostly by using offsets instead of absolute hardcoded register addresses.
> 
> Patch 7 add actual support for the PCF2131.
> 
> Patch 8 configures all interrupt sources to go through the INT A pin.
> 
> Patch 9 changes the PWRMNG bits to be the same with the PCF2131 as they
>       are with the PCF2127/29 (different default values).
> 
> Patch 10 allow to confirm PCF2131 device presence by reading the reset
>       register fixed pattern.
> 
> Patch 11 adapt the time/date registers write sequence for PCF2131 (STOP and
>       CPR bits).
> 
> Patch 12 add support for generic watchdog timing configuration.
> 
> Patch 13 add a new flag to identify if device has read support for reading
>       watchdog register value.
>       Since the watchdog value register cannot be read on the PCF2131 after
>       being set, it seems that we cannot detect if watchdog timer was
>       started by bootloader. I am not sure what is the best way to handle
>       this situation, suggestions are welcomed.
> 
> Patch 14 add the dt-bindings for the PCF2131.
> 
> I have tested the driver using a PCF2131-ARD evaluation board connected to
> an NXP imx8mp evaluation board:
>   - Time get/set ok;
>   - Alarms get/set ok
>   - Timestamp 1 to 4 ok
>   - IRQ alarm ok
>   - Watchdog ok
>   - Also tested successfully with "RTC Driver Test Example" from
>     Documentation/rtc.txt
> 
> I have also tested the driver on a custom PCF2129 adapter board connected to a
> beaglebone black.
> 
> Thank you.
> 
> Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
> Link: [v2] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=285734
> 
> Changes for V3:
> - Rebased for kernel v6.1
> 
> Changes for V2:
> - In general, fix and improvements after I have tested on real hardware
> - Fix alarm interrupt A/B mask setting for PCF2131:
>   PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
> - Remove low_reg validation: only check if TS interrupt flag is
>   defined, as low_reg is defined at address 0 for PCF2127/29.
> - Change PWRMNG value for PCF2131: default is different than PCF2127/29.
> - Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
> - Map all interrupt sources to INT A pin
> - Read and validate PCF2131 device presence from RESET register
> - Adapt watchdog configuration for PCF2131
> 
> Hugo Villeneuve (14):
>   rtc: pcf2127: add variant-specific configuration structure
>   rtc: pcf2127: adapt for time/date registers at any offset
>   rtc: pcf2127: adapt for alarm registers at any offset
>   rtc: pcf2127: adapt for WD registers at any offset
>   rtc: pcf2127: adapt for CLKOUT register at any offset
>   rtc: pcf2127: add support for multiple TS functions
>   rtc: pcf2127: add support for PCF2131 RTC
>   rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
>   rtc: pcf2127: set PWRMNG value for PCF2131
>   rtc: pcf2127: read and validate PCF2131 device signature
>   rtc: pcf2127: adapt time/date registers write sequence for PCF2131
>   rtc: pcf2127: support generic watchdog timing configuration
>   rtc: pcf2127: add flag for watchdog register value read support
>   dt-bindings: rtc: pcf2127: add PCF2131
> 
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   4 +-
>  drivers/rtc/Kconfig                           |   4 +-
>  drivers/rtc/rtc-pcf2127.c                     | 939 ++++++++++++++----
>  3 files changed, 752 insertions(+), 195 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
