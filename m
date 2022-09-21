Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9895BF74A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIUHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiIUHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:12:16 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6D3D581;
        Wed, 21 Sep 2022 00:12:10 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1284C000B;
        Wed, 21 Sep 2022 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663744329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPV61B8fcJib1mvJP+g7glWnejDZkZxpKL+a1xKlpbM=;
        b=kyrfLl9Uhdn67c6A1JzrK3qRcgAQSCwpJpdFXnHFAcS9FOUVPtsIgLJIpiswpsK2X5Ohck
        Xm6DuWcCmoLZeSWY6uRxafAIkLT07Xm4VYJ7MTGjYq5cT+L+osQTaEg1toB2oROKZEoaVk
        iIcOdt0dl21rHNviLBD4B9kf3o7OJC606Qq6C61UFwA9gUxYzMJcSu3QYcfxRrcAnefTBh
        U8z5aBt3O/k5hPII6ArndGre9Xqtlxm8oG5tpqp9dGCG2wMVx7Q1xo1fD6pv+aDbWz2FgX
        VgIfx0JOm0aweqvsWJ3cxsC6/7aFEngujAVs1hIIddk0K1ubfC5U67phKfwuHg==
Date:   Wed, 21 Sep 2022 09:12:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rtc: isl12022: simplify some expressions
Message-ID: <Yyq5SEDjaimLpy/B@mail.local>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-3-linux@rasmusvillemoes.dk>
 <YyHugb47cJPNuHbs@mail.local>
 <4fdd52c9-2de7-b86b-f081-cb59a8f72c5a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdd52c9-2de7-b86b-f081-cb59a8f72c5a@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 09:08:52+0200, Rasmus Villemoes wrote:
> On 14/09/2022 17.08, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 30/08/2022 12:01:48+0200, Rasmus Villemoes wrote:
> >> These instances of '&client->dev' might as well be spelled 'dev', since
> >> 'client' has been computed from 'dev' via 'client =
> >> to_i2c_client(dev)'.
> >>
> >> Later patches will get rid of that local variable 'client', so remove
> >> these unnecessary references so those later patches become easier to
> >> read.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  drivers/rtc/rtc-isl12022.c | 11 +++++------
> >>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> >> index 2dc19061cf5f..5e6bb9153c89 100644
> >> --- a/drivers/rtc/rtc-isl12022.c
> >> +++ b/drivers/rtc/rtc-isl12022.c
> >> @@ -112,13 +112,13 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >>  		return ret;
> >>  
> >>  	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
> >> -		dev_warn(&client->dev,
> >> +		dev_warn(dev,
> > 
> > While at it, I would prefer that one to also become a dev_dbg
> 
> Well, I prefer to keep it, because my customer actually wants to use
> this information. Grepping it out from dmesg is of course not the best
> interface, but if it gets demoted to a dev_dbg() it doesn't even get there.
> 

There is a proper userspace interface, look for RTC_VL_READ.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
