Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F35E8BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiIXLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIXLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:42:41 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F9115F51
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:42:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D3E42FF806;
        Sat, 24 Sep 2022 11:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664019758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhYx+mUA0owcFn9yFdKn4/95n9UVkSvpbtcV0Fc5BEQ=;
        b=ORM8Ah0Wk8YvxiPWmQ67Zgevs6PsbkhxocFmGXa9gFNChy+qxKkAm4Y3DHeO5fbjybX2Bc
        CEtqG5MCisUs/PqXlvy/6Pb/NTedx6X/8Q/COZkHGzfeVpoEDj/ZDtAASUXGsch2iSes29
        JNLdmMRrf6bil/SNDL7dMpR7sBUXrwUWyitwRV6pIyITC95ycuZzyFeClkHVmiK268aW8b
        xIYK2Kw7d4K9c1gQZZJvKUmKWg2E6jb26sJ1naauD4+9M9wzV8LpsreCOowlu/nDuBBK8M
        AEGcxCDCdflycUNwbm8Ch4l7NBRJ+pigXV9SbazZW4Gt3hspHAmvGyT5qEN6rg==
Date:   Sat, 24 Sep 2022 13:42:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Message-ID: <Yy7tLRcMaKeet9An@mail.local>
References: <Yy6d7TjqzUwGQnQa@penguin>
 <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 10:33:29+0200, Arnd Bergmann wrote:
> On Sat, Sep 24, 2022, at 8:04 AM, Dmitry Torokhov wrote:
> > This patch switches the driver to use newer gpiod API instead of legacy
> > gpio API. This moves us closer to the goal of stopping exporting
> > OF-specific APIs of gpiolib.
> >
> > While at it, stop using module-global for regmap.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> This looks good to me overall. Three comments:
> 
> > @@ -63,7 +62,7 @@ struct at91_cf_socket {
> > 
> >  static inline int at91_cf_present(struct at91_cf_socket *cf)
> >  {
> > -	return !gpio_get_value(cf->board->det_pin);
> > +	return gpiod_get_value(cf->board->det_pin);
> >  }
> 
> a) The change in polarity looks wrong here, I can't really tell
> from the patch. If this is intentional, maybe explain it in
> the changelog. With that addressed (either way)
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> b) In case you are doing more patches like this one at the moment,
> note that I'm in the process of removing all unused board files
> for arch/arm/, which will in turn make a lot of drivers unused.
> I should be able to provide a branch soon, which can be used to
> identify drivers that don't have DT support any more and don't
> have any board files. Rather than converting them to gpio
> descriptors, we can probably just remove those drivers.
> 
> c) I'm not sure about the state of the at91_cf driver. Apparently
> we used to have three drivers for the same hardware (pcmcia,
> pata and ide), and only the pcmcia driver remained in the tree
> after drivers/ide/ was removed and pata_at91 did not get converted
> to DT. I think in the long run we will remove the pcmcia layer,
> so if you are actually trying to use this hardware, we may want to
> revive the pata variant and drop this one instead.
> There is no dts file in tree that actually declares either of them,
> so chances are that nobody is actually using the CF slot on at91
> any more.
> 

I'm pretty sure it is broken since eaa9a21dd14b ("pcmcia: at91_cf: Use
syscon to configure the MC/smc") as this change has never been tested.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
