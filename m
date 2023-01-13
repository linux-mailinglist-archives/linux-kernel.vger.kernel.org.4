Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D23668F31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjAMHYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjAMHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:23:44 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A522972886;
        Thu, 12 Jan 2023 23:14:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2210F80FA;
        Fri, 13 Jan 2023 07:14:32 +0000 (UTC)
Date:   Fri, 13 Jan 2023 09:14:30 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI
 support for OMAP1/2 chips
Message-ID: <Y8EE1qQ3uArtYc+w@atomide.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
 <Y7/YiMPIDN0Cf5Ky@atomide.com>
 <c9821df0-cd3e-43a0-b903-430d1251d51c@app.fastmail.com>
 <20230112140524.GK730856@darkstar.musicnaut.iki.fi>
 <179739a0-5d75-412b-964b-16d5cb6d306d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179739a0-5d75-412b-964b-16d5cb6d306d@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [230112 14:31]:
> On Thu, Jan 12, 2023, at 15:05, Aaro Koskinen wrote:
> > On Thu, Jan 12, 2023 at 11:19:53AM +0100, Arnd Bergmann wrote:
> >> On Thu, Jan 12, 2023, at 10:53, Tony Lindgren wrote:
> >> 
> >> So if we want to kill off the old DMA stuff there is actually
> >> a choice between either making omap_udc PIO-only or converting
> >> it to use the standard dmaengine interface.
> >
> > I use this driver on Palm TE and 770, and without it those boards would
> > be useless for my use cases. Also DMA doubles the throughput, probably
> > also power usage is smaller.
> 
> Ok, if the performance is important, converting to dmaengine
> is probably best. Do you know if this is just a straightforward
> replacement of the function calls, or are there technical reasons
> why it's not using the dmaengine interface yet?

Yes I agree dmaengine is the best solution. Seems like this is the
last driver using the old api that never got updated probably because
it's not used on the newer SoCs.

I don't think there are any technical reasons to not use dmaengine
here.

FYI, the last blocker for dmaengine use was for drivers using
port_window that got added with the drivers/usb/musb/tusb6010_omap.c
dmaengine conversion a few years back.

Regards,

Tony
