Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543363801B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKXUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:15:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8CB0400
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF536223C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 20:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5254DC433D7;
        Thu, 24 Nov 2022 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669320953;
        bh=nFCmXQ+HU+brr3nAPnduAis/Dh4OH0PCZ8K7zI0C7MM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YDURf53M52F8SkVPVCD8Yv7J4BP7NJ9fRM9fPJ3AK0cH6usuy14XfR4+fc/QQl4FU
         rShKYOdz0/9pixQ8rnFVy0gWvaG11/QT/blKqofvv3Hwigfym8EJ3Xpjw3ic0VPEUU
         ap7PuQlAQYQDDGay47QG9fvluEn6/ljUJQ1vifRFpjVJUEKuPGKkbJV/9TjCN9yiPG
         b8g3vRQmoeLqOkElvq9WkNXQl5JKgJEldJ/StcbXFzu8AG3A6yrDj5RYbbXITRyWBp
         0WZYGN81rGc5Aqf59znHn9Rq6xQ3eSoNFPXVekpfypCQSGxZC9Hg/W9pACAvMDJgZK
         WtW4ll5O2kbIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE7005C099C; Thu, 24 Nov 2022 12:15:52 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:15:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Message-ID: <20221124201552.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
 <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221123190932.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <d2c392d9-4415-da33-ace7-d73cf64a023c@alu.unizg.hr>
 <20221124171933.GU4001@paulmck-ThinkPad-P17-Gen-1>
 <9486bc0a-345e-a93c-581f-50e2a06a3314@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9486bc0a-345e-a93c-581f-50e2a06a3314@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 07:04:13PM +0100, Mirsad Goran Todorovac wrote:
> On 24. 11. 2022. 18:19, Paul E. McKenney wrote:
> > On Thu, Nov 24, 2022 at 06:06:13PM +0100, Mirsad Goran Todorovac wrote:
> > > On 23. 11. 2022. 20:09, Paul E. McKenney wrote:
> > > 
> > > > > > If you build with (say) CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200, does
> > > > > > this still happen?
> > > > > 
> > > > > BTW, you don't need to rebuild the kernel to change those parameters; they're
> > > > > module parameters, so can be modified on the kernel command line (if needed
> > > > > during boot) and sysfs (if only needed after boot).
> > > > > 
> > > > > For sysfs the syntax is:
> > > > > #!/bin/bash
> > > > > # set rcu timeouts to specified values
> > > > > echo 60 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> > > > > echo 21000 > /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
> > > > > echo 600000 > /sys/module/rcupdate/parameters/rcu_task_stall_timeout
> > > > > grep -Hs . /sys/module/rcupdate/parameters/rcu_*_timeout
> > > > 
> > > > Excellent point, thank you!
> > > > 
> > > > I hope that this makes Mirsad's life easier, perhaps featuring less time
> > > > waiting for kernel builds and reboots.  ;-)
> > > 
> > > Unfortunately, the first stall and NMI occurs before any system script or setting a /sys/module/rcupdate/parameters/*
> > > could be executed, as second 14 of the boot process:
> > > 
> > > [   14.320045] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 7-.... } 6 jiffies s: 105 root: 0x80/.
> > > [   14.320064] rcu: blocking rcu_node structures (internal RCU debug):
> 
> ...
> 
> > > Probably something sensible should be set in the case of KASAN build. This example of stall
> > > apparently has nothing to do with squashfs_readahead().
> > 
> > Can't have everything, I guess!
> > 
> > How about building your kernel with CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200?
> > Again, mainline defaults to 21000.
> 
> Did just that, and so far there is no modprobe stall in second 14 of boot at least. Looks good.
> Probably it is too early to say anything in general before more uptime and stress load.
> 
> BTW, the 20 for CONFIG_RCU_EXP_STALL_TIMEOUT wasn't my invention, but it comes from generic
> Ubuntu stock kernel (but without KASAN or KMEMLEAK config options):
> 
> # grep STALL /boot/config-5.19.5-051905-generic
> CONFIG_RCU_STALL_COMMON=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> #

Gotta admit, those Ubuntu folks do not lack for bravery!!!  Even if they
don't also enable KASAN or KMEMLEAK by default.  ;-)

							Thanx, Paul
