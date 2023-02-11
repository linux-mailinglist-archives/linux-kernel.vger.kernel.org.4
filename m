Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715626931F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBKPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:18:49 -0500
Received: from smtp-out-04.comm2000.it (smtp-out-04.comm2000.it [212.97.32.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317B20689;
        Sat, 11 Feb 2023 07:18:45 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-04.comm2000.it (Postfix) with ESMTPSA id F2E26BC3332;
        Sat, 11 Feb 2023 16:18:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1676128722;
        bh=/5/pVryBZHFqk76tUiyUciW2nJ6CjTmw+9KqkjLkLQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Tp8QOhKRsEpH/FMAgplzKhsuOhxlRRYJNvWrrnuxndN3mhEmdKjpLqL7a38LSYZHG
         cOWvHLLoA3QM6vjE3BGWApdF4QH7XVOPBXJ6Xs6AuMZJpKaBoxYUl1gudZ9Y6SBkgo
         dMcE7DKAQcEOxktvd1P+x7WzB9DqDbnfzPCYbhRK/THQQVzpFM92a239UuUOWsq5Ce
         0TwS681ZCczlVoD8LbDB5WavXVf4/57g3fwTpjkGAt8OOtGjZZE8BFDx4rDuKnSfek
         u0MEdmcX87wUy2RclDdvfeKglR1OKivzVlF+8xOZm6cWZDoY1VNzJYF0/lXrSuVPbq
         iSuFkeJoiDqrQ==
Date:   Sat, 11 Feb 2023 16:18:37 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Mark Brown <broonie@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH -next] spi: spidev: fix a recursive locking error
Message-ID: <Y+exzSwy1UJQCUKg@francesco-nb.int.toradex.com>
References: <20230116144149.305560-1-brgl@bgdev.pl>
 <167395356741.524535.13729434862127399808.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167395356741.524535.13729434862127399808.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, Jan 17, 2023 at 11:06:07AM +0000, Mark Brown wrote:
> On Mon, 16 Jan 2023 15:41:49 +0100, Bartosz Golaszewski wrote:
> > When calling spidev_message() from the one of the ioctl() callbacks, the
> > spi_lock is already taken. When we then end up calling spidev_sync(), we
> > get the following splat:
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
> > [...]
> 
> Applied to
> 
>    broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: spidev: fix a recursive locking error
>       commit: 9bab63a3e9498afd6a29cd3a43cf3ad4a4612b85

Any plan to have this fix sent to Linus for v6.2? The reason for asking
is that because of this bug our whole test infrastructure crashes
preventing the normal testing we normally do on mainline kernel (that is
also how this issue was spotted in the first place).

Francesco

