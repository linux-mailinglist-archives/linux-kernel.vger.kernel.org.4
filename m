Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB216DB2EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDGSgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDGSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:36:51 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B093C8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:36:49 -0700 (PDT)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 260eab40-d573-11ed-abf4-005056bdd08f;
        Fri, 07 Apr 2023 21:36:46 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 7 Apr 2023 21:36:45 +0300
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Message-ID: <ZDBivYlwJ6zgaFTg@surfacebook>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
X-Spam-Status: No, score=3.2 required=5.0 tests=DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Apr 07, 2023 at 03:48:25PM +0200, Linus Walleij kirjoitti:
> On Wed, Apr 5, 2023 at 3:57 PM Michael Walle <michael@walle.cc> wrote:
> 
> > OTOH I'm not sure the driver is doing it correctly, because it also
> > seems to switch the pullup resisters together with the direction.
> > I'm not sure that is correct. So there might be just one register
> > involved after all and the GPIO_REGMAP should work again.
> 
> I'm pretty sure that should be in the .set_config() callback.
> 
> > Also, according to the datasheet this has some nv memory (to set the
> > initial state of the GPIOs [?]). So it should really be a multi-function
> > device. I'm not sure if this has to be considered right from the
> > beginning or if the device support can start with GPIO only and later
> > be transitioned to a full featured MFD (probably with nvmem support).
> 
> That's a bit of a soft definition.
> 
> If the chip is *only* doing GPIO and nvram it can be a GPIO-only
> device I think.
> 
> The precedent is a ton of ethernet drivers with nvram for storing
> e.g. the MAC address. We don't make all of those into MFDs,
> as the nvram is closely tied to the one and only function of the
> block.

I agree with Linus. This should be part of the actual (main) driver for
the chip as many do (like USB to serial adapters that have GPIO capability).
Also this code lacks of proper locking and has style issues.

-- 
With Best Regards,
Andy Shevchenko


