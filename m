Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787935EBBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiI0Hum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiI0HuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:50:18 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35BCC7D1DE;
        Tue, 27 Sep 2022 00:50:02 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1od5Lt-0000Ex-00; Tue, 27 Sep 2022 09:50:01 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BE417C0664; Tue, 27 Sep 2022 09:49:53 +0200 (CEST)
Date:   Tue, 27 Sep 2022 09:49:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <20220927074953.GA6127@alpha.franken.de>
References: <Yy08TBymyuQb27NU@google.com>
 <20220924104612.GB10628@alpha.franken.de>
 <YzKCaMU9wlFbPZS7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzKCaMU9wlFbPZS7@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:56:08PM -0700, Dmitry Torokhov wrote:
> Hi Thomas,
> 
> On Sat, Sep 24, 2022 at 12:46:12PM +0200, Thomas Bogendoerfer wrote:
> > On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
> > > This switches vmmc to use gpiod API instead of OF-specific legacy gpio
> > > API that we want to stop exporting from gpiolib.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
> > >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > applied to mips-next.
> 
> My apologies, I screwed up. I thought this patch passed 0day before I
> sent it to you, but apparently it has not.
> 
> Here is a fixup (actually cross-compiled this time), or I can send a v2
> incorporating it into the original change.

I need a fixup, but this one still fails in my build:

/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c: In function ‘vmmc_probe’:
/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c:43:5: error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Werror=format=]
     "failed to request GPIO idx %d: %d\n",
     ^
/local/tbogendoerfer/korg/linux/include/linux/dev_printk.h:110:16: note: in definition of macro ‘dev_printk_index_wrap’
   _p_func(dev, fmt, ##__VA_ARGS__);   \
                ^~~
/local/tbogendoerfer/korg/linux/include/linux/dev_printk.h:144:49: note: in expansion of macro ‘dev_fmt’
  dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                 ^~~~~~~
/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c:42:4: note: in expansion of macro ‘dev_err’
    dev_err(&pdev->dev,
    ^~~~~~~

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
