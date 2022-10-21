Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226356076EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJUMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:29:55 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10A15806F;
        Fri, 21 Oct 2022 05:29:51 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 120F724000F;
        Fri, 21 Oct 2022 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666355390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8JhSCsc0VPJJFxWJqi6lXg1VFcKEqMx4JafSN8dRwc=;
        b=PPYGKJqlyoSe2ReNc/ywYJuUZA6K8KevIZhATbt/WsOjPCH6ZlFOYynN+ujHcbuTP8UlAW
        16z9NMp7+Ik6PS9ALEqTkfV1D9i6EMwGmw5CUoj1jIVLohaFehBmAiuYYs1LrMbALCFDZi
        I4kRjyfPb3hteYukHnDrLotrrVqsrFCIsSRIkTFIXVzRYohsnahn/zLEBNdgB9AjS60jEP
        EoJ0FFmXCtvAmPr2v0Kg+phZ1McBLOjtDaTlAqM15Qh6gxP1UwJtmwkhrYJVZnUFSQ/n2K
        iP/XulJYW8C9utf0+UH0w7SLw51qUJVW2g4pEY7pUGAWTV6opMugDzDuTFhjAA==
Date:   Fri, 21 Oct 2022 14:29:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Message-ID: <Y1KQvPAwh7NC0wbA@mail.local>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com>
 <Y1G6FIvS6WD57GXW@mail.local>
 <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR03MB62477670C186E6CC5308B600962D9@DM8PR03MB6247.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 11:44:12+0000, Tilki, Ibrahim wrote:
> > > +  interrupt-names:
> > > +    description: |
> > > +      Name of the interrupt pin of the RTC used for IRQ. Not required for
> > > +      RTCs that only have single interrupt pin available. Some of the RTCs
> > > +      share interrupt pins with clock input/output pins.
> > > +    minItems: 1
> > > +    items:
> > > +      - enum: [INTA, INTB]
> > > +      - enum: [INTA, INTB]
> > > +
> > 
> > I don't think this is right, what this is doing is essentially pinmuxing
> > interrupts versus clocks. What happens if you want INTB but this goes
> > directly to a PMIC instead of the SoC?
> > It is not something you can express with your current bindings.
> > 
> 
> Why would a user want INTB when it is not connected to SoC?
> User can specify none, either one or both of the interrupt pins.
> I don't see what the problem here is.
> 

the interrupt pin may be connected to a PMIC that is able to start or
wake up the platform. In that case, the user would not have any
interrupt-names and your driver will fail to mux the interrupt on INTB.
Please fix.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
