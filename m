Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90273254D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjFPCbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjFPCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:31:23 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D326B8;
        Thu, 15 Jun 2023 19:31:20 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b2a4cb5776so237774a34.0;
        Thu, 15 Jun 2023 19:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882680; x=1689474680;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpsq4bwehtOkuTWQGOFc+nOFdLmRRIsUd3/WKvmiaqg=;
        b=XN0hohCZeqVm4tz95m0dVsNrOXYr7ZXGiS1rvTqXX/h5/FgQIWw3SVKxiSr9+orwo9
         5o8rWes4K9OW9J6AR0ZipIMGlQKKq6e1i/ETu6x4KpQNA2v0AsO8w23UK+q8G5k6itsB
         PZHx9M6lpqNvaE2s7+aps+JXLAAIiTtIFHYhwFq2yaclREKP1seNK8TbarOTs6iv+zK+
         6Ml2V8LiGGoOJ5hSvLcXhufcXGePVJp66FqqWEiVA5wSXq7/kQM6f3Kikpn1QvxOjoVM
         CngWpIm/7sVByB36DclfQVY49BCVEpb6PdJZtI+4PPlO0+MX38XUeOfxzYabG7z9QKOF
         K6GQ==
X-Gm-Message-State: AC+VfDwuPGWoHu1dYvRwwFo2Hy0satOb7EoIFSzhPlL22bqGZLG+TFnf
        HzN0Icx1sh6sGEfbAuBtiB0OyNn4yb2gpjefw7Ksww==
X-Google-Smtp-Source: ACHHUZ7DaCZUOyyuiHifPwy9rqrAzMBh0jUHJqCHK6jLrDWZtA8AY6bI6VXfs0NHZV9Rlc+59IfXRg==
X-Received: by 2002:a05:6359:60f:b0:121:7740:94e9 with SMTP id eh15-20020a056359060f00b00121774094e9mr548797rwb.5.1686882679954;
        Thu, 15 Jun 2023 19:31:19 -0700 (PDT)
Received: from localhost ([2408:8453:618:7ae:a9b9:1bdc:9a23:2334])
        by smtp.gmail.com with ESMTPSA id z24-20020a63c058000000b0051ba9d772f9sm13479528pgi.59.2023.06.15.19.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 19:31:19 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, corbet@lwn.net
