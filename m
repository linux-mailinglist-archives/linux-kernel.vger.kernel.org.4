Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD2747249
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGDNIY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjGDNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:08:22 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7F10C3;
        Tue,  4 Jul 2023 06:08:21 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-579ed2829a8so30240347b3.1;
        Tue, 04 Jul 2023 06:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476100; x=1691068100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkpYMVU8rJa52DI8rHfrIhMR4F2XjuGdUJqnXmGYafs=;
        b=VQkeHNWVeWsqoMCX3ewQzxiNBXnzSrDBPkJ/XRmy28Je+d5xuswW37Et/lXQM7Ff70
         nAt+8QvNu1IUIiq3zYSTNF/EwMeB/EAePicQgO+iFgqfrgo17ZndRnAJkoXRpAuhFR0L
         oCHBJau4ETcvgwvA2kk0ZYY3ol7wdgtHJw5wJTNRbJPxuqXCOVdQozo7JUEeXyEYBJ8E
         Y6jQOYSCxsD5EyWLqB2lo/pd1/wpdGo1Orm/SC5NZdTKNbdJZmgPXmD4FGgj1y236PQw
         OqdYyNnttVJxOTuzzLU+98ASitPdbK5R0sfLelpHlDxJL18VLWUn9yOxGffV26cYQo3l
         +wpw==
X-Gm-Message-State: ABy/qLZNcaoqaxglwmFmKY2tq39xmaiE3HbU0zkMBxip5R+h0vkiy+IO
        achilVmquR6XwuMWZoC/z6jgIe6oTdPDQQ==
X-Google-Smtp-Source: APBJJlH7TjiocYPogCuAiLoxaMpxJGnTf8Hn8lS3FHstSHR4rF09GpvLJl1mr+U6af/6sGPX/fXYUg==
X-Received: by 2002:a25:9a48:0:b0:c2c:1b68:99b4 with SMTP id r8-20020a259a48000000b00c2c1b6899b4mr11387097ybo.13.1688476100677;
        Tue, 04 Jul 2023 06:08:20 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id z12-20020a5b0a4c000000b00bceb538a275sm370839ybq.21.2023.07.04.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:08:19 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5701810884aso60600097b3.0;
        Tue, 04 Jul 2023 06:08:19 -0700 (PDT)
X-Received: by 2002:a25:ce4f:0:b0:bc8:f082:2301 with SMTP id
 x76-20020a25ce4f000000b00bc8f0822301mr13920562ybe.6.1688476099296; Tue, 04
 Jul 2023 06:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-6-sebastian.reichel@collabora.com> <CAMuHMdWRoNXrkD8ty4pUpFA-qQCMVF3wzXTCHFW4jYSy+dXivg@mail.gmail.com>
 <20230630184833.o3lgqrtqzzwgb7nk@mercury.elektranox.org>
In-Reply-To: <20230630184833.o3lgqrtqzzwgb7nk@mercury.elektranox.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 15:08:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVFFt84nESQRgBergcdgfyoO4Bx3jxrjc=3cXfoW2Bjw@mail.gmail.com>
Message-ID: <CAMuHMdVVFFt84nESQRgBergcdgfyoO4Bx3jxrjc=3cXfoW2Bjw@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Jun 30, 2023 at 8:48 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Fri, Jun 30, 2023 at 01:34:44PM +0200, Geert Uytterhoeven wrote:
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1183,12 +1183,17 @@ config MFD_RC5T583
> > >           Additional drivers must be enabled in order to use the
> > >           different functionality of the device.
> > >
> > > -config MFD_RK808
> > > +config MFD_RK8XX
> > > +       bool
> >
> > Is there any specific reason why this cannot be modular, like most (all?)
> > of its users that select it?
>
> I don't remember why I made that bool. Tristate should be perfectly
> fine. Do you want to send a patch (I will test it of course), or should
> I take care of it?

I have sent a patch.
https://lore.kernel.org/r/d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
