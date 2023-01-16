Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8666BDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjAPMTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjAPMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:19:40 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A01CF6B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:19:38 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id i188so28813298vsi.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kazLpMPqIJ8ND7JnzhZsAo9YrM4X5RuRvuloMhNxBiA=;
        b=fpKI4lR3e0tfEG5mJtj4ykMByxkXE/wybdMyyPQPkzqWy4bPosB37XYkVNEenPnC9n
         0+X5C0h1shkD3QQCmP1PVsJwsnr34O0mF1LlsfCqnjliDesjuJVnVaE3RtazynpAgpjw
         epOAd0D9zgYphOKjQ5D3gAnOMoZVakfDR/uQxo+3LbjJCUvrAT7kxMNjFMX+SwQsG5KI
         sDpu7KRsBWOvxkb4ZLWL0vLFUGV4L3G+BEBAW+U3lISnK4JsyfAljVQeeh5vUb5fTh+Q
         eYAnMQxWB5tn+uFCjcRqcSSxP1HDFGCTuIWHuwfMPpODXMBN4vveDq6QTtyghgvOkehs
         4FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kazLpMPqIJ8ND7JnzhZsAo9YrM4X5RuRvuloMhNxBiA=;
        b=P7VgODx4TAk3kIaE53j6Vsccm66QTtBIVkcBeovXeVMV0PjN0JwpobYvSzyqLDiG+f
         CI2VZIpibe+J7fHKjkhH2I6tAzFMD2Vmv1uU2oHR5/0xIFFiBcVHBSil+DbCIMQfxkSa
         uq+ANnriGlREXcUBjURXC8vcR7HD23Dw1HLV+MXwVMsa/NFw/T9EsSZcalBH64RbLv7U
         4MtRAFfPYKUdGnNd1UpK9SOpW1XL3GH2dpSri4+yVdIUA39oEFhoBY1R+aDYc2ElMRzS
         kAjZW7z78cYFeCAHao+wEwJTxKiWh31Sclv9G7Tg9sqex++rFjBru5dICuVOX3MovO9W
         pQkg==
X-Gm-Message-State: AFqh2kqXO64DF01iyuFkkUM79d4tlEBvokDn68GLGQoBcEg7gxmCMO5D
        CAfKxfvdvRaWbdf9I5osF4pLlAdANdQN9mUlcaxQ5w==
X-Google-Smtp-Source: AMrXdXsh533ytKCqAQBDxz7H2+vm1Pb7F45A1LT5hBKM7IhisMcTex00TP4koRLjkBtwQ2tNVmqT4vA2mF7N+oMFzB0=
X-Received: by 2002:a05:6102:83b:b0:3d1:3753:9a3c with SMTP id
 k27-20020a056102083b00b003d137539a3cmr1499276vsb.73.1673871577998; Mon, 16
 Jan 2023 04:19:37 -0800 (PST)
MIME-Version: 1.0
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
In-Reply-To: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 13:19:27 +0100
Message-ID: <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
Subject: Re: spidev regression in 6.2-rc kernel
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Mark Brown <broonie@kernel.org>, bartosz.golaszewski@linaro.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.krummenacher@toradex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:06 PM Francesco Dolcini <francesco@dolcini.it> wrote:
>
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
>
> Can you have a look?
> Thanks
>
> Francesco
>

Eek! Yes it's commit 1f4d2dd45b6e ("spi: spidev: fix a race condition
when accessing spidev->spi"): spidev_ioctl() takes the lock and in
certain instances can end up calling spidev_compat_ioc_message() which
takes the same lock again. I'll send a fix shortly.

Bart