Cc:     rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com, bagasdotme@gmail.com,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [RESEND PATCH v4 -next] tty: serial: add panic serial helper
Date:   Fri, 16 Jun 2023 10:31:15 +0800
Message-Id: <fbfbbad5-2418-5c1a-87f1-dc2ca20204aa@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023061502-submerge-preachy-4413@gregkh>
References: <20230614025512.27746-1-xiehongyu1@kylinos.cn> <2023061502-submerge-preachy-4413@gregkh>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Thunderbird/102.11.0
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0; attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc:    imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/6/15 18:17, Greg KH 写道:
> On Wed, Jun 14, 2023 at 10:55:12AM +0800, Hongyu Xie wrote:
>> It was inspired by kgdboc.
>>
>> This is a debug module that allows you to get all kernel logs
>> after panic.
>>
>> Normally you need to attach a USB-to-UART tool or enable kdump
>> before panic happens to get log from kernel after panic. If you
>> didn't do that and kdump is not working, you can't get any log to
>> know what happened before panic. If you have a USB-to-UART tool
>> and the UART port on your computer is working. This module helps
>> you to get all kernel log after panic() is called.
>>
>> To use this, see Documentation/dev-tools/panic_serial_helper.rst.
>>
>> Tested on an arm64 device.
>>
>> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
>> ---
> 
> Why  is this a RESEND?  What's wrong with the previous version?
Nobody review v4 for over a week.
> 
> 
>>
>> v4: fix some syntax problems in Documentation.
>>
>> v3: fix problems in Documentation reported by
>> kernel test robot <lkp@intel.com>.
>>
>> v2: replace uart with UART for consistency.
>>
>>   Documentation/dev-tools/index.rst             |   1 +
>>   .../dev-tools/panic_serial_helper.rst         | 138 ++++
>>   MAINTAINERS                                   |   5 +
>>   drivers/tty/serial/Kconfig                    |  25 +
>>   drivers/tty/serial/Makefile                   |   1 +
>>   drivers/tty/serial/panic_serial_helper.c      | 619 ++++++++++++++++++
>>   include/linux/panic.h                         |   1 +
>>   kernel/panic.c                                |  12 +
>>   8 files changed, 802 insertions(+)
>>   create mode 100644 Documentation/dev-tools/panic_serial_helper.rst
>>   create mode 100644 drivers/tty/serial/panic_serial_helper.c
>>
>> diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
>> index 6b0663075dc0..0655528e5a83 100644
>> --- a/Documentation/dev-tools/index.rst
>> +++ b/Documentation/dev-tools/index.rst
>> @@ -34,6 +34,7 @@ Documentation/dev-tools/testing-overview.rst
>>      kselftest
>>      kunit/index
>>      ktap
>> +   panic_serial_helper
>>   
>>   
>>   .. only::  subproject and html
>> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
>> new file mode 100644
>> index 000000000000..d3c177f56bc4
>> --- /dev/null
>> +++ b/Documentation/dev-tools/panic_serial_helper.rst
>> @@ -0,0 +1,138 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +========================================================
>> +Using panic serial helper to get kernel logs after panic
>> +========================================================
>> +
>> +:Author: Hongyu Xie <xiehongyu1@kylinos.cn>
>> +
>> +What is this?
>> +=============
>> +
>> +A debug module inspired by kgdboc that allows you to get all kernel logs
>> +after panic.
>> +
>> +Why do you need it?
>> +===================
>> +
>> +There are many debugging methods to know what was going on before panic.
>> +
>> +The firs is Kdump. When it is enabled, you can get a core image after
>> +panic. Then use GDB or Crash to debug that core image to know what happened
>> +before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for Kdump
>> +documentation).
>> +
>> +Another way is to connect the UART side of a USB-to-UART tool to the
>> +debugging UART port (normally a 3 pin slot on the motherborad or a RS232
>> +port on the back panel of your PC) before panic happens. Then connect the
>> +USB side of a USB-to-UART tool to another PC. You can read all the kernel
>> +logs coming from that UART port through apps like minicom on another PC.
>> +So when panic happens you'll know what was going on.
>> +
>> +What if Kdump hasn't been enabled? And people don't always connect an
>> +USB-to-UART device while he/she is using the PC. When panic occurs, it's
>> +too late to connect the USB-to-UART device.
>> +
>> +For both situations, you can use panic_serial_helper module to get all
>> +necessary kernel logs once it is loaded.
>> +
>> +How to use it?
>> +==============
>> +
>> +Prerequisites
>> +--------------
>> +
>> +1. Same as kgdboc, the UART driver must implement two callbacks in the
>> +   struct uart_ops. See Documentation/dev-tools/kgdb.rst for details.
>> +
>> +2. Your PC has an UART port and it's working.
>> +
>> +How
>> +--------------
>> +
>> +First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
>> +config. To enable it go to
>> +:menuselection:`Device Drivers-->Character devices-->Enable TTY (TTY [=y])-->Serial drivers`
>> +and select :menuselection:`debug through UART after panic`.
>> +
>> +Then build and deploy the kernel as usual.
>> +
>> +When the panic occurs, you need to do the following:
>> +
>> +1. connect the UART side of an USB-to-UART tool to any UART
>> +   port on your device (PC, server, Laptop, etc...).
>> +   Connect the USB side of that tool to another PC. Open
>> +   minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
>> +   "/dev/ttyUSB1 if there is already another USB-to-UART tool
>> +   connected to your device) with "115200 8N1".
>> +
>> +   It automatically selects the port where you first press the
>> +   "Enter" key (some keyboard labeled this with "Return").
>> +
>> +2. Press Enter and the help menu will appear::
>> +
>> +    help:
>> +
>> +        -a      show all kernel msg
>> +
>> +        -3      show S3 msg
>> +
>> +        -4      show S4 msg
>> +
>> +        -filter-[string]        show msg containing [string]
>> +
>> +        -q-     quit
>> +
>> +see ``Help menu options`` for details.
>> +
>> +3. Select one of above options and happy hacking!
>> +
>> +Help menu options
>> +-----------------
>> +Available options:
>> +
>> + - a
>> +
>> +   Show all the messages starting from ``Booting Linux on ...``
>> +
>> + - 3
>> +
>> +   If STR happened before panic, this will show messages starting from
>> +   ``PM: suspend entry...``
>> +
>> + - 4
>> +
>> +   If STD happened before panic, this will show messages starting from
>> +   ``PM: hibernation entry...``
>> +
>> + - filter-[string]
>> +
>> +   Provide case-ignored filter matching. For example, if you'd like to see
>> +   message lines that contain ``CPU`` or ``cpu``, you can pass either
>> +   ``filter-CPU`` or ``filter-cpu``. The corresponding output would be
>> +   like::
>> +
>> +     <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
>> +     <6>[    0.000000] Detected PIPT I-cache on CPU0
>> +     <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
>> +
>> +     ...
>> +
>> +     <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
>> +     <6>[    0.002411] smp: Bringing up secondary CPUs ...
>> +     <6>[    0.039105] Detected PIPT I-cache on CPU1
>> +
>> +     ...
>> +
>> +     <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
>> +     <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
>> +
>> +     ...
>> +
>> +     <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
>> +     <2>[  225.297909] SMP: stopping secondary CPUs
>> +     <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
>> +
>> + - q
>> +
>> +   Return to help menu.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 74aeae10a151..73fcae8c2f39 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15972,6 +15972,11 @@ L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/platform/x86/panasonic-laptop.c
>>   
>> +PANIC SERIAL CONSOLE
>> +M:	Hongyu Xie <xiehongyu1@kylinos.cn>
>> +F:	drivers/tty/serial/panic_serial_helper.c
>> +F:	drivers/tty/serial/panic_serial_helper.h
>> +
>>   PARALLAX PING IIO SENSOR DRIVER
>>   M:	Andreas Klinger <ak@it-klinger.de>
>>   L:	linux-iio@vger.kernel.org
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 3e3fb377d90d..796441b58498 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -198,6 +198,31 @@ config SERIAL_KGDB_NMI
>>   
>>   	  If unsure, say N.
>>   
>> +config PANIC_SERIAL_HELPER
>> +	tristate "debug through UART after panic"
>> +	depends on PANIC_TIMEOUT=0
>> +	select CONSOLE_POLL
>> +	help
>> +	  This is a debug module that allows you to get all kernel logs
>> +	  after panic.
>> +
>> +	  Normally you need to attach a USB-to-UART tool or enable kdump
>> +	  before panic happens to get log from kernel after panic. If you
>> +	  didn't do that and kdump is not working, you can't get any log to
>> +	  know what happened before panic. If you have a USB-to-UART tool
>> +	  and the UART port on your computer is working, this module helps
>> +	  you to get all kernel log after panic() is called.
>> +
>> +	  This module uses serial port in poll mode, so it's more stable
>> +	  than other debugging methods.
>> +
>> +	  Read <file:Documentation/dev-tools/panic_serial_helper.rst> for
>> +	  usage.
>> +
>> +	  Say Y if you have a working UART port and you want to gather
>> +	  kernel logs. To compile this as module (which will be called
>> +	  panic_serial_helper), say M. If unsure, say N.
>> +
>>   config SERIAL_MESON
>>   	tristate "Meson serial port support"
>>   	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index 531ec3a19dae..d7f6fdc8913c 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
>>   
>>   obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
>>   obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
>> +obj-$(CONFIG_PANIC_SERIAL_HELPER) += panic_serial_helper.o
>> diff --git a/drivers/tty/serial/panic_serial_helper.c b/drivers/tty/serial/panic_serial_helper.c
>> new file mode 100644
>> index 000000000000..1d3d57bc6340
>> --- /dev/null
>> +++ b/drivers/tty/serial/panic_serial_helper.c
>> @@ -0,0 +1,619 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * panic_serial_helper.c Debug through UART when panic.
>> + *
>> + * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
>> + *
>> + * Inspired by kgdboc.
>> + *
>> + */
>> +
>> +#define MODULE_NAME "panic_serial_helper"
>> +#define pr_fmt(fmt) MODULE_NAME ": " fmt
> 
> KBUILD_NAME is all you need, right?
What is wrong with MODULE_NAME? Over 80 module file use MODULE_NAME.
> 
>> +
>> +#include <linux/kmsg_dump.h>
>> +#include <linux/bsearch.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/tty_driver.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/string.h>
>> +
>> +#define S3_ENTRY "PM: suspend entry"
>> +#define S3_EXIT "PM: suspend exit"
>> +#define S4_ENTRY "PM: hibernation entry"
>> +#define S4_EXIT "PM: hibernation exit"
> 
> Why are these needed?  Why not just use strings where they are used as
> you are only using these once.
It's shorter in a line.
> 
>> +
>> +/* list to store msg lines */
>> +static LIST_HEAD(psh_list);
> 
> That's going to get HUGE, right?  How much memory does this module take
> up?
Let's say n is the number of msg lines from while(kmsg_dump_get_line).
Memory consumption: n * sizeof(struct dmesg_lines) + total sum of the 
size of each kmsg_dump_get_line call.
> 
>> +
>> +/* msg line prototype */
>> +struct dmesg_lines {
>> +	struct list_head entry;
>> +	char *buf;
>> +	int size;
> 
> size of what?
bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog, char 
*line, size_t size, size_t *len).
size = *len here.
> 
>> +};
>> +
>> +/* panic serial helper status*/
> 
> Odd formatting :(
> 
>> +enum PSHS {
>> +	PSHS_INIT,
>> +	PSHS_WAIT_HELP_INPUT,
>> +};
> 
> What do these mean?
Indicates the status of this module.
> 
>> +
>> +/* panic serial helper msg type */
>> +enum PSHM_TYPE {
>> +	PSHM_TYPE_ALL,
>> +	PSHM_TYPE_S3,
>> +	PSHM_TYPE_S4,
>> +	PSHM_TYPE_STRINGS,
>> +	PSHM_TYPE_QUIT,
> 
> Why do you have message types?
To choose the msg type you need.
> 
> But most importantly, why all of this at all?  Why not just tie into the
> pstore infrastructure?  Wouldn't that handle the majority of this for
> you?
pstore infrastructure needs a backend, ram, efi, mtd, etc. Which needs a 
_panic_write implementation. Some of the implementation works in a 
interrupt context. What if panic happens in a none interrupt context? 
And what if _panic_write fails? This module use UART in poll mode and 
it's reliable.
> 
>> +};
>> +
>> +/* whether UART is dumping msg */
>> +static bool dumping_msg;
>> +
>> +/* to filter msg */
>> +static char filter[256] = {0};
>> +
>> +struct psh_buf {
>> +#define PSH_BUF_SIZE 256
>> +	char buf[PSH_BUF_SIZE];
>> +	int cur;
>> +};
>> +
>> +static const char psh_tty_types[][32] = {
>> +	{"ttyAMA"},
>> +	{"ttyS"},
>> +	{"ttyPS"},
>> +	{"ttyLP"},
>> +	{"ttyARC"},
>> +	{"ttyAL"},
>> +	{"ttyUL"},
> 
> Sorry, but hard-coded tty port names are not going to go well.  Why did
> you pick this tiny subset of valid tty names?
tty_find_polling_driver use the name to find a tty driver. What's wrong 
with it? kgdboc does the same thing.
> 
> 
>> +};
>> +
>> +#define TTY_OPS "115200n8n"
> 
> Why this default?
For convenience. So you don't have to try every baud rate when it happens.
> 
> 
>> +
>> +struct psh_serial_dev {
>> +	struct list_head entry;
>> +	struct tty_driver *drv;
>> +	struct psh_buf buf;
>> +	enum PSHS psh_status;
>> +	enum PSHM_TYPE psh_msg_type;
>> +	int line;
>> +};
>> +
>> +struct psh_serial_dev *psh_dev;
>> +
>> +/* char handler prototype */
>> +struct c_handler {
>> +	char c;
>> +	int (*handler)(struct psh_serial_dev *dev, void *d);
> 
> Why do you need a handler when you only have one handler?
There are two, one for '\b', one for '\r'. And maybe more in the future.
> 
> Anyway, please look at pstore and tie into that if you really want
> something like this.
Like I said above.
> 
> thanks,
> 
> greg k-h
thanks,

Hongyu xie

