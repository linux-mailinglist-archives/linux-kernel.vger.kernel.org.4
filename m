Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078A5FE206
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJMSvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJMSuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B97C1F6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC877618F6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C2AC433D6;
        Thu, 13 Oct 2022 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665686860;
        bh=YuUMePZ+vsNbKjlHx9yOeHLR/mA9M7RIxKfWjwX0qPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PazBDFLLXt+GAi+mkSDU9TFTQyuUzl6qteLU+Qq7RRtLckPFKi6j6bJgVfJ9ZQqrX
         erfrZur+wzF9i6QDqQLAkHrHaKDJ0hpzv18XOrbsUuTMKKY+7dEueNMVTwh/pFOVhx
         Vm6sARenpfGClnv6W+nJYOd3dlJzEjxg/aOAvhyMJtNmLSo5+k4zIbg3KDqgKWiboT
         KHpaLWE4n+PU9fAYfUnWOD1K2j8XXbAg3Od+sHfWmucYF4yxGzF6CAPbEPKJ2Wc8Gg
         1c13fXR1HTlXywmLDurUmQjDdCod/EhG65fJuA3o/B//MJt8MnKtACxnL8rJtTc4aN
         xrV9C3gqAHQiA==
Date:   Thu, 13 Oct 2022 19:47:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <zx2c4@kernel.org>,
        linux-riscv@lists.infradead.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [linux-stable-rc:linux-4.19.y 3113/3976]
 drivers/char/random.c:1336: Error: unrecognized opcode `csrs sstatus,s4'
Message-ID: <Y0hdR2Z44oOQ989w@spud>
References: <202210101947.iPda3BwQ-lkp@intel.com>
 <Y0QKkwQ5KGT9ngPL@wendy>
 <Y0gONdihAaosW9+U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0gONdihAaosW9+U@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:10:13PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 10, 2022 at 01:05:39PM +0100, Conor Dooley wrote:
> > On Mon, Oct 10, 2022 at 07:51:59PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > > head:   5644b22533b36dc1a95ab1db4ae83381514b2908
> > > commit: 1923d9a8a08684c063da049fa9d5d8139edbbcbb [3113/3976] random: convert to using fops->write_iter()
> > > config: riscv-randconfig-c024-20221009
> > > compiler: riscv64-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1923d9a8a08684c063da049fa9d5d8139edbbcbb
> > >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         git fetch --no-tags linux-stable-rc linux-4.19.y
> > >         git checkout 1923d9a8a08684c063da049fa9d5d8139edbbcbb
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/char/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    arch/riscv/include/asm/irqflags.h: Assembler messages:
> > >    arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc s6,sstatus,2'
> > >    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,0'
> > >    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,s6'
> > >    drivers/char/random.c:1316: Error: unrecognized opcode `csrs sstatus,a3'
> > >    drivers/char/random.c:1316: Error: unrecognized opcode `csrc sstatus,a3'
> > >    drivers/char/random.c:1322: Error: unrecognized opcode `csrs sstatus,a3'
> > >    drivers/char/random.c:1322: Error: unrecognized opcode `csrc sstatus,a3'
> > > >> drivers/char/random.c:1336: Error: unrecognized opcode `csrs sstatus,s4'
> > > >> drivers/char/random.c:1336: Error: unrecognized opcode `csrc sstatus,s4'
> > 
> > All of these look like 4.19.y is missing a backport of:
> > Fixes: 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
> > 
> > That commit is CC: stable, so I assume it did not apply or w/e and
> > nobody cared enough to do a backport?
> 
> It does not apply and no one sent in a fixed backport :(

Welp, I have a fixed backport for it and pushed it out for LKP [0].
Just quickly checked it w/ binutils 2.36 & 2.38 locally, which both
worked fine. I doubt anyone really cares though, 4.19 is pretty long in
the tooth RISC-V hw wise. Not the biggest fan of what I did, but I
didn't want to send backports for some other infra changes that
6df2a016c0c8 depends on.

I'll send it to you once LKP gives it the all clear.

Thanks,
Conor.

0 -https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=riscv-backport_238_fix&id=cf7c2ca06cd0e5f6c16fe70e751380c8673da9ed
