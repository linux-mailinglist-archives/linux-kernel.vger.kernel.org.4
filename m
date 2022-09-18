Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29A5BBC03
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 07:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIRFXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRFXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 01:23:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FEE26AD6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 22:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/Qrqp7Eji+AkjYIHNgU8Zze5zEOlGLr1ZnBDGkv0viU=; b=Gs8ANkN6kMow2W4+jktI5Xcsh3
        irOskPOmPJBDjpCJTQlA2PqeZeIXksNCXdVoHRVCHutAjvCWv18DzYb1zwbLCBc9Kb/JojNbUEFgK
        kXC8z3PKK2jdTVtkX4UBN+hyOLL+XPPwJJDE+TKbT+T+D1pKPj7twOXuxjREtepCEErm9jC86ivBj
        DhdJ0GnpNmqviT58FoS6/6DIRC+kmpDBWxShbwCWWZ0ktI5lYiv13MCNE8t2PoPGzjx3mlC37wLka
        Y+UBHlZv9Ch/c8EDqXKkwqw8lb64Vcfj4Y3jIIg0aBvth8X8V2Za9ZLmOAk8wUtYG05aG5FLIid3/
        7lmG/3Nw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZmla-00CYlE-Fr; Sun, 18 Sep 2022 05:22:54 +0000
Message-ID: <ea5feb59-59b2-a0ad-e878-9b431d810291@infradead.org>
Date:   Sat, 17 Sep 2022 22:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: sunplus-uart.c:undefined reference to `uart_suspend_port'
To:     kernel test robot <lkp@intel.com>, Qin Jian <qinjian@cqplus1.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <202209180926.OaCX9uMr-lkp@intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202209180926.OaCX9uMr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Qin Jian,

Fix is here:
https://lore.kernel.org/lkml/20220901000821.15376-1-rdunlap@infradead.org/


On 9/17/22 18:38, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
> commit: 0aa94eea8d955c82014e5368a843da93f1dc58f8 ARM: sunplus: Add initial support for Sunplus SP7021 SoC
> date:   2 months ago
> config: arm-buildonly-randconfig-r002-20220918
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa94eea8d955c82014e5368a843da93f1dc58f8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 0aa94eea8d955c82014e5368a843da93f1dc58f8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_suspend':
>>> sunplus-uart.c:(.text+0x2a4): undefined reference to `uart_suspend_port'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_resume':
>>> sunplus-uart.c:(.text+0x2f8): undefined reference to `uart_resume_port'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_remove':
>>> sunplus-uart.c:(.text+0x34c): undefined reference to `uart_remove_one_port'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_set_termios':
>>> sunplus-uart.c:(.text+0x83c): undefined reference to `uart_get_baud_rate'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x948): undefined reference to `uart_update_timeout'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `receive_chars':
>>> sunplus-uart.c:(.text+0xfa8): undefined reference to `uart_insert_char'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x1030): undefined reference to `tty_flip_buffer_push'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x1174): undefined reference to `uart_try_toggle_sysrq'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x132c): undefined reference to `do_SAK'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_console_write':
>>> sunplus-uart.c:(.text+0x1518): undefined reference to `uart_console_write'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x1604): undefined reference to `uart_console_write'
>    arm-linux-gnueabi-ld: sunplus-uart.c:(.text+0x172c): undefined reference to `uart_console_write'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_probe':
>>> sunplus-uart.c:(.text+0x2290): undefined reference to `uart_add_one_port'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_irq':
>>> sunplus-uart.c:(.text+0x28ec): undefined reference to `uart_write_wakeup'
>>> arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o:(.data+0x118): undefined reference to `uart_console_device'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_init':
>>> sunplus-uart.c:(.init.text+0x24): undefined reference to `uart_register_driver'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.init.text+0x6c): undefined reference to `uart_unregister_driver'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_console_setup':
>>> sunplus-uart.c:(.init.text+0x25c): undefined reference to `uart_parse_options'
>>> arm-linux-gnueabi-ld: sunplus-uart.c:(.init.text+0x28c): undefined reference to `uart_set_options'
>    arm-linux-gnueabi-ld: drivers/tty/serial/sunplus-uart.o: in function `sunplus_uart_exit':
>>> sunplus-uart.c:(.exit.text+0x1c): undefined reference to `uart_unregister_driver'
> 
> Kconfig warnings: (for reference only)

Root cause!

>    WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
>    Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=y])
>    Selected by [y]:
>    - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]
>    WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS
>    Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && (ARCH_SUNPLUS [=y] || COMPILE_TEST [=y])
>    Selected by [y]:
>    - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
>    WARNING: unmet direct dependencies detected for SERIAL_SUNPLUS_CONSOLE
>    Depends on [n]: TTY [=n] && HAS_IOMEM [=y] && SERIAL_SUNPLUS [=y]
>    Selected by [y]:
>    - SOC_SP7021 [=y] && ARCH_SUNPLUS [=y]
> 

-- 
~Randy
