Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A916341A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiKVQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiKVQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:35:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C0140C0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B90B6B81CB2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584B8C433D6;
        Tue, 22 Nov 2022 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669134914;
        bh=dYGnsW5MGyF46yAFgqxQ2djiHjolP5sJlbnisgZvXe4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CJq0ZG9xaqB391bC/PG7a83GJFehC506K43VikYMoCLHELPx/mvQJH3LAroGeQuh5
         XpnKkvKrw44TiTBIV7kNpTm1xYou2NXcqlgviVJeWTwpv58o6DaqT0SDlgsdoJ4S82
         C9cOPMQysXEF9ud2nF/CGo4SXV+9PKxbPPdDFRTfpjxzSZuYm/Nm7PEWWqZpSk0QrI
         qfLwXdp17OCYRh0U0Hy8HPVwcR3OElFRH9T6Wt5psN0Wd329kVRnHaOr9N5gvi06LA
         Uf8l/MYlo/GGk3EW8e09ICkm6bB+rWsyumlGpjUtZaBVHSFDcpDymR4x+DgfraJzya
         auR9od0fubR6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 072E35C0F98; Tue, 22 Nov 2022 08:35:14 -0800 (PST)
Date:   Tue, 22 Nov 2022 08:35:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <20221122163514.GL4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leo3ovpw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:33:39PM +0106, John Ogness wrote:
> On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
> >
> > The people wanting it separate back in the day were those wanting very
> > tiny kernels.  I have not heard from them in a long time, so maybe it
> > is now OK to just make SRCU unconditional.
> 
> Who decides this? Or maybe I should create a semaphore-based Variant of
> console_srcu_read_lock()/console_srcu_read_unlock() for the
> "!CONFIG_PRINTK && !CONFIG_SRCU" case?

As an alternative, I will queue the patch making SRCU unconditional.  ;-)

							Thanx, Paul
