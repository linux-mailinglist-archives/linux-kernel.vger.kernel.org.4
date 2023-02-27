Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7634E6A45B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjB0PNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0PNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9676AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF23B60DFD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13797C433EF;
        Mon, 27 Feb 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677510810;
        bh=u8rAdrW0LjOvoaHiZAoaHp3uIGx2ZxBvoFwtlLDHQfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1VsHCci9EqWjg/662qztuJ7DUi0tDZvsdbwLvpqkNq5wHgVqt8Z6qSq+CR9vV43s
         WggEk6S7BhKM3cvVmd2FcbESgsKCdTpi101TF+lezcbAtt1UDX/NhI+AOO476z/HHd
         t3paOpHZfWW8qCQXDkyrN6S02OM+hTvtYcUfaLYJsXoE5H7FbtvrKCJZrJLpKLBb+W
         ihxsU9R900/FeiRkdbDu2S+JiRkRYoMSiPQ7dXr5e7ewRqICeNS+Zy1T+sQXEt34XZ
         DUqXQo/jn7cdssmStlWSfC+FIKrVEgBV+6tT44R7bdNuTn8EERyaqVzSwL/CXLdoD6
         hrWXdSAy6Ed4g==
Date:   Mon, 27 Feb 2023 07:13:28 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable
 instruction
Message-ID: <20230227151328.lyvzzn7kggaa2t5z@treble>
References: <202302271743.78emit6I-lkp@intel.com>
 <Y/ykNfK+1G8ZNYSU@FVFF77S0Q05N>
 <Y/y5aucdGL7U+W7a@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/y5aucdGL7U+W7a@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:08:42PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 27, 2023 at 12:38:13PM +0000, Mark Rutland wrote:
> > [adding Peter and Josh, given objtool]
> > 
> > On Mon, Feb 27, 2023 at 05:28:53PM +0800, kernel test robot wrote:
> > > Hi Mark,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
> > > commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
> > > date:   5 weeks ago
> > > config: x86_64-randconfig-r026-20230227 (https://download.01.org/0day-ci/archive/20230227/202302271743.78emit6I-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27cd083cfb9d392f304657ed00fcde1136704e7
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout c27cd083cfb9d392f304657ed00fcde1136704e7
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=x86_64 olddefconfig
> > >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202302271743.78emit6I-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable instruction
> 
> > > 07ef  2fb7bff:	e8 00 00 00 00       	call   2fb7c04 <mptscsih_abort+0x7f4>	2fb7c00: R_X86_64_PLT32	mpt_halt_firmware-0x4
> > > 07f4  2fb7c04:	e9 75 fb ff ff       	jmp    2fb777e <mptscsih_abort+0x36e>
> 
> this is one of those noreturn things again... objtool was clever enough
> to figure out that mpt_halt_firmware() does not return (all it's control
> flow ends in panic()) and hence it 'knows' that +7f4 will not be
> executed. But GCC didn't figure out the same.

I can take care of this one, to go with my other two piles of noreturn
fixes for after the merge window.

-- 
Josh
