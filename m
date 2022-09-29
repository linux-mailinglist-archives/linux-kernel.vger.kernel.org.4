Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784045EF319
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiI2KMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI2KMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:12:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D011497A1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:12:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3E5021C09;
        Thu, 29 Sep 2022 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664446360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9csrttS1u7dS43wZTmDCRyS86K0Uo6jdxqCmerZvvc=;
        b=nwb+DVpI0KvS4d4BNZ637BpZl6+psHRaKEdWeFdHS5y6bweRXRVdSs2tM7j+iPUTCGzUM3
        IkGirSJJkMJ8lCn1a7bnfu1wVQyYha4B0aEGpS/tcHscEVqCv3Xo9+GygzPndqYMb5CYvC
        q/yNLgt+raTD9FZZr7tFw7mZLZqaaL0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B4B672C149;
        Thu, 29 Sep 2022 10:12:39 +0000 (UTC)
Date:   Thu, 29 Sep 2022 12:12:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Conor Dooley <conor@kernel.org>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [resend][bug] low-probability console lockups since 5.19
Message-ID: <YzVvl+rv3iZS9vxk@alley>
References: <Yy3dsSgpDnovBdEn@spud>
 <YzR8fzyjhggO+/tT@spud>
 <98f62903-3d6f-30b4-82ef-3b0460824907@leemhuis.info>
 <YzVlYaUPcRmlfE7c@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzVlYaUPcRmlfE7c@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-09-29 10:29:05, Conor Dooley wrote:
> On Thu, Sep 29, 2022 at 11:06:01AM +0200, Thorsten Leemhuis wrote:
> > Hi Conor
> > 
> > On 28.09.22 18:55, Conor Dooley wrote:
> > > On Fri, Sep 23, 2022 at 05:24:17PM +0100, Conor Dooley wrote:
> > >>
> > >> Been bisecting a bug that is causing a boot failure in my CI & have
> > >> ended up here.. The bug in question is a low(ish) probability lock up
> > >> of the serial console, I would estimate about 1-in-5 chance on the
> > >> boards I could actually trigger it on which it has taken me so long
> > >> to realise that this was an actual problem. Thinking back on it, there
> > >> were other failures that I would retroactively attribute to this
> > >> problem too, but I had earlycon disabled
> > 
> > There is one thing I wonder when skimming this thread: was there maybe
> > some other change somewhere in the kernel between the introduction and
> > the revert of the printk console kthreads patches that is the real
> > culprit here that makes existing, older races easier to hit? But I guess
> > in the end that would be very hard to find and it's easier to fix the
> > problem in the console driver... :-/
> 
> Entirely possible that something arrived in the middle, yeah. I've done
> 100s of reboots on that interim section, albeit with the threaded
> printers enabled, as I restarted the bisection several times & never hit
> this failure then.

Interesting. I wonder if the used console was fixed during the window
when the kthreads were enabled.

> I don't know anything about console/printk/serial drivers unfortunately
> so I will almost certainly not be able to find the problem by
> inspection. I'd rather submit patches than send reports, but I really
> really need some help here. I looked at the two patterns Petr suggested,
> but the former I am not sure applies since the issue is present even
> when earlycon is disabled & the latter appears (to my untrained eye) to
> be accounted for in the 8250 driver.

The problem with the missing port->lock is visible only when the
early console is enabled. But It is really hard to hit without
the kthreads.

The problem with enabled IRQs was visible only with kthreads. The
original code called console->write() callback already with IRQs
disabled.

The kthreads called console->write() callback with IRQs enabled.
It made sense. They need to be disabled only when really needed
and the tested drivers did this correctly.

Best Reagrds,
Petr
