Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88EE5F641B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJFKFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJFKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:05:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E22610F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:05:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so1914830wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpK3HEcxibyqFugwFNWtBIn86oNeXCvN7BKqOHswlgA=;
        b=uM9HzOePGDYNdUPbTWeUMjWdVjHoYjfTzPNWnmhbIC2Dhp6WhbxLT0x1Esu4jsEx7a
         FJ6zSC7wCuoO3ldP54UZRiOKr7mvVvlW6wEVDZ5ExF9PkKoIojrSYFA1MtZ//aKbzmgT
         o+oRefRmk2W8wNIfOVrHJ+yM/YXcRvyDjNsGiTMal7GH/mIb3F3sKFYhgsBFXxiUdrK6
         UnlnNC+OI7WD1PMUaWI9dXh9TLuY0MGdHMuu9FSCH3mZKCK3Q5xYf2R8UaLrAMCbjGH6
         0D8Rl7YIdomaevqqy0/4aWRzanIWQ75az3z611q+NiPJo4M/oklXDDNkxTIEQLp1BGFl
         lcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpK3HEcxibyqFugwFNWtBIn86oNeXCvN7BKqOHswlgA=;
        b=BnunJm0mIvvXw6sYpeZC9ZJPW2VFY+RLP1JGlSbf2o4du1YqHfNp3Rsd+Kmw7slYKy
         1FplJ1tYR+8rG405L8A8Gxzb/Wh+aL7BvhJMKbWDsXHtLNfIT6TdePUPYxb8+RSLKwlP
         ROTDnq23OgVLqB3CxbUarb0tH8ch54YVJHgGxGoP66vXxQYSQCuJHlWthzgKnjgTWttz
         p7hlk7nUZGUsyQpsYVpwlQ1WZK6EljluucoY22aD867YSDtbvMHkcAP3XGX6z7sg2iVH
         8axWsqTdY41kxMrJc5QyKufbe3/OktyeEFVsb3WYc1QJO31dDIB+8QS0mM+M2Z42kCX1
         LCrg==
X-Gm-Message-State: ACrzQf123KMt/SuNm8enpsdLKXl1pkDLy8/vNtVOGUtx9cSt/anwSodh
        OUCKtcfDS7AjV7sy8+cCXz6/sQ==
X-Google-Smtp-Source: AMsMyM7CJ6PtzzkeBzex4HDz66ngkKYtXQI1uZDi5YTDtwdhQ98N9OpHJt69/dNHNbzqRDYjr/FdAA==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b1:faf7 with SMTP id f2-20020a5d64c2000000b0022e41b1faf7mr2433214wri.428.1665050701841;
        Thu, 06 Oct 2022 03:05:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y9-20020a5d4ac9000000b0021badf3cb26sm22098016wrs.63.2022.10.06.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:05:01 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:04:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Message-ID: <Yz6oS/zdNIOEtWxI@maple.lan>
References: <YzN6A9Y20Ea1LdEz@google.com>
 <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan>
 <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
 <YzyZJSwy9xsy69WL@google.com>
 <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:03:15AM +0200, Linus Walleij wrote:
> On Tue, Oct 4, 2022 at 10:35 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>
> > > Dmitry, could you fix this? Just patch away in gpiolib-of.c.
> >
> > Sure, I'll add a few quirks. I wonder what is the best way to merge
> > this? I can create a bunch of IBs to be pulled, or I can send quirks to
> > you/Bartosz and once they land send the patches to drivers...
>
> When I did it I was sufficiently convinced that I was the only one patching
> the quirks in gpiolib-of.c that merge window so I just included it as
> a hunk in the driver patch. If there will be some more patches to that
> file I guess some separate patch(es) for gpiolib-of.c is needed, maybe
> an immutable branch for those if it becomes a lot.

Are renames likely to be a common quirk on the road to libgpiod
conversion?

I admit I sort of expected it to be common enough that there would be
one rename quirk in the code supported by an alphabetized string table.
Such a table would certainly still provoke troublesome merges but ones
that are trivially resolved.


Daniel.
