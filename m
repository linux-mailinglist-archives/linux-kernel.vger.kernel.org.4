Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF271722DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjFERne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFERnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8FED3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BF8628C2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E9DC433EF;
        Mon,  5 Jun 2023 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685987009;
        bh=Vj3fnLialO/hn/MY70I7V4FxVhGUWHtfpHeXZ9mY14k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GFXfJJRyl8FZJq1B2DHfkNG/V5ychjW7zIltmc5YU7c0jLENmE1HvNx6W7OQw5NWj
         zEyaLCGb1GmLjVClF1OWffNhDV3tZW04Of99v/cBvw/UXxx8Jn+9qjHgj6r0Tk0gIS
         m0NaqWzFQcU4ghTAloh4M8QpUiQ/yFSg09eL8LqXx/8R+TUV/WrWDNVy0Su4qPqBin
         +utBGRhYqFyWGxVUiVCD9GeM9+5ZTDfVKssCfKXwkOfAtY7ZKSnhzOccfW4J5bm0TK
         cnNeD/uZGdvwqwOa6f2NMryHRqrZksWVSXQNRN6LpNE1BNZwIJ3/fgPxUTVY7MMBBo
         ld+TzT0z4/g2w==
Date:   Mon, 5 Jun 2023 18:43:23 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thomas Voegtle <tv@lio96.de>
Cc:     linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <20230605184323.79a7609e@sal.lan>
In-Reply-To: <2ca39b5c-bb19-fb6b-3c79-8ec3cb345ff5@lio96.de>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
        <20230605111715.4c0ba2ed@sal.lan>
        <2ca39b5c-bb19-fb6b-3c79-8ec3cb345ff5@lio96.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 5 Jun 2023 15:10:24 +0200 (CEST)
Thomas Voegtle <tv@lio96.de> escreveu:

> On Mon, 5 Jun 2023, Mauro Carvalho Chehab wrote:
> 
> > Em Tue, 30 May 2023 13:12:57 +0200 (CEST)
> > Thomas Voegtle <tv@lio96.de> escreveu:
> >  
> >> Hello,
> >>
> >>
> >> I have the problem that sometimes my DVB card does not initialize
> >> properly booting Linux 6.4-rc4.
> >> This is not always, maybe in 3 out of 4 attempts.
> >> When this happens somehow you don't see anything special in dmesg, but the
> >> card just doesn't work.  
> >
> > Can you paste the full dmesg?  
> 
> Sorry for the sloppy bug report, I could have sent that right away.
> See below.
> 
> >  
> >>
> >> Reverting this helps:
> >> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
> >> Author: Hyunwoo Kim <imv4bel@gmail.com>
> >> Date:   Thu Nov 17 04:59:22 2022 +0000
> >>
> >>      media: dvb-core: Fix use-after-free on race condition at dvb_frontend  
> >
> > What do you mean by helps? Does it fix it every time, or it just
> > reduces the number of init problems?  
> 
> Reverting fixes it for me. So every boot ist ok.
> 

Ok, the most relevant logs are here:

> [    3.049769] cx23885: cx23885 driver version 0.0.4 loaded

> [    3.065249] cx23885: CORE cx23885[0]: subsystem: 0070:c138, board: Hauppauge WinTV-HVR4400/HVR5500 [card=38,autodetected]

