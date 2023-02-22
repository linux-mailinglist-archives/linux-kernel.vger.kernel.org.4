Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D70C69F4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBVMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBVMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:36:41 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E56C38B5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:36:36 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id m10so6595061vso.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1677069396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zXKWn6cF0+CHQo35voABdeN+lewIiOJOlV9cWuYDSxI=;
        b=PUHckDVC8tKSZ0FAPE61kmkSmeyKm/Sq5RkaIgu6wIIJxIerQr7AjEhEFH7eT6bLiA
         9v0U1XMDwjI3dU30Dpk608KiP/t1K01NijDSLrj4bLEvZI4Hdsr5kCVDXSLSLx4fS8hm
         pZsW5awatXhXA0ZCWzMMzHA3Qj6gVJnA4THx9mduF0fvhSBk2ZtOmDj8uPY7BsNzihig
         h8l0KiIHI59fGPFBx8y82YZEjc+/1ytoBD1LVzVgAg8/PX0MaFY/yAsN/U33Q99ZMZ7y
         I66s3Hhde85aS2Z79FJh7XLTeEx7QOHsBV35PeEXmAM6rGUcQMFElPvXkPXuhD9ywdvv
         1iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677069396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXKWn6cF0+CHQo35voABdeN+lewIiOJOlV9cWuYDSxI=;
        b=6e10qg2qkpEKWOX5PKUWbgntKECqeNv23iVuGMwGNaHvPnbMIZ//yrx+QqtTI/ZwIT
         G2wG3j0L9oZidJz+FYxNyIhIrBQA6ZiCzyn/w/1MYCz07YkYQ52yHg7SH2pAeznh9OBx
         ttesathBPuyE6L14qijN+Il6jS4XfOaRKEsfegha/VscPNu9UMKZT/zYmeZyOJZSIRgS
         62ETDNXih8zrjJQFachZ+HY+hoAo2CgnVLn7MWd59ou7EW6wXYRD3acwK2FHLAojL90H
         2n4mDn8nAc/9ueoh2PsGv6RmGQ5tZ08c5s6o7PmBtg3GjsBUVnIpx4Wuf6VLMuUTGANg
         X7Kg==
X-Gm-Message-State: AO0yUKWrvyECvG+eS8UseQgzvWJdnVMkOOV0toYlOYw2joSyPBZ2+yZu
        HY4yOJTP03EAGMSZzGMy8mbgEPMtHyJKtGCxsIGQ3w==
X-Google-Smtp-Source: AK7set85UM52dIk/6l4hx5GXRC7iLhadz2pmT4Ls+DJUhrK2hIbprOPMz8lcmEbezXBdzGi7D/XisucsvME9ys1yn6o=
X-Received: by 2002:a67:e1cc:0:b0:3ea:5896:84b9 with SMTP id
 p12-20020a67e1cc000000b003ea589684b9mr1436878vsl.75.1677069395949; Wed, 22
 Feb 2023 04:36:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
In-Reply-To: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Feb 2023 13:36:25 +0100
Message-ID: <CAMRc=MdRev1NBz9ga0jcDKD0oZy_W-7caq9R0tQkUG86rBQ=3Q@mail.gmail.com>
Subject: Re: arm64: libgpiod: refcount_t: underflow; use-after-free.
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, warthog618@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 3:59 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel warning notices on qemu-arm64, qemu-arm and also on devices
> running Linux version v6.2.0 while running libgpiod tests.
>

I don't see it on v6.2 with libgpiod v1.6.4. Seeing the output of the
test script, it seems you're using an old version - what is it?

> + ./gpiod.sh /opt/libgpiod/bin/

What's in gpiod.sh?

Bart

>   [INFO]    libgpiod test suite
>   [INFO]    117 tests registered
>   [INFO]    checking the linux kernel version
>   [INFO]    kernel release is v6.2.0 - ok to run tests
>   [INFO]    using gpio-tools from '/usr/bin'
> [   10.499036] ------------[ cut here ]------------
> [   10.499656] refcount_t: underflow; use-after-free.
> [   10.500264] WARNING: CPU: 2 PID: 291 at lib/refcount.c:28
> refcount_warn_saturate+0xf4/0x144
> [   10.501306] Modules linked in: gpio_mockup(-) cfg80211 bluetooth
> rfkill crct10dif_ce fuse drm
> [   10.502364] CPU: 2 PID: 291 Comm: gpiod-test Not tainted 6.2.0 #1
> [   10.503229] Hardware name: linux,dummy-virt (DT)
> [   10.503883] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   10.505331] pc : refcount_warn_saturate+0xf4/0x144
> [   10.505723] lr : refcount_warn_saturate+0xf4/0x144
> [   10.506115] sp : ffff800008983cd0
> [   10.506391] x29: ffff800008983cd0 x28: ffff0000c4c4c100 x27: 0000000000000000
> [   10.506961] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   10.507533] x23: 0000000000000200 x22: ffff0000c4e66800 x21: ffff0000c7734640
> [   10.508104] x20: 0000000000000001 x19: ffff0000c7734600 x18: ffffffffffffffff
> [   10.508677] x17: 3d4d455453595342 x16: ffffcf0234432020 x15: ffff800088983957
> [   10.509424] x14: 0000000000000000 x13: 2e656572662d7265 x12: 7466612d65737520
> [   10.510003] x11: 3b776f6c66726564 x10: ffffcf02365db580 x9 : ffffcf0233b20138
> [   10.510575] x8 : 00000000ffffefff x7 : ffffcf02365db580 x6 : 0000000000000001
> [   10.511145] x5 : ffffcf023655f000 x4 : ffffcf023655f2e8 x3 : 0000000000000000
> [   10.511721] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c4c4c100
> [   10.512294] Call trace:
> [   10.512494]  refcount_warn_saturate+0xf4/0x144
> [   10.512971]  kobject_put+0x164/0x220
> [   10.513224]  fwnode_remove_software_node+0x44/0x60
> [   10.513554]  gpio_mockup_unregister_pdevs+0x54/0x70 [gpio_mockup]
> [   10.513970]  gpio_mockup_exit+0x10/0x328 [gpio_mockup]
> [   10.514322]  __arm64_sys_delete_module+0x190/0x2a0
> [   10.514653]  invoke_syscall+0x50/0x120
> [   10.514915]  el0_svc_common.constprop.0+0x104/0x124
> [   10.515277]  do_el0_svc+0x44/0xcc
> [   10.515541]  el0_svc+0x30/0x94
> [   10.515788]  el0t_64_sync_handler+0xbc/0x13c
> [   10.516126]  el0t_64_sync+0x190/0x194
> [   10.516419] ---[ end trace 0000000000000000 ]---
>
>
> Build and test logs,
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/test/ctxless-get-value-single-line/log
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14856342/suite/libgpiod/tests/
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
