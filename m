Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5066C459
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjAPPwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjAPPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:52:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B131CF78;
        Mon, 16 Jan 2023 07:52:02 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pHRmB-0004On-Na; Mon, 16 Jan 2023 16:51:59 +0100
Message-ID: <954a693d-09aa-1033-384a-53debf2a2d1c@leemhuis.info>
Date:   Mon, 16 Jan 2023 16:51:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: spidev regression in 6.2-rc kernel
Content-Language: en-US, de-DE
To:     Francesco Dolcini <francesco@dolcini.it>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Brown <broonie@kernel.org>, bartosz.golaszewski@linaro.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.krummenacher@toradex.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673884323;7ce5b7c7;
X-HE-SMSGID: 1pHRmB-0004On-Na
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 16.01.23 13:06, Francesco Dolcini wrote:
> Hello,
> we spotted a regression on spidev on latest 6.2-rc kernel.
> 
> [  214.047619]
> [  214.049198] ============================================
> [  214.054533] WARNING: possible recursive locking detected
> [  214.059858] 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1 Not tainted
> [  214.065969] --------------------------------------------
> [  214.071290] spidev_test/1454 is trying to acquire lock:
> [  214.076530] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x8e0/0xab8
> [  214.084164]
> [  214.084164] but task is already holding lock:
> [  214.090007] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> [  214.097537]
> [  214.097537] other info that might help us debug this:
> [  214.104075]  Possible unsafe locking scenario:
> [  214.104075]
> [  214.110004]        CPU0
> [  214.112461]        ----
> [  214.114916]   lock(&spidev->spi_lock);
> [  214.118687]   lock(&spidev->spi_lock);
> [  214.122457]
> [  214.122457]  *** DEADLOCK ***
> [  214.122457]
> [  214.128386]  May be due to missing lock nesting notation
> [  214.128386]
> [  214.135183] 2 locks held by spidev_test/1454:
> [  214.139553]  #0: c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> [  214.147524]  #1: c4925e14 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x70/0xab8
> [  214.155493]
> [  214.155493] stack backtrace:
> [  214.159861] CPU: 0 PID: 1454 Comm: spidev_test Not tainted 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1
> [  214.169012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  214.175555]  unwind_backtrace from show_stack+0x10/0x14
> [  214.180819]  show_stack from dump_stack_lvl+0x60/0x90
> [  214.185900]  dump_stack_lvl from __lock_acquire+0x874/0x2858
> [  214.191584]  __lock_acquire from lock_acquire+0xfc/0x378
> [  214.196918]  lock_acquire from __mutex_lock+0x9c/0x8a8
> [  214.202083]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> [  214.207597]  mutex_lock_nested from spidev_ioctl+0x8e0/0xab8
> [  214.213284]  spidev_ioctl from sys_ioctl+0x4d0/0xe2c
> [  214.218277]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> [  214.223351] Exception stack(0xe75cdfa8 to 0xe75cdff0)
> [  214.228422] dfa0:                   00000000 00001000 00000003 40206b00 bee266e8 bee266e0
> [  214.236617] dfc0: 00000000 00001000 006a71a0 00000036 004c0040 004bfd18 00000000 00000003
> [  214.244809] dfe0: 00000036 bee266c8 b6f16dc5 b6e8e5f6
> 
> 
> This is not running the latest rc4, but on sha 97ec4d559d93 (this is
> just what our CI had available when this test was run). I was not able
> to bisect it, but it seems something that you could have introduced.
> 
> The log is from an apalis-imx6, but I have the same on other ARM SOC.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 1f4d2dd45b6e
#regzbot title spi: spidev: recursive locking error
#regzbot monitor:
https://lore.kernel.org/all/20230116144149.305560-1-brgl@bgdev.pl/
#regzbot fix: spi: spidev: fix a recursive locking error
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
