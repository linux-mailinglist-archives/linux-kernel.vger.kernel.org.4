Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9965BE75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjACKyd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 05:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACKya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:54:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243482DEB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:54:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCevy-0008N9-4j; Tue, 03 Jan 2023 11:54:18 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCevw-003Xhj-J0; Tue, 03 Jan 2023 11:54:16 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCevv-0004ck-W5; Tue, 03 Jan 2023 11:54:16 +0100
Message-ID: <97983dd8404782630814a6dada2e863fe914a397.camel@pengutronix.de>
Subject: Re: ld.lld: error: undefined symbol: devm_ti_sci_get_handle
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 03 Jan 2023 11:54:15 +0100
In-Reply-To: <77e77c4f-0cde-090d-5918-c1a5f85ea5fb@infradead.org>
References: <202212222201.6lgWXMZT-lkp@intel.com>
         <77e77c4f-0cde-090d-5918-c1a5f85ea5fb@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-12-22 at 16:40 -0800, Randy Dunlap wrote:
> 
> On 12/22/22 06:45, kernel test robot wrote:
> > Hi Philipp,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
> > commit: a6af504184c981efd253f986e6fc54db57b1d39f reset: ti-sci: Allow building under COMPILE_TEST
> > date:   8 months ago
> > config: arm-randconfig-r046-20221222
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 98b13979fb05f3ed288a900deb843e7b27589e58)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6af504184c981efd253f986e6fc54db57b1d39f
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout a6af504184c981efd253f986e6fc54db57b1d39f
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > ld.lld: error: undefined symbol: devm_ti_sci_get_handle
> >    >>> referenced by reset-ti-sci.c:229 (drivers/reset/reset-ti-sci.c:229)
> >    >>>               reset/reset-ti-sci.o:(ti_sci_reset_probe) in archive drivers/built-in.a
> 
> Two (2) patches have been posted for this build error (in chronological order):
> 
> 2022-10-29:
>   https://lore.kernel.org/lkml/20221030055636.3139-1-rdunlap@infradead.org/
> 2022-12-15:
>   https://lore.kernel.org/all/20221215170036.2308972-1-arnd@kernel.org/
> 
> Can someone apply one of them or at least comment on them?
> Philipp?

Sorry for the delay, I've applied your patch and will send a pull
request shortly.

regards
Philipp
