Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704506388AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKYLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKYLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:22:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4E140D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n7so6266008wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=pn54IrAg9BvGdpbmlmTu4g2JeVdd9hbFtNrFP2BoA2s=;
        b=CxcXVjwjK4O53Xsx4YzgKeQEGBU2MaHahr/zOMhAdXq/sVnoZdb23QDoGDzacEdWZ6
         Rlwbs2pHtNvE2W1+dPnxWGWL59DGt9iH4oZfc0sztwVn2bWaWVWwpbhBOvhnlQWpEcDW
         wBpQ4rj5BtaEqJ8B8Hc2MS94pFz6y8zsNBfwg1gGawhTj2B7gTb12UBAqjJW7Ux3Wn7N
         hJskj2x+HOGvCgjRHN7pFl3gbdx8vQi4J6ilaqAmNkx3tj8DTdJZ+55G40uRnTt8M/6O
         i5ZMbjBjoZldLlzQZfmHVKIbBnyhFPQnPyROsi3B7TgVR/xprXdMqdFhrTNXGg6Jub2+
         Q1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn54IrAg9BvGdpbmlmTu4g2JeVdd9hbFtNrFP2BoA2s=;
        b=wBCaoeiO+YQKqTQ0fXVySDpzzn671cQPwqnz1IVgmC8aJGy0fcWPeid5yA7rcP2Em4
         aQy7ZAaCtYrGvwy2IP2CVBIP/u4QWU+qfjSUshe4SQs7ptc6+iyWlOrywfbXs52PPBSf
         6auKwNG+LsDylhfoJjo4ps7lW301T0XkW0TNVswHIC0otZiubmzTWNqu1cCxwS1JUxRm
         UTSuoqal+mN1DI7C5TGn0s6RZRb0EeKb4/TN0bEeiXaOaXICExnagfzcTqYOwVLSbU0l
         hZytiFkBA6edrKXTkQDfTYb8J79Zt467rO52vIZ718fJg/PHz2/teXNoij8JdSr0CJrx
         U0mw==
X-Gm-Message-State: ANoB5pnKDe9RHMmd2OOzCctA6ktKbmO4o1YZYxfX8XEt4F9aiFOW8DDY
        C7VfbW/WOKq9mrgfDucUlLPWqw==
X-Google-Smtp-Source: AA0mqf5J1upCR0wwX6epG9BvfBXsPDWbg7ZhxcnvLJ7dj4mY2ZQicjacNyBf2f6pOKtwDPhaumPn2A==
X-Received: by 2002:a05:6000:1088:b0:22e:4a4e:b890 with SMTP id y8-20020a056000108800b0022e4a4eb890mr14732078wrw.554.1669375366508;
        Fri, 25 Nov 2022 03:22:46 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id m6-20020adfc586000000b002366fb99cdasm3538269wrg.50.2022.11.25.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:22:45 -0800 (PST)
References: <20221110150035.2824580-1-adeep@lexina.in>
 <1jk03y37vs.fsf@starbuckisacylon.baylibre.com>
 <c31cc8a3-8adc-3e93-f6fe-73cd7482429d@lexina.in>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Vyacheslav <adeep@lexina.in>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx
Date:   Fri, 25 Nov 2022 11:28:17 +0100
In-reply-to: <c31cc8a3-8adc-3e93-f6fe-73cd7482429d@lexina.in>
Message-ID: <1j7czj2s8r.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 24 Nov 2022 at 09:22, Vyacheslav <adeep@lexina.in> wrote:

> Hi!
> Thanks for reply. Sorry for delay.
>
>
> 13.11.2022 23:06, Jerome Brunet wrote:
>> On Thu 10 Nov 2022 at 18:00, Vyacheslav Bocharov <adeep@lexina.in> wrote:
>> 
>>> The mmc driver use the same phase values (core - 180, tx/rx - 0) for all
>>> meson64 platforms. However, some platforms (and even some boards) require
>>> different values
>> Where does it stops ? Trying to solve the instabilities of this
>> IP/driver by tweaking the phase has proven to be dead-end.
>
> As a result, there is now a stalemate and various real-world operating
> system projects use patches to change clock phases.
>

The current setting has seen its fair share of "real world"
testing too, before being applied. 

It does need more work, sure. It does not make what is proposed here
appropriate.

>
>> Soon, you'll end up tweaking these settings depending on the on
>> particular version of the device because it ships with a different eMMC
>> manufacturer. Then comes multi sourcing, sdio modules, sdcards ...
>> 
>>> (axg for example use 270 degree for core clock).
>> Where ? Upstream linux does not
>
> Armbian/Home Assistant OS use core phase 270 for axg/g12/sm1 boards
> (patches by Neil). On JetHub devices phase 270 is need with eMMC more than
> 16Gb size.

Size has nothing to do with this. Few boards electing to do something
else does justify making this a DT config. It just shows the controller
still need work.

