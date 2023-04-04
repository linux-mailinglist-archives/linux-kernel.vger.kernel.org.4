Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979D6D6D13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjDDTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjDDTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:24:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9872D79
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:24:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso22462929wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680636287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtT1DRdaOk5kBas+ebDWTznCPnLY7lN6Jk+3BHKXaSs=;
        b=LXfCdVj9mOY8zs36U2YhX1BZ63Hy2PS5F19qMk4WZFIKw0FboxSoQXJdPT5FhfdXD+
         Doo5ixHWEEYwdKgFAqAjum0sG8wsvzc4vAoEsL+e4BKRIZpFE+Jm6KcgXwDt/mOr2Uq6
         NnvjQ1/SjSWoIhlGltGgucTOOVCOZEqcUFf9wrFvcaSM/81rghlian59C1kJEqB53X/J
         I3BM6tTrleBXAPegvrFz1B4NSqXi52L7cKXf+nPuhn0N5jWjDdI9ouQQpb2ie2yrmvVx
         6soha5oHyI2Ea/nFyUFS0/ED0aZzfL7GmTVffep6FVj66HQq9VM79YIWD/fmUUGUm2Oz
         7mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtT1DRdaOk5kBas+ebDWTznCPnLY7lN6Jk+3BHKXaSs=;
        b=TfSJZ17UQk9uxM8QjH9OvM4UcIS9XHaGxsCg0ffvIAmeilrazKZPq8n+omKiV4uRZQ
         QInLecEbrBqjwQ36/NOQuwiWcRWTE46GSQ0IStHIq49skcfKYODSCsJKMDHqAghFCxkJ
         dnwqhbB8sdpr+PFyGmhCcn/5niMcvZhWDK0e1Ej9B4alUPASx5l8iDXw20DnXDtJaEOh
         xV+JacZ+aBWn904vi1A2S2WiKOoezKj0UDD996/b8gl3Vu9gTM1xxO1rvrX2zSob6Erx
         7vXYPO6HNzcAbo18hX8iGYwjnz78Tgdgp9srAgLJQaSOuaBfCs+QwU3dgBz4bmu/9WgN
         xPbw==
X-Gm-Message-State: AAQBX9fXpio9vyBWCink5KOIyJie06WYhQxd5GfIe1swXRsiw2O2soym
        RE+BF3Pcl7MhXTWGXUFswEI=
X-Google-Smtp-Source: AKy350aRJxNolUEAJDrrRT0r16+dE9KV7Klqc8H5M5iLmopaqv1ra54RZGNmfM1a6TtazPiwp3IUUw==
X-Received: by 2002:a05:600c:218d:b0:3ee:36f:3485 with SMTP id e13-20020a05600c218d00b003ee036f3485mr3195410wme.8.1680636286898;
        Tue, 04 Apr 2023 12:24:46 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c358c00b003ef6f87118dsm23827053wmq.42.2023.04.04.12.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:24:46 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:24:41 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: missing crypto power domain on rk3588 ?
