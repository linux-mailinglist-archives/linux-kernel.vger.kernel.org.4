Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AA637252
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKXGXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:23:04 -0500
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683B27CDF;
        Wed, 23 Nov 2022 22:22:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 647292AB88;
        Thu, 24 Nov 2022 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1669270976; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=Jtkb8FsWa/xNXgK1fxfSzbSkqlyxfm+DrIrqY+1P7xA=;
        b=excDdHXccoor+/ly4WQAAdddOMnCppJSjYZ+UA68KkBk4+F+Esr1QzonlhXwo3wqbMPIXM
        GruVSUr6XCcxMvp6Efwj8YRh8iaurZhlF3GgaSCTHF/n7gChplhO3nykIx/s0+5buDsGs+
        F7MARCewOgtRQZerb7SnMwfLfsxYEQKoKfHATh+4f312E6cLn+Xcmyk1HI8dDGnr6Yd4u4
        FZU1D+GKOg+JWS9J0cqkf/qLNUObfdUcIXY5xgHsi0IyQ9drhM1aOsJQLCMaPjHLep+S69
        KLENDe2wfgvLG8MeBRxYY3GsMn6nivs0vSpt19OGGG4chbWUwQxOrGyo5m8QDw==
Message-ID: <c31cc8a3-8adc-3e93-f6fe-73cd7482429d@lexina.in>
Date:   Thu, 24 Nov 2022 09:22:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx
Content-Language: en-MW
To:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20221110150035.2824580-1-adeep@lexina.in>
 <1jk03y37vs.fsf@starbuckisacylon.baylibre.com>
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <1jk03y37vs.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Thanks for reply. Sorry for delay.


13.11.2022 23:06, Jerome Brunet wrote:
> 
> On Thu 10 Nov 2022 at 18:00, Vyacheslav Bocharov <adeep@lexina.in> wrote:
> 
>> The mmc driver use the same phase values (core - 180, tx/rx - 0) for all
>> meson64 platforms. However, some platforms (and even some boards) require
>> different values
> 
> Where does it stops ? Trying to solve the instabilities of this
> IP/driver by tweaking the phase has proven to be dead-end.

As a result, there is now a stalemate and various real-world operating 
system projects use patches to change clock phases.


> 
> Soon, you'll end up tweaking these settings depending on the on
> particular version of the device because it ships with a different eMMC
> manufacturer. Then comes multi sourcing, sdio modules, sdcards ...
> 
>> (axg for example use 270 degree for core clock).
> 
> Where ? Upstream linux does not

Armbian/Home Assistant OS use core phase 270 for axg/g12/sm1 boards 
(patches by Neil). On JetHub devices phase 270 is need with eMMC more 
than 16Gb size.

> 
> u-boot does something of the sort for sm1 and I'm not entirely sure this
> appropriate either.

U-boot in Armbian/HAOS use same phase 270 or/and force low speed mode 
for eMMC (limit clock freq).

> 
> IMO, this setting has more to do with the mode the mmc device is
> operating at - not the platform or board.
> 
> We had some discussions with the HW designers at AML and they recommended
> to keep a phase shift of 180 between the Core and Tx. They also
> recommended to leave Rx alone (actually, starting from the v3, the Rx
> field has no effect. It is not even wired to actual HW)

I do not have access to AML engineers :)
I can only test settings on several different boards. And it seems that 
the phase settings depend not only on the board layout, but also on the 
eMMC chip used. What to do about this (if not to use the magic of the 
driver from AML) other than providing the ability to change the value in 
devicetree for each board I can't think of yet.

> 
> Funnily, that is not what the vendor driver does. It also does A LOT of
> extremely complex and 'debatable' things, which mostly mask how much the
> driver is unstable.

As far as I understand they just go through all possible values until 
the first successful attempt to initialize the device.
What do you think of the idea to implement such a variant for the 
meson-gx driver?

> 
> With the upstream drivers, modes up to SDR50 and HS200 have been stable
> lately. SDR104 and DDR modes (DDR52 or HS400) remains problematic.

I have troubles with HS200, for example:
Card Type [CARD_TYPE: 0x57]
  HS200 Single Data Rate eMMC @200MHz 1.8VI/O
  HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O
  HS eMMC @52MHz - at rated device voltage(s)
  HS eMMC @26MHz - at rated device voltage(s)

> 
> Changing the settings further would require more discussion with AML.
> Blindly poking these value until you get something stablish for 1
> particular use case is a recipe for disaster.

I assumed the idea that the dts are edited by the maintainers or the 
board developers and will be able to choose the values themselves.


> 
>> This patch
>> transfers the values from the code to the variables in the device-tree files.
>> If not set in dts, use old default values.
> 
> I think going that way is opening a big can of worms.
> I don't think this should be applied
> 
>>
>> Vyacheslav Bocharov (4):
>>    arm64: amlogic: mmc: meson-gx: Add core, tx, rx eMMC/SD/SDIO phase
>>      clock settings from devicetree data
>>    arm64: amlogic: mmc: meson-gx: Add dts binding include for core, tx,
>>      rx eMMC/SD/SDIO phase clock settings from devicetree data
>>    arm64: amlogic: dts: meson: update meson-axg device-tree for new core,
>>      tx, rx phase clock settings.
>>    arm64: dts: docs: Update mmc meson-gx documentation for new config
>>      option amlogic,mmc-phase
>>
>>   .../bindings/mmc/amlogic,meson-gx.txt         |  7 ++++
>>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  3 ++
>>   drivers/mmc/host/meson-gx-mmc.c               | 18 +++++++---
>>   include/dt-bindings/mmc/meson-gx-mmc.h        | 35 +++++++++++++++++++
>>   4 files changed, 58 insertions(+), 5 deletions(-)
>>   create mode 100644 include/dt-bindings/mmc/meson-gx-mmc.h
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Vyacheslav Bocharov
