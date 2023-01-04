Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAC65D58C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjADOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjADOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:24:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922938AE7;
        Wed,  4 Jan 2023 06:24:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA31B6174F;
        Wed,  4 Jan 2023 14:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD8C433EF;
        Wed,  4 Jan 2023 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842275;
        bh=Tvw/x+3j2FJAWZR3JbN82C07+AuFNwia8+xecuq+n7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKnYONBubZJiYy6kZ8vRWQ/SbAeQv9KoLLlPxd9bWLvQIoTy1BlvGVcZlAy3fwaq8
         z5bzWeviSu+dbwbSPiCg8TWN1h0dUcAlNJpnl9nNdqiPO1P5fau758TiuvtSspQ98D
         +vJit1TLPZwQjmk7e5vdRuAVu6loCrA1Nt8mRzJzB6JeDn/eQSVu4ZP5/mXiii59Jx
         Tnrkor/SEYD3++iM14vWT5Tm4d0ZoUHa3B6Ke/0SXLkkd8cakxD5yFF7ZnDs4FOsD9
         lWCCyBPzRvzfU19lmLdqe6Hp77AJmMEaF40AShtrNdVnsYQwMc7zXYnsBy3P6Pdj/B
         usLzYJDtDbNRQ==
Date:   Wed, 4 Jan 2023 14:24:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y7WMHl1Mv1alXadG@google.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y6WX1Y9GZmvxqlCc@google.com>
 <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
 <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Henning Schild wrote:

> Am Mon, 2 Jan 2023 16:22:27 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
> > Am Fri, 23 Dec 2022 11:58:13 +0000
> > schrieb Lee Jones <lee@kernel.org>:
> > 
> > > On Fri, 07 Oct 2022, Henning Schild wrote:
> > >   
> > > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > > later. If there is no driver to provide that pin we will poll
> > > > forever and also create a lot of log messages.
> > > > 
> > > > So check if that GPIO driver is configured, if so it will come up
> > > > eventually. If not, we exit our probe function early and do not
> > > > even bother registering the "leds-gpio". This method was chosen
> > > > over "Kconfig depends" since this way we can add support for more
> > > > devices and GPIO backends more easily without "depends":ing on all
> > > > GPIO backends.
> > > > 
> > > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO
> > > > version of Siemens driver") Reviewed-by: Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > > <henning.schild@siemens.com> ---    
> > > 
> > > What happened in versions 1 through 3?  Please provide a
> > > change-log.  
> > 
> > Not too much really, but i will write a changelog and cover letter
> > when sending again. Mostly commit message stuff and later a rebase.
> 
> Lee please let me know if you insist on that changelog, in which case i
> would send that same patch again with a cover-letter that will carry a
> not too spectacular changelog.
> 
> Or get back on the rest of what i wrote earlier, maybe we need another
> version of the patch and not just the same one again with only a
> changelog added.

The change-log is not the issue, and you don't need to provide a
cover-letter for a single-patch set.

The issue is that this 'solution' is a hack, built on a hack, built on a
hack.  There shouldn't be a requirement to check Kconfig options from
this driver.  In an ideal world the thread handling the -EPROBE_DEFER
would not create spurious logs to trouble anyone.  What is it that's
writing those logs?  A User or Kernel Space thread?  Dependencies are
almost universally controlled with Kconfig 'depends', which is how this
problem should really be solved.

Taking into consideration the large backlog (nearly 100) of reviews I
need to do and the fact that there is already a precedent for this
behaviour inside this file, I'm tempted to apply it; however, I shall not
be doing so without giving myself (and others) a little more time to
think it over.

--
Lee Jones [李琼斯]
 
