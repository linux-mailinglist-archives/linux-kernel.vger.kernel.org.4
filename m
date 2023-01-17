Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2602266DBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjAQLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjAQLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:06:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08132E49;
        Tue, 17 Jan 2023 03:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B374E6129E;
        Tue, 17 Jan 2023 11:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6EFC433EF;
        Tue, 17 Jan 2023 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673953570;
        bh=4dyOBo3TAE/wdu3EvAHU5EkZ7LR31BZIwstpaCfcTWk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c+e0HtsyX6CKCPzt1YHqVkGJqGyJT3f+dGL/4pkg8ZlY08vFdolfSRLe3czDA5Kze
         DQekt8unI3PGVO2bvlB2E/VTTYWZ+od770D+TJcP9qTruRV6+c/pf9x+wEV1KzGvKS
         eNIn6bC1WeaNUQ5TfpmhxS7sjD6/YsTXxJCQdpfq2wVXyvJj0qxJzEVm/11BulNqtb
         QIxU/YuZFn/8zbZUPQzhv8Mhc5ThFnWtLyo05pk3hIR7+WhSjVJhdjUldBdo+QniJy
         cni/96WR0V9+hL5Cv7RQqGfeGEFbwCB7DiKp6MDzLQF0M+emsIUS8FZOhK97vcRZht
         nkbQwKGbJbsbw==
From:   Mark Brown <broonie@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20230116144149.305560-1-brgl@bgdev.pl>
References: <20230116144149.305560-1-brgl@bgdev.pl>
Subject: Re: [PATCH -next] spi: spidev: fix a recursive locking error
Message-Id: <167395356741.524535.13729434862127399808.b4-ty@kernel.org>
Date:   Tue, 17 Jan 2023 11:06:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 15:41:49 +0100, Bartosz Golaszewski wrote:
> When calling spidev_message() from the one of the ioctl() callbacks, the
> spi_lock is already taken. When we then end up calling spidev_sync(), we
> get the following splat:
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
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: fix a recursive locking error
      commit: 9bab63a3e9498afd6a29cd3a43cf3ad4a4612b85

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

