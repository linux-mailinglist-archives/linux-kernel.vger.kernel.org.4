Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2985708F74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjESFda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESFd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:33:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804D10C3;
        Thu, 18 May 2023 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GIzr/Vy8qWKJTgUTCOlBwslqaT4pEVLjp+DCWUNQCDA=; b=jGyr3SZcWm3Tqm1x74JdirLTBR
        iCmc6jmM/6AuG9EBYtKowdVG8ReOrVs1gkuJfFXbUANlpXh2ceaZI78nHnAVDFn4b0ve22smFS9rG
        Ri6WrYiDvuhV2LdAofT8VJEepavUJOuiWFgonJijRZ/roJKmVplyHyLg88UkbIIe34tCGa2KSTKsv
        TL1eOaOfzBPBOayjnfF5izpRnLPDeh0sW+l8HIB+7Mn/3MtKWnNWFnr2eY5jzxmKJirbyWYUcWqoc
        O6ZquYLLKRj9tkcD7BMYy81ugQPzWQjG1ZShKhNdsqlUD+dHbgh5NAIkHoOAF1tZ5eXqv9se1HbCm
        k5YnzXXg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzsjp-00F9pK-0s;
        Fri, 19 May 2023 05:33:13 +0000
Message-ID: <a8c0f2b3-fcc3-ee94-16b5-ef37b4ec37a9@infradead.org>
Date:   Thu, 18 May 2023 22:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 -next] tty: serial: add panic serial helper
Content-Language: en-US
To:     Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
References: <20230518102903.1179581-1-xiehongyu1@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230518102903.1179581-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/18/23 03:29, Hongyu Xie wrote:
> It was inspired by kgdboc.
> 
> This is a debug module that allows you to get all kernel logs
> after panic.
> 
> Normally you need to attach a USB-to-UART tool or enable kdump
> before panic happens to get log from kernel after panic. If you
> didn't do that and kdump is not working, you can't get any log to
> know what happened before panic. If you have a USB-to-UART tool
> and the uart port on your computer is working. This module helps
> you to get all kernel log after panic() is called.
> 
> To use this, see Documentation/dev-tools/panic_serial_helper.rst.
> 
> Tested on arm64, x86 device.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
> 
> v2:
>  1. add a doc file
>  2. remove the password thing
> 
>  .../dev-tools/panic_serial_helper.rst         | 143 +++++

This file name (panic_serial_helper) also needs to be added to
Documentation/dev-tools/index.rst.

>  MAINTAINERS                                   |   5 +
>  drivers/tty/serial/Kconfig                    |  46 ++
>  drivers/tty/serial/Makefile                   |   1 +
>  drivers/tty/serial/panic_serial_helper.c      | 571 ++++++++++++++++++
>  include/linux/panic.h                         |   1 +
>  kernel/panic.c                                |  12 +
>  7 files changed, 779 insertions(+)
>  create mode 100644 Documentation/dev-tools/panic_serial_helper.rst
>  create mode 100644 drivers/tty/serial/panic_serial_helper.c
> 
> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
> new file mode 100644
> index 000000000000..adbc4026fbe4
> --- /dev/null
> +++ b/Documentation/dev-tools/panic_serial_helper.rst
> @@ -0,0 +1,143 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +

The "===...===" lines here must be at least as long as the heading.

> +=================================================
> +Using panic serial helper to get kernel logs after panic
> +=================================================

> +========================================================
> +Using panic serial helper to get kernel logs after panic
> +========================================================

> +
> +:Author: Hongyu Xie <xiehongyu1@kylinos.cn>
> +
> +What is this?
> +============

   =============

> +
> +A debug module inspired by kgdboc that allows you to get all kernel logs
> +after panic.
> +
> +When do you need it and why?
> +============

   =============================

