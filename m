Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCC73B897
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjFWNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjFWNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:16:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4CDE2685;
        Fri, 23 Jun 2023 06:16:41 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qCgeU-0002st-00; Fri, 23 Jun 2023 15:16:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 23F86C03D4; Fri, 23 Jun 2023 15:16:20 +0200 (CEST)
Date:   Fri, 23 Jun 2023 15:16:20 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: provide unxlate_dev_mem_ptr() in asm/io.h
Message-ID: <20230623131620.GG11636@alpha.franken.de>
References: <20230516194000.548487-1-arnd@kernel.org>
 <7cddcd24-c26c-43e3-8da5-88bd12e27709@roeck-us.net>
 <64319e0b-c12e-4144-bee0-534ae9cdc128@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64319e0b-c12e-4144-bee0-534ae9cdc128@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 04:05:11PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 21, 2023, at 15:52, Guenter Roeck wrote:
> > On Tue, May 16, 2023 at 09:39:42PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The unxlate_dev_mem_ptr() function has no prototype on the mips
> >> architecture, which does not include asm-generic/io.h, so gcc warns
> >> about the __weak definition:
> >> 
> >> drivers/char/mem.c:94:29: error: no previous prototype for 'unxlate_dev_mem_ptr' [-Werror=missing-prototypes]
> >> 
> >> Since everyone else already gets the generic definition or has a custom
> >> one, there is not really much point in having a __weak version as well.
> >> 
> >> Remove this one, and instead add a trivial macro to the mips header.
> >> Once we convert mips to use the asm-generic header, this can go away
> >> again.
> >> 
> >
> > This results in build failures when trying to build sh4 images.
> >
> > drivers/char/mem.c: In function 'read_mem':
> > drivers/char/mem.c:164:25: error: implicit declaration of function 
> > 'unxlate_dev_mem_ptr'
> 
> Odd, it looks like arch/sh/ is also missing an #include
> <asm-generic/io.h> in its asm/io.h, I was sure that mips was the
> only one to still not have that.
> 
> There are already patches on the list to convert both, so I think
> we'll be fine on sh after this one gets merged:
> https://lore.kernel.org/all/20230609075528.9390-12-bhe@redhat.com/

which is already taken ages, so I'm not that confident, that this
will happen before merge window starts...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
