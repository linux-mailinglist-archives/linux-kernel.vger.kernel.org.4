Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8A6FFF06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjELCnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjELCm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:42:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED74EDD
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:42:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHY2v2286z4x5R;
        Fri, 12 May 2023 12:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683859368;
        bh=UHonVxCxl9tE/BE4saKmOTqDfW/Z+XH0atlSFKqQKFw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dIps/oqn68QXS/wtfWcyekxrrBV800VlhYXyckk0yyHlNuAi/OANA1HtUmq/Dm9HY
         RCiAcMCb25X2GkBordupXcyG4V4fbQ21NRVicTRxpC+ul9+wr55ARw5deXskUIusKV
         A89LRqgyTf2iZog4EKY6eRpyMZI2Og/axtJ7SqtKHDnysjUjgr1MLwuvMgrcsChKxW
         Tn2qFReh+IIS6pyD5m3dl/jn19fXV3tTJtc0MPNh86ctlPKzO7xmR2cz77y5pDu1Lj
         MfpgFo/YdkymlLAJvrkNWgdTIxMES90GDKurKIxsqVbTZxQfmtWNicbivLkrkYQk0o
         7shnTEqgaAJpA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Anatolij Gustschin <agust@denx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Drop MPC5200 LocalPlus bus FIFO driver
In-Reply-To: <20230509082153.jcy2qpvyd44bjaee@pengutronix.de>
References: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
 <20230412150524.ojsvukh47hing6db@pengutronix.de>
 <87zg7cabf6.fsf@mpe.ellerman.id.au>
 <20230413061642.kqkor4wkt7lp2mhp@pengutronix.de>
 <20230509082153.jcy2qpvyd44bjaee@pengutronix.de>
Date:   Fri, 12 May 2023 12:42:46 +1000
Message-ID: <873542l17d.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> On Thu, Apr 13, 2023 at 08:16:42AM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> While mpc5200b.dtsi contains a device that this driver can bind to, the
>> only purpose of a bound device is to be used by the four exported functi=
ons
>> mpc52xx_lpbfifo_submit(), mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll()
>> and mpc52xx_lpbfifo_start_xfer(). However there are no callers to this
>> function and so the driver is effectively superfluous and can be deleted.
>> Also drop some defines and a struct from <asm/mpc52xx.h> that are unused
>> now together with the declarations of the four mentioned functions.
>>=20
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> ---
>> On Thu, Apr 13, 2023 at 10:11:25AM +1000, Michael Ellerman wrote:
>> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>> > > On Wed, Dec 28, 2022 at 03:51:29PM +0100, Uwe Kleine-K=C3=B6nig wrot=
e:
>> > >> The four exported functions mpc52xx_lpbfifo_submit(),
>> > >> mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll(), and
>> > >> mpc52xx_lpbfifo_start_xfer() are not used. So they can be dropped a=
nd the
>> > >> definitions needed to call them can be moved into the driver file.
>> > >>=20
>> > >> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
>> > >
>> > > I never got feedback about this driver and it has not appeared in ne=
xt
>> > > up to now. Did it fell through the cracks?
>> >=20
>> > Yeah. I was hoping someone would explain what's going on with the
>> > driver.
>> >=20
>> > Presumably there are some out-of-tree drivers that use the routines
>> > provided by this driver?
>>=20
>> I googled for the function names but the only related hits were
>> references to this thread :-)
>>=20
>> > I think rather than merging this patch, which keeps the code but makes
>> > it completely useless, do you mind sending a patch to remove the whole
>> > driver? Maybe that will get someone's attention.
>>=20
>> fair enough, here it is.
>
> What is your thought about this patch? If you (also) think getting it
> into next soon after a merge window closed, around now would be a good
> opportunity to do so ..

I was hoping someone would explain why we have a driver that does
nothing useful :) But I guess it's too old for anyone to remember/care.

So yeah I'll take this, we can always put it back if someone needs it.

I base my next on rc2, so I'll pick this up next week.

cheers
