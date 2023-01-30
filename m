Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520576807F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjA3I4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjA3I4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:56:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B01027D61
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:56:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z3so7191921pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvti0wscSxm2TsFta3vppQO1DWp6PaQtNXLMnh1nMxU=;
        b=wCbHQAQZNWcjdWWkzQJgDhsEDKuVN1zgoHCXrEukOEkgU2YOV3x1Jyu4fOP3xQZRcE
         pWMxI1BEvf5ZrYRdn0hw0gExa61JO2fyFO0drmRQaR7qIN95KVk2e2kDpADRDWBCWK8Z
         flTyfRJsWSz7K6x9ck5DPCum/IBz2cK3J6lEQ8apC5HAFrhDvJ17+MSzkql+AddL+UA1
         kqdcEZIQ7zbXJuZrB0KFUnP4CQB+LUNBzSwah9Nr+hccEf5jo62JU6VZ8J+aPmmL/QVm
         y/0vlDZZf0w07LPfbWXcUp2szu5gEJ3/FqRnFZnakmBSA1iS4iLb8+MR1bD7eM1NWMHY
         /NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cvti0wscSxm2TsFta3vppQO1DWp6PaQtNXLMnh1nMxU=;
        b=FLaWIjsBvZJh8lbk0ibUfqdfTgqP3vXC/8UfNEFnsF+qpOjRFmMy76d675ymEcF+BN
         f3JP1Alp+9tNA2GZ9DlFAs9j4aXzLUrdsmSRTrK0RzPQl4HDD+5mJiWm6FxEXpJuJ+bZ
         Og8piGfrxAciuPCKFch49sm54zP50UdVOvLkuY88PojB1pLyKbHM6z+HmsTBXAiO/QFR
         0qlaWeQvywYyk9yJfKSOu27z+p6m8xM/9QsZRKdMhDWhmo3HdSo6vqBivVKX5e0+ajom
         kRUinX7GkpC/VY1T/Ua6anLAcQ+NfMjLi3ixt7nPnUaTix+vZGsDRxXT3i85zxKem7Ij
         i0Ag==
X-Gm-Message-State: AO0yUKUcNKJR+qHFxcgUB9rGEOjNNwKEgZciGdG+7NiB1eaD/J5AgSiH
        83yvjyfCu7i2BDff0rxL0jqqUQ==
X-Google-Smtp-Source: AK7set8lcM5fQ2RoTmj81iwj1zSBfNdM0n7rVQIjXg+oYAZNRx9qpvdUg22R0xSmKyKtG9S0ga5Jmg==
X-Received: by 2002:a62:1c10:0:b0:57d:56f1:6ae7 with SMTP id c16-20020a621c10000000b0057d56f16ae7mr14872298pfc.33.1675068966188;
        Mon, 30 Jan 2023 00:56:06 -0800 (PST)
Received: from localhost.localdomain ([124.123.172.194])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b00593a01d93ecsm3320539pfu.208.2023.01.30.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:56:05 -0800 (PST)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     saravanak@google.com
Cc:     abel.vesa@linaro.org, alexander.stein@ew.tq-group.com,
        andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com,
        brgl@bgdev.pl, colin.foster@in-advantage.com,
        cristian.marussi@arm.com, devicetree@vger.kernel.org,
        dianders@chromium.org, djrscally@gmail.com,
        dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru,
        frowand.list@gmail.com, geert+renesas@glider.be,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, jpb@kernel.org,
        jstultz@google.com, kernel-team@android.com, kernel@pengutronix.de,
        lenb@kernel.org, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux@roeck-us.net, lkft@linaro.org, luca.weiss@fairphone.com,
        magnus.damm@gmail.com, martin.kepplinger@puri.sm, maz@kernel.org,
        miquel.raynal@bootlin.com, naresh.kamboju@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        sakari.ailus@linux.intel.com, shawnguo@kernel.org,
        sudeep.holla@arm.com, tglx@linutronix.de, tony@atomide.com
Subject: [PATCH v2 00/11] fw_devlink improvements
Date:   Mon, 30 Jan 2023 14:25:42 +0530
Message-Id: <20230130085542.38546-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230127001141.407071-1-saravanak@google.com>
References: <20230127001141.407071-1-saravanak@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build test pass on arm, arm64, i386, mips, parisc, powerpc, riscv, s390, sh,
sparc and x86_64.

Boot and LTP smoke pass on qemu-arm64, qemu-armv7, qemu-i386 and qemu-x86_64.
Boot failed on FVP.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Please refer following link for details of testing.
FVP boot log failed.
https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-devicetree_20230127001141_407071-1-saravanak_google_com/testrun/14389034/suite/boot/test/gcc-12-lkftconfig-64k_page_size/details/