>
>> u-boot does something of the sort for sm1 and I'm not entirely sure this
>> appropriate either.
>
> U-boot in Armbian/HAOS use same phase 270 or/and force low speed mode for
> eMMC (limit clock freq).
>
>> IMO, this setting has more to do with the mode the mmc device is
>> operating at - not the platform or board.
>> We had some discussions with the HW designers at AML and they recommended
>> to keep a phase shift of 180 between the Core and Tx. They also
>> recommended to leave Rx alone (actually, starting from the v3, the Rx
>> field has no effect. It is not even wired to actual HW)
>
> I do not have access to AML engineers :)
> I can only test settings on several different boards. And it seems that the
> phase settings depend not only on the board layout, but also on the eMMC
> chip used.

What are you going to do when a manufacturer does multi-sourcing then
? Make one DT per PCB/eMMC chip combination ? It is wrong and does not scale.

> What to do about this (if not to use the magic of the driver
> from AML) other than providing the ability to change the value in
> devicetree for each board I can't think of yet.
>
>> Funnily, that is not what the vendor driver does. It also does A LOT of
>> extremely complex and 'debatable' things, which mostly mask how much the
>> driver is unstable.
>
> As far as I understand they just go through all possible values until the
> first successful attempt to initialize the device.
> What do you think of the idea to implement such a variant for the meson-gx
> driver?

What the amlogic driver does are overly complex computation to get a tuning
value, which is then contiously cycled (in the IRQ handler!!) while silently
retrying failed transaction behind MMC core's back

That's far from being desirable.

>
>> With the upstream drivers, modes up to SDR50 and HS200 have been stable
>> lately. SDR104 and DDR modes (DDR52 or HS400) remains problematic.
>
> I have troubles with HS200, for example:
> Card Type [CARD_TYPE: 0x57]
>  HS200 Single Data Rate eMMC @200MHz 1.8VI/O
>  HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O
>  HS eMMC @52MHz - at rated device voltage(s)
>  HS eMMC @26MHz - at rated device voltage(s)
>

That does not says with which mode or at which stage the problem occurs

>> Changing the settings further would require more discussion with AML.
>> Blindly poking these value until you get something stablish for 1
>> particular use case is a recipe for disaster.
>
> I assumed the idea that the dts are edited by the maintainers or the board
> developers and will be able to choose the values themselves.
>

And eventually, we'll end-up telling people to adjust the phases
depending of the sdcard they insert ... This does not work for me.

I understand the will to get this working at full speed. I've spent A
LOT more time than would have wanted in this driver, trying to do
exactly that. There is quite an history about that on this list
detailing why changes have been made.

It was stable(ish) for while. Now we are getting more reports of
problems. This (again) shows this need more work. It also shows there
are still things we don't know about this controller and this where it
gets tricky because there is high risk of causing regressions with each
change.

Let's leave Rx (which has no effect) and Tx out for now.

My guess is the core phase might need to be adapted depending on
* Mode: It seems the DDR modes are done by making the controller run
  faster then diving the output clock by 2. This divider might
  mess up the phase shift needed.
* Speed: Maybe there is delay contraint between the input clock and the
  core and we need at adapting the phase shift depending on the rate ?

I think what could be tried - with a LOOONG RFT giving a chance people
to report regressions - is:
* Defaulting the Core phase to 270: Despite AML HW engineer
  recommendation, this is what the vendor code does. Maybe this will help
  with board that seems to require 270 to start.
  I know if stays for all modes, it will cause problems
1) Set 180 when switching to DDR modes
2) Wether switching to 180 for high speed SDR modes (UHS, HS200) is
   required, or not, is a bit unclear. If the problem is the internal
   divider, it should not be required. If the problem is the delay,
   maybe it is.

>
>> 
>>> This patch
>>> transfers the values from the code to the variables in the device-tree files.
>>> If not set in dts, use old default values.
>> I think going that way is opening a big can of worms.
>> I don't think this should be applied
>> 
>>>
>>> Vyacheslav Bocharov (4):
>>>    arm64: amlogic: mmc: meson-gx: Add core, tx, rx eMMC/SD/SDIO phase
>>>      clock settings from devicetree data
>>>    arm64: amlogic: mmc: meson-gx: Add dts binding include for core, tx,
>>>      rx eMMC/SD/SDIO phase clock settings from devicetree data
>>>    arm64: amlogic: dts: meson: update meson-axg device-tree for new core,
>>>      tx, rx phase clock settings.
>>>    arm64: dts: docs: Update mmc meson-gx documentation for new config
>>>      option amlogic,mmc-phase
>>>
>>>   .../bindings/mmc/amlogic,meson-gx.txt         |  7 ++++
>>>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  3 ++
>>>   drivers/mmc/host/meson-gx-mmc.c               | 18 +++++++---
>>>   include/dt-bindings/mmc/meson-gx-mmc.h        | 35 +++++++++++++++++++
>>>   4 files changed, 58 insertions(+), 5 deletions(-)
>>>   create mode 100644 include/dt-bindings/mmc/meson-gx-mmc.h
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

