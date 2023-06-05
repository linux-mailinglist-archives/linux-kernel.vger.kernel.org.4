Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF955721E54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjFEGlE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 02:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFEGlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:41:02 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0CE54;
        Sun,  4 Jun 2023 23:40:39 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6af93a6166fso4338009a34.3;
        Sun, 04 Jun 2023 23:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685947196; x=1688539196;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgk/wo8630xp173Yx/ga5X9dVpaMMR3Xhkzs0PEQb1k=;
        b=RnvGMbQs9yVHIXd4dsbN8bFvhKa2FIi2RCue/hxb2Z2ua9mOyENqnSo+f27NcIBEdm
         mZIUA0es5pYQmY/kTX80ZtPmFY6lgu0U898Qp4Mm8kL/PCBqqPmxBjkqPbJFalGMQIsk
         KYCCqSBSBZ09wE7OEr8IoSAL3QDyoz+JEcRZs4ZE0XdMjtNLQ6q6GWP7qB11DCaAeRqS
         u7QPZp5x9XilBlVuNmLUzqNjuw/9w7GjOFmyi9oduKpa7TnS4snL5qKbdBgQS037bHBT
         qi59EZIOKBAVa44yKCxzWg3GdlV5I8h5Qqn1NZxg64+Y85Qw03IJO9meB30HMHX8phnq
         9sdw==
X-Gm-Message-State: AC+VfDx3yxtfAHmblDI2GoYnzsAzHN9RIjXrOCnfFjOmKF24gb9UVtYT
        H4aRNnenVRwtZoBM8hKWU/c=
X-Google-Smtp-Source: ACHHUZ4s23R/futR+Ducx9yXokwFZsIwRmmVKf8nibPhM9Yz0MHic7lfCgeLoXhjU1dz31gRN8i6rQ==
X-Received: by 2002:a9d:73d6:0:b0:6af:887d:a517 with SMTP id m22-20020a9d73d6000000b006af887da517mr10588570otk.15.1685947196094;
        Sun, 04 Jun 2023 23:39:56 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b0064fe06fe712sm4496529pfm.129.2023.06.04.23.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 23:39:55 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, corbet@lwn.net,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 -next] tty: serial: add panic serial helper
Date:   Mon,  5 Jun 2023 14:39:52 +0800
Message-Id: <806cc2f2-485a-d79e-4fec-f5124d5ccbae@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZH1e3tuuie3bGhPj@debian.me>
References: <20230605015957.730085-1-xiehongyu1@kylinos.cn> <ZH1e3tuuie3bGhPj@debian.me>
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

Hi,

