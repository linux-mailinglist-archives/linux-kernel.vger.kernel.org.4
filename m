Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9079F5B888C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiINMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiINMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:47:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC480015
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:46:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dv25so34376950ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=qMjHrKPyfAVmL3aUHtiKngSuIygvSFepZPCMketiXBw=;
        b=ZVQ9DOV4GaME/7KzwHu+EWdSsnwUHyO7tDRcgr2knAy0tb08gC5nIH819KksbN9meF
         BLQsYnPZyJqgymq45XQ55zssJiwumUVZRaCjDHGgyO1+mZQg9xyC9LLlwqi40/iEaBH4
         T7D6K99ITn2Cf46UaElRLwi2tACse+LApeheWZrysPtUhD+kvdNkxbz3bZTh1sngdNIr
         O6b0sqkkhJqU7WR5bJbNmbbGbMLQEQpgeEk/3z98Djl71CNsYHYZE8w+gUId3CDTLUMd
         SSqe3Raem729XkL8HX3hYtQYyU6tnBGYI0x6rfG4+Io8V9PmTGm+9fp4ds3GyB2qjvKi
         V5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qMjHrKPyfAVmL3aUHtiKngSuIygvSFepZPCMketiXBw=;
        b=PMi88NZZ9ZvW+5TTZmDM4xe9TuFXT0XVqjnZAdfdSWIroQPmjNcZgcN/XZM6EKHFt3
         W8PFRXOEtVoQ+PycBoFZmQUt3eGsFrAfYWFFtBR98qvulFByDFucruDBQBj66CgoUxSh
         u5XIiB3rp/KjrKCY5p4akMDJ9J+qT64HMExsl3ref2Sn3B1H9AVkTWV4YmB+GmAkGakZ
         U0ii9R20wTC6fbkvkIgL/VmDh6WzMPoCvqH3W5cE86+lU7BYjx4orzQ9McwQcMZmTG87
         tjROg0RX+pyW6ts4L9yxzpzv2t09xodTgXuhocZvx83SzlIKOBuh0G7ejfwUgXrnTMxw
         GuRA==
X-Gm-Message-State: ACgBeo2QEbNV1ZFjvk9jpYyZy5Ds+etiIvyi8pW18/+mNgrZ+Ri9Uw81
        U4v5thwhMMZighvaySVsJh546lDXO3d3HV16Id6WPw==
X-Google-Smtp-Source: AA6agR4oD40hpMgEAo5pBjQEq5Mklk/+/nFvXKTL5bUNitkMLB05wyc5CUJJsrOyzO4ZhPPxtXiP6RxXbMoJAUpdsKk=
X-Received: by 2002:a17:907:7f8e:b0:770:7c67:f522 with SMTP id
 qk14-20020a1709077f8e00b007707c67f522mr25623896ejc.366.1663159617537; Wed, 14
 Sep 2022 05:46:57 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 14 Sep 2022 18:16:46 +0530
