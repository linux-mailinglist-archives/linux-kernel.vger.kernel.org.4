Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1015ECE22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiI0UOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiI0UN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:58 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C55C8432;
        Tue, 27 Sep 2022 13:13:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1odGxn-0005Vh-00; Tue, 27 Sep 2022 22:13:55 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D8157C0AE7; Tue, 27 Sep 2022 22:13:45 +0200 (CEST)
Date:   Tue, 27 Sep 2022 22:13:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <20220927201345.GA19638@alpha.franken.de>
References: <Yy08TBymyuQb27NU@google.com>
 <20220924104612.GB10628@alpha.franken.de>
 <YzKCaMU9wlFbPZS7@google.com>
 <20220927074953.GA6127@alpha.franken.de>
 <791EE67B-9A27-4A3F-BE0E-A62CDB5CE9FA@gmail.com>
 <20220927082946.GA7667@alpha.franken.de>
 <YzMW5r5+1NY1tual@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzMW5r5+1NY1tual@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:29:42AM -0700, Dmitry Torokhov wrote:
> On Tue, Sep 27, 2022 at 10:29:46AM +0200, Thomas Bogendoerfer wrote:
> > On Tue, Sep 27, 2022 at 01:08:35AM -0700, Dmitry Torokhov wrote:
> > > On September 27, 2022 12:49:53 AM PDT, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > > >On Mon, Sep 26, 2022 at 09:56:08PM -0700, Dmitry Torokhov wrote:
> > > >> Hi Thomas,
> > > >> 
> > > >> On Sat, Sep 24, 2022 at 12:46:12PM +0200, Thomas Bogendoerfer wrote:
> > > >> > On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
> > > >> > > This switches vmmc to use gpiod API instead of OF-specific legacy gpio
> > > >> > > API that we want to stop exporting from gpiolib.
> > > >> > > 
> > > >> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >> > > ---
> > > >> > >  arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
> > > >> > >  1 file changed, 13 insertions(+), 9 deletions(-)
> > > >> > 
> > > >> > applied to mips-next.
> > > >> 
> > > >> My apologies, I screwed up. I thought this patch passed 0day before I
> > > >> sent it to you, but apparently it has not.
> > > >> 
> > > >> Here is a fixup (actually cross-compiled this time), or I can send a v2
> > > >> incorporating it into the original change.
> > > >
> > > >I need a fixup, but this one still fails in my build:
> > > >
> > > >/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c: In function ‘vmmc_probe’:
> > > >/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c:43:5: error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Werror=format=]
> > > >     "failed to request GPIO idx %d: %d\n",
> > > >     ^
> > > 
> > > I see, I did not realize PTR_ERR() is actually long. I guess I can introduce a temp variable and use PTR_ERR_OR_ZERO(), but there are a lot of places in the kernel that use %d and PTR_ERR(). I wonder why we can't define PTR_ERR() as (int)(long)ptr or something.
> > > 
> > > What compiler/version are you using for your builds? 
> > 
> > it's rather old:
> > 
> > gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) 
> 
> OK, I tried the below with gcc 12.1.0 cross-compiler, hopefully this
> does not trip on 6.1.1.

works with 6.1.1 as well. Applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