在 2023/6/5 12:04, Bagas Sanjaya 写道:
> On Mon, Jun 05, 2023 at 09:59:57AM +0800, Hongyu Xie wrote:
>> Tested on an arm64 device.
> 
> Tested on what device?
An arm64 PC that has 3 pin slot on the motherborad and a RS232 port on 
its back panel. This module should works on any PC that has UART port 
and the UART driver has implemented two callbacks that I've mentioned in 
the Doc.
>
>> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
>> new file mode 100644
>> index 000000000000..fc5b6e9103bc
>> --- /dev/null
>> +++ b/Documentation/dev-tools/panic_serial_helper.rst
> 
> The file name convention is using hyphens (like
> panic-serial-helper.rst).
> 
> The wording below really confuses me, but I try my best reviewing here.
> 
>> @@ -0,0 +1,148 @@
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
>> +When do you need it and why?
>> +============================
>> +
>> +When
>> +--------------
>> +
>> +Didn't enable debugging tool like Kdump and didn't connect a USB-to-UART
>> +tool to the debug UART port on your PC before panic.
> 
> This section is unnecessary.
> 
>> +
>> +Why
>> +--------------
>> +
>> +There are many debugging methods to know what was going on before panic.
>> +
>> +Kdump, for example. If Kdump is enabled, you can get a core image after
> "The first is Kdump. When it is enabled, ... . Then you can use GDB ..."
>> +panic. Then use GDB or Crash to debug that core image to know what happened
>> +before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for more
>> +information about Kdump).
> "(see ``Documentation/admin-guide/kdump/kdump.rst for Kdump
> documentation)."
>> +
>> +Another way is to connect the UART side of a USB-to-UART tool to the
>> +debugging UART port (normally a 3 pin slot on the motherborad or a RS232
>> +port on the back panel of your PC) before panic happens. Then connect the
>> +USB side of a USB-to-UART tool to another PC. You can read all the kernel
>> +logs coming from that UART port through apps like minicom on another PC.
>> +So when panic happens you'll know what was going on.
>> +
>> +What if Kdump hasn't been enabled? And in production environment you don't
>> +always connect a USB-to-UART tool before panic happens.
> 
> "... And yet the panic happens in production where you don't have access
> to USB-to-UART device?"
People don't always connect an USB-to-UART device while he/she is using 
the PC. When panic occurs, it's too late to connect the USB-to-UART 
device. With this module, it's never too late.
> 
>> +
>> +So if Kdump is not enabled, you can use this module to get all the kernel
>> +logs if this module is loaded prior to the panic.
> 
> "For both situations, you can use panic_serial_helper module to get all neccessary kernel logs once it is loaded."
> 
>> +
>> +How to use it?
>> +==============
>> +
>> +Prerequisites
>> +--------------
>> +
>> +1. Same as kgdboc, the UART driver must implement two callbacks in the
>> +struct uart_ops. See ``Documentation/dev-tools/kgdb.rst`` section
>> +``kgdboc and uart_ops``
>> +
>> +2. Your PC has an UART port and it's working.
>> +
>> +How
>> +--------------
>> +
>> +First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
>> +config. To enable ``CONFIG_PANIC_SERIAL_HELPER`` you should look under
> "To enable it, go to ..."
>> +:menuselection:`Device Drivers-->Character devices-->Enable TTY (TTY [=y])-->Serial drivers`
>> +and select :menuselection:`debug through UART after panic`.
>> +
>> +Second, build and update the kernel image. Then wait for panic.
> "Then build and deploy the kernel as usual."
>> +
>> +After panic, you need to do the following,
> "When the panic occurs, you need to do the following:"
>> +1. connect the UART side of an USB-to-UART tool to any UART
>> +port on your device (PC, server, Laptop, etc...).
>> +Connect the USB side of that tool to another PC. Open
>> +minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
>> +"/dev/ttyUSB1 if there is already another USB-to-UART tool
>> +connected to your device) with "115200 8N1".
>> +
>> +It automatically selects the port where you first press the
>> +"Enter" key (some keyboard labeled this with "Return").
>> +
>> +2. press "Enter" (or "Return") in that
>> +minicom window; you'll get a help menu:
> "Press Enter and the help menu will appear."
>> +help:::
>> +
>> +    -a      show all kernel msg
>> +
>> +    -3      show S3 msg
>> +
>> +    -4      show S4 msg
>> +
>> +    -filter-[string]        show msg containing [string]
>> +
>> +    -q-     quit
>> +
>> +see ``Help menu options`` for details.
>> +
>> +3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
>> +"Enter" to get what you want.
> 
> Do I have to pass ``-a`` or ``a``? Or is it command-line program or TUI
> interface?
a
> 
> Anyway,
> 
> "3. Select one of above options and happy hacking!"
> 
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
>> +   Provide case-ignored filter matching. Only show messages that containing
>> +   ``string``. For example, if you're only interesting in message lines
>> +   that containing ``CPU`` or ``cpu``, you just input
>> +   ``filter-CPU`` or ``filter-cpu``.
>> +   Here is an output example for filtering ``CPU``::
> "For example, if you'd like to see message lines that contain ``CPU`` or
> ``cpu``, you can pass either ``filter-CPU`` or ``filter-cpu``. The
> corresponding output would be like::"
>> +
>> +   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
>> +   <6>[    0.000000] Detected PIPT I-cache on CPU0
>> +   <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
>> +
>> +   ...
>> +
>> +   <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
>> +   <6>[    0.002411] smp: Bringing up secondary CPUs ...
>> +   <6>[    0.039105] Detected PIPT I-cache on CPU1
>> +
>> +   ...
>> +
>> +   <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
>> +   <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
>> +
>> +   ...
>> +
>> +   <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
>> +   <2>[  225.297909] SMP: stopping secondary CPUs
>> +   <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
>> +
>> + - q
>> +
>> +  Return to help menu.
> 
> The doc syntax looks messy, so I have to fix it up:
> 
> ---- >8 ----
> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentation/dev-tools/panic_serial_helper.rst
> index fc5b6e9103bc2d..1ed841d03ab1c2 100644
> --- a/Documentation/dev-tools/panic_serial_helper.rst
> +++ b/Documentation/dev-tools/panic_serial_helper.rst
> @@ -28,7 +28,7 @@ There are many debugging methods to know what was going on before panic.
>   
>   Kdump, for example. If Kdump is enabled, you can get a core image after
>   panic. Then use GDB or Crash to debug that core image to know what happened
> -before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for more
> +before panic (see Documentation/admin-guide/kdump/kdump.rst for more
>   information about Kdump).
>   
>   Another way is to connect the UART side of a USB-to-UART tool to the
> @@ -51,8 +51,7 @@ Prerequisites
>   --------------
>   
>   1. Same as kgdboc, the UART driver must implement two callbacks in the
> -struct uart_ops. See ``Documentation/dev-tools/kgdb.rst`` section
> -``kgdboc and uart_ops``
> +   struct uart_ops. See Documentation/dev-tools/kgdb.rst for details.
>   
>   2. Your PC has an UART port and it's working.
>   
> @@ -66,20 +65,20 @@ and select :menuselection:`debug through UART after panic`.
>   
>   Second, build and update the kernel image. Then wait for panic.
>   
> -After panic, you need to do the following,
> +After panic, you need to do the following:
> +
>   1. connect the UART side of an USB-to-UART tool to any UART
> -port on your device (PC, server, Laptop, etc...).
> -Connect the USB side of that tool to another PC. Open
> -minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
> -"/dev/ttyUSB1 if there is already another USB-to-UART tool
> -connected to your device) with "115200 8N1".
> +   port on your device (PC, server, Laptop, etc...).
> +   Connect the USB side of that tool to another PC. Open
> +   minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
> +   "/dev/ttyUSB1 if there is already another USB-to-UART tool
> +   connected to your device) with "115200 8N1".
>   
> -It automatically selects the port where you first press the
> -"Enter" key (some keyboard labeled this with "Return").
> +   It automatically selects the port where you first press the
> +   "Enter" key (some keyboard labeled this with "Return").
>   
> -2. press "Enter" (or "Return") in that
> -minicom window; you'll get a help menu:
> -help:::
> +2. press "Enter" (or "Return") in that minicom window; you'll get a help menu
> +   like::
>   
>       -a      show all kernel msg
>   
> @@ -94,7 +93,7 @@ help:::
>   see ``Help menu options`` for details.
>   
>   3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
> -"Enter" to get what you want.
> +   "Enter" to get what you want.
>   
>   Help menu options
>   -----------------
> @@ -122,27 +121,27 @@ Available options:
>      ``filter-CPU`` or ``filter-cpu``.
>      Here is an output example for filtering ``CPU``::
>   
> -   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
> -   <6>[    0.000000] Detected PIPT I-cache on CPU0
> -   <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
> +     <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
> +     <6>[    0.000000] Detected PIPT I-cache on CPU0
> +     <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
>   
> -   ...
> +     ...
>   
> -   <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
> -   <6>[    0.002411] smp: Bringing up secondary CPUs ...
> -   <6>[    0.039105] Detected PIPT I-cache on CPU1
> +     <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
> +     <6>[    0.002411] smp: Bringing up secondary CPUs ...
> +     <6>[    0.039105] Detected PIPT I-cache on CPU1
>   
> -   ...
> +     ...
>   
> -   <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
> -   <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
> +     <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
> +     <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
>   
> -   ...
> +     ...
>   
> -   <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
> -   <2>[  225.297909] SMP: stopping secondary CPUs
> -   <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
> +     <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
> +     <2>[  225.297909] SMP: stopping secondary CPUs
> +     <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
>   
>    - q
>   
> -  Return to help menu.
> +   Return to help menu.
> 
> Then apply my wording improves on top of above diff.
> 
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 3e3fb377d90d..86a2c1884b04 100644
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
>> +	  Say Y if you have an UART port that is working. If unsure, say N.
>> +	  Say M if you want add this as a module driver.
> "Say Y if you have a working UART port and you want to gather kernel
> logs. To compile this as module (which will be called panic_serial_helper),
> say M. If unsure, say N."
> 
> Thanks.
> 

Thanks.