> +
> +When
> +--------------
> +
> +Didn't enable debugging tool like Kdump and didn't connect a USB-to-UART
> +tool to the debug uart port on your PC before panic.
> +
> +Why
> +--------------
> +
> +There are many debugging methods to know what was going on before panic.
> +
> +Kdump, for example. If Kdump is enabled, you can get a core image after
> +panic. Then use GDB or Crash to debug that core image to know what happened
> +before panic(see ``Documentation/admin-guide/kdump/kdump.rst`` for more

   before panice (see

> +information about Kdump).
> +
> +Another way is to connect the UART side of a USB-to-UART tool to the

Please use "UART" consistently (not "uart").

> +debugging uart port(normally a 3 pin slot on the motherborad or a RS232

   debugging UART port (normally a 3-pin            motherboard or an RS232

> +port on the back panel of your PC) before panic happens. Then connect the

I wish I had a PC with a serial port so that I could test/use this.

> +USB side of a USB-to-UART tool to another PC. You can read all the kernel
> +logs coming from that uart port through apps like minicom on another PC.
> +So when panic happens you'll know what was going on.
> +
> +What if Kdump hasn't been enabled? And in production environment you don't
> +always connect a USB-to-UART tool before panic happens.
> +
> +So if Kdump is not enabled, you can use this module to get all the kernel
> +logs after panic.

if this module is loaded prior to the panic.

> +
> +How to use it?
> +============

   ===============
> +
> +Prerequisites
> +--------------
> +
> +1. Same as kgdboc, the UART driver must implement two callbacks in the
> +struct uart_ops. See ``Documentation/dev-tools/kgdb.rst`` section
> +``kgdboc and uarts``
> +
> +2. Your PC has an uart port and it's working.
> +
> +How
> +--------------
> +
> +First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
> +config. To enable ``CONFIG_PANIC_SERIAL_HELPER`` you should look under
> +:menuselection:
> +`Device Drivers
> +  --> Character devices
> +    --> Enable TTY (TTY [=y])
> +      --> Serial drivers`
> +and select
> +:menuselection:`debug through uart after panic`.
> +
> +Second, build and update the kernel image. Then wait for panic.
> +
> +After panic, you need to do the following,

                                   following:

> +1. connect the uart side of an USB-to-UART tool to any uart
> +  port on your device(PC, server, Laptop, etc...) after panic.

                  device (PC,                etc.).

You have already said "after panic".

> +  Connect the USB side of that tool to another PC. Open
> +  minicom(or other app) on that PC, and set "/dev/ttyUSB0"(or

     minicom (or                                     ttyUSB0" (or

> +  "/dev/ttyUSB1 if there is already another USB-to-UART tool
> +  connected to your device) with "115200 8N1".
> +
> +  It automatically selects the port where you first pressing the

                                                 first press the

> +  "Enter"(some keyboard labeled with "Return")

     "Enter" key (some keyboards label this with "Return").

> +
> +2. press "Enter"(some keyboard labeled with "Return") in that

            "Enter" (or "Return") in that

> +  minicom window, you'll get a help menu,

     minicom window; you'll get a help meu:

> +  "
> +  help:
> +      -a      show all kernel msg
> +      -3      show S3 msg
> +      -4      show S4 msg
> +      -filter-[string]        show msg contains [string]

                                          containing

> +      -q-     quit
> +  "
> +
> +see ``Help menu options`` for details.
> +
> +3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
> + "Enter" to get what you want.
> +
> +Help menu options
> +--------------
> +Available options:
> +
> + - a
> +
> +   Show all the messages starting from ``Booting Linux on ...``
> +
> + - 3
> +
> +   If STR happened before panic, this will show messages starting from

What "STR" is this?

> +   ``PM: suspend entry...``
> +
> + - 4
> +
> +   If STD happened before panic, this will show messages starting from

Is this "STD" or "STR"?

> +   ``PM: hibernation entry...``
> +
> + - filter-[string]
> +
> +   Only show messages that contain ``string``. For example, if you're only
> +   interesting in message lines that contain ``CPU``, you just input
> +   ``filter-CPU``.
> +   Here is an output example for fitering ``CPU``::

                                    filtering

It might be nice to provide case-ignored filter matching, e.g.,
find "CPU" or "cpu".

> +
> +   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
> +   <6>[    0.000000] Detected PIPT I-cache on CPU0
> +   <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
> +   ...
> +   <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
> +   <6>[    0.002411] smp: Bringing up secondary CPUs ...
> +   <6>[    0.039105] Detected PIPT I-cache on CPU1
> +   ...
> +   <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
> +   <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
> +   ...
> +   <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
> +   <2>[  225.297909] SMP: stopping secondary CPUs
> +   <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
> +
> + - q-
> +
> +   return to help menu.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bd0f510f744..951c6804b3cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11552,6 +11552,11 @@ F:	include/linux/kgdb.h
>  F:	kernel/debug/
>  F:	kernel/module/kdb.c
>  
> +PANIC SERIAL CONSOLE
> +M:	Hongyu Xie <xiehongyu1@kylinos.cn>
> +F:	drivers/tty/serial/panic_serial_helper.c
> +F:	drivers/tty/serial/panic_serial_helper.h
> +

This is the wrong place for "PANIC SERIAL CONSOLE".
The MAINTAINERS file should remain in alphabetical order.
Please move this to after
PANASONIC LAPTOP ACPI EXTRAS DRIVER
Thanks.

>  KHADAS MCU MFD DRIVER
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  L:	linux-amlogic@lists.infradead.org
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 398e5aac2e77..66cc7bddf561 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -198,6 +198,52 @@ config SERIAL_KGDB_NMI
>  
>  	  If unsure, say N.
>  

I have comments here and similar ones in the documentation file.
It would be quite OK to make the Kconfig help text shorter and refer
to the Documentation file for more detailed help.

> +config PANIC_SERIAL_HELPER
> +	tristate "debug through uart after panic"
> +	depends on PANIC_TIMEOUT=0
> +	select CONSOLE_POLL
> +	help
> +	  This is a debug module that allows you to get all kernel logs
> +	  after panic.
> +
> +	  Normally you need to attach a USB-to-UART tool or enable kdump
> +	  before panic happens to get log from kernel after panic. If you
> +	  didn't do that and kdump is not working, you can't get any log to
> +	  know what happened before panic. If you have a USB-to-UART tool
> +	  and the uart port on your computer is working. This module helps

	                                     is working, this module helps

> +	  you to get all kernel log after panic() is called.
> +
> +	  This module use serial port in poll mode, so it's more stable

	              uses

> +	  than other debugging methods.
> +
> +	  To use this, you need to do the following after panic,
> +	    1. connect the uart side of an USB-to-UART tool to any uart
> +	    port on your device(PC, server, Laptop, etc...) after panic.

	                 device (PC,                etc.).

> +	    Connect the USB side of that tool to another PC. Open
> +	    minicom(or other app) on that PC, and set "/dev/ttyUSB0"(or

	    minicom (or                                     ttyUSB0" (or

> +	    "/dev/ttyUSB1 if there is already another USB-to-UART tool
> +	    connected to your device) with "115200 8N1".
> +
> +	    It automatically selects the port where you first pressing the

	                                                first press the

> +	    "Enter"(some keyboard labeled with "Return")

	    "Enter" key (some keyboards label this as "Return").

> +
> +	    2.press "Enter"(some keyboard labeled with "Return") in that

	    2. press "Enter" (or "Return") in that

> +	    minicom window, you'll get a help menu,

	            window; you'll get a help menu:

> +	    "
> +	    help:
> +	        -a      show all kernel msg
> +	        -3      show S3 msg
> +	        -4      show S4 msg
> +	        -filter-[string]        show msg contains [string]

	                                         containing

> +	        -q-     quit
> +	    "
> +
> +	   3.Finally, type 'a', '3', '4', 'q' or "filter-xxx" then press

	   3. Finally,

> +	   "Enter" to get what you want.
> +
> +	  Say Y if you have an UART port that is working.  If unsure, say N

	                                                              say N.

> +	  Say M if you want add this as a module driver.

	  The moudul will be called panic_serial_helper.

> +
>  config SERIAL_MESON
>  	tristate "Meson serial port support"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/tty/serial/panic_serial_helper.c b/drivers/tty/serial/panic_serial_helper.c
> new file mode 100644
> index 000000000000..59863f777331
> --- /dev/null
> +++ b/drivers/tty/serial/panic_serial_helper.c
> @@ -0,0 +1,571 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * panic_serial_helper.c Debug through uart when panic.
> + *
> + * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
> + *
> + * Inspired by kgdboc.
> + *
> + */
> +
> +#define MODULE_NAME "panic_seial_helper"

                              serial

> +#define pr_fmt(fmt) MODULE_NAME ": " fmt
> +
> +#include <linux/kmsg_dump.h>
> +#include <linux/bsearch.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/tty_driver.h>
> +#include <linux/serial_core.h>
> +
> +#define S3_ENTRY "PM: suspend entry"
> +#define S3_EXIT "PM: suspend exit"
> +#define S4_ENTRY "PM: hibernation entry"
> +#define S4_EXIT "PM: hibernation exit"
> +
> +/* list to store msg lines */
> +static LIST_HEAD(psh_list);
> +
> +/* msg line prototype */
> +struct dmesg_lines {
> +	struct list_head entry;
> +	char *buf;
> +	int size;
> +};
> +
> +/* panic serial helper status*/
> +enum PSHS {
> +	PSHS_INIT,
> +	PSHS_WAIT_HELP_INPUT,
> +};
> +
> +/* panic serial helper msg type */
> +enum PSHM_TYPE {
> +	PSHM_TYPE_ALL,
> +	PSHM_TYPE_S3,
> +	PSHM_TYPE_S4,
> +	PSHM_TYPE_STRINGS,
> +	PSHM_TYPE_QUIT,
> +};
> +
> +/* whether uart is dumping msg */
> +static bool dumping_msg;
> +
> +/* to filter msg */
> +static char filter[256] = {0};
> +
> +struct psh_buf {
> +#define PSH_BUF_SIZE 256
> +	char buf[PSH_BUF_SIZE];
> +	int cur;
> +};
> +
> +static const char psh_tty_types[][32] = {
> +	{"ttyAMA"},
> +	{"ttyS"},
> +	{"ttyPS"},
> +	{"ttyLP"},
> +	{"ttyARC"},
> +	{"ttyAL"},
> +	{"ttyUL"},
> +};
> +
> +#define TTY_OPS "115200n8n"

Other places here say "115200 8N1". Is there a typo above?

> +
> +struct psh_serial_dev {
> +	struct list_head entry;
> +	struct tty_driver *drv;
> +	struct psh_buf buf;
> +	enum PSHS psh_status;
> +	enum PSHM_TYPE psh_msg_type;
> +	int line;
> +};
> +
> +struct psh_serial_dev *psh_dev;
> +
> +/* char handle prototype */

s/handle/handler/ IMO
and in other places also.

> +struct c_handle {
> +	char c;
> +	int (*handler)(struct psh_serial_dev *dev, void *d);
> +};
> +

[snip]

> +
> +static void psh_help(struct psh_serial_dev *dev)
> +{
> +	static const char help[] = "\nhelp:\n";
> +	static const char show_all[] = "\t-a\tshow all kernel msg\n";
> +	static const char show_s3[] = "\t-3\tshow S3 msg\n";
> +	static const char show_s4[] = "\t-4\tshow S4 msg\n";
> +	static const char _filter[] =
> +		"\t-filter-[string]\tshow msg contains [string]\n";

		                              containing

> +	static const char _quit[] = "\t-q-\tquit\n";
> +
> +	psh_put_strings(dev, help, strlen(help));
> +	psh_put_strings(dev, show_all, strlen(show_all));
> +	psh_put_strings(dev, show_s3, strlen(show_s3));
> +	psh_put_strings(dev, show_s4, strlen(show_s4));
> +	psh_put_strings(dev, _filter, strlen(_filter));
> +	psh_put_strings(dev, _quit, strlen(_quit));
> +}
> +

[snip]

> +
> +/* try all uart port under the same driver */
> +static int psh_try_all_uart_port(struct uart_driver *drv)
> +{
> +	struct psh_serial_dev *dev = NULL;
> +	struct uart_driver *driver = NULL;
> +	char drv_name[64] = {0};
> +	int count = 10000;
> +	int i = 0, nr = drv->nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		memset(drv_name, 0, sizeof(drv_name));
> +		snprintf(drv_name, sizeof(drv_name), "%s%d,%s",
> +			drv->driver_name,
> +			i, TTY_OPS);
> +
> +		driver = psh_find_uart_driver(drv_name);
> +		if (!driver)
> +			continue;
> +
> +		dev = create_psh_serial_dev(driver, i);
> +		if (!dev) {
> +			tty_driver_kref_put(driver->tty_driver);
> +			driver = NULL;
> +			continue;
> +		}
> +
> +		count = 10000;

Already init-ed to 10000 above...

> +		while (count-- > 0) {
> +			psh_wait_for_input(dev);
> +
> +			if (psh_dev)
> +				return 0;
> +		}
> +
> +		tty_driver_kref_put(driver->tty_driver);
> +		driver = NULL;
> +		kfree(dev);
> +		dev = NULL;
> +	}
> +
> +	return -1;
> +}


Thanks.
-- 
~Randy