Message-ID: <ZCx5eVJvXaE1dDvt@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My rk3588 crypto driver was working on vendor sources, but it fail to probe on upstream.
[    0.000000] Linux version 6.3.0-rc5-next-20230404-00102-gabc278021096-dirty (compile@Red) (aarch64-unknown-linux-gnu-gcc (Gentoo 11.3.1_p20230120-r1 p7) 11.3.1 20230120, GNU ld (Gentoo 2.37_p1 p2) 2.37) #335 SMP PREEMPT Tue Apr  4 18:57:05 CEST 2023
[    0.000000] Machine model: Radxa ROCK 5 Model B
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x00000003fc000000..0x00000003fc4fffff (5120 KiB) nomap non-reusable gap1@3,fc000000
[    0.000000] OF: reserved mem: 0x00000003fff00000..0x00000003ffffffff (1024 KiB) nomap non-reusable gap2@3,fff00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x00000003ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x3fdf30900-0x3fdf32fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000003ffffffff]ted using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.000654] pid_max: default: 32768 minimum: 301
[    0.000740] LSM: initializing lsm=capability
[    0.000874] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.000923] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.003399] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.003513] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    0.003772] rcu: Hierarchical SRCU implementation.
[    0.003779] rcu: 	Max phase no-delay instances is 1000.
[    0.005149] EFI services will not be available.
[    0.005642] smp: Bringing up secondary CPUs ...
[    0.006325] Detected VIPT I-cache on CPU1
[    0.006397] GICv3: CPU1: found redistributor 100 region 0:0x000000030000.g00
[    0.006434] CPU1io@fec30000
[    0.032224] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.032293] rockchip-gpio fec40000.gpio: probed /pinctrl/gpio@fec40000
[    0.032351] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.032419] rockchip-gpio fec50000.gpio: probed /pinctrl/gpio@fec50000
[    0.032761] KASLR disabled due to lack of seed
[    0.033169] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.033172] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.033174] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.033175] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.033177] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.033178] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.033180] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.033182] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.033959] ACPI: Interpreter disabled.
[    0.034168] iommu: Default domain type: Translated 
[    0.034170] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.034276] SCSI subsystem initialized
[    0.034528] pps_core: LinuxPPS API ver. 1 registered
[    0.034530] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.034542] t.com
ck support registered
c: GHES probing device list is empty
[    0.297154] sdhci: Secure Digital Host Controller Interface driver
[    0.298153] sdhci: Copyright(c) Pierre Ossman
[    0.298668] Synopsys Designware Multimedia Card Interface Driver
[    0.299348] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.300751] sdhci-dwcmshc fe2e0000.mmc: Disabling HS200/HS400, frequency too low (24000000)
[    0.301644] ledtrig-cpu: registered to indicate activity on CPUs
[    0.302304] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    0.303027] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.303630] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0
[    0.307827] SMCCC: SOC_ID: ARCH_FEATURES(ARCH_SOC_ID) returned error: fffffffffffffffd
[    0.308559] rk2_crypto_probe:512
[    0.308841] rk2_crypto_probe:523
[    0.309124] rk2_crypto_probe:530
[    0.309410] rk2_crypto_probe:537
[    0.309714] rk2_crypto_probe:547
[    0.310001] SError Interrupt on CPU6, code 0x00000000be000411 -- SError
[    0.310005] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-next-20230404-00102-gabc278021096-dirty #335
[    0.310009] Hardware name: Radxa ROCK 5 Model B (DT)
[    0.310011] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.310014] pc : devm_kvasprintf+0x40/0xd4
[    0.310023] lr : devm_kasprintf+0x58/0x80
[    0.310028] sp : ffff80000aa4b9d0
[    0.310029] x29: ffff80000aa4b9d0 x28: 0000000000000000 x27: ffff000102e21c80
[    0.310034] x26: ffff8000093400b0 x25: ffff8000092bf090 x24: ffff0001014a3010
[    0.310037] x23: ffff8000091d8e78 x22: 0000000000000cc0 x21: 0000000000002000
[    0.310041] x20: ffff0001014a3010 x19: ffff80000aa4ba70 x18: ffffffffffffffff
[    0.310044] x17: 666666666666203a x16: 726f727265206465 x15: ffff80008aa4b7a7
[    0.310047] x14: 0000000000000000 x13: ffff80000a757380 x12: 00000000000002e5
[    0.310050] x11: 00000000000000f7 x10: ffff80000a7af380 x9 : ffff80000aa4baf0
[    0.310053] x8 : ffff80000aa4baf0 x7 : ffff80000a7af380 x6 : ffff80000aa4baf0
[    0.310057] x5 : 00000000ffffffd8 x4 : ffff000100238478 x3 : ffff80000aa4ba10
[    0.310060] x2 : ffff8000091d8e78 x1 : 0000000000000cc0 x0 : 0b5cf7c14451b300
[    0.310064] Kernel panic - not syncing: Asynchronous SError Interrupt
Matched prompt #9: Kernel panic - not syncing
Setting prompt string to ['end Kernel panic[^\\r]*\\r', '/ #', '~ #', 'sh-5.1#', 'Login timed out', 'Login incorrect']
[    0.310066] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-next-20230404-00102-gabc278021096-dirty #335
[    0.310069] Hardware name: Radxa ROCK 5 Model B (DT)
[    0.310070] Call trace:
[    0.310071]  dump_backtrace+0x90/0xe8
[    0.310078]  show_stack+0x18/0x24
[    0.310082]  dump_stack_lvl+0x48/0x60
[    0.310088]  dump_stack+0x18/0x24
[    0.310091]  panic+0x35c/0x370
[    0.310097]  add_taint+0x0/0xbc
[    0.310100]  arm64_serror_panic+0x6c/0x78
[    0.310103]  do_serror+0x3c/0x78
[    0.310105]  el1h_64_error_handler+0x30/0x48
[    0.310111]  el1h_64_error+0x64/0x68
[    0.310113]  devm_kvasprintf+0x40/0xd4
[    0.310118]  devm_kasprintf+0x58/0x80
[    0.310122]  __devm_ioremap_resource+0x16c/0x268
[    0.310127]  devm_ioremap_resource+0x14/0x20
[    0.310131]  devm_platform_ioremap_resource+0x70/0x7c
[    0.310135]  rk2_crypto_probe+0x104/0x624
[    0.310139]  platform_probe+0x68/0xdc
[    0.310143]  really_probe+0x148/0x2ac
[    0.310147]  __driver_probe_device+0x78/0xe0
[    0.310150]  driver_probe_device+0x3c/0x15c
[    0.310153]  __driver_attach+0x94/0x19c
[    0.310155]  bus_for_each_dev+0x74/0xd4
[    0.310158]  driver_attach+0x24/0x30
[    0.310160]  bus_add_driver+0xe4/0x1e8
[    0.310163]  driver_register+0x60/0x128
[    0.310166]  __platform_driver_register+0x28/0x34
[    0.310170]  crypto_driver_init+0x1c/0x28
[    0.310174]  do_one_initcall+0x6c/0x1b0
[    0.310176]  kernel_init_freeable+0x1c0/0x2ac
[    0.310181]  kernel_init+0x24/0x1dc
[    0.310183]  ret_from_fork+0x10/0x20
[    0.310187] SMP: stopping secondary CPUs
[    0.310274] Kernel Offset: disabled
[    0.310275] CPU features: 0xc00000,00e00a0c,6400720b
[    0.310278] Memory Limit: none
96729] ghes_edac: GHES probing device list is empty
[    0.297154] sdhci: Secure Digital Host Controller Interface driver
[    0.298153] sdhci: Copyright(c) Pierre Ossman
[    0.298668] Synopsys Designware Multimedia Card Interface Driver
[    0.299348] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.300751] sdhci-dwcmshc fe2e0000.mmc: Disabling HS200/HS400, frequency too low (24000000)
[    0.301644] ledtrig-cpu: registered to indicate activity on CPUs
[    0.302304] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    0.303027] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.303630] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0
[    0.307827] SMCCC: SOC_ID: ARCH_FEATURES(ARCH_SOC_ID) returned error: fffffffffffffffd
[    0.308559] rk2_crypto_probe:512
[    0.308841] rk2_crypto_probe:523
[    0.309124] rk2_crypto_probe:530
[    0.309410] rk2_crypto_probe:537
[    0.309714] rk2_crypto_probe:547
[    0.310001] SError Interrupt on CPU6, code 0x00000000be000411 -- SError
[    0.310005] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-next-20230404-00102-gabc278021096-dirty #335
[    0.310009] Hardware name: Radxa ROCK 5 Model B (DT)
[    0.310011] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.310014] pc : devm_kvasprintf+0x40/0xd4
[    0.310023] lr : devm_kasprintf+0x58/0x80
[    0.310028] sp : ffff80000aa4b9d0
[    0.310029] x29: ffff80000aa4b9d0 x28: 0000000000000000 x27: ffff000102e21c80
[    0.310034] x26: ffff8000093400b0 x25: ffff8000092bf090 x24: ffff0001014a3010
[    0.310037] x23: ffff8000091d8e78 x22: 0000000000000cc0 x21: 0000000000002000
[    0.310041] x20: ffff0001014a3010 x19: ffff80000aa4ba70 x18: ffffffffffffffff
[    0.310044] x17: 666666666666203a x16: 726f727265206465 x15: ffff80008aa4b7a7
[    0.310047] x14: 0000000000000000 x13: ffff80000a757380 x12: 00000000000002e5
[    0.310050] x11: 00000000000000f7 x10: ffff80000a7af380 x9 : ffff80000aa4baf0
[    0.310053] x8 : ffff80000aa4baf0 x7 : ffff80000a7af380 x6 : ffff80000aa4baf0
[    0.310057] x5 : 00000000ffffffd8 x4 : ffff000100238478 x3 : ffff80000aa4ba10
[    0.310060] x2 : ffff8000091d8e78 x1 : 0000000000000cc0 x0 : 0b5cf7c14451b300
[    0.310064] Kernel panic - not syncing: Asynchronous SError Interrupt
[    0.310066] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-next-20230404-00102-gabc278021096-dirty #335
[    0.310069] Hardware name: Radxa ROCK 5 Model B (DT)
[    0.310070] Call trace:
[    0.310071]  dump_backtrace+0x90/0xe8
[    0.310078]  show_stack+0x18/0x24
[    0.310082]  dump_stack_lvl+0x48/0x60
[    0.310088]  dump_stack+0x18/0x24
[    0.310091]  panic+0x35c/0x370
[    0.310097]  add_taint+0x0/0xbc
[    0.310100]  arm64_serror_panic+0x6c/0x78
[    0.310103]  do_serror+0x3c/0x78
[    0.310105]  el1h_64_error_handler+0x30/0x48
[    0.310111]  el1h_64_error+0x64/0x68
[    0.310113]  devm_kvasprintf+0x40/0xd4
[    0.310118]  devm_kasprintf+0x58/0x80
[    0.310122]  __devm_ioremap_resource+0x16c/0x268
[    0.310127]  devm_ioremap_resource+0x14/0x20
[    0.310131]  devm_platform_ioremap_resource+0x70/0x7c
[    0.310135]  rk2_crypto_probe+0x104/0x624
[    0.310139]  platform_probe+0x68/0xdc
[    0.310143]  really_probe+0x148/0x2ac
[    0.310147]  __driver_probe_device+0x78/0xe0
[    0.310150]  driver_probe_device+0x3c/0x15c
[    0.310153]  __driver_attach+0x94/0x19c
[    0.310155]  bus_for_each_dev+0x74/0xd4
[    0.310158]  driver_attach+0x24/0x30
[    0.310160]  bus_add_driver+0xe4/0x1e8
[    0.310163]  driver_register+0x60/0x128
[    0.310166]  __platform_driver_register+0x28/0x34
[    0.310170]  crypto_driver_init+0x1c/0x28
[    0.310174]  do_one_initcall+0x6c/0x1b0
[    0.310176]  kernel_init_freeable+0x1c0/0x2ac
[    0.310181]  kernel_init+0x24/0x1dc
[    0.310183]  ret_from_fork+0x10/0x20
[    0.310187] SMP: stopping secondary CPUs
[    0.310274] Kernel Offset: disabled
[    0.310275] CPU features: 0xc00000,00e00a0c,6400720b
[    0.310278] Memory Limit: none

