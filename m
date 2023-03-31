Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AC6D1FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjCaMLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCaMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:11:13 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109021C1E7;
        Fri, 31 Mar 2023 05:11:10 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE5866000C;
        Fri, 31 Mar 2023 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680264669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlFjaEgglGp4LuEAhX3Eu2KitorIUFC8QsINMFBMePg=;
        b=G/P7ooR673wIkTHXtogfVKLqLVvxP9iSUJhbBPA0jBi46ucYB/ay6zGFAPJvLQuYGeesZu
        G2qdWoQOTRtT1BDQy+evrDZKkBsap0H2FXS1Gibw54F/NakKab9Y8rij6uS9aQZggDlDk0
        m6eq3/XUqhFZLvfC7JL0KuPSeDkPaC1FyfzrtWgwWNGPMXzIRZCC9T1TQ9Xne3tJ30JBir
        MmANr3cLZNj/XOoOMcuI0W2qjQnHhXmskYvmpfDES1thXXFm5yugnbcwFbkR8K/Fi7CDeM
        7yUkr6oY/zFhHLJpqHEjQreBpihPohVWzp4Obk0FvbeWh71jMd6wIL7LmicBFw==
Date:   Fri, 31 Mar 2023 14:11:04 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/5] mfd: Add support for the Lantiq PEF2256 framer
Message-ID: <20230331141104.42445da9@bootlin.com>
In-Reply-To: <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
        <20230328092645.634375-3-herve.codina@bootlin.com>
        <20230330160510.GB489249@google.com>
        <20230331094208.41ab4420@bootlin.com>
        <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Lee

On Fri, 31 Mar 2023 11:13:30 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 31/03/2023 09:42, Herve Codina wrote:
> > Hi Lee,
> > 
> > On Thu, 30 Mar 2023 17:05:10 +0100
> > Lee Jones <lee@kernel.org> wrote:
> >   
> >> On Tue, 28 Mar 2023, Herve Codina wrote:
> >>  
> >>> The Lantiq PEF2256 is a framer and line interface component designed to
> >>> fulfill all required interfacing between an analog E1/T1/J1 line and the
> >>> digital PCM system highway/H.100 bus.    
> >>
> >> My goodness!
> >>
> >> It's been a long time since I've seen anything quite like this.  
> > 
> > Yes, old things but working on recent kernel.
> >   
> >>
> >> My suggestion to you:
> >>
> >> * Split this up into components that fit functional subsystems  
> > 
> > It is done. The audio part is present in ASoC subsystem (path 5 in this
> > series). pinctrl function is implemented in this driver and, as I don't
> > want to share registers, I would prefer to keep this function inside this
> > driver.  
> 
> The amount of defines and huge functions like pef2256_setup_e1()
> contradict it.
> 
> Even the pef2256_setup_e1() really does not follow Linux coding style -
> you know the size requirement, right?

I know that pef2256_setup_e1() is quite big and I will look at a way
to split it in a consistent way.

> 
> pef2256_get_groups_count, struct pinmux_ops and others - this is
> pinctrl, not MFD! They cannot be in MFD driver.

Maybe the issue is that MFD was not a good choice.
The "function" provided are not independent of each other.
The "main" driver (pef2256.c) needs to do the setup and handle the interrupt.
The "function" provided are some glues in order to be used in some sub-systems
such as audio. Indeed, ASoC needs a codec DAI to be connected to a CPU DAI.
These "functions" need to be started (ie probe()) after the pef2256 setup was
done. So a start (probe()) order relationship is needed.

If a MFD driver needs independent children to handle independent functions,
the pef2256 does not fit well as a MFD driver.

I switched from misc to MFD just to handle child DT nodes instead of having
phandles. Using child DT nodes instead of phandles is really a good thing and
need to be kept.
The switch to MFD was probably not the best thing to do.

What do you think if I switched back the pef2256 "main" driver (pef2256.c) to
misc ?


> 
> > 
> > Also, I sent a RFC related to HDLC and PHY. In this RFC, the pef2256 is
> > considered as a PHY and handled in the PHY subsystem.
> >   https://lore.kernel.org/linux-kernel/20230323103154.264546-1-herve.codina@bootlin.com/
> >   
> >> * Run checkpatch.pl  
> > 
> > I did.  
> 
> There are tons of weird indentation,e.g.:
> +#define     PEF2256_2X_PC_XPC_XLT	(0x8 << 0)
>         ^^^^ there is only one space after #define

I ran checkpatch.pl, not checkpatch.pl --strict.

The spaces related the #define can be seen on many other drivers.

#define FOO_REG_BAR	0x10
#define   FOO_REG_BAR_BIT0	BIT(0)
#define   FOO_REG_BAR_BIT4	BIT(4)

The first line is the register offset and the other lines (indented) are
the bits description related to this register.

> 
> ... and other style issues:
> 
> CHECK: Please don't use multiple blank lines
> CHECK: spaces preferred around that '+' (ctx:VxV)
> CHECK: Alignment should match open parenthesis
> CHECK: Macro argument reuse '_groups' - possible side-effects?
> CHECK: usleep_range is preferred over udelay; see
> Documentation/timers/timers-howto.rst
> CHECK: spaces preferred around that '/' (ctx:VxV)

I will have a look and fix them in the next iteration.

> 
> 
> >   
> >> * Remove all of the debug prints  
> > 
> > I can do that in the next iteration if really needed.
> >   
> >> * Move all of the defines out to a header file  
> > 
> > These defines are related to registers. As I don't want to share these
> > registers, is it really necessary to use a header file for them ?
> >   
> >> * Be more verbose in your documentation / comments  
> > 
> > I can improve the API documentation present in include/mfd/pef2256.h.
> > Do you thing that is necessary ? Only a few devices will use this API.
> >   
> Krzysztof
> 

Best regards,
Hervé
