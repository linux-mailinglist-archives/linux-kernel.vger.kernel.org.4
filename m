Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067096D2353
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjCaO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjCaO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:11 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52981A24B;
        Fri, 31 Mar 2023 07:59:07 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0393DFF80E;
        Fri, 31 Mar 2023 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680274746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v716jqJtSMTkwli2R/cxVa2KhfQunAioMV9kYubIKks=;
        b=cBv/p9pJf8AgZMkcwkOnLL1o1MnBsWFtMeO2xvgtcczn74NxS5OXLtJJad4wtmZbgydAWZ
        saeDkVAKb+UTF3BPFMkfql9IBWgtnMhko9ebXLofpc6QktK5F7atY1OxxxAtYA3fW1PZTa
        ZpoeVkyl+bacg47gZGjzrXD8qU7U3KrEpZjvrq4T2lAac2b4COgtRmUENhoHA0NECzw2St
        jZpSjGjiZc8P6H6Ql992C+OKkP22RLi8plz4vkozutvHNhkgl+1zBEAi0hrFTR2bb1SsNE
        oiD6ZEIu48E9ESKzdyetV1YoVNwHjan8EbuT5N42KSQn4NJb3yqzQSeqk3zz1A==
Date:   Fri, 31 Mar 2023 16:59:04 +0200
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
Message-ID: <20230331165904.4e7f46a1@bootlin.com>
In-Reply-To: <a642e653-e3e2-c3d2-68cb-1efc92be05bb@linaro.org>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
        <20230328092645.634375-3-herve.codina@bootlin.com>
        <20230330160510.GB489249@google.com>
        <20230331094208.41ab4420@bootlin.com>
        <6d39e9c3-fb6a-4b2a-9889-8fe8d86716d5@linaro.org>
        <20230331141104.42445da9@bootlin.com>
        <a642e653-e3e2-c3d2-68cb-1efc92be05bb@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 15:44:19 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 31/03/2023 14:11, Herve Codina wrote:
> > Hi Krzysztof, Lee
> > 
> > On Fri, 31 Mar 2023 11:13:30 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 31/03/2023 09:42, Herve Codina wrote:  
> >>> Hi Lee,
> >>>
> >>> On Thu, 30 Mar 2023 17:05:10 +0100
> >>> Lee Jones <lee@kernel.org> wrote:
> >>>     
> >>>> On Tue, 28 Mar 2023, Herve Codina wrote:
> >>>>    
> >>>>> The Lantiq PEF2256 is a framer and line interface component designed to
> >>>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
> >>>>> digital PCM system highway/H.100 bus.      
> >>>>
> >>>> My goodness!
> >>>>
> >>>> It's been a long time since I've seen anything quite like this.    
> >>>
> >>> Yes, old things but working on recent kernel.
> >>>     
> >>>>
> >>>> My suggestion to you:
> >>>>
> >>>> * Split this up into components that fit functional subsystems    
> >>>
> >>> It is done. The audio part is present in ASoC subsystem (path 5 in this
> >>> series). pinctrl function is implemented in this driver and, as I don't
> >>> want to share registers, I would prefer to keep this function inside this
> >>> driver.    
> >>
> >> The amount of defines and huge functions like pef2256_setup_e1()
> >> contradict it.
> >>
> >> Even the pef2256_setup_e1() really does not follow Linux coding style -
> >> you know the size requirement, right?  
> > 
> > I know that pef2256_setup_e1() is quite big and I will look at a way
> > to split it in a consistent way.
> >   
> >>
> >> pef2256_get_groups_count, struct pinmux_ops and others - this is
> >> pinctrl, not MFD! They cannot be in MFD driver.  
> > 
> > Maybe the issue is that MFD was not a good choice.
> > The "function" provided are not independent of each other.
> > The "main" driver (pef2256.c) needs to do the setup and handle the interrupt.  
> 
> Just like all PMICs...
> 
> > The "function" provided are some glues in order to be used in some sub-systems
> > such as audio. Indeed, ASoC needs a codec DAI to be connected to a CPU DAI.  
> 
> Just like in all other cases...
> 
> > These "functions" need to be started (ie probe()) after the pef2256 setup was
> > done. So a start (probe()) order relationship is needed.  
> 
> Just like in all other cases, so I really do not see here anything special.
> 
> > 
> > If a MFD driver needs independent children to handle independent functions,
> > the pef2256 does not fit well as a MFD driver.  
> 
> Why? So far everything is exactly the same.
> 
> > 
> > I switched from misc to MFD just to handle child DT nodes instead of having
> > phandles. Using child DT nodes instead of phandles is really a good thing and
> > need to be kept.  
> 
> Your DT bindings and nodes are not related to driver design. It does not
> matter for Devicetree if you put it to misc or MFD.
> 
> It does not matter for driver whether you call it in Devicetree foo or bar.
> 
> > The switch to MFD was probably not the best thing to do.  
> 
> Maybe, but your existing arguments are not really related...
> 
> > 
> > What do you think if I switched back the pef2256 "main" driver (pef2256.c) to
> > misc ?  
> 
> Why? What would it solve? You want to stuff pinctrl driver to misc, to
> avoid Lee's review? No. Pinctrl goes to pinctrl. Not to misc. Not to MFD.

Just to be clear on that point, I do not want to avoid any reviews and Lee's
reviews are fully welcome.

I just misunderstood. I thought the issue was that the pef2256 MFD driver has an
internal setup() and that the 'function' provided were not independent (they share
the pef2256 API).
My first feeling was that it was expected a kind of 'empty' driver for the pef2256
MFD driver. The pef2256 driver cannot be empty. That's why I talk about misc.

Related to pinctrl, the probe() orders need to be controlled but that would not be
an issue if I move the pinctrl part to pinctrl. I would like also to avoid
exporting all registers. Only the pinctrl part needs to access registers and
it needs to access a few of them.

Is there a way to restrict the registers available from a child ?

Best regards,
Hervé

> 
> > 
> >   
> >>  
> >>>
> >>> Also, I sent a RFC related to HDLC and PHY. In this RFC, the pef2256 is
> >>> considered as a PHY and handled in the PHY subsystem.
> >>>   https://lore.kernel.org/linux-kernel/20230323103154.264546-1-herve.codina@bootlin.com/
> >>>     
> >>>> * Run checkpatch.pl    
> >>>
> >>> I did.    
> >>
> >> There are tons of weird indentation,e.g.:
> >> +#define     PEF2256_2X_PC_XPC_XLT	(0x8 << 0)
> >>         ^^^^ there is only one space after #define  
> > 
> > I ran checkpatch.pl, not checkpatch.pl --strict.
> > 
> > The spaces related the #define can be seen on many other drivers.
> > 
> > #define FOO_REG_BAR	0x10
> > #define   FOO_REG_BAR_BIT0	BIT(0)
> > #define   FOO_REG_BAR_BIT4	BIT(4)
> > 
> > The first line is the register offset and the other lines (indented) are
> > the bits description related to this register.  
> 
> I don't think we have such convention in general and argument that some
> drivers do it in some subsystems is never a good argument. If they also
> misspell things or use Hungarian notation, shall we do the same?
> 
> Although maybe it is fine for Lee. I find it unreadable.
> 
> git grep '#define  \+[A-Z]' | wc -l
> 73889
> git grep '#define [A-Z]' | wc -l
> 3996054
> 
> In MFD there is only one driver doing this.
> 
> Most of other cases are net and gpu.
> 
> 
> Best regards,
> Krzysztof
> 