> [    3.443790] tveeprom: Hauppauge model 121029, rev B3F5, serial# 4035236800
> [    3.457139] tveeprom: MAC address is 00:0d:fe:84:d3:c0
> [    3.462277] tveeprom: tuner model is NXP 18271C2 (idx 155, type 54)
> [    3.468543] tveeprom: TV standards PAL(B/G) PAL(I) SECAM(L/L') PAL(D/D1/K) ATSC/DVB Digital (eeprom 0xf4)

> [    3.478101] tveeprom: audio processor is CX23888 (idx 40)
> [    3.478102] tveeprom: decoder processor is CX23888 (idx 34)

> [    3.504377] tveeprom: has radio, has IR receiver, has no IR transmitter
> [    3.504378] cx23885: cx23885[0]: hauppauge eeprom: model=121029
> [    3.504398] tea5767_autodetection: not probed - driver disabled by Kconfig

> [    3.527536] tuner: 8-0060: Tuner -1 found with type(s) Radio TV.
> [    3.537560] tda18271 8-0060: creating new instance
> [    3.544404] tda18271: TDA18271HD/C1 detected @ 8-0060

> [    3.825133] cx23885: cx23885[0]: registered device video0 [v4l2]
> [    3.831235] cx23885: cx23885[0]: registered device vbi0
> [    3.836683] cx23885: cx23885[0]: alsa: registered ALSA audio device
> [    3.836685] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
> [    3.843038] cx23885: cx23885[0]: cx23885 based dvb card
> [    3.849720] tda10071 7-0005: NXP TDA10071 successfully identified
> [    3.856166] a8293 7-000b: Allegro A8293 SEC successfully attached
> [    3.862599] dvbdev: DVB: registering new adapter (cx23885[0])
> [    3.868344] cx23885 0000:03:00.0: DVB: registering adapter 0 frontend 0 (NXP TDA10071)...
> [    3.876816] cx23885: cx23885_dvb_register() allocating 1 frontend(s)
> [    3.883164] cx23885: cx23885[0]: cx23885 based dvb card
> [    3.891025] si2165 7-0064: Detected Silicon Labs Si2165-D (type 7, rev 3)
> [    3.897812] tda18271 8-0060: attaching existing instance
> [    3.903460] dvbdev: DVB: registering new adapter (cx23885[0])
> [    3.909197] cx23885 0000:03:00.0: DVB: registering adapter 1 frontend 0 (Silicon Labs Si2165 DVB-T DVB-C)...
> [    3.919161] cx23885: cx23885_dev_checkrevision() Hardware revision = 0xd0
> [    3.925943] cx23885: cx23885[0]/0: found at 0000:03:00.0, rev: 4, irq: 19, latency: 0, mmio: 0xf0400000
> [    3.935357] usbcore: registered new interface driver dvb_usb_ttusb2

> [    4.216063] ALSA device list:
> [    4.219028]   #0: Conexant CX23885 at cx23885[0]
> [    4.223641]   #1: HDA Intel HDMI at 0xf0814000 irq 37
> [    4.228686]   #2: HDA Intel PCH at 0xf0810000 irq 38

> [   26.332149] tda10071 7-0005: found a 'NXP TDA10071' in cold state, will try to load a firmware
> [   26.340779] tda10071 7-0005: downloading firmware from file 'dvb-fe-tda10071.fw'

And then the dvb frontend register mutex times out:

> [  989.277402] INFO: task vdr:743 blocked for more than 491 seconds.
> [  989.283504]       Not tainted 6.4.0-rc5-i5 #249
> [  989.288036] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  989.295860] task:vdr             state:D stack:0     pid:743   ppid:711    flags:0x00004002
> [  989.295865] Call Trace:
> [  989.295867]  <TASK>
> [  989.295869]  __schedule+0x2ea/0x12d0
> [  989.295877]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [  989.295881]  schedule+0x57/0xc0
> [  989.295884]  schedule_preempt_disabled+0xc/0x20
> [  989.295887]  __mutex_lock.isra.16+0x237/0x480
> [  989.295891]  ? dvb_get_property.isra.10+0x1bc/0xa50
> [  989.295898]  ? dvb_frontend_stop+0x36/0x180
> [  989.338777]  dvb_frontend_stop+0x36/0x180
> [  989.338781]  dvb_frontend_open+0x2f1/0x470
> [  989.338784]  dvb_device_open+0x81/0xf0
> [  989.338804]  ? exact_lock+0x20/0x20
> [  989.338808]  chrdev_open+0x7f/0x1c0
> [  989.338811]  ? generic_permission+0x1a2/0x230
> [  989.338813]  ? link_path_walk.part.63+0x340/0x380
> [  989.338815]  ? exact_lock+0x20/0x20
> [  989.338817]  do_dentry_open+0x18e/0x450
> [  989.374030]  path_openat+0xca5/0xe00
> [  989.374031]  ? terminate_walk+0xec/0x100
> [  989.374034]  ? path_lookupat+0x93/0x140
> [  989.374036]  do_filp_open+0xc0/0x140
> [  989.374038]  ? __call_rcu_common.constprop.91+0x92/0x240
> [  989.374041]  ? __check_object_size+0x147/0x260
> [  989.374043]  ? __check_object_size+0x147/0x260
> [  989.374045]  ? alloc_fd+0xbb/0x180
> [  989.374048]  ? do_sys_openat2+0x243/0x310
> [  989.374050]  do_sys_openat2+0x243/0x310
> [  989.374052]  do_sys_open+0x52/0x80
> [  989.374055]  do_syscall_64+0x5b/0x80
> [  989.421335]  ? __task_pid_nr_ns+0x92/0xa0
> [  989.421337]  ? syscall_exit_to_user_mode+0x20/0x40
> [  989.421339]  ? do_syscall_64+0x67/0x80
> [  989.421341]  ? syscall_exit_to_user_mode+0x20/0x40
> [  989.421343]  ? do_syscall_64+0x67/0x80
> [  989.421345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  989.421348] RIP: 0033:0x7fe895d067e3
> [  989.421349] RSP: 002b:00007fff933c2ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> [  989.421351] RAX: ffffffffffffffda RBX: 00007fff933c2c10 RCX: 00007fe895d067e3
> [  989.421352] RDX: 0000000000000802 RSI: 00005594acdce160 RDI: 00000000ffffff9c
> [  989.421353] RBP: 0000000000000802 R08: 0000000000000000 R09: 0000000000000000
> [  989.421353] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
> [  989.421354] R13: 00007fff933c2ca0 R14: 00000000ffffffff R15: 00007fff933c2c90
> [  989.421355]  </TASK>

Yeah, clearly it is related to the changes introduced by:
6769a0b7ee0c ("media: dvb-core: Fix use-after-free on race condition at dvb_frontend")
my guess is that there's now a deadlock between semaphore fepriv->sem and
the newly-introduced fe->remove_mutex mutex.

It is probably better to revert 6769a0b7ee0c, and work on another
approach for the UAF that would use or work better with the fepriv->sem
semaphore.

Regards,
Mauro
