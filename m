Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFB5BFA45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIUJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIUJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:10:12 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2A28275A;
        Wed, 21 Sep 2022 02:10:10 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BB987C0010;
        Wed, 21 Sep 2022 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663751409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ed895OQapn/M3xAe79KVEVKJiuKmtlhG0e7JAHU5JmY=;
        b=GBiOx+KG4nNKCT6sffO7R3pMwdALAyLzwOkjnEMsgGe01yESURAco7zPqgDY8shNZUbrkc
        m6NyxElQViRi0SUeBUSWvV/32fXLk4e5AN8X2RzLKbdZwZhnzzB7ysof5Xnc4ikHbXawLX
        z31wq1VbPMN2jnUVDsHPnPOxTkIbVY9K0MhrMqrHwPeqW2gfMegCVSQfRFYA6E1r1ze0IL
        Eqn/PzQRdU7ivtqt/ZLUSDrnIcTkb9T60C0JeuwRRjRizyeLAFekQWoakhs5J2tYRQRQAe
        l59AkiAqq3eg0gfEUhID59/2juRmtJZCq7zdti7Lnr18G4dGCpNXxwVO9iCMuQ==
Date:   Wed, 21 Sep 2022 11:10:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 6/6] rtc: isl12022: add support for temperature sensor
Message-ID: <YyrU7+/vQvVYEYCv@mail.local>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-7-linux@rasmusvillemoes.dk>
 <YyHvXh1Zhy/wsHsD@mail.local>
 <5602da22-613e-1be9-42e8-c39b8d60f465@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5602da22-613e-1be9-42e8-c39b8d60f465@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 09:58:16+0200, Rasmus Villemoes wrote:
> On 14/09/2022 17.12, Alexandre Belloni wrote:
> > On 30/08/2022 12:01:52+0200, Rasmus Villemoes wrote:
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  drivers/rtc/rtc-isl12022.c | 81 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 81 insertions(+)
> >>
> >> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> >> index b295ec92ee17..1bd72f436318 100644
> >> --- a/drivers/rtc/rtc-isl12022.c
> >> +++ b/drivers/rtc/rtc-isl12022.c
> >> @@ -17,6 +17,8 @@
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/regmap.h>
> >> +#include <linux/hwmon.h>
> >> +#include <linux/hwmon-sysfs.h>
> > 
> > You should keep that list ordered
> 
> While the three lines of context happen to be sorted, the list as a
> whole is not. I can of course include a patch sorting it.
> 

Nevermind then


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
