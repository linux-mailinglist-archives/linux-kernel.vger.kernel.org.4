Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1164B2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiLMJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiLMJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:52:06 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6415FE2;
        Tue, 13 Dec 2022 01:52:05 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-14455716674so11887549fac.7;
        Tue, 13 Dec 2022 01:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6JN3Qjucx6D9wkdyo0PHdHqF86xZNo3ZNxYxpXMaii0=;
        b=Ldx8CoWhrhmaw5RibJySEpFVNKyYC40NFx5s1aLsbMuHqvgE9jVrCXOv0PrqgRU+S2
         SmDFZZhm8gTbU1dyhZTuHXVtqI2EB4TQ5t7Foo3b69q3yySNLCZgkq7OfrofAyMqrkQz
         YG7Pubx13jaBCxyfP0fdZebAFFTE06niPBTt6CBYLkL8v3N80+aPZX9qMpwQarQOOjOp
         mCe7NOcnCkyMWl5ikdG9XJLtlLiacjGmUxcQITiUlOLkZRc2wzDXskHxNM0nrvwHR8AS
         2WNkmCxAfQ9gkI+vKGJoyFjSMN7gjeRidf+ohXXaxyKTKptEbOkJp7IN1Bpi2ny4pNik
         Ej4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JN3Qjucx6D9wkdyo0PHdHqF86xZNo3ZNxYxpXMaii0=;
        b=wr3qbv8ltlJ+FhmHpBNs/Etz6bD59sQ3lCvY1Qr1BsUmcua6xDLBKOJkCEzNs/dqMt
         U5bk8u281TVFTdO1xm7anKuWw9PH0g+AZ/bEuoofFf3FdxesmP3WnBvpBOkJrqQgd06u
         pI7r5onvNgoiW6l1LAJ/vgx67c7k0ledVlYYxqVbWLIYocEnc/2wudzO3vXEaz0uQ34j
         9r4OkPi7HBvX7Bg4tzREk4/dTNt6jzXh5CQj9j9E9rzvl7akGLozXkZ5VgwbEC3mZQ5e
         563oDY06rZ+8PAOXiCgCNTukxOHWQg5DPx8BGBcGP4mNj8Gcx7fzUkAfoPJH1/oHll7T
         4T9w==
X-Gm-Message-State: ANoB5pmpdGHnE4Qo+ulQ8bwFqSwzwVcJimIdw+v1wetIXSgPm3yCJ0Ce
        Y9m8/3Es64O0EbNFUko8VlYkZVJKreqw7fUSFYY=
X-Google-Smtp-Source: AA0mqf4oSHCRC1jqlEhnVTPVF3UADvFkLA8qspX8MebavTsi8Vyf9sBy24b3zLEuO4EjOSS3Vw9KfvXtlHjXuJSPhZ4=
X-Received: by 2002:a05:6870:d204:b0:148:3e0:cb8b with SMTP id
 g4-20020a056870d20400b0014803e0cb8bmr191374oac.288.1670925125072; Tue, 13 Dec
 2022 01:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20221207040904.582585-1-gch981213@gmail.com> <Y5g/9ETxQEVOqB5d@duo.ucw.cz>
In-Reply-To: <Y5g/9ETxQEVOqB5d@duo.ucw.cz>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 13 Dec 2022 17:51:53 +0800
Message-ID: <CAJsYDVK850L3qtPAwcwQ4oZCo+JrSq0=QA33RtiRTk5v6CSj6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] leds: add driver for SPI driven WorldSemi WS2812B
 RGB LEDs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Dec 13, 2022 at 5:03 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > This patch adds support for driving a chain of WS2812B LED chips
> > using SPI bus.
> >
> > WorldSemi WS2812B is a individually addressable LED chip that
> > can be chained together and controlled individually using a
> > single wire. The chip recognize a long pulse as a bit of 1 and
> > a short pulse as a bit of 0. Host sends a continuous stream
> > of 24-bits color values, each LED chip takes the first 3 byte
> > it receives as its color value and passes the leftover bytes to
> > the next LED on the chain.
> >
> > This driver simulates this protocol using SPI bus by sending
> > a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
> > frequency needs to be 2.105MHz~2.85MHz for the timing to be
> > correct and the controller needs to transfer all the bytes
> > continuously.
>
> Is this the same thing as NeoPixel? If so, that may be better-known
> name.

NeoPixel is the name used by Adafruit for WS2812B based LED
strips. Even though that name may be better-known, this driver
is for the WS2812B LED chips, not for the specific Adafruit
products made using those chips. So I think it's more appropriate
to go with worldsemi,ws2812b instead of NeoPixel for the driver
name.

-- 
Regards,
Chuanhong Guo