Message-ID: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
Subject: x15: kernel crash: LR is at sysc_enable_opt_clocks
To:     Tony Lindgren <tony@atomide.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed on arm TI x15 device while booting the
mainline kernel 6.0.0-rc4.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    1.427429] ti-sysc: probe of 4ae18000.target-module failed with error -16
[    1.442718] printk: console [ttyS2] disabled
[    1.442779] 48020000.serial: ttyS2 at MMIO 0x48020000 (irq = 101,
base_baud = 3000000) is a 8250
[    1.740112] ata1: SATA link down (SStatus 0 SControl 300)
[    2.789703] printk: console [ttyS2] enabled
[    2.809356] gpio gpiochip1: (gpio-32-63): not an immutable chip,
please consider fixing it!
[    2.820007] gpio gpiochip2: (gpio-64-95): not an immutable chip,
please consider fixing it!
[    2.830657] gpio gpiochip3: (gpio-96-127): not an immutable chip,
please consider fixing it!
[    2.841278] gpio gpiochip4: (gpio-128-159): not an immutable chip,
please consider fixing it!
[    2.851928] gpio gpiochip5: (gpio-160-191): not an immutable chip,
please consider fixing it!
[    2.862548] gpio gpiochip6: (gpio-192-223): not an immutable chip,
please consider fixing it!
[    2.873229] gpio gpiochip7: (gpio-224-255): not an immutable chip,
please consider fixing it!
[    2.885131] omap_i2c 48060000.i2c: bus 2 rev0.12 at 400 kHz
[    2.900146] palmas 0-0058: Irq flag is 0x00000008
[    2.933776] palmas 0-0058: Muxing GPIO 2f, PWM 0, LED 0
[    2.981475] at24 0-0050: supply vcc not found, using dummy regulator
[    2.988311] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    2.995178] omap_i2c 48070000.i2c: bus 0 rev0.12 at 400 kHz
[    3.014984] omap_rng 48090000.rng: Random Number Generator ver. 20
[    3.029357] omap_gpio 4805d000.gpio: Could not set line 27 debounce
to 200000 microseconds (-22)
[    3.038238] sdhci-omap 4809c000.mmc: Got CD GPIO
[    3.043182] sdhci-omap 4809c000.mmc: supply vqmmc not found, using
dummy regulator
[    3.059600] random: crng init done
[    3.059631] 8<--- cut here ---
[    3.066101] Unable to handle kernel paging request at virtual
address adacafae
[    3.073394] [adacafae] *pgd=00000000
[    3.076995] Internal error: Oops: 5 [#1] SMP ARM
[    3.081634] Modules linked in:
[    3.084716] CPU: 0 PID: 10 Comm: kworker/u4:1 Not tainted 6.0.0-rc4 #1
[    3.091278] Hardware name: Generic DRA74X (Flattened Device Tree)
[    3.097381] Workqueue: events_unbound deferred_probe_work_func
[    3.103271] PC is at clk_enable+0x14/0x3c
[    3.107299] LR is at sysc_enable_opt_clocks+0x4c/0xa0
[    3.112396] pc : [<c0991050>]    lr : [<c0893c4c>]    psr: a0000013
[    3.118682] sp : f00317c0  ip : 00000000  fp : c1470f48
[    3.123931] r10: 00000028  r9 : c14713e8  r8 : c29e5e80
[    3.129180] r7 : ffffffed  r6 : c3b3d840  r5 : 00000000  r4 : adacafae
[    3.135742] r3 : adacafae  r2 : 2cb8a000  r1 : 00000000  r0 : adacafae
[    3.142303] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    3.149475] Control: 10c5387d  Table: 8020406a  DAC: 00000051
[    3.155273] Register r0 information: non-paged memory
[    3.160339] Register r1 information: NULL pointer
[    3.165069] Register r2 information: non-paged memory
[    3.170166] Register r3 information: non-paged memory
[    3.175231] Register r4 information: non-paged memory
[    3.180297] Register r5 information: NULL pointer
[    3.185028] Register r6 information: slab kmalloc-256 start
c3b3d800 pointer offset 64 size 256
[    3.193817] Register r7 information: non-paged memory
[    3.198883] Register r8 information: slab task_struct start
c29e5e80 pointer offset 0
[    3.206787] Register r9 information: non-slab/vmalloc memory
[    3.212463] Register r10 information: non-paged memory
[    3.217620] Register r11 information: non-slab/vmalloc memory
[    3.223419] Register r12 information: NULL pointer
[    3.228210] Process kworker/u4:1 (pid: 10, stack limit = 0xa607d42a)
[    3.234619] Stack: (0xf00317c0 to 0xf0032000)
[    3.239013] 17c0: 00000003 00000000 c3b3d840 c0893c4c c3b3d840
c230e278 c3922810 c0896794
[    3.247222] 17e0: 00000001 00000000 c2023984 c1ad37f4 c3922810
c230e278 00000001 c3922810
[    3.255432] 1800: c29e5e80 c1ad36c0 00000001 00000001 00000006
1fd8a6ff 00000000 00000000
[    3.263671] 1820: c3922810 c210ce8c c227f600 00000000 c2321328
eeb85c9c eeb85c9c c0b9a570
[    3.271881] 1840: 00000000 c3922810 c210ce8c c0b976ac c3922910
00000073 c3922810 c227f600
[    3.280090] 1860: c210ce8c 00000073 c227f378 c0b97a88 c1471e50
eeb85c80 c2321350 c210ce8c
[    3.288330] 1880: c3922810 c227f378 c2321328 eeb85c9c eeb85c9c
c0b97c24 00000001 c210ce8c
[    3.296539] 18a0: f00318f4 c3922810 c227f378 c0b9834c 00000000
f00318f4 c29e5e80 c0b98298
[    3.304748] 18c0: c227f378 c0b954e4 c391fc94 c298c56c c2f0f438
1fd8a6ff 00000001 c3922810
[    3.312988] 18e0: 00000001 c29e5e80 c3922854 c0b97ef4 c391fc10
c3922810 00000001 1fd8a6ff
[    3.321197] 1900: eeb85f24 c3922810 c21fc1e0 c3922810 c29e5e80
c0b966f8 c3922810 00000000
[    3.329406] 1920: c391fc10 c0b93c04 c21fbc44 eeb85ca0 eeb85c8c
48468004 48468007 ff8efc2c
[    3.337646] 1940: 00000200 00000000 00000000 00000000 00000000
1fd8a6ff c3922810 c3922800
[    3.345855] 1960: c391fc10 00000000 c2023984 eeb85ce4 c29e5e80
00000000 00000001 c109a164
[    3.354064] 1980: eeb85c80 c2023828 00000000 c2023968 c2023984
c109a4ec c29e5e80 c1313e90
[    3.362304] 19a0: c391fc10 00000000 eeb85ce4 f00319f0 c1b2e02c
48468000 48468003 ff8efc28
[    3.370513] 19c0: 00000200 00000000 00000000 00000000 00000000
1fd8a6ff 60000013 eeb85c80
[    3.378723] 19e0: eeb80ed8 00000000 c2023828 c391fc10 00000001
00000000 eeb80ef4 c109a9bc
[    3.386962] 1a00: 00000001 00000000 c391fc10 eeb80ed8 c2023828
c227f600 00000000 c2321328
[    3.395172] 1a20: eeb80ef4 c0893838 00000000 c391fc10 c210ce18
c0b9a570 00000000 c391fc10
[    3.403381] 1a40: c210ce18 c0b976ac c391fd10 0000006b c391fc10
c227f600 c210ce18 0000006b
[    3.411621] 1a60: c227f378 c0b97a88 c14706f4 eeb80ed8 c2321350
c210ce18 c391fc10 c227f378
[    3.419830] 1a80: c2321328 eeb80ef4 eeb80ef4 c0b97c24 00000001
c210ce18 f0031aec c391fc10
[    3.428070] 1aa0: c227f378 c0b9834c 00000000 f0031aec c29e5e80
c0b98298 c227f378 c0b954e4
[    3.436279] 1ac0: c391ec94 c298c56c c2f0f3b8 1fd8a6ff 00000000
c391fc10 00000001 c29e5e80
[    3.444488] 1ae0: c391fc54 c0b97ef4 c391ec10 c391fc10 00000001
1fd8a6ff eeb88288 c391fc10
[    3.452697] 1b00: c21fc1e0 c391fc10 c29e5e80 c0b966f8 c391fc10
00000000 c391ec10 c0b93c04
[    3.460937] 1b20: c21fbc44 eeb80ef8 eeb80ee4 f0031bac c2023828
eeb80ed8 c29e5e80 00000000
[    3.469146] 1b40: c233dbb0 60000013 60000013 1fd8a6ff c391fc10
c391fc00 c391ec10 00000000
[    3.477355] 1b60: c2023828 eeb80f3c c29e5e80 00000000 00000001
c109a164 eeb80ed8 c2023828
[    3.485595] 1b80: 00000000 c2023918 c2023828 c109a4ec c391ec10
1fd8a6ff c391ec10 00000000
[    3.493804] 1ba0: eeb80f3c c2c23448 c391ec10 c0bb3250 00000000
f0031bbc eeb80c58 eeb6d818
[    3.502044] 1bc0: c233dbb0 60000013 60000013 1fd8a6ff 60000013
eeb80ed8 eeb80c3c 00000000
[    3.510253] 1be0: c2023828 c391ec10 00000001 eeb80c58 eeb80c58
c109a9bc 00000001 00000000
[    3.518463] 1c00: c391ec10 eeb80c3c c2023828 c227f600 00000000
c2321328 eeb80c58 c0893838
[    3.526672] 1c20: 00000000 c391ec10 c210ce18 c0b9a570 00000000
c391ec10 c210ce18 c0b976ac
[    3.534912] 1c40: c391ed10 0000006b c391ec10 c227f600 c210ce18
0000006b c227f378 c0b97a88
[    3.543121] 1c60: c14706f4 eeb80c3c c2321350 c210ce18 c391ec10
c227f378 c2321328 eeb80c58
[    3.551330] 1c80: eeb80c58 c0b97c24 00000001 c210ce18 f0031ce4
c391ec10 c227f378 c0b9834c
[    3.559570] 1ca0: 00000000 f0031ce4 c29e5e80 c0b98298 c227f378
c0b954e4 c2bf7c94 c298c56c
[    3.567779] 1cc0: c2f0f3b8 1fd8a6ff 00000001 c391ec10 00000001
c29e5e80 c391ec54 c0b97ef4
[    3.575988] 1ce0: 00000000 c391ec10 00000001 1fd8a6ff eeb80ee4
c391ec10 c21fc1e0 c391ec10
[    3.584228] 1d00: c29e5e80 c0b966f8 c391ec10 00000000 c2bf7c10
c0b93c04 c21fbc44 eeb80c5c
[    3.592437] 1d20: eeb80c48 48401800 48401bff ff8eddca 00000200
00000000 00000000 00000000
[    3.600646] 1d40: 00000000 1fd8a6ff c391ec10 c391ec00 c2bf7c10
00000000 c2023828 eeb80ca0
[    3.608886] 1d60: c29e5e80 00000000 00000001 c109a164 eeb80c3c
c2023828 00000000 c2023968
[    3.617095] 1d80: c2023828 c109a4ec 00000000 1fd8a6ff c2bf7c10
00000000 eeb80ca0 c2c21c48
[    3.625305] 1da0: c2bf7c10 48400000 484007ff ff8eddbc 00000200
00000000 00000000 00000000
[    3.633544] 1dc0: 00000000 1fd8a6ff 60000013 eeb80c3c eeb3ff88
00000000 c2023828 c2bf7c10
[    3.641754] 1de0: 00000001 00000000 c2269e40 c109a9bc 00000001
00000000 c2bf7c10 eeb3ff88
[    3.649963] 1e00: c2023828 c227f600 00000000 c290f00d c29e5e80
c0893838 00000000 c2bf7c10
[    3.658203] 1e20: c210ce18 c0b9a570 00000000 c2bf7c10 c210ce18
c0b976ac c2bf7d10 00000001
[    3.666412] 1e40: c2bf7c10 c227f600 c210ce18 00000001 c1b72f68
c0b97a88 c14706f4 eeb3ff88
[    3.674621] 1e60: c2321350 c210ce18 c2bf7c10 c1b72f68 c290f00d
c29e5e80 c2269e40 c0b97c24
[    3.682861] 1e80: 00000001 c210ce18 f0031edc c2bf7c10 c1b72f68
c0b9834c 00000000 f0031edc
[    3.691070] 1ea0: c29e5e80 c0b98298 c1b72f68 c0b954e4 c21fc084
c298c56c c2f0f3b8 1fd8a6ff
[    3.699279] 1ec0: fffffff3 c2bf7c10 00000001 c29e5e80 c2bf7c54
c0b97ef4 00000000 c2bf7c10
[    3.707519] 1ee0: 00000001 1fd8a6ff 00000000 c2bf7c10 c21fc1e0
c2bf7c10 c227f600 c0b966f8
[    3.715728] 1f00: c2bf7c10 c21fbf2c c21fbf40 c0b96c1c c21fbf64
c2981a80 c280aa00 c290f000
[    3.723937] 1f20: 00000000 c0368284 00000200 c29e5e80 c280aa00
c280aa00 c280aa1c c2981a80
[    3.732177] 1f40: c280aa00 c2981a98 c280aa1c c2003d40 00000088
c29e5e80 c280aa00 c03687a0
[    3.740386] 1f60: c29e5e80 c2269329 c29b0054 c298df80 c29e5e80
c0368564 c2981a80 c29b0040
[    3.748596] 1f80: f0029eb4 00000000 00000000 c03709ec c298df80
c0370914 00000000 00000000
[    3.756835] 1fa0: 00000000 00000000 00000000 c0300168 00000000
00000000 00000000 00000000
[    3.765045] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    3.773254] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    3.781494]  clk_enable from sysc_enable_opt_clocks+0x4c/0xa0
[    3.787261]  sysc_enable_opt_clocks from sysc_probe+0xda0/0x1598
[    3.793304]  sysc_probe from platform_probe+0x64/0xc0
[    3.798400]  platform_probe from really_probe+0xe8/0x41c
[    3.803741]  really_probe from __driver_probe_device+0xa8/0x20c
[    3.809692]  __driver_probe_device from driver_probe_device+0x38/0xc8
[    3.816192]  driver_probe_device from __device_attach_driver+0xb4/0x130
[    3.822845]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
[    3.829162]  bus_for_each_drv from __device_attach+0xb0/0x210
[    3.834930]  __device_attach from bus_probe_device+0x8c/0x94
[    3.840637]  bus_probe_device from device_add+0x3ec/0x924
[    3.846069]  device_add from of_platform_device_create_pdata+0x98/0xc8
[    3.852630]  of_platform_device_create_pdata from
of_platform_bus_create+0x200/0x4d8
[    3.860412]  of_platform_bus_create from of_platform_populate+0x9c/0x138
[    3.867156]  of_platform_populate from simple_pm_bus_probe+0xac/0xd0
[    3.873565]  simple_pm_bus_probe from platform_probe+0x64/0xc0
[    3.879425]  platform_probe from really_probe+0xe8/0x41c
[    3.884765]  really_probe from __driver_probe_device+0xa8/0x20c
[    3.890747]  __driver_probe_device from driver_probe_device+0x38/0xc8
[    3.897216]  driver_probe_device from __device_attach_driver+0xb4/0x130
[    3.903869]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
[    3.910186]  bus_for_each_drv from __device_attach+0xb0/0x210
[    3.915954]  __device_attach from bus_probe_device+0x8c/0x94
[    3.921661]  bus_probe_device from device_add+0x3ec/0x924
[    3.927093]  device_add from of_platform_device_create_pdata+0x98/0xc8
[    3.933654]  of_platform_device_create_pdata from
of_platform_bus_create+0x200/0x4d8
[    3.941436]  of_platform_bus_create from of_platform_populate+0x9c/0x138
[    3.948181]  of_platform_populate from simple_pm_bus_probe+0xac/0xd0
[    3.954559]  simple_pm_bus_probe from platform_probe+0x64/0xc0
[    3.960449]  platform_probe from really_probe+0xe8/0x41c
[    3.965789]  really_probe from __driver_probe_device+0xa8/0x20c
[    3.971740]  __driver_probe_device from driver_probe_device+0x38/0xc8
[    3.978210]  driver_probe_device from __device_attach_driver+0xb4/0x130
[    3.984893]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
[    3.991180]  bus_for_each_drv from __device_attach+0xb0/0x210
[    3.996978]  __device_attach from bus_probe_device+0x8c/0x94
[    4.002655]  bus_probe_device from device_add+0x3ec/0x924
[    4.008087]  device_add from of_platform_device_create_pdata+0x98/0xc8
[    4.014648]  of_platform_device_create_pdata from
of_platform_bus_create+0x200/0x4d8
[    4.022460]  of_platform_bus_create from of_platform_populate+0x9c/0x138
[    4.029205]  of_platform_populate from simple_pm_bus_probe+0xac/0xd0
[    4.035583]  simple_pm_bus_probe from platform_probe+0x64/0xc0
[    4.041473]  platform_probe from really_probe+0xe8/0x41c
[    4.046813]  really_probe from __driver_probe_device+0xa8/0x20c
[    4.052764]  __driver_probe_device from driver_probe_device+0x38/0xc8
[    4.059234]  driver_probe_device from __device_attach_driver+0xb4/0x130
[    4.065887]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
[    4.072204]  bus_for_each_drv from __device_attach+0xb0/0x210
[    4.077972]  __device_attach from bus_probe_device+0x8c/0x94
[    4.083679]  bus_probe_device from deferred_probe_work_func+0x9c/0xdc
[    4.090148]  deferred_probe_work_func from process_one_work+0x1f8/0x4d8
[    4.096832]  process_one_work from worker_thread+0x23c/0x560
[    4.102508]  worker_thread from kthread+0xd8/0xf4
[    4.107238]  kthread from ret_from_fork+0x14/0x2c
[    4.111968] Exception stack(0xf0031fb0 to 0xf0031ff8)
[    4.117065] 1fa0:                                     00000000
00000000 00000000 00000000
[    4.125274] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.129486] omap_i2c 48070000.i2c: controller timed out
[    4.133483] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.145385] Code: e52de004 e28dd004 e2504000 0a000007 (e5944000)
[    4.151580] ---[ end trace 0000000000000000 ]---


Full test log link,
  - https://lkft.validation.linaro.org/scheduler/job/5508159

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 4ed9c1e971b1f6474793da20496fa53c35d4a37b
  git_describe: v6.0-rc4-331-g4ed9c1e971b1
  kernel_version: 6.0.0-rc4
  vmlinux.xz: https://builds.tuxbuild.com/2EdZsxzHqjwlxqJnMhU6OByEK2x/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2EdZsxzHqjwlxqJnMhU6OByEK2x/System.map
  kernel-config: https://builds.tuxbuild.com/2EdZsxzHqjwlxqJnMhU6OByEK2x/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/637024757
  artifact-location: https://builds.tuxbuild.com/2EdZsxzHqjwlxqJnMhU6OByEK2x
  toolchain: gcc-10


--
Linaro LKFT
https://lkft.linaro.org
