Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60B55FD965
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJMMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJMMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:44:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD4123457
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:43:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu30so2632858wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFL+3ZqTNQ0jAeQ0BPwipAbFLiwXOxlfEp1/HJDetMI=;
        b=VoFnV5SLcBBiz1iP+USM4ERmiHztM1qhrWGXXnzA+n2JphKF/PV3WP+tQLfo1V/WZg
         zrz4XrSeAIXscbce56til+dnXxsIBQvyjXz25AKnWwsibpdbOYz6i3phpcERiiT/E0Vx
         RSfIly/JkROs2RGIJR4ULYzq66mEUCBYWOp8uPRXN/ZoXcEl1JId6yrz3/ImqBzGJhfu
         Hji1PMqS4lUxFG9/VVIItVo9ahiZb2wI5iI7aJgtA/61CS137qs7f+a/DX3Ht/QnVRVW
         NiHH7jX2C0b4RVzQUhAKH5tzhhUO4mmdcOdWMz6baykUUDB9B6+BHntcngAkQITyfi6J
         KO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFL+3ZqTNQ0jAeQ0BPwipAbFLiwXOxlfEp1/HJDetMI=;
        b=D9tNiuHRgWyB6wCYDo8Ow6Bq93ytAtGg1MvUjQ3G8fjTOYd2fmYKv7id6un1B9Cj6x
         gnes+BZnpkkfkwl4c87u0FML+HDY70OJGHB230fsH3NVcSK1PPniv1f4ir1NDXrzRUDS
         7lty5NPc3PCDO4LzuNloew/U6g0aJy3ingid3x/vwNQpYMedumc9lbjr+NDmkTXj8/u0
         HJNQDzMO2n2J93ebRrEJLF3hfS23J1Rn+HfXRrpRCHuaX7xQbV+78gxv4sDy1RQmK5J0
         ACVSyvBHT1755W0UOF1jGAv2QkArF4H7nt5SOvGOknbBbr83N9spO5r7Nbhcs0eXmxwj
         573Q==
X-Gm-Message-State: ACrzQf2ArtQ/w0+6Eoc8N2U0Vl0LfVsy8hovdGssvGqQI1RQz9dMrv8Z
        skHRoMk2V/n26hz+zuOapOHQ1A==
X-Google-Smtp-Source: AMsMyM4wXATrnUjeGnfBevz2YqoW6F0UBPLgNZxr7qyXYH6BLvynxwwy3ThKFM67S9PZfcNv00HhJg==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr20624644wrs.632.1665665034607;
        Thu, 13 Oct 2022 05:43:54 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u3-20020a056000038300b00231910fa71asm1912596wrf.57.2022.10.13.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:43:54 -0700 (PDT)
Date:   Thu, 13 Oct 2022 13:43:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
Message-ID: <Y0gICNqed+55mwuX@maple.lan>
References: <YzN6A9Y20Ea1LdEz@google.com>
 <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan>
 <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
 <YzyZJSwy9xsy69WL@google.com>
 <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
 <Yz6oS/zdNIOEtWxI@maple.lan>
 <CACRpkdYdZaxSGy+YiexKtffKvUEr5dcu3g=1zY3Tfhv5WMDtew@mail.gmail.com>
 <Y0ck3jopU+Z74xqn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0ck3jopU+Z74xqn@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:34:38PM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 10, 2022 at 10:36:00PM +0200, Linus Walleij wrote:
> > On Thu, Oct 6, 2022 at 12:05 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Thu, Oct 06, 2022 at 11:03:15AM +0200, Linus Walleij wrote:
> > > > On Tue, Oct 4, 2022 at 10:35 PM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > > > Dmitry, could you fix this? Just patch away in gpiolib-of.c.
> > > > >
> > > > > Sure, I'll add a few quirks. I wonder what is the best way to merge
> > > > > this? I can create a bunch of IBs to be pulled, or I can send quirks to
> > > > > you/Bartosz and once they land send the patches to drivers...
> > > >
> > > > When I did it I was sufficiently convinced that I was the only one patching
> > > > the quirks in gpiolib-of.c that merge window so I just included it as
> > > > a hunk in the driver patch. If there will be some more patches to that
> > > > file I guess some separate patch(es) for gpiolib-of.c is needed, maybe
> > > > an immutable branch for those if it becomes a lot.
> > >
> > > Are renames likely to be a common quirk on the road to libgpiod
> > > conversion?
> > >
> > > I admit I sort of expected it to be common enough that there would be
> > > one rename quirk in the code supported by an alphabetized string table.
> > > Such a table would certainly still provoke troublesome merges but ones
> > > that are trivially resolved.
> >
> > Dmitry added a table of sorts, the problems are usually a bit unique
> > for each instance of nonstandard DT GPIO bindings, that's why I
> > mostly solved it with open coding in gpiolib-of.c.
>
> OK, so I sent out the patch adding "reset-gpios" -> "gpios-reset"
> translation quirk to keep compatibility with the legacy names, but
> we still need to figure out what to do with incorrect line polarity
> in current DTses in tree. Unlike with names we have no indication
> if out of tree DTSes specify correct polarity or not, so we can't
> reasonably come up with workarounds that are guaranteed to work for
> everyone. I see several options:
>
> 1 the driver could continue ignoring line polarity specified in DTS
>   (and use gpiod_set_value_raw()) and hope that they all/will be
>   wired in the same way?
>
> 2 we could fix up in-kernel DTSes, allow flexibility of connection
>   in new designs and respect polarity specified in out of tree DTSes,
>   but accept that there can be breakages with old DTSes not contributed
>   to the mainline or DTSes that were "cached" from an older kernel
>   release
>
> 3 add another quirk forcing "active low" polarity for the legacy
>   "gpios-reset" name, which will allow us respecting polarity in
>   new "reset-gpios" name.

I don't think they is any point in having a rename if legacy DTs break
anyway! Thus if there is a rename then there should also be an active low
quirk applied when the old name is used.


Daniel.
