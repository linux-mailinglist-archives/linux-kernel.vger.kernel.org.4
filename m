Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6036F679530
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjAXK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAXK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:29:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89636402FD;
        Tue, 24 Jan 2023 02:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67BA60B29;
        Tue, 24 Jan 2023 10:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4CC433D2;
        Tue, 24 Jan 2023 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674556180;
        bh=EzT56XQJOL6STtbWMJM7SuwaIPlurSVkp9kmAZZvnMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7Ik92Z3A522198ucGebLAKbV4YXT+qeqhqzWwMk1gM7EC3VFp6bKAjOXsDcc8DkH
         dKmc9wgFdRQTIvVMTZI+mHOvYr3ekZmrqvRFFSUtEMk+VJcxo3R0AS74OeyhJvn5r9
         wJ6lmkLfBz+duc+ckwcxHWD7+Yt3wU0snoJ3ANTnXW44uEy5SjdPncznt73JXOh1DE
         aNnk3nEHLyUO82KBhrERoxi+ZX8KU2x/o6kWR6xA5kowNMAQGl28I8Zn2Us+6rhv3g
         SfHGbMHItipSJrI9NjnNE5xrJztIltWWFz+qKKFBesNDFHrfNv14R+ms7/7ub2TgZI
         KlJCFi8mq5WKA==
Date:   Tue, 24 Jan 2023 10:29:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y8+zD6AxuJVy5b7Y@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y8mv8PzL1UsP9gNh@google.com>
 <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
 <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023, Andy Shevchenko wrote:

> On Mon, Jan 23, 2023 at 10:49 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Thu, 19 Jan 2023 21:02:40 +0000
> > schrieb Lee Jones <lee@kernel.org>:
> > > On Fri, 07 Oct 2022, Henning Schild wrote:
> 
> > > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > > later. If there is no driver to provide that pin we will poll
> > > > forever and also create a lot of log messages.
> > > >
> > > > So check if that GPIO driver is configured, if so it will come up
> > > > eventually. If not, we exit our probe function early and do not even
> > > > bother registering the "leds-gpio". This method was chosen over
> > > > "Kconfig depends" since this way we can add support for more
> > > > devices and GPIO backends more easily without "depends":ing on all
> > > > GPIO backends.
> > > >
> > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > > > of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > <henning.schild@siemens.com> ---
> > > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > FYI: I'm going to try my best not to take another one like this.
> >
> > understood!
> >
> > > Please try to improve the whole situation for you next submission.
> >
> > When i have to touch this again, which i will, i will propose either
> > "depend on all possible GPIO drivers" or introduce "#ifdef CONFIG"s.
> > Caring most about big configs as seen in distros like debian, even for
> > embedded systems ... i think i would prefer the first option, as it
> > will also be easier to maintain.
> >
> > I do not see the whole infinite loop story on my plate, but if that got
> > fixed i would follow up taking the fix into account.

I still don't really know what you mean by this.  Probe deferring should
not work this way.  Do you know why the loop is infinite on your
platform?  What keeps triggering the re-probe?  Are you continually
binding and unbinding drivers, forever?  Also, what is printing out the
failure?  Maybe it should be silent?

> AFAICS another possible (not sure if it's preferable) solution is to
> split this driver to subdrivers and each of them will be dependent on
> the corresponding pin control in Kconfig. It will satisfy both of your
> requirements, right? Something like
> 
> simatic-leds-core.c
> simatic-leds-127e.c (config ..._127E depends on PINCTRL_BROXTON)

In theory, yes it would.  You could also introduce a core driver to
contain all of the shared code.  Duplication would also be a travesty.

-- 
Lee Jones [李琼斯]
