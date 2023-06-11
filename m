Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7172B490
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFKWQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 18:16:19 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B5E4E;
        Sun, 11 Jun 2023 15:16:17 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686521775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KicQDi51QCgJrB94zDjmeXvEyj1WexYw2XIAkZsTagU=;
        b=Bg3FFq4z+LN3uDx0QYx6isOKDDG+0nHA83v1sJZhQysaFwUvQVRlOLZ/W4qZW+kOQ6BrHS
        yk+BVB0c4ywyOXKFJOG5ITx7t32uJNysR7y/I/+n6sYie/mKuBtUJ2yVc3ziGHxJAWxYKA
        RkeMaAjSLYX7vTKJIS8zGam+CyDBWpqrVx2SLJ97Xe095Fnm43zX9SHBzTEokoQxIoohGo
        sAf+/ePBjsV8U59q0Cj5k6+xvft61wLq2xVnseVqYQ8o4mwmne926U4YRhtNva/Nc/SjY5
        b3jSe5dP3kg1iSxD4cQ8GT5/NdjIZIxcAYwVqitgkJa0yXhyB8udrvrLHes5rw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72D3760004;
        Sun, 11 Jun 2023 22:16:15 +0000 (UTC)
Date:   Mon, 12 Jun 2023 00:16:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage
 via RTC_VL_BACKUP_LOW
Message-ID: <202306112216153a75dfa3@mail.local>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
 <202306111511569834cac2@mail.local>
 <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2023 18:28:22+0200, Jan Kiszka wrote:
> On 11.06.23 17:11, Alexandre Belloni wrote:
> > On 11/06/2023 15:38:04+0200, Jan Kiszka wrote:
> >> On 10.06.23 10:31, Alexandre Belloni wrote:
> >>> Hello Jan,
> >>>
> >>> On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> The VL bit in the seconds register remains set only until seconds are
> >>>> written under main power. As this often happens during boot-up after
> >>>> picking up a network time, make sure to preserve the low battery state
> >>>> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
> >>>>
> >>>> To permit userspace clearing this state during runtime, also implement
> >>>> RTC_VL_CLR that works against the cached state.
> >>>>
> >>>> This is emulating RTCs which have a battery voltage check that works
> >>>> under main power as well.
> >>>>
> >>>
> >>> Emulating doesn't work well and I deliberately chose to not implement
> >>> it. For example, in your scenario, if you boot twice without using
> >>> VL_READ, you anyway have lost the information. This makes emulating
> >>> unreliabl. The fix you need is in userspace where you have to ensure you
> >>> read the status before setting the time.
> >>
> >> Then let's make sure the bit is also set in the hardware register. Then
> >> also the reboot issue (which is practically a minor one) is solved. The
> >> current situation is far from optimal.
> > 
> > This doesn't work because then the time will be considered invalid. I'm
> > not sure why you don't want to fix your userspace.
> > 
> 
> Nope, that could be easily avoided in software. The actual problem is
> that the VL bit is not settable (clear-on-write). And that means we
> can't do anything about losing the low battery information across
> reboots - but that's no difference to the situation with the existing
> driver.
> 
> There is no "fix" for userspace as there is no standard framework to
> read-out the status early and retrieve it from there when the user asks
> for it. That's best done in the kernel.

That's not true, nothing prevents userspace from reading the battery
status before setting the time and destroying the information which is
exactly what you should be doing.

> 
> In that light, I still believe my patch is an improvement over the
> current situation without making anything worse.

The information goes from behaving deterministically to being unreliable
which makes the situation worse.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
