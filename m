Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5401D689174
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBCH7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjBCH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:59:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4173B2CFDC;
        Thu,  2 Feb 2023 23:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE07B61DDF;
        Fri,  3 Feb 2023 07:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4917C4339C;
        Fri,  3 Feb 2023 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675411149;
        bh=RFMh9JQe5gZqAYMKWVlZ1rif3I6fWu+fu4Ee8wsnX24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRIaYAsK7qJNAKlYSBh1hhla8cvfcrHGJyiPkVnUug1IW4mOY8+kOHVq3buNsNqtU
         SsgPgUFnkCF/bdpjys8bcNYiZSxNKOKftB4EtyOnzI1a13BRNaq+hl8S8vx6nwQF7D
         KL7IYz1KD0ApiFCfFPpuqxXPQwMDs1d6dvn9OcsL7doOYMN8A8A+PY1/NyfcVIeJjF
         IxZ7qUmI3+sDv1HXAVmU2YiMk8UAoGzdiDEuSrtqhENTLIJ2zigXFRhGyTtw58Pp8+
         k4TiQhcXHJvoUOsuerK6CeYGilJeFtz1/oKMlsqzYOpNAE+Olxp4vhII8G8MrnVQgz
         SzRNbnlpXA4Bw==
Date:   Fri, 3 Feb 2023 07:59:04 +0000
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y9y+yOa1gxy3h+rG@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y8mv8PzL1UsP9gNh@google.com>
 <20230202205704.12a5fbff@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202205704.12a5fbff@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023, Henning Schild wrote:

> Am Thu, 19 Jan 2023 21:02:40 +0000
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Fri, 07 Oct 2022, Henning Schild wrote:
> > 
> > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > later. If there is no driver to provide that pin we will poll
> > > forever and also create a lot of log messages.
> > > 
> > > So check if that GPIO driver is configured, if so it will come up
> > > eventually. If not, we exit our probe function early and do not even
> > > bother registering the "leds-gpio". This method was chosen over
> > > "Kconfig depends" since this way we can add support for more
> > > devices and GPIO backends more easily without "depends":ing on all
> > > GPIO backends.
> > > 
> > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > > of Siemens driver") Reviewed-by: Andy Shevchenko
> > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > <henning.schild@siemens.com> ---
> > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > >  1 file changed, 2 insertions(+)  
> > 
> > FYI: I'm going to try my best not to take another one like this.
> 
> You will not have to. I now understood how to improve on that as i am
> adding more variants needing more gpio controller drivers.
> 
> > Please try to improve the whole situation for you next submission.
> > 
> > Applied, thanks.
> 
> I hope this is still in the branches for a merge. It should be applied.
> It does fix a problem but using a wrong pattern, but a pattern that is
> already in use.

What makes you think it's not applied?
 
> So this will fix 6.1 and above in the short term.
> 
> In the long term i will restructure to individual drivers which have a
> clear dependency chain in Kconfig. I will use inheritance to arrive at
> minimal code duplication and will use Kconfig switch default
> inheritance to ease configuration.
> 
> Such restructuring patches will have to be written first, but they will
> come. Either stand-alone or together with the next machine.

That's fine.  Whatever suits.

-- 
Lee Jones [李琼斯]