[    2.613437] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[    2.613628] Mem abort info:
[    2.613756]   ESR = 0x0000000096000005
[    2.613904]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.614071]   SET = 0, FnV = 0
[    2.614215]   EA = 0, S1PTW = 0
[    2.614358]   FSC = 0x05: level 1 translation fault
[    2.614517] Data abort info:
[    2.614647]   ISV = 0, ISS = 0x00000005
[    2.614792]   CM = 0, WnR = 0
[    2.614934] [0000000000000010] user address but active_mm is swapper
[    2.615105] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[    2.615219] Modules linked in:
[    2.615310] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc5 #1
[    2.615445] Hardware name: FVP Base RevC (DT)
[    2.615533] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    2.615685] pc : gpiochip_setup_dev (include/linux/err.h:41 include/linux/fwnode.h:201 drivers/gpio/gpiolib.c:586) 
[    2.615816] lr : gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:871) 
[    2.615970] sp : ffff8000081af5e0
[    2.616051] x29: ffff8000081af5e0 x28: 0000000000000000 x27: ffff0008027cb5a0
[    2.616261] x26: 0000000000000000 x25: ffffd7c5d6745910 x24: ffff0008027f4800
[    2.616472] x23: 0000000000000000 x22: ffffd7c5d62b99a8 x21: 0000000000000202
[    2.616679] x20: 0000000000000000 x19: ffff0008027f4800 x18: ffffffffffffffff
[    2.616890] x17: ffffd7c5d6467928 x16: 0000000013e3690a x15: ffff8000081af3b0
[    2.617102] x14: ffff00080275cd8a x13: ffff00080275cd88 x12: 0000000000000001
[    2.617312] x11: 62726568746f6d3a x10: 0000000000000000 x9 : ffffd7c5d3b3ebe0
[    2.617522] x8 : ffff8000081af548 x7 : 0000000000000000 x6 : 0000000000000001
[    2.617727] x5 : 0000000000000000 x4 : ffff000800640000 x3 : ffffd7c5d62b99c8
[    2.617933] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    2.618138] Call trace:
[    2.618204] gpiochip_setup_dev (include/linux/err.h:41 include/linux/fwnode.h:201 drivers/gpio/gpiolib.c:586) 
[    2.618337] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:871) 
[    2.618493] devm_gpiochip_add_data_with_key (drivers/gpio/gpiolib-devres.c:478) 
[    2.618654] bgpio_pdev_probe (drivers/gpio/gpio-mmio.c:793) 
[    2.618785] platform_probe (drivers/base/platform.c:1401) 
[    2.618928] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639) 
[    2.619056] __driver_probe_device (drivers/base/dd.c:778) 
[    2.619193] driver_probe_device (drivers/base/dd.c:808) 
[    2.619329] __device_attach_driver (drivers/base/dd.c:937) 
[    2.619464] bus_for_each_drv (drivers/base/bus.c:427) 
[    2.619590] __device_attach (drivers/base/dd.c:1010) 
[    2.619722] device_initial_probe (drivers/base/dd.c:1058) 
[    2.619861] bus_probe_device (drivers/base/bus.c:489) 
[    2.619988] device_add (drivers/base/core.c:3637) 
[    2.620102] platform_device_add (drivers/base/platform.c:717) 
[    2.620251] mfd_add_device (drivers/mfd/mfd-core.c:297) 
[    2.620397] devm_mfd_add_devices (drivers/mfd/mfd-core.c:351 drivers/mfd/mfd-core.c:449) 
[    2.620548] vexpress_sysreg_probe (drivers/mfd/vexpress-sysreg.c:115) 
[    2.620672] platform_probe (drivers/base/platform.c:1401) 
[    2.620814] really_probe (drivers/base/dd.c:560 drivers/base/dd.c:639) 
[    2.620940] __driver_probe_device (drivers/base/dd.c:778) 
[    2.621080] driver_probe_device (drivers/base/dd.c:808) 
[    2.621216] __driver_attach (drivers/base/dd.c:1195) 
[    2.621344] bus_for_each_dev (drivers/base/bus.c:301) 
[    2.621467] driver_attach (drivers/base/dd.c:1212) 
[    2.621596] bus_add_driver (drivers/base/bus.c:618) 
[    2.621720] driver_register (drivers/base/driver.c:246) 
[    2.621859] __platform_driver_register (drivers/base/platform.c:868) 
[    2.622012] vexpress_sysreg_driver_init (drivers/mfd/vexpress-sysreg.c:134) 
[    2.622145] do_one_initcall (init/main.c:1306) 
[    2.622269] kernel_init_freeable (init/main.c:1378 init/main.c:1395 init/main.c:1414 init/main.c:1634) 
[    2.622394] kernel_init (init/main.c:1526) 
[    2.622531] ret_from_fork (arch/arm64/kernel/entry.S:864) 
[ 2.622692] Code: 910003fd a90153f3 aa0003f3 f9414c00 (f9400801)
All code
========
   0:*	fd                   	std    		<-- trapping instruction
   1:	03 00                	add    (%rax),%eax
   3:	91                   	xchg   %eax,%ecx
   4:	f3 53                	repz push %rbx
   6:	01 a9 f3 03 00 aa    	add    %ebp,-0x55fffc0d(%rcx)
   c:	00 4c 41 f9          	add    %cl,-0x7(%rcx,%rax,2)
  10:	01 08                	add    %ecx,(%rax)
  12:	40 f9                	rex stc 

Code starting with the faulting instruction
===========================================
   0:	01 08                	add    %ecx,(%rax)
   2:	40 f9                	rex stc 
[    2.622807] ---[ end trace 0000000000000000 ]---
[    2.623043] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    2.623157] SMP: stopping secondary CPUs
[    2.623303] Kernel Offset: 0x57c5cb400000 from 0xffff800008000000
[    2.623413] PHYS_OFFSET: 0x80000000
[    2.623492] CPU features: 0x00000,001439ff,cd3e772f
[    2.623591] Memory Limit: none
[    2.623679] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


ref:
 - https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-devicetree_20230127001141_407071-1-saravanak_google_com/?results_layout=table&failures_only=false#!?details=#test-results



--
Linaro LKFT
https://lkft.linaro.org

