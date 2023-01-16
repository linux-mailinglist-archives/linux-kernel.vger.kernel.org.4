Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815A66CF87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjAPT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjAPT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:27:11 -0500
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3472BEF5;
        Mon, 16 Jan 2023 11:27:09 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id 6C567B4106A;
        Mon, 16 Jan 2023 20:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1673897226;
        bh=W57hoBVDKmo5vcLhLyUZTl+jzRDnvmSgbW9AuR3Cw9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X6D+rz2n6/9qh25QCnzxSFn9ezOXo/WV7cZ9gURwb4g3gbknuR0CaewLnf9bHDZPE
         Pr8aHJ/XSuA+oRrml1m2WssL8yKkHVLCClL54Ca/TkgWlzQzlS3E/Uhr7D62txtiV0
         TZOrKBp4zaCkdtH5raGWzzeOw849aa1Gp2jGCXS6fvuFxArMGTHhXPe0N7b9LgEOFQ
         9hE30Zs60rtnhHF7Ic27lUlDZ0aSE0S2CsP6fJ/wLskupUuOd1/tFm+NjuTtG+4M7a
         yonnNZh43tRDODmezUpFUFU+LewXJRWYUY4a2sDRrnVacc4EsuLWDqCM3yZMxrTl6d
         /Hw5S+1/hkjvw==
Date:   Mon, 16 Jan 2023 20:27:02 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Brown <broonie@kernel.org>,
        bartosz.golaszewski@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.krummenacher@toradex.com
Subject: Re: spidev regression in 6.2-rc kernel
Message-ID: <Y8WlBstGn0o64uFN@francesco-nb.int.toradex.com>
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
 <954a693d-09aa-1033-384a-53debf2a2d1c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954a693d-09aa-1033-384a-53debf2a2d1c@leemhuis.info>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:51:58PM +0100, Linux kernel regression tracking (#adding) wrote:
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> On 16.01.23 13:06, Francesco Dolcini wrote:
> > Hello,
> > we spotted a regression on spidev on latest 6.2-rc kernel.
> > 
> > [  214.047619]
> > [  214.049198] ============================================
> > [  214.054533] WARNING: possible recursive locking detected
> > [  214.059858] 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1 Not tainted
> > [  214.065969] --------------------------------------------
> > [  214.071290] spidev_test/1454 is trying to acquire lock:
> > [  214.076530] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x8e0/0xab8
> > [  214.084164]
> > [  214.084164] but task is already holding lock:
> > [  214.090007] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > [  214.097537]
> > [  214.097537] other info that might help us debug this:
> > [  214.104075]  Possible unsafe locking scenario:
> > [  214.104075]
> > [  214.110004]        CPU0
> > [  214.112461]        ----
> > [  214.114916]   lock(&spidev->spi_lock);
> > [  214.118687]   lock(&spidev->spi_lock);
> > [  214.122457]
> > [  214.122457]  *** DEADLOCK ***
> > [  214.122457]
> > [  214.128386]  May be due to missing lock nesting notation
> > [  214.128386]
> > [  214.135183] 2 locks held by spidev_test/1454:
> > [  214.139553]  #0: c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > [  214.147524]  #1: c4925e14 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x70/0xab8
> > [  214.155493]
> > [  214.155493] stack backtrace:
> > [  214.159861] CPU: 0 PID: 1454 Comm: spidev_test Not tainted 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1
> > [  214.169012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [  214.175555]  unwind_backtrace from show_stack+0x10/0x14
> > [  214.180819]  show_stack from dump_stack_lvl+0x60/0x90
> > [  214.185900]  dump_stack_lvl from __lock_acquire+0x874/0x2858
> > [  214.191584]  __lock_acquire from lock_acquire+0xfc/0x378
> > [  214.196918]  lock_acquire from __mutex_lock+0x9c/0x8a8
> > [  214.202083]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> > [  214.207597]  mutex_lock_nested from spidev_ioctl+0x8e0/0xab8
> > [  214.213284]  spidev_ioctl from sys_ioctl+0x4d0/0xe2c
> > [  214.218277]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> > [  214.223351] Exception stack(0xe75cdfa8 to 0xe75cdff0)
> > [  214.228422] dfa0:                   00000000 00001000 00000003 40206b00 bee266e8 bee266e0
> > [  214.236617] dfc0: 00000000 00001000 006a71a0 00000036 004c0040 004bfd18 00000000 00000003
> > [  214.244809] dfe0: 00000036 bee266c8 b6f16dc5 b6e8e5f6
> > 
> > 
> > This is not running the latest rc4, but on sha 97ec4d559d93 (this is
> > just what our CI had available when this test was run). I was not able
> > to bisect it, but it seems something that you could have introduced.
> > 
> > The log is from an apalis-imx6, but I have the same on other ARM SOC.
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 1f4d2dd45b6e
> #regzbot title spi: spidev: recursive locking error
> #regzbot monitor:
> https://lore.kernel.org/all/20230116144149.305560-1-brgl@bgdev.pl/
> #regzbot fix: spi: spidev: fix a recursive locking error
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.

The issue is in mainline, starting from v6.2-rc4, not in next.

#regzbot ^introduced a720416d94634068951773cb9e9d6f1b73769e5b

Francesco

