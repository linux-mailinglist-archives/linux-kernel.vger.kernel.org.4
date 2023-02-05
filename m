Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E08A68AEEB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBEI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBEI4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B01A948
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669BF60B60
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 08:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8814C433D2;
        Sun,  5 Feb 2023 08:56:15 +0000 (UTC)
Date:   Sun, 5 Feb 2023 03:56:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol
 'da_mon_wip' was not declared. Should it be static?
Message-ID: <20230205035612.55406e42@rorschach.local.home>
In-Reply-To: <202302050517.4xtGBe0d-lkp@intel.com>
References: <202302050517.4xtGBe0d-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2023 05:24:24 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Stephen,

Who's "Stephen"?

> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   db27c22251e7c8f3a9d5bfb55c9c8c701a70bbb3
> commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
> date:   6 months ago
> config: csky-randconfig-s052-20230205 (https://download.01.org/0day-ci/archive/20230205/202302050517.4xtGBe0d-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10bde81c74863472047f31304064018c40f488ee
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 10bde81c74863472047f31304064018c40f488ee
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash kernel/trace/rv/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/trace/rv/monitors/wip/wip.c: note: in included file:
>    kernel/trace/rv/monitors/wip/wip.h:30:22: sparse: sparse: symbol 'automaton_wip' was not declared. Should it be static?
> 

Line 30 in kernel/trace/rv/monitors/wip/wip.h is:

static const struct automaton_wip automaton_wip

Isn't it already static??

-- Steve

> vim +/da_mon_wip +20 kernel/trace/rv/monitors/wip/wip.c
> 
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @19  struct rv_monitor rv_wip;
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
> 8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  
> 
> :::::: The code at line 20 was first introduced by commit
> :::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k
> 
> :::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
> :::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

