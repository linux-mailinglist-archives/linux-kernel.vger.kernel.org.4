Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BD678082
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjAWPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjAWPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:51:16 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E225B15579;
        Mon, 23 Jan 2023 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NUL1k+cRqfVAdbMVsWp+Lo232x8JL5WAzfWWE9/fP8o=; b=x+88pgiTTsW88CDxMJkinwhpdT
        r7r4SFelsD+8KbOwzNts5mMF+L6CY6xDwo7/az1VnoiaEoJXE7XK3mCZsgilH28sO1cSS9oCZWg6r
        K5yBo3UfWOyOCZ4/Dtqm2Ya+/FvQWSDJrnaZHFNrGK1ZKSdgvgaqme5r8VzlwbgJpsyI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41484 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pJz64-0002KT-Kc; Mon, 23 Jan 2023 10:51:01 -0500
Date:   Mon, 23 Jan 2023 10:51:00 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123105100.b799ad316f27396d62c88a89@hugovil.com>
In-Reply-To: <Y8rl452Xm1FrnFfF@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <Y8rl452Xm1FrnFfF@mail.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 00/14] rtc: pcf2127: add PCF2131 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 20:05:07 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> I know I've been holding off on the review of this series for a while
> and I'm sorry for that.
> 
> One of the main issue that is remaining is that the driver ends up being
> 53% bigger and generaly less efficient for no added functionality for
> the existing RTCs.

Hi Alexandre,
that is why before submitting my driver I sent an RFC on the RTC mailing list to ask what was the better approach for developping this driver (separate or merged into pcf2127), but I didn't got an answer from any of the maintainers.

> I know performance is not a concern however, having more code in the
> set/read time and irq paths means that it is more difficult to set an
> get the time precisely.

Just some ideas about that...

Looking at pcf2127_rtc_read_time(), we now do a separate read operation of CTRL3 to check for a low voltage condition. And we only display a message if the battery is low (no abort of read time). Looking at pcf8523 driver for example, this check is done only when responding to an ioctl. Could we do the same in our driver?

Another scheme I say is in rtc-ab-b5ze-s3 driver where this detection is done at startup and using the BLF interrupt flag...

> I guess I'll take it as a merged driver but I took a different decision
> for other RTCs.

I'll address all the comments/issues Bruno and you found and submit a V4 soon then.

Thank you, Hugo.


> On 15/12/2022 10:02:01-0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Hello,
> > this patch series adds the driver for the PCF2131 real-time clock.
> > 
> > This RTC is very similar in functionality to the PCF2127/29 with the
> > following differences:
> >   -supports two new control registers at offsets 4 and 5
> >   -supports a new reset register
> >   -supports 4 tamper detection functions instead of 1
> >   -has no nvmem (like the PCF2129)
> >   -has two output interrupt pins instead of one
> >   -has 1/100th seconds capabilities (not supported in this driver)
> >   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
> >    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
> >   -watchdog value register cannot be read after being set
> > 
> > Most of the register addresses are very different, although they still
> > follow the same layout. For example, the time/date and tamper registers
> > have a different base address, but the offsets are all the same.
> > Consequently, the source code of the PCF2127 driver can be easily adapted
> > to support this new device.
> > 
> > Patches 1 to 6 modify the existing pcf2127 driver to make it more generic
> > and able to support multiple variants, like the PCF2131. This is done
> > mostly by using offsets instead of absolute hardcoded register addresses.
> > 
> > Patch 7 add actual support for the PCF2131.
> > 
> > Patch 8 configures all interrupt sources to go through the INT A pin.
> > 
> > Patch 9 changes the PWRMNG bits to be the same with the PCF2131 as they
> >       are with the PCF2127/29 (different default values).
> > 
> > Patch 10 allow to confirm PCF2131 device presence by reading the reset
> >       register fixed pattern.
> > 
> > Patch 11 adapt the time/date registers write sequence for PCF2131 (STOP and
> >       CPR bits).
> > 
> > Patch 12 add support for generic watchdog timing configuration.
> > 
> > Patch 13 add a new flag to identify if device has read support for reading
> >       watchdog register value.
> >       Since the watchdog value register cannot be read on the PCF2131 after
> >       being set, it seems that we cannot detect if watchdog timer was
> >       started by bootloader. I am not sure what is the best way to handle
> >       this situation, suggestions are welcomed.
> > 
> > Patch 14 add the dt-bindings for the PCF2131.
> > 
> > I have tested the driver using a PCF2131-ARD evaluation board connected to
> > an NXP imx8mp evaluation board:
> >   - Time get/set ok;
> >   - Alarms get/set ok
> >   - Timestamp 1 to 4 ok
> >   - IRQ alarm ok
> >   - Watchdog ok
> >   - Also tested successfully with "RTC Driver Test Example" from
> >     Documentation/rtc.txt
> > 
> > I have also tested the driver on a custom PCF2129 adapter board connected to a
> > beaglebone black.
> > 
> > Thank you.
> > 
> > Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
> > Link: [v2] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=285734
> > 
> > Changes for V3:
> > - Rebased for kernel v6.1
> > 
> > Changes for V2:
> > - In general, fix and improvements after I have tested on real hardware
> > - Fix alarm interrupt A/B mask setting for PCF2131:
> >   PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
> > - Remove low_reg validation: only check if TS interrupt flag is
> >   defined, as low_reg is defined at address 0 for PCF2127/29.
> > - Change PWRMNG value for PCF2131: default is different than PCF2127/29.
> > - Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
> > - Map all interrupt sources to INT A pin
> > - Read and validate PCF2131 device presence from RESET register
> > - Adapt watchdog configuration for PCF2131
> > 
> > Hugo Villeneuve (14):
> >   rtc: pcf2127: add variant-specific configuration structure
> >   rtc: pcf2127: adapt for time/date registers at any offset
> >   rtc: pcf2127: adapt for alarm registers at any offset
> >   rtc: pcf2127: adapt for WD registers at any offset
> >   rtc: pcf2127: adapt for CLKOUT register at any offset
> >   rtc: pcf2127: add support for multiple TS functions
> >   rtc: pcf2127: add support for PCF2131 RTC
> >   rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
> >   rtc: pcf2127: set PWRMNG value for PCF2131
> >   rtc: pcf2127: read and validate PCF2131 device signature
> >   rtc: pcf2127: adapt time/date registers write sequence for PCF2131
> >   rtc: pcf2127: support generic watchdog timing configuration
> >   rtc: pcf2127: add flag for watchdog register value read support
> >   dt-bindings: rtc: pcf2127: add PCF2131
> > 
> >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   4 +-
> >  drivers/rtc/Kconfig                           |   4 +-
> >  drivers/rtc/rtc-pcf2127.c                     | 939 ++++++++++++++----
> >  3 files changed, 752 insertions(+), 195 deletions(-)
> > 
> > -- 
> > 2.30.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