Asking for help on #linux-rockchip, I was guide to missing power domain, so I tried to add missing bits
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -1053,6 +1053,7 @@ static const struct rockchip_domain_info rk3588_pm_domains[] = {
        [RK3588_PD_SDIO]        = DOMAIN_RK3588("sdio",    0x4, BIT(10), 0,       BIT(24), 0x4, BIT(3),  BIT(19), false),
        [RK3588_PD_USB]         = DOMAIN_RK3588("usb",     0x4, BIT(11), 0,       BIT(25), 0x4, BIT(4),  BIT(20), true),
        [RK3588_PD_SDMMC]       = DOMAIN_RK3588("sdmmc",   0x4, BIT(13), 0,       BIT(26), 0x0, 0,       0,       false),
+       [RK3588_PD_CRYPTO]      = DOMAIN_RK3588("crypto",  0x4, BIT(14), 0,       BIT(27), 0x0, 0,       0,       false),
 };
 
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -816,6 +816,12 @@ power-domain@RK3588_PD_SDMMC {
                                pm_qos = <&qos_sdmmc>;
                                #power-domain-cells = <0>;
                        };
+                       power-domain@RK3588_PD_CRYPTO {
+                               reg = <RK3588_PD_CRYPTO>;
+                               pm_qos = <&qos_cryptos>,
+                                        <&qos_cryptons>;
+                               #power-domain-cells = <0>;
+                       };
                };
        };
 
@@ -854,6 +860,16 @@ qos_sdmmc: qos@fdf3d800 {
                reg = <0x0 0xfdf3d800 0x0 0x20>;
        };
 
+       qos_cryptos: qos@fdf3d000 {
+               compatible = "rockchip,rk3588-qos", "syscon";
+               reg = <0x0 0xfdf3d000 0x0 0x20>;
+       };
+
+       qos_cryptons: qos@fdf3d200 {
+               compatible = "rockchip,rk3588-qos", "syscon";
+               reg = <0x0 0xfdf3d200 0x0 0x20>;
+       };
+

And in the crypto node:
power-domains = <&power RK3588_PD_CRYPTO>;

But I still get the same problem.
Thanks for any help debugging this.
